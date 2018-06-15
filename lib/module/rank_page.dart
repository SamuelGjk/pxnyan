import 'dart:async';
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:pxnyan/model/rank.dart';
import 'package:pxnyan/http/api.dart' as Api;
import 'package:pxnyan/module/illust_details_page.dart';
import 'package:pxnyan/module/personal_page.dart';
import 'package:pxnyan/utils/utils.dart' as Utils;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:pxnyan/widget/empty_view.dart';
import 'package:pxnyan/widget/error_view.dart';
import 'package:pxnyan/widget/loading_view.dart';
import 'package:pxnyan/widget/no_more_view.dart';

class RankPage extends StatefulWidget {
  final String _mode;

  RankPage(this._mode);

  @override
  State createState() => new _RankPageState();
}

class _RankPageState extends State<RankPage> {
  String _pageIdentifier; // 用于存储 _page 的标识符
  String _rankDataIdentifier; // 用于存储 data 的标识符

  final List<Work> data = <Work>[];

  int _page;
  bool _isLoading = false;
  bool _isNoMore = false;
  bool _isError = false;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _pageIdentifier = '${widget._mode}_pageIdentifier';
    _rankDataIdentifier = '${widget._mode}_rankDataIdentifier';

    // TabBarView 目前没有像 ViewPager 一样的缓存或预加载功能, 每次子页面都会重新加载,
    // 所以在这里获取一下存储的页面数据, 避免重新获取数据
    _page = PageStorage.of(context).readState(context, identifier: _pageIdentifier) ?? 1;
    data.addAll(
      PageStorage.of(context).readState(context, identifier: _rankDataIdentifier) ?? <Work>[],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 获取到 NestedScrollView 为子 ScrollView 添加的特殊 ScrollController
    // 如果自己为 ScrollView 添加一个新的 ScrollController 会导致
    // NestedScrollView 和 SliverAppBar 带来的自动隐藏 AppBar 失效
    _scrollController = PrimaryScrollController.of(context);
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      if (_isNoMore) {
        return new EmptyView();
      } else if (_isError) {
        return new ErrorView(_handleErrorClick);
      } else {
        loadData(true);
        return new LoadingView(_isLoading);
      }
    } else {
      return _buildRanks();
    }
  }

  Future loadData(bool clear) async {
    if (!_isNoMore && !_isLoading) {
      setState(() => _isLoading = true);
      if (clear) _page = 1;
      Future<Rank> rankFuture = Api.fetchRank(widget._mode, Utils.getYesterdayString(), _page);
      return rankFuture.then(
        (Rank rank) {
          if (rank.status == Api.SUCCESS) {
            if (rank.response[0].works.isNotEmpty) {
              if (clear) {
                data.clear();
              }
              data.addAll(rank.response[0].works);

              // 存储页面数据用于恢复
              PageStorage.of(context).writeState(context, data, identifier: _rankDataIdentifier);
            }
            if (rank.pagination.next == null) {
              _isNoMore = true;
            } else {
              _page = rank.pagination.next;
              PageStorage.of(context).writeState(context, _page, identifier: _pageIdentifier);
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

  Future<Null> _handleRefresh() async {
    await loadData(true);
    return null;
  }

  void _handleScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      loadData(false);
    }
  }

  void _handleErrorClick() {
    _isError = false;
    loadData(true);
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildRanks() {
    return new Stack(
      children: <Widget>[
        new RefreshIndicator(
          child: new StaggeredGridView.countBuilder(
            key: new PageStorageKey<String>(widget._mode),
            // 使用了 NestedScrollView 和 SliverAppBar 后, 子 ScrollView 会被添加一个系统状态栏高度的
            // topPadding, 手动干掉它
            padding: new EdgeInsets.only(top: 0.0),
            crossAxisCount: 2,
            itemCount: data.length + 1,
            staggeredTileBuilder: (int index) {
              if (index == data.length) {
                return new StaggeredTile.count(2, 0.3);
              } else {
                final WorkBean work = data[index].work;
                return new StaggeredTile.count(1, work.height / work.width);
              }
            },
            itemBuilder: (context, index) {
              if (index == data.length) {
                return _isNoMore ? new NoMoreView() : new LoadingView(_isLoading);
              } else {
                return _buildRankItem(data[index].work);
              }
            },
          ),
          onRefresh: _handleRefresh,
        ),
        new Container(
          alignment: AlignmentDirectional.bottomEnd,
          padding: const EdgeInsets.only(
            right: 16.0,
            bottom: 16.0,
          ),
          child: new FloatingActionButton(
            onPressed: _scrollToTop,
            child: new Icon(Icons.arrow_upward),
            backgroundColor: Colors.orangeAccent,
          ),
        )
      ],
    );
  }

  Widget _buildRankItem(WorkBean work) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) =>
                new IllustDetailsPage(work.id, work.title, work.imageUrls.px480mw),
          ),
        );
      },
      child: new Card(
        elevation: 3.0,
        child: new Container(
          alignment: AlignmentDirectional.bottomCenter,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              fit: BoxFit.cover,
              image: new AdvancedNetworkImage(
                work.imageUrls.px480mw,
                header: Api.HEADER,
              ),
            ),
          ),
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: new Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 8.0,
              ),
              decoration: new BoxDecoration(
                color: Colors.black12,
              ),
              child: new Row(
                children: <Widget>[
                  new Container(
                    width: 30.0,
                    height: 30.0,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) =>
                            new PersonalPage(work.user),
                          ),
                        );
                      },
                      child: new CircleAvatar(
                        backgroundImage: new AdvancedNetworkImage(
                          work.user.profileImageUrls.px50x50,
                          header: Api.HEADER,
                        ),
                      ),
                    ),
                  ),
                  // 用 Expanded 包裹一下，不然会有一个警告
                  // 具体查看官方文档 https://flutter.io/tutorials/layout/
                  new Expanded(
                    child: new Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: new Text(
                        work.user.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
