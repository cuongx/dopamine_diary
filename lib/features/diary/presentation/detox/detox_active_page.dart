import 'dart:async';
import 'dart:math' as math;

import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';
import 'package:dopamine_diary/features/diary/presentation/detox/bloc/detox_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/detox/detox_setup_page.dart';
import 'package:dopamine_diary/features/diary/presentation/detox/emergency_page.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/empty_state.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Tab Detox — show:
/// - Idle: CTA bắt đầu detox
/// - Running: timer ring + lý do + blocked apps + quote + nút end
class DetoxActivePage extends StatefulWidget {
  const DetoxActivePage({super.key});

  @override
  State<DetoxActivePage> createState() => _DetoxActivePageState();
}

class _DetoxActivePageState extends State<DetoxActivePage> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    context.read<DetoxBloc>().add(DetoxLoadActiveRequested());
    // Cập nhật remaining time hiển thị mỗi 30s. Không cần precision giây.
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.detoxTitle)),
      body: BlocBuilder<DetoxBloc, DetoxState>(
        builder: (context, state) {
          if (state is DetoxInitial || state is DetoxLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DetoxFailure) {
            return EmptyState(
              icon: LucideIcons.alertTriangle,
              title: l10n.commonError,
              description: state.message,
            );
          }
          if (state is DetoxIdle) {
            return _IdleView(
              onStart: () => _openSetup(context),
            );
          }
          if (state is DetoxRunning) {
            return _RunningView(
              session: state.session,
              onEnd: () => _confirmEnd(context, state.session.id),
              onEmergency: () => Navigator.push(
                context,
                EmergencyPage.route(reason: state.session.reason),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _openSetup(BuildContext context) {
    Navigator.push(context, DetoxSetupPage.route());
  }

  void _confirmEnd(BuildContext context, String id) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.detoxConfirmEndTitle),
        content: Text(l10n.detoxConfirmEndContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.detoxConfirmEndContinue),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.detoxConfirmEndConfirm),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      context.read<DetoxBloc>().add(DetoxEndRequested(id: id));
    }
  }
}

// ============================ Idle ============================

class _IdleView extends StatelessWidget {
  final VoidCallback onStart;
  const _IdleView({required this.onStart});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space5,
        AppSpacing.space5,
        AppSpacing.space5,
        AppSpacing.space10,
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.space5),
          decoration: BoxDecoration(
            color: AppColors.brandPrimaryBg,
            borderRadius: AppRadius.lgR,
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.brandPrimary,
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(LucideIcons.zap, color: Colors.white, size: 30),
              ),
              const SizedBox(height: AppSpacing.space4),
              Text(
                l10n.detoxIdleTitle,
                style: AppTextStyles.heading1
                    .copyWith(color: AppColors.brandPrimaryText),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.space2),
              Text(
                l10n.detoxIdleDesc,
                style: AppTextStyles.body
                    .copyWith(color: AppColors.brandPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.space5),
              AppButton(
                label: l10n.detoxIdleStartCta,
                icon: LucideIcons.play,
                variant: AppButtonVariant.tertiary,
                onPressed: onStart,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space5),
        _QuoteCard(),
      ],
    );
  }
}

// ============================ Running ============================

class _RunningView extends StatelessWidget {
  final DetoxSession session;
  final VoidCallback onEnd;
  final VoidCallback onEmergency;

  const _RunningView({
    required this.session,
    required this.onEnd,
    required this.onEmergency,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final total = Duration(days: session.durationDays);
    final elapsed = now.difference(session.startTime);
    final remaining = total - elapsed;
    final progress = (elapsed.inSeconds / total.inSeconds).clamp(0.0, 1.0);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space5,
        AppSpacing.space5,
        AppSpacing.space5,
        AppSpacing.space10,
      ),
      children: [
        Center(
          child: Text(
            l10n.detoxRunningHeader,
            style: AppTextStyles.label.copyWith(
              color: AppColors.brandPrimary,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space5),
        Center(
          child: SizedBox(
            width: 240,
            height: 240,
            child: CustomPaint(
              painter: _DetoxRingPainter(progress: progress),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatRemaining(context, remaining),
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                        height: 1,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space1),
                    Text(
                      l10n.detoxRunningSubtitle(session.durationDays),
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space5),
        if (session.reason.isNotEmpty) _ReasonCard(reason: session.reason),
        if (session.blockedApps.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.space4),
          _BlockedAppsCard(apps: session.blockedApps),
        ],
        const SizedBox(height: AppSpacing.space4),
        _QuoteCard(),
        const SizedBox(height: AppSpacing.space5),
        AppButton(
          label: l10n.detoxEmergencyCta,
          icon: LucideIcons.lifeBuoy,
          variant: AppButtonVariant.tertiary,
          onPressed: onEmergency,
        ),
        const SizedBox(height: AppSpacing.space3),
        AppButton(
          label: l10n.detoxEndEarly,
          variant: AppButtonVariant.ghost,
          onPressed: onEnd,
        ),
      ],
    );
  }

  String _formatRemaining(BuildContext context, Duration d) {
    final l10n = AppLocalizations.of(context);
    if (d.isNegative) return l10n.durationDaysHours(0, 0);
    final days = d.inDays;
    final hours = d.inHours % 24;
    return l10n.durationDaysHours(days, hours);
  }
}

class _DetoxRingPainter extends CustomPainter {
  final double progress;
  _DetoxRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const stroke = 12.0;
    final radius = (size.width - stroke) / 2;

    final trackPaint = Paint()
      ..color = AppColors.surface2
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    final progressPaint = Paint()
      ..color = AppColors.brandPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
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
  bool shouldRepaint(_DetoxRingPainter old) => old.progress != progress;
}

class _ReasonCard extends StatelessWidget {
  final String reason;
  const _ReasonCard({required this.reason});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.lgR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.detoxReasonLabel,
            style: AppTextStyles.label.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space2),
          Text(
            reason,
            style: AppTextStyles.body
                .copyWith(color: AppColors.textPrimary, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _BlockedAppsCard extends StatelessWidget {
  final List<String> apps;
  const _BlockedAppsCard({required this.apps});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.lgR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.detoxBlockedLabel,
            style: AppTextStyles.label.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space3),
          Wrap(
            spacing: AppSpacing.space2,
            runSpacing: AppSpacing.space2,
            children: apps
                .map((a) => Chip(
                      label: Text(a),
                      avatar: const Icon(LucideIcons.ban,
                          size: 14, color: AppColors.cheapFg),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.brandPrimaryBg,
        borderRadius: AppRadius.lgR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.quote,
              size: 20, color: AppColors.brandPrimary.withValues(alpha: 0.5)),
          const SizedBox(height: AppSpacing.space2),
          Text(
            l10n.detoxQuoteText,
            style: AppTextStyles.body.copyWith(
              color: AppColors.brandPrimaryText,
              height: 1.55,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: AppSpacing.space2),
          Text(
            l10n.detoxQuoteAuthor,
            style: AppTextStyles.caption
                .copyWith(color: AppColors.brandPrimary),
          ),
        ],
      ),
    );
  }
}
