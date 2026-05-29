import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @appName.
  ///
  /// In vi, this message translates to:
  /// **'Dopamine Diary'**
  String get appName;

  /// No description provided for @navHome.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay'**
  String get navHome;

  /// No description provided for @navAnalytics.
  ///
  /// In vi, this message translates to:
  /// **'Phân tích'**
  String get navAnalytics;

  /// No description provided for @navDetox.
  ///
  /// In vi, this message translates to:
  /// **'Detox'**
  String get navDetox;

  /// No description provided for @navMe.
  ///
  /// In vi, this message translates to:
  /// **'Của tôi'**
  String get navMe;

  /// No description provided for @tierCheap.
  ///
  /// In vi, this message translates to:
  /// **'Rẻ tiền'**
  String get tierCheap;

  /// No description provided for @tierMedium.
  ///
  /// In vi, this message translates to:
  /// **'Trung bình'**
  String get tierMedium;

  /// No description provided for @tierHealthy.
  ///
  /// In vi, this message translates to:
  /// **'Lành mạnh'**
  String get tierHealthy;

  /// No description provided for @tierDeep.
  ///
  /// In vi, this message translates to:
  /// **'Deep work'**
  String get tierDeep;

  /// No description provided for @weekdayMon.
  ///
  /// In vi, this message translates to:
  /// **'T2'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In vi, this message translates to:
  /// **'T3'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In vi, this message translates to:
  /// **'T4'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In vi, this message translates to:
  /// **'T5'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In vi, this message translates to:
  /// **'T6'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In vi, this message translates to:
  /// **'T7'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In vi, this message translates to:
  /// **'CN'**
  String get weekdaySun;

  /// No description provided for @commonRetry.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get commonRetry;

  /// No description provided for @commonClose.
  ///
  /// In vi, this message translates to:
  /// **'Đóng'**
  String get commonClose;

  /// No description provided for @commonCancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get commonSave;

  /// No description provided for @commonEdit.
  ///
  /// In vi, this message translates to:
  /// **'Sửa'**
  String get commonEdit;

  /// No description provided for @commonContinue.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get commonContinue;

  /// No description provided for @commonBack.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get commonBack;

  /// No description provided for @commonStart.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu'**
  String get commonStart;

  /// No description provided for @commonStop.
  ///
  /// In vi, this message translates to:
  /// **'Dừng'**
  String get commonStop;

  /// No description provided for @commonError.
  ///
  /// In vi, this message translates to:
  /// **'Có lỗi'**
  String get commonError;

  /// No description provided for @durationMinutes.
  ///
  /// In vi, this message translates to:
  /// **'{n}p'**
  String durationMinutes(int n);

  /// No description provided for @durationHours.
  ///
  /// In vi, this message translates to:
  /// **'{n}h'**
  String durationHours(int n);

  /// No description provided for @durationHoursMinutes.
  ///
  /// In vi, this message translates to:
  /// **'{h}h{m}p'**
  String durationHoursMinutes(int h, int m);

  /// No description provided for @durationDaysHours.
  ///
  /// In vi, this message translates to:
  /// **'{d}d {h}h'**
  String durationDaysHours(int d, int h);

  /// No description provided for @durationDaysHoursShort.
  ///
  /// In vi, this message translates to:
  /// **'{d}n {h}h'**
  String durationDaysHoursShort(int d, int h);

  /// No description provided for @durationHoursMinShort.
  ///
  /// In vi, this message translates to:
  /// **'{h}h {m}p'**
  String durationHoursMinShort(int h, int m);

  /// No description provided for @minutesValue.
  ///
  /// In vi, this message translates to:
  /// **'{n} phút'**
  String minutesValue(int n);

  /// No description provided for @homeGreetingMorning.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi sáng'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi chiều'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingEvening.
  ///
  /// In vi, this message translates to:
  /// **'Chào buổi tối'**
  String get homeGreetingEvening;

  /// No description provided for @homeErrorTitle.
  ///
  /// In vi, this message translates to:
  /// **'Có gì đó chưa ổn'**
  String get homeErrorTitle;

  /// No description provided for @homeQuickLogCta.
  ///
  /// In vi, this message translates to:
  /// **'Ghi nhanh hoạt động'**
  String get homeQuickLogCta;

  /// No description provided for @homeTodayDistribution.
  ///
  /// In vi, this message translates to:
  /// **'PHÂN BỔ HÔM NAY'**
  String get homeTodayDistribution;

  /// No description provided for @homeTodayMinutes.
  ///
  /// In vi, this message translates to:
  /// **'{n} phút'**
  String homeTodayMinutes(int n);

  /// No description provided for @homeRecentSection.
  ///
  /// In vi, this message translates to:
  /// **'Gần đây'**
  String get homeRecentSection;

  /// No description provided for @homeScoreExcellent.
  ///
  /// In vi, this message translates to:
  /// **'Xuất sắc'**
  String get homeScoreExcellent;

  /// No description provided for @homeScoreBalanced.
  ///
  /// In vi, this message translates to:
  /// **'Cân bằng tốt'**
  String get homeScoreBalanced;

  /// No description provided for @homeScoreOk.
  ///
  /// In vi, this message translates to:
  /// **'Khá ổn'**
  String get homeScoreOk;

  /// No description provided for @homeScoreAdjust.
  ///
  /// In vi, this message translates to:
  /// **'Cần điều chỉnh'**
  String get homeScoreAdjust;

  /// No description provided for @homeScoreAttention.
  ///
  /// In vi, this message translates to:
  /// **'Cần chú ý'**
  String get homeScoreAttention;

  /// No description provided for @homeDeltaSame.
  ///
  /// In vi, this message translates to:
  /// **'Bằng hôm qua'**
  String get homeDeltaSame;

  /// No description provided for @homeDeltaCompare.
  ///
  /// In vi, this message translates to:
  /// **'{sign}{delta} so với hôm qua'**
  String homeDeltaCompare(String sign, int delta);

  /// No description provided for @homeStreakDays.
  ///
  /// In vi, this message translates to:
  /// **'Chuỗi {days} ngày'**
  String homeStreakDays(int days);

  /// No description provided for @homeStreakSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Đang giữ phong độ cân bằng'**
  String get homeStreakSubtitle;

  /// No description provided for @homeDetoxBannerTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đang detox'**
  String get homeDetoxBannerTitle;

  /// No description provided for @homeDetoxBannerRemaining.
  ///
  /// In vi, this message translates to:
  /// **'Còn {remaining} / {total} ngày'**
  String homeDetoxBannerRemaining(String remaining, int total);

  /// No description provided for @homeDetoxExpired.
  ///
  /// In vi, this message translates to:
  /// **'đã hết hạn'**
  String get homeDetoxExpired;

  /// No description provided for @homeEmptyTodayTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có hoạt động nào hôm nay'**
  String get homeEmptyTodayTitle;

  /// No description provided for @homeEmptyTodaySubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Tap \"Ghi nhanh\" để bắt đầu'**
  String get homeEmptyTodaySubtitle;

  /// No description provided for @homeScoreSlashHundred.
  ///
  /// In vi, this message translates to:
  /// **'/100'**
  String get homeScoreSlashHundred;

  /// No description provided for @emptyStateRetry.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get emptyStateRetry;

  /// No description provided for @quickLogTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ghi nhanh'**
  String get quickLogTitle;

  /// No description provided for @quickLogQuestion.
  ///
  /// In vi, this message translates to:
  /// **'Bạn vừa làm gì?'**
  String get quickLogQuestion;

  /// No description provided for @quickLogSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Ghi nhanh trong 3 giây'**
  String get quickLogSubtitle;

  /// No description provided for @quickLogRecentSection.
  ///
  /// In vi, this message translates to:
  /// **'Gần đây · tap để lặp lại'**
  String get quickLogRecentSection;

  /// No description provided for @quickLogActivitiesSection.
  ///
  /// In vi, this message translates to:
  /// **'Hoạt động'**
  String get quickLogActivitiesSection;

  /// No description provided for @quickLogVoiceCta.
  ///
  /// In vi, this message translates to:
  /// **'Ghi bằng giọng nói'**
  String get quickLogVoiceCta;

  /// No description provided for @durationSheetQuestion.
  ///
  /// In vi, this message translates to:
  /// **'Đã làm bao lâu?'**
  String get durationSheetQuestion;

  /// No description provided for @durationSheetSaveLabel.
  ///
  /// In vi, this message translates to:
  /// **'Lưu ({duration})'**
  String durationSheetSaveLabel(String duration);

  /// No description provided for @voiceLogTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ghi bằng giọng nói'**
  String get voiceLogTitle;

  /// No description provided for @voiceLogListening.
  ///
  /// In vi, this message translates to:
  /// **'Đang nghe… {time}'**
  String voiceLogListening(String time);

  /// No description provided for @voiceLogTapToStart.
  ///
  /// In vi, this message translates to:
  /// **'Tap mic để bắt đầu'**
  String get voiceLogTapToStart;

  /// No description provided for @voiceLogDone.
  ///
  /// In vi, this message translates to:
  /// **'Đã ghi xong'**
  String get voiceLogDone;

  /// No description provided for @voiceLogTapToStop.
  ///
  /// In vi, this message translates to:
  /// **'Tap lại để dừng'**
  String get voiceLogTapToStop;

  /// No description provided for @voiceLogReviewSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Xem lại transcript bên dưới và lưu'**
  String get voiceLogReviewSubtitle;

  /// No description provided for @voiceLogExample.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ: \"Sáng nay mình chạy 30 phút\"'**
  String get voiceLogExample;

  /// No description provided for @voiceLogReRecord.
  ///
  /// In vi, this message translates to:
  /// **'Ghi lại'**
  String get voiceLogReRecord;

  /// No description provided for @voiceLogSave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get voiceLogSave;

  /// No description provided for @voiceLogTranscriptLabel.
  ///
  /// In vi, this message translates to:
  /// **'TRANSCRIPT'**
  String get voiceLogTranscriptLabel;

  /// No description provided for @voiceLogAiUnderstoodLabel.
  ///
  /// In vi, this message translates to:
  /// **'AI ĐÃ HIỂU LÀ'**
  String get voiceLogAiUnderstoodLabel;

  /// No description provided for @voiceLogMockTranscript.
  ///
  /// In vi, this message translates to:
  /// **'Sáng nay mình chạy bộ 30 phút ở công viên, cảm thấy khá ổn.'**
  String get voiceLogMockTranscript;

  /// No description provided for @voiceLogMockActivity.
  ///
  /// In vi, this message translates to:
  /// **'Chạy bộ'**
  String get voiceLogMockActivity;

  /// No description provided for @voiceLogMoodChip.
  ///
  /// In vi, this message translates to:
  /// **'Mood {mood}'**
  String voiceLogMoodChip(String mood);

  /// No description provided for @analyticsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Phân tích'**
  String get analyticsTitle;

  /// No description provided for @analyticsErrorTitle.
  ///
  /// In vi, this message translates to:
  /// **'Không tải được dữ liệu'**
  String get analyticsErrorTitle;

  /// No description provided for @analyticsScore7Days.
  ///
  /// In vi, this message translates to:
  /// **'SCORE 7 NGÀY'**
  String get analyticsScore7Days;

  /// No description provided for @analyticsMetricCheap.
  ///
  /// In vi, this message translates to:
  /// **'Dopamine rẻ tuần'**
  String get analyticsMetricCheap;

  /// No description provided for @analyticsMetricDeep.
  ///
  /// In vi, this message translates to:
  /// **'Deep work tuần'**
  String get analyticsMetricDeep;

  /// No description provided for @analyticsInsightWeekendTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cuối tuần điểm thấp hơn ngày thường'**
  String get analyticsInsightWeekendTitle;

  /// No description provided for @analyticsInsightWeekendDesc.
  ///
  /// In vi, this message translates to:
  /// **'Có vẻ thứ 7 chủ nhật bạn dành nhiều thời gian cho dopamine rẻ. Hãy thử lên kế hoạch một hoạt động sâu cuối tuần này.'**
  String get analyticsInsightWeekendDesc;

  /// No description provided for @analyticsInsightExerciseTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ngày bạn tập thể dục có score cao hơn'**
  String get analyticsInsightExerciseTitle;

  /// No description provided for @analyticsInsightExerciseDesc.
  ///
  /// In vi, this message translates to:
  /// **'Các ngày bạn log \"Đi bộ\" hoặc \"Tập gym\", score trung bình cao hơn 18% so với ngày bình thường.'**
  String get analyticsInsightExerciseDesc;

  /// No description provided for @analyticsWeeklyReviewCta.
  ///
  /// In vi, this message translates to:
  /// **'Xem tổng kết tuần'**
  String get analyticsWeeklyReviewCta;

  /// No description provided for @insightLabelAi.
  ///
  /// In vi, this message translates to:
  /// **'AI GỢI Ý'**
  String get insightLabelAi;

  /// No description provided for @insightLabelPattern.
  ///
  /// In vi, this message translates to:
  /// **'PATTERN'**
  String get insightLabelPattern;

  /// No description provided for @weeklyReviewWeekLabel.
  ///
  /// In vi, this message translates to:
  /// **'TUẦN {week} · {year}'**
  String weeklyReviewWeekLabel(int week, int year);

  /// No description provided for @weeklyReviewTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tuần của bạn'**
  String get weeklyReviewTitle;

  /// No description provided for @weeklyReviewReclaimedLabel.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã giành lại'**
  String get weeklyReviewReclaimedLabel;

  /// No description provided for @weeklyReviewReclaimedFrom.
  ///
  /// In vi, this message translates to:
  /// **'từ short video so với mức trung bình'**
  String get weeklyReviewReclaimedFrom;

  /// No description provided for @weeklyReviewHighlightsLabel.
  ///
  /// In vi, this message translates to:
  /// **'HIGHLIGHTS'**
  String get weeklyReviewHighlightsLabel;

  /// No description provided for @weeklyReviewPatternLabel.
  ///
  /// In vi, this message translates to:
  /// **'PATTERN ĐÃ HỌC'**
  String get weeklyReviewPatternLabel;

  /// No description provided for @weeklyReviewPatternDesc.
  ///
  /// In vi, this message translates to:
  /// **'Ngày bạn tập thể dục → score cao hơn 34%. Đó là đòn bẩy lớn nhất của tuần này. Giữ vững nhịp tập thể dục là cách rẻ nhất để cân bằng dopamine.'**
  String get weeklyReviewPatternDesc;

  /// No description provided for @weeklyReviewGoalsLabel.
  ///
  /// In vi, this message translates to:
  /// **'MỤC TIÊU TUẦN SAU'**
  String get weeklyReviewGoalsLabel;

  /// No description provided for @weeklyReviewGoal1.
  ///
  /// In vi, this message translates to:
  /// **'Giữ ≥ 4 ngày tập thể dục'**
  String get weeklyReviewGoal1;

  /// No description provided for @weeklyReviewGoal2.
  ///
  /// In vi, this message translates to:
  /// **'Ngày tốt nhất: {day} — lặp lại routine'**
  String weeklyReviewGoal2(String day);

  /// No description provided for @weeklyReviewGoal3.
  ///
  /// In vi, this message translates to:
  /// **'Dopamine rẻ ≤ 1h45p/ngày'**
  String get weeklyReviewGoal3;

  /// No description provided for @weeklyReviewShareCta.
  ///
  /// In vi, this message translates to:
  /// **'Chia sẻ với bạn bè'**
  String get weeklyReviewShareCta;

  /// No description provided for @weeklyReviewShareUnavailable.
  ///
  /// In vi, this message translates to:
  /// **'Tính năng chia sẻ sẽ có ở bản sau'**
  String get weeklyReviewShareUnavailable;

  /// No description provided for @weeklyReviewHighlightExercise.
  ///
  /// In vi, this message translates to:
  /// **'Tập thể dục {done}/{total} ngày'**
  String weeklyReviewHighlightExercise(int done, int total);

  /// No description provided for @weeklyReviewHighlightDeep.
  ///
  /// In vi, this message translates to:
  /// **'Deep work {duration} cả tuần'**
  String weeklyReviewHighlightDeep(String duration);

  /// No description provided for @weeklyReviewHighlightScore.
  ///
  /// In vi, this message translates to:
  /// **'Score trung bình {avg}/100'**
  String weeklyReviewHighlightScore(int avg);

  /// No description provided for @detoxTitle.
  ///
  /// In vi, this message translates to:
  /// **'Detox'**
  String get detoxTitle;

  /// No description provided for @detoxIdleTitle.
  ///
  /// In vi, this message translates to:
  /// **'Reset dopamine của bạn'**
  String get detoxIdleTitle;

  /// No description provided for @detoxIdleDesc.
  ///
  /// In vi, this message translates to:
  /// **'Một phiên detox 24h, 7 ngày, hoặc 30 ngày để receptor dopamine phục hồi. Tạm xa short video, mạng xã hội — thay bằng đọc, tập thể dục, gặp người thật.'**
  String get detoxIdleDesc;

  /// No description provided for @detoxIdleStartCta.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu detox'**
  String get detoxIdleStartCta;

  /// No description provided for @detoxRunningHeader.
  ///
  /// In vi, this message translates to:
  /// **'DETOX MODE · ĐANG RESET'**
  String get detoxRunningHeader;

  /// No description provided for @detoxRunningSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'còn lại / {totalDays} ngày'**
  String detoxRunningSubtitle(int totalDays);

  /// No description provided for @detoxReasonLabel.
  ///
  /// In vi, this message translates to:
  /// **'TẠI SAO BẠN DETOX'**
  String get detoxReasonLabel;

  /// No description provided for @detoxBlockedLabel.
  ///
  /// In vi, this message translates to:
  /// **'ĐANG CHẶN'**
  String get detoxBlockedLabel;

  /// No description provided for @detoxQuoteText.
  ///
  /// In vi, this message translates to:
  /// **'\"Cảm giác khó chịu khi cai dopamine rẻ chính là dấu hiệu receptor đang hồi phục. Hãy ở lại với nó.\"'**
  String get detoxQuoteText;

  /// No description provided for @detoxQuoteAuthor.
  ///
  /// In vi, this message translates to:
  /// **'— Anna Lembke, Dopamine Nation'**
  String get detoxQuoteAuthor;

  /// No description provided for @detoxEmergencyCta.
  ///
  /// In vi, this message translates to:
  /// **'Tôi đang muốn relapse — giúp tôi'**
  String get detoxEmergencyCta;

  /// No description provided for @detoxEndEarly.
  ///
  /// In vi, this message translates to:
  /// **'Kết thúc sớm'**
  String get detoxEndEarly;

  /// No description provided for @detoxConfirmEndTitle.
  ///
  /// In vi, this message translates to:
  /// **'Kết thúc detox sớm?'**
  String get detoxConfirmEndTitle;

  /// No description provided for @detoxConfirmEndContent.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc muốn dừng phiên detox? Không phán xét gì — đôi khi dừng để học cũng là tốt.'**
  String get detoxConfirmEndContent;

  /// No description provided for @detoxConfirmEndContinue.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục detox'**
  String get detoxConfirmEndContinue;

  /// No description provided for @detoxConfirmEndConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Kết thúc'**
  String get detoxConfirmEndConfirm;

  /// No description provided for @detoxSetupTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu detox'**
  String get detoxSetupTitle;

  /// No description provided for @detoxSetupStep1.
  ///
  /// In vi, this message translates to:
  /// **'1. Chọn độ dài'**
  String get detoxSetupStep1;

  /// No description provided for @detoxSetupStep2.
  ///
  /// In vi, this message translates to:
  /// **'2. Độ nghiêm khắc'**
  String get detoxSetupStep2;

  /// No description provided for @detoxSetupStep3.
  ///
  /// In vi, this message translates to:
  /// **'3. Apps cần chặn'**
  String get detoxSetupStep3;

  /// No description provided for @detoxSetupStep4.
  ///
  /// In vi, this message translates to:
  /// **'4. Tại sao bạn muốn detox?'**
  String get detoxSetupStep4;

  /// No description provided for @detoxSetupReasonSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Quan trọng — sẽ dùng để nhắc bạn khi muốn relapse.'**
  String get detoxSetupReasonSubtitle;

  /// No description provided for @detoxSetupReasonHint.
  ///
  /// In vi, this message translates to:
  /// **'Vd: Muốn ngủ ngon hơn, có thời gian đọc sách, không bị giật thông báo cả ngày...'**
  String get detoxSetupReasonHint;

  /// No description provided for @detoxSetupStartCta.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu {days} ngày detox'**
  String detoxSetupStartCta(int days);

  /// No description provided for @detoxSetupStartedSnackbar.
  ///
  /// In vi, this message translates to:
  /// **'Detox đã bắt đầu — giữ vững nhé'**
  String get detoxSetupStartedSnackbar;

  /// No description provided for @detoxSetupReasonRequiredSnackbar.
  ///
  /// In vi, this message translates to:
  /// **'Hãy viết một câu lý do — sẽ dùng để nhắc bạn khi muốn relapse'**
  String get detoxSetupReasonRequiredSnackbar;

  /// No description provided for @detoxDuration24hLabel.
  ///
  /// In vi, this message translates to:
  /// **'24 giờ'**
  String get detoxDuration24hLabel;

  /// No description provided for @detoxDuration24hSub.
  ///
  /// In vi, this message translates to:
  /// **'Beginner'**
  String get detoxDuration24hSub;

  /// No description provided for @detoxDuration7dLabel.
  ///
  /// In vi, this message translates to:
  /// **'7 ngày'**
  String get detoxDuration7dLabel;

  /// No description provided for @detoxDuration7dSub.
  ///
  /// In vi, this message translates to:
  /// **'Đề xuất'**
  String get detoxDuration7dSub;

  /// No description provided for @detoxDuration30dLabel.
  ///
  /// In vi, this message translates to:
  /// **'30 ngày'**
  String get detoxDuration30dLabel;

  /// No description provided for @detoxDuration30dSub.
  ///
  /// In vi, this message translates to:
  /// **'Hardcore'**
  String get detoxDuration30dSub;

  /// No description provided for @detoxStrictnessLight.
  ///
  /// In vi, this message translates to:
  /// **'Nhẹ'**
  String get detoxStrictnessLight;

  /// No description provided for @detoxStrictnessMedium.
  ///
  /// In vi, this message translates to:
  /// **'Vừa'**
  String get detoxStrictnessMedium;

  /// No description provided for @detoxStrictnessHard.
  ///
  /// In vi, this message translates to:
  /// **'Cứng'**
  String get detoxStrictnessHard;

  /// No description provided for @detoxStrictnessLightDesc.
  ///
  /// In vi, this message translates to:
  /// **'Nhẹ: chỉ nhắc nhở khi mở app cheap. Vẫn có thể dùng nếu muốn.'**
  String get detoxStrictnessLightDesc;

  /// No description provided for @detoxStrictnessMediumDesc.
  ///
  /// In vi, this message translates to:
  /// **'Vừa: chặn mặc định + intervention popup mỗi lần mở. Có escape hatch.'**
  String get detoxStrictnessMediumDesc;

  /// No description provided for @detoxStrictnessHardDesc.
  ///
  /// In vi, this message translates to:
  /// **'Cứng: chặn app cheap hoàn toàn. Có escape hatch chờ 20s nếu thật sự cần.'**
  String get detoxStrictnessHardDesc;

  /// No description provided for @emergencyTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hít thở. Bạn không cô đơn.'**
  String get emergencyTitle;

  /// No description provided for @emergencySubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Cảm giác sẽ qua — trung bình cravings chỉ kéo dài 15-20 phút.'**
  String get emergencySubtitle;

  /// No description provided for @emergencyNotFailureText.
  ///
  /// In vi, this message translates to:
  /// **'Cravings là tín hiệu receptor đang hồi phục — đây không phải thất bại, mà là một phần của quá trình.'**
  String get emergencyNotFailureText;

  /// No description provided for @emergencyYourReasonLabel.
  ///
  /// In vi, this message translates to:
  /// **'LÝ DO BẠN BẮT ĐẦU'**
  String get emergencyYourReasonLabel;

  /// No description provided for @emergencyTryNowLabel.
  ///
  /// In vi, this message translates to:
  /// **'THỬ NGAY'**
  String get emergencyTryNowLabel;

  /// No description provided for @emergencyActionWaterTitle.
  ///
  /// In vi, this message translates to:
  /// **'Uống một cốc nước'**
  String get emergencyActionWaterTitle;

  /// No description provided for @emergencyActionWaterDesc.
  ///
  /// In vi, this message translates to:
  /// **'Sự thay đổi nhỏ phá vỡ vòng lặp'**
  String get emergencyActionWaterDesc;

  /// No description provided for @emergencyActionExerciseTitle.
  ///
  /// In vi, this message translates to:
  /// **'10 cái jumping jack'**
  String get emergencyActionExerciseTitle;

  /// No description provided for @emergencyActionExerciseDesc.
  ///
  /// In vi, this message translates to:
  /// **'Nâng dopamine tự nhiên trong 30s'**
  String get emergencyActionExerciseDesc;

  /// No description provided for @emergencyActionBuddyTitle.
  ///
  /// In vi, this message translates to:
  /// **'Gọi buddy'**
  String get emergencyActionBuddyTitle;

  /// No description provided for @emergencyActionBuddyDesc.
  ///
  /// In vi, this message translates to:
  /// **'Bạn không phải tự mình chống cự'**
  String get emergencyActionBuddyDesc;

  /// No description provided for @emergencyReflectionLabel.
  ///
  /// In vi, this message translates to:
  /// **'PHẢN CHIẾU'**
  String get emergencyReflectionLabel;

  /// No description provided for @emergencyReflectionQuestion.
  ///
  /// In vi, this message translates to:
  /// **'Bạn thực sự đang cảm thấy gì?'**
  String get emergencyReflectionQuestion;

  /// No description provided for @emergencyReflectionDesc.
  ///
  /// In vi, this message translates to:
  /// **'Mệt? Cô đơn? Chán? Lo lắng? Cravings thường là tín hiệu cho một nhu cầu khác — không phải thiếu dopamine.'**
  String get emergencyReflectionDesc;

  /// No description provided for @breathingInhale.
  ///
  /// In vi, this message translates to:
  /// **'Hít vào'**
  String get breathingInhale;

  /// No description provided for @breathingHold.
  ///
  /// In vi, this message translates to:
  /// **'Giữ'**
  String get breathingHold;

  /// No description provided for @breathingExhale.
  ///
  /// In vi, this message translates to:
  /// **'Thở ra'**
  String get breathingExhale;

  /// No description provided for @interventionClose.
  ///
  /// In vi, this message translates to:
  /// **'Đóng'**
  String get interventionClose;

  /// No description provided for @interventionTitle.
  ///
  /// In vi, this message translates to:
  /// **'Khoan đã 👋'**
  String get interventionTitle;

  /// No description provided for @interventionSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Bạn vừa định mở {app} lần thứ 4 trong giờ qua.'**
  String interventionSubtitle(String app);

  /// No description provided for @interventionTodayLabel.
  ///
  /// In vi, this message translates to:
  /// **'HÔM NAY'**
  String get interventionTodayLabel;

  /// No description provided for @interventionTryLabel.
  ///
  /// In vi, this message translates to:
  /// **'THỬ THAY BẰNG'**
  String get interventionTryLabel;

  /// No description provided for @interventionSuggestionWalkTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đi bộ ngắn'**
  String get interventionSuggestionWalkTitle;

  /// No description provided for @interventionSuggestionWalkDuration.
  ///
  /// In vi, this message translates to:
  /// **'10 phút'**
  String get interventionSuggestionWalkDuration;

  /// No description provided for @interventionSuggestionPodcastTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nghe podcast'**
  String get interventionSuggestionPodcastTitle;

  /// No description provided for @interventionSuggestionPodcastDuration.
  ///
  /// In vi, this message translates to:
  /// **'15 phút'**
  String get interventionSuggestionPodcastDuration;

  /// No description provided for @interventionSuggestionJournalTitle.
  ///
  /// In vi, this message translates to:
  /// **'Viết journal'**
  String get interventionSuggestionJournalTitle;

  /// No description provided for @interventionSuggestionJournalDuration.
  ///
  /// In vi, this message translates to:
  /// **'5 phút'**
  String get interventionSuggestionJournalDuration;

  /// No description provided for @interventionOpenAnyway.
  ///
  /// In vi, this message translates to:
  /// **'Vẫn muốn mở {app}'**
  String interventionOpenAnyway(String app);

  /// No description provided for @interventionOpenAnywayWait.
  ///
  /// In vi, this message translates to:
  /// **'Vẫn muốn mở {app} (chờ 20s)'**
  String interventionOpenAnywayWait(String app);

  /// No description provided for @interventionWaitSeconds.
  ///
  /// In vi, this message translates to:
  /// **'Chờ {seconds}s…'**
  String interventionWaitSeconds(int seconds);

  /// No description provided for @onboardingStepIndicator.
  ///
  /// In vi, this message translates to:
  /// **'{step}/{total}'**
  String onboardingStepIndicator(int step, int total);

  /// No description provided for @onboardingFinishCta.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu sử dụng'**
  String get onboardingFinishCta;

  /// No description provided for @onboardingStep1Title.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng đến với\nDopamine Diary'**
  String get onboardingStep1Title;

  /// No description provided for @onboardingStep1Desc.
  ///
  /// In vi, this message translates to:
  /// **'Một app giúp bạn cân bằng giữa dopamine rẻ tiền (TikTok, Reels) và dopamine lành mạnh (tập thể dục, đọc, deep work) — không phán xét, không gây nghiện chính nó.'**
  String get onboardingStep1Desc;

  /// No description provided for @onboardingStep1SetupTime.
  ///
  /// In vi, this message translates to:
  /// **'Mất ~2 phút để setup'**
  String get onboardingStep1SetupTime;

  /// No description provided for @onboardingStep2Title.
  ///
  /// In vi, this message translates to:
  /// **'Không phải mọi\ndopamine đều xấu'**
  String get onboardingStep2Title;

  /// No description provided for @onboardingStep2Desc.
  ///
  /// In vi, this message translates to:
  /// **'Cơ thể bạn cần dopamine — nó là tín hiệu của niềm vui, học tập, kết nối. Vấn đề chỉ xuất hiện khi \"dopamine rẻ\" (10s, vô hạn, không nỗ lực) lấn át \"dopamine lành\" (cần nỗ lực, mang lại ý nghĩa).'**
  String get onboardingStep2Desc;

  /// No description provided for @tierExampleCheap.
  ///
  /// In vi, this message translates to:
  /// **'TikTok, Reels, lướt vô thức'**
  String get tierExampleCheap;

  /// No description provided for @tierExampleMedium.
  ///
  /// In vi, this message translates to:
  /// **'Xem phim, ăn vặt, gặp xã giao'**
  String get tierExampleMedium;

  /// No description provided for @tierExampleHealthy.
  ///
  /// In vi, this message translates to:
  /// **'Tập thể dục, đi bộ, nấu ăn'**
  String get tierExampleHealthy;

  /// No description provided for @tierExampleDeep.
  ///
  /// In vi, this message translates to:
  /// **'Đọc sách, học, code, viết'**
  String get tierExampleDeep;

  /// No description provided for @onboardingStep3Title.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại theo BẠN'**
  String get onboardingStep3Title;

  /// No description provided for @onboardingStep3Desc.
  ///
  /// In vi, this message translates to:
  /// **'Kéo thả (hoặc tap để chọn) — tier mặc định không hợp với mọi người. TikTok với creator chuyên nghiệp là công việc, không phải dopamine rẻ.'**
  String get onboardingStep3Desc;

  /// No description provided for @onboardingDragHere.
  ///
  /// In vi, this message translates to:
  /// **'Kéo thả vào đây'**
  String get onboardingDragHere;

  /// No description provided for @onboardingReassignQuestion.
  ///
  /// In vi, this message translates to:
  /// **'Chuyển sang tier nào?'**
  String get onboardingReassignQuestion;

  /// No description provided for @onboardingStep4Title.
  ///
  /// In vi, this message translates to:
  /// **'Mỗi ngày 10 giây'**
  String get onboardingStep4Title;

  /// No description provided for @onboardingStep4Desc.
  ///
  /// In vi, this message translates to:
  /// **'Bạn không cần track mọi thứ. Mỗi tối, mở app, ghi nhanh những gì đã làm — vài giây thôi. Dopamine Diary sẽ tính score, pattern, gợi ý điều chỉnh nhẹ nhàng.'**
  String get onboardingStep4Desc;

  /// No description provided for @onboardingBulletPrivacy.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu lưu cục bộ trên máy bạn, mã hoá'**
  String get onboardingBulletPrivacy;

  /// No description provided for @onboardingBulletNoNotifications.
  ///
  /// In vi, this message translates to:
  /// **'Không notification giật gân, không badge đỏ'**
  String get onboardingBulletNoNotifications;

  /// No description provided for @onboardingBulletEmpathy.
  ///
  /// In vi, this message translates to:
  /// **'Tone đồng cảm, không phán xét khi relapse'**
  String get onboardingBulletEmpathy;

  /// No description provided for @onboardingStep5Title.
  ///
  /// In vi, this message translates to:
  /// **'Setup xong'**
  String get onboardingStep5Title;

  /// No description provided for @onboardingStep5Desc.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có thể chỉnh lại tier bất cứ lúc nào trong \"Của tôi\" → \"Phân loại hoạt động\".'**
  String get onboardingStep5Desc;

  /// No description provided for @buddyTitle.
  ///
  /// In vi, this message translates to:
  /// **'Buddy'**
  String get buddyTitle;

  /// No description provided for @buddyMockName.
  ///
  /// In vi, this message translates to:
  /// **'Linh N.'**
  String get buddyMockName;

  /// No description provided for @buddyOnlineStatus.
  ///
  /// In vi, this message translates to:
  /// **'Online · cùng goal detox 7 ngày'**
  String get buddyOnlineStatus;

  /// No description provided for @buddyTodayLabel.
  ///
  /// In vi, this message translates to:
  /// **'HÔM NAY'**
  String get buddyTodayLabel;

  /// No description provided for @buddyYourScoreLabel.
  ///
  /// In vi, this message translates to:
  /// **'Bạn'**
  String get buddyYourScoreLabel;

  /// No description provided for @buddyNotCompetitionNote.
  ///
  /// In vi, this message translates to:
  /// **'Không phải thi đua — đây là support cùng nhau'**
  String get buddyNotCompetitionNote;

  /// No description provided for @buddyFeedSection.
  ///
  /// In vi, this message translates to:
  /// **'NHẬT KÝ CỦA BẠN ẤY'**
  String get buddyFeedSection;

  /// No description provided for @buddyFeedRun.
  ///
  /// In vi, this message translates to:
  /// **'Linh vừa chạy 5km'**
  String get buddyFeedRun;

  /// No description provided for @buddyFeedRead.
  ///
  /// In vi, this message translates to:
  /// **'Linh đọc sách 45 phút'**
  String get buddyFeedRead;

  /// No description provided for @buddyFeedNeedSupport.
  ///
  /// In vi, this message translates to:
  /// **'Linh cần động viên — đang muốn relapse'**
  String get buddyFeedNeedSupport;

  /// No description provided for @buddyTimeMinutesAgo.
  ///
  /// In vi, this message translates to:
  /// **'{n} phút trước'**
  String buddyTimeMinutesAgo(int n);

  /// No description provided for @buddyTimeHoursAgo.
  ///
  /// In vi, this message translates to:
  /// **'{n} giờ trước'**
  String buddyTimeHoursAgo(int n);

  /// No description provided for @buddySendEncouragement.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lời động viên'**
  String get buddySendEncouragement;

  /// No description provided for @buddyInviteCta.
  ///
  /// In vi, this message translates to:
  /// **'Mời thêm buddy'**
  String get buddyInviteCta;

  /// No description provided for @buddyInviteUnavailable.
  ///
  /// In vi, this message translates to:
  /// **'Tính năng mời buddy sẽ có ở bản sau'**
  String get buddyInviteUnavailable;

  /// No description provided for @buddySheetTitle.
  ///
  /// In vi, this message translates to:
  /// **'Gửi cho Linh'**
  String get buddySheetTitle;

  /// No description provided for @buddySheetSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Chọn message — sẽ gửi ngay tới buddy'**
  String get buddySheetSubtitle;

  /// No description provided for @buddyMessage1.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đang làm tốt — mình tin bạn'**
  String get buddyMessage1;

  /// No description provided for @buddyMessage2.
  ///
  /// In vi, this message translates to:
  /// **'Cảm giác này sẽ qua, mình ở đây'**
  String get buddyMessage2;

  /// No description provided for @buddyMessage3.
  ///
  /// In vi, this message translates to:
  /// **'Hãy uống nước, đi bộ 5 phút trước nhé'**
  String get buddyMessage3;

  /// No description provided for @buddyMessage4.
  ///
  /// In vi, this message translates to:
  /// **'Mình cũng từng vậy, không sao đâu'**
  String get buddyMessage4;

  /// No description provided for @buddyMessageSent.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi lời động viên 💜'**
  String get buddyMessageSent;

  /// No description provided for @settingsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Của tôi'**
  String get settingsTitle;

  /// No description provided for @settingsProfileName.
  ///
  /// In vi, this message translates to:
  /// **'Bạn'**
  String get settingsProfileName;

  /// No description provided for @settingsProfileMemberSince.
  ///
  /// In vi, this message translates to:
  /// **'Thành viên từ tháng 5, 2026'**
  String get settingsProfileMemberSince;

  /// No description provided for @settingsSectionCustomize.
  ///
  /// In vi, this message translates to:
  /// **'TUỲ CHỈNH'**
  String get settingsSectionCustomize;

  /// No description provided for @settingsSectionThreshold.
  ///
  /// In vi, this message translates to:
  /// **'NGƯỠNG CẢNH BÁO'**
  String get settingsSectionThreshold;

  /// No description provided for @settingsSectionBlockedApps.
  ///
  /// In vi, this message translates to:
  /// **'CHẶN ỨNG DỤNG'**
  String get settingsSectionBlockedApps;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In vi, this message translates to:
  /// **'VỀ APP'**
  String get settingsSectionAbout;

  /// No description provided for @settingsSectionLanguage.
  ///
  /// In vi, this message translates to:
  /// **'NGÔN NGỮ'**
  String get settingsSectionLanguage;

  /// No description provided for @settingsTileTierClassification.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại hoạt động'**
  String get settingsTileTierClassification;

  /// No description provided for @settingsTileTierClassificationSub.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh tier cho từng activity type'**
  String get settingsTileTierClassificationSub;

  /// No description provided for @settingsTileBuddy.
  ///
  /// In vi, this message translates to:
  /// **'Buddy'**
  String get settingsTileBuddy;

  /// No description provided for @settingsTileBuddySub.
  ///
  /// In vi, this message translates to:
  /// **'Accountability partner'**
  String get settingsTileBuddySub;

  /// No description provided for @settingsTilePrivacy.
  ///
  /// In vi, this message translates to:
  /// **'Quyền riêng tư'**
  String get settingsTilePrivacy;

  /// No description provided for @settingsTilePrivacySub.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu mã hoá và lưu cục bộ trên máy'**
  String get settingsTilePrivacySub;

  /// No description provided for @settingsTileAbout.
  ///
  /// In vi, this message translates to:
  /// **'Về Dopamine Diary'**
  String get settingsTileAbout;

  /// No description provided for @settingsTileAboutSub.
  ///
  /// In vi, this message translates to:
  /// **'Phiên bản 0.1.0 · MVP'**
  String get settingsTileAboutSub;

  /// No description provided for @settingsPrivacySnackbar.
  ///
  /// In vi, this message translates to:
  /// **'Toàn bộ dữ liệu lưu trong Hive trên thiết bị, không upload'**
  String get settingsPrivacySnackbar;

  /// No description provided for @settingsAboutSnackbar.
  ///
  /// In vi, this message translates to:
  /// **'Dopamine Diary v0.1.0'**
  String get settingsAboutSnackbar;

  /// No description provided for @settingsThresholdLabel.
  ///
  /// In vi, this message translates to:
  /// **'Dopamine rẻ tối đa/ngày'**
  String get settingsThresholdLabel;

  /// No description provided for @settingsThresholdValue.
  ///
  /// In vi, this message translates to:
  /// **'{hours}h'**
  String settingsThresholdValue(String hours);

  /// No description provided for @settingsThresholdDesc.
  ///
  /// In vi, this message translates to:
  /// **'Khi vượt ngưỡng, Dopamine Diary sẽ gợi ý nhẹ — không chặn cứng.'**
  String get settingsThresholdDesc;

  /// No description provided for @settingsLanguageVietnamese.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get settingsLanguageVietnamese;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In vi, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In vi, this message translates to:
  /// **'Theo hệ thống'**
  String get settingsLanguageSystem;

  /// No description provided for @authLoginTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get authLoginTitle;

  /// No description provided for @authSignupTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get authSignupTitle;

  /// No description provided for @authEmailHint.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get authEmailHint;

  /// No description provided for @authPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get authPasswordHint;

  /// No description provided for @authNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Tên'**
  String get authNameHint;

  /// No description provided for @authLoginCta.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get authLoginCta;

  /// No description provided for @authSignupCta.
  ///
  /// In vi, this message translates to:
  /// **'Tạo tài khoản'**
  String get authSignupCta;

  /// No description provided for @authToSignup.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có tài khoản? Đăng ký'**
  String get authToSignup;

  /// No description provided for @authToLogin.
  ///
  /// In vi, this message translates to:
  /// **'Đã có tài khoản? Đăng nhập'**
  String get authToLogin;

  /// No description provided for @authMissingFields.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng điền đầy đủ các trường'**
  String get authMissingFields;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
