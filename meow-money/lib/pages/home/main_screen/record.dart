import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/pages/home/add_money/add_money.dart';
import 'package:monney_management/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:monney_management/models/user.dart';
import 'package:monney_management/models/money.dart';
import 'curved_list_item.dart';
import 'package:google_fonts/google_fonts.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  TextStyle fontBold=GoogleFonts.roboto(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold);
  TextStyle fontBigBold=GoogleFonts.roboto(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold);
  DateFormat formatMonth=DateFormat.MMMM('en_US');
  DateFormat formatMonthYear=DateFormat('MM/yyyy');
  List<Color>colorListItems=[
    Colors.green.shade100,
    Colors.lightBlue.shade100,
    Colors.teal.shade200,
    Colors.purple.shade200,
    Colors.red.shade300,
    Colors.yellow.shade100,
    Colors.orange.shade100,
  ];
  @override
  Widget build(BuildContext context) {
    final authInfo = Provider.of<List<UserInformation>?>(context);
    final user = Provider.of<MyUser>(context);
    final billList=Provider.of<List<Bills>?>(context);
    final incomesList=Provider.of<List<Incomes>?>(context);
    //avatar data
    String username='';
    int index=0;
    if(authInfo!=null){
      for(int i=0;i<authInfo.length;i++){
        if(authInfo[i].uid==user.uid){
          // get true data user
          index=i;
          break;
        }
      }
      username=authInfo[index].username??"";//check null
    }
    //bill data
    List product=[];
    int cnt=0,sum=0;//sum is product.length, cnt= sum>7?7:cnt
    double expenses=0,incomes=0;//sum of money in 1 month
    if(billList!=null){
      for(int i=0;i<billList.length;i++){
        if(billList[i].uid==user.uid){
          product.add(billList[i]);
          if(formatMonthYear.format(billList[i].dateTime)==formatMonthYear.format(DateTime.now())){
            expenses+=double.parse(billList[i].money);
          }
        }
      }
    }
    if(incomesList!=null){
      for(int i=0;i<incomesList.length;i++){
        if(incomesList[i].uid==user.uid){
          if(formatMonthYear.format(incomesList[i].dateTime)==formatMonthYear.format(DateTime.now())){
            incomes+=double.parse(incomesList[i].money);
          }
        }
      }
    }
    expenses/=1000;//display dot
    incomes/=1000;//display dot
    product.sort((a,b)=> a.nowDateTime.compareTo(b.nowDateTime));
    sum=product.length;
    cnt=sum>=7?7:sum;
    double heightR= MediaQuery.of(context).size.height;
    double widthR= MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.orange.shade100,
      ),
      child: Scaffold(
        backgroundColor: Colors.orange.shade100,
        body: NestedScrollView(
          headerSliverBuilder:(context,innerBoxIsScroll){
            return <Widget>[
              SliverAppBar(
                leading:const CircleAvatar(backgroundImage:AssetImage("assets/images/napping.png"),backgroundColor:Colors.white,radius:30,),
                title:Text("Hello $username",style:fontBigBold,),
                actions: [
                  IconButton(
                    onPressed:(){
                      AuthService().signOut();
                    },
                    icon:const Icon(Icons.logout),color:Colors.black,),
                ],
                backgroundColor:Colors.orange.shade100,
                floating: false,
                flexibleSpace:FlexibleSpaceBar(
                  background:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: widthR,
                        height: heightR/15,
                        color: Colors.orange.shade100,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:20,top:15),
                            child: Text("${formatMonth.format(DateTime.now())}-Expenses",style:fontBold,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:20,top:15),
                            child: Text("${formatMonth.format(DateTime.now())}-Incomes",style:fontBold,),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,right:70,top:0),
                            child: Text("-${expenses.toStringAsFixed(3)}.000",style: Font().bodyBlack,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:25,right:15,top:0),
                            child: Text("+${incomes.toStringAsFixed(3)}.000",style: Font().bodyBlack,),
                          ),
                          Expanded(child: Image.asset("assets/images/kitty.png",width:80,height:80,),)
                        ],
                      ),
                    ],
                  ),
                ),
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight:heightR/4.6,
              ),
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
            child: Column(
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
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/kitty_write.png",width:40,height:40,),
                      Text("The latest $cnt bills",style:Font().headingBlack,),
                      Image.asset("assets/images/kitty_computer.png",width:40,height:40,),
                    ],
                  ),
                ),
                Expanded(
                  child:product.isNotEmpty?ListView.builder(
                      itemCount:cnt,
                      itemBuilder:(context,index){
                        return CurvedListItem(
                          title: "Bill ${index+1}:-${(double.parse(product[sum-1-index].money)>1000)?(double.parse(product[sum-1-index].money)/1000).toStringAsFixed(3):product[sum-1-index].money}.000",
                          time: product[sum-1-index].dateTime,
                          option: product[sum-1-index].option,
                          note: product[sum-1-index].note,
                          money: (double.parse(product[sum-1-index].money)>1000)?(double.parse(product[sum-1-index].money)/1000).toStringAsFixed(3):product[sum-1-index].money,
                          color:colorListItems[index],
                          nextColor:index==cnt-1?Colors.orange.shade100:colorListItems[index+1],
                          idTouch: product[sum-1-index].idTouch,
                        );
                        }):
                  SizedBox(
                    child: Padding(
                      padding:const EdgeInsets.only(top: 30),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

