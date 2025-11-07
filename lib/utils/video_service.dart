import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class VideoService {
  final ImagePicker _picker = ImagePicker();

  /// Pick & record video using native camera
  Future<File?> recordVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 2),
      );

      if (video == null) return null; // user canceled

      final Directory tempDir = await getTemporaryDirectory();
      final String filePath =
          "${tempDir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4";

      final File savedFile = await File(video.path).copy(filePath);

      return savedFile;
    } catch (e) {
      return null;
    }
  }
}
