//
//  BRIPasswordPopupAlert.m
//  BRIPopupAlert
//
//  Created by ByRongInvest on 16/3/15.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "BRIPasswordPopupAlert.h"
#import "KLCPopup/KLCPopup.h"

@interface BRIPasswordPopupAlert () <UITextFieldDelegate>

@property (strong, nonatomic) KLCPopup *pop;
@property (copy, nonatomic) void (^confirm)(NSString *text);
@property (copy, nonatomic) void (^cancel)();
@property (strong, nonatomic) void (^cycleReference)();
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIColor *confirmColorEnable;
@property (strong, nonatomic) UIColor *confirmColorDisable;
@property (assign, nonatomic) NSRange range;

@end

@implementation BRIPasswordPopupAlert


+ (void)showAlertWithTitle:(NSString *)title
               placeholder:(NSString *)placeholder
             confirmButton:(NSString *)confirmButton
              cancelButton:(NSString *)cancelButton
                   confirm:(void (^)(NSString * _Nonnull))confirm
                    cancel:(void (^)())cancel
{
    [self showAlertWithTitle:title
                 placeholder:placeholder
                       range:NSMakeRange(0, SCHAR_MAX)
               confirmButton:confirmButton
                cancelButton:cancelButton
                     confirm:confirm
                      cancel:cancel];
}

+ (void)showAlertWithTitle:(NSString *)title
               placeholder:(NSString *)placeholder
                     range:(NSRange)range
             confirmButton:(NSString *)confirmButton
              cancelButton:(NSString *)cancelButton
                   confirm:(void (^)(NSString * _Nonnull))confirm
                    cancel:(void (^)())cancel
{
    [[[self alloc] initWithTitle:title
                     placeholder:placeholder
                           range:range
                   confirmButton:confirmButton
                    cancelButton:cancelButton
                         confirm:confirm
                          cancel:cancel] show];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s", __func__);
}

- (instancetype)initWithTitle:(NSString *)title
                  placeholder:(NSString *)placeholder
                        range:(NSRange)range
                confirmButton:(NSString *)confirmButton
                 cancelButton:(NSString *)cancelButton
                      confirm:(void (^)(NSString *text))confirm
                       cancel:(void (^)())cancel
{
    if (self = [super init]) {
        if (range.length > SCHAR_MAX) {
            range.length = SCHAR_MAX;
        }
        if (range.location > SCHAR_MAX) {
            range.location = SCHAR_MAX;
        }
        _range   = range;
        _confirm = confirm;
        _cancel  = cancel;
        _confirmColorEnable  = [UIColor colorWithRed:0.000 green:0.600 blue:0.600 alpha:1.000];
        _confirmColorDisable = [_confirmColorEnable colorWithAlphaComponent:.6];
        
        /**
         *  处理键盘
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
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
            view.layer.cornerRadius                        = 8;
            view.layer.shouldRasterize                     = YES;
            view.layer.contentsScale                       = [UIScreen mainScreen].scale;
            view.layer.rasterizationScale                  = [UIScreen mainScreen].scale;
            view;
        });
        
        UILabel *titleLabel = ({
            UILabel *label                                  = [[UILabel alloc] init];
            label.text                                      = title;
            label.numberOfLines                             = 0;
            label.textAlignment                             = NSTextAlignmentLeft;
            label.font                                      = [UIFont boldSystemFontOfSize:16];
            label.textColor                                 = [UIColor darkGrayColor];
            label.adjustsFontSizeToFitWidth                 = YES;
            label.contentMode                               = UIViewContentModeRedraw;
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label;
        });
        [contentView addSubview:titleLabel];
        
        UITextField *textField                              = ({
            UITextField *textField                              = [[UITextField alloc] init];
            textField.placeholder                               = placeholder;
            textField.font                                      = [UIFont systemFontOfSize:14];
            textField.textColor                                 = [UIColor darkGrayColor];
            textField.borderStyle                               = UITextBorderStyleRoundedRect;
            textField.secureTextEntry                           = YES;
            textField.clearButtonMode                           = UITextFieldViewModeWhileEditing;
            textField.keyboardType                              = UIKeyboardTypeDefault;
            textField.returnKeyType                             = UIReturnKeyDone;
            textField.delegate                                  = (id)self;
            UIView *view                                        = [[UIView alloc] initWithFrame:CGRectMake(8, 0, 0, 0)];
            textField.leftView                                  = view;
            textField.leftViewMode                              = UITextFieldViewModeAlways;
            textField.clearButtonMode                           = UITextFieldViewModeWhileEditing;
            textField.translatesAutoresizingMaskIntoConstraints = NO;
            textField;
        });
        [contentView addSubview:textField];
        
        UIButton *confirmB = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:confirmButton forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:_confirmColorDisable];
            [button setTag:1];
            [button setEnabled:NO];
            
            button.translatesAutoresizingMaskIntoConstraints = NO;
            button.layer.cornerRadius                        = 4;
            button.layer.shouldRasterize                     = YES;
            button.layer.contentsScale                       = [UIScreen mainScreen].scale;
            button.layer.rasterizationScale                  = [UIScreen mainScreen].scale;
            button;
        });
        _confirmButton = confirmB;
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
                                     constraintsWithVisualFormat:@"H:|-16-[textField(>=0)]-16-|"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(textField)]];
        [contentView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"V:|-14-[titleLabel(>=16)]-10-[textField(>=1)]"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(titleLabel, textField)]];
        
        [contentView addConstraints:[NSLayoutConstraint
                                     constraintsWithVisualFormat:@"V:[textField]-12-[confirmB(32)]-12-|"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(textField, confirmB)]];
        
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
    [button.superview endEditing:YES];
    
    if (button.tag == 1) {
        if (_confirm) _confirm(_text);
    }
    else {
        if (_cancel) _cancel();
    }
    [_pop dismissPresentingPopup];
    _cycleReference = nil;
}

#pragma mark - Text field delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _text = textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _text = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [NSString stringWithFormat:@"%@%@", textField.text, string];
    
    {
        NSUInteger maxLen      = _range.location + _range.length;
        NSString *regular      = [NSString stringWithFormat:@"^\\S{0,%@}$", @(maxLen)];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
        if (![predicate evaluateWithObject:text]) {
            return NO;
        }
    }
    
    {
        const NSInteger minLen = _range.location + 1;
        if ((range.location >= minLen - 1 && string.length > 0)
            || (range.location >= minLen && string.length == 0)) {
            _confirmButton.enabled = YES;
            _confirmButton.backgroundColor = _confirmColorEnable;
        }
        else {
            _confirmButton.enabled = NO;
            _confirmButton.backgroundColor = _confirmColorDisable;
        }
    }
    
    return YES;
}

#pragma mark - Handle Keyboard

- (void)handleKeyboard:(NSNotification *)notification {
    CGRect kbrectEnd = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGRect rect = CGRectMake(0,
                             0,
                             CGRectGetWidth(_pop.frame),
                             CGRectGetMinY(kbrectEnd));
    
    
    
    _pop.translatesAutoresizingMaskIntoConstraints = YES;
    _pop.center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

@end
