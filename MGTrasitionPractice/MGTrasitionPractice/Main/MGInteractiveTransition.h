//
//  MGInteractiveTransition.h
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GestureHanderConifg)();
/**
 *  手势的方向
 */
typedef NS_ENUM(NSUInteger) {
    MGInteractiveTransitionGestureDirectionLeft = 0,
    MGInteractiveTransitionGestureDirectionRight,
    MGInteractiveTransitionGestureDirectionUp,
    MGInteractiveTransitionGestureDirectionDown
}MGInteractiveTransitionGestureDirection;

/**
 *  手势控制哪种转场
 */
typedef NS_ENUM(NSUInteger) {
    MGInteractiveTransitionTypePresent = 0,
    MGInteractiveTransitionTypeDismiss,
    MGInteractiveTransitionTypePush,
    MGInteractiveTransitionTypePop,
} MGInteractiveTransitionType;


@interface MGInteractiveTransition : UIPercentDrivenInteractiveTransition

/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interation;
/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureHanderConifg presentConifg;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureHanderConifg pushConifg;


#pragma mark - 初始化方法
// 初始化方法
+ (instancetype)interactiveTransitionWithTransitionType:(MGInteractiveTransitionType)type GestureDirection:(MGInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(MGInteractiveTransitionType)type GestureDirection:(MGInteractiveTransitionGestureDirection)direction;

/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
