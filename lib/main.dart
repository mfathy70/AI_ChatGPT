import 'package:flutter/material.dart';
import 'package:robo_ai/providers/chat_provider.dart';
import 'package:robo_ai/providers/theme_provider.dart';
import 'package:robo_ai/screens/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:robo_ai/theme_data_dark.dart';
import 'package:robo_ai/theme_data_light.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        ChangeNotifierProvider(create: (_) => ThemeProvider()..initialize())
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AI Chat',
          theme: themeDataLight(),
          darkTheme: themeDataDark(),
          themeMode: context.watch<ThemeProvider>().themeMode,
          home: const MyHomePage(title: 'Chat AI'),
        );
      }),
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
              final themeProvider =
                  Provider.of<ThemeProvider>(context, listen: false);

              themeProvider.initTheme == 'light'
                  ? themeProvider.setDarkmode('dark')
                  : themeProvider.setLightMode('light');
            },
            icon: Provider.of<ThemeProvider>(context).initTheme == 'light'
                ? Icon(
                    FontAwesomeIcons.solidMoon,
                    color: Theme.of(context).primaryColorDark,
                  )
                : Icon(FontAwesomeIcons.sun,
                    color: Theme.of(context).primaryColorLight),
          ),
        ],
      ),
      body: const ChatScreen(),
    );
  }
}
