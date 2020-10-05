import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinix_android/services/Storage_service.dart';

void main() {
  test('Local Storage test', () async {

    SharedPreferences.setMockInitialValues({});

    final LocalStorage localStorage = LocalStorage();

    await localStorage.init();
  
    // firstOpen will always be true in test
    expect(localStorage.firstOpen, true);

    // if it is the first time open then username will be empty string
    expect(localStorage.userName, "");
  });
}
