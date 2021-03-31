import 'package:flutter/material.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/explore_tab_model.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:gocast/utils/text_style.dart';

class ExploreTabs extends StatefulWidget {
  const ExploreTabs({
    Key key,
    this.exploreTabs,
    this.activeExploreTab = 0,
  }) : super(key: key);

  final List<ExploreTabModel> exploreTabs;
  final int activeExploreTab;

  @override
  _ExploreTabsState createState() => _ExploreTabsState();
}

class _ExploreTabsState extends State<ExploreTabs> {
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: 44,
      child: ScrollablePositionedList.builder(
        itemCount: widget.exploreTabs.length,
        itemScrollController: itemScrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final ExploreTabModel item = widget.exploreTabs[index];
          final bool isActive = item.id == widget.activeExploreTab;
          final TextStyle textStyle = isActive
              ? Theme.of(context)
                  .textTheme
                  .subtitle1
                  .bold
                  .copyWith(color: Theme.of(context).textTheme.bodyText1.color)
              : Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.75));
          return InkWell(
            key: item.globalKey,
            onTap: () {},
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                  top: kPaddingS, start: kPaddingS, end: kPaddingS),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isActive
                        ? Theme.of(context).textTheme.bodyText1.color
                        : Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
              child: StrutText(
                item.label,
                style: textStyle,
              ),
            ),
          );
        },
      ),
    );
  }
}
