//
//  MGInteractiveTransition.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGInteractiveTransition.h"

@interface MGInteractiveTransition ()
#pragma mark - 属性
/** 传入的控制器 */
@property (nonatomic, weak) UIViewController *vc;
/** 手势方向 */
@property (nonatomic, assign) MGInteractiveTransitionGestureDirection direction;
/** 手势类型 */
@property (nonatomic, assign) MGInteractiveTransitionType type;

@end

@implementation MGInteractiveTransition

#pragma mark -  初始化方法
+ (instancetype)interactiveTransitionWithTransitionType:(MGInteractiveTransitionType)type GestureDirection:(MGInteractiveTransitionGestureDirection)direction{
    return [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(MGInteractiveTransitionType)type GestureDirection:(MGInteractiveTransitionGestureDirection)direction{
    if (self = [super init]) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController{
    self.vc = viewController;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [viewController.view addGestureRecognizer:pan];
}

/**
 *  手势过渡的过程
 *
 *  @param panGesture 传入手势
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    
    switch (self.direction) {
        case MGInteractiveTransitionGestureDirectionLeft:{ // 左
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
            break;
        }
        case MGInteractiveTransitionGestureDirectionRight:{ // 右
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
            break;
        }
        case MGInteractiveTransitionGestureDirectionUp:{ // 上
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].y;
            persent = transitionX / panGesture.view.frame.size.width;
            break;
        }
        case MGInteractiveTransitionGestureDirectionDown:{ // 下
            CGFloat transitionX = [panGesture translationInView:panGesture.view].y;
            persent = transitionX / panGesture.view.frame.size.width;
            break;
        }
        default:
            break;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded: case UIGestureRecognizerStateCancelled:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

/**
 *  类型
 */
- (void)startGesture{
    switch (_type) {
        /**
         *  Model
         */
        case MGInteractiveTransitionTypePresent:{
            if (_presentConifg) {
                _presentConifg();
            }
        }
            break;
            
        case MGInteractiveTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
            
        /**
         *  PUSH
         */
        case MGInteractiveTransitionTypePush:{
            if (_pushConifg) {
                _pushConifg();
            }
        }
            break;
        case MGInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}


@end
