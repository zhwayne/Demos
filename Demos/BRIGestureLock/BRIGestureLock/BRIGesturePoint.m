//
//  BRIGesturePoint.m
//  BRIGestureLock
//
//  Created by ByRongInvest on 15/12/9.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import "BRIGesturePoint.h"

@implementation BRIGesturePoint

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    _selected               = NO;
    _highlighted            = NO;
    _outerCircleBorderWidth = 2;
    _innerDiameter          = 20;
    _normalColor            = [UIColor greenColor];
    _highlightColor         = [UIColor redColor];
    _middleCircleColor      = [UIColor clearColor];
    
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (!_highlighted && !_selected) {
        drawCircle(ctx, rect, _outerCircleBorderWidth, _middleCircleColor.CGColor, _normalColor.CGColor);
    } else if (!_highlighted && _selected) {
        drawCircle(ctx, rect, _outerCircleBorderWidth + 0.5, _middleCircleColor.CGColor, _normalColor.CGColor);
        drawCircle(ctx, rect, _innerDiameter, _normalColor.CGColor, [UIColor clearColor].CGColor);
        drawCircle(ctx, rect, 0, [UIColor colorWithWhite:1 alpha:0.1].CGColor, [UIColor clearColor].CGColor);
    } else {
        drawCircle(ctx, rect, _outerCircleBorderWidth + 0.5, _middleCircleColor.CGColor, _highlightColor.CGColor);
        drawCircle(ctx, rect, _innerDiameter, _highlightColor.CGColor, [UIColor clearColor].CGColor);
    }
}


void drawCircle(CGContextRef ctx, CGRect rect, CGFloat borderWidth, CGColorRef fillColor, CGColorRef storkColor)
{
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectInset(rect,
                                                   borderWidth,
                                                   borderWidth));
    
    CGContextSetLineWidth(ctx, borderWidth);
    CGContextSetFillColorWithColor(ctx, fillColor);
    CGContextSetStrokeColorWithColor(ctx, storkColor);
    CGContextAddPath(ctx, path);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
