// 실시간으로 데이터를 가져올 때 user와 post의 관계에서
// post에 user_id를 넣어줘서 innse join을 할려고 했더니 직접적인 inner join을 supabase가 허락하지 않음...
// 그러므로 postgresql에서 지원하는 가상의 View를 만들어서 stream을 지원한다는 것을 알아냄..
// 그리하여 view의 select 데이터를 담아줄 객페를 만듭니다 :)

class UserWithPost {
  int? id;
  String content;
  String email;

  UserWithPost({
    this.id,
    required this.content,
    required this.email,
  });

  factory UserWithPost.fromMap(Map<String, dynamic> map) {
    return UserWithPost(
      id: map['id'] as int,
      content: map['content'] as String,
      email: map['email'] as String,
    );
  }
}



// 회고..
// 가상의 View로 Post가 업데이트 되면 가상의 View도 업데이트는 되느만 
// realTime을 지원 안하기 때문에 stream에서 값이 변하지 않음 futureBuilder를 사용하는 경우애 좋아보였다.
// 가상의 View를 만드는게 아닌 Function을 만들어서 stream 값의 변화를 grc로 가져와서 
//FutureBuilder하면 realTime과 Post 사용자의 이메일 을 가져올 수 있음