import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    MaterialApp(home: homePage(),),
  );
}

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  File? _image;
  final picker=ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile!=null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text('My first App'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    getImageFromGallery();
                  },
                  child: Text('Select image from Gallery'),),

                Text('Test'),
                Image.network('http://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),

                Padding(
                  padding: EdgeInsets.all(30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network('http://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(border: Border.all(width:5),),
                  child: Image.network('http://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                ),

                Container(
                  margin: EdgeInsets.all(20),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage('http://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                                           fit: BoxFit.fill),
                  ),
                  child: Image.network('http://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                ),

                Image.network('http://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                ),

                Padding(
                  padding: EdgeInsets.all(30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset('assets/brown-cony.gif'),
                  ),
                ),

              Image.network(
                'https://media.tenor.com/oKvq7Csi3j0AAAAj/brown-cony.gif',
                loadingBuilder: (context, child, loadingPProgress) {
                  if (loadingPProgress==null) return child;
                  return CircularProgressIndicator(
                    value: loadingPProgress.expectedTotalBytes!=null?
                    loadingPProgress.cumulativeBytesLoaded/loadingPProgress.expectedTotalBytes!:null,
                  );
                },
              ),

              Image.network(
                'https://media.tenor.com/oKvq7Csi3j0AAAAj/brown-cony.gif',
                frameBuilder: (context, child, frame, wasSyncLoaded) {
                  if (wasSyncLoaded) return child;
                  return AnimatedOpacity(
                    child: child,
                    opacity: frame==null?0:1,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeIn,
                  );
                },
              ),

              _image!=null? Image.file(_image!):Icon(Icons.icecream_outlined, size: 100,),
            ],
          ),),
      ),
    );
  }
}



