//
//  model.m
//  MGTrasitionPractice
//
//  Created by MG明明就是你 on 16/6/3.
//  Copyright © 2016年 MG明明就是你. All rights reserved.
//

#import "Model.h"
@implementation Model
+(NSArray *)models{
    NSMutableArray* array = [NSMutableArray array];
    
    NSArray* dicArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil]];

    for (NSDictionary* dic in dicArray) {
        Model* m = [Model new];
        [m setValuesForKeysWithDictionary:dic];
        [array addObject:m];
    }
    
    return array;
}
-(CGSize)scaleSize{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat scale = width / [self.w floatValue];
    CGFloat height = [self.h floatValue] * scale;
    
    return CGSizeMake(width, height);
}

@end
