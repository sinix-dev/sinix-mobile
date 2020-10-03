import 'package:flutter_test/flutter_test.dart';
import 'package:sinix_android/utils/store.dart';

void main() {
  test("Store's saveUserName() test", () async {
    final store = Store();

    await store.init();

    final testMatcher = "TestSubject";

    // putting the username in persistent storage
    await store.saveUserName(testMatcher);

    // gettting the username in persistent storage
    final savedUserName = store.localStorage.prefs.getString('userName');

    expect(savedUserName, testMatcher);
  });
}
