import 'package:fetchingapp/provider.dart';
import 'package:fetchingapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

List<String> userChats = [
  'tyLp2LZryd1JI3ceDfnt',
  '32d5W1IpXqrwTHkKIlWg',
  'EMOW7iAQe7WjAmGqRj6u'
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (_) => ReadMessageChanges(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ReadMessageChanges>(context, listen: false)
        .listenOnChatChanges(userChats);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
