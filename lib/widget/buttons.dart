import 'package:flutter/material.dart';

class Main3DButton extends StatefulWidget {
  final Widget? widget;
  final Function()? onPressed;

  const Main3DButton({super.key, this.widget, this.onPressed});
  @override
  _Main3DButtonState createState() => _Main3DButtonState();
}

class _Main3DButtonState extends State<Main3DButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Transform.scale(
        scale: _isPressed ? 0.9 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: _isPressed
                ? []
                : [
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(5, 5),
                    )
                  ],
          ),
          child: widget.widget,
        ),
      ),
    );
  }
}
