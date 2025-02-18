import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:widgets_test/model/User.dart';
import 'package:widgets_test/service/ApiTest.dart';

// loadJson 함수에서 타입 캐스팅 과정이 복잡해 보여서 타입을 지정해서 사용하겠습니다 :)
typedef Current_JsonDecodedType = List<dynamic>;
typedef DecodedType_Casting = List<Map<String, dynamic>>;

class FutureBuilderView extends StatefulWidget {
  const FutureBuilderView({super.key});

  @override
  State<FutureBuilderView> createState() => _FutureBuilderViewState();
}

class _FutureBuilderViewState extends State<FutureBuilderView> {
  List<User> usersData = []; // json 데이터를 담을 , List 첫번째 방식
  int selectedIndex = 0; // navigation view value
  @override
  void initState() {
    super.initState();
    firstMethodLoadJson();
  }

  Future<void> firstMethodLoadJson() async {
    final String? response = await ApiTest.fetchData(); // data get 수신
    if (response != null) {
      // 만약 response가 null이 아니라면.. -> 데이터가 정상적으로 들어 왔습니다
      // data가 있으므로 data를 decode 해줍니다 -> 이렇게 하면 json 형식을 dart에 맞게 변환이 됩니다. :)
      // ****중요한점은 jsonDecode의 리턴 타입은 dynamic인 것입니다!!!!!!.****
      Current_JsonDecodedType jsonDecoded =
          jsonDecode(response); // 그러므로 타입 불일치를 일으키지 말고 타입의 무결성을 위해 타입 캐스팅을 합니다
      // 제 json 데이터의 형식은 ex) [{},{},{}]
      DecodedType_Casting jsonData =
          DecodedType_Casting.from(jsonDecoded); // 타입 캐스팅을 통해 타입 불일치를 해결하는 과정
      // User.getJsonList는 배열 형태의 data를 인스턴스( User )로 가져오기 위해 getJsonList라는 정적함수를 구현 했습니다. :)
      List<User> result = User.getJsonList(jsonData);
      usersData.addAll(result);
      // 지금 부터 data를 가져오는 방식은 제 나름대로 2가지 방식인데요
      // 첫번째는 State 객체에 담을 usersData를 초기화 해서 그 내부에 data를 담고 사용하는 방식
      // 앱이 실행되고 딱 한번 실행되며 그 data를 List<User> 에 담아서 사용하는 방식입니다. / 대신에 json 데이터를 업데이트 할려면 앱을 다시 실행해야 합니다 :(
      // 왜냐하면 initState는 한번만 앱이 실행되고 한번만 call 되니까요 :) 이런 형식은 보통 한번 가져오면 거의 변하지 않는 데이터에 사용합니다.
      // 첫밴째 방식을 위해 List<User>를 State 객체에 담아두겠습니다 :)
      setState(() {
        usersData.clear(); // 새로운 data가 있을지도 모르기 때문에 저장 전에 비워두기.
        usersData.addAll(result);
      });
      // 두번재는 loadJson 함수를 통해 데이터의 변화를 뷰에서 관장하는 FutureBuilder를 사용하는 방식
      // 이 방식은 가장 많이 쓰이는 방식으로 데이터의 update가 자주 일어나면 이건 필수입니다 :)
    }
  }

