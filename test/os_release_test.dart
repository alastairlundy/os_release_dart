import 'dart:io';

import 'package:os_release/os_release.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final OsReleaseInfo osReleaseInfo;

    if(Platform.isLinux){
      osReleaseInfo = OsReleaseInfo.detect();

      test('First Test', () {
        ch

        expect(osReleaseInfo.name, );
      });
    }

  });
}
