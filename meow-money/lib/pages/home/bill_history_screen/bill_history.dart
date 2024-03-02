 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monney_management/models/money.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/pages/home/bill_history_screen/bill_charts.dart';
import 'package:monney_management/pages/home/bill_history_screen/search_bill.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../add_money/add_money.dart';

class BillHistory extends StatefulWidget {
  const BillHistory({super.key});

  @override
  State<BillHistory> createState() => _BillHistoryState();
}

class _BillHistoryState extends State<BillHistory> {
  TextStyle fontBold=GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold);
  bool innerBoxIsScroll=true;
  int? groupValue;
  DateTime? date;
  List<String>months = ['Jan', 'Feb', 'Mar', 'Apr', 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  @override
  Widget build(BuildContext context) {
    double widthR=MediaQuery.of(context).size.width;
    double heightR=MediaQuery.of(context).size.height;
    final user = Provider.of<MyUser>(context);
    final billList=Provider.of<List<Bills>?>(context);
    final incomesList=Provider.of<List<Incomes>?>(context);
    double expenses=0,cloExpenses=0,cosExpenses=0,foodExpenses=0,petExpenses=0,travelExpenses=0,vehExpenses=0;//sum of money in 1 month
    double incomes=0;//sum of money in 1 month
    if(billList!=null){
      for(int i=0;i<billList.length;i++){
        if(billList[i].uid==user.uid){
          expenses+=double.parse(billList[i].money);
          switch(billList[i].option){
            case "Clothes":
              cloExpenses+=double.parse(billList[i].money);
              break;
            case "Cosmetic":
              cosExpenses+=double.parse(billList[i].money);
              break;
            case "Food":
              foodExpenses+=double.parse(billList[i].money);
              break;
            case "Pet":
              petExpenses+=double.parse(billList[i].money);
              break;
            case "Travel":
              travelExpenses+=double.parse(billList[i].money);
              break;
            case "Vehicles":
              vehExpenses+=double.parse(billList[i].money);
              break;
            default:
              print("Error");
          }
        }
      }
    }
    if(expenses!=0.0){
      cloExpenses/=expenses;
      cosExpenses/=expenses;
      foodExpenses/=expenses;
      petExpenses/=expenses;
      travelExpenses/=expenses;
      vehExpenses/=expenses;
    }
    Map<String,double>map={
      "Clothes":cloExpenses,
      "Cosmetic":cosExpenses,
      "Food":foodExpenses,
      "Pet":petExpenses,
      "Travel":travelExpenses,
      "Vehicles":vehExpenses
    };
    var mapEntries = map.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    map..clear()..addEntries(mapEntries);
    List options=map.keys.toList();
    List percent=map.values.toList();
    expenses/=1000;
    //incomes
    if(incomesList!=null){
      for(int i=0;i<incomesList.length;i++){
        if(incomesList[i].uid==user.uid){
          incomes+=double.parse(incomesList[i].money);
        }
      }
    }
    incomes/=1000;
    return AnnotatedRegion(
      value:SystemUiOverlayStyle(
        statusBarColor:Colors.orange.shade100,
      ),
      child: Scaffold(
        backgroundColor:Colors.orange.shade100,
        body:NestedScrollView(
          headerSliverBuilder:(context,innerBoxIsScroll){
            return <Widget>[
              SliverAppBar(
                leading:Image.asset('assets/images/kitty_computer.png',width:20,height:20,),
                title:Text("Bills",style:Font().headingBlack,),
                centerTitle: true,
                backgroundColor:Colors.orange.shade100,
                actions: [
                  IconButton(
                      onPressed:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>const SearchBill()));
                      },
                      icon:Image.asset("assets/images/sleepover-party.png",height:40,width:40,),)
                ],
                floating:false,
                flexibleSpace:FlexibleSpaceBar(
                  background:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: widthR,
                        height: heightR/16,
                        color: Colors.orange.shade100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:10,top:15),
                            child: Text("All-Expenses",style: fontBold,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5,right:100,top:15),
                            child: Text("All-Incomes",style: fontBold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:80,top:15,bottom:20),
                            child: Text('-${expenses.toStringAsFixed(3)}.000',style: Font().bodyBlack,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5,right:15,top:15,bottom:20),
                            child: Text("+${incomes.toStringAsFixed(3)}.000",style: Font().bodyBlack,),
                          ),
                          Expanded(child: Image.asset("assets/images/kitty.png"),)
                        ],
                      ),
                    ],
                  ),
                ),
                expandedHeight:heightR/4.6,
              )
            ];
          },
          body:Container(
            decoration:BoxDecoration(
                color: Colors.orange.shade50,
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  )
                ],
                borderRadius:const BorderRadius.only(
                    topLeft:Radius.circular(40),
                    topRight:Radius.circular(40)
                )
            ),
            child:expenses!=0.0?BillChart(first:percent[5]*100,second:percent[4]*100,third:percent[3]*100,fourth:(1-percent[5]-percent[4]-percent[3])*100
            ,sfirst:options[5],ssecond: options[4],sthird: options[3]):
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Text('Go to add your first bill',style:Font().headingBlack,),
                    IconButton(
                        onPressed:(){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>const Add()));
                        },
                        icon: Image.asset("assets/images/paw-print.png",height:50,width:50,))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
