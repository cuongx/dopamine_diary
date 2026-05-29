import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// Vòng tròn hít thở cho Emergency Mode.
/// Nhịp: hít vào 4s → giữ 2s → thở ra 4s (chu kỳ 10s, lặp vô hạn).
///
/// Render 3 lớp đồng tâm với alpha tăng dần — không cần Lottie.
class BreathingCircle extends StatefulWidget {
  final double minSize;
  final double maxSize;
  final Color color;

  const BreathingCircle({
    super.key,
    this.minSize = 160,
    this.maxSize = 280,
    this.color = AppColors.accentCalm,
  });

  @override
  State<BreathingCircle> createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final l10n = AppLocalizations.of(context);
        final t = _controller.value;
        // Phases: 0-0.4 inhale (0→1), 0.4-0.6 hold (1), 0.6-1.0 exhale (1→0).
        final double progress;
        final String label;
        if (t < 0.4) {
          progress = t / 0.4;
          label = l10n.breathingInhale;
        } else if (t < 0.6) {
          progress = 1;
          label = l10n.breathingHold;
        } else {
          progress = (1 - t) / 0.4;
          label = l10n.breathingExhale;
        }
        final eased = Curves.easeInOut.transform(progress);
        final size =
            widget.minSize + (widget.maxSize - widget.minSize) * eased;
        return SizedBox(
          width: widget.maxSize,
          height: widget.maxSize,
          child: Center(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withValues(alpha: 0.12),
              ),
              child: Center(
                child: Container(
                  width: size * 0.75,
                  height: size * 0.75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withValues(alpha: 0.22),
                  ),
                  child: Center(
                    child: Container(
                      width: size * 0.5,
                      height: size * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color.withValues(alpha: 0.55),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: AppTextStyles.heading2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
