// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:tatwer_task/Presentation/widgets/my_message.dart';
import 'package:tatwer_task/Presentation/widgets/robot_message.dart';
import 'package:tatwer_task/business_logic/cubit/chat_cubit.dart';
import 'package:tatwer_task/constants/strings.dart';
import 'package:tatwer_task/data/models/chat_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var first_name = "";
  var last_name = "";
  var title = "";
  List<Message> messages = [];
  List<String> choices = [];
  List<String> chosen_choices = [];
  bool apply = false;
  bool message_sent = true;

  Widget choicesWidget() {
    return Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7.h, right: 1.h, top: 1.h),
                  child: RoundCheckBox(
                    checkedColor: const Color(0xff16919B),
                    size: 25,
                    onTap: (selected) {
                      if (chosen_choices.contains(choices[0])) {
                        chosen_choices.remove(choices[0]);
                      } else {
                        chosen_choices.add(choices[0]);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(choices[0]),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7.h, right: 1.h, top: 1.h),
                  child: RoundCheckBox(
                    checkedColor: const Color(0xff16919B),
                    size: 25,
                    onTap: (selected) {
                      if (chosen_choices.contains(choices[1])) {
                        chosen_choices.remove(choices[1]);
                      } else {
                        chosen_choices.add(choices[1]);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(choices[1]),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7.h, right: 1.h, top: 1.h),
                  child: RoundCheckBox(
                    checkedColor: const Color(0xff16919B),
                    size: 25,
                    onTap: (selected) {
                      if (chosen_choices.contains(choices[2])) {
                        chosen_choices.remove(choices[2]);
                      } else {
                        chosen_choices.add(choices[2]);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(choices[2]),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7.h, right: 1.h, top: 1.h),
                  child: RoundCheckBox(
                    checkedColor: const Color(0xff16919B),
                    size: 25,
                    onTap: (selected) {
                      if (chosen_choices.contains(choices[3])) {
                        chosen_choices.remove(choices[3]);
                      } else {
                        chosen_choices.add(choices[3]);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(choices[3]),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7.h, right: 1.h, top: 1.h),
                  child: RoundCheckBox(
                    checkedColor: const Color(0xff16919B),
                    size: 25,
                    onTap: (selected) {
                      if (chosen_choices.contains(choices[4])) {
                        chosen_choices.remove(choices[4]);
                      } else {
                        chosen_choices.add(choices[4]);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(choices[4]),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(7.h, 2.h, 0, 2.h),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Say Done, Or Press Send to Apply",
                  style: TextStyle(
                      fontSize: 14, fontFamily: 'poppin', color: Colors.grey),
                ),
              ),
            )
          ],
        ));
  }

  Widget chatWidget() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return messages[index].from == mainUserID
                    ? myMessage(messages[index].message)
                    : robotMessage(messages[index].message);
              }),
          choices.isNotEmpty ? choicesWidget() : const SizedBox()
        ],
      ),
    );
  }

  Widget blocWidget() {
    bool loading = true;

    BlocProvider.of<ChatCubit>(context).generateNextMessage(0);
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      _refreshController.loadComplete();
    }

    return BlocConsumer<ChatCubit, ChatState>(listener: (context, state) {
      if (state is NoNewMessages) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              "Error Occured",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.grey,
          ),
        );
      } else if (state is NewMessageAdded) {
        loading = false;
        messages.addAll(state.messages);
      } else if (state is choicesAdded) {
        choices.addAll(state.choices);
      }
    }, builder: (context, state) {
      if (loading) {
        return const Center(
          child: CircularProgressIndicator(color: Color(0xff16919B)),
        );
      } else {
        if (state is NewMessageAdded || state is choicesAdded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 10.h,
              // ),
              Expanded(
                child: SmartRefresher(
                  scrollDirection: Axis.vertical,
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: chatWidget(),
                ),
              ),
              // choices.isNotEmpty ? choicesWidget(choices) : SizedBox(),
              const Divider(),
              bottomBar()
            ],
          );
        }
        return Container();
      }
    });
  }

  Widget bottomBar() {
    var msgController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 85.w,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.language,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: msgController,
                      // autofocus: true,
                      onChanged: (value) {
                        if (value.toString() == "done" ||
                            value.toString() == "Done") {
                          apply = true;
                        } else {
                          switch (messages.length) {
                            case 1:
                              {
                                first_name = value;
                              }
                              break;
                            case 3:
                              {
                                last_name = value;
                              }
                              break;
                            case 5:
                              {
                                title = value;
                              }
                              break;
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type Something...',
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Image(image: AssetImage('assets/images/mic.png')),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  msgController.clear();

                  if (apply) {
                    if (chosen_choices.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            "You have to choose a field at least",
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, homeScreen);
                    }
                  } else if (messages.length == 7 &&
                      chosen_choices.isNotEmpty) {
                    Navigator.pushReplacementNamed(context, homeScreen);
                  } else if (messages.length == 7 && chosen_choices.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          "You have to choose a field at least",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.grey,
                      ),
                    );
                  } else {
                    switch (messages.length) {
                      case 1:
                        {
                          if (first_name == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text(
                                  "Type your Firstname",
                                  style: TextStyle(color: Colors.black),
                                ),
                                backgroundColor: Colors.grey,
                              ),
                            );
                          } else {
                            message_sent = true;
                            BlocProvider.of<ChatCubit>(context)
                                .addmyMessage(first_name);
                          }
                        }
                        break;
                      case 3:
                        {
                          if (last_name == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text(
                                  "Type your Lastname",
                                  style: TextStyle(color: Colors.black),
                                ),
                                backgroundColor: Colors.grey,
                              ),
                            );
                          } else {
                            message_sent = true;
                            BlocProvider.of<ChatCubit>(context)
                                .addmyMessage(last_name);
                          }
                        }
                        break;
                      case 5:
                        {
                          if (title == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text(
                                  "Type your title",
                                  style: TextStyle(color: Colors.black),
                                ),
                                backgroundColor: Colors.grey,
                              ),
                            );
                          } else {
                            message_sent = true;
                            BlocProvider.of<ChatCubit>(context)
                                .addmyMessage(title);
                          }
                        }
                        break;
                    }
                    message_sent
                        ? Future.delayed(const Duration(milliseconds: 500), () {
                            switch (messages.length) {
                              case 2:
                                {
                                  BlocProvider.of<ChatCubit>(context)
                                      .generateNextMessage(messages.length,
                                          user: first_name);
                                }
                                break;
                              case 4:
                                {
                                  BlocProvider.of<ChatCubit>(context)
                                      .generateNextMessage(messages.length,
                                          user: "$first_name $last_name");
                                }
                                break;
                              case 6:
                                {
                                  BlocProvider.of<ChatCubit>(context)
                                      .generateNextMessage(
                                    messages.length,
                                  );
                                  BlocProvider.of<ChatCubit>(context)
                                      .get_choices();
                                }
                                break;
                            }
                          })
                        : null;
                  }
                  // FocusScope.of(context).unfocus();
                },
                child:
                    const Image(image: AssetImage('assets/images/send.png'))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: blocWidget());
  }
}
