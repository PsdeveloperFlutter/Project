//Project is Completed Successfully with lots of Learning in this project
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Receipe App/Screen/UI component .dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Profile',
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        textTheme: TextTheme(),
      ),
      home: const UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    // Get device screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Stack(
            children: [
              //This is Responsible for the UI background of the App
              HomePage(),

              Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  CircleAvatar(
                    radius: screenWidth * 0.14,
                    backgroundImage:
                        AssetImage('assets/images/pexels-photo-1415810.jpeg'),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'John Doe',
                    style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'A passionate developer',
                    style: TextStyle(
                        fontSize: screenWidth * 0.049, color: Colors.white),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isFollowing = !isFollowing;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      backgroundColor:
                          isFollowing ? Colors.black54 : Colors.black54,
                    ),
                    child: Text(isFollowing ? 'Following' : 'Follow'),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMetricColumn('Posts', '24', screenWidth),
                      _buildMetricColumn('Followers', '150', screenWidth),
                      _buildMetricColumn('Following', '180', screenWidth),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return PostCard(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight);
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildMetricColumn(String label, String count, double screenWidth) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenWidth * 0.01),
        Text(
          label,
          style: TextStyle(
              fontSize: screenWidth * 0.04, color: Colors.yellow.shade700),
        ),
      ],
    );
  }
}

class PostCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const PostCard({required this.screenWidth, required this.screenHeight});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

  bool isLiked1 = false;
  bool isLiked2=  false;
  bool istaped = false;
  bool istaped1 = false;
  bool istaped2 = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {});
      },
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 100),
        child: Card(
          margin: EdgeInsets.symmetric(vertical: widget.screenHeight * 0.01),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.screenWidth * 0.03),
          ),
          child: Padding(
            padding: EdgeInsets.all(widget.screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: widget.screenHeight * 0.22,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(widget.screenWidth * 0.03),
                    image: const DecorationImage(
                      image:
                          AssetImage('assets/images/pexels-photo-1618269.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: widget.screenHeight * 0.01),
                Text(
                  'Post Title',
                  style: TextStyle(
                    fontSize: widget.screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: widget.screenHeight * 0.005),
                Text(
                  'This is a summary of the post content, providing a brief description.',
                  style: TextStyle(
                      fontSize: widget.screenWidth * 0.04,
                      color: Colors.grey[600]),
                ),
                SizedBox(height: widget.screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {

                        setState(() {
                          isLiked = !isLiked;
                          istaped = true;
                          // Reset the state after the animation completes
                          Future.delayed(const Duration(milliseconds: 300), () {
                            setState(() {
                              istaped = false;
                            });
                          });
                        });
                      },
                      icon: AnimatedScale(
                        scale: istaped ? 1.8 : 1.1,
                        duration: Duration(milliseconds: 300),
                        child: Icon(
                          CupertinoIcons.hand_thumbsup,
                          color: isLiked ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {

                        setState(() {
                          isLiked1 = !isLiked1;
                          istaped1 = true;

                          Future.delayed(const Duration(milliseconds: 300), () {
                            setState(() {
                              istaped1 = false;
                            });
                          });
                        });
                      },
                      icon: AnimatedScale(
                          scale: istaped1 ? 1.8 : 1.1,
                          duration: const Duration(milliseconds: 300),
                          child:  Icon(CupertinoIcons.bookmark,
                            color: isLiked1 ? Colors.blue : Colors.grey,
                          )),
                    ),
                    IconButton(
                      onPressed: () {

                        setState(() {
                          isLiked2 = !isLiked2;
                          istaped2 = true;
                          Future.delayed(const Duration(milliseconds: 300), () {
                            setState(() {
                              istaped2 = false;
                            });
                          });
                        });
                      },
                      icon: AnimatedScale(
                        duration: const Duration(milliseconds: 300),
                        scale: istaped2 ? 1.8 : 1.1,
                        child:  Icon(CupertinoIcons.share_up,
                          color: isLiked2 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
