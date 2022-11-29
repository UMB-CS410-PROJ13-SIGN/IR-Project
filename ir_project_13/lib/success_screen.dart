import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('Success'),
            TextField(
              controller: _keyController,
            ),
            TextField(
              controller: _valueController,
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () async {
                final String key = _keyController.text;
                final String value = _valueController.text;
                final AtClientManager atClientManager =
                    AtClientManager.getInstance();

                final AtClient atClient = atClientManager.atClient;
                final AtKey atKey =
                    AtKey.public(key, namespace: 'flutter_demo').build();
                final success = await atClient.put(atKey, value);
                print(atKey);
                print('Success: $success');
              },
            ),
          ],
        ),
      ),
    );
  }
}
