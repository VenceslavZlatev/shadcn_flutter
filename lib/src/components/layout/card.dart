import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme data for customizing [Card] and [SurfaceCard] widget appearance.
///
/// This class defines the visual properties that can be applied to card widgets,
/// including padding, fill behavior, colors, borders, shadows, and surface effects.
/// These properties can be set at the theme level to provide consistent styling
/// across the application.
///
/// The theme affects both regular cards and surface cards, with surface cards
/// supporting additional blur and opacity effects for glassmorphism styling.
class CardTheme {
  /// Padding inside the card.
  final EdgeInsetsGeometry? padding;

  /// Whether the card is filled.
  final bool? filled;

  /// The fill color when [filled] is true.
  final Color? fillColor;

  /// Border radius of the card.
  final BorderRadiusGeometry? borderRadius;

  /// Border color of the card.
  final Color? borderColor;

  /// Border width of the card.
  final double? borderWidth;

  /// Clip behavior of the card.
  final Clip? clipBehavior;

  /// Box shadow of the card.
  final List<BoxShadow>? boxShadow;

  /// Surface opacity for blurred background.
  final double? surfaceOpacity;

  /// Surface blur for blurred background.
  final double? surfaceBlur;

  /// Animation duration for transitions.
  final Duration? duration;

  /// Creates a [CardTheme].
  const CardTheme({
    this.padding,
    this.filled,
    this.fillColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.clipBehavior,
    this.boxShadow,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.duration,
  });

