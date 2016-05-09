//
//  NavigationController.m
//  自定义转场
//
//  Created by ByRongInvest on 16/3/11.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "NavigationController.h"
#import "MagicPushTransition.h"

@interface NavigationController () <UINavigationControllerDelegate>

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[MagicPushTransition alloc] init];
    }
    return nil;
}

@end
