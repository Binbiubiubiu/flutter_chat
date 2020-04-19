import 'package:flutter/material.dart';

class BottomMenuBar extends StatefulWidget {
  final int currentIndex;
  final List<BottomMenu> children;
  final ValueChanged<int> onChange;

  BottomMenuBar({Key key, this.currentIndex = 0, this.children, this.onChange})
      : assert(children.length > 0),
        assert(currentIndex >= 0 && currentIndex < children.length),
        super(key: key);
  @override
  _BottomMenuBarState createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black26,
              width: 0.5,
            ),
          ),
        ),
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildChildren(),
        ),
      ),
    );
  }

  buildChildren() {
    List<BottomMenu> children = [];
    for (int i = 0; i < widget.children.length; i++) {
      var current = widget.children[i];
      children.add(
        BottomMenu(
          key: ValueKey(i),
          icon: current.icon,
          activeIcon: current.activeIcon,
          title: current.title,
          isActive: widget.currentIndex == i,
          onTap: widget.onChange,
        ),
      );
    }
    return children;
  }
}

class BottomMenu extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final String title;
  final ValueChanged<int> onTap;

  BottomMenu({
    Key key,
    this.icon,
    this.activeIcon,
    this.title,
    this.onTap,
    this.isActive = false,
  })  : assert(icon != null),
        assert(title != null),
        assert(activeIcon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (onTap != null) {
            onTap((key as ValueKey).value);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            isActive
                ? Icon(
                    activeIcon,
                    color: primaryColor,
                  )
                : Icon(icon),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                color: isActive ? primaryColor : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
