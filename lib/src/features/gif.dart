import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'home_page.dart';



class GifPage extends StatefulWidget {
  @override
  _GifPageState createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  CameraController? _cameraController;
  late Future<void> _initializeCameraControllerFuture;
  bool _isRecording = false;
  File? _file;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    _initializeCameraControllerFuture = _cameraController!.initialize();
  }
Future<void> _recordVideo() async {
  if (!_isRecording) {
    try {
      final appDir = await getTemporaryDirectory();
      final videoPath = '${appDir.path}/recorded_video.mp4';

      await _initializeCameraControllerFuture;

      await _cameraController!.startVideoRecording();
      setState(() {
        _isRecording = true;
      });

      await Future.delayed(Duration(seconds: 10)); // Change the duration as needed

      await _cameraController!.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });

      _file = File(videoPath);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrimmerView(file: _file!),
        ),
      );
    } catch (e) {
      print('Error recording video: $e');
    }
  }
}


  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
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
                          onPressed: () async {
                            final file = await ImagePicker()
                                .pickVideo(source: ImageSource.gallery);
                            if (file != null) {
                              setState(() {
                                _file = File(file.path);
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TrimmerView(file: _file!),
                                ),
                              );
                            }
                          },
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
                          onPressed: () async {
                            await _recordVideo();
                          },
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