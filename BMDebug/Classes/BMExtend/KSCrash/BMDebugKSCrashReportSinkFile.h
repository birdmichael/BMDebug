//
//  BMDebugKSCrashReportSinkFile.h
//  Pods
//
//  Created by BirdMichael on 2018/11/26.
//

#import <Foundation/Foundation.h>
#import "KSCrashReportFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMDebugKSCrashReportSinkFile : NSObject  <KSCrashReportFilter>

+ (BMDebugKSCrashReportSinkFile *)filter;

- (id <KSCrashReportFilter>)defaultCrashReportFilterSet;

- (id <KSCrashReportFilter>)defaultCrashReportFilterSetAppleFmt;

@end

NS_ASSUME_NONNULL_END
