//
//  GradientView.h
//  滑动解锁效果
//
//  Created by ming on 16/8/3.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView
/** 接口  外界赋值字符串 */
@property (nonatomic,copy) NSString *textStr;

- (void)addAnimationToGradientLayer;
@end
