//
//  BRIGestureLock.h
//  BRIGestureLock
//
//  Created by ByRongInvest on 15/12/9.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, BRIGestureLockType) {
    kBRIGestureLockTypeLocal,
    kBRIGestureLockTypeRemote
};

@class BRIGestureLock;
@protocol BRIGestureLockDelegate <NSObject>

@optional
- (void)gestureLock:(BRIGestureLock *)gesture didCompleteWithPasswordString:(NSString *)string;
- (void)gestureLock:(BRIGestureLock *)gesture didCompleteWithPasswordNumbers:(NSArray *)numbers NS_DEPRECATED_IOS(2_0, 2_0, "未实现");

@end

IB_DESIGNABLE
@interface BRIGestureLock : UIView

/// 外圈圆宽度( 默认2.f)
@property (assign, nonatomic) IBInspectable CGFloat circleBorderWidth;
/// 园内小点的直径 (默认 20.f)
@property (assign, nonatomic) IBInspectable CGFloat pointDiameter;
/// 线条宽度 (默认 2.f)
@property (assign, nonatomic) IBInspectable CGFloat lineWidth;
/// 常规色 （默认 rgba 81 237 240 0.8）
@property (strong, nonatomic) IBInspectable UIColor *normalColor;
/// 错误色 (默认 redColor)
@property (strong, nonatomic) IBInspectable UIColor *wrongColor;
/// 圆圈背景色(默认 clearColor)
@property (strong, nonatomic) IBInspectable UIColor *circleBackroundColor;

@property (assign, nonatomic) id<BRIGestureLockDelegate> delegate;

- (void)clash;
- (void)match;

@end
