import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
        title: Text('Project 13 BOOLEAN'),
        brightness: Brightness.dark,
        backgroundColor: Color.fromARGB(255, 155, 50, 50),
      ),
      backgroundColor: Color.fromARGB(255, 180, 157, 157),
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
