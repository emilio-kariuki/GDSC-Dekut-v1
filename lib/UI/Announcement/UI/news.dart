// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks, avoid_print
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Controller/app_controller.dart';
import '../../../Util/App_Constants.dart';
import '../../../Util/App_components.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final controller = Get.put(AppController());
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  //QuerySnapshot? snapshotData;
  bool isSearched = false;
  Future? resultsLoaded;
  List allResults = [];
  List resultsList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged() {
    searchResultsList();
    print(searchController.text);
  }

  searchResultsList() {
    var showResults = [];

    if (searchController != '') {
      for (var tripSnapshot in allResults) {
        if (tripSnapshot['title']
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      showResults = List.from(allResults);
    }
    setState(() {
      resultsList = showResults;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getResourcesList();
  }

  getResourcesList() async {
    var data = await FirebaseFirestore.instance
        .collection('news')
        //.where('title', isLessThanOrEqualTo: 'resource')
        .get();

    setState(() {
      allResults = data.docs;
    });
    searchResultsList();
    controller.isLoading.value = false;

    return data.docs;
  }

  final listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
        // appBar: AppBar(
        //   // leading: const Icon(Icons.home, size: 20,color: Colors.black87,),
        //   backgroundColor:
        //       controller.isDark.value ? Colors.grey[900] : Colors.white,
        //   // title: Components.header_1(
        //   //   "Resources",
        //   // ),
        //   elevation: 0,
        //   flexibleSpace: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8),
        //     child: InputField(
        //       linesCount: 1,
        //       hint: "Search for a resource",
        //       widget: InkWell(
        //         onTap: () {},
        //         child: Icon(
        //           Icons.search,
        //           color:
        //               controller.isDark.value ? Colors.white : Colors.black87,
        //           size: 18,
        //         ),
        //       ),
        //       controller: searchController,
        //     ),
        //   ),
        //   bottom: PreferredSize(
        //     preferredSize: const Size.fromHeight(10), child: Components.spacerHeight(10),

        //   ),
        // ),
        body: SafeArea(
          child: RefreshIndicator(
            displacement: 20,
            onRefresh: () async {
              await getResourcesList();
            },
            child: CustomScrollView(
              //controller: listController,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Map<String, dynamic> data =
                          resultsList[index].data() as Map<String, dynamic>;

                      return Column(
                        children: [
                          ListTile(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              String url = data['link'];
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launch(url,
                                    // forceWebView: true,
                                    // enableJavaScript: true,
                                    // enableDomStorage: true,
                                    forceSafariVC: false);
                              } else {
                                Components.showMessage("Cannot launch url");
                                throw 'Could not launch $url';
                              }
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      opaque: true,
                                      barrierDismissible: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) {
                                        return Scaffold(
                                          backgroundColor:
                                              controller.isDark.value
                                                  ? Colors.grey[900]
                                                  : Colors.white,
                                          body: SafeArea(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    icon: const Icon(
                                                        Icons.cancel_sharp),
                                                    color:
                                                        controller.isDark.value
                                                            ? Colors.white
                                                            : Colors.black87,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: InteractiveViewer(
                                                    scaleEnabled: true,
                                                    panEnabled: true,
                                                    child: Hero(
                                                      tag:
                                                          resultsList[index].id,
                                                      child: Center(
                                                        child:
                                                            CachedNetworkImage(
                                                          //height: 300,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          fit: BoxFit.fill,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                          imageUrl: data[
                                                                  'imageUrl'] ??
                                                              Constants
                                                                  .announceLogo,
                                                          // placeholder: (context, url) =>
                                                          //     const CupertinoActivityIndicator(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: resultsList[index].id,
                                  child: CachedNetworkImage(
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    imageUrl: data['imageUrl'] ??
                                        Constants.announceLogo,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            strokeWidth: 1,
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              data['title'],
                              style: TextStyle(
                                color: controller.isDark.value
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            subtitle: Text(
                                data['description'].length > 35
                                    ? data['description'].substring(0, 35) +
                                        "..."
                                    : data['description'],
                                style: TextStyle(
                                    color: controller.isDark.value
                                        ? Colors.white
                                        : Colors.black87)),
                            // trailing: Icon(
                            //   Icons.link,
                            //   size: 18,
                            //   color: controller.isDark.value
                            //       ? Colors.white
                            //       : Colors.black87,
                            // ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Components.showDividerLine(12),
                          ),
                        ],
                      );
                    },
                    childCount: resultsList.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
