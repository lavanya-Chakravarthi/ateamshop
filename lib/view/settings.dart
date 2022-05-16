import 'package:ateamtest/view/homepage.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/ProductProvider.dart';
class Settings extends StatefulWidget{
  settingState createState() => new settingState();
}

class settingState extends State<Settings>{

bool pval=false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),

      ),
      body:  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                   Text("Notification Settings",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
                  ),
                  ),
                  SizedBox(height: 10,),

                  //  Expands/Collapse the setting when toggles on/off
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      hasIcon: false,
                    ),
                      controller: pval?ExpandableController(initialExpanded: true):ExpandableController(initialExpanded: false),
                      header:  switchwid("Email Notification",1),
                      collapsed: Container(),
                      expanded: Container(
                    height: MediaQuery.of(context).size.height/2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView(
                    children: [
                          switchexwid("Order Updates", true),
                          switchexwid("Shipping Updates", true),
                          switchexwid("Promotions", true),
                          switchexwid("Offers", true),
                          switchexwid("News", true),
                          switchexwid("Messages", false),
                          switchexwid("New Arrivals", true),
                    ],
                  ),
                        ),
                      )

                  ),
                  

                  SizedBox(height: 10,),
                  switchwid("Push Notification",0),
                  SizedBox(height: 10,),

                  switchwid("Notification at Night",0),


                ],
              ),
        ),
      ),

    );
  }


  //Non Expandable widgets
  Widget switchwid(str,type){
    return Row
      (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(str,
          style: GoogleFonts.lato(textStyle:TextStyle(
            fontWeight: FontWeight.w700,fontSize: 18,color: Colors.grey,),),),


        NeumorphicSwitch(
          curve: Curves.easeInOut,

          value: type==1?pval:false,
          height: 30,
          onChanged: (value){
            setState(() {
              if(type == 1) {
                pval = !pval;
              }

            });
          },
        )
      ],
    );
  }

  // Expanded widget
  Widget switchexwid(str,type){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row
        (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(str,
            style:GoogleFonts.lato(textStyle:TextStyle(
              fontWeight: FontWeight.w700,fontSize: 18,color: Colors.grey,),),),

          NeumorphicSwitch(
            curve: Curves.easeInOut,

            value:type,
            height: 30,
            onChanged: (value){


            },
          )
        ],
      ),
    );
  }


}

