import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamanda_admin/src/blocs/signupCubit/sign_up_cubit.dart';
import 'package:lamanda_admin/src/library/language_library/easy_localization_delegate.dart';
import 'package:lamanda_admin/src/library/language_library/easy_localization_provider.dart';
import 'package:lamanda_admin/src/pages/LoginAndSignUp/Login/login_page.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/widgets/textfield.dart';
import 'package:formz/formz.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  //Animation Declaration

  AnimationController animationControllerScreen;
  Animation animationScreen;

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // ignore: unnecessary_statements
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: BlocProvider<SignUpCubit>(
        create: (context) =>
            SignUpCubit(context.repository<AuthenticationRepository>()),
        child: Scaffold(
          body: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state.status.isSubmissionFailure) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text( '${state.message}'),
                  ));
              }
            },
            child: BodyWidget(mediaQueryData: mediaQueryData),
          ),
        ),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key key,
    @required this.mediaQueryData,
  }) : super(key: key);

  final MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          /// Set Background image in layout
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/dog.jpg"),
            fit: BoxFit.cover,
          )),
          child: Container(
            /// Set gradient color in image
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.2),
                  Color.fromRGBO(0, 0, 0, 0.3)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),

            /// Set component layout
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.topCenter,
                          child: Column(
                            children: <Widget>[
                              /// padding logo
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: mediaQueryData.padding.top + 10.0)),
                              Center(
                                /// Animation text treva shop accept from splashscreen layout (Click to open code)
                                child: Hero(
                                  tag: "Treva",
                                  child: Container(
                                    height: mediaQueryData.size.height * 0.2,
                                    width: mediaQueryData.size.width * 0.55,
                                    child: SvgPicture.asset(
                                      'assets/images/Logo_COLOR.svg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              /// TextFromField Number User name
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 20.0)),

                              BlocBuilder<SignUpCubit, SignUpState>(
                                buildWhen: (previous, current) =>
                                    previous.userName != current.userName,
                                builder: (context, state) {
                                  return TextFromField(
                                    errorOccurred: state.userName.invalid,
                                    erroMessage: "No puede contener espacios ni símbolos",
                                    icon: Icons.account_circle,
                                    password: false,
                                    lavel: AppLocalizations.of(context)
                                        .tr('User Name'),
                                    inputType: TextInputType.text,
                                    onChanged: (value) => context
                                        .bloc<SignUpCubit>()
                                        .userNameChanged(value),
                                  );
                                },
                              ),

                              /// TextFromField Number Phone
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0)),

                              BlocBuilder<SignUpCubit, SignUpState>(
                                buildWhen: (previous, current) =>
                                    previous.phone != current.phone,
                                builder: (context, state) {
                                  return TextFromField(
                                    errorOccurred: state.phone.invalid,
                                    erroMessage:
                                        'Número de telefono no valido',
                                    icon: Icons.phone_iphone,
                                    password: false,
                                    lavel: AppLocalizations.of(context)
                                        .tr('Number Phone'),
                                    inputType: TextInputType.number,
                                    onChanged: (value) => context
                                        .bloc<SignUpCubit>()
                                        .phoneChanged(value),
                                  );
                                },
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0)),

                              /// TextFromField Email
                              BlocBuilder<SignUpCubit, SignUpState>(
                                buildWhen: (previous, current) =>
                                    previous.email != current.email,
                                builder: (context, state) {
                                  return TextFromField(
                                    errorOccurred: state.email.invalid,
                                    erroMessage: 'El email no es valido',
                                    icon: Icons.email,
                                    password: false,
                                    lavel: AppLocalizations.of(context)
                                        .tr('Email'),
                                    inputType: TextInputType.emailAddress,
                                    onChanged: (value) => context
                                        .bloc<SignUpCubit>()
                                        .emailChanged(value),
                                  );
                                },
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0)),

                              /// TextFromField Password
                              BlocBuilder<SignUpCubit, SignUpState>(
                                buildWhen: (previous, current) =>
                                    previous.password != current.password,
                                builder: (context, state) {
                                  return TextFromField(
                                    errorOccurred: state.password.invalid,
                                    erroMessage: 'La contraseña debe contener al menos 6 dígitos',
                                    icon: Icons.vpn_key,
                                    password: true,
                                    lavel: AppLocalizations.of(context)
                                        .tr('Password'),
                                    inputType: TextInputType.text,
                                    onChanged: (value) => context
                                        .bloc<SignUpCubit>()
                                        .passwordChanged(value),
                                  );
                                },
                              ),

                              /// Button Login
                              FlatButton(
                                  padding: EdgeInsets.only(top: 20.0),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new LoginScreen()));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .tr('notHaveLogin'),
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: mediaQueryData.padding.top + 45.0,
                                    bottom: 0.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10),
                      child: MaterialButton(
                        onPressed: () => context.bloc<SignUpCubit>().signUpFormSubmitted(),                                                                          
                        minWidth: mediaQueryData.size.width * 0.85,
                        height: mediaQueryData.size.height * 0.065,
                        color: ColorsApp.primaryColorBlue,
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          AppLocalizations.of(context).tr('signUp'),
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.2,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
