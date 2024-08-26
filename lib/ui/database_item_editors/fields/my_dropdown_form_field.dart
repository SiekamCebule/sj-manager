import 'package:flutter/material.dart';
import 'package:sj_manager/ui/database_item_editors/fields/dropdown_menu_form_field.dart';
import 'package:sj_manager/ui/responsiveness/ui_constants.dart';
import 'package:sj_manager/utils/colors.dart';

class MyDropdownFormField<T> extends StatelessWidget {
  const MyDropdownFormField({
    super.key,
    this.formKey,
    this.controller,
    required this.onChange,
    this.initial,
    this.width,
    required this.entries,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.enableSearch,
    this.enabled = true,
    this.menuHeight,
    this.requestFocusOnTap,
    this.focusNode,
    required this.validator,
  });

  final GlobalKey<FormFieldState>? formKey;
  final TextEditingController? controller;
  final T? initial;
  final Function(T? selected) onChange;
  final double? width;
  final List<DropdownMenuEntry<T>> entries;
  final Widget? label;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool? enableSearch;
  final bool enabled;
  final double? menuHeight;
  final bool? requestFocusOnTap;
  final FocusNode? focusNode;
  final String? Function(T? value)? validator;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(UiFieldWidgetsConstants.borderRadius),
      borderSide: BorderSide(
        width: UiFieldWidgetsConstants.borderSideWidth,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
    return DropdownMenuFormField<T>(
      key: formKey,
      enabled: enabled,
      enableSearch: enableSearch ?? true,
      requestFocusOnTap: false,
      width: width,
      controller: controller,
      initialSelection: initial,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      dropdownMenuEntries: entries,
      textStyle: enabled
          ? null
          : Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .blendWithBg(Theme.of(context).brightness, 0.2),
              ),
      label: label,
      enableFilter: true,
      onSelected: onChange,
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            enabledBorder: border,
            border: border,
          ),
      menuStyle: MenuStyle(
        visualDensity: VisualDensity.standard,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      validator: validator,
    );
  }
}
