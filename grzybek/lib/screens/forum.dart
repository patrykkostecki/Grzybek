import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grzybek/styles.dart';

class Post {
  final String username;
  final String content;
  final String userId;
  final String id;

  Post(this.username, this.content, this.userId, {required this.id});

  // Metoda konwertująca z mapy
  Post.fromMap(Map<String, dynamic> map, {required this.id})
      : username = map['username'] ?? '',
        content = map['content'] ?? '',
        userId = map['userId'] ?? '';

  // Metoda konwertująca na mapę
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'content': content,
      'userId': userId,
    };
  }
}

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final List<Post> posts = [];
  final TextEditingController _contentController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addPost() async {
    User? user = _auth.currentUser;

    if (user != null && _contentController.text.isNotEmpty) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      String username = userDoc['username'] ?? 'Anonim';

      Post newPost = Post(username, _contentController.text, user.uid, id: '');
      await _firestore.collection('posts').add(newPost.toMap());
      _contentController.clear();
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showAddPostDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 61, 55, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Treść',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 229, 215, 194),
                    fontSize: 12.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 189, 165, 130),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 229, 215, 194),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: TextStyle(
                  color: Color.fromARGB(255, 229, 215, 194),
                  fontSize: 12.0,
                ),
                maxLines: 5,
              ),
              SizedBox(height: 5),
              Container(
                width: 100, // Ustaw szerokość przycisku
                height: 50, // Ustaw wysokość przycisku
                child: ElevatedButton(
                  onPressed: _addPost,
                  style: AppButtonStyles.primaryButtonStyle.copyWith(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                    ),
                  ),
                  child: AppButtonStyles.getGradientInk(
                    'Dodaj wpis',
                    borderRadius:
                        20, // Ustaw odpowiedni promień zaokrąglenia, jeśli jest potrzebny
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deletePost(String postId, String userId) async {
    User? user = _auth.currentUser;

    if (user != null && user.uid == userId) {
      await _firestore.collection('posts').doc(postId).delete();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nie masz uprawnień do usunięcia tego postu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/HomeBackground.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Container(
              height: 450,
              width: 375, // Ustaw stałą wysokość kontenera z postami
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 61, 55, 55), // Kolor tła
                border: Border.all(
                  color: Color.fromARGB(255, 189, 165, 130).withOpacity(0.8),
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: StreamBuilder(
                stream: _firestore.collection('posts').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Błąd: ${snapshot.error}'));
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var doc = docs[index];
                      Post post = Post.fromMap(
                        doc.data() as Map<String, dynamic>,
                        id: doc.id,
                      );
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        constraints:
                            BoxConstraints(maxHeight: 80), // Ogranicz wysokość
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppButtonStyles.primaryGradientStart
                                  .withOpacity(0.8),
                              AppButtonStyles.primaryGradientEnd
                                  .withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: Color.fromARGB(255, 189, 165, 130)
                                .withOpacity(0.8),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                // Spraw, by treść była przewijana
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.username,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 229, 215, 194),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      post.content,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 229, 215, 194),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _deletePost(post.id, post.userId),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200, // Ustaw szerokość przycisku
              height: 50, // Ustaw wysokość przycisku
              child: ElevatedButton(
                onPressed: _showAddPostDialog,
                style: AppButtonStyles.primaryButtonStyle.copyWith(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                  ),
                ),
                child: AppButtonStyles.getGradientInk(
                  'Napisz Post',
                  borderRadius:
                      20, // Ustaw odpowiedni promień zaokrąglenia, jeśli jest potrzebny
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
