import 'package:flutter/material.dart';
import 'package:timetrackerapp/custom_widget/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({this.snapshot, this.itemBuilder});

  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items currently. Please try again after sometime',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
        itemCount: items.length+2,
        separatorBuilder: (context, index) => Divider(height: 0.7),
        itemBuilder: (context, index) => index == 0 || index == items.length + 1
            ? Container()
            : itemBuilder(context, items[index - 1]));
  }
}
