# PROMPT CHO CLAUDE CODE — Build app "Dopamine Diary"

> Copy toàn bộ nội dung dưới đây và paste vào Claude Code sau khi chạy `claude` trong thư mục `dopamine_diary`.

---

Bạn là senior Flutter engineer. Hãy build app **Dopamine Diary** — một app quản lý dopamine cá nhân, giúp người dùng cân bằng giữa "dopamine rẻ tiền" (TikTok, Reels) và "dopamine lành mạnh" (tập thể dục, đọc sách, deep work).

⚠️ LƯU Ý ĐẦU TIÊN — ĐÂY LÀ PROJECT ĐÃ CÓ SẴN:
Trước khi viết bất kỳ code nào, hãy:
1. Chạy `flutter pub get` và đọc `pubspec.yaml` để biết package + version đang dùng
2. Khám phá cấu trúc thư mục `lib/` hiện tại — xem cách tổ chức feature, naming convention
3. Đọc 1-2 Bloc/Cubit đã có để hiểu pattern (Bloc hay Cubit? dùng Equatable hay freezed? state structure thế nào?)
4. Báo cáo lại cho tôi: project đang dùng những gì, structure ra sao, rồi mới đề xuất kế hoạch build
5. TUYỆT ĐỐI tuân theo convention đã có, KHÔNG áp đặt pattern mới

Đọc kỹ toàn bộ spec dưới đây rồi build theo đúng thứ tự các phase. Sau mỗi phase, chạy `flutter analyze` để đảm bảo không có lỗi, rồi mới sang phase tiếp theo.

## 0 · TECH STACK & CẤU HÌNH

QUAN TRỌNG: Đây là project ĐÃ TỒN TẠI và đang dùng **Bloc** cho state management. Hãy:
1. Đọc cấu trúc project hiện tại trước (pubspec.yaml, lib/, các bloc đã có) để hiểu convention đang dùng
2. TUÂN THEO pattern Bloc/Cubit hiện có — KHÔNG đổi sang state management khác
3. Đặt file theo đúng structure folder hiện tại của project

- **State management**: flutter_bloc (Bloc/Cubit) — theo đúng pattern đã có trong project
- **Local storage**: Hive (offline-first, không cần backend ở MVP) — hoặc theo cái project đang dùng nếu đã có
- **Navigation**: theo router project đang dùng (go_router / Navigator 2.0 / auto_route...). Nếu chưa có thì dùng go_router.
- **Font**: Google Fonts (Inter)
- **Icons**: lucide_icons (tương đương Tabler, outline mảnh, đẹp)
- **Charts**: fl_chart (cho bar chart analytics)
- Hỗ trợ tiếng Việt là ngôn ngữ chính

Kiểm tra `pubspec.yaml` hiện tại, nếu thiếu thì thêm (giữ nguyên version đang có nếu đã khai báo):
```yaml
dependencies:
  flutter_bloc: ^8.1.6      # nếu project đang dùng version khác thì GIỮ NGUYÊN
  equatable: ^2.0.5         # cho Bloc states/events
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  google_fonts: ^6.2.1
  lucide_icons: ^0.257.0
  fl_chart: ^0.68.0
  intl: ^0.19.0
dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.11
```

### Quy ước Bloc cho project này
Mỗi feature có cấu trúc:
```
lib/features/<feature>/
  bloc/
    <feature>_bloc.dart      (hoặc _cubit.dart nếu project dùng Cubit)
    <feature>_event.dart
    <feature>_state.dart
  view/
    <feature>_screen.dart
  widgets/
```
States dùng Equatable. Nếu project hiện tại dùng Cubit thay vì full Bloc thì theo Cubit. Nếu dùng freezed cho state thì theo freezed. LUÔN khớp với code đã có.

Các Bloc/Cubit cần tạo:
- `ActivityBloc` — quản lý log hoạt động, tính score
- `HomeBloc` / `HomeCubit` — state cho dashboard (score, tier breakdown, streak, recent)
- `AnalyticsBloc` — data cho biểu đồ + insights
- `DetoxBloc` — quản lý detox session, timer, blocked apps
- `OnboardingCubit` — phân loại tier, các bước onboarding

## 1 · TRIẾT LÝ THIẾT KẾ (quan trọng — phải tuân thủ xuyên suốt)

