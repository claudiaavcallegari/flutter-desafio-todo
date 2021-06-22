import 'package:flutter/material.dart';

import 'connection.dart';

class DatabaseAdmConnection with WidgetsBindingObserver {


  @override
      void didChangeAppLifecycleState(AppLifecycleState state) {
        print(state);
        var connection = Connection();
        switch(state){
          
          case AppLifecycleState.resumed:
            
            break;
          case AppLifecycleState.inactive:
            connection.closeConnection();
            break;
          case AppLifecycleState.paused:
            connection.closeConnection();
            break;
          case AppLifecycleState.detached:
            connection.closeConnection();
            break;
        }




        super.didChangeAppLifecycleState(state);
      }



}