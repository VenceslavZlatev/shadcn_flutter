import 'package:shadcn_flutter/shadcn_flutter.dart';

class BadgeExample3 extends StatelessWidget {
  const BadgeExample3({super.key});
  
  @override
  Widget build(BuildContext context) {
     return OutlineButton( padding: Button.badgePadding, child: Text('Outlined'), ); 
  }
}
    