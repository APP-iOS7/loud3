import 'package:flutter/material.dart';
import 'package:widgets_test/model/ListModel.dart';

class ListScreenPage extends StatelessWidget {
  final List<Listmodel> dataSet;
  const ListScreenPage({
    super.key,
    required this.dataSet,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: dataSet.length,
          itemBuilder: (context, index) {
            Listmodel data = dataSet[index];

            return ListTile(
              title: Text(
                data.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: data.imagePath == 'none'
                  ? const Icon(Icons.image_not_supported_outlined)
                  : const Text("이미지 잇음!!"),
              subtitle: Text(
                "${data.subTitle} / ${data.createdAt.year}년 ${data.createdAt.month}월 ${data.createdAt.day}일",
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
              ),
              trailing: const Icon(Icons.arrow_circle_right_outlined),
              onTap: () =>
                  Navigator.of(context).pushNamed(data.route.keys.first),
            );
          },
        ),
      ),
      routes: dataSet.fold<Map<String, WidgetBuilder>>({}, (prev, data) {
        prev.addAll(data.route);
        return prev;
      }),
    );
  }
}
