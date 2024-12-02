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
        padding: EdgeInsets.only(top:55,bottom: 15,left: 5,right: 5),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(

              color: Colors.blueAccent,

              child: Container(
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.scanner_outlined,size:25,color: Colors.white,)),
                        Text("Scan",style: TextStyle(color: Colors.white,fontSize: 12),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.document_scanner,size:25,color: Colors.black,)),
                        Text("Recognize",style: TextStyle(color: Colors.white,fontSize: 12),),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.assignment_sharp,size:25,color: Colors.white,)),
                        Text("Enhance",style: TextStyle(color: Colors.white,fontSize: 12),),

                      ],
                    ),

                  ],
                ),
              ),
            ),
           Card(
             color: Colors.black,
             child: Container(
               height: MediaQuery.of(context).size.height-300,

             ),
           )
,

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