import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFormFieldCustom extends StatefulWidget {
  TextFormFieldCustom({
    super.key,
    required this.controller,
    required this.label,
    required this.isTopLabel,
    this.isAnimasi,
    this.isRequired,
    this.isFormatMoney,
    this.width,
    this.widthAfterAnimasi,
    this.height,
    this.hintText,
    this.errorText,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    this.isPassword,
    this.fillColor,
    this.filled,
    this.prefixIcon,
    this.floatingLabelBehavior,
    this.enabledBorder,
    this.isRightIcon,
    this.contentPadding,
    this.enabled,
    this.labelStyle,
    this.inputFormatters,
    this.onTap,
  });
  final TextEditingController controller;
  String label;
  bool isTopLabel;
  bool? isAnimasi;
  bool? isRequired;
  bool? isFormatMoney;
  double? width;
  double? widthAfterAnimasi;
  double? height;
  String? hintText;
  String? errorText;
  String? Function(String? value)? validator;
  TextInputType? keyboardType;
  bool? obscureText;
  Widget? suffixIcon;
  bool? isPassword;
  bool? isRightIcon;
  Color? fillColor;
  bool? filled;
  Widget? prefixIcon;
  FloatingLabelBehavior? floatingLabelBehavior;
  InputBorder? enabledBorder;
  EdgeInsetsGeometry? contentPadding;
  bool? enabled;
  TextStyle? labelStyle;
  List<TextInputFormatter>? inputFormatters;
  void Function()? onTap;

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  bool showPassword = false;
  final FocusNode _focusNode = FocusNode();
  double? _width;
  final NumberFormat _currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  @override
  void initState() {
    super.initState();
    _width = widget.width;
    if (widget.isAnimasi == true) {
      _focusNode.addListener(_onFocusChange);
    }
    if (widget.isFormatMoney == true) {
      widget.controller.addListener(() {
        final text = widget.controller.text
            .replaceAll(RegExp(r'[Rp\s,.]'), ''); // Remove formatting
        if (text.isNotEmpty) {
          final value = int.parse(text);
          final formattedValue = _currencyFormatter.format(value);
          widget.controller.value = TextEditingValue(
            text: formattedValue,
            selection: TextSelection.collapsed(offset: formattedValue.length),
          );
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant TextFormFieldCustom oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.width != widget.width) {
      _width = widget.width;
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    if (widget.isAnimasi == true) {
      _focusNode.dispose();
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    _focusNode.hasFocus
        ? _width = widget.widthAfterAnimasi
        : _width = widget.width;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isTopLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  widget.label,
                  style: widget.labelStyle ?? const TextStyle(fontSize: 16),
                ),
                if (widget.isRequired == true)
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
              ],
            ),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widget.isAnimasi == true ? _width : widget.width,
          height: widget.height,
          child: Stack(
            children: [
              TextFormField(
                focusNode: _focusNode,
                controller: widget.controller,
                validator: widget.validator,
                onTap: widget.onTap,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                obscureText: widget.isPassword == true
                    ? !showPassword
                    : widget.obscureText ?? false,
                decoration: InputDecoration(
                  contentPadding: widget.contentPadding,
                  errorText: widget.errorText,
                  label: widget.isTopLabel
                      ? null
                      : Row(
                          children: [
                            Text(
                              widget.label,
                              style: const TextStyle(fontSize: 16),
                            ),
                            if (widget.isRequired == true)
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                          ],
                        ),
                  labelStyle: widget.labelStyle,
                  hintText: widget.hintText,
                  fillColor: widget.fillColor,
                  alignLabelWithHint: false,
                  floatingLabelBehavior: widget.floatingLabelBehavior,
                  filled: widget.filled,
                  enabled: widget.enabled ?? true,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.isPassword == true
                      ? InkWell(
                          onTap: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                          child: showPassword
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off))
                      : widget.suffixIcon,
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: widget.enabledBorder,
                  disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              if (widget.isAnimasi == true)
                Align(
                  alignment: _focusNode.hasFocus || widget.isRightIcon == true
                      ? Alignment.centerRight
                      : Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.only(
                          right:
                              _focusNode.hasFocus || widget.isRightIcon == true
                                  ? 10
                                  : 0),
                      child: Image.asset('assets/icon/icon_search.png')),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
