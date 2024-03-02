import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:monney_management/const_value.dart';
import 'package:intl/intl.dart';
import 'package:monney_management/services/database.dart';
import 'package:monney_management/pages/home/main_screen/update_bill.dart';

class SearchBillListTile extends StatefulWidget {
  const SearchBillListTile({super.key,required this.money,required this.option,required this.time,required this.index,this.note,this.idTouch});
  final String money,option;
  final DateTime time;
  final String? note,idTouch;
  final int index;
  @override
  State<SearchBillListTile> createState() => _SearchBillListTileState();
}

class _SearchBillListTileState extends State<SearchBillListTile> {
  DateFormat format=DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    final widthR=MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      width: widthR,
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(40),
        border:Border.all(color:Colors.black,width:2.0),
      ),
      child: ListTile(
          title:Text("Money: -${(double.parse(widget.money)>1000)?(double.parse(widget.money)/1000).toStringAsFixed(3):widget.money}.000 ",style: Font().bodyBlack,),
          subtitle: Text("Date: ${format.format(widget.time)}",style:Font().bodyBlack,),
          onTap:(){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.custom,
              title: "Bill ${widget.index+1}: -${(double.parse(widget.money)>1000)?(double.parse(widget.money)/1000).toStringAsFixed(3):widget.money}.000 ",
              text: widget.option,
              customAsset:"assets/images/cat_money.gif",
              widget:Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: <Widget>[
                    ConstWigdet().thinDivider(),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount:",style:Font().bodyBlack,),
                        Text("-${(double.parse(widget.money)>1000)?(double.parse(widget.money)/1000).toStringAsFixed(3):widget.money}.000",style:Font().bodyBlack,)
                      ],
                    ),
                    ConstWigdet().thinDivider(),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Time:",style:Font().bodyBlack,),
                        Text(format.format(widget.time),style:Font().bodyBlack,)
                      ],
                    ),
                    ConstWigdet().thinDivider(),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Note:",style:Font().bodyBlack,),
                        Text(widget.note??"",style:Font().bodyBlack,)
                      ],
                    ),
                    ConstWigdet().thinDivider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed:(){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateBill(idTouch: widget.idTouch??"US6sYmwwE57DxJuG2ZOA",money:widget.money,dateTime:widget.time,note:widget.note,)));
                            },
                            icon:Image.asset("assets/images/pencil.png",width:35,height:35,),),
                          IconButton(
                            onPressed:(){},
                            icon:Image.asset("assets/images/vip.png",width:40,height:40,),),
                          IconButton(
                            onPressed:(){
                              Database().deleteDocument(widget.idTouch??"US6sYmwwE57DxJuG2ZOA");
                              Navigator.pop(context);
                            },
                            icon:Image.asset("assets/images/delete.png",width:50,height:50,),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
