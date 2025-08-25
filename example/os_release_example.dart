import 'dart:io';

import 'package:os_release/os_release.dart';

Future<void> main() async {
 if(Platform.isLinux){
   var osRel = await LinuxOsRelease.detect();

   print("We're running: ${osRel.name}, which is a Linux distribution. That's so cool!");
 }
}
