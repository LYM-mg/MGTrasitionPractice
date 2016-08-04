//
//  MGMagicMovePushCell.m
//  MGTrasitionPractice
//
//  Created by ming on 16/8/4.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGMagicMovePushCell.h"

@implementation MGMagicMovePushCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        self.imageView = imageView;
        [self addSubview:imageView];
    }
    return self;
}

- (void)setImageView:(UIImageView *)imageView{
    _imageView.image = imageView.image;
}

@end
