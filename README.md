# BMDebug

[![CI Status](https://img.shields.io/travis/birdmichael/BMDebug.svg?style=flat)](https://travis-ci.org/birdmichael/BMDebug)
[![Version](https://img.shields.io/cocoapods/v/BMDebug.svg?style=flat)](https://cocoapods.org/pods/BMDebug)
[![License](https://img.shields.io/cocoapods/l/BMDebug.svg?style=flat)](https://cocoapods.org/pods/BMDebug)
[![Platform](https://img.shields.io/cocoapods/p/BMDebug.svg?style=flat)](https://cocoapods.org/pods/BMDebug)

![View Hierarchy Exploration](http://engineering.flipboard.com/assets/flex/basic-view-exploration.gif)

## 目前常用我的功能：

- 查看视图（位置，类名，层级结构）
- 修改视图
- 修改视图属性
- 内存查看及修改（堆区）
- 沙盒文件
- 系统库
- 项目中编译类
- APPDelegate
- User Defaults 修改
- 获取设备信息
- 私有快捷操作



## FLEX基础添加

- 显示FPS值
- 显示CPU占用率
- 获取设备信息（APP信息，内存，系统，时区，设备，IP，网络，通讯）
- app资源信息
- NSLog
- Crash
- app设置（网络切换，用户信息修改）（计划中）

## 使用第三方

- KSCrash
- fishhook
- RuntimeBrowser
- FLEX

## 使用

### CocoaPods

配置podfile，仅在`Debug`下才会打包，并制定我的这个仓库:

```
pod 'FLEX', :configurations => ['Debug'], :git => 'git@github.com:birdmichael/FLEX.git'
```

在AppDelegate中引入框架并初始化Button控制呼出工具条:

More complete version:

```objc
#if DEBUG
#import "FLEXManager.h"
#endif

...

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
...
    
#ifdef DEBUG
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 30, 200, 30, 30);
        [button setTitle:@"BM" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11.f];
        [button setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
        [button addTarget:[FLEXManager sharedManager] action:@selector(showExplorer) forControlEvents:UIControlEventTouchUpInside];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:button];

    });
    
#endif
    
...

}
```



饮下引用于FLEX介绍

## Feature Examples

### Modify Views
Once a view is selected, you can tap on the info bar below the toolbar to present more details about the view. From there, you can modify properties and call methods.

![View Modification](http://engineering.flipboard.com/assets/flex/advanced-view-editing.gif)

### Network History
When enabled, network debugging allows you to view all requests made using NSURLConnection or NSURLSession. Settings allow you to adjust what kind of response bodies get cached and the maximum size limit of the response cache. You can choose to have network debugging enabled automatically on app launch. This setting is persisted across launches.

![Network History](http://engineering.flipboard.com/assets/flex/network-history.gif)

### All Objects on the Heap
FLEX queries malloc for all the live allocated memory blocks and searches for ones that look like objects. You can see everything from here.

![Heap Exploration](http://engineering.flipboard.com/assets/flex/heap-browser.gif)

### Simulator Keyboard Shortcuts
Default keyboard shortcuts allow you to activate the FLEX tools, scroll with the arrow keys, and close modals using the escape key. You can also add custom keyboard shortcuts via `-[FLEXMananger registerSimulatorShortcutWithKey:modifiers:action:description]`

![Simulator Shortcuts](https://cloud.githubusercontent.com/assets/1422245/10002927/1106fd32-6067-11e5-8e21-57a357c259b6.png)

### File Browser
View the file system within your app's sandbox. FLEX shows file sizes, image previews, and pretty prints `.json` and `.plist` files. You can copy text and image files to the pasteboard if you want to inspect them outside of your app.

![File Browser](http://engineering.flipboard.com/assets/flex/file-browser.gif)

### SQLite Browser
SQLite database files (with either `.db` or `.sqlite` extensions), or [Realm](http://realm.io) database files can be explored using FLEX. The database browser lets you view all tables, and individual tables can be sorted by tapping column headers.

![Database Browser](https://cloud.githubusercontent.com/assets/1422245/11786700/d0ab95dc-a23c-11e5-80ce-0e1b4dba2b6b.png)

### 3D Touch in the Simulator
Using a combination of the command, control, and shift keys, you can simulate different levels of 3D touch pressure in the simulator. Each key contributes 1/3 of maximum possible force. Note that you need to move the touch slightly to get pressure updates.

![Simulator 3D Touch](https://cloud.githubusercontent.com/assets/1422245/11786615/5d4ef96c-a23c-11e5-975e-67275341e439.gif)

### System Library Exploration
Go digging for all things public and private. To learn more about a class, you can create an instance of it and explore its default state.

![System Libraries Browser](http://engineering.flipboard.com/assets/flex/system-libraries-browser.gif)

### NSUserDefaults Editing
FLEX allows you to edit defaults that are any combination of strings, numbers, arrays, and dictionaries. The input is parsed as `JSON`. If other kinds of objects are set for a defaults key (i.e. `NSDate`), you can view them but not edit them.

![NSUserDefaults Editor](http://engineering.flipboard.com/assets/flex/nsuserdefaults-editor.gif)

### Learning from Other Apps
The code injection is left as an exercise for the reader. :innocent:

![Springboard Lock Screen](http://engineering.flipboard.com/assets/flex/flex-readme-reverse-1.png) ![Springboard Home Screen](http://engineering.flipboard.com/assets/flex/flex-readme-reverse-2.png)


## Installation

FLEX requires an app that targets iOS 7 or higher.

### CocoaPods

FLEX is available on [CocoaPods](https://cocoapods.org/pods/FLEX). Simply add the following line to your podfile:

```ruby
pod 'FLEX', '~> 2.0', :configurations => ['Debug']
```

### Carthage

Add the following to your Cartfile:

```
github "flipboard/FLEX" ~> 2.0
```

### Manual

Manually add the files in `Classes/` to your Xcode project.


## Excluding FLEX from Release (App Store) Builds

FLEX makes it easy to explore the internals of your app, so it is not something you should expose to your users. Fortunately, it is easy to exclude FLEX files from Release builds. The strategies differ depending on how you integrated FLEX in your project, and are described below.

At the places in your code where you integrate FLEX, do a `#if DEBUG` check to ensure the tool is only accessible in your `Debug` builds and to avoid errors in your `Release` builds. For more help with integrating FLEX, see the example project.

### FLEX added with CocoaPods

CocoaPods automatically excludes FLEX from release builds if you only specify the Debug configuration for FLEX in your Podfile.

### FLEX added with Carthage

If you are using Carthage, only including the `FLEX.framework` in debug builds is easy:

1. Do NOT add `FLEX.framework` to the embedded binaries of your target, as it would otherwise be included in all builds (therefore also in release ones).
2. Instead, add `$(PROJECT_DIR)/Carthage/Build/iOS` to your target _Framework Search Paths_ (this setting might already be present if you already included other frameworks with Carthage). This makes it possible to import the FLEX framework from your source files. It does not harm if this setting is added for all configurations, but it should at least be added for the debug one. 
3. Add a _Run Script Phase_ to your target (inserting it after the existing `Link Binary with Libraries` phase, for example), and which will embed `FLEX.framework` in debug builds only:

  ```shell
  if [ "$CONFIGURATION" == "Debug" ]; then
    /usr/local/bin/carthage copy-frameworks
  fi
  ```

  Finally, add `$(SRCROOT)/Carthage/Build/iOS/FLEX.framework` as input file of this script phase.

<p align="center"><img src="README-images/flex-exclusion-carthage.jpg"/></p>

### FLEX files added manually to a project

In Xcode, navigate to the "Build Settings" tab of your project. Click the plus and select `Add User-Defined Setting`.

![Add User-Defined Setting](http://engineering.flipboard.com/assets/flex/flex-readme-exclude-1.png)

Name the setting `EXCLUDED_SOURCE_FILE_NAMES`. For your `Release` configuration, set the value to `FLEX*`. This will exclude all files with the prefix FLEX from compilation. Leave the value blank for your `Debug` configuration.

![EXCLUDED_SOURCE_FILE_NAMES](http://engineering.flipboard.com/assets/flex/flex-readme-exclude-2.png)

## Additional Notes

- When setting fields of type `id` or values in `NSUserDefaults`, FLEX attempts to parse the input string as `JSON`. This allows you to use a combination of strings, numbers, arrays, and dictionaries. If you want to set a string value, it must be wrapped in quotes. For ivars or properties that are explicitly typed as `NSStrings`, quotes are not required.
- You may want to disable the exception breakpoint while using FLEX. Certain functions that FLEX uses throw exceptions when they get input they can't handle (i.e. `NSGetSizeAndAlignment()`). FLEX catches these to avoid crashing, but your breakpoint will get hit if it is active.


## Thanks & Credits
FLEX builds on ideas and inspiration from open source tools that came before it. The following resources have been particularly helpful:
- [DCIntrospect](https://github.com/domesticcatsoftware/DCIntrospect): view hierarchy debugging for the iOS simulator.
- [PonyDebugger](https://github.com/square/PonyDebugger): network, core data, and view hierarchy debugging using the Chrome Developer Tools interface.
- [Mike Ash](https://www.mikeash.com/pyblog/): well written, informative blog posts on all things obj-c and more. The links below were very useful for this project:
 - [MAObjCRuntime](https://github.com/mikeash/MAObjCRuntime)
 - [Let's Build Key Value Coding](https://www.mikeash.com/pyblog/friday-qa-2013-02-08-lets-build-key-value-coding.html)
 - [ARM64 and You](https://www.mikeash.com/pyblog/friday-qa-2013-09-27-arm64-and-you.html)
- [RHObjectiveBeagle](https://github.com/heardrwt/RHObjectiveBeagle): a tool for scanning the heap for live objects. It should be noted that the source code of RHObjectiveBeagle was not consulted due to licensing concerns.
- [heap_find.cpp](https://www.opensource.apple.com/source/lldb/lldb-179.1/examples/darwin/heap_find/heap/heap_find.cpp): an example of enumerating malloc blocks for finding objects on the heap.
- [Gist](https://gist.github.com/samdmarshall/17f4e66b5e2e579fd396) from [@samdmarshall](https://github.com/samdmarshall): another example of enumerating malloc blocks.
- [Non-pointer isa](http://www.sealiesoftware.com/blog/archive/2013/09/24/objc_explain_Non-pointer_isa.html): an explanation of changes to the isa field on iOS for ARM64 and mention of the useful `objc_debug_isa_class_mask` variable.
- [GZIP](https://github.com/nicklockwood/GZIP): A library for compressing/decompressing data on iOS using libz.
- [FMDB](https://github.com/ccgus/fmdb): This is an Objective-C wrapper around SQLite




## Contributing
Please see our [Contributing Guide](https://github.com/Flipboard/FLEX/blob/master/CONTRIBUTING.md).


## TODO
- Swift runtime introspection (swift classes, swift objects on the heap, etc.)
- Improved file type detection and display in the file browser
- Add new NSUserDefault key/value pairs on the fly