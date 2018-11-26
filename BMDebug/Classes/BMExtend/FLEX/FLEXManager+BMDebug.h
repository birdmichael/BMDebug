//
//  FLEXManager+BMDebug.h
//  Pods
//
//  Created by BirdMichael on 2018/11/20.
//

#import "FLEXManager.h"
#import "BMDebugFpsInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLEXManager (BMDebug) <BMDebugFpsInfoDelegate>

+ (void)bmDebugLoad;

@end

NS_ASSUME_NONNULL_END
