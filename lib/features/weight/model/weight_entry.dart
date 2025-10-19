import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weight_entry.g.dart';

@JsonSerializable()
class WeightEntry {
  final String id;
  final String userId;
  final double weight;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime dateTime;

  WeightEntry({
    required this.id,
    required this.userId,
    required this.weight,
    required this.dateTime,
  });


  factory WeightEntry.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WeightEntry(
      id: doc.id,
      userId: data['userId'] as String,
      weight: (data['weight'] as num).toDouble(),
      dateTime: _fromJson(data['dateTime']),
    );
  }

  static DateTime _fromJson(dynamic json) {
    if (json == null) throw ArgumentError('dateTime is null');
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    throw ArgumentError('Invalid dateTime type: $json');
  }

  static dynamic _toJson(DateTime date) => Timestamp.fromDate(date);

  Map<String, dynamic> toJson() => _$WeightEntryToJson(this);

 
}