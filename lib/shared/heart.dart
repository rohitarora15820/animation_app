import 'dart:developer';

import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _colorTween;
  bool isFav = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _colorTween = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_controller!);

    _controller!.addListener(() {
      log(_controller!.value.toString());
      log(_colorTween!.value.toString());
    });

    _controller!.addStatusListener((status) {
      log(status.toString());
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorTween!.value,
            size: 30,
          ),
          onPressed: () {
            isFav ? _controller!.reverse() : _controller!.forward();
          },
        );
      },
    );
  }
}