App này theo nguyên tắc **"anti-engagement design"** — app quản lý dopamine mà gây nghiện chính nó thì phản tác dụng. Cụ thể:

- KHÔNG infinite scroll, KHÔNG notification giật gân, KHÔNG badge đỏ gây lo âu
- Màu chủ đạo trung tính (trắng/be), chỉ dùng màu accent cho data
- KHÔNG dùng shadow (dùng border 0.5px thay thế) → UI flat, nhẹ, không gây stress thị giác
- Tone giọng đồng cảm, KHÔNG phán xét: "Khoan đã 👋" thay vì "DỪNG LẠI!"
- Mọi intervention đều có "escape hatch" (chờ 20s) — không bao giờ hard-block
- Score thấp KHÔNG hiển thị như điều "tệ" (tránh red alert, ⚠️)
- Relapse được xử lý nhẹ nhàng, coi là dữ liệu để học, không trừng phạt

## 2 · DESIGN TOKENS (tạo file `lib/core/theme/`)

### Colors (`app_colors.dart`)

4 tier dopamine, mỗi tier có bg / main / fg:
```
// Tier CHEAP (dopamine rẻ - đỏ)
cheapBg     = #FCEBEB
cheapMain   = #E24B4A
cheapFg     = #791F1F
cheapText   = #501313

// Tier MEDIUM (trung bình - vàng/cam)
mediumBg    = #FAEEDA
mediumMain  = #EF9F27
mediumFg    = #854F0B
mediumText  = #412402

// Tier HEALTHY (lành mạnh - xanh lá)
healthyBg   = #EAF3DE
healthyMain = #97C459
healthyFg   = #27500A
healthyText = #173404

// Tier DEEP (deep work - xanh dương)
deepBg      = #E6F1FB
deepMain    = #378ADD
deepFg      = #0C447C
deepText    = #042C53

// Brand
brandPrimary   = #534AB7   // detox, AI, premium
brandPrimaryBg = #EEEDFE
brandPrimaryText = #26215C

accentCalm     = #1D9E75   // emergency, buddy
accentCalmBg   = #E1F5EE
accentCalmText = #04342C

// Surfaces
surface1 = #FFFFFF   // card
surface2 = #F1EFE8   // subtle bg
surface3 = #FAF9F5   // screen bg

// Text
textPrimary   = #2C2C2A
textSecondary = #5F5E5A
textTertiary  = #888780

// Border
borderSubtle  = #E8E6DD
borderDefault = #D3D1C7
```

### Typography (`app_text_styles.dart`)
Inter, chỉ 2 weights: 400 (regular) / 500 (medium). KHÔNG dùng weight ≥ 600.
```
display   : 48px / w500   (score, big stat)
heading1  : 20px / w500   (screen title)
heading2  : 17px / w500   (section title)
body      : 14px / w400   (default)
label     : 12px / w500   (card label)
caption   : 11px / w400   (meta, hint)
```

### Spacing (`app_spacing.dart`) — grid 4pt
```
space1 = 4    space2 = 8    space3 = 12
space4 = 16   space5 = 20   space6 = 24
```

### Radius (`app_radius.dart`)
```
sm = 4    md = 8    lg = 12    xl = 28
```

### Motion guidelines (áp dụng khi làm animation)
- Page transition: 300ms ease-out, slide horizontal
- Score number: 800ms count-up (cảm giác "earned")
- Intervention popup: 400ms fade-in từ dưới, KHÔNG bounce/spring
- Tier bar fill: 600ms staggered (50ms delay mỗi tier)
- Haptic: chỉ ở log thành công (light), button primary (light), detox start (medium). KHÔNG rung khi báo lỗi.

## 3 · DATA MODELS (tạo `lib/core/models/`)

```dart
enum DopamineTier { cheap, medium, healthy, deep }

class Activity {
  String id;
  String name;          // "Lướt TikTok"
  DopamineTier tier;
  int durationMinutes;
  DateTime timestamp;
  String? mood;         // emoji optional
  int scoreImpact;      // -12, +18, etc.
}

class ActivityType {     // dạng template, user tự phân loại tier
  String id;
  String name;
  DopamineTier tier;
  String iconName;       // lucide icon name
}

class DetoxSession {
  String id;
  DateTime startTime;
  int durationDays;      // 1, 7, 30
  int strictness;        // 1-3
  String reason;         // user viết, dùng để remind khi muốn relapse
  List<String> blockedApps;
  bool isActive;
}

class DailyScore {
  DateTime date;
  int score;             // 0-100
  Map<DopamineTier, int> minutesByTier;
}
```

