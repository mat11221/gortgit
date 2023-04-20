//@dart=2.1

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gort/gort_app_theme.dart';
import 'package:gort/model/element.dart';
import 'package:gort/ui/page_detail.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'page_addlist.dart';
import 'dart:io' show Platform;
import 'globals.dart' as globals;
import 'package:purchases_flutter/purchases_flutter.dart' as purchases;

class TaskPage extends StatefulWidget {
  final User user;
  const TaskPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  String directory;
  List filelist = [];

  // void showstory() {
  //   Dialogs.materialDialog(
  //       msg: '',
  //       title: "Remove all Notifications",
  //       color: Colors.white,
  //       context: context,
  //       actions: [
  //         IconsOutlineButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           text: 'No',
  //           iconData: Icons.cancel_outlined,
  //           textStyle: const TextStyle(color: Colors.grey),
  //           iconColor: Colors.grey,
  //         ),
  //         IconsOutlineButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           text: 'Yes',
  //           iconData: Icons.check,
  //           color: Colors.green,
  //           textStyle: const TextStyle(color: Colors.white),
  //           iconColor: Colors.white,
  //         ),
  //       ]);
  // // }

  // List<Color> getColorList(Color color) {
  //   if (color is MaterialColor) {
  //     return [
  //       color.shade500,
  //       color.shade600,
  //       color.shade700,
  //       color.shade800,
  //     ];
  //   } else if (color == const Color(0xff2196f3)) {
  //     return [
  //       Colors.blue.shade600,
  //       Colors.blue.shade700,
  //       Colors.blue.shade700,
  //       Colors.blue.shade800,
  //     ];
  //   } else if (color == const Color(0xffe91e63)) {
  //     return [
  //       Colors.pink.shade600,
  //       Colors.pink.shade700,
  //       Colors.pink.shade700,
  //       Colors.pink.shade800,
  //     ];
  //   } else if (color == const Color(0xff4caf50)) {
  //     return [
  //       Colors.green.shade600,
  //       Colors.green.shade700,
  //       Colors.green.shade700,
  //       Colors.green.shade800,
  //     ];
  //   } else if (color == const Color(0xffffc107)) {
  //     return [
  //       Colors.yellow.shade600,
  //       Colors.yellow.shade700,
  //       Colors.yellow.shade700,
  //       Colors.yellow.shade800,
  //     ];
  //   } else if (color == const Color(0xffff9800)) {
  //     return [
  //       Colors.orange.shade600,
  //       Colors.orange.shade700,
  //       Colors.orange.shade700,
  //       Colors.orange.shade800,
  //     ];
  //   } else if (color == const Color(0xff607d8b)) {
  //     return [
  //       Colors.blueGrey.shade600,
  //       Colors.blueGrey.shade700,
  //       Colors.blueGrey.shade700,
  //       Colors.blueGrey.shade800,
  //     ];
  //   } else {
  //     return List<Color>.filled(4, color);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GortAppTheme.background,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            // FloatingActionButton(
            //   backgroundColor: GortAppTheme.darkText,
            //   onPressed: () => _showStory(),
            //   heroTag: null,
            //   child: const Icon(
            //     Icons.remove_red_eye,
            //     color: Colors.white,
            //   ),
            // ),
            FloatingActionButton(
              backgroundColor: GortAppTheme.darkText,
              onPressed: () => _addTaskPressed(),
              heroTag: null,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          ])),
      //  FloatingActionButton(
      //     onPressed: () {
      //       _addTaskPressed();
      //       // Add your onPressed code here!
      //     },
      //     backgroundColor: GortAppTheme.darkText,
      //     child: const Icon(
      //       Icons.add,
      //       color: Colors.white,
      //     )),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              // IconButton(
                              //   onPressed: _settingsPressed,
                              //   icon: const Icon(Icons.person),
                              //   iconSize: 30,
                              // ),
                              Text(
                                'Gört!',
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: GortAppTheme.fontName,
                                    color: GortAppTheme.darkText),
                              ),
                              // const SizedBox(
                              //   width: 40,
                              // )
                              // SizedBox(
                              //   width: 40,
                              // )
                            ],
                          )),
                    ],
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              height: 600.0,
              padding: const EdgeInsets.only(bottom: 25.0),
              child: NotificationListener<OverscrollIndicatorNotification>(
                // ignore: missing_return
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                },
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(widget.user.uid)
                        .orderBy("date", descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ));
                      }
                      if (snapshot.hasData && snapshot.data.docs.isEmpty) {
                        return Center(
                            child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(top: 50.0),
                                child: Text('Gört! Means do it!',
                                    style: GortAppTheme.caption)),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, left: 70, right: 70),
                              child: Column(
                                children: const <Widget>[
                                  Text(
                                    'Gört is a project where you visualize a goal, something that you definitely will achieve',
                                    style: GortAppTheme.caption,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(
                                    top: 100.0, left: 70, right: 70),
                                child: Text(
                                  'No Gört is available',
                                  style: GortAppTheme.caption,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Press  ',
                                      style: GortAppTheme.caption,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: GortAppTheme.darkText,
                                        ),
                                        height: 34,
                                        width: 34,
                                        child: const Icon(
                                          Icons.add,
                                          size: 15,
                                          color: Colors.white,
                                        )),
                                    const Text(
                                      '  to create a new Gört',
                                      style: GortAppTheme.caption,
                                    )
                                  ],
                                )),
                          ],
                        ));
                      }
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        scrollDirection: Axis.vertical,
                        children: getExpenseItems(snapshot),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<dynamic> activities = [];
    List<int> gortActivitiyDaysDoneCount = [];
    List<int> gortActivitiyDaysCount = [];
    List<dynamic> activitiesdone = [];

    List<ElementTask> listElement = [], listElement2;
    Map<String, List<ElementTask>> userMap = {};
    List<String> docName = [];
    List<String> imageurl = [];
    List<String> cardColor = [];
    List<String> dayIndex = [];
    List<int> createdDate = [];
    List<String> documentId = [];
    List<String> currentweek = [];
    List<String> activitycount = [];
    List<dynamic> webimages = [];
    List<dynamic> webvideos = [];
    List<dynamic> actdayslist = [];
    List<dynamic> actdaysdonelist = [];
    List<bool> endDate = [];
    List<String> streak = [];
    List<String> record = [];

    List<String> freq = [];
    Map<dynamic, dynamic> dataMap = {};

    if (widget.user.uid.isNotEmpty) {
      imageurl.clear();
      docName.clear();
      cardColor.clear();
      dayIndex.clear();
      createdDate.clear();
      documentId.clear();
      activitycount.clear();
      actdayslist.clear();
      actdaysdonelist.clear();
      webimages.clear();
      currentweek.clear();
      webvideos.clear();
      globals.storyimages.clear();
      endDate.clear();
      streak.clear();
      record.clear();

      /// Hold Temporary Activity Days Count
      int activityDaysGortCount = 0;
      int activityDaysDoneGortCount = 0;
      snapshot.data.docs.map<List>((f) {
        String imgurl;
        String name;
        String color;
        String currentDayIndex;
        int created;
        String docid;
        String week;
        String actcount;
        String actdays;
        String actdaysdone;
        List<String> webimg = [];
        List<String> webvd = [];
        bool endD;
        String str;
        String rec;

        // if (snapshot.data[widget.user.user.uid + 'settings']) {
        //   FirebaseFirestore.instance
        //       .collection(widget.user.user.uid)
        //       .doc(widget.user.user.uid + 'settings')
        //       .set({
        //     'weeknumber': DateTime.now().weekOfYear.toString(),
        //     'paid': false
        //   });
        // }

        Map<String, dynamic> data = f.data() as Map<String, dynamic>;
        data.forEach((a, b) {
          /// Reset _activityDaysGortCount back to zero
          activityDaysGortCount = 0;
          activityDaysDoneGortCount = 0;
          name = f.id;
          if (b.runtimeType == bool) {
            listElement.add(ElementTask(a, b));
            freq.add("${a}freq");
          } else {
            dataMap[a] = [b];
          }
          if (b is String && a == "color") {
            color = b;
          }
          if (b is String && a == "currentDayIndex") {
            currentDayIndex = b;
          }
          if (b is int && a == "date") {
            created = b;
          }
          if (b is String && a == "documentId") {
            docid = b;
          }
          if (b is String && a == "currentweek") {
            week = b;
          }
          if (b is String && a == "imageurl") {
            imgurl = b;
          }
          if (b is String && a == "endDate") {
            if (b == "true") {
              endD = true;
            } else {
              endD = false;
            }
          }
          if (b is String && a == "streak") {
            str = b;
          }

          if (b is String && a == "record") {
            rec = b;
          }
          if (a == "activities") {
            for (var element in (data['activities'] as List)) {
              activityDaysDoneGortCount += (element['daysdone'] as List).length;
              activityDaysGortCount += (element['days'] as List).length;
              activities.add(element['days']);
              activitiesdone.add(element['daysdone']);
            }

            /// Now ad `_activityDaysGortCount` int value to `gortActivitiyDaysCount` list
            gortActivitiyDaysCount.add(activityDaysGortCount);
            gortActivitiyDaysDoneCount.add(activityDaysDoneGortCount);
          }
          if (a == "webimagelist") {
            for (var element in (data['webimagelist'] as List)) {
              webimg.add((element.toString()));
              globals.storyimages.add(element.toString());
            }
          }
          if (a == "webvideolist") {
            for (var element in (data['webvideolist'] as List)) {
              webvd.add((element.toString()));
            }
          }
        });
        listElement2 = List<ElementTask>.from(listElement);
        for (int i = 0; i < listElement2.length; i++) {
          if (listElement2.elementAt(i).isDone == false) {
            userMap[f.id] = listElement2;
            docName.add(name);
            cardColor.add(color);
            dayIndex.add(currentDayIndex);
            createdDate.add(created);
            documentId.add(docid);
            activitycount.add(actcount);
            actdayslist.add(actdays);
            actdaysdonelist.add(actdaysdone);
            webimages.add(webimg);
            webvideos.add(webvd);
            currentweek.add(week);
            imageurl.add(imgurl);
            endDate.add(endD);
            streak.add(str);
            record.add(rec);
            break;
          }
        }
        if (listElement2.isEmpty) {
          userMap[f.id] = listElement2;
          docName.add(name);
          cardColor.add(color);
          dayIndex.add(currentDayIndex);
          createdDate.add(created);
          documentId.add(docid);
          activitycount.add(actcount);
          actdayslist.add(actdays);
          actdaysdonelist.add(actdaysdone);
          webimages.add(webimg);
          webvideos.add(webvd);
          currentweek.add(week);
          imageurl.add(imgurl);
          endDate.add(endD);
          streak.add(str);
          record.add(rec);
        }
        listElement.clear();
        globals.totalgort = cardColor.length;
        return null;
      }).toList();

      // if (isSaving) {
      //   dataMap.forEach((key, value) {
      //     for (int i = 0; i < freq.length; i++) {
      //       if (key == freq[i]) {
      //         frequencies.add(int.parse(value[0]));
      //       }
      //     }
      //   });
      // }
      // isSaving = false;

      return List<Widget>.generate(userMap.length, (int index) {
        return GestureDetector(
          onTap: () {
            print(docName);
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => DetailPage(
                  user: widget.user,
                  i: index,
                  docname: docName.elementAt(index),
                  color: cardColor.elementAt(index),
                  dayindex: dayIndex.elementAt(index),
                  createdDate: createdDate.elementAt(index),
                  documentId: documentId.elementAt(index),
                  webimages: webimages.elementAt(index),
                  webvideos: webvideos.elementAt(index),
                  week: currentweek.elementAt(index),
                  gortActivitiyDaysCount:
                      gortActivitiyDaysCount.elementAt(index).toString(),
                  gortActivitiyDaysDoneCount:
                      gortActivitiyDaysDoneCount.elementAt(index).toString(),
                  endDate: endDate.elementAt(index),
                  streak: streak.elementAt(index),
                  record: record.elementAt(index),
                  allGottNames: docName,
                ),
                transitionsBuilder:
                    (_, Animation<double> animation, __, child) =>
                        ScaleTransition(
                  scale: Tween<double>(begin: 1.5, end: 1.0)
                      .animate(CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0.50, 1.00, curve: Curves.linear),
                  )),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: const Interval(0.00, 0.50, curve: Curves.linear),
                      ),
                    ),
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: Card(
            color: Color(int.parse(cardColor.elementAt(index))),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Container(
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   // Where the linear gradient begins and ends
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                // stops: const [0.3, 0.5, 0.7, 0.9],
                color: Color(
                  int.parse(cardColor.elementAt(index)),
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: GortAppTheme.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 16, right: 2),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    // Container(
                                    //   height: 48,
                                    //   width: 2,
                                    //   decoration: BoxDecoration(
                                    //     color: GortAppTheme.nearlyWhite
                                    //         .withOpacity(0.5),
                                    //     borderRadius: const BorderRadius.all(
                                    //         Radius.circular(4.0)),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        docName
                                            .elementAt(index)
                                            .replaceAll('ô', '/'),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontFamily: GortAppTheme.fontName,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          letterSpacing: 1.2,
                                          color: GortAppTheme.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 2),
                                            child: Text(
                                              endDate.elementAt(index) == true
                                                  ? dayIndex.elementAt(index)
                                                  : ' ',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontFamily:
                                                    GortAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                letterSpacing: -0.1,
                                                color: GortAppTheme.nearlyWhite,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 3),
                                                child: gortActivitiyDaysCount[
                                                            index] ==
                                                        0
                                                    ? const Text(
                                                        '0 activities this week',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              GortAppTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          letterSpacing: -0.2,
                                                          color: GortAppTheme
                                                              .nearlyWhite,
                                                        ),
                                                      )
                                                    : Text(
                                                        '${gortActivitiyDaysDoneCount[index]}/${gortActivitiyDaysCount[index]} activities this week',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              GortAppTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          letterSpacing: -0.2,
                                                          color: GortAppTheme
                                                              .nearlyWhite,
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Column(
                              children: [
                                CircularPercentIndicator(
                                    radius: 40.0,
                                    animation: true,
                                    animationDuration: 1200,
                                    lineWidth: 10.0,
                                    percent: int.parse(
                                                record.elementAt(index)) <
                                            int.parse(streak.elementAt(index))
                                        ? 1
                                        : (int.parse(streak.elementAt(index)) /
                                            (int.parse(
                                                record.elementAt(index)))),
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          streak.elementAt(index),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26.0),
                                        ),
                                        const Text(
                                          "Streak",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.0),
                                        ),
                                      ],
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: const Color.fromARGB(
                                        255, 228, 228, 228),
                                    progressColor:
                                        const Color.fromARGB(255, 241, 76, 76)),
                                // Stack(
                                //   alignment: Alignment.center,
                                //   children: [
                                //     Column(
                                //       crossAxisAlignment: CrossAxisAlignment.center,
                                //       children: [
                                //         // CircleAvatar(
                                //         //     radius: 42,
                                //         //     backgroundColor: GortAppTheme.darkText,
                                //         //     child: ClipOval(
                                //         //       child: SizedBox(
                                //         //         width: 80.0,
                                //         //         height: 80.0,
                                //         //         child: (imageurl.elementAt(index) !=
                                //         //                 null)
                                //         //             ? Image.network(
                                //         //                 imageurl.elementAt(index),
                                //         //                 fit: BoxFit.fill,
                                //         //               )
                                //         //             : Image.asset(
                                //         //                 "assets/placeholder.png",
                                //         //                 fit: BoxFit.fill,
                                //         //               ),
                                //         //       ),
                                //         //     )),
                                //       ],
                                //     ),
                                //     Padding(
                                //         padding:
                                //             const EdgeInsets.only(top: 0, right: 90),
                                //         child: (webimages.elementAt(index) != null)
                                //             ? CircleAvatar(
                                //                 backgroundColor: Colors.black54,
                                //                 child: IconButton(
                                //                   icon: const Icon(
                                //                     Icons.remove_red_eye,
                                //                     color: Colors.white,
                                //                   ),
                                //                   onPressed: () {
                                //                     showDefaultPopup(
                                //                         webimages.elementAt(index));
                                //                   },
                                //                 ),
                                //               )
                                //             :  const SizedBox.shrink())
                                //   ],
                                // ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  int.parse(record.elementAt(index)) >
                                          int.parse(streak.elementAt(index))
                                      ? 'Record: ${record.elementAt(index)}'
                                      : 'Record: ${streak.elementAt(index)}',
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  )
                ],
              ),
            ),
          ),
        );
      });
    }
    return <Widget>[];
  }

  showDefaultPopup(List<String> img) {
    PopupBanner(
      context: context,
      images: img,
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
    ).show();
  }

  int countElements(List<dynamic> list) {
    int count = 0;
    for (var element in list) {
      if (element is List) {
        count += countElements(element);
      } else {
        count++;
      }
    }
    return count;
  }

  Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  // void _listofImagesM() async {
  //   print('object');
  //   directory = (await getApplicationDocumentsDirectory()).path;
  //   setState(() {
  //     final mediaFiles = io.Directory('$directory/')
  //         .listSync()
  //         .whereType<File>()
  //         .where((file) => file.path.split('/').last.startsWith('imageM'));
  //     Iterable<File> files = mediaFiles.whereType<File>();
  //     for (final file in files) {
  //       _imageFileListM.add(file);
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    initPlatformState();

    // purchases.Purchases.addCustomerInfoUpdateListener((customerInfo) async {
    //   var isPro = customerInfo.entitlements.all['premium_1m'].isActive;
    //   if (isPro) {
    //     setState(() {
    //       globals.payd = true;
    //     });
    //     // Unlock that great "pro" content
    //   }
    //   if (customerInfo == null) {
    //   } else {
    //     setState(() {
    //       globals.payd = false;
    //     });
    //   }
    // });
    // _listofImagesM();
    // FirebaseFirestore.instance
    //     .collection(widget.user.user.uid)
    //     .doc('${widget.user.user.uid}settings')
    //     .get()
    //     .then((onValue) {
    //   setState(() {
    //     if (onValue.exists) {
    //       if (onValue['weeknumber'] == DateTime.now().weekOfYear.toString()) {
    //         print(onValue['weeknumber']);
    //       } else {
    //         Dialogs.materialDialog(
    //           color: Colors.white,
    //           msg: 'Grattis, du klarade 2/5 aktiviteter',
    //           title: 'Ny vecka',
    //           lottieBuilder: Lottie.asset(
    //             'assets/cong_example.json',
    //             fit: BoxFit.contain,
    //           ),
    //           context: context,
    //           actions: [
    //             ElevatedButton(
    //               onPressed: () {
    //                 FirebaseFirestore.instance
    //                     .collection(widget.user.user.uid)
    //                     .doc('${widget.user.user.uid}settings')
    //                     .set({
    //                   'weeknumber': DateTime.now().weekOfYear.toString(),
    //                   'paid': false
    //                 });
    //                 Navigator.of(context).pop();
    //               },
    //               child: const Text('Fortsätt'),
    //             ),
    //           ],
    //         );
    //       }
    //     } else {
    //       FirebaseFirestore.instance
    //           .collection(widget.user.user.uid)
    //           .doc('${widget.user.user.uid}settings')
    //           .set({
    //         'weeknumber': DateTime.now().weekOfYear.toString(),
    //         'paid': false
    //       });
    //     }
    //   });
    // });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  changePayment() {
    FirebaseFirestore.instance
        .collection('PayedUsers')
        .doc(widget.user.uid)
        .set({"payd": true});
    globals.payd = true;
  }

  // void _settingsPressed() async {
  //   Navigator.of(context).push(
  //     PageRouteBuilder(
  //       pageBuilder: (_, __, ___) => SettingsPage(
  //         user: widget.user,
  //       ),
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) =>
  //           ScaleTransition(
  //         scale: Tween<double>(
  //           begin: 1.5,
  //           end: 1.0,
  //         ).animate(
  //           CurvedAnimation(
  //             parent: animation,
  //             curve: const Interval(
  //               0.50,
  //               1.00,
  //               curve: Curves.linear,
  //             ),
  //           ),
  //         ),
  //         child: ScaleTransition(
  //           scale: Tween<double>(
  //             begin: 0.0,
  //             end: 1.0,
  //           ).animate(
  //             CurvedAnimation(
  //               parent: animation,
  //               curve: const Interval(
  //                 0.00,
  //                 0.50,
  //                 curve: Curves.linear,
  //               ),
  //             ),
  //           ),
  //           child: child,
  //         ),
  //       ),
  //     ),
  //   );
  //   //Navigator.of(context).pushNamed('/new');
  // }

  Future<void> initPlatformState() async {
    await purchases.Purchases.setDebugLogsEnabled(true);

    purchases.PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          purchases.PurchasesConfiguration('goog_IwHHndgVDAefoxrcalgTksZmSqF');
      // if (buildingForAmazon) {
      //   // use your preferred way to determine if this build is for Amazon store
      //   // checkout our MagicWeather sample for a suggestion
      //   configuration = AmazonConfiguration(<public_amazon_sdk_key>);
      // }
    } else if (Platform.isIOS) {
      configuration =
          purchases.PurchasesConfiguration('appl_JcMoSccethXXDUouIeXgIgGvQOh');
    }
    await purchases.Purchases.configure(configuration);
  }

  void _addTaskPressed() async {
    CustomerInfo customerInfo = await purchases.Purchases.getCustomerInfo();
    if (customerInfo.entitlements.all['premium_1m'] != null &&
        customerInfo.entitlements.all['premium_1m'].isActive == true) {
      if (!mounted) return;
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => NewTaskPage(
            user: widget.user,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 1.5,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(
                  0.50,
                  1.00,
                  curve: Curves.linear,
                ),
              ),
            ),
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(
                    0.00,
                    0.50,
                    curve: Curves.linear,
                  ),
                ),
              ),
              child: child,
            ),
          ),
        ),
      );
      //Navigator.of(context).pushNamed('/new');
    } else if (globals.totalgort > 0) {
      if (!mounted) return;
      showGeneralDialog(
          context: context,
          barrierColor: GortAppTheme.background,
          barrierDismissible: false,
          barrierLabel: 'Dialog',
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) {
            return Scaffold(
                body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.close,
                          size: 40.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'GET PREMIUM',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: GortAppTheme.darkText,
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Remove ads',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Unlimited Görts',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Icon(
                  Icons.payment_rounded,
                  size: 100,
                  color: GortAppTheme.darkText,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '19kr/Månad',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 40),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            purchases.CustomerInfo customerInfo =
                                await purchases.Purchases.purchaseProduct(
                                    'premium_1m');
                            var isPro = customerInfo
                                .entitlements.all['premium_1m'].isActive;
                            if (isPro) {
                              if (!mounted) return;
                              Navigator.of(context).pop();
                              // Unlock that great "pro" content
                            }
                          } on PlatformException catch (e) {
                            var errorCode =
                                purchases.PurchasesErrorHelper.getErrorCode(e);
                            if (errorCode !=
                                purchases.PurchasesErrorCode
                                    .purchaseCancelledError) {}
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GortAppTheme.darkText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 15.0,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Subscribe',
                            style: TextStyle(
                                fontSize: 20, color: GortAppTheme.nearlyWhite),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            ));
          });
    } else {
      if (!mounted) return;
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => NewTaskPage(
            user: widget.user,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 1.5,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(
                  0.50,
                  1.00,
                  curve: Curves.linear,
                ),
              ),
            ),
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(
                    0.00,
                    0.50,
                    curve: Curves.linear,
                  ),
                ),
              ),
              child: child,
            ),
          ),
        ),
      );
    }
  }
}
