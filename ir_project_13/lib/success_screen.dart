import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';
import 'package:ir_project_13/front_end.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('Success'),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () async {
                final String key = "ir";
                final String atSignPico = '@87whispering';
                final AtClientManager atClientManager =
                    AtClientManager.getInstance();

                final AtClient atClient = atClientManager.atClient;
                final AtKey atKey =
                    AtKey.public(key, namespace: 'IR', sharedBy: atSignPico)
                        .build();

                final AtValue atValue = await atClient.get(atKey,
                    getRequestOptions: GetRequestOptions()..bypassCache = true);

                final success = await atClient.put(atKey, atValue);
                print(atValue);
                print('Success: $success');

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FrontEnd();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
