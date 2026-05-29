import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/l10n/tier_labels.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/lucide_icon_map.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// Khu vực 1 tier — accept drop activity type chip, hoặc tap chip để mở
/// sheet đổi tier. Border dashed nhẹ để gợi ý "kéo thả".
class TierZone extends StatefulWidget {
  final DopamineTier tier;
  final List<ActivityType> types;
  final void Function(String typeId, DopamineTier newTier) onAssign;
  final ValueChanged<ActivityType> onChipTap;

  const TierZone({
    super.key,
    required this.tier,
    required this.types,
    required this.onAssign,
    required this.onChipTap,
  });

  @override
  State<TierZone> createState() => _TierZoneState();
}

class _TierZoneState extends State<TierZone> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<ActivityType>(
      onWillAcceptWithDetails: (details) {
        setState(() => _hovering = true);
        return details.data.tier != widget.tier;
      },
      onLeave: (_) => setState(() => _hovering = false),
      onAcceptWithDetails: (details) {
        setState(() => _hovering = false);
        widget.onAssign(details.data.id, widget.tier);
      },
      builder: (context, candidate, rejected) {
        return CustomPaint(
          painter: _DashedBorderPainter(
            color: _hovering ? widget.tier.main : AppColors.borderDefault,
            strokeWidth: _hovering ? 1.5 : 1.0,
            radius: AppRadius.lg,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.space3),
            decoration: BoxDecoration(
              color: _hovering
                  ? widget.tier.bg
                  : AppColors.surface1,
              borderRadius: AppRadius.lgR,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: widget.tier.main,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Text(
                      widget.tier.label(context),
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: widget.tier.textColor),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.types.length}',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
                if (widget.types.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.space4,
                    ),
                    child: Text(
                      AppLocalizations.of(context).onboardingDragHere,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  )
                else ...[
                  const SizedBox(height: AppSpacing.space3),
                  Wrap(
                    spacing: AppSpacing.space2,
                    runSpacing: AppSpacing.space2,
                    children: widget.types
                        .map(
                          (t) => _DraggableChip(
                            type: t,
                            onTap: () => widget.onChipTap(t),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DraggableChip extends StatelessWidget {
  final ActivityType type;
  final VoidCallback onTap;

  const _DraggableChip({required this.type, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final chip = _Chip(type: type, onTap: onTap);
    return LongPressDraggable<ActivityType>(
      data: type,
      delay: const Duration(milliseconds: 200),
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(opacity: 0.9, child: chip),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: chip),
      child: chip,
    );
  }
}

class _Chip extends StatelessWidget {
  final ActivityType type;
  final VoidCallback onTap;

  const _Chip({required this.type, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: type.tier.bg,
      borderRadius: AppRadius.mdR,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdR,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space3,
            vertical: AppSpacing.space2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIconMap.of(type.iconName),
                  size: 14, color: type.tier.fg),
              const SizedBox(width: AppSpacing.space2),
              Text(
                type.name,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: type.tier.textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  static const double _dashLength = 6;
  static const double _gapLength = 4;

  final Color color;
  final double strokeWidth;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + _dashLength;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + _gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.radius != radius;
}
