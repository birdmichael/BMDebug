//
//  BMDebugKSCrashInstallationFile.m
//  Pods
//
//  Created by BirdMichael on 2018/11/26.
//

#import "BMDebugKSCrashInstallationFile.h"
#import "KSCrashInstallation+Private.h"
#import "KSCrashReportFilterAppleFmt.h"
#import "KSCrashReportFilterBasic.h"
#import "KSCrashReportFilterJSON.h"
#import "KSCrashReportFilterStringify.h"
#import "BMDebugKSCrashReportSinkFile.h"

@implementation BMDebugKSCrashInstallationFile
@synthesize printAppleFormat = _printAppleFormat;

+ (instancetype)sharedInstance
{
    static BMDebugKSCrashInstallationFile *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BMDebugKSCrashInstallationFile alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if ((self = [super initWithRequiredProperties:nil])) {
        self.printAppleFormat = NO;
    }
    return self;
}

- (id<KSCrashReportFilter>)sink
{
    BMDebugKSCrashReportSinkFile *sink = [BMDebugKSCrashReportSinkFile filter];
    if (self.printAppleFormat) {
        return [sink defaultCrashReportFilterSetAppleFmt];
    } else {
        return [sink defaultCrashReportFilterSet];
    }
}
@end
