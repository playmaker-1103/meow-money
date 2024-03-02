import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monney_management/models/money.dart';
import 'package:monney_management/models/user.dart';
import 'charts.dart';
import 'package:monney_management/const_value.dart';
import 'package:provider/provider.dart';

class BillChart extends StatefulWidget {
  const BillChart({super.key,this.first,this.second,this.third,this.fourth, required this.sfirst, required this.ssecond, required this.sthird});
  final double? first,second,third,fourth;
  final String sfirst,ssecond,sthird;
  @override
  State<BillChart> createState() => _BillChartState();
}

class _BillChartState extends State<BillChart> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    final incomesList=Provider.of<List<Incomes>?>(context);
    double incomes=0,salary=0,extra=0,give=0,other=0;
    if(incomesList!=null){
      for(int i=0;i<incomesList.length;i++){
        if(incomesList[i].uid==user.uid){
          incomes+=double.parse(incomesList[i].money);
          switch(incomesList[i].option){
            case "Salary":
              salary+=double.parse(incomesList[i].money);
              break;
            case "Extra Money":
              extra+=double.parse(incomesList[i].money);
              break;
            case "Give":
              give+=double.parse(incomesList[i].money);
              break;
            case "Other":
              other+=double.parse(incomesList[i].money);
              break;
            default:
              print("Error2");
              break;
          }
        }
      }
    }
    if(incomes!=0){
      salary/=incomes;
      extra/=incomes;
      give/=incomes;
      other/=incomes;
    }
    Map<String,double>map2={
      "Salary":salary,
      "Extra Money":extra,
      'Give':give,
      "Others":other
    };
    var map1=map2.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    map2..clear()..addEntries(map1);
    List<String>incomesOption=map2.keys.toList();
    List<double>incomesPercent=map2.values.toList();
    double widthR=MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Center(
          child: Container(
            height:5,
            width: widthR/4,
            color:Colors.grey.shade400,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:20),
          child: Text("Expenses:",style:Font().headingBlack,),
        ),
        Charts(first:widget.first,second:widget.second,third:widget.third,fourth:widget.fourth,sfirst:widget.sfirst,ssecond:widget.ssecond,sthird: widget.sthird),
        Expenses(text:widget.sfirst,color: Colors.red.shade400,),
        Expenses(text:widget.ssecond,color:Colors.orange.shade400,),
        Expenses(text:widget.sthird,color: Colors.yellow.shade400,),
        ConstWigdet().thinDivider(),
        Padding(
          padding: const EdgeInsets.only(right:0,top:20),
          child: Text("Incomes:",style:Font().headingBlack,),
        ),
        incomes!=0.0?Charts(first:incomesPercent[3]*100,second:incomesPercent[2]*100,third:incomesPercent[1]*100,fourth:incomesPercent[0]*100,sfirst:incomesOption[3],ssecond:incomesOption[2],sthird: incomesOption[1])
            :Center(child: Text("No data incomes",style:Font().headingBlack,)),
        incomes!=0.0?IncomesBill(text:incomesOption[3],color: Colors.red.shade400,):Text("",style:Font().bodyBlack,),
        incomes!=0.0?IncomesBill(text:incomesOption[2],color:Colors.orange.shade400,):Text("",style:Font().bodyBlack,),
        incomes!=0.0?IncomesBill(text:incomesOption[1],color: Colors.yellow.shade400,):Text("",style:Font().bodyBlack,),
      ],
    );
  }
}

