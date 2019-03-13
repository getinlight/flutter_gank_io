import 'package:flutter/material.dart';
import 'package:flutter_gank_io/common/localization/GankLocalizations.dart';
import 'package:flutter_gank_io/common/constant/strings.dart';
import 'package:flutter_gank_io/ui/widget/widget_category_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: AppStrings.GANK_ALL_CATEGORY_KEYS.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border(
              bottom: BorderSide(
                width: 0.2,
                color: Theme.of(context).dividerColor,
              )
            ),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: GankLocalizations.of(context).currentLocalized.gankAllCategories.map<Widget>((page) {
                return Tab(text: page);
              }).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: AppStrings.GANK_ALL_CATEGORY_KEYS.map<Widget>((String page) {
                  return GankCategoryListWidget(page);
                }).toList()
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

}
