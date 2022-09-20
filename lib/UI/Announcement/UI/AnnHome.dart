// ignore_for_file: prefer_const_constructors, must_call_super

import 'package:flutter/material.dart';
import 'package:gdsc_app/UI/Announcement/UI/announcement.dart';
import 'package:gdsc_app/UI/Announcement/UI/news.dart';
import 'package:gdsc_app/UI/Profile/Pages/Admins/admin_meeting.dart';
import 'package:gdsc_app/UI/Profile/Pages/Admins/admins._announcements.dart';
import 'package:gdsc_app/UI/Profile/Pages/Admins/admins_resources.dart';
import 'package:gdsc_app/UI/Profile/Pages/Leads/UI/leads.dart';
import 'package:gdsc_app/UI/Profile/Pages/Post/comm_Events.dart';
import 'package:gdsc_app/UI/Profile/Pages/Post/comm_leads.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:gdsc_app/Util/dimensions.dart';
import 'package:get/get.dart';

import '../../../../Controller/app_controller.dart';

class AnnHome extends StatefulWidget {
  const AnnHome({Key? key}) : super(key: key);

  @override
  State<AnnHome> createState() => _AnnHomeState();
}

class _AnnHomeState extends State<AnnHome>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static var controller = Get.put(AppController());
  late TabController tabController;
  int index = 0;
  List<Tab> tabs = <Tab>[
    Tab(
      child: Components.header_3(
          "News", Colors.black87),
    ),
    Tab(
      child: Components.header_3(
          "Groups",  Colors.black87),
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
      child: Obx(() => Scaffold(
          backgroundColor:
              controller.isDark.value ? Colors.grey[900] : Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
                color:
                    controller.isDark.value ? Colors.white : Colors.grey[900],
                size: 20),
            title: Components.header_2("GDSC News"),
            centerTitle: true,
            backgroundColor:
                controller.isDark.value ? Colors.grey[900] : Colors.white,
            elevation: 0,
            bottom: TabBar(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL),
              tabs: tabs,
              //controller: tabController,
              indicatorWeight: 2,
              indicator: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(40),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor:
                  controller.isDark.value ? Colors.white : Colors.black87,
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: const [
                News(),
                Announcements(),
              ],
            ),
          ))),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
