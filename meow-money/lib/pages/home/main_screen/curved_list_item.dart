import 'package:intl/intl.dart';
import 'package:monney_management/pages/home/main_screen/update_bill.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:monney_management/services/database.dart';
import 'package:monney_management/const_value.dart';

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({super.key,
    required this.time,
    this.title,
    this.note,
    this.money,
    this.option,
    this.color,
    this.nextColor,
    this.idTouch,
  });
  final String? title,note,money,option,idTouch;
  final DateTime time;
  final Color? color,nextColor;
  @override
  Widget build(BuildContext context) {
    DateFormat format=DateFormat("dd/MM/yyyy");
    return Container(
      color: nextColor,
      child: Container(
        height:120,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
          ),
        ),
        padding: const EdgeInsets.only(
          top: 30,
          left: 32,
        ),
        child:ListTile(
          leading:Image.asset("assets/images/payment.png",height:40,width: 40,),
          title:Text(format.format(time), style:Font().bodyBlack,),
          subtitle: Text(title??"This is your record", style:Font().headingBlack,),
          onTap:(){
            QuickAlert.show(
              context: context,
              type: QuickAlertType.custom,
              title: title,
              text: option??'Details',
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
                        Text("$money.000",style:Font().bodyBlack,)
                      ],
                    ),
                    ConstWigdet().thinDivider(),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Time:",style:Font().bodyBlack,),
                        Text(format.format(time),style:Font().bodyBlack,)
                      ],
                    ),
                    ConstWigdet().thinDivider(),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Note:",style:Font().bodyBlack,),
                        Text(note??"",style:Font().bodyBlack,)
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
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateBill(idTouch: idTouch??"US6sYmwwE57DxJuG2ZOA",money:money??"",dateTime:time,note:note,)));
                              },
                              icon:Image.asset("assets/images/pencil.png",width:35,height:35,),),
                          IconButton(
                            onPressed:(){},
                            icon:Image.asset("assets/images/vip.png",width:40,height:40,),),
                          IconButton(
                            onPressed:(){
                              Database().deleteDocument(idTouch??"US6sYmwwE57DxJuG2ZOA");
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
          },
        ),
      ),
    );
  }
}