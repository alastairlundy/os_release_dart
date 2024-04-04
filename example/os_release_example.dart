import 'dart:io';

import 'package:os_release/os_release.dart';

void main() {
 if(Platform.isLinux){
   var osRel = OsReleaseInfo.detect();

   print("We're running: ${osRel.name}, which is a Linux distribution. That's so cool!");
 }
}
