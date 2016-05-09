//
//  TableUpdateProtocol.h
//  TableViewDemo
//
//  Created by Wayne on 16/3/31.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TableUpdateProtocol <NSObject>

@optional
@property CGFloat theHeight;

- (void)didSelected;

@required
- (void)updateContentWithObject:(id)object;

@end