class Expenses extends StatelessWidget{
  const Expenses({super.key,required this.text,required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context){
    final double heightR=MediaQuery.of(context).size.height;
    DateFormat format=DateFormat('dd-MM-yyyy');
    final user = Provider.of<MyUser>(context);
    final billList=Provider.of<List<Bills>?>(context);
    List product=[];
    switch(text){
      case "Clothes":
        if(billList!=null){
          for(int i=0;i<billList.length;i++){
            if(billList[i].uid==user.uid&&billList[i].option=="Clothes"){
              product.add(billList[i]);
            }
          }
        }
        break;
      case "Cosmetic":
        if(billList!=null){
          for(int i=0;i<billList.length;i++){
            if(billList[i].uid==user.uid&&billList[i].option=="Cosmetic"){
              product.add(billList[i]);
            }
          }
        }
        break;
      case "Food":
        if(billList!=null){
          for(int i=0;i<billList.length;i++){
            if(billList[i].uid==user.uid&&billList[i].option=="Food"){
              product.add(billList[i]);
            }
          }
        }
        break;
      case "Pet":
        if(billList!=null){
          for(int i=0;i<billList.length;i++){
            if(billList[i].uid==user.uid&&billList[i].option=="Pet"){
              product.add(billList[i]);
            }
          }
        }
        break;
      case "Travel":
        if(billList!=null){
          for(int i=0;i<billList.length;i++){
            if(billList[i].uid==user.uid&&billList[i].option=="Travel"){
              product.add(billList[i]);
            }
          }
        }
        break;
      case "Vehicles":
        if(billList!=null){
          for(int i=0;i<billList.length;i++){
            if(billList[i].uid==user.uid&&billList[i].option=="Vehicles"){
              product.add(billList[i]);
            }
          }
        }
        break;
      default:
        print("Error1");
        break;
    }
    return ListTile(
      leading:Image.asset("assets/images/payment.png",height:40,width:40,),
      title:Text(text, style:Font().bodyBlack,),
      subtitle: Container(
        color: color,
        height: 5,
      ),
      onTap:(){
        showModalBottomSheet(
            context: context,
            builder:(BuildContext context){
              return Container(
                decoration:  BoxDecoration(
                  color: Colors.orange.shade100,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.only(topRight:Radius.circular(40),topLeft:Radius.circular(40)),
                ),
                height: heightR/2,
                child: Column(
                  children: [
                    Text("Bills History",style:Font().headingBlack,),
                    ConstWigdet().thickDivider(),
                    Expanded(
                      child: ListView.builder(
                          itemCount: product.length,
                          itemBuilder:(context,index){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Bill ${index+1}:${(double.parse(product[index].money)>1000)?(double.parse(product[index].money)/1000).toStringAsFixed(3):product[index].money}.000",style:Font().bodyBlack,),
                                      Text(format.format(product[index].dateTime),style:Font().bodyBlack,),
                                    ],
                                  ),
                                ),
                                ConstWigdet().thinDivider()
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
            shape:const RoundedRectangleBorder(
                borderRadius:BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40))
            )
        );
      },
    );
  }
}
class IncomesBill extends StatelessWidget{
  const IncomesBill({super.key,required this.text,required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context){
    final double heightR=MediaQuery.of(context).size.height;
    DateFormat format=DateFormat('dd-MM-yyyy');
    final user = Provider.of<MyUser>(context);
    final incomesList=Provider.of<List<Incomes>?>(context);
    List product=[];
    switch(text){
      case "Salary":
        if(incomesList!=null){
          for(int i=0;i<incomesList.length;i++){
            if(incomesList[i].uid==user.uid && incomesList[i].option=="Salary"){
              product.add(incomesList[i]);
            }
          }
        }
        break;
      case "Extra Money":
        if(incomesList!=null){
          for(int i=0;i<incomesList.length;i++){
            if(incomesList[i].uid==user.uid && incomesList[i].option=="Extra Money"){
              product.add(incomesList[i]);
            }
          }
        }
        break;
      case "Give":
        if(incomesList!=null){
          for(int i=0;i<incomesList.length;i++){
            if(incomesList[i].uid==user.uid && incomesList[i].option=="Give"){
              product.add(incomesList[i]);
            }
          }
        }
        break;
      case "Others":
        if(incomesList!=null){
          for(int i=0;i<incomesList.length;i++){
            if(incomesList[i].uid==user.uid && incomesList[i].option=="Other"){
              product.add(incomesList[i]);
            }
          }
        }
        break;
      default:
        print("Error3");
        break;
    }
    return ListTile(
      leading:Image.asset("assets/images/payment.png",height:40,width:40,),
      title:Text(text, style:Font().bodyBlack,),
      subtitle: Container(
        color: color,
        height: 5,
      ),
      onTap:(){
        showModalBottomSheet(
            context: context,
            builder:(BuildContext context){
              return Container(
                decoration:  BoxDecoration(
                  color: Colors.orange.shade100,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.only(topRight:Radius.circular(40),topLeft:Radius.circular(40)),
                ),
                height: heightR/2,
                child: Column(
                  children: [
                    Text("Bills History",style:Font().headingBlack,),
                    ConstWigdet().thickDivider(),
                    Expanded(
                      child: ListView.builder(
                          itemCount: product.length,
                          itemBuilder:(context,index){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Bill ${index+1}:${(double.parse(product[index].money)>1000)?(double.parse(product[index].money)/1000).toStringAsFixed(3):product[index].money}.000",style:Font().bodyBlack,),
                                      Text(format.format(product[index].dateTime),style:Font().bodyBlack,),
                                    ],
                                  ),
                                ),
                                ConstWigdet().thinDivider()
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
            shape:const RoundedRectangleBorder(
                borderRadius:BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40))
            )
        );
      },
    );
  }
}