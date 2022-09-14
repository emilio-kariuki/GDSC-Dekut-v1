import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';

class AdminNews extends StatefulWidget {
  const AdminNews({Key? key}) : super(key: key);

  @override
  State<AdminNews> createState() => _AdminNewsState();
}

class _AdminNewsState extends State<AdminNews>with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Components.adminNewsListCard(context),
        ),
      ),
    );
  }


  @override

  bool get wantKeepAlive => true;
}
