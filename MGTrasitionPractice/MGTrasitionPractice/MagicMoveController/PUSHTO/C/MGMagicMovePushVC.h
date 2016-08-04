//
//  MGMagicMovePushVC.h
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGMagicMovePushVC : UIViewController<UINavigationControllerDelegate>
@property (weak, nonatomic) UIImageView *imageView;
/** 数组 */
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end
