//
//  OJLCollectionViewCell.h
//  MGTrasitionPractice
//
//  Created by MG明明就是你 on 16/6/3.
//  Copyright © 2016年 MG明明就是你. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@interface OJLCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) Model* model;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
