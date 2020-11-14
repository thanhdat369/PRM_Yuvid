import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prm_yuvid/blocs/account/search_account/search_account_bloc.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/shared/my_circleavt.dart';
import 'package:prm_yuvid/screens/user/components/list_user_component.dart';
import 'package:prm_yuvid/screens/user/components/user_rounded_input.dart';
import 'package:prm_yuvid/themes/colors.dart';

class SearchAccountScreenParent extends StatelessWidget {
  const SearchAccountScreenParent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchAccountBloc(),
      child: SearchAccountScreen(),
    );
  }
}

class SearchAccountScreen extends StatefulWidget {
  SearchAccountScreen({Key key}) : super(key: key);

  @override
  _SearchAccountScreenState createState() => _SearchAccountScreenState();
}

class _SearchAccountScreenState extends State<SearchAccountScreen> {
  SearchAccountBloc _searchAccountBloc;
  TextEditingController _namecontroller = TextEditingController();
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _searchAccountBloc = BlocProvider.of<SearchAccountBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: MainColors.kDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserRoundedInput(
                  hintText: "Name",
                  width: size.width * 0.5,
                  icon: null,
                  line: 1,
                  textEditingController: _namecontroller,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: RaisedButton(
                    color: MainColors.kSoftDark,
                    child: Icon(
                      Icons.search,
                      color: MainColors.kLight,
                    ),
                    onPressed: _searchClick,
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<SearchAccountBloc, SearchAccountState>(
                  builder: (context, state) {
                if (state is SearchAccountInitial) {
                  return SizedBox.shrink();
                } else if (state is SearchAccountLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchAccountSuccessState) {
                  return ListAccountComponent(list_user: state.list_dto);
                } else if (state is SearchAccountFailedState) {
                  return Text("An error when Search Account",
                      style: TextStyle(color: Colors.red));
                } else {
                  return SizedBox.shrink();
                }
              }),
            ),
          ],
        ));
  }

  Widget buildingListAccount(List<AccountDTO> list) {
    if (list.isEmpty) {
      return Center(child: Text("No account matching"));
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return accountItem(list[index]);
      },
    );
  }

  Widget accountItem(AccountDTO dto) {
    return Row(
      children: <Widget>[
        MyCircleAvatar(
          imgPath: dto.avatarSrc,
          userID: dto.id,
          radius: 20,
        ),
        Column(
          children: <Widget>[
            Text(
                "Username: " + dto.username == null
                    ? "No username"
                    : dto.username,
                style: TextStyle(fontSize: 16)),
            Text("Name: " + dto.name == null ? "No Name" : dto.name,
                style: TextStyle(fontSize: 16)),
          ],
        )
      ],
    );
  }

  void _searchClick() {
    if (this._namecontroller.text.trim().isNotEmpty) {
      this._searchAccountBloc.add(
          SearchAccountClickEvent(searchStr: this._namecontroller.text.trim()));
    }
  }
}
