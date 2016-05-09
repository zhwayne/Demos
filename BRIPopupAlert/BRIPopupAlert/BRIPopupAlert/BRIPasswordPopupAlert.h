//
//  BRIPasswordPopupAlert.h
//  BRIPopupAlert
//
//  Created by ByRongInvest on 16/3/15.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BRIPasswordPopupAlert : NSObject

+ (void)showAlertWithTitle:(nullable NSString *)title
               placeholder:(NSString *)placeholder
             confirmButton:(NSString *)confirmButton
              cancelButton:(nullable NSString *)cancelButton
                   confirm:(nullable void (^)(NSString *text))confirm
                    cancel:(nullable void (^)())cancel;

+ (void)showAlertWithTitle:(nullable NSString *)title
               placeholder:(NSString *)placeholder
                     range:(NSRange)range
             confirmButton:(NSString *)confirmButton
              cancelButton:(nullable NSString *)cancelButton
                   confirm:(nullable void (^)(NSString *text))confirm
                    cancel:(nullable void (^)())cancel;

@end
NS_ASSUME_NONNULL_END
