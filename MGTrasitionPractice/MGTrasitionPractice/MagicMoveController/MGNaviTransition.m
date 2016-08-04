//
//  MGNaviTransition.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGNaviTransition.h"
#import "MGMagicMoveVC.h"
#import "MGMagicMovePushVC.h"
#import "MGMagicMoveCell.h"

@interface MGNaviTransition ()

/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) MGNaviOneTransitionType type;

@end


@implementation MGNaviTransition
#pragma mark - 初始化动画过渡代理
/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(MGNaviOneTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}
- (instancetype)initWithTransitionType:(MGNaviOneTransitionType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
/**
 *  动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.75;
}

/**
 *  如何执行过渡动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case MGNaviOneTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
            
        case MGNaviOneTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
}


/**
 *  执行push过渡动画
 */
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    MGMagicMoveVC *fromVC = (MGMagicMoveVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MGMagicMovePushVC *toVC = (MGMagicMovePushVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //拿到当前点击的cell的iconView
    MGMagicMoveCell *cell = (MGMagicMoveCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [cell.iconView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [cell.iconView convertRect:cell.iconView.bounds toView: containerView];
    //设置动画前的各个控件的状态
    cell.iconView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.image = cell.iconView.image;
    toVC.imageView.hidden = YES;
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.45 initialSpringVelocity:1/0.55 options:0 animations:^{
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
}
/**
 *  执行pop过渡动画
 */
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    MGMagicMovePushVC *fromVC = (MGMagicMovePushVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MGMagicMoveVC *toVC = (MGMagicMoveVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    MGMagicMoveCell *cell = (MGMagicMoveCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    //设置初始状态
    cell.iconView.hidden = YES;
    fromVC.imageView.hidden = YES;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [cell.iconView convertRect:cell.iconView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }else{//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的iconView
            cell.iconView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}


@end