## 4 · COMPONENT LIBRARY (tạo `lib/core/widgets/`)

Build các reusable widget này TRƯỚC khi làm screen:

1. **AppButton** — variants: primary (đen), secondary (border), tertiary (tím nhạt), ghost. Height 44, radius 8.
2. **ActivityRow** — icon container 36×36 + title/meta + score chip. Border-left 3px màu tier.
3. **MetricCard** — label (11/400 muted) + value (24/500) + delta (semantic color).
4. **InsightCard** — 2 variants: AI (nền tím #EEEDFE, icon sparkles) / Pattern (nền teal #E1F5EE).
5. **ScoreRing** — vòng tròn progress hiển thị score 0-100 (dùng CustomPainter).
6. **TierBar** — thanh ngang chia 4 đoạn theo % mỗi tier.
7. **AppBottomNav** — 4 tabs: Hôm nay / Phân tích / Detox / Của tôi.

## 5 · SCREENS (tạo `lib/screens/`) — build theo thứ tự ưu tiên

### Nhóm A — Core loop (làm trước, đây là MVP)
**1. Home Dashboard** (`home_screen.dart`)
- Greeting "Chào buổi sáng, [tên]"
- ScoreRing 72/100 + "Cân bằng tốt" + "↑ +8 so với hôm qua"
- TierBar (Rẻ 18% / TB 27% / Lành 36% / Deep 19%)
- Nút primary "+ Ghi nhanh hoạt động"
- Streak card (nền vàng #FAEEDA): "🔥 Chuỗi 7 ngày · Detox khỏi short video"
- Recent activities (ActivityRow list)
- Bottom nav

**2. Quick Log** (`quick_log_screen.dart`) — modal/sheet
- "Bạn vừa làm gì? · Ghi nhanh trong 3 giây"
- Search bar
- Recent activities list (tap để log nhanh)
- Nút "🎤 Ghi bằng giọng nói" (UI thôi, chưa cần STT thật ở MVP)

**3. Analytics** (`analytics_screen.dart`)
- Bar chart 7 ngày (fl_chart) — màu cột theo score (thấp=cam/đỏ, cao=xanh)
- InsightCard AI: "Bạn thường lướt TikTok vào 21h–23h sau khi mở app công việc"
- InsightCard Pattern: "Ngày tập thể dục → score cao hơn 34%"
- 2 metric cards: "Dopamine rẻ 12h30p" / "Deep work 8h15p"

**4. Detox Active** (`detox_active_screen.dart`)
- "DETOX MODE · Đang trong giai đoạn reset"
- Timer ring lớn: "2d 14h còn lại / 7 ngày"
- Blocked apps chips (TikTok, Instagram, YouTube Shorts, Facebook)
- Quote card (nền tím): trích Anna Lembke về phục hồi receptor
- Nút "Kết thúc sớm" (ghost)

### Nhóm B — Engagement & support
**5. Intervention Popup** (`intervention_screen.dart`) — modal
- Icon circle ✋ (nền vàng)
- "Khoan đã 👋 · Bạn vừa mở TikTok lần thứ 4 trong giờ qua"
- Stats card: "Hôm nay đã dùng 1h47p / Giới hạn 2h" + progress bar
- 3 suggestion rows: Đi bộ 10p / Nghe podcast 15p / Viết journal 5p
- Escape hatch: "Vẫn muốn mở TikTok (chờ 20s)" — có countdown thật 20s

**6. Onboarding — Tier Setup** (`onboarding_tier_screen.dart`)
- Progress bar (bước 3/5)
- "Phân loại hoạt động · Kéo thả vào tier phù hợp với BẠN"
- 4 tier zones (dashed border) với chips bên trong
- Khu "Chưa phân loại" để kéo thả
- Cho phép user tự quyết tier — KHÔNG áp đặt (vì TikTok với creator là công việc)

**7. Voice Log** (`voice_log_screen.dart`)
- Mic circle lớn + waveform animation
- "Đang nghe... 0:08"
- Transcript card (mock text)
- AI parsed card: chips "🟢 Chạy bộ · 30 phút · Mood 😊"
- Nút Sửa / Lưu

**8. Weekly Review** (`weekly_review_screen.dart`) — màn DUY NHẤT dùng gradient
- Nền gradient tím (#26215C → #534AB7), chữ trắng
- "TUẦN 21 · 2026 · Tuần của bạn"
- Big stat: "Bạn đã giành lại 11h từ short video"
- Highlights card (translucent): 🏃 Tập 5/7 ngày / 📚 Đọc 4h / 🌙 Ngủ sớm 6 đêm
- Pattern card + Goal card
- Nút "Chia sẻ với bạn bè"

### Nhóm C — Còn lại
**9. Buddy** (`buddy_screen.dart`)
- Buddy card: avatar Linh N. + "● Online · cùng goal detox 7 ngày"
- So sánh điểm: Bạn 72 / Linh 68 (KHÔNG phải thi đua, mà là support)
- Activity feed: "Linh vừa chạy 5km" / "Linh cần động viên — đang muốn relapse"
- Nút "Gửi lời động viên"

**10. Detox Setup Wizard** (`detox_setup_screen.dart`)
- Chọn độ dài: 24h (beginner) / 7 ngày (đề xuất) / 30 ngày (hardcore)
- Slider độ nghiêm khắc (Nhẹ - Vừa - Cứng)
- Text field "Tại sao bạn muốn detox?" (quan trọng: dùng remind khi relapse)
- Nút "Bắt đầu 7 ngày detox"

**11. Emergency Mode** (`emergency_screen.dart`) — màu teal calming (KHÔNG đỏ)
- Nền gradient teal (#04342C → #0F6E56)
- "Hít thở. Bạn không cô đơn. · Cảm giác sẽ qua"
- Breathing circle animation (Hít vào 4s / giữ / thở ra)
- Message: "Cravings trung bình 15-20 phút. Đây không phải thất bại"
- Quick actions: Uống nước / 10 jumping jack / Gọi buddy
- Reflection: "Bạn thực sự đang cảm thấy gì? Mệt? Cô đơn? Chán?"

**12. Settings** (`settings_screen.dart`)
- Profile card
- Blocked apps (toggle list)
- Ngưỡng cảnh báo (slider "Dopamine rẻ tối đa/ngày = 2h")
- Privacy note: "Dữ liệu mã hóa và lưu local"

## 6 · USER FLOWS (logic kết nối)

**Daily loop**: Mở app → Home → tap "Ghi nhanh" → Quick Log → log xong → Home cập nhật score. Nếu score thấp (nhiều cheap) → tự động hiện Intervention. Nếu ổn → im lặng.

**Detox journey**: Home → Detox tab → Setup wizard → Detox Active. Khi user muốn relapse → Emergency Mode (breathing + remind lý do + gọi buddy). Vượt qua → quay lại detox. Không vượt qua → "soft relapse", không phán xét.

## 7 · THỨ TỰ BUILD (làm đúng từng phase, analyze sau mỗi phase)

1. **Phase 1**: Đọc theme hiện có (nếu project đã có `lib/core/theme` hoặc tương tự). Nếu CHƯA có thì tạo mới (colors, typography, spacing, radius) + cập nhật MaterialApp theme. Nếu ĐÃ có theme thì MERGE design tokens dưới đây vào, KHÔNG ghi đè toàn bộ.
2. **Phase 2**: Data models + Hive setup + Bloc/Cubit cho từng feature (mock data trước, repository pattern)
3. **Phase 3**: Component library (7 widgets ở mục 4)
4. **Phase 4**: Nhóm A screens (Home, Quick Log, Analytics, Detox Active) + bottom nav + routing
5. **Phase 5**: Nhóm B screens (Intervention, Onboarding, Voice Log, Weekly Review)
6. **Phase 6**: Nhóm C screens (Buddy, Detox Setup, Emergency, Settings)
7. **Phase 7**: Polish — animations, haptics, empty states, transitions

Bắt đầu với Phase 1. Sau khi xong Phase 1, dừng lại cho tôi xem `flutter run` chạy được rồi mới tiếp Phase 2.

Dùng tiếng Việt cho tất cả text trong UI và comment trong code. Code clean, tách file rõ ràng, đặt tên biến có ý nghĩa.
