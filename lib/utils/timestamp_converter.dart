import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<Timestamp, int> {
  const TimestampConverter();

  @override
  Timestamp fromJson(int json) {
    return Timestamp.fromMillisecondsSinceEpoch(json);
  }

  @override
  int toJson(Timestamp timestamp) {
    return timestamp.millisecondsSinceEpoch;
  }
}