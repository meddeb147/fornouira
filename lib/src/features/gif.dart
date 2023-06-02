import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import 'home_page.dart';
import 'trimmer.dart';

class GifPage extends StatefulWidget {
  @override
  _GifPageState createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  File? _file;
  VideoPlayerController? _videoController;

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    late final XFile pickedFile;

    if (kIsWeb) {
      // Web platform
      pickedFile = (await picker.pickVideo(source: ImageSource.gallery))!;
    } else if (Platform.isIOS) {
      // iOS platform
      pickedFile = (await picker.pickVideo(source: ImageSource.camera))!;
    } else {
      // Android platform
      pickedFile = (await picker.pickVideo(source: ImageSource.camera))!;
    }

    if (pickedFile != null) {
      final videoPath = pickedFile.path;
      setState(() {
        _videoController = VideoPlayerController.file(File(videoPath))
          ..initialize().then((_) {
            _videoController!.play();
          });
      });

      // Navigate to TrimmerPage after recording is done
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrimmerView(file: File(videoPath)),
        ),
      );
    } else {
      print('No video selected.');
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    late final XFile? pickedFile;

    if (kIsWeb) {
      // Web platform
      pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    } else if (Platform.isIOS) {
      // iOS platform
      pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    } else {
      // Android platform
      pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile!.path);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrimmerView(file: _file!),
        ),
      );
    } else {
      print('No video selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            Image.network(
              'https://cdn.pixabay.com/animation/2022/10/11/09/05/09-05-26-529_512.gif',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ElevatedButton(
                          onPressed: _pickVideo,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Pick Video',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ElevatedButton(
                          onPressed: _openCamera,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Record Video',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
