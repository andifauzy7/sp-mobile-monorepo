/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/add-square.svg
  SvgGenImage get addSquare => const SvgGenImage('assets/icon/add-square.svg');

  /// File path: assets/icon/arrow-circle-left.svg
  SvgGenImage get arrowCircleLeft =>
      const SvgGenImage('assets/icon/arrow-circle-left.svg');

  /// File path: assets/icon/arrow-circle-right.svg
  SvgGenImage get arrowCircleRight =>
      const SvgGenImage('assets/icon/arrow-circle-right.svg');

  /// File path: assets/icon/arrow-down.svg
  SvgGenImage get arrowDown => const SvgGenImage('assets/icon/arrow-down.svg');

  /// File path: assets/icon/arrow-left.svg
  SvgGenImage get arrowLeft => const SvgGenImage('assets/icon/arrow-left.svg');

  /// File path: assets/icon/arrow-right.svg
  SvgGenImage get arrowRight =>
      const SvgGenImage('assets/icon/arrow-right.svg');

  /// File path: assets/icon/calendar-picker.svg
  SvgGenImage get calendarPicker =>
      const SvgGenImage('assets/icon/calendar-picker.svg');

  /// File path: assets/icon/calendar.svg
  SvgGenImage get calendar => const SvgGenImage('assets/icon/calendar.svg');

  /// File path: assets/icon/consultation.svg
  SvgGenImage get consultation =>
      const SvgGenImage('assets/icon/consultation.svg');

  /// File path: assets/icon/edit.svg
  SvgGenImage get edit => const SvgGenImage('assets/icon/edit.svg');

  /// File path: assets/icon/empty-checkbox.svg
  SvgGenImage get emptyCheckbox =>
      const SvgGenImage('assets/icon/empty-checkbox.svg');

  /// File path: assets/icon/filter.svg
  SvgGenImage get filter => const SvgGenImage('assets/icon/filter.svg');

  /// File path: assets/icon/history.svg
  SvgGenImage get history => const SvgGenImage('assets/icon/history.svg');

  /// File path: assets/icon/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icon/home.svg');

  /// File path: assets/icon/logout.svg
  SvgGenImage get logout => const SvgGenImage('assets/icon/logout.svg');

  /// File path: assets/icon/notification.svg
  SvgGenImage get notification =>
      const SvgGenImage('assets/icon/notification.svg');

  /// File path: assets/icon/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/icon/profile.svg');

  /// File path: assets/icon/search-normal.svg
  SvgGenImage get searchNormal =>
      const SvgGenImage('assets/icon/search-normal.svg');

  /// File path: assets/icon/timer.svg
  SvgGenImage get timer => const SvgGenImage('assets/icon/timer.svg');

  /// File path: assets/icon/true-checkbox.svg
  SvgGenImage get trueCheckbox =>
      const SvgGenImage('assets/icon/true-checkbox.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        addSquare,
        arrowCircleLeft,
        arrowCircleRight,
        arrowDown,
        arrowLeft,
        arrowRight,
        calendarPicker,
        calendar,
        consultation,
        edit,
        emptyCheckbox,
        filter,
        history,
        home,
        logout,
        notification,
        profile,
        searchNormal,
        timer,
        trueCheckbox
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/circle_background.png
  AssetGenImage get circleBackground =>
      const AssetGenImage('assets/images/circle_background.png');

  /// File path: assets/images/dot_ornament.png
  AssetGenImage get dotOrnament =>
      const AssetGenImage('assets/images/dot_ornament.png');

  /// File path: assets/images/forgot_password_background.png
  AssetGenImage get forgotPasswordBackground =>
      const AssetGenImage('assets/images/forgot_password_background.png');

  /// File path: assets/images/forgot_password_ornament.png
  AssetGenImage get forgotPasswordOrnament =>
      const AssetGenImage('assets/images/forgot_password_ornament.png');

  /// File path: assets/images/image_failure.png
  AssetGenImage get imageFailure =>
      const AssetGenImage('assets/images/image_failure.png');

  /// File path: assets/images/image_success.png
  AssetGenImage get imageSuccess =>
      const AssetGenImage('assets/images/image_success.png');

  /// File path: assets/images/splash_background.png
  AssetGenImage get splashBackground =>
      const AssetGenImage('assets/images/splash_background.png');

  /// File path: assets/images/splash_ornament.png
  AssetGenImage get splashOrnament =>
      const AssetGenImage('assets/images/splash_ornament.png');

  /// File path: assets/images/splash_welcome.png
  AssetGenImage get splashWelcome =>
      const AssetGenImage('assets/images/splash_welcome.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        circleBackground,
        dotOrnament,
        forgotPasswordBackground,
        forgotPasswordOrnament,
        imageFailure,
        imageSuccess,
        splashBackground,
        splashOrnament,
        splashWelcome
      ];
}

class SPAssets {
  SPAssets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
