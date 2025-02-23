import 'package:supabase_flutter/supabase_flutter.dart';

class Post {
  int? id;
  String content;
  String user_id;
  Post({
    this.id,
    required this.content,
    required this.user_id,
  });

  factory Post.fromMap(Map<String, dynamic> mapData) {
    return Post(
      id: mapData['id'] as int,
      content: mapData['content'] as String,
      user_id: mapData['user_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'content': content, 'user_id': user_id};
  }
}
