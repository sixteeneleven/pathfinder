import 'package:flutter/material.dart';

class NodeButton extends StatefulWidget {
  NodeButton(
      {Key key,
      this.node,
      this.wall,
      this.checking = false,
      this.checked = false})
      : super(key: key);

  List<int> node;
  final bool wall;
  bool checking;
  bool checked;

  _NodeButtonState createState() => _NodeButtonState();
}

class _NodeButtonState extends State<NodeButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            color: nodeColour(),
            child: widget.node[2] == null
                ? Center(child: Text("?"))
                : Center(
                    child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("x" +
                            widget.node[0].toString() +
                            "y" +
                            widget.node[1].toString(), style: TextStyle(fontSize: 9),),
                      Text(widget.node[2].toString()),
                    ],
                  ),
                        ))),
          ),
        ),
    );
  }

  Color nodeColour() {
    if (widget.wall) {
      return Colors.red;
    } else {
      if (widget.checking) {
        return Colors.orange;
      } else if (widget.checked) {
        return Colors.green;
      } else {
        return Colors.grey;
      }
    }
  }
}
