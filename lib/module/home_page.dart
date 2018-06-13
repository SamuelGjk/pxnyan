import 'package:flutter/material.dart';
import 'package:pxnyan/module/rank_page.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<_Mode> _modes = const <_Mode>[
    const _Mode('daily', '日榜'),
    const _Mode('weekly', '周榜'),
    const _Mode('monthly', '月榜'),
    const _Mode('rookie', '新人'),
    const _Mode('original', '原创'),
    const _Mode('male', '男性向'),
    const _Mode('female', '女性向'),
  ];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _modes.length,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                floating: true,
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                title: new Text('PxNyan'),
                bottom: new TabBar(
                  isScrollable: true,
                  tabs: _buildTabs(),
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: _buildRankPages(),
          ),
        ),
      ),
    );
  }

  List<Tab> _buildTabs() {
    final tabs = <Tab>[];
    _modes.forEach((mode) => tabs.add(new Tab(text: mode.cn)));
    return tabs;
  }

  List<Widget> _buildRankPages() {
    final pages = <Widget>[];
    _modes.forEach((mode) => pages.add(new RankPage(PageStorageKey<String>(mode.en), mode.en)));
    return pages;
  }
}

class _Mode extends Object {
  final String en;
  final String cn;

  const _Mode(this.en, this.cn);
}
