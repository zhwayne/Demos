//
//  CustomTransition.m
//  自定义转场
//
//  Created by ByRongInvest on 16/3/11.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "MagicPushTransition.h"
#import "ViewController.h"
#import "ViewController2.h"

@implementation MagicPushTransition


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    /**
     *  先拿到前后两个viewcontroller 以及实现动画的容器
     */
    ViewController2 *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView    = [transitionContext containerView];
    
    /**
     *  from view 的截图
     */
    UIView *snapshot = [fromVC.button snapshotViewAfterScreenUpdates:NO];
    snapshot.frame = [containerView convertRect:fromVC.button.frame fromView:fromVC.button.superview];
    fromVC.button.hidden = YES;
    
    /**
     *  设置toVC，fromVC 初始位置和最终位置
     */
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.button.hidden = YES;
    
    /**
     *  顺序很重要
     */
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapshot];
    
    
    
    
    /**
     *  动画
     */
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.alpha = 1;
        snapshot.frame = [containerView convertRect:toVC.button.frame toView:toVC.view];
    } completion:^(BOOL finished) {
        toVC.button.hidden = NO;
        fromVC.button.hidden = NO;
        [snapshot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
