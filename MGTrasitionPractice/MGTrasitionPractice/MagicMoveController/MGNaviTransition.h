//
//  MGNaviTransition.h
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger) {
    MGNaviOneTransitionTypePush = 0,
    MGNaviOneTransitionTypePop
}MGNaviOneTransitionType;

@interface MGNaviTransition : NSObject<UIViewControllerAnimatedTransitioning>
/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(MGNaviOneTransitionType)type;
- (instancetype)initWithTransitionType:(MGNaviOneTransitionType)type;

@end
