import 'package:flutter/material.dart';

// Localization
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Components
import './components/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eldey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Dashboard(),
      // home: Store(counter: 0, child: Dashboard()),
    );
  }
}
