//
//  MGPageCoverTransition.h
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger, MGPageCoverTransitionType) {
    MGPageCoverTransitionTypePush = 0,
    MGPageCoverTransitionTypePop
};

@interface MGPageCoverTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) MGPageCoverTransitionType type;
/**
 *  初始化动画过渡代理
 * @prama type 初始化pop还是push的代理
 */
+ (instancetype)transitionWithType:(MGPageCoverTransitionType)type;
- (instancetype)initWithTransitionType:(MGPageCoverTransitionType)type;

@end
