import 'package:shadcn_flutter/shadcn_flutter.dart';

class Progress extends StatelessWidget {
  final double? progress;
  final double min;
  final double max;
  final bool animated;
  final Duration duration;
  const Progress({
    super.key,
    this.progress,
    this.min = 0.0,
    this.max = 1.0,
    this.animated = true,
    this.duration = kDefaultDuration,
  }) : assert(progress != null && progress >= min && progress <= max,
            'Progress must be between min and max');

  double? get normalizedValue {
    if (progress == null) {
      return null;
    }
    return (progress! - min) / (max - min);
  }

  @override
  Widget build(BuildContext context) {
    final progress = normalizedValue;
    if (!animated) {
      if (progress == null) {
        return buildBar(context, 0.0, 0.0);
      } else {
        return buildBar(context, 0.0, progress);
      }
    } else {
      if (progress == null) {
        return buildIndeterminate(context);
      } else {
        return AnimatedValueBuilder(
          value: progress,
          duration: duration,
          builder: (context, value) {
            return buildBar(context, 0.0, value);
          },
        );
      }
    }
  }

  Widget buildBar(BuildContext context, double startOffset, double endOffset) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(theme.radiusMd),
          color: theme.colorScheme.primary.withOpacity(0.2),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              left: startOffset * constraints.maxWidth,
              right: (1 - endOffset) * constraints.maxWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildIndeterminate(BuildContext context) {
    // TODO: would be nice to have an indeterminate progress bar
    return buildBar(context, 0.0, 0.0);
  }
}
