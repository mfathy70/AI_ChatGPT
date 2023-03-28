import 'package:flutter/material.dart';
import 'package:robo_ai/providers/chat_provider.dart';
import 'package:robo_ai/providers/theme_provider.dart';
import 'package:robo_ai/screens/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:robo_ai/theme_data_dark.dart';
import 'package:robo_ai/theme_data_light.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Chat',
        theme: themeDataLight(),
        darkTheme: themeDataDark(),
        themeMode: ThemeMode.system,
        home: const MyHomePage(title: 'Chat AI'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkmode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                //________________NOT FINISHED YET________________
                final themeProvider =
                    Provider.of<ThemeProvider>(context, listen: false);

                setState(() {
                  isDarkmode = !isDarkmode;
                });

                isDarkmode // call the functions
                    ? themeProvider.setDarkmode()
                    : themeProvider.setLightMode();
              },
              icon: Icon(FontAwesomeIcons.solidMoon))
        ],
      ),
      body: const ChatScreen(),
    );
  }
}
