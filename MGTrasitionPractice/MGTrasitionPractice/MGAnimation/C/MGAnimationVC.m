//
//  MGAnimationVC.m
//  MGDemo
//
//  Created by ming on 16/7/8.
//  Copyright © 2016年 ming. All rights reserved.
//<UINavigationControllerDelegate>

#import "MGAnimationVC.h"
#import "CustomTransitionViewController.h"

@interface MGAnimationVC ()


@end

@implementation MGAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Custom" style:UIBarButtonItemStyleDone target:self action:@selector(customAnimation)];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.98f green:0.97f blue:0.90f alpha:1.00f];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"10.jpg"]];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(300);
    }];
}

- (void)customAnimation{
    CustomTransitionViewController *vc = [[CustomTransitionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    // 必须在viewDidAppear或者viewWillAppear中写，因为每次都需要将delegate设为当前界面
//    self.navigationController.delegate = self;
//}


@end
