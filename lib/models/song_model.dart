// To parse this JSON data, do
//
//     final songs = songsFromJson(jsonString);

import 'dart:convert';

Songs songsFromJson(String str) => Songs.fromJson(json.decode(str));

String songsToJson(Songs data) => json.encode(data.toJson());

class Songs {
  Songs({
    required this.data,
  });

  final List<SongModel> data;

  factory Songs.fromJson(Map<String, dynamic> json) => Songs(
    data: List<SongModel>.from(json["data"].map((x) => SongModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SongModel {
    int seq;
    int id;
    String code;
    String name;
    String singer;
    String? lang;
    String? sex;
    String? company;
    String? songDate;
    String? subname;
    String? songDetailId;
    int? counter;
    int? dateSorter;
    int? len;
    String? artistImg;
    String? trackId;
    String? albumId;
    String? albumName;
    String? albumDate;
    String? albumImg;
    String? artistId;
    String? youtubeId;

    SongModel({
        required this.seq,
        required this.id,
        required this.code,
        required this.name,
        required this.singer,
        this.lang,
        this.sex,
        this.company,
        this.songDate,
        this.subname,
        this.songDetailId,
        this.counter,
        this.dateSorter,
        this.len,
        this.artistImg,
        this.trackId,
        this.albumId,
        this.albumName,
        this.albumDate,
        this.albumImg,
        this.artistId,
        this.youtubeId,
    });

    factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        seq: json["seq"],
        id: json["id"],
        code: json["code"],
        name: json["name"],
        singer: json["singer"],
        lang: json["lang"],
        sex: json["sex"],
        company: json["company"],
        songDate: json["songDate"],
        subname: json["subname"],
        songDetailId: json["songDetailID"],
        counter: json["counter"],
        dateSorter: json["dateSorter"],
        len: json["len"],
        artistImg: json["artistIMG"],
        trackId: json["trackID"],
        albumId: json["albumID"],
        albumName: json["albumName"],
        albumDate: json["albumDate"],
        albumImg: json["albumIMG"],
        artistId: json["artistID"],
        youtubeId: json["youtubeID"],
    );

    Map<String, dynamic> toJson() => {
        "seq": seq,
        "id": id,
        "code": code,
        "name": name,
        "singer": singer,
        "lang": lang,
        "sex": sex,
        "company": company,
        "songDate": songDate,
        "subname": subname,
        "songDetailID": songDetailId,
        "counter": counter,
        "dateSorter": dateSorter,
        "len": len,
        "artistIMG": artistImg,
        "trackID": trackId,
        "albumID": albumId,
        "albumName": albumName,
        "albumDate": albumDate,
        "albumIMG": albumImg,
        "artistID": artistId,
        "youtubeID": youtubeId,
    };
}
