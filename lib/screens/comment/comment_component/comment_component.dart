import 'package:flutter/material.dart';
import 'package:prm_yuvid/models/commentDTO.dart';
import 'package:prm_yuvid/screens/login_signup/components/my_circleavt.dart';
import 'package:prm_yuvid/themes/colors.dart';

class CommentListComponent extends StatefulWidget {
  List<CommentReadDTO> list;
  CommentListComponent({Key key, this.list}) : super(key: key);

  @override
  _CommentListComponentState createState() => _CommentListComponentState();
}

class _CommentListComponentState extends State<CommentListComponent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (BuildContext context, int index) {
              return CommentItem(dto: this.widget.list[index],size: 100,);
             },
            ),
          )
        ],
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  CommentReadDTO dto;
  double size;
  CommentItem({Key key, this.size=20, this.dto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(60, 0, 20, 0),
            height: size,
            width: size,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: MainColors.kLight),
              borderRadius: BorderRadius.all(Radius.circular(70)),
            ),
            child: MyCircleAvatar(
              radius: 70,
              imgPath:
                  dto.authorAvatarSrc==null? "asset/images/user_screen/noavt.jpg":dto.authorAvatarSrc,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    //this.title.toUpperCase(),
                    this.dto.authorName??"",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    this.dto.content??"",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  this.dto.createdAt,
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//       child: UserScreenBackButton(
//       title: "VIDEO NAME",
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.only(bottom: 100),
//               children: <Widget>[
//                 ItemExercise(),
//                  ItemExercise(
//                     title: "Name User",
//                     imagePath: "asset/images/background/mans.jpg",
//                     des: "The http package provides the simplest way to fetch data from the internet.",
//                     timePost: "7 giờ",
//                 ),

//                 ],
//             ),
//           )
//         ],
//       ),
//     )
//     );
