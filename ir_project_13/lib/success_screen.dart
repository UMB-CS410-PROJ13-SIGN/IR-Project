import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/services.dart';


class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

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
        title: const Text('Project 13 Led'),
        backgroundColor: Colors.black, systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
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
        child: Text("get"),
        onPressed: () async {
          /// @atsign public key shared between the the two @atsigns's
          final String key = "ir";
          /// atsign authenticated with Pico
          final String atSignPico = '@87whispering';
          /// AtClientManager instance responsible to provide a client
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
