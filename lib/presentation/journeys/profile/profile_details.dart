import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sell_streams/data/core/api_constants.dart';
import 'package:sell_streams/data/models/user_model.dart';
import 'package:sell_streams/presentation/blocs/user/user.dart';
import 'package:sell_streams/presentation/journeys/widgets/app_text_field.dart';
import 'package:sell_streams/presentation/journeys/widgets/loader_widget.dart';
import 'package:sell_streams/utils/constants.dart';

class EditProfileDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state){
            print('user state listening is:\t$state');
            if(state is UserStateLoading){
              return AppLoader(text: 'Loading Profile Data',);
            }
            if(state is UserStateSuccess){
              print(state.user);
              return EditProfileDetailsFormPage(user: state.user);
            }
            if(state is UserStateFailure){}
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state){
              print('user state building is:\t$state');
              if(state is UserStateSuccess){
                print(state.user);
                return EditProfileDetailsFormPage(user: state.user);
              }
              return AppLoader(text: 'Loading Profile Data',);
            },
          ),
        ),
      ),
    );
  }

}

class EditProfileDetailsFormPage extends StatefulWidget {

  final UserModel user;
  EditProfileDetailsFormPage({@required this.user});

  @override
  _EditProfileDetailsFormPageState createState() => _EditProfileDetailsFormPageState();
}

class _EditProfileDetailsFormPageState extends State<EditProfileDetailsFormPage> {

  double height, width;
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  String isoPhone;

  var storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.user.username;
    emailController.text = widget.user.email;
    phoneController.text = widget.user.phone;
  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    print(widget.user);

    return Container(
      width: width,
      height: height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.2,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              width: width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0, 0.5, 0.75],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF24cdd8),
                        Color(0xFF24a4ef), Color(0xFF24cdd8),],
                      tileMode: TileMode.clamp)),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    top: 10.0,
                    left: -25.0,
                    child: IconButton(
                      icon: Icon(Icons.chevron_left, color: Colors.white, size: 50.0,),
                      onPressed: ()=> Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    child: Text('Edit My Account', style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 22.0
                        )
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                          hint: 'Your Username',
                          label: 'Username',
                          inputType: TextInputType.text,
                          controller: usernameController,
                          isEnabled: true,
                          isPassword: false,
                          onValidate: (value){}
                      ),
                      SizedBox(height: 15.0,),
                      AppTextField(
                          hint: 'Your Email Address',
                          label: 'Email',
                          inputType: TextInputType.emailAddress,
                          controller: emailController,
                          isEnabled: true,
                          isPassword: false,
                          onValidate: (value){}
                      ),
                      SizedBox(height: 15.0,),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          border: Border.all(color: Colors.black, width: 1.0),
                        ),
                        child: IntlPhoneField(
                          controller: phoneController,
                          enabled: true,
                          textInputAction: TextInputAction.next,
                          initialCountryCode: 'NG',
                          onChanged: (phone) {
                            setState(()=> isoPhone = phone.completeNumber);
                          },
                          onCountryChanged: (phone) {},
                          validator: (value){
                            if(value.isEmpty || value.length < 5){
                              return 'Invalid Phone Number';
                            }
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            counter: Container(),
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.lato(textStyle: TextStyle(color: Colors.purple, fontSize: 20.0)),
                          ),
                          style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.purple, fontSize: 20.0)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      SizedBox(height: 35.0,),
                      RaisedButton(
                        onPressed: () async {
                          String userId = await storage.read(key: APIConstants.USER_ID_KEY);
                          print('userId in editprofilepage is\t$userId');
                          if(userId != null){}
                        },
                        elevation: 2.0,
                        padding: EdgeInsets.symmetric(horizontal: 115.0, vertical: 15.0),
                        color: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        child: Text('Save Bio', style: kCTAButtonTextStyle.copyWith(color: Colors.white),),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

}