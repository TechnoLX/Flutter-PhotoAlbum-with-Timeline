import 'dart:convert';

SweetMemo sweetMemoFromJson(String str) => SweetMemo.fromJson(json.decode(str));

String sweetMemoToJson(SweetMemo data) => json.encode(data.toJson());

class SweetMemo {
  SweetMemo({
    this.timeline,
  });

  List<MemoDetails> timeline;

  factory SweetMemo.fromJson(Map<String, dynamic> json) => SweetMemo(
        timeline: List<MemoDetails>.from(
            json["timeline"].map((x) => MemoDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timeline": List<dynamic>.from(timeline.map((x) => x.toJson())),
      };
}

class MemoDetails {
  MemoDetails({
    this.title,
    this.date,
    this.sweetPhoto,
    this.sweetMemo,
  });

  String title;
  String date;
  Map<String, dynamic> sweetPhoto;
  String sweetMemo;

  factory MemoDetails.fromJson(Map<String, dynamic> json) => MemoDetails(
        title: json["title"],
        date: json['date'],
        sweetPhoto: json["sweetPhoto"],
        sweetMemo: json["sweetMemo"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
        "sweetPhoto": sweetPhoto,
        "sweetMemo": sweetMemo,
      };
}
