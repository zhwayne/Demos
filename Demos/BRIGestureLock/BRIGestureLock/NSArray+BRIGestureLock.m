//
//  NSArray+BRIGestureLock.m
//  BRIGestureLock
//
//  Created by ByRongInvest on 15/12/10.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import "NSArray+BRIGestureLock.h"

@implementation NSArray (BRIGestureLock)

- (BOOL)containsPoint:(NSValue *)pointVlue {
    __block BOOL contain = NO;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSValue class]]) {
            if ([((NSValue *)obj) isEqualToValue:pointVlue]) {
                contain = YES;
                *stop   = YES;
            }
        }
        
    }];
    
    return contain;
}

- (BOOL)isLastObjectEqualToPoint:(NSValue *)pointValue {
    if ([self.lastObject isKindOfClass:[NSValue class]]) {
        return [((NSValue *)self.lastObject) isEqualToValue:pointValue];
    }
    
    return NO;
}

@end
