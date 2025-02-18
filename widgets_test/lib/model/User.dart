class User {
  final int userId;
  final int id;
  final String title;
  final String body;

  User({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // json 데이터를 {} User 인스턴스로 바꿔주는 단계 ex) {"test" : "1"}을 -> User인스턴스에 맞게 넣어주는 함수
  // 공장처럼 돌아가는 함수....
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId:
          json['userId'] is int ? json['userId'] : int.parse(json['userId']),
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      title: json['title'],
      body: json['body'],
    );
  }

  // 이 함수가 필요한 이유는 외부에서 오는 데이터는 [{}, {}, {}] 이런 형태이므로 이걸 List<User>에 저장하기 위한 것
  // User인스턴스로 만들어주는건 fromJson 이지만 배열에 감싸서 주는 함수가 필요하기에 정의한 함수입니다 :)
  static List<User> getJsonList(List<Map<String, dynamic>> jsonData) {
    return jsonData.map((json) => User.fromJson(json)).toList();
  }
}
