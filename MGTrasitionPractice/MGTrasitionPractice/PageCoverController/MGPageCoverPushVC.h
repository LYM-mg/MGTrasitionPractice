//
//  MGPageCoverPushVC.h
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MGPageCoverPushControllerDelegate <NSObject>

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush;

@end

@interface MGPageCoverPushVC : UIViewController<UINavigationControllerDelegate>

@property (nonatomic, assign) id<MGPageCoverPushControllerDelegate> delegate;

@end