  /// Creates a copy of this theme with the given values replaced.
  CardTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<bool?>? filled,
    ValueGetter<Color?>? fillColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<Clip?>? clipBehavior,
    ValueGetter<List<BoxShadow>?>? boxShadow,
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
    ValueGetter<Duration?>? duration,
  }) {
    return CardTheme(
      padding: padding == null ? this.padding : padding(),
      filled: filled == null ? this.filled : filled(),
      fillColor: fillColor == null ? this.fillColor : fillColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      clipBehavior: clipBehavior == null ? this.clipBehavior : clipBehavior(),
      boxShadow: boxShadow == null ? this.boxShadow : boxShadow(),
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      duration: duration == null ? this.duration : duration(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CardTheme &&
        other.padding == padding &&
        other.filled == filled &&
        other.fillColor == fillColor &&
        other.borderRadius == borderRadius &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.clipBehavior == clipBehavior &&
        other.boxShadow == boxShadow &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.duration == duration;
  }

  @override
  int get hashCode => Object.hash(
        padding,
        filled,
        fillColor,
        borderRadius,
        borderColor,
        borderWidth,
        clipBehavior,
        boxShadow,
        surfaceOpacity,
        surfaceBlur,
        duration,
      );
}

/// A versatile container widget that provides a card-like appearance with comprehensive styling options.
///
/// [Card] is a foundational layout component that wraps content in a visually distinct
/// container with configurable borders, shadows, fills, and surface effects. It serves
/// as the basis for many UI patterns including content cards, panels, sections, and
/// grouped information displays.
///
/// Key features:
/// - Flexible fill and border styling options
/// - Configurable shadow effects for depth perception
/// - Customizable corner radius and clipping behavior
/// - Surface effects for glassmorphism and blur styling
/// - Responsive padding with theme integration
/// - Animation support for state transitions
/// - Consistent theming across the application
///
/// The card supports various visual modes:
/// - Filled cards with solid background colors
/// - Outlined cards with transparent backgrounds and borders
/// - Surface cards with blur effects and opacity
/// - Elevated cards with shadow effects
/// - Custom combinations of fill, border, and shadow
///
/// Visual hierarchy can be achieved through:
/// - Shadow depth for elevation indication
/// - Fill colors for emphasis and categorization
/// - Border styles for subtle grouping
/// - Surface effects for modern glass-like appearances
///
/// Example:
/// ```dart
/// Card(
///   filled: true,
///   fillColor: Colors.white,
///   borderRadius: BorderRadius.circular(12),
///   boxShadow: [
///     BoxShadow(
///       color: Colors.black.withOpacity(0.1),
///       blurRadius: 8,
///       offset: Offset(0, 2),
///     ),
///   ],
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Column(
///       children: [
///         Text('Card Title', style: TextStyle(fontWeight: FontWeight.bold)),
///         SizedBox(height: 8),
///         Text('Card content goes here...'),
///       ],
///     ),
///   ),
/// );
/// ```
class Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool? filled;
  final Color? fillColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Clip? clipBehavior;
  final List<BoxShadow>? boxShadow;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final Duration? duration;

  const Card({
    super.key,
    required this.child,
    this.padding,
    this.filled,
    this.fillColor,
    this.borderRadius,
    this.clipBehavior,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<CardTheme>(context);
    final scaling = theme.scaling;
    final padding = styleValue(
      widgetValue: this.padding,
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.all(16 * scaling),
    );
    final filled = styleValue(
      widgetValue: this.filled,
      themeValue: compTheme?.filled,
      defaultValue: false,
    );
    final fillColor = styleValue(
      widgetValue: this.fillColor,
      themeValue: compTheme?.fillColor,
      defaultValue: theme.colorScheme.border,
    );
    final borderRadius = styleValue(
      widgetValue: this.borderRadius,
      themeValue: compTheme?.borderRadius,
      defaultValue: null,
    );
    final borderColor = styleValue(
      widgetValue: this.borderColor,
      themeValue: compTheme?.borderColor,
      defaultValue: null,
    );
    final borderWidth = styleValue(
      widgetValue: this.borderWidth,
      themeValue: compTheme?.borderWidth,
      defaultValue: null,
    );
    final clipBehavior = styleValue(
      widgetValue: this.clipBehavior,
      themeValue: compTheme?.clipBehavior,
      defaultValue: Clip.none,
    );
    final boxShadow = styleValue(
      widgetValue: this.boxShadow,
      themeValue: compTheme?.boxShadow,
      defaultValue: null,
    );
    final surfaceOpacity = styleValue(
      widgetValue: this.surfaceOpacity,
      themeValue: compTheme?.surfaceOpacity,
      defaultValue: null,
    );
    final surfaceBlur = styleValue(
      widgetValue: this.surfaceBlur,
      themeValue: compTheme?.surfaceBlur,
      defaultValue: null,
    );
    final duration = styleValue(
      widgetValue: this.duration,
      themeValue: compTheme?.duration,
      defaultValue: null,
    );

    return OutlinedContainer(
      clipBehavior: clipBehavior,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      backgroundColor:
          filled ? fillColor : theme.colorScheme.card,
      boxShadow: boxShadow,
      padding: padding,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      duration: duration,
      child: DefaultTextStyle.merge(
        child: child,
        style: TextStyle(
          color: theme.colorScheme.cardForeground,
        ),
      ),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool? filled;
  final Color? fillColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Clip? clipBehavior;
  final List<BoxShadow>? boxShadow;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final Duration? duration;

  const SurfaceCard({
    super.key,
    required this.child,
    this.padding,
    this.filled,
    this.fillColor,
    this.borderRadius,
    this.clipBehavior,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<CardTheme>(context);
    var isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
    final scaling = theme.scaling;
    if (isSheetOverlay) {
      final padding = styleValue(
        widgetValue: this.padding,
        themeValue: compTheme?.padding,
        defaultValue: EdgeInsets.all(16 * scaling),
      );
      return Padding(
        padding: padding,
        child: child,
      );
    }
    return Card(
      clipBehavior: clipBehavior,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      filled: filled,
      fillColor: fillColor,
      boxShadow: boxShadow,
      padding: padding,
      surfaceOpacity:
          surfaceOpacity ?? compTheme?.surfaceOpacity ?? theme.surfaceOpacity,
      surfaceBlur:
          surfaceBlur ?? compTheme?.surfaceBlur ?? theme.surfaceBlur,
      duration: duration ?? compTheme?.duration,
      child: child,
    );
  }
}

