import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  static SettingsTab? settingsTab = null;
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget getSettingsTab(){
    if(settingsTab == null){
      settingsTab = SettingsTab();
    }
      return settingsTab!;

  }
}
