//
//  BMDebugManager.h
//  Pods
//
//  Created by BirdMichael on 2018/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMDebugManager : NSObject

// BM调试器是否正在显示中
@property (nonatomic, readonly) BOOL isHidden;

// 显示调试器
- (void)show;
// 隐藏调试器
- (void)hide;

// 单例方法
+ (instancetype)sharedInstance;



@end

NS_ASSUME_NONNULL_END
