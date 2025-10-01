import 'package:flutter/services.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

import '../../../shadcn_flutter.dart';

/// Standard duration for switch state transitions and animations.
const kSwitchDuration = Duration(milliseconds: 100);

/// Theme configuration for [Switch] widget styling and visual appearance.
///
/// Defines the visual properties used by switch components including colors,
/// spacing, and border styling for different switch states. All properties are
/// optional and fall back to framework defaults when not specified.
///
/// Supports comprehensive customization of switch appearance including track
/// colors, thumb colors, and layout properties to match application design.
class SwitchTheme {
  /// Color of the switch track when in the active/on state.
  ///
  /// Applied as the background color of the switch track when toggled on.
  /// When null, uses the theme's primary color for visual consistency.
  final Color? activeColor;

  /// Color of the switch track when in the inactive/off state.
  ///
  /// Applied as the background color of the switch track when toggled off.
  /// When null, uses the theme's muted color for visual hierarchy.
  final Color? inactiveColor;

  /// Color of the switch thumb when in the active/on state.
  ///
  /// Applied to the circular thumb element when the switch is toggled on.
  /// When null, uses the theme's primary foreground color for contrast.
  final Color? activeThumbColor;

  /// Color of the switch thumb when in the inactive/off state.
  ///
  /// Applied to the circular thumb element when the switch is toggled off.
  /// When null, uses a contrasting color against the inactive track.
  final Color? inactiveThumbColor;

  /// Spacing between the switch and its leading/trailing widgets.
  ///
  /// Applied on both sides of the switch when leading or trailing widgets
  /// are provided. When null, defaults to framework spacing standards.
  final double? gap;

  /// Border radius applied to the switch track corners.
  ///
  /// Creates rounded corners on the switch track container. When null,
  /// uses a fully rounded appearance typical of toggle switches.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [SwitchTheme].
  ///
  /// All parameters are optional and will use framework defaults when null.
  /// The theme can be applied to individual switches or globally through
  /// the component theme system.
  const SwitchTheme({
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.gap,
    this.borderRadius,
  });

  /// Returns a copy of this theme with the given fields replaced.
  SwitchTheme copyWith({
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? inactiveColor,
    ValueGetter<Color?>? activeThumbColor,
    ValueGetter<Color?>? inactiveThumbColor,
    ValueGetter<double?>? gap,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return SwitchTheme(
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      inactiveColor:
          inactiveColor == null ? this.inactiveColor : inactiveColor(),
      activeThumbColor:
          activeThumbColor == null ? this.activeThumbColor : activeThumbColor(),
      inactiveThumbColor: inactiveThumbColor == null
          ? this.inactiveThumbColor
          : inactiveThumbColor(),
      gap: gap == null ? this.gap : gap(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SwitchTheme &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor &&
        other.activeThumbColor == activeThumbColor &&
        other.inactiveThumbColor == inactiveThumbColor &&
        other.gap == gap &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
        activeColor,
        inactiveColor,
        activeThumbColor,
        inactiveThumbColor,
        gap,
        borderRadius,
      );
}

class SwitchController extends ValueNotifier<bool>
    with ComponentController<bool> {
  SwitchController([super.value = false]);

  void toggle() {
    value = !value;
  }
}

class ControlledSwitch extends StatelessWidget with ControlledComponent<bool> {
  @override
  final bool initialValue;
  @override
  final ValueChanged<bool>? onChanged;
  @override
  final bool enabled;
  @override
  final SwitchController? controller;

  final Widget? leading;
  final Widget? trailing;
  final double? gap;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final BorderRadiusGeometry? borderRadius;

  const ControlledSwitch({
    super.key,
    this.controller,
    this.initialValue = false,
    this.onChanged,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.gap,
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Switch(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          leading: leading,
          trailing: trailing,
          gap: gap,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          activeThumbColor: activeThumbColor,
          inactiveThumbColor: inactiveThumbColor,
          borderRadius: borderRadius,
        );
      },
    );
  }
}

class Switch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? leading;
  final Widget? trailing;
  final bool? enabled;
  final double? gap;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final BorderRadiusGeometry? borderRadius;

  const Switch({
    super.key,
    required this.value,
    required this.onChanged,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.gap,
    this.activeColor,
    this.inactiveColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.borderRadius,
  });

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> with FormValueSupplier<bool, Switch> {
  bool _focusing = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  bool get _enabled => widget.enabled ?? widget.onChanged != null;

  @override
  void didUpdateWidget(covariant Switch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(bool value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<SwitchTheme>(context);
    final gap = styleValue(
        widgetValue: widget.gap,
        themeValue: compTheme?.gap,
        defaultValue: 8 * scaling);
    final activeColor = styleValue(
        widgetValue: widget.activeColor,
        themeValue: compTheme?.activeColor,
        defaultValue: theme.colorScheme.primary);
    final inactiveColor = styleValue(
        widgetValue: widget.inactiveColor,
        themeValue: compTheme?.inactiveColor,
        defaultValue: theme.colorScheme.input);
    final activeThumbColor = styleValue(
        widgetValue: widget.activeThumbColor,
        themeValue: compTheme?.activeThumbColor,
        defaultValue: theme.colorScheme.background);
    final inactiveThumbColor = styleValue(
        widgetValue: widget.inactiveThumbColor,
        themeValue: compTheme?.inactiveThumbColor,
        defaultValue: theme.colorScheme.foreground);
    final borderRadius = styleValue<BorderRadiusGeometry>(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: BorderRadius.circular(theme.radiusXl));
    return FocusOutline(
      focused: _focusing && _enabled,
      borderRadius: optionallyResolveBorderRadius(context, borderRadius) ??
          BorderRadius.circular(theme.radiusXl),
      child: GestureDetector(
        onTap: _enabled
            ? () {
                widget.onChanged?.call(!widget.value);
              }
            : null,
        child: FocusableActionDetector(
          enabled: _enabled,
          onShowFocusHighlight: (value) {
            setState(() {
              _focusing = value;
            });
          },
          actions: {
            ActivateIntent: CallbackAction(
              onInvoke: (Intent intent) {
                widget.onChanged?.call(!widget.value);
                return true;
              },
            ),
          },
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
            SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
          },
          mouseCursor: _enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leading != null) widget.leading!,
              if (widget.leading != null) SizedBox(width: gap),
              AnimatedContainer(
                duration: kSwitchDuration,
                width: (32 + 4) * scaling,
                height: (16 + 4) * scaling,
                padding: EdgeInsets.all(2 * scaling),
                decoration: BoxDecoration(
                  borderRadius:
                      optionallyResolveBorderRadius(context, borderRadius) ??
                          BorderRadius.circular(theme.radiusXl),
                  color: !_enabled
                      ? theme.colorScheme.muted
                      : widget.value
                          ? activeColor
                          : inactiveColor,
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: kSwitchDuration,
                      curve: Curves.easeInOut,
                      left: widget.value ? 16 * scaling : 0,
                      top: 0,
                      bottom: 0,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(theme.radiusLg),
                            color: !_enabled
                                ? theme.colorScheme.mutedForeground
                                : widget.value
                                    ? activeThumbColor
                                    : inactiveThumbColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.trailing != null) SizedBox(width: gap),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
