import 'package:flutter/material.dart';
import 'package:fucking_math/widget/common/backgrounds.dart';

mixin ControllerManager<T extends StatefulWidget> on State<T> {
  List<TextEditingController> get controllers;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

mixin FormResetMixin<T extends StatefulWidget>
    on State<T>, ControllerManager<T> {
  void resetForm() {
    for (var controller in controllers) {
      controller.clear();
    }
    FocusScope.of(context).unfocus();
  }
}

abstract class GenericFormState<T extends StatefulWidget> extends State<T>
    with ControllerManager<T> {
  final formKey = GlobalKey<FormState>();

  // 子类实现
  String get formTitle;

  /// 表单主要内容，不含按钮
  List<Widget> buildFormFields(BuildContext context);

  /// 按钮按下时
  Future<void> onPrimaryAction() async {}

  // 可选配置
  String get primaryButtonLabel => "提交";
  IconData get primaryButtonIcon => Icons.check;
  bool validateForm() => formKey.currentState?.validate() ?? false;

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    labelText: formTitle,
    child: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...buildFormFields(context),
            const Spacer(),
            buildActionButton(),
          ],
        ),
      ),
    ),
  );

  Widget buildActionButton() => ElevatedButton.icon(
    onPressed: _handleAction,
    label: Text(primaryButtonLabel),
    icon: Icon(primaryButtonIcon),
  );

  Future _handleAction() async {
    if (validateForm()) await onPrimaryAction();
  }
}

/// 添加表单基类
abstract class AddFormState<T extends StatefulWidget>
    extends GenericFormState<T>
    with FormResetMixin<T> {
  @override
  String get primaryButtonLabel => '添加';

  @override
  IconData get primaryButtonIcon => Icons.add;

  @override
  Future<dynamic> _handleAction() async {
    if (validateForm()) {
      await onPrimaryAction();
      resetForm();
    }
  }
}

abstract class EditFormState<T extends StatefulWidget>
    extends GenericFormState<T> {
  @override
  String get primaryButtonLabel => '保存';

  @override
  IconData get primaryButtonIcon => Icons.save;

  void loadInitialDate();

  @override
  void initState() {
    super.initState();
    loadInitialDate();
  }
}

abstract class MultiActionFormState<T extends StatefulWidget>
    extends GenericFormState<T> {
  List<FormAction> get actions;

  @override
  Widget buildActionButton() => Row(
    children: [
      for (var action in actions)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton.icon(
              onPressed: () async {
                if (action.requiresValidation && !validateForm()) return;
                await action.onPressed();
              },
              label: Text(action.label),
              icon: Icon(action.icon),
            ),
          ),
        ),
    ],
  );
}

class FormAction {
  final String label;
  final IconData icon;
  final Future<void> Function() onPressed;
  final bool requiresValidation;

  const FormAction({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.requiresValidation = true,
  });
}
