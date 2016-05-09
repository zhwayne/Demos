//
//  BRICarouselImageView.m
//  BRICarouselImageView
//
//  Created by ByRongInvest on 15/11/26.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import "BRICarouselImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>

typedef NS_ENUM(NSUInteger, Type) {
    TypeString,
    TypeImage
};


@interface BRICarouselImageView () <UIScrollViewDelegate>

@property (nonnull, strong, nonatomic ) UIScrollView   *scrollView;
@property (nonnull, strong, nonatomic ) UIImageView    *leftLeftImageView;
@property (nonnull, strong, nonatomic ) UIImageView    *leftImageView;
@property (nonnull, strong, nonatomic ) UIImageView    *middleImageView;
@property (nonnull, strong, nonatomic ) UIImageView    *rightImageView;
@property (nonnull, strong, nonatomic ) UIImageView    *rightRightImageView;
@property (nullable, strong, nonatomic) NSTimer        *timer;
@property (assign, nonatomic          ) Type           type;
@property (assign, nonatomic          ) NSUInteger     indexPage;
@property (nullable, strong, nonatomic) NSMutableArray *dataSource;

@end


@implementation BRICarouselImageView

- (void)dealloc {
    [self endScroll];
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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    _type = TypeString;
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.leftLeftImageView];
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.middleImageView];
    [self.scrollView addSubview:self.rightImageView];
    [self.scrollView addSubview:self.rightRightImageView];
}

#pragma mark - Getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView               = [[UIScrollView alloc] init];
        _scrollView.delegate      = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces       = NO;
    }
    
    return _scrollView;
}

- (UIImageView *)leftLeftImageView {
    if (!_leftLeftImageView) {
        _leftLeftImageView             = [[UIImageView alloc] init];
        _leftLeftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _leftLeftImageView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView             = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    if (!_middleImageView) {
        _middleImageView             = [[UIImageView alloc] init];
        _middleImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _middleImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView             = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _rightImageView;
}

- (UIImageView *)rightRightImageView {
    if (!_rightRightImageView) {
        _rightRightImageView             = [[UIImageView alloc] init];
        _rightRightImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _rightRightImageView;
}


#pragma mark - Setters

- (void)setImages:(NSArray<id> *)images {
    /// 数据数组为空时，返回
    if (!images || images.count == 0) {
        return;
    }
    
    /// 检测数据数组中元素的数据类型是否合法
    __block NSInteger len = 0;
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(substringWithRange:)]) {
            // 传入的是字符串数组
            --len;
        }
        else if ([obj respondsToSelector:@selector(imageWithCGImage:)]) {
            // 传入的是image对象数组
            ++len;
        }
        else {
            len = 0;
            *stop = YES;
        }
    }];
    
    if ((len != images.count && len != -images.count) || len == 0) {
        NSCAssert(NO, @"传入参数不合法，元素必须是<NSString *>或者<UIImage *>!");
    }
    
    _images     = images;
    _type       = len == _images.count ? TypeImage : TypeString;
    _dataSource = [NSMutableArray arrayWithArray:_images];
    
    [self config];
}

- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    
    [self startScroll];
}

- (void)setDelayTimeInterval:(NSTimeInterval)delayTimeInterval {
    _delayTimeInterval = delayTimeInterval;
    
    [self startScroll];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame          = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.scrollView.contentSize    = CGSizeMake(CGRectGetWidth(self.frame) * 5, CGRectGetHeight(self.frame));
    self.scrollView.contentOffset  = CGPointMake(CGRectGetWidth(self.frame) * 2, 0);
    self.leftLeftImageView.frame   = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.leftImageView.frame       = CGRectMake(CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.middleImageView.frame     = CGRectMake(CGRectGetWidth(self.frame) * 2, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.rightImageView.frame      = CGRectMake(CGRectGetWidth(self.frame) * 3, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.rightRightImageView.frame = CGRectMake(CGRectGetWidth(self.frame) * 4, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}


#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= CGRectGetWidth(self.frame) * 3) {
        //        _rightRightImageView.backgroundColor = _dataSource
        id tempObject = [_dataSource firstObject];
        [_dataSource removeObjectAtIndex:0];
        [_dataSource addObject:tempObject];
        [self config];
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * 2, 0) animated:NO];
    }
    else if (scrollView.contentOffset.x <= CGRectGetWidth(self.frame)) {
        id tempObject = [_dataSource lastObject];
        [_dataSource removeLastObject];
        [_dataSource insertObject:tempObject atIndex:0];
        [self config];
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * 2, 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self endScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self startScroll];
}


#pragma mark - 定时器方法

- (void)startScroll {
    [self endScroll];
    
    if (_autoScroll == NO || _delayTimeInterval <= 0) {
        return;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_delayTimeInterval target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)endScroll {
    [_timer invalidate];
    _timer = nil;
}

- (void)scroll {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + CGRectGetWidth(_scrollView.frame), 0) animated:YES];
}


#pragma mark - 配置数据

- (void)config {
    NSUInteger len = _dataSource.count;
    NSInteger middleIndex = (len % 2 == 0) ? (len - 1) / 2 : len / 2;
    NSInteger leftIndex = (middleIndex - 1 < 0) ? len - 1 : middleIndex - 1;
    NSInteger leftLeftIndex = (leftIndex - 1 < 0) ? len - 2 : leftIndex - 1;
    NSInteger rigintIndex = (middleIndex + 1 >= len) ? 0 : middleIndex + 1;
    NSInteger rightRightIndex = (rigintIndex + 1 >= len) ? 0 : rigintIndex + 1;
    
    
    if (_type == TypeString) {
        [self.leftLeftImageView sd_setImageWithURL:[NSURL URLWithString:_dataSource[leftLeftIndex]]];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_dataSource[leftIndex]]];
        [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:_dataSource[middleIndex]]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:_dataSource[rigintIndex]]];
        [self.rightRightImageView sd_setImageWithURL:[NSURL URLWithString:_dataSource[rightRightIndex]]];
    }
    else {
        self.leftLeftImageView.image   = _dataSource[leftLeftIndex];
        self.leftImageView.image       = _dataSource[leftIndex];
        self.middleImageView.image     = _dataSource[middleIndex];
        self.rightImageView.image      = _dataSource[rigintIndex];
        self.rightRightImageView.image = _dataSource[rightRightIndex];
    }
}

@end
