import 'dart:io';

import 'package:file_manager/models.dart';
import 'package:file_manager/util.dart' as util;
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ValueNotifier<Directory?> directoryNotifier;
  late ValueNotifier<File?> fileNotifier;

  @override
  void initState() {
    super.initState();

    directoryNotifier = ValueNotifier(null);
    fileNotifier = ValueNotifier(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBoby(context),
    );
  }

  Widget buildBoby(BuildContext context) {
    return ValueListenableBuilder<Directory?>(
      valueListenable: directoryNotifier,
      builder: (context, directory, child) {
        if (directory == null) {
          final drives = util.getDrivesByWin32();
          // final drives = util.getDrivesByWMI();
          return buildDrives(context, drives);
        } else {
          final entities = directory.listSync();
          return buildEntities(context, entities);
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
                    directoryNotifier.value = Directory(drive.name);
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

  Widget buildEntities(BuildContext context, List<FileSystemEntity> entities) {
    return ListView.separated(
      padding: const EdgeInsets.all(12.0),
      itemCount: entities.length,
      itemBuilder: (context, i) {
        final entity = entities[i];
        final name = entity.path.substring(entity.parent.path.length);
        final stat = entity.statSync();
        final image = stat.type == FileSystemEntityType.directory
            ? 'images/folder.png'
            : 'images/unknown.png';
        return Row(
          children: [
            Image.asset(
              image,
              width: 20.0,
              height: 20.0,
            ),
            const SizedBox(width: 4.0),
            Text(name),
          ],
        );
      },
      separatorBuilder: (context, i) {
        return const SizedBox(height: 4.0);
      },
    );
  }

  @override
  void dispose() {
    directoryNotifier.dispose();
    fileNotifier.dispose();
    super.dispose();
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
