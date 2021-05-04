import 'package:flutter/material.dart';

class POSDraggableCart extends StatefulWidget {
  POSDraggableCart({
    Key key,
    this.position,
    this.onChanged,
  }) : super(key: key);
  final double cwidth = 100;
  final double cheight = 100;
  final Offset position;
  final ValueChanged<Offset> onChanged;

  @override
  _POSDraggableCartState createState() => _POSDraggableCartState();
}

class _POSDraggableCartState extends State<POSDraggableCart> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Container(
        width: widget.cwidth,
        height: widget.cheight,
        color: Colors.green,
        child: Text('Drag'),
      ),
      feedback: Container(
        color: Colors.blue,
        child: Center(
          child: Text('drag'),
        ),
      ),
      onDragEnd: (details) {
        print('Drag complete');
        setState(() {
          
        });
      },
    );
  }
}
