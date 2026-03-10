import 'package:fucking_math/ai/config/ai_config.dart';
import 'package:fucking_math/ai/engine/ai_task_processor.dart';
import 'package:fucking_math/ai/repository/ai_history_repository.dart';
import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/utils/repository/helper/exceptions.dart';
import 'package:fucking_math/utils/uuid.dart';

/// 任务管理单例，管理多个 AiTaskProcessor 实例
class AiTaskService {
  final AiConfig _aiConfig;
  final AiHistoryRepository _historyRepo;
  final Map<String, AiTaskProcessor> _tasks = {};

  AiTaskService(this._aiConfig, this._historyRepo);

  /// 创建并启动新任务
  Future<AiTaskProcessor> startTask({
    required int sessionId,
    required String model,
    required List<BaseAiTool> tools,
    String? systemPrompt,
    int maxIterations = 10,
  }) {
    final provider = _aiConfig.activeProvider;
    if (provider == null) {
      throw AiTaskException('No active AI provider configured');
    }

    final taskId = getUuidV1();
    final processor = AiTaskProcessor(
      taskId: taskId,
      providerId: provider.id,
      sessionId: sessionId,
      model: model,
      tools: tools,
      systemPrompt: systemPrompt,
      aiConfig: _aiConfig,
      historyRepo: _historyRepo,
      maxIterations: maxIterations,
    );

    _tasks[taskId] = processor;

    // 启动任务（不 await，让调用方通过 events stream 监听）
    processor.run();

    return Future.value(processor);
  }

  /// 获取已存在的任务（UI 重连）
  AiTaskProcessor? getTask(String taskId) => _tasks[taskId];

  /// 中断并移除任务
  void cancelTask(String taskId) {
    final task = _tasks[taskId];
    if (task != null) {
      task.interrupt();
      _tasks.remove(taskId);
    }
  }

  /// 清理已完成的任务
  void cleanupCompleted() {
    _tasks.removeWhere((_, task) => !task.isRunning);
  }
}
