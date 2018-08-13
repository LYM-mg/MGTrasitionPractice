//
//  MGCircleSpreadTransition.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGCircleSpreadTransition.h"
#import "MGCircleSpreadVC.h"

@interface MGCircleSpreadTransition()<CAAnimationDelegate>
/** 按钮的尺寸 */
@property (nonatomic, assign) CGRect buttonFrame;

@end

@implementation MGCircleSpreadTransition
#pragma mark - 初始化
+ (instancetype)transitionWithTransitionType:(MGCircleSpreadTransitionType)type withOriginFrame:(CGRect)buttonFrame{
    return [[self alloc] initWithTransitionType:type withOriginFrame:buttonFrame];
}

- (instancetype)initWithTransitionType:(MGCircleSpreadTransitionType)type withOriginFrame:(CGRect)buttonFrame{
    self = [super init];
    if (self) {
        _type = type;
        _buttonFrame = buttonFrame;
    }
    return self;
}

+ (instancetype)transitionWithTransitionType:(MGCircleSpreadTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(MGCircleSpreadTransitionType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (CGRectIsEmpty(_buttonFrame)) {
        switch (_type) {
            case MGCircleSpreadTransitionTypePresent:
                [self presentAnimation:transitionContext];
                break;
                
            case MGCircleSpreadTransitionTypeDismiss:
                [self dismissAnimation:transitionContext];
                break;
        }
        return;
    }
    
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor clearColor];
    
    
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGFloat radius;
    UIBezierPath *startCycle;
    UIBezierPath *endCycle;
    if (_type == MGCircleSpreadTransitionTypePresent) {
        startCycle =  [UIBezierPath bezierPathWithOvalInRect:_buttonFrame];
        CGFloat x = MAX(_buttonFrame.origin.x, containerView.frame.size.width - _buttonFrame.origin.x);
        CGFloat y = MAX(_buttonFrame.origin.y, containerView.frame.size.height - _buttonFrame.origin.y);
        radius = sqrtf(pow(x, 2) + pow(y, 2));
        endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        [containerView addSubview:toVc.view];
    }else {
        //画两个圆路径
        radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
        startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        endCycle =  [UIBezierPath bezierPathWithOvalInRect:_buttonFrame];
         [containerView addSubview:fromVc.view];
    }
    
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];

    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    if (_type == MGCircleSpreadTransitionTypePresent) {
        toVc.view.layer.mask = maskLayer;
    }else {
        fromVc.view.layer.mask = maskLayer;
    }
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    MGCircleSpreadVC *temp = toVC.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    //画两个圆路径
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.buttonFrame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController *fromVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MGCircleSpreadVC *temp = fromVC.viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    //画两个圆路径
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.buttonFrame];
    CGFloat x = MAX(temp.buttonFrame.origin.x, containerView.frame.size.width - temp.buttonFrame.origin.x);
    CGFloat y = MAX(temp.buttonFrame.origin.y, containerView.frame.size.height - temp.buttonFrame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.View的遮盖
    toVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (_type) {
        case MGCircleSpreadTransitionTypePresent:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            //            [transitionContext viewControllerForKey:UITransitionContextToViewKey].view.layer.mask = nil;
        }
            break;
        case MGCircleSpreadTransitionTypeDismiss:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                if (CGRectIsEmpty(_buttonFrame)) {
                    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
                }else {
                    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
//                   [transitionContext containerView].layer.mask = nil;
                }
                
//                [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
                
            }
        }
            break;
    }
}

@end
