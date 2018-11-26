#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BMDebug.h"
#import "BMDebugManager.h"

FOUNDATION_EXPORT double BMDebugVersionNumber;
FOUNDATION_EXPORT const unsigned char BMDebugVersionString[];

