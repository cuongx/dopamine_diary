// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Dopamine Diary';

  @override
  String get navHome => 'Today';

  @override
  String get navAnalytics => 'Analytics';

  @override
  String get navDetox => 'Detox';

  @override
  String get navMe => 'Me';

  @override
  String get tierCheap => 'Cheap';

  @override
  String get tierMedium => 'Medium';

  @override
  String get tierHealthy => 'Healthy';

  @override
  String get tierDeep => 'Deep work';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonClose => 'Close';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonBack => 'Back';

  @override
  String get commonStart => 'Start';

  @override
  String get commonStop => 'Stop';

  @override
  String get commonError => 'Error';

  @override
  String durationMinutes(int n) {
    return '${n}m';
  }

  @override
  String durationHours(int n) {
    return '${n}h';
  }

  @override
  String durationHoursMinutes(int h, int m) {
    return '${h}h${m}m';
  }

  @override
  String durationDaysHours(int d, int h) {
    return '${d}d ${h}h';
  }

  @override
  String durationDaysHoursShort(int d, int h) {
    return '${d}d ${h}h';
  }

  @override
  String durationHoursMinShort(int h, int m) {
    return '${h}h ${m}m';
  }

  @override
  String minutesValue(int n) {
    return '$n min';
  }

  @override
  String get homeGreetingMorning => 'Good morning';

  @override
  String get homeGreetingAfternoon => 'Good afternoon';

  @override
  String get homeGreetingEvening => 'Good evening';

  @override
  String get homeErrorTitle => 'Something\'s off';

  @override
  String get homeQuickLogCta => 'Log an activity';

  @override
  String get homeTodayDistribution => 'TODAY\'S BREAKDOWN';

  @override
  String homeTodayMinutes(int n) {
    return '$n min';
  }

  @override
  String get homeRecentSection => 'Recent';

  @override
  String get homeScoreExcellent => 'Excellent';

  @override
  String get homeScoreBalanced => 'Well balanced';

  @override
  String get homeScoreOk => 'Pretty good';

  @override
  String get homeScoreAdjust => 'Needs adjusting';

  @override
  String get homeScoreAttention => 'Needs attention';

  @override
  String get homeDeltaSame => 'Same as yesterday';

  @override
  String homeDeltaCompare(String sign, int delta) {
    return '$sign$delta vs yesterday';
  }

  @override
  String homeStreakDays(int days) {
    return '$days-day streak';
  }

  @override
  String get homeStreakSubtitle => 'Keeping the balance going';

  @override
  String get homeDetoxBannerTitle => 'Detox in progress';

  @override
  String homeDetoxBannerRemaining(String remaining, int total) {
    return '$remaining left / $total days';
  }

  @override
  String get homeDetoxExpired => 'expired';

  @override
  String get homeEmptyTodayTitle => 'No activities yet today';

  @override
  String get homeEmptyTodaySubtitle => 'Tap \"Log\" to get started';

  @override
  String get homeScoreSlashHundred => '/100';

  @override
  String get emptyStateRetry => 'Retry';

  @override
  String get quickLogTitle => 'Quick Log';

  @override
  String get quickLogQuestion => 'What did you just do?';

  @override
  String get quickLogSubtitle => 'Log it in 3 seconds';

  @override
  String get quickLogRecentSection => 'Recent · tap to repeat';

  @override
  String get quickLogActivitiesSection => 'Activities';

  @override
  String get quickLogVoiceCta => 'Log with voice';

  @override
  String get durationSheetQuestion => 'How long?';

  @override
  String durationSheetSaveLabel(String duration) {
    return 'Save ($duration)';
  }

  @override
  String get voiceLogTitle => 'Voice Log';

  @override
  String voiceLogListening(String time) {
    return 'Listening… $time';
  }

  @override
  String get voiceLogTapToStart => 'Tap the mic to start';

  @override
  String get voiceLogDone => 'Done recording';

  @override
  String get voiceLogTapToStop => 'Tap again to stop';

  @override
  String get voiceLogReviewSubtitle => 'Review the transcript below and save';

  @override
  String get voiceLogExample =>
      'Try: \"I went for a 30 minute run this morning\"';

  @override
  String get voiceLogReRecord => 'Re-record';

  @override
  String get voiceLogSave => 'Save';

  @override
  String get voiceLogTranscriptLabel => 'TRANSCRIPT';

  @override
  String get voiceLogAiUnderstoodLabel => 'AI UNDERSTOOD';

  @override
  String get voiceLogMockTranscript =>
      'Went for a 30 minute run at the park this morning, felt pretty good.';

  @override
  String get voiceLogMockActivity => 'Running';

  @override
  String voiceLogMoodChip(String mood) {
    return 'Mood $mood';
  }

  @override
  String get voiceLogUnavailable =>
      'Speech recognition isn\'t available, or mic/recognition permission was denied.';

  @override
  String get voiceLogError => 'Couldn\'t hear you — please try again.';

  @override
  String get voiceLogNoSpeech =>
      'Didn\'t catch anything. Tap the mic and try again.';

  @override
  String get voiceLogParsing => 'AI is analyzing…';

  @override
  String get voiceLogParseError =>
      'Couldn\'t analyze — you can still edit and save.';

  @override
  String get voiceLogReviewLabel => 'REVIEW & EDIT';

  @override
  String get voiceLogNameLabel => 'Activity name';

  @override
  String get voiceLogTierLabel => 'Type';

  @override
  String get voiceLogDurationLabel => 'Duration';

  @override
  String get voiceLogMoodLabel => 'Mood';

  @override
  String get analyticsTitle => 'Analytics';

  @override
  String get analyticsErrorTitle => 'Couldn\'t load data';

  @override
  String get analyticsScore7Days => '7-DAY SCORE';

  @override
  String get analyticsMetricCheap => 'Cheap dopamine this week';

  @override
  String get analyticsMetricDeep => 'Deep work this week';

  @override
  String get analyticsInsightWeekendTitle =>
      'Weekends score lower than weekdays';

  @override
  String get analyticsInsightWeekendDesc =>
      'Looks like Sat/Sun you spend more time on cheap dopamine. Try planning one deep activity this weekend.';

  @override
  String get analyticsInsightExerciseTitle =>
      'Days you exercise have higher scores';

  @override
  String get analyticsInsightExerciseDesc =>
      'On days you log \"Walk\" or \"Gym\", your average score is 18% higher than normal days.';

  @override
  String get analyticsWeeklyReviewCta => 'See weekly review';

  @override
  String get insightLabelAi => 'AI SUGGESTION';

  @override
  String get insightLabelPattern => 'PATTERN';

  @override
  String weeklyReviewWeekLabel(int week, int year) {
    return 'WEEK $week · $year';
  }

  @override
  String get weeklyReviewTitle => 'Your week';

  @override
  String get weeklyReviewReclaimedLabel => 'You reclaimed';

  @override
  String get weeklyReviewReclaimedFrom => 'from short video vs the average';

  @override
  String get weeklyReviewHighlightsLabel => 'HIGHLIGHTS';

  @override
  String get weeklyReviewPatternLabel => 'PATTERN LEARNED';

  @override
  String get weeklyReviewPatternDesc =>
      'Days you exercise → score is 34% higher. That\'s the biggest lever of the week. Keeping a steady exercise rhythm is the cheapest way to balance dopamine.';

  @override
  String get weeklyReviewGoalsLabel => 'GOALS FOR NEXT WEEK';

  @override
  String get weeklyReviewGoal1 => 'Keep ≥ 4 days of exercise';

  @override
  String weeklyReviewGoal2(String day) {
    return 'Best day: $day — repeat the routine';
  }

  @override
  String get weeklyReviewGoal3 => 'Cheap dopamine ≤ 1h45m/day';

  @override
  String get weeklyReviewShareCta => 'Share with friends';

  @override
  String get weeklyReviewShareUnavailable =>
      'Sharing will come in a future release';

  @override
  String weeklyReviewHighlightExercise(int done, int total) {
    return 'Exercise $done/$total days';
  }

  @override
  String weeklyReviewHighlightDeep(String duration) {
    return 'Deep work $duration all week';
  }

  @override
  String weeklyReviewHighlightScore(int avg) {
    return 'Average score $avg/100';
  }

  @override
  String get detoxTitle => 'Detox';

  @override
  String get detoxIdleTitle => 'Reset your dopamine';

  @override
  String get detoxIdleDesc =>
      'A 24h, 7-day, or 30-day detox session lets your dopamine receptors recover. Step away from short video and social media — replace with reading, exercise, real people.';

  @override
  String get detoxIdleStartCta => 'Start detox';

  @override
  String get detoxRunningHeader => 'DETOX MODE · RESETTING';

  @override
  String detoxRunningSubtitle(int totalDays) {
    return 'left / $totalDays days';
  }

  @override
  String get detoxReasonLabel => 'WHY YOU\'RE DETOXING';

  @override
  String get detoxBlockedLabel => 'BLOCKING';

  @override
  String get detoxQuoteText =>
      '\"The discomfort of withdrawal from cheap dopamine is exactly the signal that receptors are healing. Stay with it.\"';

  @override
  String get detoxQuoteAuthor => '— Anna Lembke, Dopamine Nation';

  @override
  String get detoxEmergencyCta => 'I\'m about to relapse — help me';

  @override
  String get detoxEndEarly => 'End early';

  @override
  String get detoxConfirmEndTitle => 'End detox early?';

  @override
  String get detoxConfirmEndContent =>
      'Sure you want to stop the session? No judgment — sometimes stopping to learn is fine too.';

  @override
  String get detoxConfirmEndContinue => 'Keep going';

  @override
  String get detoxConfirmEndConfirm => 'End';

  @override
  String get detoxSetupTitle => 'Start detox';

  @override
  String get detoxSetupStep1 => '1. Pick a duration';

  @override
  String get detoxSetupStep2 => '2. Strictness';

  @override
  String get detoxSetupStep3 => '3. Apps to block';

  @override
  String get detoxSetupStep4 => '4. Why do you want to detox?';

  @override
  String get detoxSetupReasonSubtitle =>
      'Important — we\'ll show this back when you want to relapse.';

  @override
  String get detoxSetupReasonHint =>
      'E.g. To sleep better, have time to read, stop being interrupted all day...';

  @override
  String detoxSetupStartCta(int days) {
    return 'Start $days-day detox';
  }

  @override
  String get detoxSetupStartedSnackbar => 'Detox started — hold steady';

  @override
  String get detoxSetupReasonRequiredSnackbar =>
      'Write a quick reason — we\'ll use it when you want to relapse';

  @override
  String get detoxDuration24hLabel => '24 hours';

  @override
  String get detoxDuration24hSub => 'Beginner';

  @override
  String get detoxDuration7dLabel => '7 days';

  @override
  String get detoxDuration7dSub => 'Recommended';

  @override
  String get detoxDuration30dLabel => '30 days';

  @override
  String get detoxDuration30dSub => 'Hardcore';

  @override
  String get detoxStrictnessLight => 'Light';

  @override
  String get detoxStrictnessMedium => 'Medium';

  @override
  String get detoxStrictnessHard => 'Hard';

  @override
  String get detoxStrictnessLightDesc =>
      'Light: just a reminder when you open cheap apps. You can still use them.';

  @override
  String get detoxStrictnessMediumDesc =>
      'Medium: block by default + intervention popup every time. Has escape hatch.';

  @override
  String get detoxStrictnessHardDesc =>
      'Hard: blocks cheap apps fully. 20s wait escape hatch if you really need it.';

  @override
  String get emergencyTitle => 'Breathe. You\'re not alone.';

  @override
  String get emergencySubtitle =>
      'The feeling will pass — cravings usually last 15-20 minutes on average.';

  @override
  String get emergencyNotFailureText =>
      'Cravings are the signal your receptors are healing — this isn\'t failure, it\'s part of the process.';

  @override
  String get emergencyYourReasonLabel => 'WHY YOU STARTED';

  @override
  String get emergencyTryNowLabel => 'TRY NOW';

  @override
  String get emergencyActionWaterTitle => 'Drink a glass of water';

  @override
  String get emergencyActionWaterDesc => 'A small change breaks the loop';

  @override
  String get emergencyActionExerciseTitle => '10 jumping jacks';

  @override
  String get emergencyActionExerciseDesc => 'Natural dopamine boost in 30s';

  @override
  String get emergencyActionBuddyTitle => 'Call your buddy';

  @override
  String get emergencyActionBuddyDesc => 'You don\'t have to fight this alone';

  @override
  String get emergencyReflectionLabel => 'REFLECT';

  @override
  String get emergencyReflectionQuestion => 'What are you actually feeling?';

  @override
  String get emergencyReflectionDesc =>
      'Tired? Lonely? Bored? Anxious? Cravings are often the signal of another need — not a dopamine deficit.';

  @override
  String get breathingInhale => 'Inhale';

  @override
  String get breathingHold => 'Hold';

  @override
  String get breathingExhale => 'Exhale';

  @override
  String get interventionClose => 'Close';

  @override
  String get interventionTitle => 'Hold on 👋';

  @override
  String interventionSubtitle(String app) {
    return 'You were about to open $app for the 4th time this hour.';
  }

  @override
  String get interventionTodayLabel => 'TODAY';

  @override
  String get interventionTryLabel => 'TRY INSTEAD';

  @override
  String get interventionSuggestionWalkTitle => 'Short walk';

  @override
  String get interventionSuggestionWalkDuration => '10 min';

  @override
  String get interventionSuggestionPodcastTitle => 'Listen to a podcast';

  @override
  String get interventionSuggestionPodcastDuration => '15 min';

  @override
  String get interventionSuggestionJournalTitle => 'Write in journal';

  @override
  String get interventionSuggestionJournalDuration => '5 min';

  @override
  String interventionOpenAnyway(String app) {
    return 'Open $app anyway';
  }

  @override
  String interventionOpenAnywayWait(String app) {
    return 'Open $app anyway (wait 20s)';
  }

  @override
  String interventionWaitSeconds(int seconds) {
    return 'Wait ${seconds}s…';
  }

  @override
  String onboardingStepIndicator(int step, int total) {
    return '$step/$total';
  }

  @override
  String get onboardingFinishCta => 'Start using';

  @override
  String get onboardingStep1Title => 'Welcome to\nDopamine Diary';

  @override
  String get onboardingStep1Desc =>
      'An app that helps you balance cheap dopamine (TikTok, Reels) with healthy dopamine (exercise, reading, deep work) — without judgment, and without becoming addictive itself.';

  @override
  String get onboardingStep1SetupTime => 'About 2 minutes to set up';

  @override
  String get onboardingStep2Title => 'Not all dopamine\nis bad';

  @override
  String get onboardingStep2Desc =>
      'Your body needs dopamine — it\'s the signal of joy, learning, connection. The problem only shows up when \"cheap dopamine\" (10 seconds, infinite, effortless) overrides \"healthy dopamine\" (effortful, meaningful).';

  @override
  String get tierExampleCheap => 'TikTok, Reels, mindless scrolling';

  @override
  String get tierExampleMedium => 'Movies, snacks, social meetups';

  @override
  String get tierExampleHealthy => 'Exercise, walking, cooking';

  @override
  String get tierExampleDeep => 'Reading, learning, coding, writing';

  @override
  String get onboardingStep3Title => 'Classify your own way';

  @override
  String get onboardingStep3Desc =>
      'Drag (or tap to pick) — the default tiers don\'t fit everyone. TikTok for a creator is work, not cheap dopamine.';

  @override
  String get onboardingDragHere => 'Drag here';

  @override
  String get onboardingReassignQuestion => 'Move to which tier?';

  @override
  String get onboardingStep4Title => '10 seconds a day';

  @override
  String get onboardingStep4Desc =>
      'You don\'t need to track everything. Each evening, open the app and quickly log what you did — a few seconds. Dopamine Diary computes scores, patterns, and gentle nudges.';

  @override
  String get onboardingBulletPrivacy => 'Data stays on your device, encrypted';

  @override
  String get onboardingBulletNoNotifications =>
      'No noisy notifications, no red badges';

  @override
  String get onboardingBulletEmpathy =>
      'Empathetic tone, no judgment on relapse';

  @override
  String get onboardingStep5Title => 'All set';

  @override
  String get onboardingStep5Desc =>
      'You can adjust tiers anytime in \"Me\" → \"Activity classification\".';

  @override
  String get buddyTitle => 'Buddy';

  @override
  String get buddyMockName => 'Linh N.';

  @override
  String get buddyOnlineStatus => 'Online · same 7-day detox goal';

  @override
  String get buddyTodayLabel => 'TODAY';

  @override
  String get buddyYourScoreLabel => 'You';

  @override
  String get buddyNotCompetitionNote =>
      'Not a competition — just support together';

  @override
  String get buddyFeedSection => 'THEIR JOURNAL';

  @override
  String get buddyFeedRun => 'Linh just ran 5km';

  @override
  String get buddyFeedRead => 'Linh read for 45 minutes';

  @override
  String get buddyFeedNeedSupport => 'Linh needs support — about to relapse';

  @override
  String buddyTimeMinutesAgo(int n) {
    return '$n min ago';
  }

  @override
  String buddyTimeHoursAgo(int n) {
    return '$n h ago';
  }

  @override
  String get buddySendEncouragement => 'Send encouragement';

  @override
  String get buddyInviteCta => 'Invite another buddy';

  @override
  String get buddyInviteUnavailable =>
      'Buddy invites will come in a future release';

  @override
  String get buddySheetTitle => 'Send to Linh';

  @override
  String get buddySheetSubtitle => 'Pick a message — it\'ll send right away';

  @override
  String get buddyMessage1 => 'You\'re doing great — I believe in you';

  @override
  String get buddyMessage2 => 'This feeling will pass, I\'m here';

  @override
  String get buddyMessage3 => 'Drink some water, walk 5 minutes first';

  @override
  String get buddyMessage4 => 'I\'ve been there too, it\'s okay';

  @override
  String get buddyMessageSent => 'Encouragement sent 💜';

  @override
  String get settingsTitle => 'Me';

  @override
  String get settingsProfileName => 'You';

  @override
  String get settingsProfileMemberSince => 'Member since May, 2026';

  @override
  String get settingsSectionCustomize => 'CUSTOMIZE';

  @override
  String get settingsSectionThreshold => 'ALERT THRESHOLD';

  @override
  String get settingsSectionBlockedApps => 'BLOCKED APPS';

  @override
  String get settingsSectionAbout => 'ABOUT';

  @override
  String get settingsSectionLanguage => 'LANGUAGE';

  @override
  String get settingsTileTierClassification => 'Activity classification';

  @override
  String get settingsTileTierClassificationSub =>
      'Adjust tier for each activity type';

  @override
  String get settingsTileBuddy => 'Buddy';

  @override
  String get settingsTileBuddySub => 'Accountability partner';

  @override
  String get settingsTilePrivacy => 'Privacy';

  @override
  String get settingsTilePrivacySub => 'Encrypted and stored locally on device';

  @override
  String get settingsTileAbout => 'About Dopamine Diary';

  @override
  String get settingsTileAboutSub => 'Version 0.1.0 · MVP';

  @override
  String get settingsPrivacySnackbar =>
      'All data is stored in Hive on-device, never uploaded';

  @override
  String get settingsAboutSnackbar => 'Dopamine Diary v0.1.0';

  @override
  String get settingsThresholdLabel => 'Cheap dopamine max/day';

  @override
  String settingsThresholdValue(String hours) {
    return '${hours}h';
  }

  @override
  String get settingsThresholdDesc =>
      'When you exceed it, Dopamine Diary nudges softly — never hard-blocks.';

  @override
  String get settingsLanguageVietnamese => 'Tiếng Việt';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get authLoginTitle => 'Log in';

  @override
  String get authSignupTitle => 'Sign up';

  @override
  String get authEmailHint => 'Email';

  @override
  String get authPasswordHint => 'Password';

  @override
  String get authNameHint => 'Name';

  @override
  String get authLoginCta => 'Log in';

  @override
  String get authSignupCta => 'Create account';

  @override
  String get authToSignup => 'No account? Sign up';

  @override
  String get authToLogin => 'Already have an account? Log in';

  @override
  String get authMissingFields => 'Please fill all fields';
}
