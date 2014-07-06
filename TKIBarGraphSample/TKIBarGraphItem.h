//
//  TKIBarGraphItem.h
//  TKIBarGraphSample
//
//  Created by 田中 幸一 on 2014/03/09.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! A TKIBarGraphItem objcet represents barGraph's colors and drawing rectangle  */
@interface TKIBarGraphItem : NSObject

@property (nonatomic, copy,readonly)   NSString  *name;
@property (nonatomic, strong)          UIColor   *color;
@property (nonatomic, assign)          CGFloat   percentage;
@property (nonatomic, assign)          CGRect    rect;
@property (nonatomic)                  CGFloat   value;

- (instancetype)initWithName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal;

+ (instancetype)graphItemWithName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal;

@end
