//
//  WLReloadPromptView.h
//  ZHWAYNE
//
//  Created by Wayne on 15/12/23.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface WLReloadPromptView : UIView

@property (strong, nonatomic) IBInspectable UIColor *ringColor;         /*< 圆圈的颜色 */
@property (strong, nonatomic) IBInspectable UIColor *WIFIColor;         /*< WIFI Logo 的颜色 */
@property (strong, nonatomic) IBInspectable UIColor *promptTextColor;   /*< 提示文字的颜色 */
@property (strong, nonatomic) IBInspectable UIColor *reloadTitleColor;  /*< 按钮标题的颜色 */
@property (strong, nonatomic) IBInspectable UIColor *borderColor;       /*< 按钮边框的颜色 */
@property (strong, nonatomic) IBInspectable UIColor *borderFillColor;   /*< 按钮背景色 */
@property (copy, nonatomic) IBInspectable NSString *promptText;         /*< 提示文字 */
@property (copy, nonatomic) IBInspectable NSString *reloadTitle;        /*< 按钮标题 */
@property (assign, nonatomic) IBInspectable CGFloat borderRadius;       /*< 按钮边框圆角 */

@property (nullable, copy, nonatomic) void (^reloadActions)(void);      /*< 按钮点击的闭包 */

- (instancetype)initWithCoveredView:(UIView *)view;
- (instancetype)initWithCoveredView:(UIView *)view reloadActions:(void (^ _Nullable)(void))actions;
- (instancetype)initWithFrame:(CGRect)frame NS_DEPRECATED_IOS(2_0, 2_0);
- (instancetype)init NS_DEPRECATED_IOS(2_0, 2_0);

- (void)appear;
- (void)disappear;

NS_ASSUME_NONNULL_END

@end
