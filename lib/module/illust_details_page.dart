import 'dart:async';
import 'dart:ui' show ImageFilter;

import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter/material.dart';
import 'package:pxnyan/http/api.dart' as Api;
import 'package:pxnyan/model/illust_details.dart';
import 'package:pxnyan/model/illustration.dart';
import 'package:pxnyan/module/gallery_page.dart';
import 'package:pxnyan/utils/utils.dart' as Utils;
import 'package:pxnyan/widget/corner_label.dart';
import 'package:pxnyan/widget/error_view.dart';
import 'package:pxnyan/widget/loading_view.dart';

class IllustDetailsPage extends StatefulWidget {
  final int _id;
  final String _illustTitle;
  final String _bgImgUrl;

  IllustDetailsPage(this._id, this._illustTitle, this._bgImgUrl);

  @override
  State<StatefulWidget> createState() => new _IllustDetailsPageState();
}

class _IllustDetailsPageState extends State<IllustDetailsPage> {
  IllustDetails _illustDetails;
  List<String> _imageUrls = <String>[];

  Future<IllustDetails> getIllustDetails() {
    return _illustDetails == null
        ? Api.fetchIllustDetails(widget._id)
        : new Future.value(_illustDetails);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new AdvancedNetworkImage(
            widget._bgImgUrl,
            header: Api.HEADER,
          ),
        ),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(widget._illustTitle),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          backgroundColor: Colors.black12,
          body: new FutureBuilder<IllustDetails>(
            future: getIllustDetails(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new LoadingView(true);
                default:
                  if (snapshot.hasData) {
                    if (snapshot.data.status == Api.SUCCESS) {
                      if (_illustDetails == null) {
                        _illustDetails = snapshot.data;
                      }
                      Illustration illustration = snapshot.data.response[0];
                      _imageUrls.clear();
                      if (illustration.isManga) {
                        _imageUrls
                            .addAll(illustration.metadata.pages.map((page) => page.imageUrls.large));
                      } else {
                        _imageUrls.add(illustration.imageUrls.large);
                      }
                      return _buildDetails(illustration);
                    } else {
                      return new ErrorView(_handleErrorClick, textColor: Colors.white);
                    }
                  } else if (snapshot.hasError) {
                    return new ErrorView(_handleErrorClick, textColor: Colors.white);
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(Illustration illustration) {
    return new ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
        new GestureDetector(
          onTap: _handleImageClick,
          child: new Card(
            elevation: 3.0,
            child: new Stack(
              children: <Widget>[
                new Image(
                  image: new AdvancedNetworkImage(
                    illustration.imageUrls.px480mw,
                    header: Api.HEADER,
                  ),
                ),
                new Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: new CornerLabel('${illustration.pageCount}'),
                ),
              ],
            ),
          ),
        ),
        new Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            elevation: 3.0,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Icon(Icons.person, color: Colors.blue, size: 20.0),
                      new Expanded(
                        child: new Container(
                          margin: const EdgeInsets.only(left: 3.0),
                          child: new Text(
                            illustration.user.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      new Icon(Icons.remove_red_eye, color: Colors.blue, size: 20.0),
                      new Container(
                        margin: const EdgeInsets.only(left: 3.0),
                        child: new Text(
                          '${Utils.getFormatNumber(illustration.stats.viewsCount)}',
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
                          '${Utils.getFormatNumber(illustration.stats.favoritedCount.public +
                              illustration.stats.favoritedCount.private)}',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    alignment: AlignmentDirectional.topStart,
                    margin: const EdgeInsets.only(top: 8.0),
                    child: new Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: _buildTags(illustration.tags),
                    ),
                  ),
                  new Container(
                    alignment: AlignmentDirectional.topStart,
                    margin: const EdgeInsets.only(top: 8.0),
                    child: new Text(illustration.caption ?? ''),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  List<Widget> _buildTags(List<String> tags) {
    return tags
        .map((tag) => new Chip(
              labelStyle: const TextStyle(color: Colors.white, fontSize: 12.0),
              backgroundColor: Colors.blue,
              label: new Text(tag),
            ))
        .toList();
  }

  void _handleErrorClick() => setState(() {});

  void _handleImageClick() {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new GalleryPage(_imageUrls),
      ),
    );
  }
}
