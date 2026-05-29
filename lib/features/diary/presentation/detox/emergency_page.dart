import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/breathing_circle.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Emergency Mode — màn calming khi user gần relapse.
/// Tone teal (KHÔNG đỏ), tập trung vào hít thở + reflection.
/// Reason là lý do detox user đã viết khi setup — show lại để remind.
class EmergencyPage extends StatelessWidget {
  static MaterialPageRoute<void> route({String? reason}) =>
      MaterialPageRoute(
        builder: (_) => EmergencyPage(reason: reason),
        fullscreenDialog: true,
      );

  final String? reason;

  const EmergencyPage({super.key, this.reason});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF04342C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(LucideIcons.x, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF04342C), Color(0xFF0F6E56)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space5,
              AppSpacing.space4,
              AppSpacing.space5,
              AppSpacing.space6,
            ),
            children: [
              Text(
                l10n.emergencyTitle,
                style: AppTextStyles.display
                    .copyWith(color: Colors.white, fontSize: 28),
              ),
              const SizedBox(height: AppSpacing.space2),
              Text(
                l10n.emergencySubtitle,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                  height: 1.55,
                ),
              ),
              const SizedBox(height: AppSpacing.space5),
              const Center(
                child: BreathingCircle(
                  minSize: 140,
                  maxSize: 240,
                  color: Color(0xFF1D9E75),
                ),
              ),
              const SizedBox(height: AppSpacing.space5),
              _NotFailureCard(text: l10n.emergencyNotFailureText),
              if (reason != null && reason!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.space4),
                _YourReasonCard(
                  label: l10n.emergencyYourReasonLabel,
                  reason: reason!,
                ),
              ],
              const SizedBox(height: AppSpacing.space5),
              Text(
                l10n.emergencyTryNowLabel,
                style: AppTextStyles.label.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: AppSpacing.space3),
              _QuickAction(
                icon: LucideIcons.droplet,
                title: l10n.emergencyActionWaterTitle,
                description: l10n.emergencyActionWaterDesc,
              ),
              _QuickAction(
                icon: LucideIcons.activity,
                title: l10n.emergencyActionExerciseTitle,
                description: l10n.emergencyActionExerciseDesc,
              ),
              _QuickAction(
                icon: LucideIcons.phone,
                title: l10n.emergencyActionBuddyTitle,
                description: l10n.emergencyActionBuddyDesc,
              ),
              const SizedBox(height: AppSpacing.space5),
              _ReflectionCard(
                label: l10n.emergencyReflectionLabel,
                question: l10n.emergencyReflectionQuestion,
                desc: l10n.emergencyReflectionDesc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================ Components ============================

class _NotFailureCard extends StatelessWidget {
  final String text;
  const _NotFailureCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: AppRadius.lgR,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: AppRadius.smR,
            ),
            child: const Icon(LucideIcons.heart,
                size: 20, color: Colors.white),
          ),
          const SizedBox(width: AppSpacing.space3),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _YourReasonCard extends StatelessWidget {
  final String label;
  final String reason;
  const _YourReasonCard({required this.label, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: AppRadius.lgR,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.label.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: AppSpacing.space2),
          Text(
            '"$reason"',
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space2),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space3),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: AppRadius.mdR,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: AppRadius.smR,
              ),
              child: Icon(icon, size: 20, color: Colors.white),
            ),
            const SizedBox(width: AppSpacing.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReflectionCard extends StatelessWidget {
  final String label;
  final String question;
  final String desc;
  const _ReflectionCard({
    required this.label,
    required this.question,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: AppRadius.lgR,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.helpCircle,
                  size: 16, color: Colors.white),
              const SizedBox(width: AppSpacing.space2),
              Text(
                label,
                style: AppTextStyles.label.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space2),
          Text(
            question,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.space1),
          Text(
            desc,
            style: AppTextStyles.body.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
