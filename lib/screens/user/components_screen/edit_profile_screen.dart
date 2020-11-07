import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/account/edit_profile/edit_profile_bloc.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/user/components/user_rounded_button.dart';
import 'package:prm_yuvid/screens/user/components/user_rounded_input.dart';
import 'package:prm_yuvid/screens/user/components_screen/user_screen_back_button.dart';
import 'package:prm_yuvid/themes/colors.dart';

class EditProfileParentScreen extends StatelessWidget {
  const EditProfileParentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(),
      child: EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileBloc editProfileBloc;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _biocontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editProfileBloc = BlocProvider.of<EditProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return UserScreenBackButton(
        title: "Edit profile",
        child: Container(
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
                  icon: Icons.account_box,
                  line: 1,
                  textEditingController: _namecontroller,
                ),
                UserRoundedInput(
                  hintText: "Email",
                  icon: Icons.email,
                  line: 1,
                  textEditingController: _emailcontroller,
                ),
                UserRoundedInput(
                  hintText: "Bio",
                  icon: null,
                  line: 3,
                  textEditingController: _biocontroller,
                ),
                UserRoundedButton(text: "Edit", press: edit_profile),
                BlocListener<EditProfileBloc, EditProfileState>(
                  listener: (context, state) {
                    if (state is EditProfileSuccessState) {
                      Navigator.pop(context);
                    }
                  },
                  child: BlocBuilder<EditProfileBloc, EditProfileState>(
                      builder: (context, state) {
                    if (state is EditProfileInitial) {
                      return SizedBox.shrink();
                    } else if (state is EditProfileLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is EditProfileSuccessState) {
                      return Container();
                    } else if (state is EditProfileFailedState) {
                      return Text(state.message,
                          style: TextStyle(color: Colors.red));
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                ),
              ]),
        ));
  }

  void edit_profile() {
    // print("Hello");
    AccountEditDTO dto = AccountEditDTO(
        name: this._namecontroller.text,
        email: this._emailcontroller.text,
        bio: this._biocontroller.text);
    this.editProfileBloc.add(EditProfileClickEvent(accountEditDTO: dto));
  }
}
