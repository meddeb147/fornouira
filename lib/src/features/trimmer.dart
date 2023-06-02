import 'dart:io' show Directory, File, Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'gif.dart';
import 'voicetotext.dart';




class TrimmerView extends StatefulWidget {
  final File? file;

  TrimmerView({this.file});

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  late Trimmer _trimmer;
  double _startValue = 0.0;
  double _endValue = 0.0;
  bool _isPlaying = false;
  bool _progressVisibility = false;

  @override
  void initState() {
    super.initState();
    _trimmer = Trimmer();
    _loadVideo();
  }


  void _loadVideo() async {
  await _trimmer.loadVideo(videoFile: widget.file!);
  setState(() {});
}


  Future<void> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    await _trimmer.saveTrimmedVideo(
      startValue: _startValue,
      endValue: _endValue,
      onSave: (outputPath) async {
        setState(() {
          _progressVisibility = false;
        });

        if (outputPath != null) {
          print('OUTPUT PATH: $outputPath');

          if (kIsWeb) {
            // Handle web specific functionality
          } else {
            final appDir = await getExternalStorageDirectory();
            final directory = Directory('${appDir!.path}/Videos');
            await directory.create(recursive: true);
            final trimmedVideoFile = File(outputPath as String);
            final fileName = trimmedVideoFile.path.split('/').last;
            final savedVideoPath = '${directory.path}/$fileName';

            await trimmedVideoFile.copy(savedVideoPath);

            // Refresh the gallery to make the saved video visible
            if (Platform.isAndroid || Platform.isIOS) {
              await ImageGallerySaver.saveFile(savedVideoPath);
              final snackBar = SnackBar(content: Text('Video saved successfully'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.9;

    return Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF161B22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Visibility(
                  visible: _progressVisibility,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
                Expanded(
                  child: VideoViewer(trimmer: _trimmer),
                ),
                Center(
                  child: TrimViewer(
                    trimmer: _trimmer,
                    viewerHeight: 50.0,
                    viewerWidth: screenWidth,
                    maxVideoLength: const Duration(minutes: 50),
                    onChangeStart: (value) => _startValue = value,
                    onChangeEnd: (value) => _endValue = value,
                    onChangePlaybackState: (value) =>
                        setState(() => _isPlaying = value),
                  ),
                ),
                TextButton(
                  child: _isPlaying
                      ? Icon(
                    Icons.pause,
                    size: 80.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )
                      : Icon(
                    Icons.play_arrow,
                    size: 80.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () async {
                    bool playbackState = await _trimmer.videoPlaybackControl(
                      startValue: _startValue,
                      endValue: _endValue,
                    );
                    setState(() {
                      _isPlaying = playbackState;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: 10.0, bottom: 20, right: 5),
                        child: Container(
                          width: buttonWidth,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ElevatedButton(
                            onPressed: _progressVisibility
                                ? null
                                : () async {
                              await _saveVideo();
                              Get.to(MyApp());
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 255, 255, 255),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
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
