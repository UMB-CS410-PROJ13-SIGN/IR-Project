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
      key: const ValueKey(1),
      child: Image.asset('assets/white.jpg'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project 13 Light'),
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            transitionBuilder: (child, animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: child,
              );
            },
            child: _animatedWidget,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            test = !test;
            _animatedWidget = test
                ? ClipOval(
                    child: Image.asset('assets/green.jpg'),
                    key: const ValueKey(2),
                  )
                : ClipOval(
                    child: Image.asset('assets/red.jpg'),
                    key: const ValueKey(1),
                  );
          });
        },
      ),
    );
  }
}
