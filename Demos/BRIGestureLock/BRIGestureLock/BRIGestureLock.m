//
//  BRIGestureLock.m
//  BRIGestureLock
//
//  Created by ByRongInvest on 15/12/9.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import "BRIGestureLock.h"
#import "BRIGesturePoint.h"
#import "BRIGestureLine.h"
#import "NSArray+BRIGestureLock.h"


#define POINTSCALE  (1 / 4.f)

@interface BRIGestureLock ()

@property (strong, nonatomic) NSMutableArray <NSValue *> *points;
@property (strong, nonatomic) NSMutableArray <BRIGesturePoint *> *pointViews;
@property (strong, nonatomic) NSMutableString *numbers;

@property (strong, nonatomic) UIColor *currentColor;
@property (strong, nonatomic) BRIGestureLine *line;

@end


@implementation BRIGestureLock


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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    _points     = [NSMutableArray array];
    _pointViews = [NSMutableArray array];
    _numbers    = [NSMutableString string];
    
    _lineWidth         = 2;
    _pointDiameter     = 20;
    _circleBorderWidth = 2;
    
    _normalColor          = [UIColor colorWithRed:81 / 255.f green:237 / 255.f blue:240 / 255.f alpha:.8f];
    _currentColor         = _normalColor;
    _wrongColor           = [UIColor redColor];
    _circleBackroundColor = [UIColor clearColor];
    
    _line = [BRIGestureLine layer];
    [self.layer addSublayer:_line];
    
    for (int i = 0; i < 9; ++i) {
        @autoreleasepool {
            BRIGesturePoint *point = [BRIGesturePoint new];
            point.tag = -10000 + i;
            [self addSubview:point];
        }
    }
}

#pragma mark - Setter

- (void)setFrame:(CGRect)frame {
    frame.size.width = frame.size.height;
    [super setFrame:frame];
}


#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat pointDiameter          = MAX(CGRectGetWidth(self.frame) * POINTSCALE, CGRectGetHeight(self.frame) * POINTSCALE);
    __weak __typeof(self) weakSelf = self;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong __typeof(weakSelf) self = weakSelf;
        
        if ([obj isKindOfClass:[BRIGesturePoint class]]) {
            BRIGesturePoint *pointView = (BRIGesturePoint *)obj;
            
            CGFloat xs[3] = {pointDiameter / 2.f, CGRectGetWidth(self.frame) / 2.f, CGRectGetWidth(self.frame) - (pointDiameter / 2.f)};
            CGFloat ys[3] = {pointDiameter / 2.f, CGRectGetHeight(self.frame) / 2.f, CGRectGetHeight(self.frame) - (pointDiameter / 2.f)};

            pointView.bounds                 = CGRectMake(0, 0, pointDiameter, pointDiameter);
            pointView.center                 = CGPointMake(xs[idx % 3], ys[idx / 3]);
            pointView.outerCircleBorderWidth = _circleBorderWidth;
            pointView.innerDiameter          = pointDiameter / 3;
            pointView.normalColor            = _normalColor;
            pointView.highlightColor         = _wrongColor;
            pointView.middleCircleColor      = _circleBackroundColor;
            pointView.backgroundColor        = [UIColor clearColor];
            [pointView setNeedsDisplay];
        }
    }];
    
    [_pointViews enumerateObjectsUsingBlock:^(BRIGesturePoint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        _points[idx] = [NSValue valueWithCGPoint:obj.center];
    }];
    
    _line.frame          = self.bounds;
    _line.lineWidth      = _lineWidth;
    _line.normalColor    = _normalColor;
    _line.highlightColor = _wrongColor;
    _line.points         = _points;
}


#pragma mark - Touch events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self beginToDragOnPoint:[touches.anyObject locationInView:self]];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endDragOnPoint:[touches.anyObject locationInView:self]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dragOnPoint:[touches.anyObject locationInView:self]];
}


#pragma mark - Private methods

- (void)beginToDragOnPoint:(CGPoint)point  {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BRIGesturePoint class]]) {
            if (containsPoint(point, obj.frame)) {
                ((BRIGesturePoint *)obj).selected = YES;
                *stop = YES;
            }
        }
    }];
}

- (void)dragOnPoint:(CGPoint)point {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BRIGesturePoint class]]) {
            if (containsPoint(point, obj.frame)) {
                NSValue *pointValue = [NSValue valueWithCGPoint:obj.center];
                if (![_points containsPoint:pointValue]) {
                    ((BRIGesturePoint *)obj).selected = YES;
                    [_points addObject:pointValue];
                    [_pointViews addObject:obj];
                    [_numbers appendString:[NSString stringWithFormat:@"%@", @(obj.tag + 10000)]];
                }
                *stop = YES;
            }
        }
    }];
    
    NSMutableArray *points = [NSMutableArray arrayWithArray:_points];
    [points addObject:[NSValue valueWithCGPoint:point]];
    _line.points = [points copy];
}

- (void)endDragOnPoint:(CGPoint)point {
    __block BOOL pointInside = NO;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BRIGesturePoint class]]) {
            if (containsPoint(point, obj.frame)) {
                pointInside = YES;
            }
        }
    }];
    
    if (!pointInside) {
        NSValue *pointValue = [NSValue valueWithCGPoint:point];
        if ([_points isLastObjectEqualToPoint:pointValue]) {
            [_points removeLastObject];
        }
    }
    
    _line.points = [_points copy];
    
    self.userInteractionEnabled = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(gestureLock:didCompleteWithPasswordString:)]) {
        [self.delegate gestureLock:self didCompleteWithPasswordString:[_numbers copy]];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self reset];
        });
    }
}

- (void)resetSelectedPointViewsToHighlight {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BRIGesturePoint class]]) {
            if (((BRIGesturePoint *)obj).selected == YES) {
                ((BRIGesturePoint *)obj).highlighted = YES;
            }
        }
    }];
}

#pragma mark - Public methods

- (void)reset {
    [_numbers replaceCharactersInRange:NSMakeRange(0, _numbers.length) withString:@""];
    [_points removeAllObjects];
    [_pointViews removeAllObjects];
    _line.points                = @[];
    _line.highlighted           = NO;
    self.userInteractionEnabled = YES;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BRIGesturePoint class]]) {
            ((BRIGesturePoint *)obj).selected    = NO;
            ((BRIGesturePoint *)obj).highlighted = NO;
        }
    }];
}

- (void)match {
    [self reset];
}

- (void)clash {
    _line.highlighted = YES;
    [self resetSelectedPointViewsToHighlight];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reset];
    });
}


#pragma mark - tools :)

bool containsPoint(CGPoint point, CGRect rect)
{
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    return (powf(fabs(point.x - center.x), 2) + powf(fabs(point.y - center.y), 2)) <= powf(rect.size.width / 2, 2);
}

@end
