//
//  DetailViewController.h
//  MGTrasitionPractice
//
//  Created by MG明明就是你 on 16/6/3.
//  Copyright © 2016年 MG明明就是你. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OUNavAnimation.h"
#import "Model.h"
@interface DetailViewController : UIViewController <OUNavAnimationDelegate>
-(instancetype)initWithModel:(Model*)model desImageViewRect:(CGRect)desRect;;
@end
