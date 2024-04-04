import 'dart:core';
import 'dart:io';


/// A class to more easily store and work with Linux os-release files.
final class OsReleaseInfo {

  final bool? isLongTermSupportRelease;

  final String? version;
  final String? versionId;
  final String? versionCodename;

  final String? cpeName;
  final String? variant;
  final String? variantId;
  final String? buildId;
  final String? imageId;
  final String? imageVersion;

  final List<String>? identifierLike;

  final String? vendorUrl;
  final String? vendorName;

  final String? logo;
  final DateTime? supportEnd;
  final String? ansiColor;

  final String? homeUrl;
  final String? supportUrl;
  final String? bugReportUrl;
  final String? privacyPolicyUrl;
  final String? documentationUrl;

  final String? defaultHostname;
  final String? architecture;
  final String? sysExtLevel;
  final String? confextLevel;
  final String? sysExtScope;
  final String? confextScope;
  final String? portablePrefixes;

  final String name;
  final String identifier;
  final String prettyName;


  OsReleaseInfo(
      {required this.name, this.version, this.versionId, this.cpeName, this.variant, this.variantId, this.buildId,
        this.imageId, this.imageVersion, required this.identifier, this.identifierLike, required this.prettyName,
        this.versionCodename, this.homeUrl, this.supportUrl, this.bugReportUrl, this.privacyPolicyUrl, this.documentationUrl,
        this.vendorName, this.vendorUrl, this.isLongTermSupportRelease, this.supportEnd, this.logo, this.ansiColor, this.defaultHostname,
        this.architecture, this.confextLevel, this.confextScope, this.sysExtLevel, this.sysExtScope, this.portablePrefixes});

