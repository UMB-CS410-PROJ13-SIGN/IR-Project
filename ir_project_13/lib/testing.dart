import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  //final TextEditingController _keyController = TextEditingController();
  Widget? _animatedWidget;
  bool test = false;
  String str = "";

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
      floatingActionButton: ElevatedButton(
        child: Text("submit"),
        onPressed: () async {
          final String key = "ir";
          final String atSignPico = '@87whispering';
          final AtClientManager atClientManager = AtClientManager.getInstance();

          final AtClient atClient = atClientManager.atClient;
          final AtKey atKey =
              AtKey.public(key, namespace: 'IR', sharedBy: atSignPico).build();

          final AtValue atValue = await atClient.get(atKey,
              getRequestOptions: GetRequestOptions()..bypassCache = true);

          //final success = await atClient.put(atKey, atValue);
          print(atValue);
          print('Success: $atValue');
          setState(() {
            str = atValue.value;
            if (str == "True") {
              test = true;
            } else {
              test = false;
            }
            _animatedWidget = test
                ? ClipOval(
                    child: Image.asset('assets/green.jpg'),
                    key: const ValueKey("True"),
                  )
                : ClipOval(
                    child: Image.asset('assets/red.jpg'),
                    key: const ValueKey("False"),
                  );
          });
        },
      ),
    );
  }
}
