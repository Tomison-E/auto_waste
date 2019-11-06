import 'package:flutter/material.dart';
import 'package:auto_waste/utils/uidata.dart';

class CustomFloat extends StatelessWidget {
  final IconData icon;
  final Widget builder;
  final VoidCallback qrCallback;
  final isMini;
  final tag;

  CustomFloat({this.icon, this.builder, this.qrCallback, this.isMini = false,this.tag});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: isMini,
      onPressed: qrCallback,
      heroTag: tag,
      child: Ink(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            builder != null
                ? Positioned(
              right: 7.0,
              top: 7.0,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: builder,
                radius: 10.0,
              ),
            )
                : Container(),
            // builder
          ],
        ),
      ),
    );
  }
}
