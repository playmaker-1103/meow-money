import 'package:monney_management/models/user.dart';
import 'package:monney_management/pages/wrapper.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:monney_management/services/auth_service.dart';
import 'package:monney_management/pages/login/sign_up.dart';
import 'package:monney_management/const_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login>{
  bool hint=false;
  final AuthService authService=AuthService();
  final _formKey=GlobalKey<FormState>();
  final AuthService auth= AuthService();
  String email='',password='';
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context){
    double heightR=MediaQuery.of(context).size.height;
    double widthR=MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:SystemUiOverlayStyle(
        statusBarColor: Colors.orange.shade50,
      ),
      child:Scaffold(
        backgroundColor: Colors.orange.shade50,
        body: Center(
            child:Form(
              key: _formKey,
              child: ListView(
                children:<Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          child:Container(
                            width: widthR,
                            height: heightR/4,
                            color: Colors.orange.shade50
                          )),
                      WaveWidget(
                        config: CustomConfig(
                            gradients: [
                              [Colors.orange.shade200,Colors.orange],
                              [Colors.orange.shade400,Colors.orange],
                              [Colors.orange.shade50,Colors.orange.shade200],
                            ],
                            durations: [5000,10000,6000],
                            heightPercentages:[0,0.35,0.7]
                        ),
                        size: Size(widthR,heightR/3),
                      ),
                      Positioned(child: Text("Meow Money",style: Font().welcomeBlack,),),
                      Positioned(
                          top: heightR/10,
                          left:widthR/3.1,
                          child:const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/avatar.png'),
                            backgroundColor: Colors.white,
                            radius: 60,
                          ))
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top:0,left:135),
                      child: Text('Log in',style: Font().welcomeBlack,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30,left: 20,right: 20),
                    child:TextFormField(
                      validator:(val){
                        if(val==null||val.isEmpty){
                          return "Enter a valid email";
                        }
                        else {
                          return null;
                        }
                      },
                      controller: emailController,
                      onChanged: (text){
                        email=text;
                      },
                      decoration: ConstWigdet().inputDecoration("Your email"),
                    ),
                  ),
                  Padding(
                    padding:ConstValue().edgeInsetsInput,
                    child: TextFormField(
                      validator:(val){
                        if(val==null||val.length<6){
                          return "Enter a valid password";
                        }
                        else{
                          return null;
                        }
                      },
                      onChanged:(text){
                        password=text;
                      },
                      obscureText: hint,
                      decoration: inputPasswordDecoration("Your password"),
                    ),
                  ),
                  Padding(
                    padding:ConstValue().edgeInsets,
                    child: Container(
                      decoration: ConstWigdet().boxDecoration(),
                      child: TextButton(
                        child:Text("Log in",style:Font().headingWhite,),
                        onPressed:()async{
                          if(_formKey.currentState!.validate()){
                            MyUser? result =await authService.signInemailandpassword(email, password);
                            print(result);
                            if(result == null){
                              final snackBar = SnackBar(
                                backgroundColor:Colors.orange[100],
                                content: Text('Invalid email or wrong password!',style: Font().bodyWhite,),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            else{
                              Navigator.push(context,MaterialPageRoute(builder:(context)=>const Wrapper()));
                            }
                          }
                          else{
                            final snackBar = SnackBar(
                              backgroundColor:Colors.orange[100],
                              content: Text('Invalid email or wrong password!',style: Font().bodyBlack,),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:ConstValue().edgeInsets,
                    child: Container(
                      decoration: ConstWigdet().boxDecoration(),
                      child: TextButton(
                        child:Text("Sign up",style:Font().headingWhite,),
                        onPressed:(){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>const SignUp()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
  InputDecoration? inputPasswordDecoration(String label){
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
      labelText:label,
      suffix: InkWell(
          child:hint?const Icon(Icons.remove_red_eye_outlined):const Icon(Icons.visibility_off_sharp),
          onTap:()async{
            setState(() {
              hint=!hint;
            });
          }
      ),
    );
  }
}