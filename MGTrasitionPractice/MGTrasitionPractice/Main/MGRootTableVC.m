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

@interface MGRootTableVC ()
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *viewControllers;
@end

@implementation MGRootTableVC

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
        _data = [@[@"神奇移动",@"弹性pop",@"翻页效果",@"小圆点扩散"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [@[@"MGMagicMoveVC", @"MGPresentOneVC", @"MGPageCoverVC", @"MGCircleSpreadVC"] copy];
    }
    return _viewControllers;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init] animated:YES];
}


@end
