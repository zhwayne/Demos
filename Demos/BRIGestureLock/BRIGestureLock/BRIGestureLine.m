//
//  BRIGestureLine.m
//  BRIGestureLock
//
//  Created by ByRongInvest on 15/12/9.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import "BRIGestureLine.h"

@implementation BRIGestureLine

+ (instancetype)layer {
    id layer = [super layer];
    
    if (layer) {
        [self initialize];
    }
    
    return layer;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    self.fillColor   = [UIColor clearColor].CGColor;
    self.lineCap     = kCALineCapRound;
    self.lineJoin    = kCALineJoinRound;
}


#pragma mark - Setters

- (void)setPoints:(NSArray *)points {
    _points = points;
    [self setNeedsDisplay];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    
    if (!_highlighted) {
        self.strokeColor = normalColor.CGColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    if (_highlighted) {
        self.strokeColor = _highlightColor.CGColor;
    } else {
        self.strokeColor = _normalColor.CGColor;
    }
    
    [self setNeedsDisplay];
}


- (void)drawInContext:(CGContextRef)ctx {
    drawPath(self, self.points);
}

void drawPath(CAShapeLayer *layer, NSArray <NSValue *> *points)
{
    CGMutablePathRef path = CGPathCreateMutable();
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [points enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                CGPoint point = [obj CGPointValue];
                if (idx == 0) {
                    CGPathMoveToPoint(path, NULL, point.x, point.y);
                } else {
                    CGPathAddLineToPoint(path, NULL, point.x, point.y);
                }
            }
        }];
    });

    layer.path = path;
}

@end
