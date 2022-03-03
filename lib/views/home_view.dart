import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_manager/models.dart';
import 'package:file_manager/notifications.dart';
import 'package:file_manager/util.dart' as util;
import 'package:file_manager/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tuple/tuple.dart';

typedef ClipArguments = Tuple3<ui.Image, ui.Offset, ui.Size>;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final key = GlobalKey();
  final keys = {for (var themeMode in ThemeMode.values) themeMode: GlobalKey()};

  late ValueNotifier<Directory?> directoryNotifier;
  late ValueNotifier<List<Drive>> drivesNotifier;
  late ValueNotifier<List<FileSystemEntity>> entitiesNotifier;
  late ValueNotifier<Uint8List?> memoryNotifier;
  late StreamSubscription<DriveState> driveSubscription;
  late ValueNotifier<ClipArguments?> clipArgumentsNotifier;

  late AnimationController themeController;

  StreamSubscription<FileSystemEvent>? directorySubscription;

  @override
  void initState() {
    super.initState();

    directoryNotifier = ValueNotifier(null);
    drivesNotifier = ValueNotifier([]);
    entitiesNotifier = ValueNotifier([]);
    memoryNotifier = ValueNotifier(null);
    clipArgumentsNotifier = ValueNotifier(null);

    themeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

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
        developer.log('Get drives failed: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: key,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
            body: buildBoby(context),
          ),
          ValueListenableBuilder<ClipArguments?>(
            valueListenable: clipArgumentsNotifier,
            builder: (context, clipArguments, child) {
              if (clipArguments == null) {
                return const SizedBox.shrink();
              } else {
                final image = clipArguments.item1;
                final offset = clipArguments.item2;
                final size = clipArguments.item3;
                final bounds = Offset.zero & size;
                final d0 = (offset - bounds.topLeft).distance;
                final d1 = (offset - bounds.topRight).distance;
                final d2 = (offset - bounds.bottomRight).distance;
                final d3 = (offset - bounds.bottomLeft).distance;
                final distance = [d0, d1, d2, d3].reduce(math.max);
                final animation = CurvedAnimation(
                  parent: themeController,
                  curve: Curves.easeInOut,
                );
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return ClipImage(
                      image: image,
                      offset: offset,
                      radius: distance * animation.value,
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
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
        final settings = Settings.of(context);
        final theme = Theme.of(context);
        final url = directory?.path ?? 'This PC';
        final urlController = TextEditingController(text: url);
        const height = 32.0;
        const modes = ThemeMode.values;
        return SizedBox(
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: height,
                margin: const EdgeInsets.only(right: 12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: directory == null
                      ? null
                      : () => openParentDirectory(context, directory),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: height / 2.0,
                      vertical: 8.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(height / 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(height / 2.0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12.0),
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(height / 2.0),
                  children: modes.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: height / 2.0,
                      ),
                      child: Text(e.name, key: keys[e]),
                    );
                  }).toList(),
                  isSelected:
                      modes.map((e) => settings.themeMode == e).toList(),
                  onPressed: (i) {
                    final mode = modes[i];
                    changeThemeMode(context, mode);
                  },
                ),
              ),
            ],
          ),
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
                        openEntity(context, directory);
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
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<List<FileSystemEntity>>(
            valueListenable: entitiesNotifier,
            builder: (context, entities, child) {
              return ListView.separated(
                itemCount: entities.length,
                itemBuilder: (context, i) {
                  final entity = entities[i];
                  final name = entity.path.split(r'\').last;
                  final image = entity is Directory
                      ? 'images/directory.png'
                      : entity.endsWithJPG || entity.endsWithPNG
                          ? 'images/image.png'
                          : 'images/unknown.png';
                  return InkWell(
                    onTap: () => viewEntity(context, entity),
                    onDoubleTap: () => openEntity(context, entity),
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
          ),
        ),
        ValueListenableBuilder<Uint8List?>(
          valueListenable: memoryNotifier,
          builder: (context, memory, child) {
            return Visibility(
              visible: memory != null,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Image.memory(
                  memory ?? Uint8List(0),
                  fit: BoxFit.scaleDown,
                  errorBuilder: (context, error, stack) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$error'),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: memory == null
                              ? null
                              : () => fixMemory(context, memory),
                          child: const Text('Try to fix'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    driveSubscription.cancel();
    directorySubscription?.cancel();

    themeController.dispose();

    directoryNotifier.dispose();
    drivesNotifier.dispose();
    entitiesNotifier.dispose();
    memoryNotifier.dispose();
    clipArgumentsNotifier.dispose();
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

  void viewEntity(BuildContext context, FileSystemEntity entity) async {
    if (entity is File && (entity.endsWithJPG || entity.endsWithPNG)) {
      memoryNotifier.value = await entity.readAsBytes();
    } else {
      memoryNotifier.value = null;
    }
  }

  void openEntity(BuildContext context, FileSystemEntity entity) async {
    final file = memoryNotifier.value;
    if (file != null) {
      memoryNotifier.value = null;
    }
    if (entity is Directory) {
      try {
        await directorySubscription?.cancel();

        entitiesNotifier.value = await entity.list().toList();
        directoryNotifier.value = entity;

        directorySubscription = entity.watch().listen((event) async {
          try {
            entitiesNotifier.value = await entity.list().toList();
          } catch (e) {
            developer.log('Get entities failed: $e');
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
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Not implemented yet!'),
          );
        },
      );
    }
  }

  void openParentDirectory(BuildContext context, Directory directory) {
    if (memoryNotifier.value != null) {
      memoryNotifier.value = null;
    }
    if (directory.parent.path == directory.path) {
      openDrives(context);
    } else {
      openEntity(context, directory.parent);
    }
  }

  void changeThemeMode(BuildContext context, ThemeMode mode) {
    final settings = Settings.of(context);
    if (settings.themeMode == mode) {
      return;
    }
    final value = settings.copyWith(
      themeMode: mode,
    );
    SettingsNotification(value).dispatch(context);

    final key = keys[mode]!;
    startAnimation(context, key);
  }

  void startAnimation(BuildContext context, GlobalKey key) async {
    final renderObject = this.key.currentContext?.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      final renderBox = key.currentContext?.findRenderObject();
      if (renderBox is RenderBox) {
        final mediaQuery = MediaQuery.of(context);
        final image = await renderObject.toImage(
          pixelRatio: mediaQuery.devicePixelRatio,
        );
        final center = (Offset.zero & renderBox.size).center;
        final offset = renderBox.localToGlobal(center, ancestor: renderObject);
        final size = renderObject.size;
        clipArgumentsNotifier.value = ClipArguments(image, offset, size);
        themeController
          ..reset()
          ..forward().whenComplete(() => clipArgumentsNotifier.value = null);
      }
    }
  }

  void fixMemory(BuildContext context, Uint8List memory) {
    final elements = util.removeCRs(memory);
    memoryNotifier.value = Uint8List.fromList(elements);
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

extension on FileSystemEntity {
  bool get endsWithJPG => path.toUpperCase().endsWith('.JPG');
  bool get endsWithPNG => path.toUpperCase().endsWith('.PNG');
}