  /// Detects the os-release info from the file system if running on Linux.
  /// Throws an exception if running on a non Linux platform.
  static OsReleaseInfo detect() {
    if (Platform.isLinux) {
      // Provide initial default values.
      bool isLongTermSupportRelease = false;
      String name = "";
      String? version;
      String identifier = "";
      String? cpeName;

      String? variant;
      String? variantId;

      String? buildId;
      String? imageId;
      String? imageVersion;

      String? vendorUrl;
      String? vendorName;

      String? logo;
      DateTime? supportEnd;
      String? ansiColor;

      List<String> identifierLike = List.empty(growable: true);
      String prettyName = "";

      String? versionId;
      String? versionCodename;

      String? homeUrl;
      String? supportUrl;
      String? bugReportUrl;
      String? privacyPolicyUrl;
      String? documentationUrl;

      String? defaultHostname;
      String? architecture;
      String? sysExtLevel;
      String? confextLevel;
      String? sysExtScope;
      String? confextScope;
      String? portablePrefixes;

      File file;

      try {
        file = File("/etc/os-release");
      }
      catch (e) {
        file = File("/usr/lib/os-release");
      }

      List<String> lines = file.readAsLinesSync();

      List<String> delimiters = List.of({'  ', '\t', '\n', '\r', '"'});

      for (int index = 0; index < lines.length; index++) {
        String currentLine = lines[index];

        for (String delimiter in delimiters) {
          if (lines.iterator.current.toLowerCase().contains(delimiter)) {
            currentLine = currentLine.replaceAll(delimiter, "");
          }
        }

        if (currentLine.toUpperCase().contains("NAME")) {
          if (currentLine.toUpperCase().contains("PRETTY")) {
            prettyName = currentLine.replaceFirst("PRETTY_NAME=", "");
          }
          if (currentLine.toUpperCase().contains("CODE")) {
            versionCodename = currentLine.replaceFirst("CODE_NAME=", "");
          }
          if (currentLine.toUpperCase().contains("CPE")) {
            cpeName = currentLine.replaceFirst("CPE_NAME", "");
          }
          if (currentLine.toUpperCase().contains("NAME")) {
            vendorName = currentLine.replaceFirst("VENDOR_NAME=", "");
          }
          if (currentLine.toUpperCase().contains("HOSTNAME")) {
            defaultHostname = currentLine.replaceFirst("DEFAULT_HOSTNAME", "");
          }

          if (!currentLine.toUpperCase().contains("PRETTY") &&
              !currentLine.toUpperCase().contains("CODE") &&
              !currentLine.toUpperCase().contains("CPE") &&
              !currentLine.toUpperCase().contains("VENDOR") &&
              !currentLine.toUpperCase().contains("HOSTNAME")) {
            name = currentLine.replaceFirst("NAME=", "");
          }
        }

        if (currentLine.toUpperCase().contains("EXT")) {
          if (currentLine.toUpperCase().contains("SYSEXT_LEVEL")) {
            sysExtLevel = currentLine.replaceFirst("SYSEXT_LEVEL=", "");
          }
          else if (currentLine.toUpperCase().contains("SYSEXT_SCOPE")) {
            sysExtScope = currentLine.replaceFirst("SYSEXT_SCOPE=", "");
          }

          if (currentLine.toUpperCase().contains("CONFEXT_LEVEL")) {
            confextLevel = currentLine.replaceFirst("CONFEXT_LEVEL=", "");
          }
          else if (currentLine.toUpperCase().contains("CONFEXT_SCOPE")) {
            confextScope = currentLine.replaceFirst("CONFEXT_SCOPE=", "");
          }
        }

        if (currentLine.toUpperCase().contains("PORTABLE")) {
          portablePrefixes = currentLine.replaceFirst("PORTABLE_PREFIXES=", "");
        }

        if (currentLine.toUpperCase().contains("ARCHITECTURE")) {
          architecture = currentLine.replaceFirst("ARCHITECTURE=", "");
        }

        if (currentLine.toUpperCase().contains("ID")) {
          if (currentLine.toUpperCase().contains("VERSION")) {
            versionId = currentLine.replaceFirst("VERSION_ID=", "");
          }
          if (currentLine.toUpperCase().contains("LIKE")) {
            identifierLike =
                currentLine.replaceFirst("ID_LIKE=", "").split(" ");
          }
          if (currentLine.toUpperCase().contains("VARIANT")) {
            variantId = currentLine.replaceFirst("VARIANT_ID=", "");
          }
          if (currentLine.toUpperCase().contains("BUILD")) {
            buildId = currentLine.replaceFirst("BUILD_ID=", "");
          }
          if (currentLine.toUpperCase().contains("IMAGE")) {
            imageId = currentLine.replaceFirst("IMAGE_ID=", "");
          }

          if (!currentLine.toUpperCase().contains("VERSION") &&
              !currentLine.toUpperCase().contains("LIKE") &&
              !currentLine.toUpperCase().contains("VARIANT") &&
              !currentLine.toUpperCase().contains("BUILD") &&
              !currentLine.toUpperCase().contains("IMAGE")) {
            identifier = currentLine.replaceFirst("ID=", "");
          }
        }
        else if (currentLine.toUpperCase().contains("VARIANT") &&
            !currentLine.toUpperCase().contains("ID")) {
          variant = currentLine.replaceFirst("VARIANT=", "");
        }

        if (currentLine.toUpperCase().contains("IMAGE") &&
            !currentLine.toUpperCase().contains("VERSION")) {
          imageVersion = currentLine.replaceFirst("IMAGE_VERSION=", "");
        }

        if (currentLine.toUpperCase().contains("LOGO")) {
          logo = currentLine.replaceFirst("LOGO=", "");
        }
        if (currentLine.toUpperCase().contains("SUPPORT_END")) {
          List<String> dateSplit = currentLine.replaceFirst("SUPPORT_END=", "")
              .split("-");

          supportEnd = DateTime(
              int.parse(dateSplit[0]), int.parse(dateSplit[1]),
              int.parse(dateSplit[2]));
        }

        if (currentLine.toUpperCase().contains("VERSION") &&
            !currentLine.toUpperCase().contains("ID=")) {
          if (currentLine.toUpperCase().contains("LTS")) {
            isLongTermSupportRelease = true;
          }
          else {
            isLongTermSupportRelease = false;
          }

          version = currentLine.replaceFirst("VERSION=", "");
        }

        if (currentLine.toUpperCase().contains("URL")) {
          if (currentLine.toUpperCase().contains("HOME_")) {
            homeUrl = currentLine.replaceFirst("HOME_URL=", "");
          }
          else if (currentLine.toUpperCase().contains("SUPPORT_")) {
            supportUrl = currentLine.replaceFirst("SUPPORT_URL=", "");
          }
          else if (currentLine.toUpperCase().contains("BUG_REPORT_")) {
            bugReportUrl = currentLine.replaceFirst("BUG_REPORT_URL=", "");
          }
          else if (currentLine.toUpperCase().contains("PRIVACY_")) {
            privacyPolicyUrl =
                currentLine.replaceFirst("PRIVACY_POLICY_URL=", "");
          }
          else if (currentLine.toUpperCase().contains("DOCUMENTATION")) {
            documentationUrl =
                currentLine.replaceFirst("DOCUMENTATION_URL=", "");
          }
          else if (currentLine.toUpperCase().contains("VENDOR_URL")) {
            vendorUrl = currentLine.replaceFirst("VENDOR_URL=", "");
          }
        }
      }

      return OsReleaseInfo(name: name,
          version: version,
          identifier: identifier,
          identifierLike: identifierLike,
          prettyName: prettyName,
          versionCodename: versionCodename,
          versionId: versionId,
          homeUrl: homeUrl,
          supportUrl: supportUrl,
          bugReportUrl: bugReportUrl,
          privacyPolicyUrl: privacyPolicyUrl,
          isLongTermSupportRelease: isLongTermSupportRelease,
          documentationUrl: documentationUrl,
          logo: logo,
          ansiColor: ansiColor,
          vendorUrl: vendorUrl,
          vendorName: vendorName,
          supportEnd: supportEnd,
          cpeName: cpeName,
          variant: variant,
          variantId: variantId,
          buildId: buildId,
          imageId: imageId,
          imageVersion: imageVersion,
          defaultHostname: defaultHostname,
          portablePrefixes: portablePrefixes,
          confextLevel: confextLevel,
          confextScope: confextScope,
          architecture: architecture,
          sysExtLevel: sysExtLevel,
          sysExtScope: sysExtScope);
    }
    else {
      throw Exception("Detection attempted on a non-supported non-linux platform that is ${Platform.operatingSystem}.");
    }
  }
}