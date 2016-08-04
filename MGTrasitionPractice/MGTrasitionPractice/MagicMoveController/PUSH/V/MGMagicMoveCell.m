//
//  MGMagicMoveCell.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGMagicMoveCell.h"

@interface MGMagicMoveCell ()


@end

@implementation MGMagicMoveCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setIconName:(NSString *)iconName{
    _iconName = iconName;
    self.iconView.image = [UIImage imageNamed:iconName];
}

@end
