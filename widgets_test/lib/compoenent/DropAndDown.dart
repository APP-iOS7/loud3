import 'package:flutter/material.dart';

class DropAndDownScreen extends StatefulWidget {
  const DropAndDownScreen({super.key});

  @override
  State<DropAndDownScreen> createState() => _DropAndDownScreenState();
}

class _DropAndDownScreenState extends State<DropAndDownScreen> {
  List<String> initList = [
    "1번",
    "2번",
    "3번",
    "4번",
    "5번",
    "6번",
    "7번",
    "8번",
    "9번",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: ReorderableListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                key: Key('$index'),
                tileColor: index % 2 == 0
                    ? Colors.greenAccent
                    : Colors.lightGreenAccent,
                title: Text(initList[index]),
              );
            },
            itemCount: initList.length,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                print('oldIndex : $oldIndex');
                String tile = initList.removeAt(oldIndex);
                print('removeAt after list : $initList');
                print('newIndex : $newIndex');
                initList.insert(newIndex, tile);
              });
            },
          ),
        ),
      ),
    );
  }
}


// 회고 ReorderableListView은 드랍 앤 다운을 위해 하나의 함수를 제공합니다
// onRecoder: (int oldIndex, int newIndex) {}
// oldIndex는 내가 처음에 누른 Tile의 index이고 newIndex는 내가 내려놓은 위치의 index를 반환함
// 그러그모 removeAt함수로 배열에서 해당 값을 지워주고 return 값을 변수에 저장
// 저장한 변수를 원하는 위치에 넣기 위해 insert(원하는 위치 index , 변수) 를 통해 잘 되는 줄 알았는데 
// 기능이 완벽하지 않음.
// 위로는 잘 되었지만 아래로 가는 게 잘 안됨 
// 이유는 newIndex가 내가 지정한 index보다 (플마 1) 되어 있었음  그러므로 조건 식을 통해 -= 1 을 해주면 해결.
