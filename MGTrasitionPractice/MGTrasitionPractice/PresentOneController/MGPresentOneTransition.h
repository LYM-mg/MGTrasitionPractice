//
//  MGPresentOneTransition.h
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  动画过渡代理管理的是Present还是Dismiss
 */
typedef NS_ENUM(NSUInteger, MGPresentOneTransitionType) {
    MGPresentOneTransitionTypePresent = 0,
    MGPresentOneTransitionTypeDismiss
};

@interface MGPresentOneTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(MGPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(MGPresentOneTransitionType)type;

@end
