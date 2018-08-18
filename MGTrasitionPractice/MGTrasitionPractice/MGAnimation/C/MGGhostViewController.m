//
//  MGGhostViewController.m
//  MGTrasitionPractice
//
//  Created by newunion on 2018/8/18.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGGhostViewController.h"
#import "HUTransitionAnimator.h"
#import "MGInteractiveTransition.h"


@interface MGGhostViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) MGInteractiveTransition *interactiveTransition;
@end

@implementation MGGhostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.transitioningDelegate = self;
    self.interactiveTransition = [MGInteractiveTransition interactiveTransitionWithTransitionType:MGInteractiveTransitionTypeDismiss GestureDirection:MGInteractiveTransitionGestureDirectionRight];
    [self.interactiveTransition addPanGestureForViewController:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveTransition;
    //.interation ? _interactiveTransition : nil;
}

#pragma mark - IBAction

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self.view];
    if (p.y > self.view.height/2) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
