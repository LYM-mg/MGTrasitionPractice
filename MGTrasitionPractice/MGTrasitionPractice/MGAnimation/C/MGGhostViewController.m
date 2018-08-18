//
//  MGGhostViewController.m
//  MGTrasitionPractice
//
//  Created by newunion on 2018/8/18.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGGhostViewController.h"
#import "HUTransitionAnimator.h"

@interface MGGhostViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation MGGhostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
//    self.navigationItem.title = @"笨蛋呐，好想你";
    self.transitioningDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate

//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                  animationControllerForOperation:(UINavigationControllerOperation)operation
//                                               fromViewController:(UIViewController *)fromVC
//                                                 toViewController:(UIViewController *)toVC
//{
//    NSObject <UIViewControllerAnimatedTransitioning> *animator;
//
//    animator = [[HUTransitionGhostAnimator alloc] init];
//    [(HUTransitionGhostAnimator *)animator setPresenting:YES];
//
//    return animator;
//}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    NSObject <UIViewControllerAnimatedTransitioning> *animator;
    
    animator = [[HUTransitionGhostAnimator alloc] init];
    [(HUTransitionGhostAnimator *)animator setPresenting:YES];
    
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    NSObject <UIViewControllerAnimatedTransitioning> *animator;
    
    animator = [[HUTransitionGhostAnimator alloc] init];
    [(HUTransitionGhostAnimator *)animator setPresenting:NO];
    
    return animator;
}

#pragma mark - IBAction

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
