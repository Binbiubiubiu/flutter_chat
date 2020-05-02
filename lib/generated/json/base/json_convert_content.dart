// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:simonchat/models/message_entity.dart';
import 'package:simonchat/generated/json/message_entity_helper.dart';

class JsonConvert<T> {
  T fromJson(Map<String, dynamic> json) {
    return _getFromJson<T>(runtimeType, this, json);
  }

  Map<String, dynamic> toJson() {
    return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
      case MessageEntity:
        return messageEntityFromJson(data as MessageEntity, json) as T;
      case MessageUser:
        return messageUserFromJson(data as MessageUser, json) as T;
    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
    switch (type) {
      case MessageEntity:
        return messageEntityToJson(data as MessageEntity);
      case MessageUser:
        return messageUserToJson(data as MessageUser);
    }
    return data as T;
  }

  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {
      case 'MessageEntity':
        return MessageEntity().fromJson(json);
      case 'MessageUser':
        return MessageUser().fromJson(json);
    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {
      case 'MessageEntity':
        return List<MessageEntity>();
      case 'MessageUser':
        return List<MessageUser>();
    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}