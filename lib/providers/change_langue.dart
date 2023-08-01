import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeProvider extends ChangeNotifier {
  Locale _currentLocale = new Locale("fr");

  Locale get currentLocale => _currentLocale ?? Locale("fr");

    void changeLocale(String _locale, bool isCheck) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString(_locale) != '') {
      await prefs.setString('language_code', ''); 
      await prefs.setBool('isCheck', false); 
    } 

    await prefs.clear(); // on clean les prefs pour ne pas générer de conflits si une langue est déjà enregistrée
    
    this._currentLocale = new Locale(_locale);
    await prefs.setString('language_code', _locale);    
    await prefs.setBool('isCheck', isCheck);  
    notifyListeners();
  } 

    fetchLocale() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('language_code') == null) {
      _currentLocale = Locale("fr");
      return null;
    }
    _currentLocale = Locale(prefs.getString('language_code')!);

    return _currentLocale;

  }

}