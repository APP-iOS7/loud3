import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widgets_test/compoenent/supabaseAuth/Post.dart';
import 'package:widgets_test/compoenent/supabaseAuth/UserWithPost.dart';
import 'package:widgets_test/compoenent/supabaseAuth/post_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostDatabase database = PostDatabase();
  final TextEditingController todoText = TextEditingController();
  final TextEditingController editText = TextEditingController();
  void signOutSupabase() async {
    await Supabase.instance.client.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: const Text('TODO LIST'),
        backgroundColor: Colors.grey.shade400,
        actions: [
          IconButton(
            onPressed: signOutSupabase,
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: StreamBuilder(
          stream: database.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final Post post = snapshot.data![index]; // post
                  final email = database.getEmail(post.user_id);
                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<String>(
                              future: email,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return Text('유저의 이메일 - ${snapshot.data}');
                                }
                              }),
                          Text(
                            post.content,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () => database.deletePost(post),
                                  icon: const Icon(Icons.delete, size: 20)),
                              IconButton(
                                  onPressed: () {
                                    editText.text = post.content;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return _updateDialog(context, post);
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit, size: 20))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _createDialog(context);
            },
          );
        },
        elevation: 5,
        child: const Icon(Icons.today_rounded),
      ),
    );
  }

  AlertDialog _createDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Todo 생성"),
      content: TextField(
        controller: todoText,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            todoText.clear();
          },
          child: const Text("취소"),
        ),
        TextButton(
          onPressed: () {
            try {
              Post newPost = Post(
                content: todoText.text,
                user_id: Supabase.instance.client.auth.currentUser!.id,
              );
              database.insertPost(newPost);
              Navigator.of(context).pop();
            } catch (e) {
              print('생성 실패 : $e');
            }
          },
          child: const Text("확인"),
        ),
      ],
    );
  }

  AlertDialog _updateDialog(BuildContext context, Post oldPost) {
    return AlertDialog(
      title: const Text("Todo 수정"),
      content: TextField(
        controller: editText,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("취소"),
        ),
        TextButton(
          onPressed: () {
            try {
              database.updatePost(oldPost, editText.text);
              Navigator.of(context).pop();
            } catch (e) {
              print('생성 실패 : $e');
            }
          },
          child: const Text("확인"),
        ),
      ],
    );
  }
}
