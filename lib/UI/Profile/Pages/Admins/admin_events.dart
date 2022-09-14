import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';


class AdminEvents extends StatefulWidget {
  const AdminEvents({Key? key}) : super(key: key);

  @override
  State<AdminEvents> createState() => _AdminEventsState();
}

class _AdminEventsState extends State<AdminEvents> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Components.adminEventListCard(context),
            )),
      ),
    );
  }

  @override

  bool get wantKeepAlive => true;
}
