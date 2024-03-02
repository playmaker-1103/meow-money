import 'package:monney_management/pages/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:size_config/size_config.dart';
import 'package:monney_management/const_value.dart';


class Myscreen extends StatefulWidget {
  const Myscreen({super.key});

  @override
  State<Myscreen> createState() => _MyscreenState();
}

class _MyscreenState extends State<Myscreen>with TickerProviderStateMixin{
  bool selected=false;
  bool selectedText=false;
  @override
  Widget build(BuildContext context) {
    double heightR=MediaQuery.of(context).size.height;
    double widthR=MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: SizeConfigInit(
        referenceHeight: heightR,
        referenceWidth: widthR, builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          body: SizedBox(
              width: widthR,
              height: heightR,
              child: Stack(
                children:[
                Positioned(
                  top: 100,
                  left: 100,
                  child: FadeInDownBig(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 1500),
                    child: SizedBox(
                      width: widthR / 2,
                      height: heightR / 4,
                      child: Center(
                          child:Image.asset("assets/images/avatar.png",),),
                    ),
                  ),
                ),
                Positioned(
                  top: heightR / 2.5,
                  left: 10,
                  child: FadeInLeft(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 1000),
                    child: SizedBox(
                      width: widthR / 1.5,
                      height: heightR / 5,
                      child: Center(
                        child: Text(
                            "Easy money,\neasy life",
                            style: Font().title1
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: heightR / 1.8,
                  left: 15,
                  child: FadeInLeft(
                    delay: const Duration(milliseconds: 1000),
                    duration: const Duration(milliseconds: 1000),
                    child: SizedBox(
                      width: widthR,
                      height: heightR / 5,
                      child: Center(
                        child: Text(
                            "Make safe payment and keep your money wise with our help",
                            style: Font().bodyBlack
                        ),
                      ),
                    ),
                  ),
                ),
                  Positioned(
                      bottom: heightR / 8,
                      left: widthR / 12,
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 2000),
                        duration: const Duration(milliseconds: 1000),
                        child: Center(
                            child:GestureDetector(
                              onTap:(){
                                if(selected==true){
                                  Navigator.push(context,_createRoute());
                                }
                              },
                              child:Container(
                                width: widthR*0.8,
                                height: 50,
                                decoration:ConstWigdet().boxDecoration(),
                                child:Center(
                                  child: Text("Get started",style:Font().headingBlack,),
                                )
                              ),
                            )
                        ),)
                  ),
                  Positioned(
                      bottom: heightR / 8,
                      left: widthR / 12,
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 2000),
                        duration: const Duration(milliseconds: 1000),
                        child: Center(
                            child:GestureDetector(
                              onTap:(){
                                setState(() {
                                  selected=!selected;
                                });
                              },
                              child:SizedBox(
                                width: widthR*0.8,
                                height: 50,
                                child:AnimatedAlign(
                                  alignment: selected ?Alignment.bottomRight:Alignment.center,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn,
                                  child: Image.asset("assets/images/splash_meow.png",height:80,width:80,),
                                ),
                              ),
                            )
                        ),)
                  ),
              ],)
          ),
        );
      }));
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Wrapper(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.fastOutSlowIn;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
