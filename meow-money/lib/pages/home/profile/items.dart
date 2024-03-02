import 'package:flutter/material.dart';
import 'package:monney_management/const_value.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Items extends StatelessWidget {
  const Items({super.key,required this.title,required this.goals,required this.color});
  final String title;
  final double goals;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(40),
        border:Border.all(
          width:2,
          color:Colors.black
        ),
        color:color,
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,style:Font().headingWhite,),
          ConstWigdet().thinDivider(),
          Expanded(child: const Statics(text:"June", goals:100, earn:80).data()),
          Expanded(child: const Statics(text:"July", goals:100, earn:60).data()),
          Expanded(child: const Statics(text:"August", goals:100, earn:50).data()),
          Expanded(child: const Statics(text:"September", goals:100, earn:90).data()),
          Expanded(child: const Statics(text:"October", goals:100, earn:100).data()),
        ],
      ),
    );
  }
}

class Statics{
  const Statics({required this.text,required this.goals,required this.earn});
  final String text;
  final double goals,earn;
  Widget data(){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style:Font().bodyWhite,),
          LinearPercentIndicator(
            width:200,
            lineHeight:20,
            percent: earn/goals,
            center:Text("${earn/goals*100}%",style:Font().bodyBlack,),
            progressColor:Colors.orange.shade100,
            backgroundColor: Colors.white,
            barRadius:const Radius.circular(15),
          )
        ],
      ),
    );
  }
}
