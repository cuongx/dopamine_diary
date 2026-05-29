/// Đường dẫn tới mọi asset trong app.
///
/// MVP hiện không bundle bất kỳ file ảnh nào — toàn bộ logo, illustration,
/// animation đều được render bằng widget code trong `core/common/widgets/`
/// (xem AppLogo, EmptyState, BreathingCircle, AnimatedCheck, WelcomeHero...).
///
/// Khi có file ảnh thật cần dùng, thêm path vào class này thay vì hardcode
/// chuỗi ở widget.
class AppAssets {
  AppAssets._();

  // (intentionally empty — assets được thay bằng widget code)
}
