//
//  BRIImagePopupAlert.m
//  BRIPopupAlert
//
//  Created by ByRongInvest on 16/2/25.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "BRIImagePopupAlert.h"
#import "KLCPopup/KLCPopup.h"

@interface BRIImagePopupAlert ()

@property (strong, nonatomic) KLCPopup *pop;
@property (copy, nonatomic) void (^confirm)();
@property (copy, nonatomic) void (^cancel)();
@property (strong, nonatomic) void (^cycleReference)();

@end

@implementation BRIImagePopupAlert

+ (void)showAlertWithImage:(UIImage *)image
             confirmButton:(NSString *)confirmButton
              cancelButton:(NSString *)cancelButton
                   confirm:(void (^)())confirm
                    cancel:(void (^)())cancel
{
    [[[self alloc] initWithImage:image
                   confirmButton:confirmButton
                    cancelButton:cancelButton
                         confirm:confirm
                          cancel:cancel] show];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)initWithImage:(UIImage *)image
                confirmButton:(NSString *)confirmButton
                 cancelButton:(NSString *)cancelButton
                      confirm:(void (^)())confirm
                       cancel:(void (^)())cancel
{
    if (self = [super init]) {
        _confirm = confirm;
        _cancel  = cancel;
        /**
         *  设置循环引用，防止对象本身被提前释放
         */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        _cycleReference = ^{
            [self class];
        };
#pragma clang diagnostic pop
        
        UIView *contentView = ({
            UIView *view                                   = [[UIView alloc] init];
            view.backgroundColor                           = [UIColor whiteColor];
            view.contentMode                               = UIViewContentModeRedraw;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            view.layer.masksToBounds                       = YES;
            view.layer.cornerRadius                        = 8;
            view.layer.shouldRasterize                     = YES;
            view.layer.contentsScale                       = [UIScreen mainScreen].scale;
            view.layer.rasterizationScale                  = [UIScreen mainScreen].scale;
            view;
        });
        
        UIImageView *imageView = ({
            UIImageView *imageView                              = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode                               = UIViewContentModeScaleAspectFit;
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView;
        });
        [contentView addSubview:imageView];
        
        [contentView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"H:[contentView(260)]"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(contentView)]];
        
        [contentView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(imageView)]];
        [contentView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(imageView)]];
        
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
                                     constraintsWithVisualFormat:@"V:[confirmB(32)]-12-|"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(confirmB)]];
        
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
        
        _pop = [KLCPopup popupWithContentView:contentView
                                     showType:KLCPopupShowTypeBounceIn
                                  dismissType:KLCPopupDismissTypeBounceOut
                                     maskType:KLCPopupMaskTypeDimmed
                     dismissOnBackgroundTouch:NO
                        dismissOnContentTouch:NO];
    }
    
    return self;
}

- (void)show {
    [_pop show];
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
