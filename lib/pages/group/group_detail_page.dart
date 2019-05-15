import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/group/gourp_bloc.dart';
import 'package:flutter_mk/models/group_models.dart';
import 'package:flutter_mk/pages/group/add_post.dart';
import 'package:flutter_mk/views/group/group_detail_widget.dart';

class GroupDetail extends StatefulWidget {
  final String id;

  GroupDetail(this.id);

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  GroupDetailBlocFactory blocFactory = GroupDetailBlocFactory();

  ScrollController _scrollController;

  bool showTitle = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = blocFactory.bloc(widget.id);
    _scrollController.addListener(() {
      this.setState(() {
        showTitle = _scrollController.offset > 156;
      });
    });
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, AsyncSnapshot<Group> snapshot) {
          if (snapshot.hasData) {
            var group = snapshot.data;

            return Stack(children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text(showTitle ? group.name : ""),
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.share),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.details),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.person),
                      )
                    ],
                    pinned: true,
                    expandedHeight: 230,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(group.image),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.0)),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 56,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: group.image,
                                width: 100,
                                height: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      group.name,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      group.remark,
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 8, right: 8),
                      child: GroupDetailWidget(widget.id),
                    ),
                  )),
                ],
              ),
              Positioned(
                bottom: 48,
                right: 24,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return NewPostPage(groupId: widget.id);
                    }));
                  },
                  child: Icon(Icons.add_a_photo),
                ),
              )
            ]);
          } else
            return Container(
              color: Colors.white,
            );
        });
  }
}
