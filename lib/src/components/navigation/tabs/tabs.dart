import 'package:shadcn_flutter/shadcn_flutter.dart';

class Tabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  final List<TabChild> children;
  final EdgeInsetsGeometry? padding;
  final bool enableWrap;
  final double spacing;
  final double runSpacing;

  const Tabs({
    super.key,
    required this.index,
    required this.onChanged,
    required this.children,
    this.padding,
    this.enableWrap = false,
    this.spacing = 4.0,
    this.runSpacing = 8.0,
  });

  Widget _childBuilder(BuildContext context, TabContainerData data, Widget child) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final i = data.index;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onChanged(i);
      },
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50), // slightly faster than kDefaultDuration
          alignment: Alignment.center,
          padding: padding ??
              const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ) *
                  scaling,
          decoration: BoxDecoration(
            color: i == index ? theme.colorScheme.background : null,
            borderRadius: BorderRadius.circular(
              theme.radiusMd,
            ),
          ),
          child: (i == index ? child.foreground() : child.muted()).small().medium(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return TabContainer(
      selected: index,
      onSelect: onChanged,
      builder: (context, children) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.muted,
            borderRadius: BorderRadius.circular(theme.radiusLg),
          ),
          padding: const EdgeInsets.all(4) * scaling,
          child: enableWrap
              ? Wrap(
                  spacing: spacing * scaling,
                  runSpacing: runSpacing * scaling,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: children,
                ).muted()
              : IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ).muted(),
                ),
        );
      },
      childBuilder: _childBuilder,
      children: children,
    );
  }
}
