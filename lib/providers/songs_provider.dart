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

  //
  getDataFromAPI({String keyword=''}) async {
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
    isLoading = false;
    updateData();
  }

  updateData() {
    searchedSongs.data.clear();
    searchedSongs.data.addAll(songs.data);
    // if (searchText.isEmpty) {
    //   searchedSongs.data.addAll(songs.data);
    // } else {
    //   searchedSongs.data.addAll(songs.data
    //       .where((element) =>
    //           element.name!.toLowerCase().startsWith(searchText))
    //       .toList());
    // }
    notifyListeners();
  }

  search(String searchText) async {
    await getDataFromAPI(keyword: searchText);
    // updateData();
  }
}
