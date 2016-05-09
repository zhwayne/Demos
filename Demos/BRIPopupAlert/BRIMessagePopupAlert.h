//
//  BRIMessagePopupAlert.h
//  BRIPopupAlert
//
//  Created by ByRongInvest on 16/2/25.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface BRIMessagePopupAlert : NSObject

+ (instancetype)alertWithTitle:(nullable NSString *)title
                       message:(NSString *)message
                 confirmButton:(NSString *)confirmButton
                  cancelButton:(nullable NSString *)cancelButton
                       confirm:(nullable void (^)())confirm
                        cancel:(nullable void (^)())cancel;

@end
NS_ASSUME_NONNULL_END
