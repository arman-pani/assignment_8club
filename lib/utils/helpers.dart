int getDegreeRotation(int index) {
  int value = (index + 1) % 3;
  if (value == 0) {
    return 0;
  } else if (value == 1) {
    return -3;
  } else {
    return 3;
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return '$minutes:$seconds';
}
