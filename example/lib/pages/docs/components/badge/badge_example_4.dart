import 'package:shadcn_flutter/shadcn_flutter.dart';

class BadgeExample4 extends StatelessWidget {
  const BadgeExample4({super.key});
  
  @override
  Widget build(BuildContext context) {
     return DestructiveButton( padding: Button.badgePadding, child: Text('Destructive'), ); 
  }
}
    