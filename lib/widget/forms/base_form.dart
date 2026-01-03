import 'package:flutter/material.dart';
import 'package:fucking_math/providers/base_proivder.dart';
import 'package:fucking_math/utils/mixin/form_helper.dart';
import 'package:fucking_math/utils/mixin/provider_error_handle.dart';
import 'package:fucking_math/widget/common/backgrounds.dart';
import 'package:fucking_math/widget/common/tag_selection.dart';
import 'package:fucking_math/widget/forms/action_button.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:provider/provider.dart';

// 使用泛型来适应不同的 Widget 和 Provider
abstract class BaseAddFormState<T extends StatefulWidget, P extends BaseProvider>
    extends State<T> with FormClearable<T>, ProviderErrorHandler<T> {
  final formKey = GlobalKey<FormState>();
  Set<int> selectedTagIds = {};

  // ==========================================================
  // 1. 抽象成员 (子类必须实现这些)
  // ==========================================================

  /// 表单顶部的标题
  String get formTitle;

  /// 提交按钮的文本
  String get submitButtonLabel;

  /// 构建表单独有的输入字段
  Widget buildFormFields(BuildContext context);

  /// 执行实际的提交逻辑 (调用 provider)
  Future<void> performSubmit();

  // ==========================================================
  // 2. 具体实现 (所有子类共享)
  // ==========================================================

  @override
  Set<int> get tagSelection => selectedTagIds;

  /// 统一的提交方法
  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    // 调用子类实现的具体提交逻辑
    await performSubmit();

    final provider = context.read<P>();
    if (provider.error == null) {
      clearForm();
    }
  }

  /// AI 生成定义（所有子类共享此占位符）
  void generateDefinition() {
    // TODO: implement ai definition generation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('AI 生成功能正在开发中...')),
    );
  }

  @override
  void clearForm() {
    super.clearForm();
    // 清空标签选择
    setState(() {
      selectedTagIds.clear();
    });
  }

  /// 共享的 build 方法！这是最大的代码复用点。
  @override
  Widget build(BuildContext context) {
    return BorderedContainerWithTopText(
      labelText: formTitle, // 使用抽象属性
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 调用抽象方法来构建特定于子类的表单字段
              buildFormFields(context),
              boxH16,
              TagSelectionArea(
                selectedTagIds: selectedTagIds,
                onSelectionChanged: (newSelection) {
                  setState(() => selectedTagIds = newSelection);
                },
              ),
              const Spacer(),
              Consumer<P>( // 使用泛型 Provider
                builder: (context, provider, child) {
                  // 使用 Mixin 的错误处理
                  handleProviderError(provider.error);
                  return FormActionButtons(
                    isLoading: provider.isLoading,
                    onSubmit: submitForm, // 调用共享的提交方法
                    onGenerate: generateDefinition,
                    submitLabel: submitButtonLabel, // 使用抽象属性
                    generateLabel: 'AI 生成释义',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
