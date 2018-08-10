//
//  GradientView.m
//  滑动解锁效果
//
//  Created by ming on 16/8/3.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "GradientView.h"

@interface GradientView ()

/** 渐变层 */
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
/** <#注释#> */
@property (nonatomic,strong) UILabel *textLabel;
@end

@implementation GradientView
#pragma mark - lazy
- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:self.gradientLayer.bounds];
        _textLabel.textColor = [UIColor grayColor];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont boldSystemFontOfSize:30];
        _textLabel.userInteractionEnabled = NO;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}


- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc] init];
        
        // 设置开始位置和结束位置
        _gradientLayer.startPoint = CGPointMake( 0.0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        
        // 从左到右依次的这几种颜色,颜色是渐变的
        NSArray *colors = @[
                            (id)[UIColor blackColor].CGColor,
                            (id)[UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1.0].CGColor,
                            (id)[UIColor blackColor].CGColor
                            ];
        _gradientLayer.colors = colors;
        
        // 颜色的位置
        NSArray *locations = @[@(0.25), @(0.5), @(0.75)];
        _gradientLayer.locations = locations;
    }
    
    return _gradientLayer;
}

/**
 *  为gradientLayer添加动画效果
 */
- (void)addAnimationToGradientLayer{
    [self.gradientLayer removeAllAnimations];
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnimation.fromValue = @[@(0.0), @(0.0), @(0.25)];
    gradientAnimation.toValue = @[@(0.75), @(1.0), @(1.0)];
    gradientAnimation.duration = 3.0;
    gradientAnimation.repeatCount = MAXFLOAT;
    [self.gradientLayer addAnimation:gradientAnimation forKey:nil];
}

//- (void)didMoveToWindow{
//    [super didMoveToWindow];
////     [self.gradientLayer removeAllAnimations];
//    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
//    gradientAnimation.fromValue = @[@(0.0), @(0.0), @(0.25)];
//    gradientAnimation.toValue = @[@(0.75), @(1.0), @(1.0)];
//    gradientAnimation.duration = 3.0;
//    gradientAnimation.repeatCount = MAXFLOAT;
//    [self.gradientLayer addAnimation:gradientAnimation forKey:nil];
//}

// 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.gradientLayer];
        [self textLabel];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self.layer addSublayer:self.gradientLayer];
        [self textLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
    self.textLabel.frame = self.gradientLayer.frame;
    
    [self didMoveToWindow];
}

/**
 *  接口
 *
 *  @param text 外界设置的字符串
 */
- (void)setTextStr:(NSString *)textStr{
    _textStr = textStr;
    
    self.textLabel.text = textStr;
    self.gradientLayer.mask =  self.textLabel.layer;
    [self addAnimationToGradientLayer];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
//    NSLog(@"dsadasda");
//}

@end
