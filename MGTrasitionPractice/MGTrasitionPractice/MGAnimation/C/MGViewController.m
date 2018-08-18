//
//  MGViewController.m
//  MGTrasitionPractice
//
//  Created by newunion on 2018/8/18.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGViewController.h"
#import "MGPresentViewController.h"
#import "MGLeftPresentAnimation.h"

@interface MGViewController ()

@end

@implementation MGViewController

- (void)viewDidLoad {
     // 设置导航栏右边按钮
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Custom" style:UIBarButtonItemStyleDone target:self action:@selector(customAnimation)];
     
     self.view.backgroundColor = [UIColor redColor];
     self.navigationItem.title = @"笨蛋呐，好想你";

}


 - (void)customAnimation{
     MGPresentViewController * secondVC = [[MGPresentViewController alloc] init];
     secondVC.transitioningDelegate = self;
     [self presentViewController:secondVC animated:YES completion:nil];
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
