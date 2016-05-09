//
//  BRIGestureLine.h
//  BRIGestureLock
//
//  Created by ByRongInvest on 15/12/9.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface BRIGestureLine : CAShapeLayer

@property (strong, nonatomic) NSArray <NSValue *>*points;
@property (strong, nonatomic) UIColor *normalColor;
@property (strong, nonatomic) UIColor *highlightColor;

@property (assign, nonatomic) BOOL highlighted;

@end
