import 'package:at_app_flutter/at_app_flutter.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:flutter/material.dart';
//import 'package:ir_project_13/success_screen.dart';
import 'package:ir_project_13/testing.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:ir_project_13/success_screen.dart';
//import 'package:ir_project_13/testing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<AtClientPreference> loadPreferences() async {
    var dir = await getApplicationSupportDirectory();

    return AtClientPreference()
      ..rootDomain = AtEnv.rootDomain
      ..namespace = ''
      ..hiveStoragePath = dir.path
      ..commitLogPath = dir.path
      ..isLocalStoreRequired = true; // Future<AtClientPreference>
  }

  @override
  Widget build(BuildContext context) {
    KeyChainManager.getInstance().clearKeychainEntries();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Login'),
          onPressed: () async {
            final AtOnboardingResult result = await AtOnboarding.onboard(
              context: context,
              config: AtOnboardingConfig(
                atClientPreference: await loadPreferences(),
                appAPIKey: AtEnv.appApiKey,
                domain: AtEnv.rootDomain,
                rootEnvironment: AtEnv.rootEnvironment,
              ),
            );

            if (result.status == AtOnboardingResultStatus.success) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Testing();
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
