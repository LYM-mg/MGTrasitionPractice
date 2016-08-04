//
//  MGMagicMoveVC.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGMagicMoveVC.h"
#import "MGMagicMoveCell.h"

#import "MGMagicMovePushVC.h"

@interface MGMagicMoveVC ()
/** 图片数组 */
@property (nonatomic,strong) NSMutableArray *images;
@end

@implementation MGMagicMoveVC

static NSString * const KMGMagicMoveCellReuseIdentifier = @"KMGMagicMoveCellReuseIdentifier";

- (NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i = 0; i<10; i++) {
            NSString *str = [NSString stringWithFormat:@"%02d.jpg",i+1];
            [_images addObject:str];
        }
    }
    return _images;
}


- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(180, 200);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    self = [super initWithCollectionViewLayout:layout];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"神奇移动";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = back;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MGMagicMoveCell class]) bundle:nil] forCellWithReuseIdentifier:KMGMagicMoveCellReuseIdentifier];
}

- (void)backToRoot
{
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (MGMagicMoveCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGMagicMoveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KMGMagicMoveCellReuseIdentifier forIndexPath:indexPath];
    cell.iconName = self.images[indexPath.item%self.images.count];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _currentIndexPath = indexPath;
    MGMagicMovePushVC *vc = [[MGMagicMovePushVC alloc] init];
    vc.images = self.images;
    vc.indexPath = indexPath;
    //设置导航控制器的代理为推出的控制器，可以达到自定义不同控制器的退出效果的目的
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
