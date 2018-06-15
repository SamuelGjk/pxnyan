import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pxnyan/model/illustration.dart';
import 'package:pxnyan/model/member_illust.dart';
import 'package:pxnyan/model/user.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:pxnyan/http/api.dart' as Api;
import 'package:pxnyan/module/illust_details_page.dart';
import 'package:pxnyan/utils/utils.dart' as Utils;
import 'package:pxnyan/widget/empty_view.dart';
import 'package:pxnyan/widget/error_view.dart';
import 'package:pxnyan/widget/loading_view.dart';
import 'package:pxnyan/widget/no_more_view.dart';

class PersonalPage extends StatelessWidget {
  final User _user;

  PersonalPage(this._user);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: new FlexibleSpaceBar(
                title: new Text(_user.name),
                background: new Container(
                  child: new Image(
                    fit: BoxFit.cover,
                    image: new AdvancedNetworkImage(
                      _user.profileImageUrls.px170x170,
                      header: Api.HEADER,
                    ),
                  ),
                  foregroundDecoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[Colors.black26, Colors.transparent],
                    ),
                  ),
                ),
              ),
              expandedHeight: 192.0,
            ),
          ];
        },
        body: new PersonalContent(_user.id),
      ),
    );
  }
}

class PersonalContent extends StatefulWidget {
  final int _id;

  PersonalContent(this._id);

  @override
  State<StatefulWidget> createState() => new PersonalContentState();
}

class PersonalContentState extends State<PersonalContent> {
  final List<Illustration> _data = <Illustration>[];
  int _illustCount = -1;

  int _page;
  bool _isLoading = false;
  bool _isNoMore = false;
  bool _isError = false;

  Future loadData(bool clear) async {
    if (!_isNoMore && !_isLoading) {
      setState(() => _isLoading = true);
      if (clear) _page = 1;
      Future<MemberIllust> rankFuture = Api.fetchMemberIllust(widget._id, _page);
      return rankFuture.then(
        (MemberIllust result) {
          if (result.status == Api.SUCCESS) {
            if (_illustCount == -1) {
              _illustCount = result.pagination.total;
            }
            if (result.response.isNotEmpty) {
              if (clear) {
                _data.clear();
              }
              _data.addAll(result.response);
            }
            if (result.pagination.next == null) {
              _isNoMore = true;
            } else {
              _page = result.pagination.next;
            }
          }
        },
        onError: (error) {
          _isError = true;
          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('没届到')));
        },
      ).whenComplete(() => setState(() => _isLoading = false));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      if (_isNoMore) {
        return new EmptyView();
      } else if (_isError) {
        return new ErrorView(_handleErrorClick);
      } else {
        loadData(true);
        return new LoadingView(_isLoading);
      }
    } else {
      return _buildIllustList();
    }
  }

  Widget _buildIllustList() {
    return new RefreshIndicator(
      child: new NotificationListener<ScrollEndNotification>(
        onNotification: _handleScrollNotification,
        child: new ListView.builder(
          padding: const EdgeInsets.only(top: 5.0),
          itemCount: _data.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: new Text(
                  '作品（$_illustCount）',
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w200,
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),
                ),
              );
            } else if (index == _data.length + 1) {
              return _isNoMore
                  ? new NoMoreView()
                  : new Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: new LoadingView(_isLoading),
                    );
            } else {
              return _buildIllustItem(_data[index - 1]);
            }
          },
        ),
      ),
      onRefresh: _handleRefresh,
    );
  }

  Widget _buildIllustItem(Illustration illust) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) =>
            new IllustDetailsPage(illust.id, illust.title, illust.imageUrls.px480mw),
          ),
        );
      },
      child: new Card(
        elevation: 3.0,
        child: new SizedBox(
          height: 100.0,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new SizedBox(
                width: 120.0,
                child: new Image(
                  fit: BoxFit.cover,
                  image: new AdvancedNetworkImage(
                    illust.imageUrls.px128x128,
                    header: Api.HEADER,
                  ),
                ),
              ),
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        illust.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      new Expanded(
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Icon(Icons.remove_red_eye, color: Colors.blue, size: 20.0),
                            new Container(
                              margin: const EdgeInsets.only(left: 3.0),
                              child: new Text(
                                '${Utils.getFormatNumber(illust.stats.viewsCount)}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ),
                            new Container(
                              margin: const EdgeInsets.only(left: 8.0),
                              child: new Icon(Icons.favorite, color: Colors.blue, size: 20.0),
                            ),
                            new Container(
                              margin: const EdgeInsets.only(left: 3.0),
                              child: new Text(
                                '${Utils.getFormatNumber(illust.stats.favoritedCount.public +
                                    illust.stats.favoritedCount.private)}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await loadData(true);
    return null;
  }

  bool _handleScrollNotification(ScrollEndNotification notification) {
    if (notification.metrics.extentAfter == 0.0) {
      loadData(false);
    }
    return false;
  }

  void _handleErrorClick() {
    _isError = false;
    loadData(true);
  }
}
