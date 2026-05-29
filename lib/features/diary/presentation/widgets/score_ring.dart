import 'dart:math' as math;

import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Vòng tròn hiển thị score 0-100. Vẽ bằng CustomPainter — scale vô hạn.
///
/// Phase 9 sẽ wrap bằng TweenAnimationBuilder để có count-up 800ms.
/// Hiện tại render tĩnh để dùng trong layout.
class ScoreRing extends StatelessWidget {
  final int score;
  final double size;
  final double strokeWidth;

  /// Phụ đề dưới số (vd "/100" hoặc "Cân bằng tốt").
  final String? subtitle;

  const ScoreRing({
    super.key,
    required this.score,
    this.size = 160,
    this.strokeWidth = 10,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final color = _colorForScore(score);
    final clamped = score.clamp(0, 100);
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ScoreRingPainter(
          progress: clamped / 100,
          color: color,
          strokeWidth: strokeWidth,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$clamped',
                style: GoogleFonts.inter(
                  fontSize: size * 0.32,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  height: 1,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle ?? '/100',
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Màu progress theo score — soft, không alert.
  /// Trên 70 dùng deep blue (an toàn), 50-70 healthy green (ok),
  /// dưới 50 medium orange (chú ý). Không bao giờ dùng đỏ rực.
  static Color _colorForScore(int score) {
    if (score >= 70) return AppColors.deepMain;
    if (score >= 50) return AppColors.healthyMain;
    return AppColors.mediumMain;
  }
}

class _ScoreRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _ScoreRingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track nền
    final trackPaint = Paint()
      ..color = AppColors.surface2
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Progress arc — bắt đầu từ đỉnh, đi theo chiều kim đồng hồ
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_ScoreRingPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.strokeWidth != strokeWidth;
}
