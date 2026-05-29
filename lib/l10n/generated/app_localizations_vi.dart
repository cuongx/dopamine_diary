// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Dopamine Diary';

  @override
  String get navHome => 'Hôm nay';

  @override
  String get navAnalytics => 'Phân tích';

  @override
  String get navDetox => 'Detox';

  @override
  String get navMe => 'Của tôi';

  @override
  String get tierCheap => 'Rẻ tiền';

  @override
  String get tierMedium => 'Trung bình';

  @override
  String get tierHealthy => 'Lành mạnh';

  @override
  String get tierDeep => 'Deep work';

  @override
  String get weekdayMon => 'T2';

  @override
  String get weekdayTue => 'T3';

  @override
  String get weekdayWed => 'T4';

  @override
  String get weekdayThu => 'T5';

  @override
  String get weekdayFri => 'T6';

  @override
  String get weekdaySat => 'T7';

  @override
  String get weekdaySun => 'CN';

  @override
  String get commonRetry => 'Thử lại';

  @override
  String get commonClose => 'Đóng';

  @override
  String get commonCancel => 'Hủy';

  @override
  String get commonSave => 'Lưu';

  @override
  String get commonEdit => 'Sửa';

  @override
  String get commonContinue => 'Tiếp tục';

  @override
  String get commonBack => 'Quay lại';

  @override
  String get commonStart => 'Bắt đầu';

  @override
  String get commonStop => 'Dừng';

  @override
  String get commonError => 'Có lỗi';

  @override
  String durationMinutes(int n) {
    return '${n}p';
  }

  @override
  String durationHours(int n) {
    return '${n}h';
  }

  @override
  String durationHoursMinutes(int h, int m) {
    return '${h}h${m}p';
  }

  @override
  String durationDaysHours(int d, int h) {
    return '${d}d ${h}h';
  }

  @override
  String durationDaysHoursShort(int d, int h) {
    return '${d}n ${h}h';
  }

  @override
  String durationHoursMinShort(int h, int m) {
    return '${h}h ${m}p';
  }

  @override
  String minutesValue(int n) {
    return '$n phút';
  }

  @override
  String get homeGreetingMorning => 'Chào buổi sáng';

  @override
  String get homeGreetingAfternoon => 'Chào buổi chiều';

  @override
  String get homeGreetingEvening => 'Chào buổi tối';

  @override
  String get homeErrorTitle => 'Có gì đó chưa ổn';

  @override
  String get homeQuickLogCta => 'Ghi nhanh hoạt động';

  @override
  String get homeTodayDistribution => 'PHÂN BỔ HÔM NAY';

  @override
  String homeTodayMinutes(int n) {
    return '$n phút';
  }

  @override
  String get homeRecentSection => 'Gần đây';

  @override
  String get homeScoreExcellent => 'Xuất sắc';

  @override
  String get homeScoreBalanced => 'Cân bằng tốt';

  @override
  String get homeScoreOk => 'Khá ổn';

  @override
  String get homeScoreAdjust => 'Cần điều chỉnh';

  @override
  String get homeScoreAttention => 'Cần chú ý';

  @override
  String get homeDeltaSame => 'Bằng hôm qua';

  @override
  String homeDeltaCompare(String sign, int delta) {
    return '$sign$delta so với hôm qua';
  }

  @override
  String homeStreakDays(int days) {
    return 'Chuỗi $days ngày';
  }

  @override
  String get homeStreakSubtitle => 'Đang giữ phong độ cân bằng';

  @override
  String get homeDetoxBannerTitle => 'Đang detox';

  @override
  String homeDetoxBannerRemaining(String remaining, int total) {
    return 'Còn $remaining / $total ngày';
  }

  @override
  String get homeDetoxExpired => 'đã hết hạn';

  @override
  String get homeEmptyTodayTitle => 'Chưa có hoạt động nào hôm nay';

  @override
  String get homeEmptyTodaySubtitle => 'Tap \"Ghi nhanh\" để bắt đầu';

  @override
  String get homeScoreSlashHundred => '/100';

  @override
  String get emptyStateRetry => 'Thử lại';

  @override
  String get quickLogTitle => 'Ghi nhanh';

  @override
  String get quickLogQuestion => 'Bạn vừa làm gì?';

  @override
  String get quickLogSubtitle => 'Ghi nhanh trong 3 giây';

  @override
  String get quickLogRecentSection => 'Gần đây · tap để lặp lại';

  @override
  String get quickLogActivitiesSection => 'Hoạt động';

  @override
  String get quickLogVoiceCta => 'Ghi bằng giọng nói';

  @override
  String get durationSheetQuestion => 'Đã làm bao lâu?';

  @override
  String durationSheetSaveLabel(String duration) {
    return 'Lưu ($duration)';
  }

  @override
  String get voiceLogTitle => 'Ghi bằng giọng nói';

  @override
  String voiceLogListening(String time) {
    return 'Đang nghe… $time';
  }

  @override
  String get voiceLogTapToStart => 'Tap mic để bắt đầu';

  @override
  String get voiceLogDone => 'Đã ghi xong';

  @override
  String get voiceLogTapToStop => 'Tap lại để dừng';

  @override
  String get voiceLogReviewSubtitle => 'Xem lại transcript bên dưới và lưu';

  @override
  String get voiceLogExample => 'Ví dụ: \"Sáng nay mình chạy 30 phút\"';

  @override
  String get voiceLogReRecord => 'Ghi lại';

  @override
  String get voiceLogSave => 'Lưu';

  @override
  String get voiceLogTranscriptLabel => 'TRANSCRIPT';

  @override
  String get voiceLogAiUnderstoodLabel => 'AI ĐÃ HIỂU LÀ';

  @override
  String get voiceLogMockTranscript =>
      'Sáng nay mình chạy bộ 30 phút ở công viên, cảm thấy khá ổn.';

  @override
  String get voiceLogMockActivity => 'Chạy bộ';

  @override
  String voiceLogMoodChip(String mood) {
    return 'Mood $mood';
  }

  @override
  String get analyticsTitle => 'Phân tích';

  @override
  String get analyticsErrorTitle => 'Không tải được dữ liệu';

  @override
  String get analyticsScore7Days => 'SCORE 7 NGÀY';

  @override
  String get analyticsMetricCheap => 'Dopamine rẻ tuần';

  @override
  String get analyticsMetricDeep => 'Deep work tuần';

  @override
  String get analyticsInsightWeekendTitle =>
      'Cuối tuần điểm thấp hơn ngày thường';

  @override
  String get analyticsInsightWeekendDesc =>
      'Có vẻ thứ 7 chủ nhật bạn dành nhiều thời gian cho dopamine rẻ. Hãy thử lên kế hoạch một hoạt động sâu cuối tuần này.';

  @override
  String get analyticsInsightExerciseTitle =>
      'Ngày bạn tập thể dục có score cao hơn';

  @override
  String get analyticsInsightExerciseDesc =>
      'Các ngày bạn log \"Đi bộ\" hoặc \"Tập gym\", score trung bình cao hơn 18% so với ngày bình thường.';

  @override
  String get analyticsWeeklyReviewCta => 'Xem tổng kết tuần';

  @override
  String get insightLabelAi => 'AI GỢI Ý';

  @override
  String get insightLabelPattern => 'PATTERN';

  @override
  String weeklyReviewWeekLabel(int week, int year) {
    return 'TUẦN $week · $year';
  }

  @override
  String get weeklyReviewTitle => 'Tuần của bạn';

  @override
  String get weeklyReviewReclaimedLabel => 'Bạn đã giành lại';

  @override
  String get weeklyReviewReclaimedFrom =>
      'từ short video so với mức trung bình';

  @override
  String get weeklyReviewHighlightsLabel => 'HIGHLIGHTS';

  @override
  String get weeklyReviewPatternLabel => 'PATTERN ĐÃ HỌC';

  @override
  String get weeklyReviewPatternDesc =>
      'Ngày bạn tập thể dục → score cao hơn 34%. Đó là đòn bẩy lớn nhất của tuần này. Giữ vững nhịp tập thể dục là cách rẻ nhất để cân bằng dopamine.';

  @override
  String get weeklyReviewGoalsLabel => 'MỤC TIÊU TUẦN SAU';

  @override
  String get weeklyReviewGoal1 => 'Giữ ≥ 4 ngày tập thể dục';

  @override
  String weeklyReviewGoal2(String day) {
    return 'Ngày tốt nhất: $day — lặp lại routine';
  }

  @override
  String get weeklyReviewGoal3 => 'Dopamine rẻ ≤ 1h45p/ngày';

  @override
  String get weeklyReviewShareCta => 'Chia sẻ với bạn bè';

  @override
  String get weeklyReviewShareUnavailable =>
      'Tính năng chia sẻ sẽ có ở bản sau';

  @override
  String weeklyReviewHighlightExercise(int done, int total) {
    return 'Tập thể dục $done/$total ngày';
  }

  @override
  String weeklyReviewHighlightDeep(String duration) {
    return 'Deep work $duration cả tuần';
  }

  @override
  String weeklyReviewHighlightScore(int avg) {
    return 'Score trung bình $avg/100';
  }

  @override
  String get detoxTitle => 'Detox';

  @override
  String get detoxIdleTitle => 'Reset dopamine của bạn';

  @override
  String get detoxIdleDesc =>
      'Một phiên detox 24h, 7 ngày, hoặc 30 ngày để receptor dopamine phục hồi. Tạm xa short video, mạng xã hội — thay bằng đọc, tập thể dục, gặp người thật.';

  @override
  String get detoxIdleStartCta => 'Bắt đầu detox';

  @override
  String get detoxRunningHeader => 'DETOX MODE · ĐANG RESET';

  @override
  String detoxRunningSubtitle(int totalDays) {
    return 'còn lại / $totalDays ngày';
  }

  @override
  String get detoxReasonLabel => 'TẠI SAO BẠN DETOX';

  @override
  String get detoxBlockedLabel => 'ĐANG CHẶN';

  @override
  String get detoxQuoteText =>
      '\"Cảm giác khó chịu khi cai dopamine rẻ chính là dấu hiệu receptor đang hồi phục. Hãy ở lại với nó.\"';

  @override
  String get detoxQuoteAuthor => '— Anna Lembke, Dopamine Nation';

  @override
  String get detoxEmergencyCta => 'Tôi đang muốn relapse — giúp tôi';

  @override
  String get detoxEndEarly => 'Kết thúc sớm';

  @override
  String get detoxConfirmEndTitle => 'Kết thúc detox sớm?';

  @override
  String get detoxConfirmEndContent =>
      'Bạn có chắc muốn dừng phiên detox? Không phán xét gì — đôi khi dừng để học cũng là tốt.';

  @override
  String get detoxConfirmEndContinue => 'Tiếp tục detox';

  @override
  String get detoxConfirmEndConfirm => 'Kết thúc';

  @override
  String get detoxSetupTitle => 'Bắt đầu detox';

  @override
  String get detoxSetupStep1 => '1. Chọn độ dài';

  @override
  String get detoxSetupStep2 => '2. Độ nghiêm khắc';

  @override
  String get detoxSetupStep3 => '3. Apps cần chặn';

  @override
  String get detoxSetupStep4 => '4. Tại sao bạn muốn detox?';

  @override
  String get detoxSetupReasonSubtitle =>
      'Quan trọng — sẽ dùng để nhắc bạn khi muốn relapse.';

  @override
  String get detoxSetupReasonHint =>
      'Vd: Muốn ngủ ngon hơn, có thời gian đọc sách, không bị giật thông báo cả ngày...';

  @override
  String detoxSetupStartCta(int days) {
    return 'Bắt đầu $days ngày detox';
  }

  @override
  String get detoxSetupStartedSnackbar => 'Detox đã bắt đầu — giữ vững nhé';

  @override
  String get detoxSetupReasonRequiredSnackbar =>
      'Hãy viết một câu lý do — sẽ dùng để nhắc bạn khi muốn relapse';

  @override
  String get detoxDuration24hLabel => '24 giờ';

  @override
  String get detoxDuration24hSub => 'Beginner';

  @override
  String get detoxDuration7dLabel => '7 ngày';

  @override
  String get detoxDuration7dSub => 'Đề xuất';

  @override
  String get detoxDuration30dLabel => '30 ngày';

  @override
  String get detoxDuration30dSub => 'Hardcore';

  @override
  String get detoxStrictnessLight => 'Nhẹ';

  @override
  String get detoxStrictnessMedium => 'Vừa';

  @override
  String get detoxStrictnessHard => 'Cứng';

  @override
  String get detoxStrictnessLightDesc =>
      'Nhẹ: chỉ nhắc nhở khi mở app cheap. Vẫn có thể dùng nếu muốn.';

  @override
  String get detoxStrictnessMediumDesc =>
      'Vừa: chặn mặc định + intervention popup mỗi lần mở. Có escape hatch.';

  @override
  String get detoxStrictnessHardDesc =>
      'Cứng: chặn app cheap hoàn toàn. Có escape hatch chờ 20s nếu thật sự cần.';

  @override
  String get emergencyTitle => 'Hít thở. Bạn không cô đơn.';

  @override
  String get emergencySubtitle =>
      'Cảm giác sẽ qua — trung bình cravings chỉ kéo dài 15-20 phút.';

  @override
  String get emergencyNotFailureText =>
      'Cravings là tín hiệu receptor đang hồi phục — đây không phải thất bại, mà là một phần của quá trình.';

  @override
  String get emergencyYourReasonLabel => 'LÝ DO BẠN BẮT ĐẦU';

  @override
  String get emergencyTryNowLabel => 'THỬ NGAY';

  @override
  String get emergencyActionWaterTitle => 'Uống một cốc nước';

  @override
  String get emergencyActionWaterDesc => 'Sự thay đổi nhỏ phá vỡ vòng lặp';

  @override
  String get emergencyActionExerciseTitle => '10 cái jumping jack';

  @override
  String get emergencyActionExerciseDesc => 'Nâng dopamine tự nhiên trong 30s';

  @override
  String get emergencyActionBuddyTitle => 'Gọi buddy';

  @override
  String get emergencyActionBuddyDesc => 'Bạn không phải tự mình chống cự';

  @override
  String get emergencyReflectionLabel => 'PHẢN CHIẾU';

  @override
  String get emergencyReflectionQuestion => 'Bạn thực sự đang cảm thấy gì?';

  @override
  String get emergencyReflectionDesc =>
      'Mệt? Cô đơn? Chán? Lo lắng? Cravings thường là tín hiệu cho một nhu cầu khác — không phải thiếu dopamine.';

  @override
  String get breathingInhale => 'Hít vào';

  @override
  String get breathingHold => 'Giữ';

  @override
  String get breathingExhale => 'Thở ra';

  @override
  String get interventionClose => 'Đóng';

  @override
  String get interventionTitle => 'Khoan đã 👋';

  @override
  String interventionSubtitle(String app) {
    return 'Bạn vừa định mở $app lần thứ 4 trong giờ qua.';
  }

  @override
  String get interventionTodayLabel => 'HÔM NAY';

  @override
  String get interventionTryLabel => 'THỬ THAY BẰNG';

  @override
  String get interventionSuggestionWalkTitle => 'Đi bộ ngắn';

  @override
  String get interventionSuggestionWalkDuration => '10 phút';

  @override
  String get interventionSuggestionPodcastTitle => 'Nghe podcast';

  @override
  String get interventionSuggestionPodcastDuration => '15 phút';

  @override
  String get interventionSuggestionJournalTitle => 'Viết journal';

  @override
  String get interventionSuggestionJournalDuration => '5 phút';

  @override
  String interventionOpenAnyway(String app) {
    return 'Vẫn muốn mở $app';
  }

  @override
  String interventionOpenAnywayWait(String app) {
    return 'Vẫn muốn mở $app (chờ 20s)';
  }

  @override
  String interventionWaitSeconds(int seconds) {
    return 'Chờ ${seconds}s…';
  }

  @override
  String onboardingStepIndicator(int step, int total) {
    return '$step/$total';
  }

  @override
  String get onboardingFinishCta => 'Bắt đầu sử dụng';

  @override
  String get onboardingStep1Title => 'Chào mừng đến với\nDopamine Diary';

  @override
  String get onboardingStep1Desc =>
      'Một app giúp bạn cân bằng giữa dopamine rẻ tiền (TikTok, Reels) và dopamine lành mạnh (tập thể dục, đọc, deep work) — không phán xét, không gây nghiện chính nó.';

  @override
  String get onboardingStep1SetupTime => 'Mất ~2 phút để setup';

  @override
  String get onboardingStep2Title => 'Không phải mọi\ndopamine đều xấu';

  @override
  String get onboardingStep2Desc =>
      'Cơ thể bạn cần dopamine — nó là tín hiệu của niềm vui, học tập, kết nối. Vấn đề chỉ xuất hiện khi \"dopamine rẻ\" (10s, vô hạn, không nỗ lực) lấn át \"dopamine lành\" (cần nỗ lực, mang lại ý nghĩa).';

  @override
  String get tierExampleCheap => 'TikTok, Reels, lướt vô thức';

  @override
  String get tierExampleMedium => 'Xem phim, ăn vặt, gặp xã giao';

  @override
  String get tierExampleHealthy => 'Tập thể dục, đi bộ, nấu ăn';

  @override
  String get tierExampleDeep => 'Đọc sách, học, code, viết';

  @override
  String get onboardingStep3Title => 'Phân loại theo BẠN';

  @override
  String get onboardingStep3Desc =>
      'Kéo thả (hoặc tap để chọn) — tier mặc định không hợp với mọi người. TikTok với creator chuyên nghiệp là công việc, không phải dopamine rẻ.';

  @override
  String get onboardingDragHere => 'Kéo thả vào đây';

  @override
  String get onboardingReassignQuestion => 'Chuyển sang tier nào?';

  @override
  String get onboardingStep4Title => 'Mỗi ngày 10 giây';

  @override
  String get onboardingStep4Desc =>
      'Bạn không cần track mọi thứ. Mỗi tối, mở app, ghi nhanh những gì đã làm — vài giây thôi. Dopamine Diary sẽ tính score, pattern, gợi ý điều chỉnh nhẹ nhàng.';

  @override
  String get onboardingBulletPrivacy =>
      'Dữ liệu lưu cục bộ trên máy bạn, mã hoá';

  @override
  String get onboardingBulletNoNotifications =>
      'Không notification giật gân, không badge đỏ';

  @override
  String get onboardingBulletEmpathy =>
      'Tone đồng cảm, không phán xét khi relapse';

  @override
  String get onboardingStep5Title => 'Setup xong';

  @override
  String get onboardingStep5Desc =>
      'Bạn có thể chỉnh lại tier bất cứ lúc nào trong \"Của tôi\" → \"Phân loại hoạt động\".';

  @override
  String get buddyTitle => 'Buddy';

  @override
  String get buddyMockName => 'Linh N.';

  @override
  String get buddyOnlineStatus => 'Online · cùng goal detox 7 ngày';

  @override
  String get buddyTodayLabel => 'HÔM NAY';

  @override
  String get buddyYourScoreLabel => 'Bạn';

  @override
  String get buddyNotCompetitionNote =>
      'Không phải thi đua — đây là support cùng nhau';

  @override
  String get buddyFeedSection => 'NHẬT KÝ CỦA BẠN ẤY';

  @override
  String get buddyFeedRun => 'Linh vừa chạy 5km';

  @override
  String get buddyFeedRead => 'Linh đọc sách 45 phút';

  @override
  String get buddyFeedNeedSupport => 'Linh cần động viên — đang muốn relapse';

  @override
  String buddyTimeMinutesAgo(int n) {
    return '$n phút trước';
  }

  @override
  String buddyTimeHoursAgo(int n) {
    return '$n giờ trước';
  }

  @override
  String get buddySendEncouragement => 'Gửi lời động viên';

  @override
  String get buddyInviteCta => 'Mời thêm buddy';

  @override
  String get buddyInviteUnavailable => 'Tính năng mời buddy sẽ có ở bản sau';

  @override
  String get buddySheetTitle => 'Gửi cho Linh';

  @override
  String get buddySheetSubtitle => 'Chọn message — sẽ gửi ngay tới buddy';

  @override
  String get buddyMessage1 => 'Bạn đang làm tốt — mình tin bạn';

  @override
  String get buddyMessage2 => 'Cảm giác này sẽ qua, mình ở đây';

  @override
  String get buddyMessage3 => 'Hãy uống nước, đi bộ 5 phút trước nhé';

  @override
  String get buddyMessage4 => 'Mình cũng từng vậy, không sao đâu';

  @override
  String get buddyMessageSent => 'Đã gửi lời động viên 💜';

  @override
  String get settingsTitle => 'Của tôi';

  @override
  String get settingsProfileName => 'Bạn';

  @override
  String get settingsProfileMemberSince => 'Thành viên từ tháng 5, 2026';

  @override
  String get settingsSectionCustomize => 'TUỲ CHỈNH';

  @override
  String get settingsSectionThreshold => 'NGƯỠNG CẢNH BÁO';

  @override
  String get settingsSectionBlockedApps => 'CHẶN ỨNG DỤNG';

  @override
  String get settingsSectionAbout => 'VỀ APP';

  @override
  String get settingsSectionLanguage => 'NGÔN NGỮ';

  @override
  String get settingsTileTierClassification => 'Phân loại hoạt động';

  @override
  String get settingsTileTierClassificationSub =>
      'Chỉnh tier cho từng activity type';

  @override
  String get settingsTileBuddy => 'Buddy';

  @override
  String get settingsTileBuddySub => 'Accountability partner';

  @override
  String get settingsTilePrivacy => 'Quyền riêng tư';

  @override
  String get settingsTilePrivacySub => 'Dữ liệu mã hoá và lưu cục bộ trên máy';

  @override
  String get settingsTileAbout => 'Về Dopamine Diary';

  @override
  String get settingsTileAboutSub => 'Phiên bản 0.1.0 · MVP';

  @override
  String get settingsPrivacySnackbar =>
      'Toàn bộ dữ liệu lưu trong Hive trên thiết bị, không upload';

  @override
  String get settingsAboutSnackbar => 'Dopamine Diary v0.1.0';

  @override
  String get settingsThresholdLabel => 'Dopamine rẻ tối đa/ngày';

  @override
  String settingsThresholdValue(String hours) {
    return '${hours}h';
  }

  @override
  String get settingsThresholdDesc =>
      'Khi vượt ngưỡng, Dopamine Diary sẽ gợi ý nhẹ — không chặn cứng.';

  @override
  String get settingsLanguageVietnamese => 'Tiếng Việt';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSystem => 'Theo hệ thống';

  @override
  String get authLoginTitle => 'Đăng nhập';

  @override
  String get authSignupTitle => 'Đăng ký';

  @override
  String get authEmailHint => 'Email';

  @override
  String get authPasswordHint => 'Mật khẩu';

  @override
  String get authNameHint => 'Tên';

  @override
  String get authLoginCta => 'Đăng nhập';

  @override
  String get authSignupCta => 'Tạo tài khoản';

  @override
  String get authToSignup => 'Chưa có tài khoản? Đăng ký';

  @override
  String get authToLogin => 'Đã có tài khoản? Đăng nhập';

  @override
  String get authMissingFields => 'Vui lòng điền đầy đủ các trường';
}
