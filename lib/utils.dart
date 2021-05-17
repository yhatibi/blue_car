import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot querySnapshot, EventSink<List<T>> sink) {
          final snaps = querySnapshot.docs.map((doc) => doc.data()).toList();
          final json = snaps.map((data) => fromJson(data)).toList();

          sink.add(json);
        },
      );

  static StreamTransformer transformerFromDoc<T>(
      T Function(DocumentSnapshot) fromDoc) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot querySnapshot, EventSink<List<T>> sink) {
          final json = querySnapshot.docs.map((data) => fromDoc(data)).toList();
          sink.add(json);
        },
      );

  static DateTime toDateTime(Timestamp value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }
}
