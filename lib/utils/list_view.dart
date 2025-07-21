import 'package:flutter/material.dart';

ListView listView<T>(
  Iterable<T> items,
  Widget itemBuilder(T item),
) {
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, i) => itemBuilder(items.elementAt(i)),
  );
}
