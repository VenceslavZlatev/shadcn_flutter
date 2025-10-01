import '../../shadcn_flutter.dart';
import 'dart:ui';
void _assertNotThemeModeSystem(ThemeMode mode, String label) {
  if (mode == ThemeMode.system) {
    final List<DiagnosticsNode> diagnosticList = [];
    diagnosticList.add(ErrorSummary('ColorSchemes.${label.toLowerCase()}(ThemeMode mode) can only be used with ThemeMode.light or ThemeMode.dark.'));
    diagnosticList.add(ErrorDescription('This method is only intended as a helper method to get either ColorSchemes.light$label() or ColorSchemes.dark$label().'));
    diagnosticList.add(ErrorHint('To use system theme mode, do this:\n'
      'ShadcnApp(\n'
      '  theme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.light)),\n'
      '  darkTheme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.dark)),\n'
      '  themeMode: ThemeMode.system, // optional, default is ThemeMode.system\n'
      ')\n'
      'or:\n'
      'ShadcnApp(\n'
      '  theme: ThemeData(colorScheme: ColorSchemes.light$label),\n'
      '  darkTheme: ThemeData(colorScheme: ColorSchemes.dark$label),\n'
      ')\n'
      'instead of:\n'
      'ShadcnApp(\n'
      '  theme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.system)),\n'
      ')'));
    throw FlutterError.fromParts(diagnosticList);
  }
}
class ColorSchemes {
  ColorSchemes._();
	static const ColorScheme lightBlue = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF09090B),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF09090B),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF09090B),
			primary: Color(0xFF2B7FFF),
			primaryForeground: Color(0xFFEFF6FF),
			secondary: Color(0xFFF4F4F5),
			secondaryForeground: Color(0xFF18181B),
			muted: Color(0xFFF4F4F5),
			mutedForeground: Color(0xFF71717B),
			accent: Color(0xFFF4F4F5),
			accentForeground: Color(0xFF18181B),
			destructive: Color(0xFFE7000B),
			border: Color(0xFFE4E4E7),
			input: Color(0xFFE4E4E7),
			ring: Color(0xFF2B7FFF),
			chart1: Color(0xFFF54900),
			chart2: Color(0xFF009689),
			chart3: Color(0xFF104E64),
			chart4: Color(0xFFFFB900),
			chart5: Color(0xFFFE9A00),
			sidebar: Color(0xFFFAFAFA),
			sidebarForeground: Color(0xFF09090B),
			sidebarPrimary: Color(0xFF2B7FFF),
			sidebarPrimaryForeground: Color(0xFFEFF6FF),
			sidebarAccent: Color(0xFFF4F4F5),
			sidebarAccentForeground: Color(0xFF18181B),
			sidebarBorder: Color(0xFFE4E4E7),
			sidebarRing: Color(0xFF2B7FFF),
		);

	static const ColorScheme darkBlue = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF09090B),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF18181B),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF18181B),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFF155DFC),
			primaryForeground: Color(0xFF1C398E),
			secondary: Color(0xFF27272A),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF27272A),
			mutedForeground: Color(0xFF9F9FA9),
			accent: Color(0xFF27272A),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFFFF6467),
			border: Color(0x1AFFFFFF),
			input: Color(0x26FFFFFF),
			ring: Color(0xFF1447E6),
			chart1: Color(0xFF1447E6),
			chart2: Color(0xFF00BC7D),
			chart3: Color(0xFFFE9A00),
			chart4: Color(0xFFAD46FF),
			chart5: Color(0xFFFF2056),
			sidebar: Color(0xFF18181B),
			sidebarForeground: Color(0xFFFAFAFA),
			sidebarPrimary: Color(0xFF155DFC),
			sidebarPrimaryForeground: Color(0xFF1C398E),
			sidebarAccent: Color(0xFF27272A),
			sidebarAccentForeground: Color(0xFFFAFAFA),
			sidebarBorder: Color(0x1AFFFFFF),
			sidebarRing: Color(0xFF1447E6),
		);

	static ColorScheme blue(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Blue');
			return true;
		}());
		return mode == ThemeMode.light ? lightBlue : darkBlue;
	}

	static const ColorScheme lightDefaultColor = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF0A0A0A),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF0A0A0A),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF0A0A0A),
			primary: Color(0xFF171717),
			primaryForeground: Color(0xFFFAFAFA),
			secondary: Color(0xFFF5F5F5),
			secondaryForeground: Color(0xFF171717),
			muted: Color(0xFFF5F5F5),
			mutedForeground: Color(0xFF737373),
			accent: Color(0xFFF5F5F5),
			accentForeground: Color(0xFF171717),
			destructive: Color(0xFFE7000B),
			border: Color(0xFFE5E5E5),
			input: Color(0xFFE5E5E5),
			ring: Color(0xFFA1A1A1),
			chart1: Color(0xFFF54900),
			chart2: Color(0xFF009689),
			chart3: Color(0xFF104E64),
			chart4: Color(0xFFFFB900),
			chart5: Color(0xFFFE9A00),
			sidebar: Color(0xFFFAFAFA),
			sidebarForeground: Color(0xFF0A0A0A),
			sidebarPrimary: Color(0xFF171717),
			sidebarPrimaryForeground: Color(0xFFFAFAFA),
			sidebarAccent: Color(0xFFF5F5F5),
			sidebarAccentForeground: Color(0xFF171717),
			sidebarBorder: Color(0xFFE5E5E5),
			sidebarRing: Color(0xFFA1A1A1),
		);

	static const ColorScheme darkDefaultColor = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF0A0A0A),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF171717),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF171717),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFFE5E5E5),
			primaryForeground: Color(0xFF171717),
			secondary: Color(0xFF262626),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF262626),
			mutedForeground: Color(0xFFA1A1A1),
			accent: Color(0xFF262626),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFFFF6467),
			border: Color(0x1AFFFFFF),
			input: Color(0x26FFFFFF),
			ring: Color(0xFF737373),
			chart1: Color(0xFF1447E6),
			chart2: Color(0xFF00BC7D),
			chart3: Color(0xFFFE9A00),
			chart4: Color(0xFFAD46FF),
			chart5: Color(0xFFFF2056),
			sidebar: Color(0xFF171717),
			sidebarForeground: Color(0xFFFAFAFA),
			sidebarPrimary: Color(0xFF1447E6),
			sidebarPrimaryForeground: Color(0xFFFAFAFA),
			sidebarAccent: Color(0xFF262626),
			sidebarAccentForeground: Color(0xFFFAFAFA),
			sidebarBorder: Color(0x1AFFFFFF),
			sidebarRing: Color(0xFF737373),
		);

	static ColorScheme defaultcolor(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'DefaultColor');
			return true;
		}());
		return mode == ThemeMode.light ? lightDefaultColor : darkDefaultColor;
	}

	static const ColorScheme lightGreen = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF09090B),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF09090B),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF09090B),
			primary: Color(0xFF00C950),
			primaryForeground: Color(0xFFF0FDF4),
			secondary: Color(0xFFF4F4F5),
			secondaryForeground: Color(0xFF18181B),
			muted: Color(0xFFF4F4F5),
			mutedForeground: Color(0xFF71717B),
			accent: Color(0xFFF4F4F5),
			accentForeground: Color(0xFF18181B),
			destructive: Color(0xFFE7000B),
			border: Color(0xFFE4E4E7),
			input: Color(0xFFE4E4E7),
			ring: Color(0xFF00C950),
			chart1: Color(0xFFF54900),
			chart2: Color(0xFF009689),
			chart3: Color(0xFF104E64),
			chart4: Color(0xFFFFB900),
			chart5: Color(0xFFFE9A00),
			sidebar: Color(0xFFFAFAFA),
			sidebarForeground: Color(0xFF09090B),
			sidebarPrimary: Color(0xFF00C950),
			sidebarPrimaryForeground: Color(0xFFF0FDF4),
			sidebarAccent: Color(0xFFF4F4F5),
			sidebarAccentForeground: Color(0xFF18181B),
			sidebarBorder: Color(0xFFE4E4E7),
			sidebarRing: Color(0xFF00C950),
		);

	static const ColorScheme darkGreen = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF09090B),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF18181B),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF18181B),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFF00BC7D),
			primaryForeground: Color(0xFF0D542B),
			secondary: Color(0xFF27272A),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF27272A),
			mutedForeground: Color(0xFF9F9FA9),
			accent: Color(0xFF27272A),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFFFF6467),
			border: Color(0x1AFFFFFF),
			input: Color(0x26FFFFFF),
			ring: Color(0xFF008236),
			chart1: Color(0xFF1447E6),
			chart2: Color(0xFF00BC7D),
			chart3: Color(0xFFFE9A00),
			chart4: Color(0xFFAD46FF),
			chart5: Color(0xFFFF2056),
			sidebar: Color(0xFF18181B),
			sidebarForeground: Color(0xFFFAFAFA),
			sidebarPrimary: Color(0xFF00BC7D),
			sidebarPrimaryForeground: Color(0xFF0D542B),
			sidebarAccent: Color(0xFF27272A),
			sidebarAccentForeground: Color(0xFFFAFAFA),
			sidebarBorder: Color(0x1AFFFFFF),
			sidebarRing: Color(0xFF008236),
		);

	static ColorScheme green(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Green');
			return true;
		}());
		return mode == ThemeMode.light ? lightGreen : darkGreen;
	}

	static const ColorScheme lightOrange = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF09090B),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF09090B),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF09090B),
			primary: Color(0xFFFF6900),
			primaryForeground: Color(0xFFFFF7ED),
			secondary: Color(0xFFF4F4F5),
			secondaryForeground: Color(0xFF18181B),
			muted: Color(0xFFF4F4F5),
			mutedForeground: Color(0xFF71717B),
			accent: Color(0xFFF4F4F5),
			accentForeground: Color(0xFF18181B),
			destructive: Color(0xFFE7000B),
			border: Color(0xFFE4E4E7),
			input: Color(0xFFE4E4E7),
			ring: Color(0xFFFF6900),
			chart1: Color(0xFFF54900),
			chart2: Color(0xFF009689),
			chart3: Color(0xFF104E64),
			chart4: Color(0xFFFFB900),
			chart5: Color(0xFFFE9A00),
			sidebar: Color(0xFFFAFAFA),
			sidebarForeground: Color(0xFF09090B),
			sidebarPrimary: Color(0xFFFF6900),
			sidebarPrimaryForeground: Color(0xFFFFF7ED),
			sidebarAccent: Color(0xFFF4F4F5),
			sidebarAccentForeground: Color(0xFF18181B),
			sidebarBorder: Color(0xFFE4E4E7),
			sidebarRing: Color(0xFFFF6900),
		);

	static const ColorScheme darkOrange = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF09090B),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF18181B),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF18181B),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFFF54900),
			primaryForeground: Color(0xFFFFF7ED),
			secondary: Color(0xFF27272A),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF27272A),
			mutedForeground: Color(0xFF9F9FA9),
			accent: Color(0xFF27272A),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFFFF6467),
			border: Color(0x1AFFFFFF),
			input: Color(0x26FFFFFF),
			ring: Color(0xFFF54900),
			chart1: Color(0xFF1447E6),
			chart2: Color(0xFF00BC7D),
			chart3: Color(0xFFFE9A00),
			chart4: Color(0xFFAD46FF),
			chart5: Color(0xFFFF2056),
			sidebar: Color(0xFF18181B),
			sidebarForeground: Color(0xFFFAFAFA),
			sidebarPrimary: Color(0xFFF54900),
			sidebarPrimaryForeground: Color(0xFFFFF7ED),
			sidebarAccent: Color(0xFF27272A),
			sidebarAccentForeground: Color(0xFFFAFAFA),
			sidebarBorder: Color(0x1AFFFFFF),
			sidebarRing: Color(0xFFF54900),
		);

	static ColorScheme orange(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Orange');
			return true;
		}());
		return mode == ThemeMode.light ? lightOrange : darkOrange;
	}

	static const ColorScheme lightRed = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF09090B),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF09090B),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF09090B),
			primary: Color(0xFFFB2C36),
			primaryForeground: Color(0xFFFEF2F2),
			secondary: Color(0xFFF4F4F5),
			secondaryForeground: Color(0xFF18181B),
			muted: Color(0xFFF4F4F5),
			mutedForeground: Color(0xFF71717B),
			accent: Color(0xFFF4F4F5),
			accentForeground: Color(0xFF18181B),
			destructive: Color(0xFFE7000B),
			border: Color(0xFFE4E4E7),
			input: Color(0xFFE4E4E7),
			ring: Color(0xFFFB2C36),
			chart1: Color(0xFFF54900),
			chart2: Color(0xFF009689),
			chart3: Color(0xFF104E64),
			chart4: Color(0xFFFFB900),
			chart5: Color(0xFFFE9A00),
			sidebar: Color(0xFFFAFAFA),
			sidebarForeground: Color(0xFF09090B),
			sidebarPrimary: Color(0xFFFB2C36),
			sidebarPrimaryForeground: Color(0xFFFEF2F2),
			sidebarAccent: Color(0xFFF4F4F5),
			sidebarAccentForeground: Color(0xFF18181B),
			sidebarBorder: Color(0xFFE4E4E7),
			sidebarRing: Color(0xFFFB2C36),
		);

	static const ColorScheme darkRed = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF09090B),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF18181B),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF18181B),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFFFB2C36),
			primaryForeground: Color(0xFFFEF2F2),
			secondary: Color(0xFF27272A),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF27272A),
			mutedForeground: Color(0xFF9F9FA9),
			accent: Color(0xFF27272A),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFFFF6467),
			border: Color(0x1AFFFFFF),
			input: Color(0x26FFFFFF),
			ring: Color(0xFFFB2C36),
			chart1: Color(0xFF1447E6),
			chart2: Color(0xFF00BC7D),
			chart3: Color(0xFFFE9A00),
			chart4: Color(0xFFAD46FF),
			chart5: Color(0xFFFF2056),
			sidebar: Color(0xFF18181B),
			sidebarForeground: Color(0xFFFAFAFA),
			sidebarPrimary: Color(0xFFFB2C36),
			sidebarPrimaryForeground: Color(0xFFFEF2F2),
			sidebarAccent: Color(0xFF27272A),
			sidebarAccentForeground: Color(0xFFFAFAFA),
			sidebarBorder: Color(0x1AFFFFFF),
			sidebarRing: Color(0xFFFB2C36),
		);

	static ColorScheme red(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Red');
			return true;
		}());
		return mode == ThemeMode.light ? lightRed : darkRed;
	}

	static const ColorScheme lightRose = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF09090B),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF09090B),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF09090B),
			primary: Color(0xFFFF2056),
			primaryForeground: Color(0xFFFFF1F2),
			secondary: Color(0xFFF4F4F5),
			secondaryForeground: Color(0xFF18181B),
			muted: Color(0xFFF4F4F5),
			mutedForeground: Color(0xFF71717B),
			accent: Color(0xFFF4F4F5),
			accentForeground: Color(0xFF18181B),
			destructive: Color(0xFFE7000B),
			border: Color(0xFFE4E4E7),
			input: Color(0xFFE4E4E7),
			ring: Color(0xFFFF2056),
			chart1: Color(0xFFF54900),
			chart2: Color(0xFF009689),
			chart3: Color(0xFF104E64),
			chart4: Color(0xFFFFB900),
			chart5: Color(0xFFFE9A00),
			sidebar: Color(0xFFFAFAFA),
			sidebarForeground: Color(0xFF09090B),
			sidebarPrimary: Color(0xFFFF2056),
			sidebarPrimaryForeground: Color(0xFFFFF1F2),
			sidebarAccent: Color(0xFFF4F4F5),
			sidebarAccentForeground: Color(0xFF18181B),
			sidebarBorder: Color(0xFFE4E4E7),
			sidebarRing: Color(0xFFFF2056),
		);

	static const ColorScheme darkRose = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF09090B),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF18181B),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF18181B),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFFFF2056),
			primaryForeground: Color(0xFFFFF1F2),
			secondary: Color(0xFF27272A),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF27272A),
			mutedForeground: Color(0xFF9F9FA9),
			accent: Color(0xFF27272A),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFFFF6467),
			border: Color(0x1AFFFFFF),
			input: Color(0x26FFFFFF),
			ring: Color(0xFFFF2056),
			chart1: Color(0xFF1447E6),
			chart2: Color(0xFF00BC7D),
			chart3: Color(0xFFFE9A00),
			chart4: Color(0xFFAD46FF),
			chart5: Color(0xFFFF2056),
			sidebar: Color(0xFF18181B),
			sidebarForeground: Color(0xFFFAFAFA),
			sidebarPrimary: Color(0xFFFF2056),
			sidebarPrimaryForeground: Color(0xFFFFF1F2),
			sidebarAccent: Color(0xFF27272A),
			sidebarAccentForeground: Color(0xFFFAFAFA),
			sidebarBorder: Color(0x1AFFFFFF),
			sidebarRing: Color(0xFFFF2056),
		);

	static ColorScheme rose(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Rose');
			return true;
		}());
		return mode == ThemeMode.light ? lightRose : darkRose;
	}

	static const ColorScheme lightViolet = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF09090B),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF09090B),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF09090B),
			primary: Color(0xFF8E51FF),
			primaryForeground: Color(0xFFF5F3FF),
			secondary: Color(0xFFF4F4F5),
			secondaryForeground: Color(0xFF18181B),
			muted: Color(0xFFF4F4F5),
			mutedForeground: Color(0xFF71717B),
			accent: Color(0xFFF4F4F5),
			accentForeground: Color(0xFF18181B),
			destructive: Color(0xFFE7000B),
			border: Color(0xFFE4E4E7),
			input: Color(0xFFE4E4E7),
			ring: Color(0xFF8E51FF),
			chart1: Color(0xFFF54900),
			chart2: Color(0xFF009689),
			chart3: Color(0xFF104E64),
			chart4: Color(0xFFFFB900),
			chart5: Color(0xFFFE9A00),
			sidebar: Color(0xFFFAFAFA),
			sidebarForeground: Color(0xFF09090B),
			sidebarPrimary: Color(0xFF8E51FF),
			sidebarPrimaryForeground: Color(0xFFF5F3FF),
			sidebarAccent: Color(0xFFF4F4F5),
			sidebarAccentForeground: Color(0xFF18181B),
			sidebarBorder: Color(0xFFE4E4E7),
			sidebarRing: Color(0xFF8E51FF),
		);

	static const ColorScheme darkViolet = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF09090B),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF18181B),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF18181B),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFF7F22FE),
			primaryForeground: Color(0xFFF5F3FF),
			secondary: Color(0xFF27272A),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF27272A),
			mutedForeground: Color(0xFF9F9FA9),
			accent: Color(0xFF27272A),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFFFF6467),
			border: Color(0x1AFFFFFF),
			input: Color(0x26FFFFFF),
			ring: Color(0xFF7F22FE),
			chart1: Color(0xFF1447E6),
			chart2: Color(0xFF00BC7D),
			chart3: Color(0xFFFE9A00),
			chart4: Color(0xFFAD46FF),
			chart5: Color(0xFFFF2056),
			sidebar: Color(0xFF18181B),
			sidebarForeground: Color(0xFFFAFAFA),
			sidebarPrimary: Color(0xFF7F22FE),
			sidebarPrimaryForeground: Color(0xFFF5F3FF),
			sidebarAccent: Color(0xFF27272A),
			sidebarAccentForeground: Color(0xFFFAFAFA),
			sidebarBorder: Color(0x1AFFFFFF),
			sidebarRing: Color(0xFF7F22FE),
		);

	static ColorScheme violet(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Violet');
			return true;
		}());
		return mode == ThemeMode.light ? lightViolet : darkViolet;
	}

	static const ColorScheme lightYellow = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF09090B),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF09090B),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF09090B),
			primary: Color(0xFFF0B100),
			primaryForeground: Color(0xFF733E0A),
			secondary: Color(0xFFF4F4F5),
			secondaryForeground: Color(0xFF18181B),
			muted: Color(0xFFF4F4F5),
			mutedForeground: Color(0xFF71717B),
			accent: Color(0xFFF4F4F5),
			accentForeground: Color(0xFF18181B),
			destructive: Color(0xFFE7000B),
			border: Color(0xFFE4E4E7),
			input: Color(0xFFE4E4E7),
			ring: Color(0xFFF0B100),
			chart1: Color(0xFFF54900),
			chart2: Color(0xFF009689),
			chart3: Color(0xFF104E64),
			chart4: Color(0xFFFFB900),
			chart5: Color(0xFFFE9A00),
			sidebar: Color(0xFFFAFAFA),
			sidebarForeground: Color(0xFF09090B),
			sidebarPrimary: Color(0xFFF0B100),
			sidebarPrimaryForeground: Color(0xFF733E0A),
			sidebarAccent: Color(0xFFF4F4F5),
			sidebarAccentForeground: Color(0xFF18181B),
			sidebarBorder: Color(0xFFE4E4E7),
			sidebarRing: Color(0xFFF0B100),
		);

	static const ColorScheme darkYellow = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF09090B),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF18181B),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF18181B),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFFF0B100),
			primaryForeground: Color(0xFF733E0A),
			secondary: Color(0xFF27272A),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF27272A),
			mutedForeground: Color(0xFF9F9FA9),
			accent: Color(0xFF27272A),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFFFF6467),
			border: Color(0x1AFFFFFF),
			input: Color(0x26FFFFFF),
			ring: Color(0xFFA65F00),
			chart1: Color(0xFF1447E6),
			chart2: Color(0xFF00BC7D),
			chart3: Color(0xFFFE9A00),
			chart4: Color(0xFFAD46FF),
			chart5: Color(0xFFFF2056),
			sidebar: Color(0xFF18181B),
			sidebarForeground: Color(0xFFFAFAFA),
			sidebarPrimary: Color(0xFFF0B100),
			sidebarPrimaryForeground: Color(0xFF733E0A),
			sidebarAccent: Color(0xFF27272A),
			sidebarAccentForeground: Color(0xFFFAFAFA),
			sidebarBorder: Color(0x1AFFFFFF),
			sidebarRing: Color(0xFFA65F00),
		);

	static ColorScheme yellow(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Yellow');
			return true;
		}());
		return mode == ThemeMode.light ? lightYellow : darkYellow;
	}

}