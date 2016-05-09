//
//  WLReloadPromptView.h
//  ZHWAYNE
//
//  Created by Wayne on 15/12/23.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

#import "WLReloadPromptView.h"

char * const setNeedsDisplayContext = "setNeedsDisplay";

@interface WLReloadPromptView ()

@property (strong, nonatomic) UIColor *tempBorderFillColor;
@property (strong, nonatomic) UIView  *coverdView;  // general is superview

@end

@implementation WLReloadPromptView
{
    CGRect buttonRect;
}

- (instancetype)initWithCoveredView:(UIView *)view reloadActions:(void (^)(void))actions {
    self = [super initWithFrame:view.bounds];
    if (self) {
        self.coverdView    = view;
        self.reloadActions = actions;
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithCoveredView:(UIView *)view {
    self = [[[self class] alloc] initWithCoveredView:view reloadActions:nil];
    return self;
}

- (instancetype)init {
    NSCAssert(NO, @"Please use `-initWithCoveredView:reloadActions:`");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
        [self setNeedsDisplay];
    }
    
    return self;
}

- (void)dealloc {
    @try {
        [self removeObserver:self forKeyPath:@"ringColor"];
        [self removeObserver:self forKeyPath:@"WIFIColor"];
        [self removeObserver:self forKeyPath:@"promptTextColor"];
        [self removeObserver:self forKeyPath:@"reloadTitleColor"];
        [self removeObserver:self forKeyPath:@"borderColor"];
        [self removeObserver:self forKeyPath:@"borderFillColor"];
        [self removeObserver:self forKeyPath:@"promptText"];
        [self removeObserver:self forKeyPath:@"reloadTitle"];
        [self removeObserver:self forKeyPath:@"borderRadius"];
    }
    @catch (NSException *exception) {
        // Do nothing here.
    }
}

- (void)initialize {
    _ringColor           = [UIColor colorWithRed:0.736 green:0.737 blue:0.721 alpha:1.000];
    _WIFIColor           = [UIColor whiteColor];
    _promptTextColor     = [UIColor lightGrayColor];
    _reloadTitleColor    = [UIColor darkGrayColor];
    _borderColor         = [UIColor darkGrayColor];
    _borderFillColor     = [UIColor whiteColor];
    _promptText          = @"您的设备网络不太顺畅哦~";
    _reloadTitle         = @"重新加载";
    _borderRadius        = 4;
    self.backgroundColor = [UIColor whiteColor];
    
    [self addObserver:self forKeyPath:@"ringColor" options:0x01 context:setNeedsDisplayContext];
    [self addObserver:self forKeyPath:@"WIFIColor" options:0x01 context:setNeedsDisplayContext];
    [self addObserver:self forKeyPath:@"promptTextColor" options:0x01 context:setNeedsDisplayContext];
    [self addObserver:self forKeyPath:@"reloadTitleColor" options:0x01 context:setNeedsDisplayContext];
    [self addObserver:self forKeyPath:@"borderColor" options:0x01 context:setNeedsDisplayContext];
    [self addObserver:self forKeyPath:@"borderFillColor" options:0x01 context:setNeedsDisplayContext];
    [self addObserver:self forKeyPath:@"promptText" options:0x01 context:setNeedsDisplayContext];
    [self addObserver:self forKeyPath:@"reloadTitle" options:0x01 context:setNeedsDisplayContext];
    [self addObserver:self forKeyPath:@"borderRadius" options:0x01 context:setNeedsDisplayContext];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (!strcmp(context, setNeedsDisplayContext)) {
        [self setNeedsDisplay];
    }
}


#pragma mark - Override

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 一个圆
    CGPoint point = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect) - 60);
    CGRect frame  = convert_points_to_the_rect(point, 60);

    CGContextSetLineWidth(ctx, 1);
    [[UIColor clearColor] setFill];
    CGContextFillRect(ctx, frame);
    CGContextAddEllipseInRect(ctx, frame);
    [_ringColor setFill];
    CGContextFillPath(ctx);

    // WIFI logo
    point = CGPointMake(point.x, point.y + 30);
    UIBezierPath *path;
    
    CGContextSetLineWidth(ctx, 6.0);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, _WIFIColor.CGColor);

    for (int i = 0; i < 4; ++i) {
        if (i < 3) {
            path = [UIBezierPath bezierPathWithArcCenter:point radius:60 - i * 20 startAngle:M_PI * 1.24  endAngle:M_PI * 1.76  clockwise:YES];
            CGContextAddPath(ctx, path.CGPath);
            CGContextStrokePath(ctx);
            continue;
        }
        
        path = [UIBezierPath bezierPathWithArcCenter:point radius:2 startAngle:M_PI * 0  endAngle:M_PI * 2  clockwise:YES];
        CGContextAddPath(ctx, path.CGPath);
        CGContextStrokePath(ctx);
    }

    // 提示文字
    NSString *text               = nil;
    NSDictionary *textAttributes = nil;
    CGSize textSize              = CGSizeZero;
    CGRect textRect              = CGRectZero;
    
    point          = CGPointMake(point.x, point.y + 60);
    text           = _promptText;
    textAttributes = @{NSForegroundColorAttributeName: _promptTextColor,
                        NSFontAttributeName: [UIFont systemFontOfSize:16]};
    textSize       = [text sizeWithAttributes:textAttributes];
    textRect       = CGRectMake(point.x - textSize.width / 2, point.y,
                                textSize.width, textSize.height);
    [text drawInRect:textRect withAttributes:textAttributes];

    // 点击按钮（实际上只是显示一个按钮的样子，点击事件交由 Touch end 处理）
    point          = CGPointMake(point.x, point.y + 50);
    text           = _reloadTitle;
    textAttributes = @{NSForegroundColorAttributeName: _reloadTitleColor,
                       NSFontAttributeName: [UIFont systemFontOfSize:15]};
    textSize       = [text sizeWithAttributes:textAttributes];
    textRect       = CGRectMake(point.x - textSize.width / 2, point.y,
                                textSize.width, textSize.height);
    
    // 按钮边框
    buttonRect = CGRectMake(CGRectGetMinX(textRect) - 40, CGRectGetMinY(textRect) - 8,
                            CGRectGetWidth(textRect) + 80, CGRectGetHeight(textRect) + 16);
    path       = [UIBezierPath bezierPathWithRoundedRect:buttonRect cornerRadius:_borderRadius];
    [_borderColor setStroke];
    [_borderFillColor setFill];
    CGContextSetLineWidth(ctx, 1);
    CGContextAddPath(ctx, path.CGPath);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    [text drawInRect:textRect withAttributes:textAttributes];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.borderFillColor = _tempBorderFillColor;
    if (CGRectContainsPoint(CGRectInset(buttonRect, -20, -20), [touches.anyObject locationInView:self]) &&
        self.reloadActions) {
        self.reloadActions();
        
        self.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _tempBorderFillColor = self.borderFillColor;
    if (CGRectContainsPoint(buttonRect, [touches.anyObject locationInView:self])) {
        self.borderFillColor = lightColor(self.borderFillColor, -0.04);
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!CGRectContainsPoint(CGRectInset(buttonRect, -20, -20), [touches.anyObject locationInView:self])) {
        self.borderFillColor = _tempBorderFillColor;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(buttonRect, point)) return YES;
    return NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}


