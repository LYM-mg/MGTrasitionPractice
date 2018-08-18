//
//  MGPresentViewController.m
//  MGTrasitionPractice
//
//  Created by newunion on 2018/8/18.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGPresentViewController.h"
#import "HUTransitionAnimator.h"
#import "MGLeftPresentAnimation.h"
#import "MGViewController.h"

@interface MGPresentViewController ()<UIViewControllerTransitioningDelegate>

@property (strong,nonatomic) UIPercentDrivenInteractiveTransition *interactiveTransition;;
@end

@implementation MGPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioningDelegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"笨蛋呐，好想你";
    
    //添加手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(panGestureRecognizerAction:)]; [self.view addGestureRecognizer:pan];
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 40;
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 100, width-40, height);
    [btn1 setTitle:@"关闭" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btn1Action{
    [self dismissViewControllerAnimated:YES completion:nil];
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


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    MGLeftPresentAnimation* leftPresentAnimation = [[MGLeftPresentAnimation alloc] init];
    leftPresentAnimation.isPresent = NO;
    return leftPresentAnimation;
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    MGLeftPresentAnimation* leftPresentAnimation = [[MGLeftPresentAnimation alloc] init];
    leftPresentAnimation.isPresent = YES;
    return leftPresentAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveTransition;
}


@end
