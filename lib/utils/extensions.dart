import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hospital/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

late PackageInfo appInfo;

late Box storage;

class HiveStorage implements IPersistStore {
  @override
  Future<void> init() async {
    await Hive.initFlutter();
    appInfo = await PackageInfo.fromPlatform();
    storage = await Hive.openBox<String>(appInfo.appName);
  }

  @override
  Future<void> delete(String key) async => storage.delete(key);

  @override
  Future<void> deleteAll() async => storage.clear();

  @override
  String? read(String key) => storage.get(key);

  @override
  Future<void> write<T>(String key, value) async => storage.put(key, value);
}

extension DynamicExtensions on dynamic {
  Text text({
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    return Text(
      toString(),
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      // ignore: deprecated_member_use
      textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

extension WidgetExtensions on Widget {
  Padding pad({
    double? all,
    double? right,
    double? left,
    double? top,
    double? bottom,
    double? horizontal,
    double? vertical,
  }) {
    EdgeInsetsGeometry edgeInsets = EdgeInsets.zero;

    if (all != null) {
      edgeInsets = EdgeInsets.all(all);
    } else if (horizontal != null || vertical != null) {
      edgeInsets = EdgeInsets.symmetric(
        vertical: vertical ?? 0.0,
        horizontal: horizontal ?? 0.0,
      );
    } else if (right != null || left != null || top != null || bottom != null) {
      edgeInsets = EdgeInsets.only(
        left: left ?? 0.0,
        right: right ?? 0.0,
        top: top ?? 0.0,
        bottom: bottom ?? 0.0,
      );
    } else {
      edgeInsets = EdgeInsets.all(8.0);
    }

    return Padding(padding: edgeInsets, child: this);
  }

  Widget center() => Center(child: this);
  Card card({
    Key? key,
    Color? color,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    ShapeBorder? shape,
    bool borderOnForeground = true,
    EdgeInsetsGeometry? margin,
    Clip? clipBehavior,
    bool semanticContainer = true,
  }) {
    return Card(
      key: key,
      color: color,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      shape: shape,
      borderOnForeground: borderOnForeground,
      margin: margin,
      clipBehavior: clipBehavior,
      semanticContainer: semanticContainer,
      child: this,
    );
  }
}
