import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';
import 'package:choice/choice.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/services/database.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String>typeList=['Only Month','Year','Every Month'];
  List<String>months = ['Jan', 'Feb', 'Mar', 'Apr', 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  List<String>choices=["Cosmetic",'Clothes','Food','Pet','Travel',"Vehicles",'All'];
  List<String>imageChoose=[
    'assets/images/cosmetic.png',
    'assets/images/clothes-hanger.png',
    'assets/images/burger.png',
    'assets/images/pets.png',
    'assets/images/travel.png',
    'assets/images/car.png',
    'assets/images/check.png',
  ];
  String? typeChoose,monthChoose;
  double _currentSliderValue=20;
  List<String> valueChoose=[];
  void setSelectedChoice(List<String> value){
    setState(() {
      valueChoose=value;
    });
  }
  bool hidden=false;
  @override
  Widget build(BuildContext context) {
    double widthR=MediaQuery.of(context).size.width;
    double heightR=MediaQuery.of(context).size.height;
    final user=Provider.of<MyUser?>(context);
    return Container(
      height: heightR/3,
      width: widthR,
      decoration:BoxDecoration(
        color:Colors.orange.shade100,
        borderRadius:const BorderRadius.only(topRight:Radius.circular(40),topLeft:Radius.circular(40)),
        border:Border.all(color: Colors.black,width:1.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
              child: Text("Set your goals",style:Font().headingBlack,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.circular(40),
                border:Border.all(width:1.5,color:Colors.black)
              ),
              child: Row(
                children: [
                  Text('  Select type: ',style:Font().bodyBlack,),
                  SizedBox(
                    width: widthR/2.9,
                    height: heightR/19,
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down,size: 30,),
                      underline: const SizedBox(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87
                      ),
                      value: typeChoose??typeList[0],
                      onChanged:(newType){
                        setState(() {
                          typeChoose = newType;
                          if(typeChoose=="Only Month"){
                            setState(() {
                              hidden= true;
                            });
                          }
                          else {
                            hidden=false;
                          }
                        });
                      } ,
                      items: typeList.map((type){
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type,style:Font().bodyBlack,),
                        );
                      }).toList(),
                    ),
                  ),
                  hidden?SizedBox(
                    width:widthR/3.5,
                    height: heightR/19,
                      child:DropdownButton(
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down,size: 30,),
                        underline: const SizedBox(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87
                        ),
                        value: monthChoose??months[0],
                        onChanged:(newType){
                          setState(() {
                            monthChoose = newType;
                          });
                        } ,
                        items: months.map((type){
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type,style:Font().bodyBlack,),
                          );
                        }).toList(),
                      )
                  ):
                  SizedBox(
                    width: widthR/3.5,
                  )
                ],
              ),
            ),
          ),
          Choice<String>.inline(
              itemCount: choices.length,
              itemBuilder:(state,i){
                return ChoiceChip(
                  backgroundColor:Colors.lightGreen,
                  selectedColor: Colors.red.shade200,
                  selected:state.selected(choices[choices.length-1])?true:state.selected(choices[i]),
                  onSelected:state.onSelected(choices[i]),
                  label:SizedBox(
                    height:40,
                    width:150,
                    child:Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Image.asset(imageChoose[i],width:50,height: 40,),
                        Text(choices[i],style:Font().bodyBlack,)
                      ],
                    ),
                  ),
                );
              },
            multiple: true,
            clearable: true,
            value: valueChoose,
            onChanged: setSelectedChoice,
            listBuilder: ChoiceList.createScrollable(
              spacing: 10,
              runSpacing: 10,
              padding:  const EdgeInsets.symmetric(
                horizontal:10,
                vertical: 10,
              ),
            ),
          ),
          Center(
            child: Text("Choose value:",style:Font().bodyBlack,),
          ),
          Slider(
              value: _currentSliderValue,
              max: 55,
              min:5,
              divisions:10,
              activeColor:Colors.red.shade200,
              inactiveColor:Colors.lightGreen,
              label: "${_currentSliderValue.round().toStringAsFixed(3)}.000",
              onChanged:(double value){
                setState(() {
                  _currentSliderValue=value;
                });
              }),
          Container(
            height:heightR/19,
            width: widthR/3,
            decoration:BoxDecoration(
              color: Colors.brown,
              border: Border.all(),
              borderRadius: BorderRadius.circular(40)
            ),
            child: TextButton(
                onPressed:(){
                  for(int i=0;i<valueChoose.length;i++){
                    //Database(uid: user!.uid).updateGoals(_currentSliderValue.toStringAsFixed(3),valueChoose[i],typeChoose??"Every Month",monthChoose);
                    Database(uid: user!.uid).setGoals("10.000",valueChoose[i]);
                  }
                  Navigator.pop(context);
                },
                child:Text("Save",style:Font().bodyWhite,)
            ),
          )
        ],
      ),
    );
  }
}
