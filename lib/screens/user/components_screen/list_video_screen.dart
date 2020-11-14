import 'package:flutter/material.dart';
import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/screens/user/components/video_card.dart';

class ListVideoComponent extends StatefulWidget {
  List<VideoDTO> list;
  ListVideoComponent({Key key, this.list}) : super(key: key);

  @override
  _ListVideoComponentState createState() => _ListVideoComponentState();
}

class _ListVideoComponentState extends State<ListVideoComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: this.widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return VideoCard(videoDTO: this.widget.list[index]);
        },
      ),
    );
  }
}
