import'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.only(top:55),
        color: Colors.white,
        child: Column(
          children: [
            Card(

              color: Colors.blueAccent,

              child: Container(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    IconButton(onPressed: (){}, icon: Icon(Icons.rotate_left,size:35,color: Colors.white,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.camera,size:50,color: Colors.white,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.image_outlined,size:35,color: Colors.white,)),

                  ],
                ),
              ),
            ),
            Card(

              color: Colors.blueAccent,

              child: Container(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    IconButton(onPressed: (){}, icon: Icon(Icons.rotate_left,size:35,color: Colors.white,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.camera,size:50,color: Colors.white,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.image_outlined,size:35,color: Colors.white,)),

                  ],
                ),
              ),
            )
          ],
        ),
      ) ,
    );
  }
}