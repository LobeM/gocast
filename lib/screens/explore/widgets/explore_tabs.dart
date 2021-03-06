import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gocast/blocs/explore/explore_bloc.dart';
import 'package:gocast/configs/constants.dart';
import 'package:gocast/data/models/top_tab_model.dart';
import 'package:gocast/widgets/strut_text.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:gocast/utils/text_style.dart';

class ExploreTabs extends StatefulWidget {
  const ExploreTabs({
    Key key,
    this.exploreTabs,
    this.activeExploreTab = 0,
  }) : super(key: key);

  final List<TopTabModel> exploreTabs;
  final int activeExploreTab;

  @override
  ExploreTabsState createState() => ExploreTabsState();
}

class ExploreTabsState extends State<ExploreTabs> {
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
          final TopTabModel item = widget.exploreTabs[index];
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
            onTap: () => BlocProvider.of<ExploreBloc>(context)
                .add(CategoryFilteredExploreEvent(activeExploreTab: item.id)),
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
