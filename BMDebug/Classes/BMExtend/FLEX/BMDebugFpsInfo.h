//
//  BMDebugFpsInfo.h
//  Pods
//
//  Created by BirdMichael on 2018/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMDebugFpsData : NSObject

// FPS，取整数：(int)round(fps)
@property (nonatomic, assign) float fps;

// FPS结果，1好 0警告 -1不好
@property (nonatomic, assign) NSInteger fpsState;

// CPU占比，0-100
@property (nonatomic, assign) float cpu;
// CPU占比结果，1好 0警告 -1不好
@property (nonatomic, assign) NSInteger cpuState;

@end

@protocol BMDebugFpsInfoDelegate <NSObject>

- (void)bmDebugFpsInfoChanged:(BMDebugFpsData *)fpsData;

@end

@interface BMDebugFpsInfo : NSObject

@property (nonatomic, weak) id<BMDebugFpsInfoDelegate> delegate;

@property (nonatomic, strong, readonly) BMDebugFpsData *fpsData;

- (void)start;

- (void)stop;

NS_ASSUME_NONNULL_END

@end
