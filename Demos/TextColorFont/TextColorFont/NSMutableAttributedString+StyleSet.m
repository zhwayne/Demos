//
//  NSMutableAttributedString+StyleSet.m
//  TextColorFont
//
//  Created by ByRongInvest on 16/1/8.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "NSMutableAttributedString+StyleSet.h"

@implementation NSMutableAttributedString (StyleSet)

+ (instancetype)ss_string:(NSString *)string {
    return [[[self class] alloc] initWithString:string];
}

#pragma mark - Font

- (instancetype)ss_addFont:(UIFont *)font range:(NSRange)range {
    @try {
        [self addAttribute:NSFontAttributeName value:font range:range];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        return self;
    }
}

- (instancetype)ss_addFont:(UIFont *)font {
    return [self ss_addFont:font range:NSMakeRange(0, self.length)];
}

- (instancetype)ss_addFont:(UIFont *)font toIndex:(NSUInteger)index {
    return [self ss_addFont:font range:NSMakeRange(0, index)];
}

- (instancetype)ss_addFont:(UIFont *)font fromIndex:(NSUInteger)index {
    return [self ss_addFont:font range:NSMakeRange(index, self.length)];
}

- (instancetype)ss_addFont:(UIFont *)font indexFromTheEnd:(NSUInteger)index {
    return [self ss_addFont:font range:NSMakeRange(self.length - index, index)];
}

#pragma mark - Color

- (instancetype)ss_addColor:(UIColor *)color range:(NSRange)range {
    @try {
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        return self;
    }
}

- (instancetype)ss_addColor:(UIColor *)color {
    return [self ss_addColor:color range:NSMakeRange(0, self.length)];
}

- (instancetype)ss_addColor:(UIColor *)color toIndex:(NSUInteger)index {
    return [self ss_addColor:color range:NSMakeRange(0, index)];
}

- (instancetype)ss_addColor:(UIColor *)color fromIndex:(NSUInteger)index {
    return [self ss_addColor:color range:NSMakeRange(index, self.length)];
}

- (instancetype)ss_addColor:(UIColor *)color indexFromTheEnd:(NSUInteger)index {
    return [self ss_addColor:color range:NSMakeRange(self.length - index, index)];
}


#pragma mark - Strikeout

- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color range:(NSRange)range {
    [self ss_addStrikeoutWithRange:range];
    [self addAttribute:NSStrikethroughColorAttributeName value:color range:range];
    return self;
}

- (instancetype)ss_addStrikeoutWithRange:(NSRange)range {
    @try {
        [self addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:range];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        return self;
    }
}

- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color {
    return [self ss_addStrikeoutWithColor:color range:NSMakeRange(0, self.length)];
}

- (instancetype)ss_addStrikeout {
    return [self ss_addStrikeoutWithRange:NSMakeRange(0, self.length)];
}

- (instancetype)ss_addStrikeoutToIndex:(NSUInteger)index {
    return [self ss_addStrikeoutWithRange:NSMakeRange(0, index)];
}

- (instancetype)ss_addStrikeoutFromIndex:(NSUInteger)index {
    return [self ss_addStrikeoutWithRange:NSMakeRange(index, self.length)];
}

- (instancetype)ss_addStrikeoutStartingFromIndexFromTheEnd:(NSUInteger)index {
    return [self ss_addStrikeoutWithRange:NSMakeRange(self.length - index, index)];
}

- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color toIndex:(NSUInteger)index {
    return [self ss_addStrikeoutWithColor:color range:NSMakeRange(0, index)];
}

- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color fromIndex:(NSUInteger)index {
    return [self ss_addStrikeoutWithColor:color range:NSMakeRange(index, self.length)];
}

- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color indexFromTheEnd:(NSUInteger)index {
    return [self ss_addStrikeoutWithColor:color range:NSMakeRange(self.length - index, index)];
}

#pragma mark - MIX

- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color range:(NSRange)range {
    [self ss_addFont:font range:range];
    [self ss_addColor:color range:range];
    return self;
}

- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color {
    return [self ss_addFont:font color:color range:NSMakeRange(0, self.length)];
}

- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color toIndex:(NSUInteger)index {
    return [self ss_addFont:font color:color range:NSMakeRange(0, index)];
}

- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color fromIndex:(NSUInteger)index {
    return [self ss_addFont:font color:color range:NSMakeRange(index, self.length)];
}

- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color indexFromTheEnd:(NSUInteger)index {
    return [self ss_addFont:font color:color range:NSMakeRange(self.length - index, index)];
}


@end
