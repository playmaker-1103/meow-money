import 'package:flutter/material.dart';
import 'package:monney_management/pages/home/bill_history_screen/search_bill_list_tile.dart';
import 'package:monney_management/services/database.dart';
import 'package:monney_management/pages/home/main_screen/update_bill.dart';
import 'package:monney_management/const_value.dart';
import 'package:monney_management/models/money.dart';
import 'package:monney_management/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:choice/choice.dart';

class SearchBill extends StatefulWidget {
  const SearchBill({super.key});

  @override
  State<SearchBill> createState() => _SearchBillState();
}

class _SearchBillState extends State<SearchBill> {
  DateTime? date;
  bool searchDate=true;
  List<String>choices=["Cosmetic",'Clothes','Food','Pet','Travel',"Vehicles"];
  List<String>imageChoose=[
    'assets/images/cosmetic.png',
    'assets/images/clothes-hanger.png',
    'assets/images/burger.png',
    'assets/images/pets.png',
    'assets/images/travel.png',
    'assets/images/car.png',
    'assets/images/check.png',
  ];
  List<String> valueChoose=[];
  void setSelectedChoice(List<String> value){
    setState(() {
      valueChoose=value;
    });
  }
  List search=[];
  DateFormat format=DateFormat('dd/MM/yyyy');
  final dateEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double heightR=MediaQuery.of(context).size.height;
    final double widthR=MediaQuery.of(context).size.width;
    final user = Provider.of<MyUser>(context);
    final billList=Provider.of<List<Bills>?>(context);
    List product=[];
    if(billList!=null){
      for(int i=0;i<billList.length;i++){
        if(billList[i].uid==user.uid){
          product.add(billList[i]);
        }
      }
    }
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body:SizedBox(
        height: heightR,
        width: widthR,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            ShaderMask(
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
              child:Image.asset("assets/images/cat-money4.png",height:heightR,width:widthR,fit: BoxFit.cover,),
            ),
            Padding(
              padding:const EdgeInsets.only(left:0,top:40),
              child:Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded, size: 30, color: Colors.black,),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text("Search Bills",style:Font().headingBlack,),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      height: 45,
                      width: 215,
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color:Colors.black,width: 2.0),
                          color: Colors.lightGreen
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height:40,
                            decoration:BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft:Radius.circular(40),bottomLeft:Radius.circular(40)),
                                border: Border.all(color:Colors.black,width: 2.0),
                                color: searchDate?Colors.lightGreen:Colors.orange.shade100
                            ),
                            child: TextButton(
                              child:Text("Date",style:Font().bodyBlack,),
                              onPressed: (){
                                setState(() {
                                  searchDate=true;
                                });
                              },
                            ),
                          ),
                          Container(
                            height:40,
                            width: 110,
                            decoration:BoxDecoration(
                                borderRadius: const BorderRadius.only(topRight:Radius.circular(40),bottomRight:Radius.circular(40)),
                                border: Border.all(color:Colors.black,width: 2.0),
                                color: searchDate?Colors.orange.shade100:Colors.lightGreen
                            ),
                            child: TextButton(
                              child:Text("Options",style:Font().bodyBlack,),
                              onPressed: (){
                                setState(() {
                                  searchDate=false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30,left:40,right: 40),
                    child:searchDate?TextField(
                      controller: dateEditingController,
                      onTap: () async{
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(FocusNode());
                        // Show Date Picker Here
                        await _selectDate(context);
                        dateEditingController.text = DateFormat('dd/MM/yyyy').format(date!);
                      },
                      decoration: ConstWigdet().inputDecoration("Enter date"),
                    ):Choice<String>.inline(
                      itemCount: choices.length,
                      itemBuilder:(state,i){
                        return ChoiceChip(
                          backgroundColor:Colors.orange.shade200,
                          selectedColor: Colors.lightGreen,
                          selected:state.selected(choices[i]),
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
                      multiple: false,
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
                  ),
                  Padding(
                      padding:const EdgeInsets.only(top:30,left:0),
                      child:Container(
                        height: 50,
                        width: widthR/2.5,
                        decoration: BoxDecoration(
                          color: Colors.brown.shade400,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextButton(
                            onPressed:(){
                              setState(() {
                                if(searchDate){
                                  search=[];
                                  for(var pro in product){
                                    if(format.format(pro.dateTime)==format.format(date??DateTime.now())) {
                                      search.add(pro);
                                    }
                                  }
                                }
                                else{
                                  search=[];
                                  for(var pro in product){
                                    if(pro.option==valueChoose[0]){
                                      search.add(pro);
                                    }
                                  }
                                  valueChoose=[];
                                }
                              });
                            },
                            child:Text("Search",style:Font().bodyWhite,)),
                      ),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(top:30,left:0),
                    child:Text(date==null?"":format.format(date!),style:Font().headingBlack,)
                  ),
                  Expanded(
                    child:search.isNotEmpty?
                        ListView.builder(
                          itemCount: search.length,
                          itemBuilder:(BuildContext context,index){
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SearchBillListTile(
                                money: search[index].money,
                                option:search[index].option,
                                time:search[index].dateTime,
                                index: index,
                                note: search[index].note,
                                idTouch: search[index].idTouch,
                              ),
                            );
                          },
                        ):Center(
                        child: Text(searchDate?"No bill in day":"No option bill",style:Font().bodyBlack,)
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
