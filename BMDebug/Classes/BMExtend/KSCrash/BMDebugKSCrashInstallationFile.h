//
//  BMDebugKSCrashInstallationFile.h
//  Pods
//
//  Created by BirdMichael on 2018/11/26.
//

#import "KSCrashInstallation.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMDebugKSCrashInstallationFile : KSCrashInstallation

@property(nonatomic, assign) BOOL printAppleFormat;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
