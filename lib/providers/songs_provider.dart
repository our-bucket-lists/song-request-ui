import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:song_request_ui/models/song_model.dart';

class SongsProvider extends ChangeNotifier {
  static const apiEndpoint =
      'http://ec2-13-210-189-82.ap-southeast-2.compute.amazonaws.com:5000/api/v1/songs';

  bool isLoading = true;
  String error = '';
  Songs songs = Songs(data: []);
  Songs searchedSongs = Songs(data: []);
  String searchText = '';

  getSearchResultAPI({String keyword=''}) async {
    isLoading = true;
    notifyListeners();
    
    try {
      Response response = await http.get(
        Uri.parse(keyword==''
          ? '$apiEndpoint?board=new&lang=%E5%9C%8B&min_id=0'
          : '$apiEndpoint?keyword=$keyword'
      ));
      if (response.statusCode == 200) {
        songs = songsFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    searchedSongs.data.clear();
    searchedSongs.data.addAll(songs.data);
    isLoading = false;
    notifyListeners();
  }

  search(String searchText) async {
    await getSearchResultAPI(keyword: searchText);
  }

  bool isEmpty = true;
  Songs addedSongs = Songs(data: []);

  postSongRequestAPI() async {
    isLoading = true;
    notifyListeners();
    
    try {
      Response response = await http.get(
        Uri.parse('$apiEndpoint'
      ));
      if (response.statusCode == 200) {
        songs = songsFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    searchedSongs.data.clear();
    searchedSongs.data.addAll(songs.data);
    isLoading = false;
    notifyListeners();
  }

  addToCart(SongModel song) async {
    addedSongs.data.add(song);
    isEmpty = addedSongs.data.isEmpty;
    notifyListeners();
  }

  removeFromCart(int index) async {
    addedSongs.data.removeAt(index);
    isEmpty = addedSongs.data.isEmpty;
    notifyListeners();
  }
  
  clearCart() async {
    addedSongs.data.clear();
    isEmpty = addedSongs.data.isEmpty;
    notifyListeners();
  }

  submitSongRequestsList() async {
    Map<String, dynamic> postBody = addedSongs.toJson();
    log('Post body: $postBody');
  }

}
