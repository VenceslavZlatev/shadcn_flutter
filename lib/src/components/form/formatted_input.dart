import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

class FormattedInputTheme {
  final double? height;
  final EdgeInsetsGeometry? padding;

  const FormattedInputTheme({this.height, this.padding});

  FormattedInputTheme copyWith({
    ValueGetter<double?>? height,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return FormattedInputTheme(
      height: height == null ? this.height : height(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FormattedInputTheme &&
        other.height == height &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(height, padding);
}

abstract class InputPart implements FormattedValuePart {
  const factory InputPart.static(String text) = StaticPart;
  const factory InputPart.editable({
    required int length,
    bool obscureText,
    List<TextInputFormatter> inputFormatters,
    Widget? placeholder,
    required double width,
  }) = EditablePart;
  const factory InputPart.widget(Widget widget) = WidgetPart;

  const InputPart();
  Widget build(BuildContext context, FormattedInputData data);
  Object? get partKey;

  bool get canHaveValue => false;

  @override
  String? get value => null;

  @override
  InputPart get part => this;

  @override
  FormattedValuePart withValue(String value) {
    return FormattedValuePart(this, value);
  }
}

class WidgetPart extends InputPart {
  final Widget widget;

  const WidgetPart(this.widget);

  @override
  Widget build(BuildContext context, FormattedInputData data) {
    return widget;
  }

  @override
  Object? get partKey => widget.key;
}

class StaticPart extends InputPart {
  final String text;

  const StaticPart(this.text);

  @override
  Widget build(BuildContext context, FormattedInputData data) {
    return _StaticPartWidget(text: text);
  }

  @override
  String get partKey => text;

  @override
  String toString() {
    return 'StaticPart{text: $text}';
  }
}

class _StaticPartWidget extends StatefulWidget {
  final String text;
  const _StaticPartWidget({required this.text});

  @override
  State<_StaticPartWidget> createState() => _StaticPartWidgetState();
}

class _StaticPartWidgetState extends State<_StaticPartWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text).muted().base().center();
  }
}

class EditablePart extends InputPart {
  final int length;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final double width;
  final Widget? placeholder;
  const EditablePart({
    required this.length,
    this.obscureText = false,
    this.inputFormatters = const [],
    this.placeholder,
    required this.width,
  });

  @override
  Object? get partKey => null;

  @override
  bool get canHaveValue => true;

  @override
  Widget build(BuildContext context, FormattedInputData data) {
    return _EditablePartWidget(
      data: data,
      length: length,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      placeholder: placeholder,
      width: width,
    );
  }

  @override
  String toString() {
    return 'EditablePart{length: $length, obscureText: $obscureText, inputFormatters: $inputFormatters, width: $width, placeholder: $placeholder}';
  }
}

class _EditablePartController extends TextEditingController {
  final int maxLength;
  final bool hasPlaceholder;
  _EditablePartController(
      {required this.maxLength, required this.hasPlaceholder, super.text});

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final theme = Theme.of(context);
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      var text = this.text;
      if (text.isEmpty && hasPlaceholder) {
        return const TextSpan();
      }
      var padding = '_' * max(0, maxLength - text.length);
      return TextSpan(children: [
        TextSpan(
          style: style,
          text: text,
        ),
        TextSpan(
          style: style?.copyWith(color: theme.colorScheme.mutedForeground),
          text: padding,
        ),
      ]);
    }

    final TextStyle composingStyle =
        style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
            const TextStyle(decoration: TextDecoration.underline);
    var textBefore = value.composing.textBefore(value.text);
    var textInside = value.composing.textInside(value.text);
    var textAfter = value.composing.textAfter(value.text);
    int totalTextLength =
        textBefore.length + textInside.length + textAfter.length;
    if (totalTextLength == 0 && hasPlaceholder) {
      return const TextSpan();
    }
    var padding = '_' * max(0, maxLength - totalTextLength);
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: textBefore),
        TextSpan(
          style: composingStyle,
          text: textInside,
        ),
        TextSpan(text: textAfter),
        TextSpan(
          style: style?.copyWith(color: theme.colorScheme.mutedForeground),
          text: padding,
        ),
      ],
    );
  }
}

