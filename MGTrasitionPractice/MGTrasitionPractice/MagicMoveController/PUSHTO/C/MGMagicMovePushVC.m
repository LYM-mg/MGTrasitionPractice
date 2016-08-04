//
//  MGMagicMovePushVC.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGMagicMovePushVC.h"
#import "MGNaviTransition.h"
#import "MGInteractiveTransition.h"

#import "MGMagicMovePushCell.h"


@interface MGMagicMovePushVC ()<UICollectionViewDataSource>
@property (nonatomic, strong) MGInteractiveTransition *interactiveTransition;
/** collectionView */
@property (nonatomic,weak)  UICollectionView *collectionView;
@end

@implementation MGMagicMovePushVC

static NSString * const KMGMagicMovePushCellReuseIdentifier = @"KMGMagicMovePushCellReuseIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"神奇移动";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化子控件
    [self setUpMainView];
    
    //初始化手势过渡的代理
    self.interactiveTransition = [MGInteractiveTransition
                                  interactiveTransitionWithTransitionType:MGInteractiveTransitionTypePop
                                  GestureDirection:MGInteractiveTransitionGestureDirectionRight];
    //给当前控制器的视图添加手势
    [_interactiveTransition addPanGestureForViewController:self];

}

#pragma mark - 私有方法
- (void)setUpMainView{
    // 1、collectionView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"02.jpg"]];
    imageView.userInteractionEnabled = YES;
    self.imageView = imageView;
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - self.view.height / 2 + 210);
    imageView.bounds = CGRectMake(0, 0, self.view.width, 300);
    
//    UICollectionViewFlowLayout *layout = ({
//        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//        layout.itemSize = CGSizeMake(self.view.width, 300);
//        layout.minimumInteritemSpacing = 0;
//        layout.minimumLineSpacing = 0;
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 水平滚动
//        layout;
//    });
//    UICollectionView *collectionView = ({
//        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 300) collectionViewLayout:layout];
//        collectionView.showsHorizontalScrollIndicator = NO;
//        collectionView.showsVerticalScrollIndicator = NO;
//        collectionView.scrollEnabled = YES;
//        collectionView.pagingEnabled = YES;
//        collectionView.dataSource = self;
//        collectionView;
//    });
//    [self.view addSubview:collectionView];
//    [collectionView registerClass:[MGMagicMovePushCell class] forCellWithReuseIdentifier:KMGMagicMovePushCellReuseIdentifier];
    
    // 2、描述
    UITextView *textView = [UITextView new];
    textView.text = @"多么神奇移动效果，向右滑动可以通过手势控制POP动画,可以看到一个大美女";
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero).priorityLow();
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
    }];
    
//    [collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    NSLog(@"%@", NSStringFromCGRect(self.imageView.frame));
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [MGNaviTransition transitionWithType:(operation == UINavigationControllerOperationPush ? MGNaviOneTransitionTypePush : MGNaviOneTransitionTypePop)];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    //手势开始的时候才需要传入手势过渡代理，如果直接点击pop，应该传入空，否者无法通过点击正常pop
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MGMagicMovePushCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KMGMagicMovePushCellReuseIdentifier forIndexPath:indexPath];
    NSString *imageName = self.images[indexPath.item%self.images.count];
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
}
@end
