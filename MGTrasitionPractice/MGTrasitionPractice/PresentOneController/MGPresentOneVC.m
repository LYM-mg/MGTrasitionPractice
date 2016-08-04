//
//  MGPresentOneVC.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGPresentOneVC.h"
#import "MGInteractiveTransition.h"
#import "MGPresentedOneController.h"

@interface MGPresentOneVC ()<MGPresentedOneControllerDelegate>
@property (nonatomic, strong) MGInteractiveTransition *interactivePush;
@end

@implementation MGPresentOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"弹性present";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"08.jpg"]];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或者向上滑动present" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).offset(-200);
    }];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
    
    _interactivePush = [MGInteractiveTransition interactiveTransitionWithTransitionType:MGInteractiveTransitionTypePresent GestureDirection:MGInteractiveTransitionGestureDirectionUp];
    typeof(self)weakSelf = self;
    _interactivePush.presentConifg = ^(){
        [weakSelf present];
    };
    [_interactivePush addPanGestureForViewController:self.navigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - present
- (void)present{
    MGPresentedOneController *presentedVC = [MGPresentedOneController new];
    presentedVC.delegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

#pragma mark -  MGPresentedOneControllerDelegate
- (void)presentedOneControllerPressedDissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return _interactivePush;
}

@end
