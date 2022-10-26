import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tatwer_task/business_logic/cubit/experts_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tatwer_task/data/models/experts_model.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Expert> experts = [];
  List<Expert> online_experts = [];
  List<String> fav_ids = [];

  Widget Main_Widget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recommended Experts",
                style: TextStyle(
                    fontSize: 16, color: Colors.black, fontFamily: 'poppin'),
              ),
              const Text(
                "...",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              )
            ],
          ),
          SizedBox(
            height: 38.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: experts.length,
                itemBuilder: ((context, index) {
                  return Container(
                    width: 50.w,
                    child: Card(
                      // color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 20.h,
                            width: 100.w,
                            color: Colors.red,
                            child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/${experts[index].image}')),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text("(${experts[index].rating})"),
                                SizedBox(
                                  width: 26.w,
                                ),
                                fav_ids.contains(experts[index].id)
                                    ? InkWell(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                        onTap: () {
                                          BlocProvider.of<ExpertsCubit>(context)
                                              .addtofavs(
                                                  experts, experts[index].id);
                                        },
                                      )
                                    : InkWell(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.grey,
                                        ),
                                        onTap: () {
                                          BlocProvider.of<ExpertsCubit>(context)
                                              .addtofavs(
                                                  experts, experts[index].id);
                                        },
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  experts[index].name.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'poppin',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  experts[index].field.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'poppin',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Online Experts",
                style: TextStyle(
                    fontSize: 16, color: Colors.black, fontFamily: 'poppin'),
              ),
              const Text(
                "...",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              )
            ],
          ),
          SizedBox(
            height: 25.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: online_experts.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 20.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image:
                                          AssetImage('assets/images/man.jpg')),
                                  color: Colors.grey,
                                  shape: BoxShape.circle),
                            ),
                            Positioned(
                              left: 16.w,
                              top: 5.h,
                              child: Container(
                                height: 2.h,
                                width: 2.w,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          online_experts[index].name.toString(),
                          style: TextStyle(fontSize: 9),
                        )
                      ],
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  Widget blocWidget() {
    bool loading = true;

    BlocProvider.of<ExpertsCubit>(context).getExperts();
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      _refreshController.loadComplete();
    }

    return BlocBuilder<ExpertsCubit, ExpertsState>(
      builder: (context, state) {
        if (state is ExpertsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xff16919B)),
          );
        } else if (state is ExpertsAdded) {
          experts = state.experts;
          online_experts = state.online_experts;
          if (fav_ids.contains(state.id) && fav_ids != []) {
            fav_ids.remove(state.id);
          } else {
            fav_ids.add(state.id);
          }
          return Column(
            children: [
              Expanded(
                child: SmartRefresher(
                  scrollDirection: Axis.vertical,
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: Main_Widget(),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text("No Experts now"),
          );
        }
      },
    );
  }

  Widget AppbarWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Material(
            shape: new CircleBorder(),
            child: const Image(image: AssetImage('assets/images/human.png'))),
      ),
      centerTitle: true,
      title: const Image(image: AssetImage('assets/images/title_appbar.png')),
      actions: const [Image(image: AssetImage('assets/images/Search.png'))],
    );
  }

  Widget _previewWidget() {
    return Container(
      width: 60,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      // padding: const EdgeInsets.all(16),
    );
  }

  Widget _expandedWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView.builder(
          itemCount: 6,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 11.h,
                width: 8.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Image(image: AssetImage('assets/images/it.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Information Technology",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'poppin',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          const Text(
                            "23 Experts",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'poppin',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.h),
                      child: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }

  Widget bottombarWidget() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(
              'assets/images/Home.png',
            ),
          ),
          label: 'Home',
          // backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon:
              Center(child: Image(image: AssetImage('assets/images/Star.png'))),
          label: 'Home',
          // backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Image(image: AssetImage('assets/images/Wallet.png')),
          label: 'Home',
          // backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Image(image: AssetImage('assets/images/Profile.png')),
          label: 'Home',
          // backgroundColor: Colors.white,
        ),
      ],
      // currentIndex: _selectedIndex,
      // selectedItemColor: Colors.amber[800],
      // onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottombarWidget(),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0), child: AppbarWidget()),
      body: DraggableBottomSheet(
        minExtent: 10,
        useSafeArea: true,
        curve: Curves.easeIn,
        previewWidget: _previewWidget(),
        expandedWidget: _expandedWidget(),
        backgroundWidget: blocWidget(),
        duration: const Duration(milliseconds: 10),
        maxExtent: MediaQuery.of(context).size.height * 0.7,
        onDragging: (pos) {},
      ),
    );
  }
}
