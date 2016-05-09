//
//  ViewController.m
//  BRIGestureLock
//
//  Created by ByRongInvest on 15/12/9.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <BRIGestureLockDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.lock.delegate = self;
}


- (void)gestureLock:(BRIGestureLock *)gesture didCompleteWithPasswordString:(NSString *)string {
    NSLog(@"%@", string);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [gesture clash];
    });
}


@end
