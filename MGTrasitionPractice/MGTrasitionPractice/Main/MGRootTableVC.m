//
//  MGRootTableVC.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGRootTableVC.h"
#import "MGMagicMoveVC.h"
#import "MGPresentOneVC.h"
#import "MGPageCoverVC.h"
#import "MGCircleSpreadVC.h"
#import "MGAnimationVC.h"

#import "GradientView.h"

@interface MGRootTableVC ()
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *viewControllers;
@end

@implementation MGRootTableVC
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义转场动画";
    self.navigationController.view.layer.cornerRadius = 10;
    self.navigationController.view.layer.masksToBounds = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
}

#pragma mark - lazyLoding

- (NSArray *)data{
    if (!_data) {
        _data = [@[@"神奇移动",@"弹性pop",@"翻页效果",@"小圆点扩散",@"CustomAnimation"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [@[@"MGMagicMoveVC", @"MGPresentOneVC", @"MGPageCoverVC", @"MGCircleSpreadVC",@"MGAnimationVC"] copy];
    }
    return _viewControllers;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    __block GradientView *gradientView = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        // 1.新建一个view,随便设置位置尺寸,将gradientLayer添加到view上面
        gradientView = [[GradientView alloc] initWithFrame:cell.frame];
        gradientView.width = self.view.width;
        gradientView.backgroundColor = [UIColor clearColor];
        
        [cell addSubview:gradientView];

    }
    gradientView.textStr = _data[indexPath.row];
   //    cell.textLabel.text = _data[indexPath.row];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init] animated:YES];
}


@end
