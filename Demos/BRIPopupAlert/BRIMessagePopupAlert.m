//
//  BRIMessagePopupAlert.m
//  BRIPopupAlert
//
//  Created by ByRongInvest on 16/2/25.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "BRIMessagePopupAlert.h"
#import "KLCPopup/KLCPopup.h"

@interface BRIMessagePopupAlert ()

@property (strong, nonatomic) KLCPopup *pop;
@property (copy, nonatomic) void (^confirm)();
@property (copy, nonatomic) void (^cancel)();
@property (strong, nonatomic) void (^cycleReference)();

@end

@implementation BRIMessagePopupAlert

+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message
                 confirmButton:(NSString *)confirmButton
                  cancelButton:(NSString *)cancelButton
                       confirm:(void (^)())confirm
                        cancel:(void (^)())cancel
{
    return [[self alloc] initWithTitle:title
                               message:message
                         confirmButton:confirmButton
                          cancelButton:cancelButton
                               confirm:confirm
                                cancel:cancel];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}


- (instancetype)initWithTitle:(NSString *)title
                       message:(NSString *)message
                 confirmButton:(NSString *)confirmButton
                  cancelButton:(NSString *)cancelButton
                       confirm:(void (^)())confirm
                        cancel:(void (^)())cancel
{
    if (self = [super init]) {
        _confirm = confirm;
        _cancel  = cancel;
        
        UIView *contentView = ({
            UIView *view                                   = [[UIView alloc] init];
            view.backgroundColor                           = [UIColor whiteColor];
            view.contentMode                               = UIViewContentModeRedraw;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            view.layer.cornerRadius                        = 4;
            view.layer.shouldRasterize                     = YES;
            view.layer.contentsScale                       = [UIScreen mainScreen].scale;
            view.layer.rasterizationScale                  = [UIScreen mainScreen].scale;
            view;
        });
        
        UILabel *titleLabel = ({
            UILabel *label                                  = [[UILabel alloc] init];
            label.text                                      = title;
            label.textAlignment                             = NSTextAlignmentCenter;
            label.font                                      = [UIFont boldSystemFontOfSize:16];
            label.textColor                                 = [UIColor darkGrayColor];
            label.adjustsFontSizeToFitWidth                 = YES;
            label.contentMode                               = UIViewContentModeRedraw;
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label;
        });
        [contentView addSubview:titleLabel];
        
        UILabel *messageLabel = ({
            UILabel *label                                  = [[UILabel alloc] init];
            label.text                                      = message;
            label.textAlignment                             = NSTextAlignmentCenter;
            label.textColor                                 = [UIColor darkGrayColor];
            label.font                                      = [UIFont systemFontOfSize:14];
            label.contentMode                               = UIViewContentModeRedraw;
            label.numberOfLines                             = 10;
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label;
        });
        [contentView addSubview:messageLabel];
        
        UIButton *confirmB = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:confirmButton forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor colorWithRed:0.000 green:0.600 blue:0.600 alpha:1.000]];
            [button setTag:1];
            button.translatesAutoresizingMaskIntoConstraints = NO;
            button.layer.cornerRadius                        = 4;
            button.layer.shouldRasterize                     = YES;
            button.layer.contentsScale                       = [UIScreen mainScreen].scale;
            button.layer.rasterizationScale                  = [UIScreen mainScreen].scale;
            button;
        });
        [contentView addSubview:confirmB];
        
        [contentView addConstraints:[NSLayoutConstraint
                                   constraintsWithVisualFormat:@"H:[contentView(260)]"
                                   options:0
                                   metrics:nil
                                   views:NSDictionaryOfVariableBindings(contentView)]];
        
        [contentView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"H:|-16-[titleLabel(>=0)]-16-|"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(titleLabel)]];
        [contentView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"H:|-16-[messageLabel(>=0)]-16-|"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(messageLabel)]];
        [contentView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"V:|-[titleLabel(34)]-[messageLabel(>=1)]"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(titleLabel, messageLabel)]];
        
        [contentView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"V:[messageLabel]-16-[confirmB(32)]-|"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(messageLabel, confirmB)]];
        
        if (cancelButton && cancelButton.length) {
            UIButton *cancelB = ({
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                [button setTitle:cancelButton forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor colorWithWhite:0.800 alpha:1.000]];
                [button setTag:0];
                button.translatesAutoresizingMaskIntoConstraints = NO;
                button.layer.cornerRadius                        = 4;
                button.layer.shouldRasterize                     = YES;
                button.layer.contentsScale                       = [UIScreen mainScreen].scale;
                button.layer.rasterizationScale                  = [UIScreen mainScreen].scale;
                button;
            });
            [contentView addSubview:cancelB];
            
            [contentView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:@"H:|-22-[cancelB(==confirmB)]-16-[confirmB(>=0)]-22-|"
                                         options:0
                                         metrics:nil
                                         views:NSDictionaryOfVariableBindings(cancelB, confirmB)]];
            [contentView addConstraint:[NSLayoutConstraint constraintWithItem:confirmB
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:cancelB
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1.f
                                                                     constant:0.f]];
        }
        else {
            [contentView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:@"H:|-80-[confirmB]-80-|"
                                         options:0
                                         metrics:nil
                                         views:NSDictionaryOfVariableBindings(confirmB)]];
        }
        
        /**
         *  设置循环引用，防止对象本身被提前释放
         */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        _cycleReference = ^{
            [self class];
        };
#pragma clang diagnostic pop
        
        _pop = [KLCPopup popupWithContentView:contentView
                                              showType:KLCPopupShowTypeBounceInFromTop
                                           dismissType:KLCPopupDismissTypeBounceOut
                                              maskType:KLCPopupMaskTypeDimmed
                              dismissOnBackgroundTouch:NO
                                 dismissOnContentTouch:NO];
        [_pop show];
    }
    
    return self;
}


- (void)buttonClicked:(UIButton *)button {
    if (button.tag == 1) {
        if (_confirm) _confirm();
    }
    else {
        if (_cancel) _cancel();
    }
    [_pop dismissPresentingPopup];
    _cycleReference = nil;
}

@end
