import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lal_pay/home/welcome.dart';
import 'package:lal_pay/home/widgets/splash_screen.dart';
import 'package:lal_pay/home/models/mat_color.dart';
import 'package:lal_pay/localication/application.dart';
import 'package:lal_pay/localication/app_translations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Future<Null> main() async {
  runApp(new Home());
}

class Home extends StatefulWidget{
  _HomeState createState()=> _HomeState();
}

class _HomeState extends State<Home>{
  AppTranslationsDelegate _newLocaleDelegate;
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  String label = languagesList[0];

  @override
  void initState() {

    _newLocaleDelegate = AppTranslationsDelegate(newLocale: languagesMap[0]);
    application.onLocaleChanged = onLocaleChange;
    super.initState();
  }
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lal pay',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF2CB54B, color)
      ),
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [

        _newLocaleDelegate,
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      home: SplashScreen(),
    );
  }

  Widget _getData(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('categories').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return SplashScreen();
        }else{
          return Welcome();
        }
      }
    );
  }

}


