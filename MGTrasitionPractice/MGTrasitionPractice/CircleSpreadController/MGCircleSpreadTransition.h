//
//  MGCircleSpreadTransition.h
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MGCircleSpreadTransitionType) {
    MGCircleSpreadTransitionTypePresent = 0,
    MGCircleSpreadTransitionTypeDismiss
};

@interface MGCircleSpreadTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) MGCircleSpreadTransitionType type;

+ (instancetype)transitionWithTransitionType:(MGCircleSpreadTransitionType)type withOriginFrame:(CGRect)buttonFrame;
- (instancetype)initWithTransitionType:(MGCircleSpreadTransitionType)type withOriginFrame:(CGRect)buttonFrame;

+ (instancetype)transitionWithTransitionType:(MGCircleSpreadTransitionType)type;

- (instancetype)transitionWithTransitionType:(MGCircleSpreadTransitionType)type;
@end

