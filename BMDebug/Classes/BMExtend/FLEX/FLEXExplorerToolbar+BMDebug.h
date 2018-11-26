//
//  FLEXExplorerToolbar+BMDebug.h
//  Pods
//
//  Created by BirdMichael on 2018/11/20.
//

#import "FLEXExplorerToolbar.h"
#import "FLEXToolbarItem.h"

@class BMDebugFpsData;

@interface FLEXExplorerToolbar (BMDebug)

- (FLEXToolbarItem *)bmDebugFpsItem;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FLEXToolbarItem (BMDebug)

- (void)setFpsData:(BMDebugFpsData *)fpsData;

@end

NS_ASSUME_NONNULL_END
