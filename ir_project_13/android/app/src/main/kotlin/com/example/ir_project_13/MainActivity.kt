package com.example.ir_project_13

import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {

    void main() async {
        AtClientManager.getInstance().setCurrentAtSign('@alice', 'wavi', <preference>);
        AtClient atclient = atClientManager.atClient;
        Atkey myAtKey = AtKey().key = 'my-pizza'
        String myValue =
        'pepperoni'
        await atclient.put (myAtKey, myValue);
        AtValue result = await atClient. get (myAtKey);
        String value = result. value; // pepperoni
        String myNewvalue = 'meat-lovers';
        await atclient.put myAtKey, myNewValue);
        AtValue result2 = await atClient.get (myAtKey) ;
        String value = result.value; // meat-Lovers
        myAtkey. sharedwith = '@alice';
        await atClient.put (myAtKey, myNewValue);
        await atClient.delete(myAtKey) ;

    }

}
