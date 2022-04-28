import 'dart:ui' as ui;

final double devicePixelRatio = ui.window.devicePixelRatio;
final ui.Size size = ui.window.physicalSize;
final double width = size.width;
final double height = size.height;

class AppHelpers{
  static bool isTablet(){
    return Device.get().isTablet;
  }
  static bool isPhone() => Device.get().isPhone;
  static bool hasNotch() => Device.get().hasNotch;
}

class Device {
  static double screenWidth = width / devicePixelRatio;
  static double screenHeight = height / devicePixelRatio;
  static ui.Size screenSize = ui.Size(screenWidth, screenHeight);
  final bool isTablet, isPhone, hasNotch;
  static Device? _device;
  static Function? onMetricsChange;

  Device({required this.isTablet, required this.isPhone, required this.hasNotch});

  factory Device.get() {
    if (_device != null) return _device!;

    if (onMetricsChange == null) {
      onMetricsChange = ui.window.onMetricsChanged;
      ui.window.onMetricsChanged = () {
        _device = null;
        screenWidth = width / devicePixelRatio;
        screenHeight = height / devicePixelRatio;
        screenSize = ui.Size(screenWidth, screenHeight);
        onMetricsChange!();
      };
    }

    bool isTablet;
    bool isPhone;
    bool hasNotch = false;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }

    if (_hasTopOrBottomPadding()) hasNotch = true;

    return _device = Device(
        isTablet: isTablet,
        isPhone: isPhone,
        hasNotch: hasNotch);
  }

  static bool _hasTopOrBottomPadding() {
    final padding = ui.window.viewPadding;
    return padding.top > 0 || padding.bottom > 0;
  }
}