class _EditablePartWidget extends StatefulWidget {
  final FormattedInputData data;
  final int length;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final double width;
  final Widget? placeholder;
  const _EditablePartWidget({
    required this.length,
    required this.data,
    this.obscureText = false,
    this.inputFormatters = const [],
    this.placeholder,
    required this.width,
  });

  @override
  State<_EditablePartWidget> createState() => _EditablePartWidgetState();
}

class _EditablePartWidgetState extends State<_EditablePartWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _EditablePartController(
      maxLength: widget.length,
      hasPlaceholder: widget.placeholder != null,
      text: widget.data.initialValue,
    );
    if (widget.data.controller != null) {
      widget.data.controller!.addListener(_onFormattedInputControllerChange);
    }
  }

  bool _updating = false;
  void _onFormattedInputControllerChange() {
    if (_updating) {
      return;
    }
    _updating = true;
    try {
      if (widget.data.controller != null) {
        var value = widget.data.controller!.value;
        var part = value.values.elementAt(widget.data.partIndex);
        String newText = part.value ?? '';
        _controller.value = _controller.value.replaceText(newText);
      }
    } finally {
      _updating = false;
    }
  }

  @override
  void didUpdateWidget(covariant _EditablePartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      final oldValue = _controller.value;
      _controller = _EditablePartController(
        maxLength: widget.length,
        hasPlaceholder: widget.placeholder != null,
        text: oldValue.text,
      );
    }
    if (oldWidget.data.controller != widget.data.controller) {
      if (oldWidget.data.controller != null) {
        oldWidget.data.controller!
            .removeListener(_onFormattedInputControllerChange);
      }
      if (widget.data.controller != null) {
        widget.data.controller!.addListener(_onFormattedInputControllerChange);
      }
    }
  }

  @override
  void dispose() {
    if (widget.data.controller != null) {
      widget.data.controller!.removeListener(_onFormattedInputControllerChange);
    }
    super.dispose();
  }

  FormattedInputData get data => widget.data;

  void _onChanged(String value) {
    int length = value.length;
    if (length >= widget.length) {
      _nextFocus();
    }
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (_controller.selection.isCollapsed &&
            _controller.selection.baseOffset == 0) {
          _previousFocus();
          return KeyEventResult.handled;
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        if (_controller.selection.isCollapsed &&
            _controller.selection.baseOffset == 0) {
          _previousFocus();
          return KeyEventResult.handled;
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        if (_controller.selection.isCollapsed &&
            _controller.selection.baseOffset == _controller.text.length) {
          _nextFocus();
          return KeyEventResult.handled;
        }
      }
    }
    return KeyEventResult.ignored;
  }

  void _nextFocus() {
    int nextIndex = data.partIndex + 1;
    if (nextIndex < data.focusNodes.length) {
      FocusNode nextNode = data.focusNodes[nextIndex];
      nextNode.requestFocus();
    }
  }

  void _previousFocus() {
    int nextIndex = data.partIndex - 1;
    if (nextIndex >= 0) {
      FocusNode nextNode = data.focusNodes[nextIndex];
      nextNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Focus(
      onKeyEvent: _onKeyEvent,
      child: FormEntry(
        key: TextFieldKey(data.partIndex),
        child: SizedBox(
          width: widget.width,
          child: ComponentTheme(
            data: const FocusOutlineTheme(
              border: Border.fromBorderSide(BorderSide.none),
            ),
            child: TextField(
              focusNode: data.focusNode,
              controller: _controller,
              maxLength: widget.length,
              onChanged: _onChanged,
              decoration: const BoxDecoration(),
              style: DefaultTextStyle.of(context)
                  .style
                  .merge(theme.typography.mono),
              border: const Border.fromBorderSide(BorderSide.none),
              textAlign: TextAlign.center,
              initialValue: data.initialValue,
              maxLines: 1,
              obscureText: widget.obscureText,
              inputFormatters: widget.inputFormatters,
              placeholder: widget.placeholder,
              padding: EdgeInsets.symmetric(
                horizontal: 6 * theme.scaling,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormattedValuePart {
  final InputPart part;
  final String? value;

  const FormattedValuePart(this.part, [this.value]);

  FormattedValuePart withValue(String value) {
    return FormattedValuePart(part, value);
  }

  @override
  String toString() {
    return 'FormattedValuePart{part: $part, value: $value}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FormattedValuePart &&
        part == other.part &&
        value == other.value;
  }

  @override
  int get hashCode => Object.hash(part, value);
}

class FormattedValue {
  final List<FormattedValuePart> parts;

  const FormattedValue([this.parts = const []]);

  Iterable<FormattedValuePart> get values =>
      parts.where((part) => part.part.canHaveValue);

  FormattedValuePart? operator [](int index) {
    int partIndex = 0;
    for (var part in parts) {
      if (part.part.canHaveValue) {
        if (partIndex == index) {
          return part;
        }
        partIndex++;
      }
    }
    return null;
  }

  @override
  String toString() => parts.join();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FormattedValue && listEquals(parts, other.parts);
  }

  @override
  int get hashCode => parts.hashCode;
}

/// A controller for managing [FormattedInput] values programmatically.
///
/// This controller extends [ValueNotifier<FormattedValue>] to provide reactive
/// state management for formatted input components. It implements [ComponentController]
/// to integrate with the controlled component system, allowing external control
/// and listening to formatted input changes.
///
/// Example:
/// ```dart
/// final controller = FormattedInputController(
///   FormattedValue([
///     FormattedValuePart.static('('),
///     FormattedValuePart.editable('', length: 3),
///     FormattedValuePart.static(') '),
///     FormattedValuePart.editable('', length: 3),
///     FormattedValuePart.static('-'),
///     FormattedValuePart.editable('', length: 4),
///   ])
/// );
/// ```
class FormattedInputController extends ValueNotifier<FormattedValue>
    with ComponentController<FormattedValue> {
  /// Creates a [FormattedInputController] with an optional initial value.
  ///
  /// Parameters:
  /// - [value] (FormattedValue, default: empty): Initial formatted value
  FormattedInputController([super.value = const FormattedValue()]);
}

/// A controlled input widget for structured data entry with formatting.
///
/// This widget provides a sophisticated input system that combines static text
/// elements with editable fields in a single input interface. It's ideal for
/// formatted inputs like phone numbers, credit cards, dates, or any structured
/// data that requires specific formatting patterns.
///
/// The FormattedInput manages multiple editable segments, each with their own
/// validation, formatting, and input restrictions. It automatically handles
/// focus management between segments and provides a seamless user experience
/// with proper keyboard navigation.
///
/// Example:
/// ```dart
/// FormattedInput(
///   style: TextStyle(fontFamily: 'monospace'),
///   leading: Icon(Icons.phone),
///   initialValue: FormattedValue([
///     FormattedValuePart.static('('),
///     FormattedValuePart.editable('555', length: 3),
///     FormattedValuePart.static(') '),
///     FormattedValuePart.editable('123', length: 3),
///     FormattedValuePart.static('-'),
///     FormattedValuePart.editable('4567', length: 4),
///   ]),
/// );
/// ```
class FormattedInput extends StatefulWidget
    with ControlledComponent<FormattedValue> {
  @override
  final FormattedValue? initialValue;
  @override
  final ValueChanged<FormattedValue>? onChanged;
  @override
  final bool enabled;
  @override
  final FormattedInputController? controller;
  
  /// Text style applied to all input segments.
  ///
  /// This style affects both static text and editable input fields within
  /// the formatted input. Using a monospace font family is recommended
  /// for consistent character spacing across segments.
  final TextStyle? style;
  
  /// Widget displayed at the beginning of the input.
  ///
  /// Commonly used for icons or labels that provide context for the input
  /// content, such as a phone icon for phone number inputs.
  final Widget? leading;
  
  /// Widget displayed at the end of the input.
  ///
  /// Can be used for action buttons, status indicators, or additional
  /// context related to the input content.
  final Widget? trailing;

  /// Creates a [FormattedInput].
  ///
  /// The input structure is defined by the [initialValue] or [controller]
  /// value, which contains the mix of static text and editable segments.
  /// Each editable segment can have its own length restrictions and formatting.
  ///
  /// Parameters:
  /// - [initialValue] (FormattedValue?, optional): Initial structure and values
  /// - [onChanged] (ValueChanged<FormattedValue>?, optional): Callback for value changes
  /// - [style] (TextStyle?, optional): Text styling for all segments
  /// - [leading] (Widget?, optional): Widget displayed before the input
  /// - [trailing] (Widget?, optional): Widget displayed after the input
  /// - [enabled] (bool, default: true): Whether the input accepts user interaction
  /// - [controller] (FormattedInputController?, optional): External controller for programmatic control
  ///
  /// Example:
  /// ```dart
  /// FormattedInput(
  ///   initialValue: FormattedValue([
  ///     FormattedValuePart.static('$'),
  ///     FormattedValuePart.editable('0.00', length: 8),
  ///   ]),
  ///   leading: Icon(Icons.attach_money),
  ///   style: TextStyle(fontSize: 16),
  /// );
  /// ```
  const FormattedInput({
    super.key,
    this.initialValue,
    this.onChanged,
    this.style,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.controller,
  });

  @override
  State<FormattedInput> createState() => _FormattedInputState();
}

class _FormattedInputState extends State<FormattedInput> {
  final FormController _controller = FormController();
  bool _hasFocus = false;
  FormattedValue? _value;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? widget.controller?.value;
    _controller.addListener(_notifyChanged);
    int partIndex = 0;
    if (_value != null) {
      for (var part in _value!.parts) {
        if (part.part.canHaveValue) {
          partIndex++;
        }
      }
    }
    _focusNodes = _allocateFocusNodes(partIndex);
  }

  List<FocusNode> _allocateFocusNodes(int newLength,
      [List<FocusNode>? oldNodes]) {
    if (oldNodes == null) {
      return List.generate(newLength, (index) => FocusNode());
    }
    if (newLength == oldNodes.length) {
      return oldNodes;
    }
    if (newLength < oldNodes.length) {
      for (var i = newLength; i < oldNodes.length; i++) {
        oldNodes[i].dispose();
      }
      return oldNodes.sublist(0, newLength);
    }
    return [
      ...oldNodes,
      ...List.generate(newLength - oldNodes.length, (index) => FocusNode()),
    ];
  }

  Widget _buildPart(int index, InputPart part) {
    var formattedInputData = FormattedInputData(
      partIndex: index,
      initialValue: index < 0 ? null : (_value?[index]?.value ?? ''),
      enabled: widget.enabled,
      controller: widget.controller,
      focusNode: index < 0 ? null : _focusNodes[index],
      focusNodes: _focusNodes,
    );
    return part.build(context, formattedInputData);
  }

  bool _updating = false;
  void _notifyChanged() {
    if (_updating) {
      return;
    }
    _updating = true;
    try {
      List<FormattedValuePart> parts = [];
      var values = _controller.values;
      var value = _value;
      if (value != null) {
        int partIndex = 0;
        for (var i = 0; i < value.parts.length; i++) {
          var part = value.parts[i];
          if (part.part.canHaveValue) {
            FormKey key = FormKey(partIndex);
            var val = values[key];
            parts.add(part.withValue(val as String? ?? ''));
            partIndex++;
          } else {
            parts.add(part);
          }
        }
        _focusNodes = _allocateFocusNodes(partIndex, _focusNodes);
      } else {
        _focusNodes = _allocateFocusNodes(0, _focusNodes);
      }
      if (widget.onChanged != null) {
        widget.onChanged!(FormattedValue(parts));
      }
    } finally {
      _updating = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> children = [];
    if (_value != null) {
      int partIndex = 0;
      for (var part in _value!.parts) {
        if (part.part.canHaveValue) {
          children.add(_buildPart(partIndex, part.part));
          partIndex++;
        } else {
          children.add(_buildPart(-1, part.part));
        }
      }
    }
    final compTheme = ComponentTheme.maybeOf<FormattedInputTheme>(context);
    return SizedBox(
      height: (compTheme?.height ?? kTextFieldHeight) * theme.scaling, // 32 + 2
      child: TextFieldTapRegion(
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _hasFocus = hasFocus;
            });
          },
          child: FocusOutline(
            focused: _hasFocus,
            borderRadius: theme.borderRadiusMd,
            child: OutlinedContainer(
              borderRadius: theme.borderRadiusMd,
              borderColor: theme.colorScheme.border,
              backgroundColor: theme.colorScheme.input.scaleAlpha(0.3),
              padding: compTheme?.padding ??
                  EdgeInsets.symmetric(
                    horizontal: 6 * theme.scaling,
                  ),
              child: Form(
                controller: _controller,
                child: FocusTraversalGroup(
                  policy: WidgetOrderTraversalPolicy(),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.leading != null) widget.leading!,
                        ...children,
                        if (widget.trailing != null) widget.trailing!,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormattedInputData {
  final int partIndex;
  final String? initialValue;
  final bool enabled;
  final FormattedInputController? controller;
  final FocusNode? focusNode;
  final List<FocusNode> focusNodes;
  FormattedInputData({
    required this.partIndex,
    required this.initialValue,
    required this.enabled,
    required this.controller,
    required this.focusNode,
    required this.focusNodes,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FormattedInputData &&
        partIndex == other.partIndex &&
        initialValue == other.initialValue &&
        enabled == other.enabled &&
        controller == other.controller &&
        focusNode == other.focusNode &&
        focusNodes == other.focusNodes;
  }

  @override
  int get hashCode => Object.hash(
      partIndex, initialValue, enabled, controller, focusNode, focusNodes);
}

typedef FormattedInputPopupBuilder<T> = Widget Function(
    BuildContext context, ComponentController<T?> controller);

class FormattedObjectInput<T> extends StatefulWidget
    with ControlledComponent<T?> {
  @override
  final T? initialValue;
  @override
  final ValueChanged<T?>? onChanged;
  final ValueChanged<List<String>>? onPartsChanged;
  final FormattedInputPopupBuilder<T>? popupBuilder;
  @override
  final bool enabled;
  @override
  final ComponentController<T?>? controller;
  final BiDirectionalConvert<T?, List<String?>> converter;
  final List<InputPart> parts;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final Offset? popoverOffset;
  final Widget? popoverIcon;

  const FormattedObjectInput({
    super.key,
    this.initialValue,
    this.onChanged,
    this.popupBuilder,
    this.enabled = true,
    this.controller,
    required this.converter,
    required this.parts,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverOffset,
    this.popoverIcon,
    this.onPartsChanged,
  });

  @override
  State<FormattedObjectInput<T>> createState() =>
      _FormattedObjectInputState<T>();
}

class _FormattedObjectController<T> extends ValueNotifier<T?>
    with ComponentController<T?> {
  _FormattedObjectController([super.value]);
}

class _FormattedObjectInputState<T> extends State<FormattedObjectInput<T>> {
  late FormattedInputController _formattedController;
  late ComponentController<T?> _controller;

  final _popoverController = PopoverController();

  bool _updating = false; // to prevent circular updates

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? _FormattedObjectController<T>();
    List<String?> values = widget.converter
        .convertA(widget.initialValue ?? widget.controller?.value);
    List<FormattedValuePart> valueParts = [];
    int partIndex = 0;
    for (var i = 0; i < widget.parts.length; i++) {
      var part = widget.parts[i];
      if (part.canHaveValue) {
        var value = values[partIndex];
        if (value != null) {
          valueParts.add(part.withValue(value));
        } else {
          valueParts.add(FormattedValuePart(part));
        }
        partIndex++;
      } else {
        valueParts.add(FormattedValuePart(part));
      }
    }
    _formattedController = FormattedInputController(
      FormattedValue(valueParts),
    );
    _formattedController.addListener(_onFormattedControllerUpdate);
    _controller.addListener(_onControllerUpdate);
  }

  @override
  void didUpdateWidget(covariant FormattedObjectInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.parts, oldWidget.parts)) {
      List<String?> values = widget.converter.convertA(_controller.value);
      List<FormattedValuePart> valueParts = [];
      List<FormattedValuePart> oldValues =
          _formattedController.value.values.toList();
      int partIndex = 0;
      for (var i = 0; i < widget.parts.length; i++) {
        var part = widget.parts[i];
        if (part.canHaveValue) {
          var value = values[partIndex];
          if (value != null) {
            valueParts.add(part.withValue(value));
          } else {
            var oldValue =
                partIndex < oldValues.length ? oldValues[partIndex] : null;
            if (oldValue != null) {
              valueParts.add(oldValue);
            } else {
              valueParts.add(FormattedValuePart(part));
            }
          }
          partIndex++;
        } else {
          valueParts.add(FormattedValuePart(part));
        }
      }
      _updating = true;
      try {
        _formattedController.value = FormattedValue(valueParts);
      } finally {
        _updating = false;
      }
    }
  }

  void _onFormattedControllerUpdate() {
    if (_updating) return;
    _updating = true;
    try {
      var value = _formattedController.value;
      T? newValue = widget.converter.convertB(value.values.map((part) {
        return part.value ?? '';
      }).toList());
      _controller.value = newValue;
      widget.onChanged?.call(newValue);
    } finally {
      _updating = false;
    }
  }

  void _onControllerUpdate() {
    if (_updating) return;
    _updating = true;
    try {
      List<String?> values = widget.converter.convertA(_controller.value);
      List<FormattedValuePart> valueParts = [];
      int partIndex = 0;
      List<FormattedValuePart> oldValues =
          _formattedController.value.values.toList();
      for (var i = 0; i < widget.parts.length; i++) {
        var part = widget.parts[i];
        if (part.canHaveValue) {
          var value = values[partIndex];
          if (value != null) {
            valueParts.add(part.withValue(value));
          } else {
            var oldValue =
                partIndex < oldValues.length ? oldValues[partIndex] : null;
            if (oldValue != null) {
              valueParts.add(oldValue);
            } else {
              valueParts.add(FormattedValuePart(part));
            }
          }
          partIndex++;
        } else {
          valueParts.add(FormattedValuePart(part));
        }
      }
      _formattedController.value = FormattedValue(valueParts);
      widget.onChanged?.call(_controller.value);
    } finally {
      _updating = false;
    }
  }

  void _openPopover() {
    var popupBuilder = widget.popupBuilder;
    if (popupBuilder == null) {
      return;
    }
    final theme = Theme.of(context);
    _popoverController.show(
        context: context,
        alignment: widget.popoverAlignment ?? AlignmentDirectional.topStart,
        anchorAlignment:
            widget.popoverAnchorAlignment ?? AlignmentDirectional.bottomStart,
        offset: widget.popoverOffset ?? (const Offset(0, 4) * theme.scaling),
        builder: (context) {
          return popupBuilder(context, _controller);
        });
  }

  @override
  void dispose() {
    _formattedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var popoverIcon = widget.popoverIcon;
    return FormattedInput(
        controller: _formattedController,
        onChanged: (value) {
          List<String> values = value.values.map((part) {
            return part.value ?? '';
          }).toList();
          widget.onPartsChanged?.call(values);
          T? newValue = widget.converter.convertB(values);
          _controller.value = newValue;
        },
        trailing: popoverIcon == null
            ? null
            : ListenableBuilder(
                listenable: _popoverController,
                builder: (context, child) {
                  return WidgetStatesProvider(
                    states: {
                      if (_popoverController.hasOpenPopover)
                        WidgetState.hovered,
                    },
                    child: child!,
                  );
                },
                child: IconButton.text(
                  icon: popoverIcon,
                  density: ButtonDensity.compact,
                  onPressed: _openPopover,
                )));
  }
}
