import 'package:flutter/material.dart';

import 'package:sell_streams/domain/repositories/user_repository.dart';

import 'package:sell_streams/presentation/blocs/authentication/auth.dart';
import 'package:sell_streams/presentation/blocs/register/register.dart';

import 'package:sell_streams/presentation/journeys/widgets/app_text_field.dart';
import 'package:sell_streams/presentation/journeys/widgets/cta_button.dart';
import 'package:sell_streams/presentation/journeys/widgets/loader_widget.dart';
import 'package:sell_streams/presentation/journeys/widgets/top_banner.dart';

import 'package:sell_streams/utils/strings.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class RegisterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            final authBloc = BlocProvider.of<AuthenticationBloc>(context);

            if(state is AuthenticationStateUnAuthenticated) {
              return RegisterForm();
            }
            if (state is AuthenticationStateFailure) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(state.errorMessage),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Retry'),
                        onPressed: () {
                          authBloc.add(AppStarted());
                        },
                      )
                    ],
                  ));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final authService = RepositoryProvider.of<UserRepository>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(authBloc, authService),
        child: RegisterFormView(),
      ),
    );
  }
}


class RegisterFormView extends StatefulWidget {
  @override
  _RegisterFormViewState createState() => _RegisterFormViewState();
}

class _RegisterFormViewState extends State<RegisterFormView> {

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hasAcceptedTerms;

  double width, height;

  String isoPhone;

  @override
  void initState() {
    super.initState();
    hasAcceptedTerms = false;
  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    _onRegisterButtonPressed() {

      print(usernameController.text);
      print(emailController.text);
      print(passwordController.text);
      print(confirmPasswordController.text);
      print(isoPhone);

      Map<String, dynamic> body = {
        "username": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
        "phone": isoPhone
      };

      if(_formKey.currentState.validate()){
        BlocProvider.of<RegisterBloc>(context).add(RegisterWithEmail(body: body));
        resetInputs();
      }

    }

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state){
        print('register state listened is $state');
        if(state is RegisterStateSuccess){
          Fluttertoast.showToast(
              msg: "Sign Up Successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pushNamedAndRemoveUntil(context, landingRoute, (route) => false);
        }
        if(state is RegisterStateFailure) {
          Fluttertoast.showToast(
              msg: "There was an issue creating an account with us",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state){
          print('register state built is $state');
          if(state is RegisterStateLoading){
            return AppLoader(text: 'Signing Up...',);
          }
          return Container(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopBanner(
                    height: MediaQuery.of(context).size.height * 0.17,
                    title: registerText,
                    hasBackButton: true,
                    onBackPressed: ()=> Navigator.pop(context),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextField(
                            controller: usernameController,
                            hint: 'Enter Username Here',
                            label: 'Username',
                            isEnabled: true,
                            isPassword: false,
                            inputType: TextInputType.text,
                            onValidate: (value){
                              if(value == null || value.isEmpty){
                                return 'Username is Required';
                              }
                            },
                          ),
                          SizedBox(height: 15.0,),
                          AppTextField(
                            controller: emailController,
                            hint: 'Enter Your Email',
                            label: 'Email',
                            isEnabled: true,
                            isPassword: false,
                            inputType: TextInputType.emailAddress,
                            onValidate: (value){
                              if(value == null || value.isEmpty){
                                return 'Email is Required';
                              } else if (!value.contains('@')){
                                return 'Invalid Email';
                              }
                            },
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
                          AppTextField(
                            controller: passwordController,
                            hint: 'Enter Password',
                            label: 'Password',
                            isEnabled: true,
                            isPassword: true,
                            onValidate: (value){
                              if(value == null || value.isEmpty){
                                return 'Password is Required';
                              }
                            },
                          ),
                          SizedBox(height: 15.0,),
                          AppTextField(
                            controller: confirmPasswordController,
                            hint: 'Confirm Password',
                            label: 'Confirm Password',
                            isEnabled: true,
                            isPassword: true,
                            onValidate: (value){
                              if(value == null || value.isEmpty){
                                return 'Password is Required';
                              } else if(value != passwordController.text){
                                return 'Passwords Don\'t Match';
                              }
                            },
                          ),
                          SizedBox(height: 15.0,),
                          Row(
                            children: [
                              Checkbox(
                                value: hasAcceptedTerms,
                                onChanged: (value) {
                                  setState(()=> hasAcceptedTerms = !hasAcceptedTerms);
                                },
                                checkColor: Theme.of(context).primaryColor,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "I have agreed to ",
                                    style: TextStyle(color: Colors.black45, fontSize: 12.0),
                                    children: [
                                      TextSpan(
                                          text: 'the Terms and Conditions',
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: 15.0
                                          )
                                      )
                                    ]
                                ),
                                maxLines: 1,
                              )
                            ],
                          ),
                          CTAButton(
                            title: 'Register',
                            width: width,
                            color: Theme.of(context).primaryColorDark,
                            textColor: Colors.white,
                            isMini: false,
                            isEnabled: hasAcceptedTerms ? true : false,
                            onPressed: ()=> state is RegisterStateLoading ? (){} : _onRegisterButtonPressed(),
                          ),
                          SizedBox(height: 20.0,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }

  void resetInputs() {
    usernameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

}