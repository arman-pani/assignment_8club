import 'package:assignment_8club/constants/app_colors.dart';
import 'package:flutter/material.dart';

class WavySlider extends StatefulWidget {
  final double value;
  final double waveHeight;
  final double waveWidth;
  final double width;
  final double strokeWidth;
  final Color color;

  const WavySlider({
    super.key,
    this.value = .5,
    this.waveHeight = 8,
    this.width = 200,
    this.waveWidth = 12,
    this.strokeWidth = 2,
    this.color = AppColors.primaryAccent,
  });

  @override
  State<WavySlider> createState() => _WavySliderState();
}

class _WavySliderState extends State<WavySlider> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: widget.value),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, animatedValue, _) {
        final animatedWidth = animatedValue * widget.width;

        return Stack(
          children: [
            Container(
              color: Colors.transparent,
              height: widget.waveHeight,
              child: _WavySliderBackground(
                waveHeight: widget.waveHeight,
                waveWidth: widget.waveWidth,
                thickness: widget.strokeWidth,
                width: widget.width,
                color: AppColors.border2,
              ),
            ),
            Container(
              color: Colors.transparent,
              height: widget.waveHeight,
              width: animatedWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _WaveLine(
                    waveHeight: widget.waveHeight,
                    waveWidth: widget.waveWidth,
                    waveLineColor: widget.color,
                    thickness: widget.strokeWidth,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _WaveLine extends StatelessWidget {
  final double waveHeight;
  final double waveWidth;
  final Color waveLineColor;
  final double thickness;

  const _WaveLine({
    required this.waveHeight,
    required this.waveWidth,
    required this.waveLineColor,
    required this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 0),
      painter: _WavyLinePainter(
        waveColor: waveLineColor,
        strokeWidth: thickness,
        height: waveHeight,
        width: waveWidth,
      ),
    );
  }
}

class _WavyLinePainter extends CustomPainter {
  final Color waveColor;
  final double strokeWidth;
  final double height;
  final double width;

  _WavyLinePainter({
    required this.height,
    required this.width,
    required this.waveColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    final waveHeight = height;
    final waveWidth = width;

    path.moveTo(0, size.height / 2 + 5);
    bool up = true;

    for (double x = 9; x < size.width; x += waveWidth) {
      if (up) {
        path.relativeQuadraticBezierTo(
          waveWidth / 2,
          -waveHeight,
          waveWidth,
          0,
        );
      } else {
        path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight, waveWidth, 0);
      }
      up = !up;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _WavySliderBackground extends StatefulWidget {
  final double width;
  final double waveHeight;
  final double waveWidth;
  final double thickness;
  final Color color;

  const _WavySliderBackground({
    required this.waveHeight,
    required this.waveWidth,
    this.width = 200,
    required this.thickness,
    required this.color,
  });

  @override
  State<_WavySliderBackground> createState() => _WavySliderBackgroundState();
}

class _WavySliderBackgroundState extends State<_WavySliderBackground> {
  late double _width;

  @override
  void initState() {
    super.initState();
    _width = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: _width,
          child: _WaveLine(
            waveHeight: widget.waveHeight,
            waveWidth: widget.waveWidth,
            waveLineColor: widget.color,
            thickness: widget.thickness,
          ),
        ),
      ],
    );
  }
}
