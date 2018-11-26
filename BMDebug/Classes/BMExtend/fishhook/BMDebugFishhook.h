//
//  BMDebugFishhook.h
//  Pods
//
//  Created by BirdMichael on 2018/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMDebugFishhook : NSObject

+ (BOOL)isLogEnabled;

+ (void)logMessage:(NSString *)message;

+ (NSArray *)allLogMessages;

+ (NSUInteger)logLimit;
+ (void)setLogLimit:(NSUInteger)logLimit;

@end

NS_ASSUME_NONNULL_END
