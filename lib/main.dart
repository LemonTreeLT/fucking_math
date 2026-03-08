import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fucking_math/ai/client.dart';
import 'package:fucking_math/ai/config/ai_config.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/providers/images.dart';
import 'package:fucking_math/providers/knowledge.dart';
import 'package:fucking_math/providers/mistakes.dart';
import 'package:fucking_math/providers/phrase.dart';
import 'package:fucking_math/providers/tags.dart';
import 'package:fucking_math/providers/words.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'pages/routers/router.dart';
import 'configs/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initialize();
  final AppDatabase database = AppDatabase();

  final getIt = GetIt.instance;

  final aiConfig = AiConfig(database)..loadActionProvider();
  final wordsProvider = WordsProvider(database)..loadWords();
  final phraseProvider = PhraseProvider(database)..loadPhrases();
  final tagProvider = TagProvider(database)..loadTags();
  final knowledgeProvider = KnowledgeProvider(database)..loadKnowledge();
  final mistakesProvider = MistakesProvider(database)..loadMistakes();
  final imagesProvider = ImagesProvider(database);

  getIt.registerSingleton<AiConfig>(aiConfig);
  getIt.registerSingleton<WordsProvider>(wordsProvider);
  getIt.registerSingleton<PhraseProvider>(phraseProvider);
  getIt.registerSingleton<TagProvider>(tagProvider);
  getIt.registerSingleton<KnowledgeProvider>(knowledgeProvider);
  getIt.registerSingleton<MistakesProvider>(mistakesProvider);
  getIt.registerSingleton<ImagesProvider>(imagesProvider);

  getIt.registerSingleton<AppDatabase>(database);
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(Assistant());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: aiConfig),
        ChangeNotifierProvider.value(value: wordsProvider),
        ChangeNotifierProvider.value(value: phraseProvider),
        ChangeNotifierProvider.value(value: tagProvider),
        ChangeNotifierProvider.value(value: knowledgeProvider),
        ChangeNotifierProvider.value(value: mistakesProvider),
        ChangeNotifierProvider.value(value: imagesProvider),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Fucking Math',
    debugShowCheckedModeBanner: kDebugMode,
    theme: Config.lightTheme,
    darkTheme: Config.darkTheme,
    routerConfig: appRouter,
  );
}
