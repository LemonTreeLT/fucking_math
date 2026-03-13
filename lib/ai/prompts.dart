import 'package:fucking_math/ai/types.dart';

Prompt getTest1() => test1.build({"content1": "你好", "content2": "测试替换"});

// ========== Source Prompts ==========

final test1 = Prompt(
  content:
      "你现在处于测试模式之中，你需要输出以下内容,若出现{{}}则说明用户没有提供该字段, 你不需要输出: {{content1}}, {{content2}}, {{content3}}",
);

final systemPromptV1 = Prompt(content: "你是一位内置于Fucking Math");

final masterOrchestratorGuide = Prompt(
  content: """
### Master Orchestrator 操作准则 (Internal SOP)

**1. 前置验证 (Pre-Verification)**
*   **严禁盲插：** 在执行 `save` 动作前，必须先使用 `run_sql_query` 确认 `linked_word_id` (用于短语) 或 `tags` ID 确实存在于数据库中。
*   **重复性检查：** 通过 SQL 查询确认是否已存在内容重复的记录，避免数据冗余。
*   **字段有效性验证: ** 通过 sql 工具获取的字段定义可能与工具的定义不同，需要严格按照工具给出的定义调用

**2. 数据预处理 (Data Sanitization)**
*   **标签去重：** 在 `tags` 数组提交前，必须在代码逻辑内进行去重 (Unique)，防止触发数据库 `UNIQUE constraint` 导致批量任务中断。
*   **学科校准：** 强制将 `subject` 转换为**小写**，并严格校验是否属于白名单 (math, chinese, english, physics, chemistry, biology, history, politics, geography)。
*   **文本修剪：** 对 `phrase`、`head`、`body` 进行 `trim()` 处理，拒绝仅包含空格的无效录入。

**3. 逻辑约束 (Logic Constraints)**
*   **动作匹配：** `mark_review` 仅允许作用于 `phrase` 实体；`mistake` 实体严禁使用该动作。
*   **必填校验：** `phrase` 必须包含 `phrase` 文本和 `linked_word_id`；`mistake` 必须包含 `body`。
""",
);

final sqlQueryGuide = Prompt(
  content: """
[SQL Tooling Constraint]
**NO SEMICOLONS**: Never end a SQL string with a semicolon when using `run_sql_query` or `run_sql_mutation`.
**PREVENT AUTO-LIMIT** CONFLICT: Ensure the statement ends with a keyword or value so that the system-appended `LIMIT` remains part of the same execution block.
""",
);
