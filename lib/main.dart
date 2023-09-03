import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_request_ui/pages/home_page.dart';
import 'package:song_request_ui/providers/songs_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SongsProvider(),
      child: MaterialApp(
        title: 'Wink點歌',
        themeMode: ThemeMode.light,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
