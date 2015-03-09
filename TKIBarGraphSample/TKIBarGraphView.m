//
//  TKIBarGraph.m
//  TKIBarGraphSample
//
//  Created by 田中 幸一 on 2014/03/09.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import "TKIBarGraphView.h"
#import "TKIBarGraphItemView.h"
#import "TKIBarGraphItem.h"

@interface TKIBarGraphView ()

/** GraphItems total value. */
@property (nonatomic) CGFloat totalVal;

/** Array of TKIBarGraphItem. */
@property (nonatomic, strong) NSMutableArray *internalItems;

@end

@implementation TKIBarGraphView

#pragma mark - Initializer
- (void)awakeFromNib
{
    [self privateInit];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self privateInit];
    }
    return self;
}

/**
 * common initializer from nib/code.
 */
- (void)privateInit
{
    _internalItems = [[NSMutableArray alloc] init];
    _totalVal      = 0;
    _animated     = YES;
}

#pragma mark - Getter

/**
 * Return immutable TKIBarGraphItems.
 */
- (NSArray *)items
{
    return [self.internalItems copy];
}

/**
 * Return a TKIBarGraphItem.
 */
- (TKIBarGraphItem *)itemWithName:(NSString *)inName
{
    for ( TKIBarGraphItem *item in self.internalItems )
    {
        if( [item.name compare:inName] == NSOrderedSame )
        {
            return item;
        }
    }
    return nil;
}

/**
 * Return a rectangle for specified view by name.
 */
- (CGRect)rectWithName:(NSString *)inName
{
    for ( TKIBarGraphItem *item in self.internalItems )
    {
        if ([item.name compare:inName] == NSOrderedSame)
        {
            return item.rect;
        }
    }
    return CGRectZero;
}

#pragma mark - Add Item

/**
 * Set graphItem with item info.
 */
- (void)addItemWithName:(NSString *)inName color:(UIColor *)inColor val:(CGFloat)inVal
{
    if ( !inName || !inColor )
    {
        return;
    }
    
    TKIBarGraphItem *item = [TKIBarGraphItem graphItemWithName:inName color:inColor val:inVal];
    [self.internalItems addObject:item];
    self.totalVal += item.value;
}

#pragma mark - Reset Item
/*!Reset all items */
- (void)resetAllGraphItem
{
    if ([self.internalItems count] > 0)
    {
        [self.internalItems removeAllObjects];
        self.totalVal = 0;
    }
}

#pragma mark - Update Item

/*!Update item. */
- (void)updateItemWithName:(NSString *)inName val:(CGFloat)inValue
{
    [self updateItemWithName:inName color:nil val:inValue];
}

/*!Update item. */
- (void)updateItemWithName:(NSString *)inName color:(UIColor *)inColor val:(CGFloat)inValue
{
    if ( !inName )
    {
        return;
    }
    
    for (TKIBarGraphItem *item in self.internalItems)
    {
        if ([item.name compare:inName options:0] == NSOrderedSame)
        {
            item.color     = inColor ? inColor : item.color;
            self.totalVal -= item.value;
            
            item.value     = inValue;
            self.totalVal += item.value;
        }
    }
}

#pragma mark - Calc and Draw BarGraph

- (void)drawRect:(CGRect)rect
{
    [self calcFillRect:rect];
    
    [self addBarGraphItemView];
    
    [self update];
}

- (void)calcFillRect:(CGRect)baseRect
{
    if ( [self.items count] <= 0 )
    {
        return;
    }
    
    // calc and set percentage to barGraphItems
    CGFloat nextItemOffsetX = 0;
    
    for ( TKIBarGraphItem *item in self.internalItems )
    {
        item.percentage  = ( item.value / self.totalVal );
        
        CGFloat barWidth = (CGRectGetWidth(baseRect) * item.percentage);
        
        item.rect        =  CGRectMake( baseRect.origin.x + nextItemOffsetX,
                                        baseRect.origin.y,
                                        barWidth,
                                        baseRect.size.height);
        nextItemOffsetX += barWidth;
    }
}

- (void)addBarGraphItemView
{
    if ([self.subviews count] > 0)
    {
        return;
    }
    
    // item has rect for drawing.
    for ( TKIBarGraphItem *item in self.internalItems )
    {
        @autoreleasepool
        {
            TKIBarGraphItemView *v = [[TKIBarGraphItemView alloc] initWithFrame:item.rect];
            [v setBackgroundColor:item.color];
            [v setName:item.name];
            [self addSubview:v];
        }
    }
}

- (void)update
{
    if (self.animated)
    {
        [UIView animateWithDuration:0.5 animations:^{
            [self updateAllItem];
        }];
    }
    else
    {
        [self updateAllItem];
    }
}

- (void)updateAllItem
{
    for ( TKIBarGraphItemView *itemView in self.subviews )
    {
        for ( TKIBarGraphItem *item in self.internalItems )
        {
            if ( [itemView.name compare:item.name] == NSOrderedSame )
            {
                itemView.frame = item.rect;
                [itemView setBackgroundColor:item.color];
            }
        }
    }
}

@end
