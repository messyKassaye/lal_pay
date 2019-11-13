import 'package:flutter/material.dart';
import 'package:lal_pay/home/models/languages.dart';
class DropDownMenu extends StatefulWidget{

  _DropDownMenuState createState()=>_DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu>{

  List<Languages> languagesList = Languages.getLanguages();
  List<DropdownMenuItem<Languages>> _dropDownMenuList;
  Languages _selectedLanguage;

  @override
  void initState() {
    // TODO: implement initState
    _dropDownMenuList = _buildDropDownMenuItem(languagesList);
    _selectedLanguage = _dropDownMenuList[0].value;
    super.initState();
  }

  onLanguageChange(Languages selectedLanguage){
    setState(() {
      _selectedLanguage=selectedLanguage;
    });
  }

  List<DropdownMenuItem<Languages>> _buildDropDownMenuItem(List languagesList){
    List<DropdownMenuItem<Languages>> list;
    for(Languages lan in languagesList){
      list.add(DropdownMenuItem(value:lan,child:Text(lan.name)));
    }

    return list;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton(
      value: _selectedLanguage,
      items: _dropDownMenuList,
      onChanged: onLanguageChange,
    );
  }
}