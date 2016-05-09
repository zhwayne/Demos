//
//  ViewController.m
//  BRIPopupAlert
//
//  Created by ByRongInvest on 16/3/15.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "ViewController.h"
#import "BRIPopupAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    [BRIPasswordPopupAlert showAlertWithTitle:@"title\n$699.\n00" placeholder:@"密码" range:NSMakeRange(7, 9) confirmButton:@"OK" cancelButton:@"Cancel" confirm:^(NSString * _Nonnull text) {
        NSLog(@"%@", text);
    } cancel:^{
        
    }];
    
}

@end
