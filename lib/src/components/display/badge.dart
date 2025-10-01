import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for customizing badge widget appearance across different styles.
///
/// This class defines the visual properties that can be applied to various
/// badge types including [PrimaryBadge], [SecondaryBadge], [OutlineBadge],
/// and [DestructiveBadge]. Each badge style can have its own button styling
/// configuration to provide consistent appearance across the application.
class BadgeTheme {
  /// Style for [PrimaryBadge].
  final AbstractButtonStyle? primaryStyle;

  /// Style for [SecondaryBadge].
  final AbstractButtonStyle? secondaryStyle;

  /// Style for [OutlineBadge].
  final AbstractButtonStyle? outlineStyle;

  /// Style for [DestructiveBadge].
  final AbstractButtonStyle? destructiveStyle;

  /// Creates a [BadgeTheme].
  const BadgeTheme({
    this.primaryStyle,
    this.secondaryStyle,
    this.outlineStyle,
    this.destructiveStyle,
  });

  /// Returns a copy of this theme with the given fields replaced.
  BadgeTheme copyWith({
    ValueGetter<AbstractButtonStyle?>? primaryStyle,
    ValueGetter<AbstractButtonStyle?>? secondaryStyle,
    ValueGetter<AbstractButtonStyle?>? outlineStyle,
    ValueGetter<AbstractButtonStyle?>? destructiveStyle,
  }) {
    return BadgeTheme(
      primaryStyle: primaryStyle == null ? this.primaryStyle : primaryStyle(),
      secondaryStyle:
          secondaryStyle == null ? this.secondaryStyle : secondaryStyle(),
      outlineStyle: outlineStyle == null ? this.outlineStyle : outlineStyle(),
      destructiveStyle:
          destructiveStyle == null ? this.destructiveStyle : destructiveStyle(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BadgeTheme &&
        other.primaryStyle == primaryStyle &&
        other.secondaryStyle == secondaryStyle &&
        other.outlineStyle == outlineStyle &&
        other.destructiveStyle == destructiveStyle;
  }

  @override
  int get hashCode =>
      Object.hash(primaryStyle, secondaryStyle, outlineStyle, destructiveStyle);
}

/// A primary style badge widget for highlighting important information or status.
///
/// [PrimaryBadge] displays content in a prominent badge format using the primary
/// color scheme. It's designed for high-importance status indicators, labels,
/// and interactive elements that need to draw attention. The badge supports
/// leading and trailing widgets for icons or additional content.
///
/// Key features:
/// - Primary color styling with emphasis and contrast
/// - Optional tap handling for interactive badges
/// - Support for leading and trailing widgets (icons, counters, etc.)
/// - Customizable button styling through theme integration
/// - Compact size optimized for badge display
/// - Consistent visual hierarchy with other badge variants
///
/// The badge uses button-like styling but in a compact form factor suitable
/// for status displays, labels, and small interactive elements. It integrates
/// with the theme system to maintain visual consistency.
///
/// Common use cases:
/// - Status indicators (active, new, featured)
/// - Notification counts and alerts
/// - Category labels and tags
/// - Interactive filter chips
/// - Achievement or ranking displays
///
/// Example:
/// ```dart
/// PrimaryBadge(
///   child: Text('NEW'),
///   leading: Icon(Icons.star, size: 16),
///   onPressed: () => _showNewItems(),
/// );
/// 
/// // Non-interactive status badge
/// PrimaryBadge(
///   child: Text('5'),
///   trailing: Icon(Icons.notifications, size: 14),
/// );
/// ```
class PrimaryBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const PrimaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle = style ??
        compTheme?.primaryStyle ??
        const ButtonStyle.primary(
          size: ButtonSize.small,
          density: ButtonDensity.dense,
          shape: ButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

class SecondaryBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const SecondaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle = style ??
        compTheme?.secondaryStyle ??
        const ButtonStyle.secondary(
          size: ButtonSize.small,
          density: ButtonDensity.dense,
          shape: ButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

class OutlineBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const OutlineBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle = style ??
        compTheme?.outlineStyle ??
        const ButtonStyle.outline(
          size: ButtonSize.small,
          density: ButtonDensity.dense,
          shape: ButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

class DestructiveBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const DestructiveBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle = style ??
        compTheme?.destructiveStyle ??
        const ButtonStyle.destructive(
          size: ButtonSize.small,
          density: ButtonDensity.dense,
          shape: ButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}
