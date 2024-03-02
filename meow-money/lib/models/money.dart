
class Goals{
  String jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec;
  Goals({
    required this.jan,
    required this.feb,
    required this.mar,
    required this.apr,
    required this.may,
    required this.jun,
    required this.jul,
    required this.aug,
    required this.sep,
    required this.oct,
    required this.nov,
    required this.dec});
}

class Bills{
  String money,option;
  String? uid,idTouch;
  String? note;
  DateTime dateTime,nowDateTime;
  Bills({required this.money,required this.option,required this.dateTime,this.uid,this.idTouch,required this.nowDateTime,this.note});
}

class Incomes{
  String money,option;
  String? uid,idTouch;
  String? note;
  DateTime dateTime,nowDateTime;
  Incomes({required this.money,required this.option,required this.dateTime,this.uid,this.idTouch,required this.nowDateTime,this.note});
}

class Saving{
  double money;
  String? uid;
  bool completed;
  Saving({required this.money,this.uid,required this.completed});
}