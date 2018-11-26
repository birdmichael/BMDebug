//
//  BMDebugManager.m
//  Pods
//
//  Created by BirdMichael on 2018/11/18.
//

#import "BMDebugManager.h"
#import "FLEXManager+BMDebug.h"
#import "KSCrash+BMDebug.h"

@implementation BMDebugManager

#pragma mark - LifeCycl


+ (void)load
{
    [BMDebugManager sharedInstance];
}

+ (instancetype)sharedInstance
{
    static BMDebugManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BMDebugManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [FLEXManager bmDebugLoad];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLaunch:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Private

- (void)onLoad
{
    [FLEXManager bmDebugLoad];
}
- (void)onLaunch:(NSNotification *)notification
{
    [KSCrash bmDebugLaunch];
}

#pragma mark - Public

- (BOOL)isHidden
{
    return [FLEXManager sharedManager].isHidden;
}

- (void)show{
    [[FLEXManager sharedManager] showExplorer];
}

- (void)hide
{
    [[FLEXManager sharedManager] hideExplorer];
}

@end
