import 'dart:io';
import 'package:assignment_8club/constants/app_colors.dart';
import 'package:assignment_8club/constants/app_strings.dart';
import 'package:assignment_8club/constants/app_textstyles.dart';
import 'package:assignment_8club/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoRecorded extends StatefulWidget {
  final String videoPath;
  final VoidCallback onDelete;
  const VideoRecorded({super.key, required this.videoPath, required this.onDelete});

  @override
  State<VideoRecorded> createState() => _VideoRecordedState();
}

class _VideoRecordedState extends State<VideoRecorded> {
  String? _thumbPath;
  VideoPlayerController? _controller;
  Duration? _duration;

  @override
  void initState() {
    super.initState();
    _initVideo();
    _generate();
  }

  Future<void> _initVideo() async {
    _controller = VideoPlayerController.file(File(widget.videoPath));

    await _controller!.initialize();
    _duration = _controller!.value.duration;

    if (mounted) setState(() {});
  }

  Future<void> _generate() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final thumb = await VideoThumbnail.thumbnailFile(
        video: widget.videoPath,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 120,
        quality: 75,
      );
      if (mounted) setState(() => _thumbPath = thumb);
    } catch (_) {
      debugPrint("Thumbnail generation failed");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 4.0, top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite2,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: FileImage(File(_thumbPath ?? "")),
                fit: BoxFit.cover,
              ),
            ),
            child: Icon(LucideIcons.play, color: AppColors.text1, size: 12.0),
          ),
          SizedBox(width: 12.0),
          Text.rich(
            TextSpan(
              text: AppStrings.videoRecorded,
              style: AppTextStyles.b1.copyWith(
                fontWeight: FontWeight.w200,
                color: AppColors.text1,
              ),
              children: [
                TextSpan(
                  text:
                      " • ${formatDuration(_duration ?? Duration.zero)}",
                  style: AppTextStyles.b1.copyWith(
                    fontWeight: FontWeight.w200,
                    color: AppColors.text4,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: widget.onDelete,
            icon: Icon(
              LucideIcons.trash2,
              color: AppColors.primaryAccent,
              size: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
