import 'dart:ui';
import 'package:flutter/foundation.dart';

import '../../../shadcn_flutter.dart';

class DividerProperties {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

  const DividerProperties({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  static DividerProperties lerp(
      DividerProperties a, DividerProperties b, double t) {
    return DividerProperties(
      color: Color.lerp(a.color, b.color, t)!,
      thickness: lerpDouble(a.thickness, b.thickness, t)!,
      indent: lerpDouble(a.indent, b.indent, t)!,
      endIndent: lerpDouble(a.endIndent, b.endIndent, t)!,
    );
  }
}

/// Theme configuration for [Divider].
class DividerTheme {
  /// Color of the divider line.
  final Color? color;

  /// Height of the divider widget.
  final double? height;

  /// Thickness of the divider line.
  final double? thickness;

  /// Empty space to the leading edge of the divider.
  final double? indent;

  /// Empty space to the trailing edge of the divider.
  final double? endIndent;

  /// Padding around the [Divider.child].
  final EdgeInsetsGeometry? padding;

  /// Creates a [DividerTheme].
  const DividerTheme({
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.padding,
  });

  /// Creates a copy of this theme but with the given fields replaced by the
  /// new values.
  DividerTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<double?>? height,
    ValueGetter<double?>? thickness,
    ValueGetter<double?>? indent,
    ValueGetter<double?>? endIndent,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return DividerTheme(
      color: color == null ? this.color : color(),
      height: height == null ? this.height : height(),
      thickness: thickness == null ? this.thickness : thickness(),
      indent: indent == null ? this.indent : indent(),
      endIndent: endIndent == null ? this.endIndent : endIndent(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is DividerTheme &&
      color == other.color &&
      height == other.height &&
      thickness == other.thickness &&
      indent == other.indent &&
      endIndent == other.endIndent &&
      padding == other.padding;

  @override
  int get hashCode =>
      Object.hash(color, height, thickness, indent, endIndent, padding);
}

class Divider extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const Divider({
    super.key,
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding,
  });

  @override
  Size get preferredSize => Size(0, height ?? 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<DividerTheme>(context);
    final color = styleValue(
      widgetValue: this.color,
      themeValue: compTheme?.color,
      defaultValue: theme.colorScheme.border,
    );
    final thickness = styleValue(
      widgetValue: this.thickness,
      themeValue: compTheme?.thickness,
      defaultValue: 1.0,
    );
    final height = styleValue(
      widgetValue: this.height,
      themeValue: compTheme?.height,
      defaultValue: thickness,
    );
    final indent = styleValue(
      widgetValue: this.indent,
      themeValue: compTheme?.indent,
      defaultValue: 0.0,
    );
    final endIndent = styleValue(
      widgetValue: this.endIndent,
      themeValue: compTheme?.endIndent,
      defaultValue: 0.0,
    );
    final padding = styleValue(
      widgetValue: this.padding,
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.symmetric(horizontal: theme.scaling * 8),
    );
    if (child != null) {
      return SizedBox(
        width: double.infinity,
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  height: height,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color,
                        thickness: thickness,
                        indent: indent,
                        endIndent: 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: DividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
              child!.muted().small().withPadding(padding: padding),
              Expanded(
                child: SizedBox(
                  height: height,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color,
                        thickness: thickness,
                        indent: 0,
                        endIndent: endIndent,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: DividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      height: height,
      width: double.infinity,
      child: AnimatedValueBuilder(
          value: DividerProperties(
            color: color,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
          ),
          lerp: DividerProperties.lerp,
          duration: kDefaultDuration,
          builder: (context, value, child) {
            return CustomPaint(
              painter: DividerPainter(
                color: value.color,
                thickness: value.thickness,
                indent: value.indent,
                endIndent: value.endIndent,
              ),
            );
          }),
    );
  }
}

class DividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

  DividerPainter({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.square;
    final start = Offset(indent, size.height / 2);
    final end = Offset(size.width - endIndent, size.height / 2);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant DividerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent;
  }
}

class VerticalDividerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;

  const VerticalDividerPainter({
    required this.color,
    required this.thickness,
    required this.indent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.square;
    final start = Offset(size.width / 2, indent);
    final end = Offset(size.width / 2, size.height - endIndent);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant VerticalDividerPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.indent != indent ||
        oldDelegate.endIndent != endIndent;
  }
}

class VerticalDivider extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const VerticalDivider({
    super.key,
    this.color,
    this.width,
    this.thickness,
    this.indent,
    this.endIndent,
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Size get preferredSize => Size(width ?? 1, 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (child != null) {
      return SizedBox(
        height: double.infinity,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SizedBox(
                  width: width ?? 1,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: indent ?? 0,
                        endIndent: 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: VerticalDividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
              child!.muted().small().withPadding(padding: padding),
              Expanded(
                child: SizedBox(
                  width: width ?? 1,
                  child: AnimatedValueBuilder(
                      value: DividerProperties(
                        color: color ?? theme.colorScheme.border,
                        thickness: thickness ?? 1,
                        indent: 0,
                        endIndent: endIndent ?? 0,
                      ),
                      duration: kDefaultDuration,
                      lerp: DividerProperties.lerp,
                      builder: (context, value, child) {
                        return CustomPaint(
                          painter: VerticalDividerPainter(
                            color: value.color,
                            thickness: value.thickness,
                            indent: value.indent,
                            endIndent: value.endIndent,
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      width: width ?? 1,
      child: AnimatedValueBuilder(
          value: DividerProperties(
            color: color ?? theme.colorScheme.border,
            thickness: thickness ?? 1,
            indent: indent ?? 0,
            endIndent: endIndent ?? 0,
          ),
          lerp: DividerProperties.lerp,
          duration: kDefaultDuration,
          builder: (context, value, child) {
            return CustomPaint(
              painter: VerticalDividerPainter(
                color: value.color,
                thickness: value.thickness,
                indent: value.indent,
                endIndent: value.endIndent,
              ),
            );
          }),
    );
  }
}
