//
//  BRIGesturePoint.h
//  BRIGestureLock
//
//  Created by ByRongInvest on 15/12/9.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface BRIGesturePoint : UIView

@property (assign, nonatomic) CGFloat outerCircleBorderWidth;
@property (assign, nonatomic) CGFloat innerDiameter;
@property (strong, nonatomic) UIColor *normalColor;
@property (strong, nonatomic) UIColor *highlightColor;
@property (strong, nonatomic) UIColor *middleCircleColor;

@property (assign, nonatomic) BOOL highlighted;
@property (assign, nonatomic) BOOL selected;

@end
