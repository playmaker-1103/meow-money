import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:monney_management/pages/home/add_money/add_money.dart';
import 'package:monney_management/pages/home/bill_history_screen/bill_history.dart';
import 'package:monney_management/pages/home/main_screen/record.dart';
import 'package:monney_management/pages/home/profile/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;
  final List<Color> colors = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 4, vsync: this);
    tabController.animation?.addListener(
          () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color unselectedColor = colors[currentPage].computeLuminance() < 0.5 ? Colors.black : Colors.white;
    return SafeArea(
      child: Scaffold(
        body: BottomBar(
          clip: Clip.none,
          fit: StackFit.expand,
          borderRadius: BorderRadius.circular(500),
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
          showIcon: true,
          width: MediaQuery.of(context).size.width * 0.8,
          barColor: Colors.white,
          start: 2,
          end: 0,
          offset: 10,
          barAlignment: const Alignment(0.1,0.85),
          iconHeight: 30,
          iconWidth: 30,
          reverse: true,
          hideOnScroll: false,
          scrollOpposite: false,
          body: (context, controller) => TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children:const <Widget>[
              Record(),
              BillHistory(),
              Add(),
              ProfileScreen()
            ]
          ),
          child:TabBar(
            indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            controller: tabController,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: currentPage <= 3 ? colors[currentPage] : unselectedColor,
                  width: 4,
                ),
                insets: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
            tabs: [
              iconNavBar("assets/images/invoice.png"),
              iconNavBar("assets/images/mobile-transfer.png"),
              iconNavBar("assets/images/paw-print.png"),
              iconNavBar("assets/images/gear.png")
            ],
          ),
        ),
      ),
    );
  }
}
Widget iconNavBar(String asset){
  return SizedBox(
    height: 55,
    width: 40,
    child: Center(
      child:Image.asset(asset,width:25,height:25,)
    ),
  );
}