//
//  TKIBarGraph.m
//  TKIBarGraphSample
//
//  Created by 田中 幸一 on 2014/03/09.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import "TKIBarGraphView.h"
#import "TKIBarGraphItem.h"

@interface TKIBarGraphView ()

/*!graphItems total value */
@property (nonatomic) CGFloat totalVal;

/*!TKIBarGraphItems Array */
@property (nonatomic, strong) NSMutableArray *internalItems;

@end

@implementation TKIBarGraphView

#pragma mark - Initializer
- (void)awakeFromNib
{
    NSLog(@"%s",__func__);
    [self privateInit];
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"%s",__func__);
    self = [super initWithFrame:frame];
    if (self) {
        [self privateInit];
    }
    return self;
}

- (void)privateInit
{
    NSLog(@"%s",__func__);
    _internalItems = [[NSMutableArray alloc] init];
    _totalVal = 0;
}

/*!return immutable TKIBarGraphItems */
- (NSArray *)items
{
    NSLog(@"%s",__func__);
    return [self.internalItems copy];
}

/*!set graphItem with item info */
- (void)addItemWithName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal
{
    NSLog(@"%s",__func__);
    if ( !inName || !inColor ) {
        return;
    }
    TKIBarGraphItem *item = [TKIBarGraphItem graphItemWithName:inName color:inColor val:inVal];
    [self.internalItems addObject:item];
    self.totalVal += item.val;
}

- (void)addItemWithName:(NSString *)inName dictionary:(NSDictionary *)inDict
{
    NSLog(@"%s",__func__);
    if ( !inName || !inDict ) {
        return;
    }
    for (UIColor *inColorKey in [inDict allKeys]) {
        if ( ![inColorKey isKindOfClass:[UIColor class]] ||
             ![[inDict objectForKey:inColorKey] isKindOfClass:[NSNumber class]])
        {
            return;
        }
        @autoreleasepool
        {
            NSNumber *inVal = inDict[inColorKey];
            TKIBarGraphItem *item = [TKIBarGraphItem graphItemWithName:inName
                                                                 color:inColorKey
                                                                   val:[inVal integerValue]];
            [self.internalItems addObject:item];
            self.totalVal += item.val;
        }
    }
}

/*!reset all items */
- (void)resetAllGraphItem
{
    NSLog(@"%s",__func__);
    if ([self.internalItems count] > 0)
    {
        [self.internalItems removeAllObjects];
        self.totalVal = 0;
    }
}

/*!update item */
- (void)updateItemWithName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal
{
    NSLog(@"%s",__func__);
    if ( !inName ) {
        return;
    }
    for (TKIBarGraphItem *item in self.internalItems)
    {
        if ([item.name compare:inName options:0] == NSOrderedSame) {
            item.color = inColor;
            self.totalVal -= item.val;
            item.val = inVal;
            self.totalVal += item.val;
        }
    }
}

/*!update item with dict*/
- (void)updateItemWithName:(NSString *)inName dictionary:(NSDictionary *)inDict
{
    NSLog(@"%s",__func__);
    if ( !inName || !inDict ) {
        return;
    }
    
    int i = 0;
    for (UIColor *inColorKey in [inDict allKeys]) {
        if ( ![inColorKey isKindOfClass:[UIColor class]] ||
            ![[inDict objectForKey:inColorKey] isKindOfClass:[NSNumber class]])
        {
            return;
        }
        
        NSNumber *inVal = inDict[inColorKey];
        TKIBarGraphItem *item = self.internalItems[i];
        
        if ([item.name compare:inName options:0] == NSOrderedSame)  {
            
            item.color     = inColorKey;
            self.totalVal -= item.val;
            item.val       = [inVal floatValue];
            self.totalVal += item.val;
        }
        i++;
    }
}

#pragma mark - Private Methods

- (void)drawRect:(CGRect)rect
{
    NSLog(@"%s",__func__);
    [self calcFillRect:rect];
    
    [self drawBarGraph];
}

- (void)calcFillRect:(CGRect)baseRect
{
    NSLog(@"%s",__func__);
    if ( [self.items count] <= 0 )
    {
        return;
    }
    
    // calc and set percentage to barGraphItems
    CGFloat startPoint = 0;
    for ( TKIBarGraphItem *item in self.internalItems )
    {
        item.percentage = ( item.val / self.totalVal);
        CGFloat barWidth = (CGRectGetWidth(baseRect) * item.percentage);
        item.fillRect = CGRectMake( baseRect.origin.x + startPoint, baseRect.origin.y,
                                    barWidth, baseRect.size.height);
        startPoint += barWidth;
    }
}

- (void)drawBarGraph
{
    NSLog(@"%s",__func__);
    for ( TKIBarGraphItem *item in self.internalItems ) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:item.fillRect];
        [item.color setFill];
        [bezierPath fill];
    }
}

@end
