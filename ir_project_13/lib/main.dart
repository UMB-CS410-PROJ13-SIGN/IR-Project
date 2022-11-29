import 'package:at_client/at_client.dart';
import 'package:flutter/material.dart';
import 'package:ir_project_13/home_screen.dart';
import 'package:at_commons/at_commons.dart';

void main() async {

  /// Setup two atClients with their respective atSigns
  /// gets [AtClient] and [NotificationService] instances of at sign .


    ///IR transmitter atSign client
    final atSign_device = '@board1potential';
    final device_name = 'IR transmitter';
    final atClientPreference = AtClientPreference();
    // Initializing AtClientManager instance
    await AtClientManager.getInstance()
        .setCurrentAtSign(atSign_device,device_name, atClientPreference);

    // Getting the AtClient instance
    AtClient atClient_device = AtClientManager.getInstance().atClient;
    // Storing value to keystore
    atClient_device.put(
        AtKey.public('boolean', namespace: device_name).build(), 'false');

    // Getting the NotificationService instance
    NotificationService notificationService =
        AtClientManager.getInstance().notificationService;
    // Invoking the notify method
    notificationService.notify(NotificationParams.forUpdate(
        AtKey.shared('boolean', namespace:device_name).build()));


    ///APP atSign client to display data

    final atSign_app = '@administrative77';
    final app_name = 'IR APP';
    // Initializing AtClientManager instance
    await AtClientManager.getInstance()
        .setCurrentAtSign(atSign_app,app_name, atClientPreference);

    // Getting the AtClient instance
    AtClient atClient_app = AtClientManager.getInstance().atClient;
    // Storing value to keystore
    atClient_app.put(
        AtKey.public('Received?', namespace: app_name).build(), 'false');


    notificationService.notify(NotificationParams.forUpdate(
        AtKey.shared('Received?', namespace:app_name).build()));

    ConnectivityListener().subscribe().listen((isConnected) {
        if (isConnected) {
            print('connection available');
        } else {
            print('connection lost');
        }
    });


    const MaterialApp app = MaterialApp(
    home: HomeScreen(),
  );

  runApp(app);
}

