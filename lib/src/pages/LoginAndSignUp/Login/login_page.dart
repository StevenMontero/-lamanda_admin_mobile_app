import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lamanda_admin/src/blocs/loginCubit/login_cubit.dart';
import 'package:lamanda_admin/src/library/language_library/easy_localization_delegate.dart';
import 'package:lamanda_admin/src/library/language_library/easy_localization_provider.dart';
import 'package:lamanda_admin/src/theme/colors.dart';
import 'package:lamanda_admin/src/widgets/textfield.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

/// Component Widget this layout UI
class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // ignore: unnecessary_statements
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.width;
    mediaQueryData.size.height;

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
        data: data,
        child: BlocProvider(
          create: (context) =>
              LoginCubit(context.repository<AuthenticationRepository>()),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status.isSubmissionFailure) {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Login Failure')),
                    );
                }
              },
              child: BodyWidget(mediaQueryData: mediaQueryData),
            ),
          ),
        ));
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
    return Container(
      /// Set Background image in layout (Click to open code)
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/dog.jpg"),
        fit: BoxFit.cover,
      )),
      child: Container(
        /// Set gradient color in image (Click to open code)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 0, 0.0),
              Color.fromRGBO(0, 0, 0, 0.3)
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),

        /// Set component layout
        child: ListView(
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
                                  top: mediaQueryData.padding.top + 10)),
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

                          /// ButtonCustomFacebook
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.0)),
                          Text(
                            AppLocalizations.of(context).tr('Administración'),
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.2,
                                fontSize: 17.0),
                          ),

                          /// TextFromField Email
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0)),
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (previous, current) =>
                                previous.email != current.email,
                            builder: (context, state) {
                              return TextFromField(
                                erroMessage: 'Email no es valido',
                                errorOccurred: state.email.invalid,
                                onChanged: (value) => context
                                    .bloc<LoginCubit>()
                                    .emailChanged(value),
                                icon: Icons.email,
                                password: false,
                                lavel: AppLocalizations.of(context).tr('email'),
                                inputType: TextInputType.emailAddress,
                              );
                            },
                          ),
                          /// TextFromField Password
                          Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (previous, current) =>
                            previous.password != current.password,
                            builder: (context, state) {
                              return TextFromField(
                                erroMessage: 'Contraseña no valida',
                                errorOccurred: state.password.invalid,
                                onChanged: (value) => context
                                .bloc<LoginCubit>()
                                .passwordChanged(value),
                                icon: Icons.vpn_key,
                                password: true,
                                lavel:
                                    AppLocalizations.of(context).tr('password'),
                                inputType: TextInputType.text,
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: mediaQueryData.padding.top + 70.0,
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
                    onPressed: () {
                      context.bloc<LoginCubit>().logInWithCredentials();
                    },
                    height: 49.0,
                    minWidth: 500.0,
                    color: ColorsApp.primaryColorBlue,
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text(
                      AppLocalizations.of(context).tr('login'),
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
    );
  }
}