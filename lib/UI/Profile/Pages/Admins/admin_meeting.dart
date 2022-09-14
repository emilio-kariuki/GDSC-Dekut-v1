import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';


class AdminMeeting extends StatefulWidget {
  const AdminMeeting({Key? key}) : super(key: key);

  @override
  State<AdminMeeting> createState() => _AdminMeetingState();
}

class _AdminMeetingState extends State<AdminMeeting>with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Components.adminMeetingListCard(context),
            )),
      ),
    );
  }

  @override

  bool get wantKeepAlive =>true;
}
