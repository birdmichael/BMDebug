//
//  FLEXManager+BMDebug.m
//  Pods
//
//  Created by BirdMichael on 2018/11/20.
//

#import "FLEXManager+BMDebug.h"
#import "FLEXExplorerViewController.h"
#import "FLEXFileBrowserTableViewController.h"
#import "FLEXObjectExplorerViewController+BMDebug.h"
#import "FLEXClassExplorerViewController+BMDebug.h"
#import "FLEXFileBrowserTableViewController+BMDebug.h"
#import "FLEXExplorerToolbar+BMDebug.h"
#import "FLEXSystemLogTableViewController+BMDebug.h"
#import "FLEXInstancesTableViewController+BMDebug.h"
#import "FLEXObjectExplorerFactory.h"
#import "BMMethodSwizzling.h"
#import "BMDebugSystemInfo.h"


@interface FLEXManager ()

@property (nonatomic, strong) FLEXExplorerViewController *explorerViewController;

@end

@interface FLEXExplorerViewController ()

@property (nonatomic, strong) FLEXExplorerToolbar *explorerToolbar;

- (void)makeKeyAndPresentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)selectedViewExplorerFinished:(id)sender;

@end

@implementation FLEXManager (BMDebug)

+ (void)load
{
    BMExchangeInstanceMethods(self, @selector(showExplorer), @selector(bmDebugShowExplorer));
    BMExchangeInstanceMethods(self, @selector(hideExplorer), @selector(bmDebugHideExplorer));
}

+ (void)bmDebugLoad
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [FLEXManager sharedManager].explorerViewController.title = @"BM";
    });
    
    [FLEXManager sharedManager].networkDebuggingEnabled = YES;
    
    [[FLEXManager sharedManager] registerGlobalEntryWithName:@"📳  BM's Device Info" viewControllerFutureBlock:^UIViewController *{
        return [[BMDebugSystemInfo alloc] init];
    }];
    
    [[FLEXManager sharedManager] registerGlobalEntryWithName:@"📘  App Browser" viewControllerFutureBlock:^UIViewController *{
        return [[FLEXFileBrowserTableViewController alloc] initWithPath:[NSBundle mainBundle].bundlePath];
    }];
    
    [[FLEXManager sharedManager] registerGlobalEntryWithName:@"📝  BMLog Browser" viewControllerFutureBlock:^UIViewController *{
        NSString *fileLogPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        fileLogPath = [[fileLogPath stringByAppendingPathComponent:@"BMDebug"] stringByAppendingPathComponent:@"NSLog"];
        return [[FLEXFileBrowserTableViewController alloc] initWithPath:fileLogPath];
    }];
    
    [[FLEXManager sharedManager] registerGlobalEntryWithName:@"🍀  BMCrash Log" viewControllerFutureBlock:^UIViewController *{
        NSString *crashLogPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        crashLogPath = [[crashLogPath stringByAppendingPathComponent:@"BMDebug"] stringByAppendingPathComponent:@"CrashLog"];
        return [[FLEXFileBrowserTableViewController alloc] initWithPath:crashLogPath];
    }];
    
//    💟  App Config
}

- (BMDebugFpsInfo *)bmDebugFpsInfo
{
    BMDebugFpsInfo *fpsInfo = objc_getAssociatedObject(self, _cmd);
    if (!fpsInfo) {
        fpsInfo = [[BMDebugFpsInfo alloc] init];
        fpsInfo.delegate = self;
        objc_setAssociatedObject(self, _cmd, fpsInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self.explorerViewController.explorerToolbar.bmDebugFpsItem addTarget:self action:@selector(bmDebugFpsItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.explorerViewController.explorerToolbar.bmDebugFpsItem setFpsData:fpsInfo.fpsData];
    }
    return fpsInfo;
}

- (void)bmDebugShowExplorer
{
    
    [self bmDebugShowExplorer];
    
    [self.bmDebugFpsInfo start];
}

- (void)bmDebugHideExplorer
{
    [self bmDebugHideExplorer];
    
    [self.bmDebugFpsInfo stop];
}

- (void)bmDebugFpsInfoChanged:(BMDebugFpsData *)fpsData
{
    [self.explorerViewController.explorerToolbar.bmDebugFpsItem setFpsData:fpsData];
}

- (void)bmDebugFpsItemClicked:(FLEXToolbarItem *)sender
{
    FLEXObjectExplorerViewController *viewController = [FLEXObjectExplorerFactory explorerViewControllerForObject:[self bmDebugViewController]];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self.explorerViewController action:@selector(selectedViewExplorerFinished:)];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.explorerViewController makeKeyAndPresentViewController:navigationController animated:YES completion:nil];
}

- (UIViewController *)bmDebugViewController
{
    UIViewController *currentViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while ([currentViewController presentedViewController]) {
        currentViewController = [currentViewController presentedViewController];
    }
    while ([currentViewController isKindOfClass:[UITabBarController class]] &&
           [(UITabBarController *)currentViewController selectedViewController]) {
        currentViewController = [(UITabBarController *)currentViewController selectedViewController];
    }
    while ([currentViewController isKindOfClass:[UINavigationController class]] &&
           [(UINavigationController *)currentViewController topViewController]) {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    }
    return currentViewController;
}


@end
