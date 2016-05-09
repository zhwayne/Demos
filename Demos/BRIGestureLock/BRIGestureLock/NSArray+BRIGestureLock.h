//
//  NSArray+BRIGestureLock.h
//  BRIGestureLock
//
//  Created by ByRongInvest on 15/12/10.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (BRIGestureLock)

- (BOOL)containsPoint:(NSValue *)pointVlue;

- (BOOL)isLastObjectEqualToPoint:(NSValue *)pointValue;

@end
