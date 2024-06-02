import 'package:flutter/material.dart';
import 'package:grzybek/styles.dart';

class Post {
  final String username;
  final String content;

  Post(this.username, this.content);

  // Method to convert from a map
  Post.fromMap(Map<String, String> map)
      : username = map['username']!,
        content = map['content']!;
}

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final List<Post> posts = [];
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _addPost() {
    if (_usernameController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      setState(() {
        posts.add(Post(
          _usernameController.text,
          _contentController.text,
        ));
        _usernameController.clear();
        _contentController.clear();
      });
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
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nazwa użytkownika',
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
              ),
              SizedBox(height: 5),
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

  // Method to fetch data (simulated)
  List<Post> _fetchPosts() {
    // Simulated data fetching
    List<Map<String, String>> data = [
      {'username': 'Patryk Kostecki', 'content': 'Dlaczego jestem kurwą?!'},
      {
        'username': 'Szymon Czermak',
        'content': 'Nie wiem stary może sie po prostu taki urodziłeś'
      }
    ];

    return data.map((map) => Post.fromMap(map)).toList();
  }

  @override
  void initState() {
    super.initState();
    // Fetch and set posts
    setState(() {
      posts.addAll(_fetchPosts());
    });
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
              width: 375, // Set a fixed height for the posts container
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 61, 55, 55), // Background color
                border: Border.all(
                  color: Color.fromARGB(255, 189, 165, 130).withOpacity(0.8),
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    constraints:
                        BoxConstraints(maxHeight: 80), // Limit the height
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppButtonStyles.primaryGradientStart.withOpacity(0.8),
                          AppButtonStyles.primaryGradientEnd.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color:
                            Color.fromARGB(255, 189, 165, 130).withOpacity(0.8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      // Make the content scrollable
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            posts[index].username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 229, 215, 194),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            posts[index].content,
                            style: TextStyle(
                              color: Color.fromARGB(255, 229, 215, 194),
                            ),
                          ),
                        ],
                      ),
                    ),
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
