import 'package:flutter/material.dart';

class Node extends StatefulWidget {
  Node({
    Key key,
  }) : super(key: key);

  String _value;

  Node.withValue(String newValue) : _value = newValue;

  String getNodeValue() {
    return _value;
  }

  void updateNode(String newStatus) {
    {
      _value = newStatus;
    }
  }

  _NodeState createState() => _NodeState();
}

class _NodeState extends State<Node> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          width: 40, height: 40, color: colour(widget.getNodeValue())),
    );
  }
}

colour(String state) {
  if (state == 'empty') {
    return Colors.grey;
  } else if (state == 'checked') {
    return Colors.yellow;
  } else if (state == 'path') {
    return Colors.red;
  }
}
