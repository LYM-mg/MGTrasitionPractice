//
//  MGMagicMoveCell.h
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGMagicMoveCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 图片名 */
@property (nonatomic,copy) NSString *iconName;
@end
