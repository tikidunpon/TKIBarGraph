//
//  TKIBarGraphItem.h
//  TKIBarGraphSample
//
//  Created by 田中 幸一 on 2014/03/09.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKIBarGraphItem : NSObject

@property (nonatomic, copy,readonly)   NSString  *name;
@property (nonatomic, strong)          UIColor   *color;
@property (nonatomic, assign)          CGFloat   percentage;
@property (nonatomic, assign)          CGRect    fillRect;
@property (nonatomic)                  CGFloat   val;

- (instancetype)initWithName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal;

+ (instancetype)graphItemWithName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal;

@end
