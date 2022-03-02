import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_manager/models.dart';
import 'package:file_manager/notifications.dart';
import 'package:file_manager/util.dart' as util;
import 'package:file_manager/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final key = GlobalKey();
  final changeKey = GlobalKey();

  late ValueNotifier<Directory?> directoryNotifier;
  late ValueNotifier<List<Drive>> drivesNotifier;
  late ValueNotifier<List<FileSystemEntity>> entitiesNotifier;
  late ValueNotifier<File?> fileNotifier;
  late StreamSubscription<DriveState> driveSubscription;

  late ValueNotifier<ui.Image?> screenshotNotifier;
  late ui.Offset offset;

  StreamSubscription<FileSystemEvent>? directorySubscription;

  @override
  void initState() {
    super.initState();

    directoryNotifier = ValueNotifier(null);
    drivesNotifier = ValueNotifier([]);
    entitiesNotifier = ValueNotifier([]);
    fileNotifier = ValueNotifier(null);

    screenshotNotifier = ValueNotifier(null);

    openDrives(context);

    driveSubscription = util.driveStateChanged.listen((state) {
      try {
        final drivers = util.getDrives();
        final directory = directoryNotifier.value;
        if (state == DriveState.removed &&
            directory != null &&
            drivers.every((drive) => !directory.path.startsWith(drive.name))) {
          directoryNotifier.value = null;
        }
        drivesNotifier.value = drivers;
      } catch (e) {
        log('Get drives failed: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          key: key,
          child: Scaffold(
            body: buildBoby(context),
          ),
        ),
        ValueListenableBuilder<ui.Image?>(
          valueListenable: screenshotNotifier,
          builder: (context, screenshot, child) {
            if (screenshot == null) {
              return Container();
            } else {
              return ClipImage(
                image: screenshot,
                offset: offset,
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildBoby(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          buildToolbar(context),
          const SizedBox(height: 12.0),
          Expanded(
            child: ValueListenableBuilder<Directory?>(
              valueListenable: directoryNotifier,
              builder: (context, directory, child) {
                if (directory == null) {
                  return buildDrives(context);
                } else {
                  return buildEntities(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildToolbar(BuildContext context) {
    return ValueListenableBuilder<Directory?>(
      valueListenable: directoryNotifier,
      builder: (context, directory, child) {
        final theme = Theme.of(context);
        final url = directory?.path ?? 'My Computer';
        final urlController = TextEditingController(text: url);
        return Row(
          children: [
            InkResponse(
              onTap: directory == null
                  ? null
                  : () => openParentDirectory(context, directory),
              child: const Icon(
                Icons.arrow_back,
                size: 20.0,
              ),
              radius: 20.0,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: TextField(
                controller: urlController,
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            InkResponse(
              onTap: () => changeThemeMode(context),
              child: Icon(
                Icons.change_circle,
                key: changeKey,
                size: 20.0,
              ),
              radius: 20.0,
            ),
          ],
        );
      },
    );
  }

  Widget buildDrives(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<List<Drive>>(
        valueListenable: drivesNotifier,
        builder: (context, drives, child) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: drives.length,
            itemBuilder: (context, i) {
              final drive = drives[i];
              final String image;
              switch (drive.type) {
                case DriveType.fixed:
                  image = 'images/internal.png';
                  break;
                case DriveType.cdROM:
                  image = 'images/compact.png';
                  break;
                case DriveType.removable:
                  image = 'images/removable.png';
                  break;
                default:
                  image = 'images/external.png';
                  break;
              }
              const spacing = 4.0;
              return Center(
                child: ClipPath(
                  clipper: const DriveClipper(radius: 12.0, spacing: spacing),
                  child: Material(
                    child: InkWell(
                      onDoubleTap: () {
                        final directory = Directory(drive.name);
                        openDirectory(context, directory);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            image,
                            width: 100.0,
                            height: 100.0,
                          ),
                          const SizedBox(height: spacing),
                          Text(drive.name),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, i) {
              return const SizedBox(width: 40.0);
            },
          );
        },
      ),
    );
  }

  Widget buildEntities(BuildContext context) {
    return ValueListenableBuilder<List<FileSystemEntity>>(
      valueListenable: entitiesNotifier,
      builder: (context, entities, child) {
        return ListView.separated(
          itemCount: entities.length,
          itemBuilder: (context, i) {
            final entity = entities[i];
            final name = entity.path.split(r'\').last;
            final image = entity is Directory
                ? 'images/directory.png'
                : name.endsWith('.png')
                    ? 'images/image.png'
                    : 'images/unknown.png';
            return InkWell(
              onDoubleTap: () async {
                if (entity is Directory) {
                  openDirectory(context, entity);
                }
              },
              child: Row(
                children: [
                  Image.asset(
                    image,
                    width: 24.0,
                    height: 24.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(name),
                ],
              ),
            );
          },
          separatorBuilder: (context, i) {
            return const SizedBox(height: 8.0);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    driveSubscription.cancel();
    directorySubscription?.cancel();

    directoryNotifier.dispose();
    drivesNotifier.dispose();
    entitiesNotifier.dispose();
    fileNotifier.dispose();
    super.dispose();
  }

  void openDrives(BuildContext context) async {
    try {
      drivesNotifier.value = util.getDrives();
      directoryNotifier.value = null;
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('$e'),
          );
        },
      );
    }
  }

  void openDirectory(BuildContext context, Directory directory) async {
    try {
      await directorySubscription?.cancel();

      entitiesNotifier.value = await directory.list().toList();
      directoryNotifier.value = directory;

      directorySubscription = directory.watch().listen((event) async {
        try {
          entitiesNotifier.value = await directory.list().toList();
        } catch (e) {
          log('Get entities failed: $e');
        }
      });
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('$e'),
          );
        },
      );
    }
  }

  void openParentDirectory(BuildContext context, Directory directory) {
    if (directory.parent.path == directory.path) {
      openDrives(context);
    } else {
      openDirectory(context, directory.parent);
    }
  }

  void changeThemeMode(BuildContext context) {
    startAnimation(context);
    final settings = Settings.of(context);
    switch (settings.themeMode) {
      case ThemeMode.system:
        final value = settings.copyWith(
          themeMode: ThemeMode.light,
        );
        SettingsNotification(value).dispatch(context);
        break;
      case ThemeMode.light:
        final value = settings.copyWith(
          themeMode: ThemeMode.dark,
        );
        SettingsNotification(value).dispatch(context);
        break;
      case ThemeMode.dark:
        final value = settings.copyWith(
          themeMode: ThemeMode.system,
        );
        SettingsNotification(value).dispatch(context);
        break;
      default:
        break;
    }
  }

  void startAnimation(BuildContext context) async {
    final renderObject = key.currentContext?.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      final renderBox = changeKey.currentContext?.findRenderObject();
      if (renderBox is RenderBox) {
        final center = (Offset.zero & renderBox.size).center;
        offset = renderBox.localToGlobal(center, ancestor: renderObject);
      }
      final mediaQuery = MediaQuery.of(context);
      screenshotNotifier.value = await renderObject.toImage(
        pixelRatio: mediaQuery.devicePixelRatio,
      );
    }
  }

  // Widget buildBoby(BuildContext context) {
  //   return Center(
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         minimumSize: Size.zero,
  //         fixedSize: const Size.fromHeight(32.0),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //       ),
  //       onPressed: () async {
  //         final result = await FilePicker.platform.pickFiles();
  //         if (result != null) {
  //           final file = File(result.files.single.path!);
  //           final directory = file.parent;
  //           final bytes = await file.readAsBytes();
  //           final cleanedBytes = util.clean(bytes);
  //           final cleanedPath = '${directory.path}\\cleaned.png';
  //           final sink = File(cleanedPath).openWrite();
  //           sink.add(cleanedBytes);
  //           await sink.flush();
  //           await sink.close();
  //         } else {}
  //       },
  //       child: const Text('选择文件'),
  //     ),
  //   );
  // }

}

class DriveClipper extends CustomClipper<Path> {
  final double radius;
  final double spacing;

  const DriveClipper({
    required this.radius,
    required this.spacing,
  });

  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;

    final radius1 = (height - width - spacing) / 2.0;

    final length0 = width - 2.0 * radius;
    final length1 = width - 2.0 * radius1;

    final r0 = Radius.circular(radius);
    final r1 = Radius.circular(radius1);

    final o0 = Offset.zero.translate(radius, 0.0);
    final o1 = o0.translate(length0, 0.0);
    final o2 = o1.translate(radius, radius);
    final o3 = o2.translate(0.0, length0);
    final o4 = o3.translate(-radius, radius);
    final o5 = o4.translate(-length0, 0.0);
    final o6 = o5.translate(-radius, -radius);
    final o7 = o6.translate(0.0, -length0);

    final o8 = Offset.zero.translate(radius1, width + spacing);
    final o9 = o8.translate(length1, 0.0);
    final o10 = o9.translate(0.0, 2.0 * radius1);
    final o11 = o10.translate(-length1, 0.0);

    return Path()
      ..moveTo(o0.dx, o0.dy)
      ..lineTo(o1.dx, o1.dy)
      ..arcToPoint(o2, radius: r0)
      ..lineTo(o3.dx, o3.dy)
      ..arcToPoint(o4, radius: r0)
      ..lineTo(o5.dx, o5.dy)
      ..arcToPoint(o6, radius: r0)
      ..lineTo(o7.dx, o7.dy)
      ..arcToPoint(o0, radius: r0)
      ..moveTo(o8.dx, o8.dy)
      ..lineTo(o9.dx, o9.dy)
      ..arcToPoint(o10, radius: r1)
      ..lineTo(o11.dx, o11.dy)
      ..arcToPoint(o8, radius: r1);
  }

  @override
  bool shouldReclip(covariant DriveClipper oldClipper) {
    return oldClipper.radius != radius || oldClipper.spacing != spacing;
  }
}
