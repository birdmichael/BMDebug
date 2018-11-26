//
//  KSCrash+BMDebug.m
//  Pods
//
//  Created by BirdMichael on 2018/11/26.
//

#import "KSCrash+BMDebug.h"
#import "BMDebugKSCrashInstallationFile.h"

@implementation KSCrash (BMDebug)

+ (void)bmDebugLaunch {
    BMDebugKSCrashInstallationFile *installation = [BMDebugKSCrashInstallationFile sharedInstance];
    installation.printAppleFormat = YES;
    [installation install];
    
    [KSCrash sharedInstance].deleteBehaviorAfterSendAll = KSCDeleteOnSucess;
    
    [installation sendAllReportsWithCompletion:^(NSArray *filteredReports, BOOL completed, NSError *error) {
        if (completed) {
            NSLog(@"Sent %d reports", (int)[filteredReports count]);
        } else {
            NSLog(@"Failed to send reports: %@", error);
        }
    }];
}

@end
