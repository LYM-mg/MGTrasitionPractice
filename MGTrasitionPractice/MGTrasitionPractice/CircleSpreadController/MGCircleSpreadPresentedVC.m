//
//  MGCircleSpreadPresentedVC.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGCircleSpreadPresentedVC.h"
#import "MGInteractiveTransition.h"
#import "MGCircleSpreadTransition.h"

@interface MGCircleSpreadPresentedVC ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) MGInteractiveTransition *interactiveTransition;
@end

@implementation MGCircleSpreadPresentedVC


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"02.jpg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 50, self.view.frame.size.width, 50);
    [self.view addSubview:button];
    self.interactiveTransition = [MGInteractiveTransition interactiveTransitionWithTransitionType:MGInteractiveTransitionTypeDismiss GestureDirection:MGInteractiveTransitionGestureDirectionDown];
    [self.interactiveTransition addPanGestureForViewController:self];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [MGCircleSpreadTransition transitionWithTransitionType:MGCircleSpreadTransitionTypePresent withOriginFrame:_buttonFrame];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [MGCircleSpreadTransition transitionWithTransitionType:MGCircleSpreadTransitionTypeDismiss withOriginFrame:_buttonFrame];
}


- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}


- (void)dealloc{
    NSLog(@"销毁了");
}

@end
