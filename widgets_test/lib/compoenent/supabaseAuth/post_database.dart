import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widgets_test/compoenent/supabaseAuth/Post.dart';

class PostDatabase {
  final database = Supabase.instance.client.from('post');
  final currentUser =
      Supabase.instance.client.auth.currentUser; // 객체가 생성되면 유저 또한 있음
  //create
  Future<void> insertPost(Post newPost) async {
    try {
      await database.insert(newPost.toMap());
    } catch (e) {
      print(e);
    }
  }

  //read
  final stream =
      Supabase.instance.client.from('post').stream(primaryKey: ['id']).map(
    (data) => data.map((post) => Post.fromMap(post)).toList(),
  );
  //update
  Future<void> updatePost(Post oldPost, String newContent) async {
    final postEmail = await getEmail(oldPost.user_id);
    if (currentUser!.email == postEmail) {
      await database
          .update({'content': newContent}).eq('id', oldPost.id.toString());
    } else {
      print('다른 사람이 작성한 Todo입니다');
    }
  }

  //delete
  Future<void> deletePost(Post post) async {
    final postEmail = await getEmail(post.user_id);
    if (currentUser!.email == postEmail) {
      await database.delete().eq('id', post.id!);
    } else {
      print('다른 사람이 작성한 Todo입니다');
    }
  }

  //이메일 가져오기
  Future<String> getEmail(String userId) async {
    try {
      final response = await Supabase.instance.client
          .rpc('get_user_email', params: {'user_id': userId});
      return response as String;
    } catch (e) {
      print("이메일 가져오기 실패! : $e");
    }
    return "이메일이 없습니다";
  }
}
