//
//  BRICarouselImageView.h
//  BRICarouselImageView
//
//  Created by ByRongInvest on 15/11/26.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BRICarouselImageView : UIView

/*!
 *    图片URL地址数组, 或者图片对象数组
 */
@property (nullable, strong, nonatomic) NSArray<id> *images;
/*!
 *    是否自动滚动，默认为 NO.
 */
@property (assign, nonatomic) IBInspectable BOOL autoScroll;
/*!
 *    定时器时间间隔. 单位(s) 默认为 4 s
 */
@property (assign, nonatomic) IBInspectable NSTimeInterval delayTimeInterval;

@end
