import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:monney_management/services/database.dart';

class UpdateBill extends StatefulWidget {
  const UpdateBill({super.key,required this.idTouch,required this.dateTime,required this.money,this.note});
  final String idTouch,money;
  final DateTime dateTime;
  final String? note;
  @override
  State<UpdateBill> createState() => _UpdateBillState();
}

class _UpdateBillState extends State<UpdateBill> {
  double _currentValue =0;
  final formKey=GlobalKey<FormState>();
  final dateEditingController=TextEditingController();
  final noteEditingController=TextEditingController();
  String? note;
  DateTime? date;
  DateFormat dateFormat=DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    final double widthR=MediaQuery.of(context).size.width;
    final double heightR=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:Form(
          key: formKey,
          child:SizedBox(
            width: widthR,
            height: heightR,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  top: heightR*0.15,
                  child: ShaderMask(
                    // gradient layer
                    shaderCallback: (bound) {
                      return  LinearGradient(
                          end: FractionalOffset.topCenter,
                          begin: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.white70,
                            Colors.orange.shade100,
                          ],
                          stops:const [0.0, 0.8])
                          .createShader(bound);
                    },
                    blendMode: BlendMode.srcOver,
                    child:Image.asset("assets/images/cat-money4.png",height:heightR*0.85,width:widthR,fit: BoxFit.cover,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 100),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Update your bills",style:Font().headingBlack,
                      ),
                      Padding(
                        padding:const EdgeInsets.only(top: 30),
                        child: Container(
                          width: widthR*0.9,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Colors.black,width: 2.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                child: Text(_currentValue==0?"${widget.money}.000":_currentValue.toString(),style:Font().bodyBlack,),
                                onPressed: (){
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context){
                                        return SizedBox(
                                          width: widthR,
                                          height: heightR/2,
                                          child: cal(),
                                        );
                                      }
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:30),
                        child: TextFormField(
                          validator: (val) {
                            if(val==null||val.isEmpty){
                              return 'Enter date';
                            }
                            else
                            {return null;}
                          },
                          controller: dateEditingController,
                          onTap: () async{
                            // Below line stops keyboard from appearing
                            FocusScope.of(context).requestFocus(FocusNode());
                            // Show Date Picker Here
                            await _selectDate(context);
                            dateEditingController.text = DateFormat('dd/MM/yyyy').format(date!);
                          },
                          decoration: ConstWigdet().inputDecoration(dateFormat.format(widget.dateTime)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:30,bottom:30),
                        child: TextFormField(
                          validator: (val) {
                            if(val==null||val.isEmpty){
                              return 'Enter note';
                            }
                            else
                            {return null;}
                          },
                          controller: noteEditingController,
                          onChanged: (text){
                            note=text;
                          },
                          decoration: ConstWigdet().inputDecoration(note??"Update your note"),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: widthR/2.5,
                        decoration: BoxDecoration(
                          color: Colors.brown.shade400,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextButton(
                            onPressed:(){
                              Database().updateDocument(widget.idTouch,_currentValue==0?widget.money:_currentValue.toStringAsFixed(0),note,date??widget.dateTime);
                              Navigator.pop(context);
                              setState(() {
                                _currentValue=0;
                              });
                              dateEditingController.clear();
                              noteEditingController.clear();
                            },
                            child:Text("Update",style:Font().bodyWhite,)),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top:heightR*0.11,
                    right: 35,
                    child:Transform.rotate(
                        angle:350*3.1415927/180,
                        child: Image.asset("assets/images/lazy-cat.png",height:150,width:150,))
                ),
              ],
            ),
          )
      ),
    );
  }
  Widget cal(){
    return SimpleCalculator(
      value: _currentValue,
      hideExpression: true,
      hideSurroundingBorder: true,
      autofocus: true,
      onChanged:(key,value,expression){
        setState(() {
          _currentValue=value??0;
        });
        if (kDebugMode) {
          print('$key\t$value\t$expression');
        }
      },
      theme: CalculatorThemeData(
        borderColor: Colors.black,
        borderWidth: 2,
        displayColor: Colors.orange.shade100,
        displayStyle: const TextStyle(fontSize: 80, color: Colors.black),
        expressionColor: Colors.indigo,
        expressionStyle: const TextStyle(fontSize: 20, color: Colors.white),
        operatorColor: Colors.lightGreen,
        operatorStyle: const TextStyle(fontSize: 30, color: Colors.white),
        commandColor: Colors.brown,
        commandStyle: const TextStyle(fontSize: 30, color: Colors.white),
        numColor: Colors.grey,
        numStyle: const TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date ?? now,
        firstDate: now,
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      print('$picked');
      setState(() {
        date = picked;
      });
    }
  }
}
