import 'package:flutter/material.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/utils/providers/phrase_proivder.dart';
import 'package:fucking_math/utils/providers/words_proivder.dart';
import 'package:provider/provider.dart';

import 'pages/router.dart';
import 'configs/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDatabase database = AppDatabase();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => database, dispose: (_, db) => db.close()),
        ChangeNotifierProvider(
          create: (context) =>
              WordsProvider(context.read<AppDatabase>())..loadWords(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              PhraseProivder(context.read<AppDatabase>())..loadPhrases(),
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
