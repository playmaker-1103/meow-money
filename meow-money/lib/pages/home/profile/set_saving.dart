import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/models/money.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/services/database.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class SetSaving extends StatefulWidget {
  const SetSaving({super.key,required this.expenses,required this.incomes});

  final double expenses,incomes;
  @override
  State<SetSaving> createState() => _SetSavingState();
}

class _SetSavingState extends State<SetSaving> {
  double currentSliderValue=20;
  bool hidden=false;
  @override
  Widget build(BuildContext context) {
    final double heightR=MediaQuery.of(context).size.height;
    final double widthR=MediaQuery.of(context).size.width;
    double saving=widget.incomes>widget.expenses?widget.incomes-widget.expenses:0;
    double currentSave=10;
    final user=Provider.of<MyUser?>(context);
    final saveList=Provider.of<List<Saving>?>(context);
    if(saveList!=null){
      for(int i=0;i<saveList.length;i++){
        if(saveList[i].uid==user!.uid){
          hidden=saveList[i].completed;
          currentSave=saveList[i].money;
        }
      }
    }
    return Container(
      height: heightR/2.5,
      width: widthR,
      decoration:BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(40),
          border: Border.all(color: Colors.black,width: 2.0),
          color: Colors.orange.shade100
      ),
      child: Column(
        children: [
          Text(hidden?"Finish ${widget.incomes>widget.expenses?"${(widget.incomes-widget.expenses).toStringAsFixed(3)}.000":"0"}/${currentSave.toStringAsFixed(3)}.000":"Set your saving money",style: Font().headingBlack,),
          Text(hidden?"":"Once you press save you can't change it until it's done",style: Font().bodyBlack,),
          hidden?CircularPercentIndicator(
            radius: 100,
            percent:saving/currentSave>1?1:saving/currentSave,
            progressColor: Colors.lightGreen,
            backgroundColor: Colors.brown.shade400,
          ):Slider(
              value: currentSliderValue,
              max: 55,
              min:5,
              divisions:10,
              activeColor:Colors.red.shade200,
              inactiveColor:Colors.lightGreen,
              label: "${currentSliderValue.round().toStringAsFixed(3)}.000",
              onChanged:(double value){
                setState(() {
                  currentSliderValue=value;
                });
              }),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height:heightR/19,
              width: widthR/3,
              decoration:BoxDecoration(
                  color: Colors.brown,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(40)
              ),
              child: TextButton(
                  onPressed:(){
                    setState(() {
                      hidden=true;
                      if((widget.incomes-widget.expenses)/currentSliderValue>1){
                        hidden=false;
                        final snackBar = SnackBar(
                          backgroundColor:Colors.brown,
                          content: Text('Saving Successfully',style: Font().bodyWhite,),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                    if(hidden){
                      Database(uid:user!.uid).addSavingData(currentSliderValue,hidden);
                    }
                    else{
                      Navigator.pop(context);
                    }
                  },
                  child:Text(hidden?"Ok":"Save",style:Font().bodyWhite,)
              ),
            ),
          )
        ],
      ),
    );
  }
}
