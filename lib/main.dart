/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lamanda_admin/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_admin/src/blocs/productCubit/products_cubit.dart';
import 'package:lamanda_admin/src/library/language_library/easy_localization.dart';
import 'package:lamanda_admin/src/pages/home.dart';
import 'package:lamanda_admin/src/routes/routes.dart';
import 'package:lamanda_admin/src/theme/theme.dart';

//Debug Main

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'Material App', home: ListProducts());
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
    child: MyApp(
      authenticationRepository: AuthenticationRepository(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const MyApp({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    //Obliga  a la aplicacion a solo funcionar en portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    return EasyLocalizationProvider(
      data: data,
      child: RepositoryProvider.value(
        value: authenticationRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthenticationBloc(
                authenticationRepository: authenticationRepository,
              ),
            ),
            BlocProvider(
              create: (_) => new ProductsCubit(),
            ),
          ],
          child: AppView(data: data),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    Key key,
    @required this.data,
  }) : super(key: key);

  final data;

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'La Manada Admin',
      routes: getRoutesApp(),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushReplacementNamed('admin_home');
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushReplacementNamed('choseLogOSig');
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => AdminHome()),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasylocaLizationDelegate(
            locale: widget.data.locale, path: 'assets/language')
      ],
      supportedLocales: [Locale('en', 'US')],
      locale: widget.data.savedLocale,
    );
  }
}*/

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lamanda_admin/src/blocs/AuthenticationBloc/authentication_bloc.dart';
import 'package:lamanda_admin/src/blocs/productCubit/products_cubit.dart';
import 'package:lamanda_admin/src/pages/home.dart';
import 'package:lamanda_admin/src/routes/routes.dart';
import 'package:lamanda_admin/src/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const MyApp({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    //var data = EasyLocalizationProvider.of(context).data;
    //Obliga  a la aplicacion a solo funcionar en portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (_) => new ProductsCubit(),
          ),
        ],
        child: AppView(),
      ),
    );

    //EasyLocalizationProvider(
    //  data: data,
    //  child: RepositoryProvider.value(
    //    value: authenticationRepository,
    //    child: BlocProvider(
    //      create: (context) => AuthenticationBloc(
    //          authenticationRepository: authenticationRepository),
    //      child: AppView(data: data),
    //    ),
    //  ),
    //);
  }
}

class AppView extends StatefulWidget {
  const AppView({
    Key key,
    //@required this.data,
  }) : super(key: key);

  //final data;

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'La Manada petShop',
      routes: getRoutesApp(),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushReplacementNamed('admin_home');
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushReplacementNamed('admin_home');
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => AdminHome()),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        const Locale('es'),
        const Locale('en'),
      ],
    );
  }
}

//Debug Main

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'Material App', home: ListProducts());
//   }
// }
