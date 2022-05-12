import 'package:bloc_flutter/view/home_page.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(const MyApp(

  ));
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final primaryColor = Color.fromARGB(106, 58, 6, 48);
    final primaryColorDark = Color.fromARGB(255, 32, 27, 29);
    final primaryColorLight = Color.fromARGB(255, 66, 3, 32);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        backgroundColor: Colors.white
      ),
      home: HomePage(),
    );
  }
}