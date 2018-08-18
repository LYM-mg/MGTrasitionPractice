//
//  MGLeftPresentAnimation.m
//  MGTrasitionPractice
//
//  Created by newunion on 2018/8/18.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGLeftPresentAnimation.h"

@implementation MGLeftPresentAnimation
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* toView = nil;
    UIView* fromView = nil;
    UIView* transView = nil;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
        
    } if (self.isPresent) {
        transView = toView;
        [[transitionContext containerView] addSubview:toView];
        
    }else {
        transView = fromView;
        [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
        
    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height; transView.frame = CGRectMake(self.isPresent ?width :0, 0, width, height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        transView.frame = CGRectMake(self.isPresent ?0 :width, 0, width, height);
        
    } completion:^(BOOL finished) { [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }];
}
//- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
//    <#code#>
//}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

@end
