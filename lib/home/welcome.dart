import 'package:flutter/material.dart';
import 'package:lal_pay/home/models/hex_color.dart';
import 'package:lal_pay/home/widgets/cards.dart';
import 'package:lal_pay/commons/lal_pay_text.dart';
import 'package:lal_pay/home/models/languages.dart';
import 'package:lal_pay/localication/application.dart';
import 'package:lal_pay/localication/app_localizations.dart';
class Welcome extends StatefulWidget{

  _WelcomeState createState()=>_WelcomeState();
}

class _WelcomeState extends State<Welcome>{
  String languageCode = '';
  List<Languages> languagesList = Languages.getLanguages();
  List<DropdownMenuItem<Languages>> _dropDownMenuList;
  Languages _selectedLanguage;
  static final List<String> localeLanguagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    localeLanguagesList[0]: languageCodesList[0],
    localeLanguagesList[1]: languageCodesList[1],
  };
  String label = localeLanguagesList[0];



  @override
  void initState() {
    _dropDownMenuList = _buildDropDownMenuItem(languagesList);
    _selectedLanguage = _dropDownMenuList[0].value;
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap["English"]));
     super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.all_inclusive,color: Colors.white,),
        title: LalPay(firstColor: 'ffffff',secondColor: 'EA001B',),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert,color: Colors.white,),
            onPressed: ()=>{},
          )
        ],
      ),
      backgroundColor: HexColor('F2F5FA'),
      body:  Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60))
              ),
            ),
            SafeArea(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(AppTranslations.of(context).text('services'),style: TextStyle(color: HexColor('23262B'),fontSize: 18),),
                        Text(AppTranslations.of(context).text('view_all'),style: TextStyle(color: HexColor('2CB54B'),fontSize: 15))
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        CrediCard(
                          color: '2CB54B',
                          title: 'Internet payment',
                          description: "Internet payment was a biggest challenge "
                              "in Ethiopia, but now thanks for LalPay it is solved."
                              "We start providing internet payments for E-commerce,"
                              "Betting sites and Online marketers.",
                          valid: 'VALID 19/12',
                        ),
                        CrediCard(color: "000068", title: "Card seller", description: 'Starting earning money by selling our Cards. We prepare a virtual card of your money',valid: "VALID 07/24",),
                      ],
                    ),
                  ),

                  SizedBox(height: 70,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: 'Welcome to ',style: TextStyle(color: HexColor('23262B'),fontSize: 30.0,fontWeight: FontWeight.bold)),
                            ]
                        ),
                      ),
                      LalPay(firstColor: '2CB54B',secondColor: 'EA001B')
                    ],
                  ),
                  SizedBox(height: 40,),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: ()=>{},
                            padding: EdgeInsets.all(10.0),
                            color: HexColor('2CB54B'),
                            textColor: Colors.white,
                            child: Container(
                              width: 250,
                              color: HexColor('2CB54B'),
                              child: Center(
                                child: Text(AppTranslations.of(context).text('sign_in'),
                                  style: TextStyle(fontSize: 18),),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                side: BorderSide(color: HexColor('2CB54B'))
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: ()=>{},
                            color: Colors.white,
                            textColor: HexColor('2CB54B'),
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              width: 250,
                              color: Colors.white,
                              child: Center(
                                child: Text(AppTranslations.of(context).text('sign_up'),
                                  style: TextStyle(fontSize: 18),),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                side: BorderSide(color: HexColor('2CB54B'))
                            ),

                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(AppTranslations.of(context).text('languages')),
                            DropdownButton(
                              hint: Text('Languages'),
                              value: _selectedLanguage,
                              items: _dropDownMenuList,
                              onChanged: onLanguageChange,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),

            )

          ],
        ),
      ),
    );
  }

  onLanguageChange(Languages selectedLanguage){
    print(selectedLanguage.name);
    setState(() {
      _selectedLanguage= selectedLanguage;
      onLocaleChange(Locale(languagesMap[selectedLanguage.name]));
    });
  }

  void onLocaleChange(Locale locale) async {
    AppTranslations.of(context).text('services');
    setState(() {
      AppTranslations.load(locale);
    });
  }

  List<DropdownMenuItem<Languages>> _buildDropDownMenuItem(List languagesList){
    List<DropdownMenuItem<Languages>> list = List();
    for(Languages lan in languagesList){
      list.add(DropdownMenuItem(value:lan,child:Text(lan.name)));
    }

    return list;
  }
}