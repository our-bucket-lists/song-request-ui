import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_request_ui/providers/songs_provider.dart';
import 'package:song_request_ui/widgets/my_widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    log('Cart page build is called.');
    final provider = Provider.of<SongsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
      child: Column(
        children: [
          Expanded(
            child: getCartResult()
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 8, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PrettyTextButton(
                  text: '清空',
                  onPressed: () async {
                    log('Clean up the cart.');
                    await provider.clearCart();
                  }
                ),
                PrettyTextButton(
                  text: '送出',
                  onPressed: () async {
                    log('The song requests list has been summit.');
                    //await provider.submitSongRequestsList();
                  }
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

  Widget getCartResult() {
    final provider = Provider.of<SongsProvider>(context, listen: true);
    return provider.isEmpty
    ? const Center(child: Text('Empty', style: TextStyle(fontSize: 60),))
    : Consumer<SongsProvider>(
      builder: (context, songsProvider, child) => ReorderableListView.builder(
        buildDefaultDragHandles: false,
        onReorder:(oldIndex, newIndex) {
          log('Cart list is reordered');
          if (oldIndex < newIndex) {
            newIndex --;
          }
          final song = songsProvider.addedSongs.data.removeAt(oldIndex);
          songsProvider.addedSongs.data.insert(newIndex, song);
        },
        itemCount: songsProvider.addedSongs.data.length,
        itemBuilder: (context, index) => Container(
          key: ValueKey(index),
          child: ReorderableDragStartListener(
            index: index,
            child: SongCard(
              song: songsProvider.addedSongs.data[index],
              padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4), 
              icon: Icons.playlist_remove_rounded,
              iconTip: '刪除',
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(child: Text('刪除「${songsProvider.searchedSongs.data[index].name}」')),
                    duration: const Duration(microseconds: 400000),
                  ),
                );
                songsProvider.removeFromCart(index);
              }
            ),
          ),
        ),
      ),
    );
  }
}
