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
    [self privateInit];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self privateInit];
    }
    return self;
}

- (void)privateInit
{
    _internalItems = [[NSMutableArray alloc] init];
    _totalVal = 0;
}

/*!set graphItem with item info */
- (void)addItemName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal
{
    if ( !inName || !inColor ) {
        return;
    }
    TKIBarGraphItem *item = [TKIBarGraphItem graphItemWithName:inName color:inColor val:inVal];
    [self.internalItems addObject:item];
    self.totalVal += item.val;
}

/*!return immutable TKIBarGraphItems */
- (NSArray *)items
{
    return [self.internalItems copy];
}

/*!reset all items */
- (void)resetAllGraphItem
{
    if ([self.internalItems count] > 0)
    {
        [self.internalItems removeAllObjects];
        self.totalVal = 0;
    }
}

- (void)drawRect:(CGRect)rect
{
    [self calcFillRect:rect];
    
    [self drawBarGraph];
}

#pragma mark - Private Methods
- (void)calcFillRect:(CGRect)baseRect
{
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
    for ( TKIBarGraphItem *item in self.internalItems ) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:item.fillRect];
        [item.color setFill];
        [bezierPath fill];
    }
}

@end
