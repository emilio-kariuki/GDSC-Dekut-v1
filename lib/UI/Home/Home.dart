import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/UI/Announcement/announcement.dart';
import 'package:gdsc_app/UI/Profile/profile.dart';
import 'package:gdsc_app/UI/Resources/resources.dart';

import '../../Util/dimensions.dart';
import '../Events/Events.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;
  var myGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getFooter() {
    List<IconData> icons = [
      Icons.home,
      Icons.layers,
      Icons.notifications,
      Icons.person,
    ];
    List<String> names = [
      "Events",
      "Resources",
      "Announcements",
      "Profile",
    ];
    return AnimatedBottomNavigationBar.builder(
      backgroundColor: Colors.white,
      splashColor: Colors.deepOrangeAccent,
      notchSmoothness: NotchSmoothness.softEdge,
      itemCount: icons.length,
      activeIndex: activeIndex,
      gapWidth: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? Colors.deepOrange : Colors.grey;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons[index],
              size: 18,
              color: color,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AutoSizeText(
                names[index],
                maxLines: 1,
                style: TextStyle(color: color, fontWeight: FontWeight.w500),
                group: myGroup,
              ),
            )
          ],
        );
      },
    );
  }

  selectedTab(index) {
    setState(() {
      activeIndex = index;
    });
  }

  Widget getBody() {
    List<Widget> pages = [
      const Events(),
      const Resources(),
      const Announcements(),
      const Account(),
    ];
    return IndexedStack(
      index: activeIndex,
      children: pages,
    );
  }
}
