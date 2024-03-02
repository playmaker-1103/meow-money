import 'package:google_fonts/google_fonts.dart';
import 'package:monney_management/pages/login/login.dart';
import 'package:flutter/material.dart';
class Font{
  final welcomeWhite=GoogleFonts.pacifico(fontSize:40,color: Colors.white);
  final welcomeBlack=GoogleFonts.pacifico(fontSize:40,color: Colors.black);
  final pacificoWhite=GoogleFonts.pacifico(fontSize: 25,color: Colors.white);
  final pacificoBlack=GoogleFonts.pacifico(fontSize: 25,color: Colors.black);
  final bodyWhite=GoogleFonts.roboto(fontSize:19,color:Colors.white);
  final bodyBlack=GoogleFonts.roboto(fontSize: 19,color: Colors.black);
  final bodyError=GoogleFonts.roboto(fontSize:19,color: Colors.red);
  final bodyProfile=GoogleFonts.roboto(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold);
  final headingBlack=GoogleFonts.roboto(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold);
  final headingWhite=GoogleFonts.roboto(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold);
  final headingPurple=GoogleFonts.roboto(fontSize: 25,color: Colors.purple[200],fontWeight: FontWeight.bold);
  final title=GoogleFonts.roboto(color: Colors.deepPurple,fontSize:40,fontWeight: FontWeight.bold);
  final title1=GoogleFonts.roboto(color: Colors.black,fontSize: 45,fontWeight: FontWeight.bold);
}

class ConstValue{
  BorderRadius borderRadius=BorderRadius.circular(40);
  BorderSide borderSideOrange=BorderSide(color: Colors.orange.shade800,width:2.0);
  BorderSide borderSideWhite=const BorderSide(color: Colors.white,width:2.0);
  BorderSide borderSideBlack=const BorderSide(color: Colors.black,width:2.0);
  EdgeInsets edgeInsets=const EdgeInsets.symmetric(vertical: 20,horizontal:50);
  EdgeInsets edgeInsetsInput=const EdgeInsets.symmetric(vertical: 30,horizontal: 20);
}

class ConstWigdet{
  Divider thinDivider(){
    return const Divider(
      height: 10,
      thickness: 0.5,
      color: Colors.black,
    );
  }
  Divider thickDivider(){
    return const Divider(
      height: 10,
      thickness:2,
      color: Colors.black,
    );
  }
  InputDecoration? inputDecoration(String label){
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius:ConstValue().borderRadius,
            borderSide:ConstValue().borderSideBlack
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: ConstValue().borderRadius,
            borderSide:ConstValue().borderSideOrange
        ),
        fillColor: Colors.white,
        filled: true,
        labelText: label,
        labelStyle:Font().bodyBlack
    );
  }
  Decoration? boxDecoration(){
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.orange.shade200,
          Colors.orange.shade400
        ],
        stops:const [
          0.1,
          0.8
        ],// red to yellow
        tileMode: TileMode.repeated, // repeats the gradient over the canvas
      ),
      borderRadius: ConstValue().borderRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0,2), // changes position of shadow
        ),
      ],
    );
  }
}

class ConstAppBar{
  AppBar goBackToLogin(String title) {
    return AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded, size: 30, color: Colors.black,),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                  }
              );
            }
        ),
        title: Text(title, style:GoogleFonts.pacifico(fontSize:30,color: Colors.black))
    );
  }
}