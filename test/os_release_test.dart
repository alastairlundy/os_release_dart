/*  BSD 3-Clause License

    Copyright (c) 2024, Alastair Lundy

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import 'dart:io';

import 'package:os_release/os_release.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () async {
    final LinuxOsRelease osReleaseInfo;

    if(Platform.isLinux){
      osReleaseInfo = await LinuxOsRelease.detect();

      test('First Test', () {
        assert(Platform.isLinux, true);

        // these are all non nullable and should have values.
        assert(osReleaseInfo.name.isNotEmpty);
        assert(osReleaseInfo.identifier.isNotEmpty);
        assert(osReleaseInfo.prettyName.isNotEmpty);
      });
    }
    else{
      osReleaseInfo = LinuxOsRelease(name: "Fake Linux Distro", identifier: "mostfakedistroever", prettyName: "The Fake Linux Distro", vendorName: "Fake Corporation");

      assert(osReleaseInfo.name.isNotEmpty);
      assert(osReleaseInfo.identifier.isNotEmpty);
      assert(osReleaseInfo.prettyName.isNotEmpty);

     if(osReleaseInfo.vendorName != null){
       assert(osReleaseInfo.vendorName!.isNotEmpty);
     }
    }

  });
}
