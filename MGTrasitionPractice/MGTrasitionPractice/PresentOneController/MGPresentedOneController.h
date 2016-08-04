//
//  MGPresentedOneController.h
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 协议
@protocol MGPresentedOneControllerDelegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;

@end

@interface MGPresentedOneController : UIViewController

@property (nonatomic, assign) id<MGPresentedOneControllerDelegate> delegate;

@end
