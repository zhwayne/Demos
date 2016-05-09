//
//  TableSectionExtraModel.m
//  TableViewDemo
//
//  Created by Wayne on 16/3/31.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "TableSectionExtraModel.h"

const CGFloat defaultHeaderFooterHeight = CGFLOAT_MIN;

@implementation TableSectionExtraModel

- (instancetype)init {
    if (self = [super init]) {
        _height = defaultHeaderFooterHeight;
    }
    
    return self;
}

@end
