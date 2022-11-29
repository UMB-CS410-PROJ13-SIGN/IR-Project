import 'package:flutter/material.dart';

class FrontEnd extends StatefulWidget {
  const FrontEnd({super.key});

  @override
  State<FrontEnd> createState() => _FrontEndState();
}

class _FrontEndState extends State<FrontEnd> {
  Widget? _animatedWidget;
  bool test = false;

  @override
  void initState() {
    super.initState();
    _animatedWidget = ClipOval(
      child: Image.asset('assets/white.jpg'),
      key: ValueKey(1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project 13 Light'),
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: AnimatedSwitcher(
            child: _animatedWidget,
            duration: const Duration(milliseconds: 1000),
            transitionBuilder: (child, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: child,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            test = !test;
            _animatedWidget = test
                ? ClipOval(
                    child: Image.asset('assets/green.jpg'),
                    key: ValueKey(2),
                  )
                : ClipOval(
                    child: Image.asset('assets/red.jpg'),
                    key: ValueKey(1),
                  );
          });
        },
      ),
    );
  }
}
