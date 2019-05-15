import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/group/gourp_bloc.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/group_models.dart';
import 'package:flutter_mk/pages/group/add_group_page.dart';
import 'package:flutter_mk/pages/group/group_detail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GroupListWidget extends StatefulWidget {
  const GroupListWidget();

  @override
  State<StatefulWidget> createState() => GroupListState();
}

class GroupListState extends State<GroupListWidget> {
  GroupListBloc groupListBloc = GroupListBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("我的小组"),
          actions: <Widget>[
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddGroupPage();
                }));
              },
            )
          ],
        ),
        body: Container(
          child: StreamBuilder<List<Group>>(
            stream: groupListBloc.stream,
            builder: (context, AsyncSnapshot<List<Group>> snapshot) {
              if (snapshot.hasData) {
                List<Group> groups = snapshot.data;
                if (groups != null && groups.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: groups.map((group) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return GroupDetail(group.id);
                            }));
                          },
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Stack(children: <Widget>[
                                        CachedNetworkImage(
                                          imageUrl: group.image,
                                          fit: BoxFit.fitWidth,
                                          height: 100,
                                          width: double.infinity,
                                        ),
                                        buildMessageChip(group.messageCount),
                                      ]),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              group.name,
                                              style: bookNameStyle,
                                            ),
                                            Text(group.memberCount.toString())
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                } else
                  return Container();
              } else
                return SpinKitThreeBounce(
                    color: primaryColor, size: primaryTextSize);
            },
          ),
        ),
      ),
    );
  }

  Widget buildMessageChip(int messageCount) {
    if (messageCount > 0)
      return Positioned(
        right: 16,
        top: 0,
        child: Chip(
          label: Text(
            messageCount.toString(),
            style: TextStyle(color: colorWhite),
          ),
          backgroundColor: primaryColor,
        ),
      );
    else
      return Container();
  }
}
