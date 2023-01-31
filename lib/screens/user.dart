

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../widget/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme?Colors.white :Colors.black;
    return  Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text:  TextSpan(
                    text: 'Hi, ',
                    style: const  TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'MyName',
                        style: TextStyle(
                          color: color,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()..onTap =(){
                          print('My name is pressed');
                      }

                      ),
                    ]
                  ),
                ),
                const SizedBox(height: 5,
                ),
                TextWidget(
                  text:'nanatakyieric@gmail.com',
                  color:color,
                  textSize: 18 ,
                  //isTitle: true,
                ),

                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                _listTiles(
                  title: 'Address 2',
                  subtitle: 'My subtitle',
                  icon: IconlyBold.profile,
                  onPressed: ()async{
                    await _showAddressDialoge();

                  },
                  color:color,
                ),

                _listTiles(
                    title: 'Viewed',
                    icon: IconlyBold.show,
                    onPressed: (){}, color:color,
                ),
                _listTiles(
                    title: 'Forget password',
                    icon: IconlyBold.unlock,
                    onPressed: (){}, color:color,
                ),
                SwitchListTile(
                  title: TextWidget(
                    text:themeState.getDarkTheme ?'Dark mode':'Light mode',
                    color:color,
                    textSize: 18 ,
                    //isTitle: true,
                  ),
                  secondary: Icon(themeState.getDarkTheme
                      ?Icons.dark_mode
                      : Icons.light_mode_outlined),

                  onChanged: (bool value){
                    setState((){
                      themeState.setDarkTheme = value;
                    });


                  },
                  value: themeState.getDarkTheme,),
                _listTiles(
                    title: 'Logout',
                    icon: IconlyBold.logout,
                    onPressed: (){
                      _showLogoutDialoge();
                      },
                  color:color,
                ),

              ],
            ),
          ),
        ),
      ));

  }
  Future < void > _showLogoutDialoge()async{
    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 8,
              ),
              const Text('Sign out'),

            ]),
            content: const Text('Do you want to sign out?'),
            actions: [
              TextButton(
                  onPressed: (){
                    if (Navigator.canPop(context)){
                      Navigator.pop(context);

                    }

                  },
                  child: TextWidget(
                    color: Colors.cyan,
                    text: 'cancel',
                    textSize: 18,
              ),
              ),
              TextButton(
                onPressed: (){},
                child: TextWidget(
                  color: Colors.red,
                  text: 'OK',
                  textSize: 18,
                ),
              ),
            ],

);

    });

  }
  Future < void > _showAddressDialoge()async{
    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              // onChanged: (value){
              //   print('_addressTextController.text${_addressTextController.text}');
              // },
              controller:_addressTextController ,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Your address"),
           ),
           actions: [
             TextButton(onPressed:() {}, child: const Text('Update'),
        ),
      ],

    );
  });

}
  Widget _listTiles ({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }){
    return ListTile(
      title: TextWidget(
      text:title,
      color:color,
      textSize: 22 ,
      //isTitle: true,
    ),
      subtitle:TextWidget(
        text:subtitle == null ? "":subtitle,
        color:color,
        textSize: 18 ,

      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: (){
        onPressed();
      },
    );
  }
}