#pragma mark - Public methods

- (void)appear {
    if (!self.superview) {
        [self.coverdView addSubview:self];
    }
    
    self.hidden = NO;
    self.alpha  = 1;
    [self.superview bringSubviewToFront:self];
}

- (void)disappear {
    if (!self.superview) return;
    
    self.hidden = YES;
    self.alpha  = 0;
    [self.superview insertSubview:self atIndex:0];
}

#pragma mark - Private methods

CGRect convert_points_to_the_rect(CGPoint point, CGFloat radius)
{
    CGRect rect     = CGRectZero;
    rect.size.width = rect.size.height = radius * 2;
    rect.origin.x   = point.x - radius;
    rect.origin.y   = point.y - radius;
    
    return rect;
}

UIColor* lightColor(UIColor *color, CGFloat value)
{
    if (value < -1) value = -1;
    else if (value > 1) value = 1;
    else if (value == 0) return color;
    
    value = 1 + value;
    
    CGFloat h=0,s=0,b=0,a=0;
    [color getHue:&h saturation:&s brightness:&b alpha:&a];
    
    NSDictionary *HSBA = @{@"HSBA-h": @(h),
                           @"HSBA-s": @(s),
                           @"HSBA-b": @(b * value),
                           @"HSBA-a": @(a)};
    
    return [UIColor colorWithHue:[HSBA[@"HSBA-h"] doubleValue]
                      saturation:[HSBA[@"HSBA-s"] doubleValue]
                      brightness:[HSBA[@"HSBA-b"] doubleValue]
                           alpha:[HSBA[@"HSBA-a"] doubleValue]];
}


@end
