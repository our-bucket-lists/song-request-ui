
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_request_ui/providers/songs_provider.dart';
import 'package:song_request_ui/widgets/my_widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    log('Search page build is called.');
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 8, 16),
            child: getSearchBar(),
          ),
          Expanded(
            child: getSearchResult(),
          ),
        ],
      ),
    );
  }

  Widget getSearchBar() {
    final provider = Provider.of<SongsProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
        child: TextFormField(
          onFieldSubmitted: (value) async {
            provider.search(value);
          },
          decoration: InputDecoration(
            hintText: 'Search here',
            hintStyle:TextStyle(
              color: Theme.of(context).colorScheme.secondary
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  Widget getSearchResult() {
    final provider = Provider.of<SongsProvider>(context, listen: true);
    return provider.isLoading
    ? const Loading()
    : Consumer<SongsProvider>(
      builder: (context, songsProvider, child) => ListView.builder(
        itemCount: songsProvider.searchedSongs.data.length,
        itemBuilder: (context, index) => SongCard(
          song: songsProvider.searchedSongs.data[index],
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8), 
          icon: Icons.playlist_add_rounded,
          iconTip: '點歌',
          onPressed: () async {
            log('Index of the requested song = $index');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text('加入「${songsProvider.searchedSongs.data[index].name}」')),
                duration: const Duration(microseconds: 400000),
              ),
            );
            songsProvider.submitSongRequest(songsProvider.searchedSongs.data[index]);
          }
        ),
      ),
    );
  }
}
