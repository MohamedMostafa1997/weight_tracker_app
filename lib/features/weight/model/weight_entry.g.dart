// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightEntry _$WeightEntryFromJson(Map<String, dynamic> json) => WeightEntry(
  id: json['id'] as String,
  userId: json['userId'] as String,
  weight: (json['weight'] as num).toDouble(),
  dateTime: WeightEntry._fromJson(json['dateTime']),
);

Map<String, dynamic> _$WeightEntryToJson(WeightEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'weight': instance.weight,
      'dateTime': WeightEntry._toJson(instance.dateTime),
    };
