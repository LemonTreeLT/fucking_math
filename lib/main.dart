import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fucking_math/ai/client.dart';
import 'package:fucking_math/ai/config/ai_config.dart';
import 'package:fucking_math/ai/engine/ai_task_service.dart';
import 'package:fucking_math/ai/repository/ai_history_repository.dart';
import 'package:fucking_math/ai/repository/ai_provider_repository.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/daos/images.dart';
import 'package:fucking_math/db/daos/knowledge.dart';
import 'package:fucking_math/db/daos/question.dart';
import 'package:fucking_math/db/daos/phrase.dart';
import 'package:fucking_math/db/daos/tag.dart';
import 'package:fucking_math/db/daos/word.dart';
import 'package:fucking_math/ai/repository/ai_prompt_repository.dart';
import 'package:fucking_math/providers/ai_provider.dart';
import 'package:fucking_math/providers/images.dart';
import 'package:fucking_math/providers/knowledge.dart';
import 'package:fucking_math/providers/questions.dart';
import 'package:fucking_math/providers/phrase.dart';
import 'package:fucking_math/providers/prompt.dart';
import 'package:fucking_math/providers/tags.dart';
import 'package:fucking_math/providers/words.dart';
import 'package:fucking_math/utils/repository/english.dart';
import 'package:fucking_math/utils/repository/images.dart';
import 'package:fucking_math/utils/repository/knowledge.dart';
import 'package:fucking_math/utils/repository/questions.dart';
import 'package:fucking_math/utils/repository/phrase.dart';
import 'package:fucking_math/utils/repository/tag.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'pages/routers/router.dart';
import 'configs/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initialize();
  final AppDatabase database = AppDatabase();

  final getIt = GetIt.instance;

  // 注册 Repo
  final aiProviderRepo = AiProviderRepository(database.aiProviderDao);
  final questionsRepo = QuestionsRepository(QuestionsDao(database));
  final phraseRepo = PhraseRepository(PhrasesDao(database));
  final wordRepo = WordsRepository(WordsDao(database));
  final knowledgeRepo = KnowledgeRepository(KnowledgeDao(database));
  final tagRepo = TagRepository(TagsDao(database));
  final imagesRepo = ImagesRepository(ImagesDao(database));

  getIt.registerSingleton(aiProviderRepo);
  getIt.registerSingleton(wordRepo);
  getIt.registerSingleton(knowledgeRepo);
  getIt.registerSingleton(tagRepo);
  getIt.registerSingleton(questionsRepo);
  getIt.registerSingleton(phraseRepo);
  getIt.registerSingleton(imagesRepo);

  final promptRepo = PromptRepository(database.promptDao);
  getIt.registerSingleton(promptRepo);

  final aiConfig = AiConfig(aiProviderRepo)..loadActionProvider();
  final aiProviderProvider = AiProviderProvider(aiProviderRepo)..loadProviders();
  final wordsProvider = WordsProvider(wordRepo)..loadWords();
  final phraseProvider = PhraseProvider(phraseRepo)..loadPhrases();
  final tagProvider = TagProvider(tagRepo)..loadTags();
  final knowledgeProvider = KnowledgeProvider(knowledgeRepo)..loadKnowledge();
  final questionsProvider = QuestionsProvider(questionsRepo)..loadQuestions();
  final imagesProvider = ImagesProvider(imagesRepo);
  final promptProvider = PromptProvider(promptRepo)..loadPrompts();

  getIt.registerSingleton<AiConfig>(aiConfig);
  getIt.registerSingleton<AiProviderProvider>(aiProviderProvider);
  getIt.registerSingleton<WordsProvider>(wordsProvider);
  getIt.registerSingleton<PhraseProvider>(phraseProvider);
  getIt.registerSingleton<TagProvider>(tagProvider);
  getIt.registerSingleton<KnowledgeProvider>(knowledgeProvider);
  getIt.registerSingleton<QuestionsProvider>(questionsProvider);
  getIt.registerSingleton<ImagesProvider>(imagesProvider);
  getIt.registerSingleton<PromptProvider>(promptProvider);

  getIt.registerSingleton<AppDatabase>(database);
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(Assistant());

  final historyRepo = AiHistoryRepository(
    database.aiHistoryDao,
    database.aiHistoryImagesLinkDao,
  );
  final aiTaskService = AiTaskService(aiConfig, historyRepo);
  getIt.registerSingleton<AiHistoryRepository>(historyRepo);
  getIt.registerSingleton<AiTaskService>(aiTaskService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: aiConfig),
        ChangeNotifierProvider.value(value: aiProviderProvider),
        ChangeNotifierProvider.value(value: wordsProvider),
        ChangeNotifierProvider.value(value: phraseProvider),
        ChangeNotifierProvider.value(value: tagProvider),
        ChangeNotifierProvider.value(value: knowledgeProvider),
        ChangeNotifierProvider.value(value: questionsProvider),
        ChangeNotifierProvider.value(value: imagesProvider),
        ChangeNotifierProvider.value(value: promptProvider),
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
