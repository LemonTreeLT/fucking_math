import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/utils/types.dart';

class Debug extends StatefulWidget {
  const Debug({super.key});

  @override
  State<Debug> createState() => _DebugPageState();
}

class _DebugPageState extends State<Debug> {
  // 用于展示数据的列表
  final ValueNotifier<List<Map<String, dynamic>>> _data = ValueNotifier([]);
  String _currentTable = 'Words';

  // 声明 AppDatabase 实例
  late final AppDatabase database;

  @override
  void initState() {
    super.initState();
    // 使用 WidgetsBinding.instance.addPostFrameCallback 安全地访问 context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 通过 Provider 获取 AppDatabase 实例
      database = context.read<AppDatabase>();
      _loadData(_currentTable);
    });
  }

  // ============== 数据加载逻辑 ==============

  Future<void> _loadData(String tableName) async {
    if (!mounted) return;
    setState(() {
      _currentTable = tableName;
    });

    List<dynamic> result = [];

    // 如果数据库未初始化 (例如在 hardReset 之后)，则跳过
    try {
      switch (tableName) {
        case 'Words':
          // 使用 .first 将 Stream 转换为 Future<List<Word>>
          result = await database.watchAllWords().first;
          break;
        case 'Mistakes':
          result = await database.watchAllMistakes().first;
          break;
        case 'WordLogs':
          // 获取最近 50 条日志
          result =
              await (database.select(database.wordLogs)
                    ..limit(50)
                    ..orderBy([
                      (l) => OrderingTerm(
                        expression: l.timestamp,
                        mode: OrderingMode.desc,
                      ),
                    ]))
                  .get();
          break;
        default:
          result = [];
      }
    } catch (e) {
      // 错误处理，例如数据库文件不存在
      print("Error loading data: $e");
    }

    // 将 Drift 的数据模型转换为 Map 方便展示
    _data.value = result
        .map((item) => item.toJson() as Map<String, dynamic>)
        .toList();
  }

  // ============== 操作逻辑 ==============

  Future<void> _insertDummyData() async {
    await database.insertWord(
      word: 'Example_${DateTime.now().millisecond}',
      definition: '测试定义',
    );
    await database.insertMistake(
      subject: Subject.english,
      questionHeader: '测试错题 ${DateTime.now().second}',
      questionBody: '这是一个测试题目',
      correctAnswer: 'Yes',
      userAnswer: 'No',
    );
    await _loadData(_currentTable);
  }

  Future<void> _hardReset() async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('⚠️ 确认重置数据库'),
            content: const Text('这将永久删除数据库文件并清空所有数据。您确定吗？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('确定', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;

    if (confirmed) {
      // 访问 database 实例执行高危操作
      // await database.hardResetDatabase();

      // 清空数据展示，并提示用户
      _data.value = [];
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('数据库文件已删除。请重启应用以重新建立连接。')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 确保数据库实例已提供
    // 如果未提供，Provider.of 会抛出错误，这是我们期望的

    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ 数据库调试与维护'),
        actions: [
          // 切换查看的表
          PopupMenuButton<String>(
            onSelected: _loadData,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Words', child: Text('Words (单词)')),
              const PopupMenuItem(
                value: 'Mistakes',
                child: Text('Mistakes (错题)'),
              ),
              const PopupMenuItem(
                value: 'WordLogs',
                child: Text('WordLogs (日志)'),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(child: Text('查看: $_currentTable')),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildControlPanel(),
          Expanded(
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: _data,
              builder: (context, data, _) {
                if (data.isEmpty) {
                  return Center(child: Text('当前 $_currentTable 表中没有数据。'));
                }
                return _buildDataTable(data);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ... _buildControlPanel 和 _buildDataTable 方法保持不变 ...

  Widget _buildControlPanel() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        children: [
          ElevatedButton(
            onPressed: () => _loadData(_currentTable),
            child: const Text('刷新数据'),
          ),
          ElevatedButton(
            onPressed: _insertDummyData,
            child: const Text('插入测试数据'),
          ),
          ElevatedButton.icon(
            onPressed: _hardReset,
            icon: const Icon(Icons.warning, color: Colors.white),
            label: const Text(
              '重置/删除数据库',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return Container();

    final columns = data.first.keys.toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 12,
        horizontalMargin: 10,
        columns: columns.map((col) => DataColumn(label: Text(col))).toList(),
        rows: data.map((row) {
          return DataRow(
            cells: columns.map((col) {
              String cellValue = row[col]?.toString() ?? 'NULL';
              if (row[col] is DateTime) {
                cellValue = (row[col] as DateTime).toLocal().toString().split(
                  '.',
                )[0];
              }
              return DataCell(
                Container(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: Text(cellValue, overflow: TextOverflow.ellipsis),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
