import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simonchat/constants/emoji.dart';

class EmojiPicker extends StatefulWidget {
  final bool disabledDelete;
  final ValueChanged onSelected;
  final VoidCallback onDelete;

  EmojiPicker({
    Key key,
    this.onSelected,
    this.onDelete,
    this.disabledDelete,
  }) : super(key: key);

  @override
  _EmojiPickerState createState() => _EmojiPickerState();
}

class _EmojiPickerState extends State<EmojiPicker> {
  List<String> emojis;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emojis = smileys.values.map((e) {
      return e;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double size = (MediaQuery.of(context).size.width - 20) / 8;

    return Container(
      color: Color(0xFFEEEEEE),
      child: Stack(
        children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  widget.onSelected(emojis[index]);
                },
                child: Center(
                  child: Text(
                    emojis[index],
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              );
            },
            itemCount: emojis.length,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            width: size * 2 + 10,
            height: size * 2,
            child: Container(
              alignment: Alignment.centerRight,
              color: Color(0xFFEEEEEE),
              child: GestureDetector(
                onTap: () {
                  widget.onDelete();
                },
                child: Container(
                  width: size + 10,
                  height: size,
                  margin: EdgeInsets.only(right: 14.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Icon(
                    Icons.backspace,
                    size: 22.0,
                    color:
                        widget.disabledDelete ? Colors.black12 : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
