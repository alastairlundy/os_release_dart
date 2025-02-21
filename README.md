# os_release
Reads the os-release file on Linux Distributions and makes accessing the contents of the file easy.

If your dart or flutter app needs to know the name of the installed Linux Distribution, the version that is installed, or whether it's based on a major distribution such as Arch or Debian - this is the package for you.

**Note**: This package is in the pre-release stage. Use it with caution and please [file any bug reports or potential issues you see.](https://github.com/alastairlundy/os_release/issues/)

## Compatibility

This detection code in this package is only intended to be used on Linux based operating systems, however you may use the package and ``OsRelease`` class in cross-platform Dart or Flutter projects provided that you only run the detection method and other ``OsRelease`` static methods on a Linux based operating system.
You can use the ``Platform.isLinux`` field from the `dart:io` package to guard against calling the detection code from unsupported OSes.

To better illustrate compatibility, please view this table:
| Platform | ``OsRelease.detect()`` support | ``OsRelease.readFile()`` and `OsRelease.readFileSync()` support | `OsRelease.contains(String string)` support |
|-|-|-|-|
| Linux | :white_check_mark: | :white_check_mark: |  :white_check_mark: |
| macOS | :x: | :x: | :x: |
| Windows | :x: | :x: | :x: |
| Windows Subsystem For Linux | :white_check_mark: | :white_check_mark: |  :white_check_mark: |
| Android | :x: | :x: | :x: |
| IOS | :x: | :x: | :x: |
| Web | :x: | :x: | :x: |

**Note:** For Dart or Flutter projects running under Windows Subsystem For Linux, no code changes are required and the ``Platform.isLinux`` field provided by `dart:io` will return true.

## Getting started
This will rely on you having either the Dart SDK or Flutter SDK installed (the Flutter SDK downloads and installs the Dart SDK).

If you want to add this to your Dart project, enter:
``dart pub add os_release``

If you want to add this to your Flutter project, enter:
``flutter pub add os_release``

## Usage
To maintain compatibility if you want to only perform detection on Linux, here's how:

```dart
import 'dart:io';

// Create a nullable instance so that: if the detection code isn't run on Linux it doesn't become a problem.
OsRelease? osRelInfo;

  if(Platform.isLinux){
    ///This is a static method and is how you should be detecting os-release info.
    osRelInfo = await OsRelease.detect();

  //Do whatever you want to do with the results of the detection
  
  }
 
  //You can also use osRelInfo here but it's probably easier to use it in the if statement above since osRelInfo there it is probably not null.
}
```

Alternatively if you have already detected os-release information another way, you can still use the ``OsRelease`` class as a model to store your detected data. 


## Additional information
__ALL__ fields declared in ``OsRelease`` are final even if some of them are nullable. Initialize the class with the constructor to set the values to what you want - You cannot alter them afterwards.

### ``OsRelease`` class is `final`

The ``OsRelease`` class is `final` - You cannot extend it or inherit from it. If you want to add new functionality to it, please consider contributing a change to the existing class.

### Why is the Class final?
This class (and indeed this package) is focused on providing something that is compatible with different Linux distributions and that means standardizing around what the original ``os-release`` itself standardized upon. Most fields that are optional in the `os-release` specification are optional (and thus marked as nullable) in `OsRelease` unless `os-release` provides a default value - in which case a value is provided and it should not be nullable.

### Why are the Fields final?
Directly modifying the results from the detection, particularly in a manner that deletes detected data, is not helpful to anyone - If you want to modify the results, please create a new variable to do so.

It is also best practice since you can't meaningfully change the data unless you are detecting data in the first instance - this is why the ``static OsRelease detect()`` method exists.

### Contributing to the Package

#### Suggestions and Bug Reports
If you have either a suggestion or bug report you can file it on [the GitHub Repo's Issues page](https://github.com/alastairlundy/os_release/issues).

#### Security Vulnerabilities
If you wish to report a potential security vulnerability please email the contact email listed for the publisher info on Dart Pub with the subject line of "os_release Potential Security Vulnerability" and information about the potential vulnerability in the message body. 
I will attempt to provide acknowledgement of the email received shortly after receiving it. It may take a few days to investigate the issue and subsequently decide how to handle the potential vulnerability if is accepted as one.

#### Submitting a Pull Request
If you'd like to add a feature or change part of the code, please:
1) fork the repository
2) make a new branch from main with a name that very briefly describes the changes you want to make
3) Test the changes to make sure it doesn't break any existing code and works on the Platforms that the package currently works on - For now testing on a Linux distro (through a Virtual Machine or natively, wherever you usually use Linux is fine) or via Windows Subsystem for Linux is sufficient.
4) Submit a Pull Request describing the changes you've made and why you've made them (particularly if it's not immediately apparent)
5) If I haven't commented on the Pull Request or reviewed it within a few weeks of it being created, please feel free to tag me @alastairlundy in the Pull Request.

If you have multiple features or changes you want to add that don't rely on each other, please follow these steps for each separate change or feature. 

You might find it duplicative or exhausting to do this, and that is understandable, but it helps to ensure that: 
A) individual changes are accepted or declined based on their merits
B) code that is submitted to be merged is reviewed and scrutinized carefully to avoid or mitigate against attacks on Open Source code and infrastructure - We don't need a repeat of the xz utils backdoor attack.
and C) code is safely added to the project without causing the package to suffer as a result of accepting the code. 

If you accept these principles and follows these steps, and your code does make helpful change, I am likely to agree to merge it.
