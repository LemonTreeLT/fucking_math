import 'package:flutter/material.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/providers/images.dart';
import 'package:fucking_math/providers/knowledge.dart';
import 'package:fucking_math/providers/mistakes.dart';
import 'package:fucking_math/providers/phrase.dart';
import 'package:fucking_math/providers/tags.dart';
import 'package:fucking_math/providers/words.dart';
import 'package:provider/provider.dart';

import 'pages/routers/router.dart';
import 'configs/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initialize();
  final AppDatabase database = AppDatabase();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => database, dispose: (_, db) => db.close()),
        ChangeNotifierProvider(
          create: (context) => WordsProvider(context.read())..loadWords(),
        ),
        ChangeNotifierProvider(
          create: (context) => PhraseProvider(context.read())..loadPhrases(),
        ),
        ChangeNotifierProvider(
          create: (context) => TagProvider(context.read())..loadTags(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              KnowledgeProvider(context.read())..loadKnowledge(),
        ),
        ChangeNotifierProvider(
          create: (context) => MistakesProvider(context.read())..loadMistakes(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagesProvider(context.read()),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fucking Math',
      debugShowCheckedModeBanner: true,
      theme: Config.lightTheme,
      darkTheme: Config.darkTheme,
      routerConfig: appRouter,
    );
  }
}
