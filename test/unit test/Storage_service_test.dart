import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinix_android/services/Storage_service.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});

  final LocalStorage localStorage = LocalStorage();
  await localStorage.init();

  test('Local Storage test', () async {
    // firstOpen will always be true in test
    expect(localStorage.firstOpen, true);

    // if it is the first time open then username will be empty string
    expect(localStorage.userName, "");
  });

  test("LocalStorage's saveCoordinate test", () async {
    await localStorage.init();

    final defaultCoordinate = localStorage.defaultCoordinate;

    // for first time opening all the coordinates
    // of the controller will be the default one.
    expect(localStorage.joypadCoordinate, defaultCoordinate);
    expect(localStorage.rightpadCoordinate, defaultCoordinate);

    Offset testCoordinate = Offset(60.0, 74.0);

    await localStorage.saveCoordinates(testCoordinate, testCoordinate, testCoordinate);

    localStorage.getCoordinates();

    expect(localStorage.joypadCoordinate,
        [testCoordinate.dx.toString(), testCoordinate.dy.toString()]);

    expect(localStorage.rightpadCoordinate,
        [testCoordinate.dx.toString(), testCoordinate.dy.toString()]);
  });
}
