import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController todoController = TextEditingController();
  final TextEditingController editController = TextEditingController();
  final User currentUser = FirebaseAuth.instance.currentUser!;

  void lougoutMethod() async {
    await FirebaseAuth.instance.signOut();
  }

  // create
  void createTodo() {
    if (todoController.text.isNotEmpty) {
      // 고유 식별자 가져오기
      final docReference = FirebaseFirestore.instance.collection('posts').doc();

      docReference.set({
        'doc_id': docReference.id,
        'userEmail': currentUser.email,
        'content': todoController.text,
        'createdAt': Timestamp.now(),
      });

      Navigator.of(context).pop();
    }
  }

  // update
  void updateTodo(
      {required String doc_id,
      required String postEmail,
      required String editText}) {
    if (currentUser.email == postEmail) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(doc_id)
          .update({'content': editText}).then((_) {
        print("문서 업데이트 성공!");
      }).catchError((error) {
        print("문서 업데이트 실패: $error");
      });
    } else {
      print("다른 이메일의 정보는 수정 할 수 없습니다!!");
    }
    Navigator.of(context).pop();
  }

  // delete
  void deleteTodo({required String doc_id, required String userEmail}) {
    try {
      if (currentUser.email == userEmail) {
        FirebaseFirestore.instance.collection('posts').doc(doc_id).delete();
      } else {
        print("다른 이메일의 정보는 삭제 할 수 없습니다!!");
      }
    } catch (e) {
      print("문서 삭제 성공..? : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Text('TODO LIST'),
        actions: [
          IconButton(
            onPressed: lougoutMethod,
            icon: const Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('createdAt', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data!.docs[index];
                  DateTime createdAt =
                      (post['createdAt'] as Timestamp).toDate();
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
                          Text('유저의 이메일 - ${post['userEmail']}'),
                          Text(
                            post['content'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${createdAt.year} - ${createdAt.month} - ${createdAt.day}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () => deleteTodo(
                                            doc_id: post['doc_id'],
                                            userEmail: post['userEmail'],
                                          ),
                                      icon: const Icon(Icons.delete, size: 20)),
                                  IconButton(
                                    onPressed: () {
                                      editController.text = post['content'];
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Todo 수정"),
                                            content: TextField(
                                              controller: editController,
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    todoController
                                                        .clear(); // clear
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('취소')),
                                              TextButton(
                                                  onPressed: () => updateTodo(
                                                        doc_id: post['doc_id'],
                                                        postEmail:
                                                            post['userEmail'],
                                                        editText:
                                                            editController.text,
                                                      ),
                                                  child: const Text('확인')),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.edit, size: 20),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: Text("에러가 있습니다 ㅜㅜ"),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade300,
        elevation: 10,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Todo 생성"),
                  content: TextField(
                    controller: todoController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          todoController.clear(); // clear
                          Navigator.of(context).pop();
                        },
                        child: const Text('취소')),
                    TextButton(onPressed: createTodo, child: const Text('확인')),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
