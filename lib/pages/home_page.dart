
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:song_request_ui/providers/songs_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<SongsProvider>(context, listen: false);
    provider.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<SongsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('找歌'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : getBodyUI(),
    );
  }

  Widget getLoadingUI() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            color: Colors.blueGrey,
            size: 80,
          ),
          Text(
            'Loading...',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }

  Widget getBodyUI() {
    final provider = Provider.of<SongsProvider>(context, listen: false);
    return provider.isLoading
          ? getLoadingUI()
          : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onFieldSubmitted: (value) async {
                    provider.search(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, SongsProvider songsProvider, child) =>
                    ListView.builder(
                      itemCount: songsProvider.searchedSongs.data.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: const EdgeInsets.all(20.0),
                        leading: songsProvider.searchedSongs.data[index].albumImg == null
                          ? Image.network('https://i.kfs.io/album/tw/131234,0v3/fit/160x160.jpg')
                          : Image.network(songsProvider.searchedSongs.data[index].albumImg!,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network('https://i.kfs.io/album/tw/131234,0v3/fit/160x160.jpg');
                            },
                          ),
                        isThreeLine: true,
                        title: Text(
                          songsProvider.searchedSongs.data[index].name,
                          style: const TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        subtitle: Text(
                          '${songsProvider.searchedSongs.data[index].singer}\\${songsProvider.searchedSongs.data[index].code}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Tooltip(
                              message: '點歌',
                              child: ElevatedButton(
                                onPressed: () => print('request a song'),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(16),
                                ), 
                                child: const Icon(
                                  Icons.add,
                                  size: 26,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Tooltip(
                              message: '插播',
                              child: ElevatedButton(
                                onPressed: () => print('queue a song for immediate play'),
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(16),
                                ), 
                                child: const Icon(
                                  Icons.campaign_outlined,
                                  size: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                ),
              ),
            ],
          );
  }
}
