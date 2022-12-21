import 'package:at_app_flutter/at_app_flutter.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ir_project_13/success_screen.dart';
import 'package:path_provider/path_provider.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<AtClientPreference> loadPreferences() async {
    var dir = await getApplicationSupportDirectory();

    return AtClientPreference()    /// setup Atclient preferences
      ..rootDomain = AtEnv.rootDomain
      ..namespace = ''
      ..hiveStoragePath = dir.path
      ..commitLogPath = dir.path
      ..isLocalStoreRequired = true;
  }

  @override
  Widget build(BuildContext context) {
    KeyChainManager.getInstance().clearKeychainEntries();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project 13'),
        backgroundColor: Colors.black, systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(

        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/a.jpg'),
              fit: BoxFit.cover,
            )),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
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
                      return const SuccessScreen();
                    },
                  ),
                );
              }
            },
            child: const Text('Login'),
          ),///ElevatedButton
        ),///Center
      ),
    );///Scafo=fold
  }
}