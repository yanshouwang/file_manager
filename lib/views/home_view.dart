import 'dart:io';

import 'package:file_manager/models.dart';
import 'package:file_manager/util.dart' as util;
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

typedef DirectoryAndEntities = Tuple2<Directory, List<FileSystemEntity>>;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ValueNotifier<DirectoryAndEntities?> directoryAndEntitiesNotifier;
  late ValueNotifier<File?> fileNotifier;

  @override
  void initState() {
    super.initState();

    directoryAndEntitiesNotifier = ValueNotifier(null);
    fileNotifier = ValueNotifier(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBoby(context),
    );
  }

  Widget buildBoby(BuildContext context) {
    return ValueListenableBuilder<Tuple2<Directory, List<FileSystemEntity>>?>(
      valueListenable: directoryAndEntitiesNotifier,
      builder: (context, directoryAndEntities, child) {
        if (directoryAndEntities == null) {
          final drives = util.getDrives();
          return buildDrives(context, drives);
        } else {
          return buildDirectoryAndEntities(context, directoryAndEntities);
        }
      },
    );
  }

  Widget buildDrives(BuildContext context, List<Drive> drives) {
    return Center(
      child: ListView.separated(
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
      ),
    );
  }

  Widget buildDirectoryAndEntities(
    BuildContext context,
    DirectoryAndEntities directoryAndEntities,
  ) {
    final directory = directoryAndEntities.item1;
    final entities = directoryAndEntities.item2;
    final theme = Theme.of(context);
    final urlController = TextEditingController(text: directory.path);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            controller: urlController,
            decoration: InputDecoration(
              icon: InkResponse(
                onTap: () {
                  if (directory.parent.path == directory.path) {
                    directoryAndEntitiesNotifier.value = null;
                  } else {
                    openDirectory(context, directory.parent);
                  }
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 20.0,
                ),
                radius: 20.0,
              ),
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
          const SizedBox(height: 12.0),
          Expanded(
            child: ListView.separated(
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    directoryAndEntitiesNotifier.dispose();
    fileNotifier.dispose();
    super.dispose();
  }

  void openDirectory(BuildContext context, Directory directory) async {
    try {
      final entities = await directory.list().toList();
      directoryAndEntitiesNotifier.value =
          DirectoryAndEntities(directory, entities);
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
