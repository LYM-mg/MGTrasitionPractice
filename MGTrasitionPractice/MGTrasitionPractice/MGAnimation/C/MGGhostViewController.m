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
//@property (nonatomic, strong) MGInteractiveTransition *interactiveTransition;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation MGGhostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.transitioningDelegate = self;
//    self.interactiveTransition = [MGInteractiveTransition interactiveTransitionWithTransitionType:MGInteractiveTransitionTypeDismiss GestureDirection:MGInteractiveTransitionGestureDirectionRight];
//    [self.interactiveTransition addPanGestureForViewController:self];
    
    //添加手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(panGestureRecognizerAction:)]; [self.view addGestureRecognizer:pan];
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan{
    
    //产生百分比
    CGFloat process = [pan translationInView:self.view].x / ([UIScreen mainScreen].bounds.size.width);
    
    NSLog(@"panGesture.width = %f   transitionX = %f",pan.view.frame.size.width,[pan translationInView:pan.view].x);
    process = MIN(1.0,(MAX(0.0, process)));
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.interactiveTransition = [UIPercentDrivenInteractiveTransition new];
        //触发dismiss转场动画
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        [self.interactiveTransition updateInteractiveTransition:process];
    }else if (pan.state == UIGestureRecognizerStateEnded
              || pan.state == UIGestureRecognizerStateCancelled){
        if (process > 0.5) {
            [ self.interactiveTransition finishInteractiveTransition];
        }else{
            [ self.interactiveTransition cancelInteractiveTransition];
        }
        self.interactiveTransition = nil;
    }
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
