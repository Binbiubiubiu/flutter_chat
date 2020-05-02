import 'package:simonchat/models/message_entity.dart';

MessageEntity messageEntityFromJson(
    MessageEntity data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toString();
  }
  if (json['type'] != null) {
    data.type = json['type']?.toString();
  }
  if (json['user'] != null) {
    data.user = new MessageUser().fromJson(json['user']);
  }
  if (json['content'] != null) {
    data.content = json['content']?.toString();
  }
  return data;
}

Map<String, dynamic> messageEntityToJson(MessageEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['type'] = entity.type;
  if (entity.user != null) {
    data['user'] = entity.user.toJson();
  }
  data['content'] = entity.content;
  return data;
}

messageUserFromJson(MessageUser data, Map<String, dynamic> json) {
  if (json['avator'] != null) {
    data.avator = json['avator']?.toString();
  }
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  return data;
}

Map<String, dynamic> messageUserToJson(MessageUser entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['avator'] = entity.avator;
  data['name'] = entity.name;
  return data;
}
