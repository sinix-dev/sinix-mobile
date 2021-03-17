import 'package:rxdart/subjects.dart';

class ThemeBloc {
  Stream<String> get theme => _themeSubject.stream;

  final _themeSubject = BehaviorSubject<String>();
  var _theme = "light";

  ThemeBloc() {
    _getTheme().then((_) {
      _themeSubject.add(_theme);
    });
  }

  Future<Null> _getTheme() async {
    _themeSubject.add(_theme);
  }

  void updateTheme(){
    _theme = _theme == "light" ? "dark" : "light";
    _themeSubject.add(_theme);
  }
}
