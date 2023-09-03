
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_request_ui/providers/songs_provider.dart';
import 'package:song_request_ui/pages/search_page.dart';
import 'package:song_request_ui/pages/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<SongsProvider>(context, listen: false);
    provider.getSearchResultAPI();
    super.initState();
  } 

  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const Text(
        'Home Page',
        style: optionStyle,
      ),
      const SearchPage(),
      const CartPage(),
      const Text(
        'Queue',
        style: optionStyle,
      ),
      const Text(
        'Settings',
        style: optionStyle,
      ),
      
    ];
    
    log('Home page build is called.');


    return Scaffold(
      appBar: AppBar(
        title: const Text('Wink'),
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: true,
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: '首頁',
            backgroundColor: Theme.of(context).primaryColorDark,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.music_note_rounded),
            label: '搜歌',
            backgroundColor: Theme.of(context).primaryColorDark,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.edit_note_rounded),
            label: '待點',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.queue_music_rounded),
            label: '已點',
            backgroundColor: Theme.of(context).primaryColorLight
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Theme.of(context).primaryColorDark,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).hintColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
