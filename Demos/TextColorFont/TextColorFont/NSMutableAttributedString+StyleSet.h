//
//  NSMutableAttributedString+StyleSet.h
//  TextColorFont
//
//  Created by ByRongInvest on 16/1/8.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSMutableAttributedString (StyleSet)

+ (instancetype)ss_string:(NSString *)string;

// Font
- (instancetype)ss_addFont:(UIFont *)font;
- (instancetype)ss_addFont:(UIFont *)font range:(NSRange)range;
- (instancetype)ss_addFont:(UIFont *)font toIndex:(NSUInteger)index;
- (instancetype)ss_addFont:(UIFont *)font fromIndex:(NSUInteger)index;
- (instancetype)ss_addFont:(UIFont *)font indexFromTheEnd:(NSUInteger)index;


// Color
- (instancetype)ss_addColor:(UIColor *)color;
- (instancetype)ss_addColor:(UIColor *)color range:(NSRange)range;
- (instancetype)ss_addColor:(UIColor *)color toIndex:(NSUInteger)index;
- (instancetype)ss_addColor:(UIColor *)color fromIndex:(NSUInteger)index;
- (instancetype)ss_addColor:(UIColor *)color indexFromTheEnd:(NSUInteger)index;

// Strikeout
- (instancetype)ss_addStrikeout;
- (instancetype)ss_addStrikeoutWithRange:(NSRange)range;
- (instancetype)ss_addStrikeoutToIndex:(NSUInteger)index;
- (instancetype)ss_addStrikeoutFromIndex:(NSUInteger)index;
- (instancetype)ss_addStrikeoutStartingFromIndexFromTheEnd:(NSUInteger)index;
- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color;
- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color range:(NSRange)range;
- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color toIndex:(NSUInteger)index;
- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color fromIndex:(NSUInteger)index;
- (instancetype)ss_addStrikeoutWithColor:(UIColor *)color indexFromTheEnd:(NSUInteger)index;


// MIX
- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color;
- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color range:(NSRange)range;
- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color toIndex:(NSUInteger)index;
- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color fromIndex:(NSUInteger)index;
- (instancetype)ss_addFont:(UIFont *)font color:(UIColor *)color indexFromTheEnd:(NSUInteger)index;

@end