  // 두번째 방식 FutureBuilder
  Future<List<User>?> secondMethodLoadJson() async {
    final String? response = await ApiTest.fetchData(); // data get 수신
    if (response != null) {
      // 만약 response가 null이 아니라면.. -> 데이터가 정상적으로 들어 왔습니다
      // data가 있으므로 data를 decode 해줍니다 -> 이렇게 하면 json 형식을 dart에 맞게 변환이 됩니다. :)
      // ****중요한점은 jsonDecode의 리턴 타입은 dynamic인 것입니다!!!!!!.****
      Current_JsonDecodedType jsonDecoded =
          jsonDecode(response); // 그러므로 타입 불일치를 일으키지 말고 타입의 무결성을 위해 타입 캐스팅을 합니다
      // 제 json 데이터의 형식은 ex) [{},{},{}]
      DecodedType_Casting jsonData =
          DecodedType_Casting.from(jsonDecoded); // 타입 캐스팅을 통해 타입 불일치를 해결하는 과정
      // User.getJsonList는 배열 형태의 data를 인스턴스( User )로 가져오기 위해 getJsonList라는 정적함수를 구현 했습니다. :)
      List<User> result = User.getJsonList(jsonData);

      // 두번재는 loadJson 함수를 통해 데이터의 변화를 뷰에서 관장하는 FutureBuilder를 사용하는 방식
      // 이 방식은 가장 많이 쓰이는 방식으로 데이터의 update가 자주 일어나면 이건 필수입니다 :)

      return result;
    }
    // 여기로 오면 끝임...
    return null;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle contentStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int value) {
          // 선택한 뷰의 index 전환
          setState(() {
            selectedIndex = value;
          });
        },
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.one_x_mobiledata_rounded),
            label: "첫번째 방식",
          ),
          NavigationDestination(
            icon: Icon(Icons.one_x_mobiledata_rounded),
            label: "두번째 방식",
          )
        ],
      ),
      body: SafeArea(
        child: selectedIndex == 0
            ? ListView.builder(
                itemCount: usersData.length,
                itemBuilder: (BuildContext context, int index) {
                  User user = usersData[index];
                  return ListTile(
                    title: Text(
                      user.title,
                      style: contentStyle,
                    ),
                    leading: Text(
                      '${user.id}',
                      style: contentStyle,
                    ),
                    subtitle: Text(
                      user.body,
                      style: contentStyle.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  );
                },
              )
            : FutureBuilder<List<User>?>(
                future: secondMethodLoadJson(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("에러가 있어요 :( ${snapshot.error}"),
                    );
                  } else {
                    return _DeleyedFutureBuilder(
                      contentStyle: contentStyle,
                      usersData: snapshot.data, // data 주입
                    );
                  }
                },
              ),
      ),
      floatingActionButton: selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                // FutureBuilder 활용을 위해 re-rendering 코드 작성 이렇게 하면 새로운 데이터가 있다면 다시 받아올 수 있음.
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: const Icon(Icons.restart_alt_rounded),
            )
          : null,
    );
  }
}

// 2번째 FutureBuilder
class _DeleyedFutureBuilder extends StatelessWidget {
  const _DeleyedFutureBuilder({
    super.key,
    required this.contentStyle,
    required this.usersData,
  });

  final TextStyle contentStyle;
  final List<User>? usersData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        // delay를 위해 FutureBuilder에 넣어줌
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, delayedSnapshot) {
          if (delayedSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: usersData!.length,
              itemBuilder: (BuildContext context, int index) {
                User user = usersData![index];
                return ListTile(
                  title: Text(
                    user.title,
                    style: contentStyle,
                  ),
                  leading: Text(
                    '${user.id}',
                    style: contentStyle,
                  ),
                  subtitle: Text(
                    user.body,
                    style: contentStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                );
              },
            );
          }
        });
  }
}


// 회고 
// 2가지 방식을 통해 FutureBuilder에 대한 이해와 Json데이터의 모델링에 대해 연습 할 수 있습니다.
// FutureBulder에 있는 snapshot은 총 2가지. 
// 첫번째는 List<User>를 담고 있는 snapshot, 그리고 내부에는 
// FutureBuilder를 좀 더 활용해 보기 위해 일부러 deley를 준 delayedSnapshot 이 있습니다.
// 
//
// **결론** 
// 1번째 방식은 data를 한번만 받아오는 firstMethodLoadJson 방식
// 2번째 방식은 data를 여러번 update되는 Widget 즉 FutureBuilder를 통해 데이터를 다양한 상황에서 대응 가능함 (secondMethodLoadJson)