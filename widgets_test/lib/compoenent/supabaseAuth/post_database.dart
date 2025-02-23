import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widgets_test/compoenent/supabaseAuth/Post.dart';
import 'package:widgets_test/compoenent/supabaseAuth/UserWithPost.dart';

class PostDatabase {
  final database = Supabase.instance.client.from('post');

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
    await database
        .update({'content': newContent}).eq('id', oldPost.id.toString());
  }

  //delete
  Future<void> deletePost(Post post) async {
    await database.delete().eq('id', post.id!);
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
