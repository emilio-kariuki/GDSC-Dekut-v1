// ignore_for_file: prefer_const_constructors, must_call_super

import 'package:flutter/material.dart';
import 'package:gdsc_app/UI/Profile/Pages/Admins/admins._announcements.dart';
import 'package:gdsc_app/UI/Profile/Pages/Admins/admins_resources.dart';
import 'package:gdsc_app/UI/Profile/Pages/Post/comm_Events.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:gdsc_app/Util/dimensions.dart';
import 'package:get/get.dart';

import '../../../../Controller/app_controller.dart';
import 'admin_events.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static var controller = Get.put(AppController());
  late TabController tabController;
  int index = 0;
  List<Tab> tabs = <Tab>[
    Tab(
      child: Components.header_3(
          "Event", controller.isDark.value ? Colors.white : Colors.black87),
    ),
    Tab(
      child: Components.header_3("Annoucements",
          controller.isDark.value ? Colors.white : Colors.black87),
    ),
    Tab(
      child: Components.header_3(
          "Resources", controller.isDark.value ? Colors.white : Colors.black87),
    ),
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          backgroundColor:
              controller.isDark.value ? Colors.grey[900] : Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
                color:
                    controller.isDark.value ? Colors.white : Colors.grey[900],
                size: 20),
            title: Components.header_2(
              "Admin",
            ),
            centerTitle: true,
            backgroundColor:
                controller.isDark.value ? Colors.grey[900] : Colors.white,
            elevation: 0,
            bottom: TabBar(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              tabs: tabs,
              //controller: tabController,
              indicatorWeight: 2,
              indicator: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(50),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor:
                  controller.isDark.value ? Colors.white : Colors.black87,
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: const [
                AdminEvents(),
                AdminAnnouncements(),
                AdminResources(),
              ],
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
