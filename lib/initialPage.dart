import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';

import 'ChatScreen.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
          ),
          Center(
            child: Container(
              height: 250,
              width: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/new1.gif"),
                  fit: BoxFit.fitHeight,
                )
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
          ),
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: Text("Speed and accuracy of messages to transfer in the most different types in platform..",
              style:TextStyle(color: Colors.blue, fontStyle: FontStyle.italic), overflow: TextOverflow.ellipsis,maxLines: 4, softWrap: false,),
          ),

    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>
    [
      IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
      }, icon:   Icon(
    Icons.arrow_right_alt_rounded,
    color: Colors.lightBlueAccent,
    size: 36,
    shadows: [
    Shadow(blurRadius: 5, color: Colors.lightBlueAccent),
    ],
    ),),
    // DecoratedIcon(
    // icon: Icon(
    // Icons.arrow_right_alt_rounded,
    // color: Colors.lightBlueAccent,
    // size: 36,
    // shadows: [
    // Shadow(blurRadius: 5, color: Colors.lightBlueAccent),
    // ],
    // ),
    // ),
    ],
    ),
        ],
      ),
    );
  }
}
