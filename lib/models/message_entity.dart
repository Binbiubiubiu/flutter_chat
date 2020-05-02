import 'package:simonchat/generated/json/base/json_convert_content.dart';

class MessageEntity with JsonConvert<MessageEntity> {
  String id;
  String type;
  MessageUser user;
  dynamic content;
}

class MessageUser with JsonConvert<MessageUser> {
  String avator;
  String name;
}
