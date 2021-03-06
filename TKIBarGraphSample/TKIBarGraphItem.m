//
//  TKIBarGraphItem.m
//  TKIBarGraphSample
//
//  Created by 田中 幸一 on 2014/03/09.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import "TKIBarGraphItem.h"

@interface TKIBarGraphItem ()
@property (nonatomic, copy) NSString  *name;
@end

@implementation TKIBarGraphItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [self initWithName:nil color:nil val:0];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal
{
    _name = inName;
    _color = inColor;
    _value = inVal;
    _percentage = 0.0;
    _rect = CGRectZero;
    return self;
}

+ (instancetype)graphItemWithName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal
{
    return [[self alloc] initWithName:inName color:inColor val:inVal];
}

@end
