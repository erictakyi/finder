import 'package:bookingapp/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Center(
          child: SwitchListTile(
        title: Text('Theme'),
        secondary: Icon(themeState.getDarkTheme
            ?Icons.dark_mode
            : Icons.light_mode_outlined),

        onChanged: (bool value){
          setState((){
            themeState.setDarkTheme = value;
          });


        },
        value: themeState.getDarkTheme,)),

    );
  }

  void setState(Null Function() param0) {}
}
