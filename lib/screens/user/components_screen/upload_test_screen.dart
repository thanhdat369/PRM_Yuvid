import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prm_yuvid/blocs/video/upload/upload_bloc.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/screens/user/components/user_rounded_button.dart';
import 'package:prm_yuvid/screens/user/components/user_rounded_input.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/user_home.dart';
import 'package:prm_yuvid/themes/colors.dart';

class UploadScreenParent extends StatelessWidget {
  const UploadScreenParent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadBloc(),
      child: UploadScreen(),
    );
  }
}

class UploadScreen extends StatefulWidget {
  UploadScreen({Key key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  UploadBloc _uploadBloc;
  File _video;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _uploadBloc = BlocProvider.of<UploadBloc>(context);
  }

  Future pickVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MainColors.kDark,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text("UPLOAD VIDEO",
                  style: TextStyle(
                      color: MainColors.kMain,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            UserRoundedInput(
              hintText: "Name",
              icon: null,
              line: 1,
              textEditingController: _namecontroller,
            ),
            UserRoundedInput(
              hintText: "Decrsiption",
              icon: null,
              line: 3,
              textEditingController: _descriptioncontroller,
            ),
            RaisedButton(
              child: Icon(Icons.add),
              onPressed: pickVideo,
            ),
            Center(
                child: Text(this._video == null
                    ? ""
                    : "Choosed: ${this._video.path.split('/').last} ")),
            UserRoundedButton(
              text: "Upload",
              press: uploadVideo,
            ),
            BlocListener<UploadBloc, UploadState>(
              listener: (context, state) {
                if (state is UploadSuccessState) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return UserHomeScreen();
                  }));
                }
              },
              child: BlocBuilder<UploadBloc, UploadState>(
                  builder: (context, state) {
                if (state is UploadInitial) {
                  return SizedBox.shrink();
                } else if (state is UploadLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UploadSuccessState) {
                  return Container();
                } else if (state is UploadFailedState) {
                  return Text("An error when upload video",
                      style: TextStyle(color: Colors.red));
                } else {
                  return SizedBox.shrink();
                }
              }),
            ),
          ],
        ));
  }

  void uploadVideo() {
    if (this._video != null && this._namecontroller.text.isNotEmpty) {
      VideoUploadDTO videoUploadDTO = VideoUploadDTO(
        src: this._video,
        authorId: MockSession.id,
        name: _namecontroller.text,
        description: _descriptioncontroller.text,
      );
      _uploadBloc.add(UploadVideoClickEvent(videoUploadDTO: videoUploadDTO));
    }
    // print(_namecontroller.text);
    // print(_descriptioncontroller.text);
    // print(this._image);
  }
}
