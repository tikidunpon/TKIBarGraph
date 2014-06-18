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
    _totalVal      = 0;
    _animation     = YES;
}

#pragma mark - Getter
/*!return immutable TKIBarGraphItems */
- (NSArray *)items
{
    NSLog(@"%s",__func__);
    return [self.internalItems copy];
}

#pragma mark - Add Item
/*!set graphItem with item info */
- (void)addItemWithName:(NSString *)inName color:(UIColor *)inColor val:(CGFloat)inVal
{
    NSLog(@"%s",__func__);
    if ( !inName || !inColor )
    {
        return;
    }
    
    TKIBarGraphItem *item = [TKIBarGraphItem graphItemWithName:inName color:inColor val:inVal];
    [self.internalItems addObject:item];
    self.totalVal += item.val;
}

- (void)addItemWithName:(NSString *)inName dictionary:(NSDictionary *)inDict
{
    NSLog(@"%s",__func__);
    if ( !inName || !inDict )
    {
        return;
    }
    
    for (UIColor *inColorKey in [inDict allKeys])
    {
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
                                                                   val:[inVal floatValue]];
            [self.internalItems addObject:item];
            self.totalVal += item.val;
        }
    }
}

#pragma mark - Reset Item
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

#pragma mark - Update Item
/*!update item */
- (void)updateItemWithName:(NSString *)inName color:(UIColor *)inColor val:(CGFloat)inVal
{
    NSLog(@"%s",__func__);
    if ( !inName )
    {
        return;
    }
    
    for (TKIBarGraphItem *item in self.internalItems)
    {
        if ([item.name compare:inName options:0] == NSOrderedSame)
        {
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
    
    if ( !inName || !inDict )
    {
        return;
    }
    
    int i = 0;
    for (UIColor *inColorKey in [inDict allKeys])
    {
        if ( ![inColorKey isKindOfClass:[UIColor class]] ||
             ![[inDict objectForKey:inColorKey] isKindOfClass:[NSNumber class]])
        {
            return;
        }

        if (i > [self.internalItems count] - 1)
        {
            return;
        }
        
        TKIBarGraphItem *item = self.internalItems[i];
        
        NSNumber *inVal = inDict[inColorKey];
        
        if ([item.name compare:inName options:0] == NSOrderedSame)
        {
            item.color     = inColorKey;
            self.totalVal -= item.val;
            item.val       = [inVal floatValue];
            self.totalVal += item.val;
        }
        i++;
    }
}

#pragma mark - Calc and Draw BarGraph
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
        item.percentage  = ( item.val / self.totalVal);
        CGFloat barWidth = (CGRectGetWidth(baseRect) * item.percentage);
        item.fillRect    = CGRectMake( baseRect.origin.x + startPoint, baseRect.origin.y,
                                    barWidth, baseRect.size.height);
        startPoint += barWidth;
    }
}

- (void)drawBarGraph
{
    NSLog(@"%s",__func__);
    for ( TKIBarGraphItem *item in self.internalItems )
    {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:item.fillRect];
        [item.color setFill];
        [bezierPath fill];
    }
}

@end
