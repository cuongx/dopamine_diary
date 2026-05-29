import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Tick xanh animated — chạy khi log activity thành công.
/// Vẽ vòng tròn ngoài + dấu check bằng CustomPainter (KHÔNG cần Lottie).
/// 800ms tổng: 300ms scale-in vòng tròn, 500ms vẽ dấu check.
class AnimatedCheck extends StatefulWidget {
  final double size;
  final Color color;
  final VoidCallback? onComplete;

  const AnimatedCheck({
    super.key,
    this.size = 96,
    this.color = AppColors.healthyMain,
    this.onComplete,
  });

  @override
  State<AnimatedCheck> createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _circleAnim;
  late final Animation<double> _checkAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _circleAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.4, curve: Curves.easeOut),
    );
    _checkAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic),
    );
    _controller.forward().whenComplete(() => widget.onComplete?.call());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          painter: _CheckPainter(
            circleProgress: _circleAnim.value,
            checkProgress: _checkAnim.value,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  final double circleProgress;
  final double checkProgress;
  final Color color;

  _CheckPainter({
    required this.circleProgress,
    required this.checkProgress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;

    // Vòng tròn nền (scale-in)
    final scale = circleProgress;
    final fillPaint = Paint()..color = color.withValues(alpha: 0.15);
    canvas.drawCircle(center, radius * scale, fillPaint);

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius * scale, strokePaint);

    if (checkProgress <= 0) return;

    // Dấu check — 2 đoạn nối nhau, vẽ progressive
    final w = size.width;
    final p1 = Offset(w * 0.28, w * 0.50);
    final p2 = Offset(w * 0.45, w * 0.65);
    final p3 = Offset(w * 0.72, w * 0.38);

    final checkPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()..moveTo(p1.dx, p1.dy);
    if (checkProgress < 0.5) {
      final t = checkProgress / 0.5;
      final cur = Offset.lerp(p1, p2, t)!;
      path.lineTo(cur.dx, cur.dy);
    } else {
      path.lineTo(p2.dx, p2.dy);
      final t = (checkProgress - 0.5) / 0.5;
      final cur = Offset.lerp(p2, p3, t)!;
      path.lineTo(cur.dx, cur.dy);
    }
    canvas.drawPath(path, checkPaint);
  }

  @override
  bool shouldRepaint(_CheckPainter old) =>
      old.circleProgress != circleProgress ||
      old.checkProgress != checkProgress ||
      old.color != color;
}
