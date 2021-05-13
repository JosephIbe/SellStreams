import 'package:flutter/material.dart';

import 'package:sell_streams/domain/repositories/user_repository.dart';

import 'package:sell_streams/presentation/blocs/authentication/auth.dart';
import 'package:sell_streams/presentation/blocs/login/login.dart';

import 'package:sell_streams/presentation/journeys/widgets/app_text_field.dart';
import 'package:sell_streams/presentation/journeys/widgets/cta_button.dart';
import 'package:sell_streams/presentation/journeys/widgets/loader_widget.dart';
import 'package:sell_streams/presentation/journeys/widgets/top_banner.dart';

import 'package:sell_streams/utils/constants.dart';
import 'package:sell_streams/utils/strings.dart';

import '../landing.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {

              final authBloc = BlocProvider.of<AuthenticationBloc>(context);

              print(state);

              if(state is AuthenticationStateAuthenticated) {
                return Landing();
              }

              if (state is AuthenticationStateUnAuthenticated) {
                return LoginForm();
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
              return LoginForm();
            },
          )),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final authService = RepositoryProvider.of<UserRepository>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
        child: LoginFormView(),
      ),
    );
  }
}

class LoginFormView extends StatefulWidget {
  @override
  __LoginFormViewState createState() => __LoginFormViewState();
}

class __LoginFormViewState extends State<LoginFormView> {

  final  _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _autoValidate = false;

  double width, height;

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      Map<String, dynamic> body = {
        "email": emailController.text,
        "password": passwordController.text
      };
      if(_formKey.currentState.validate()){
        _loginBloc.add(LoginWithEmail(body: body));
        resetInputs();
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print('login state listened is $state');
        if(state is LoginStateSuccess){
          Fluttertoast.showToast(
              msg: "Login Successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.pushNamedAndRemoveUntil(context, landingRoute, (route) => false);
        }
        if(state is LoginStateFailure) {
          Fluttertoast.showToast(
              msg: "There was an issue verifying your account with us",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          print('login state built is $state');
          if (state is LoginStateLoading) {
            return AppLoader(text: 'Logging In...',);
          }
          return Container(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopBanner(
                    height: MediaQuery.of(context).size.height * 0.16,
                    title: loginText,
                    hasBackButton: false,
                    onBackPressed: null,
                  ),
                  SizedBox(height: 30.0,),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextField(
                            controller: emailController,
                            hint: 'Email Address',
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
                          AppTextField(
                            controller: passwordController,
                            hint: 'Enter Password',
                            label: 'Password',
                            isPassword: true,
                            isEnabled: true,
                            onValidate: (value){
                              if(value == null || value.isEmpty){
                                return 'Password is Required';
                              }
                            },
                          ),
                          SizedBox(height: 40.0,),
                          CTAButton(
                            title: 'Login',
                            width: width,
                            isEnabled: true,
                            color: Theme.of(context).primaryColorDark,
                            textColor: Colors.white,
                            isMini: false,
                            onPressed: ()=> state is LoginStateLoading ? (){} : _onLoginButtonPressed(),
                          ),
                          SizedBox(height: 30.0,),
                          GestureDetector(
                            onTap: ()=> Navigator.pushNamed(context, registerRoute),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                registerText, style: kAuthOptionsTextStyle,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  resetInputs(){
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

}