import 'package:control_emission/screens/dashboard_page.dart';
import 'package:control_emission/screens/vehicles_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';

  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffDDDDDD),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    'assets/icons/menu_icon.svg',
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset('assets/images/only_logo.png'),
                )
              ],
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Color(0xff004040),
      ),
      body: _getDrawerItemWidget(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xff004040),
        unselectedItemColor: Colors.black,
        elevation: 1,
        enableFeedback: true,
        iconSize: 22,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Dashboard',
            icon: Icon(Icons.dashboard_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Vehicles',
            icon: Icon(CupertinoIcons.car_detailed),
          ),
        ],
        unselectedLabelStyle: TextStyle(
          fontSize: 8,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return DashboardPage();
      case 1:
        return VehiclesPage();
      default:
        return Text("Error");
    }
  }
}

// ImageIcon(
// AssetImage("assets/images/filter_icon.png"),
// size: 24.sp,
// color: Color(0xffD1D5DB),
// )
