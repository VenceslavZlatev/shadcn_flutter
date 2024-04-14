import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'checkbox/checkbox_example_1.dart';
class CheckboxExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'checkbox',
      description: 'Checkboxes allow the user to select one or more items from a set.',
      displayName: 'Checkbox',
      children: [
        WidgetUsageExample(
          child: CheckboxExample1(),
          path: 'lib/pages/docs/components/checkbox/checkbox_example_1.dart',
        ),
      ],
    );
  }
}
  