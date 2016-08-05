//
//  MGPageCoverVC.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGPageCoverVC.h"
#import "MGInteractiveTransition.h"
#import "MGPageCoverPushVC.h"

@interface MGPageCoverVC ()<MGPageCoverPushControllerDelegate>
@property (nonatomic, strong) MGInteractiveTransition *interactiveTransitionPush;
@end

@implementation MGPageCoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.title = @"翻页效果";
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"04.jpeg"]];
    imageView.y = 64;
    imageView.height = self.view.height - 64;
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向左滑动push" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(74);
    }];
    _interactiveTransitionPush = [MGInteractiveTransition interactiveTransitionWithTransitionType:MGInteractiveTransitionTypePush GestureDirection:MGInteractiveTransitionGestureDirectionLeft];
    typeof(self)weakSelf = self;
    _interactiveTransitionPush.pushConifg = ^(){
        [weakSelf push];
    };
    //此处传入self.navigationController， 不传入self，因为self.view要形变，否则手势百分比算不准确；
    [_interactiveTransitionPush addPanGestureForViewController:self];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)backToRoot
{
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)push{
    MGPageCoverPushVC *pushVC = [MGPageCoverPushVC new];
    self.navigationController.delegate = pushVC;
    pushVC.delegate = self;
    [self.navigationController pushViewController:pushVC animated:YES];
}

#pragma mark - MGPageCoverPushControllerDelegate
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush{
    return _interactiveTransitionPush;
}

@end
