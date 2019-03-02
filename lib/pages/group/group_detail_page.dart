import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/group/gourp_bloc.dart';
import 'package:flutter_mk/models/group_models.dart';

class GroupDetail extends StatefulWidget {
  final String id;

  GroupDetail(this.id);

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  GroupDetailBlocFactory blocFactory = GroupDetailBlocFactory();

  @override
  Widget build(BuildContext context) {
    var bloc = blocFactory.bloc(widget.id);
    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, AsyncSnapshot<Group> snapshot) {
          if (snapshot.hasData) {
            var group = snapshot.data;
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
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
                          filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.0)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 56,
                        child: CachedNetworkImage(
                          imageUrl: group.image,
                          width: 100,
                          height: 100,
                        ),
                      )
                    ]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 1000,
                    color: Colors.white,
                  ),
                )
              ],
            );
          } else
            return Container();
        });
  }
}
