import 'package:final_year_project/CameraDiseasePredictionTab.dart';
import 'package:final_year_project/HelpLine.dart';
import 'package:final_year_project/MainDashBoardTab.dart';
import 'package:final_year_project/WeatherInfoTab.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class MainDashBoard extends StatefulWidget {
  @override
  _MainDashBoardState createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  int currentTab = 0;
  PageController _pageController = PageController();

  // List of Tabs or Screens in the Bottom Navigation Bar.
  static final MainDashBoardTab _userHomeTab = MainDashBoardTab();
  static final WeatherInfoTab _weatherInfoTab = WeatherInfoTab();
  static final CameraDiseasePredictionTab _cameraDiseasePredictionTab =
      CameraDiseasePredictionTab();
  static final HelpLine _helpLine = HelpLine();
  List<Widget> _screen = [
    _userHomeTab,
    _weatherInfoTab,
    _cameraDiseasePredictionTab
    ];

  void _pageChanged(int index) {
    setState(() {
      currentTab = index;
    });
  }

  void userMenuItem(String value, BuildContext context) async {
    if (value == 'NewsInfo') {
      Navigator.pushNamed(context, '/NewsInfo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Digital Kisan'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              userMenuItem(value, context);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "NewsInfo",
                child: Text("NewsInfo"),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: _screen,
          onPageChanged: _pageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
        currentIndex: currentTab,
        curve: Curves.easeInBack,
        items: [
          TitledNavigationBarItem(title: Text('Home'), icon: Icons.home),
          TitledNavigationBarItem(
              title: Text('Weather Info'), icon: WeatherIcons.cloud),
          TitledNavigationBarItem(
              title: Text('Disease Prediction'), icon: Icons.camera),
        ],
        activeColor: Colors.black,
        inactiveColor: Colors.blueGrey,
      ),
    );
  }
}
