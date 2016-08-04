//
//  MGCircleSpreadVC.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGCircleSpreadVC.h"
#import "MGCircleSpreadPresentedVC.h"


@interface MGCircleSpreadVC ()
@property (nonatomic, weak) UIButton *button;
@end

@implementation MGCircleSpreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"10.jpg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    
    // 按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button = button;
    [button setTitle:@"点击或\n拖动我" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = 1;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(0, 0)).priorityLow();
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.greaterThanOrEqualTo(self.view);
        make.top.greaterThanOrEqualTo(self.view).offset(64);
        make.bottom.right.lessThanOrEqualTo(self.view);
    }];
    
    // 手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [button addGestureRecognizer:pan];
}

- (void)present{
    MGCircleSpreadPresentedVC *presentVC = [MGCircleSpreadPresentedVC new];
    [self presentViewController:presentVC animated:YES completion:nil];
}

- (CGRect)buttonFrame{
    return _button.frame;
}

#pragma mark - 手势
- (void)pan:(UIPanGestureRecognizer *)panGesture{
    UIView *button = panGesture.view;
    CGPoint newCenter = CGPointMake([panGesture translationInView:panGesture.view].x + button.center.x - [UIScreen mainScreen].bounds.size.width / 2, [panGesture translationInView:panGesture.view].y + button.center.y - [UIScreen mainScreen].bounds.size.height / 2);
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(newCenter).priorityLow();
    }];
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

#pragma mark - Navigation


@end
