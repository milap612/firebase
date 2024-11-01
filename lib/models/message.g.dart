// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      senderId: json['senderId'] as String,
      senderEmail: json['senderEmail'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      timeStamp: const TimestampConverter()
          .fromJson((json['timeStamp'] as num).toInt()),
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'senderEmail': instance.senderEmail,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'timeStamp': const TimestampConverter().toJson(instance.timeStamp),
    };
