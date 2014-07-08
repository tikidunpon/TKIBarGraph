//
//  TKIBarGraph.h
//  TKIBarGraphSample
//
//  Created by 田中 幸一 on 2014/03/09.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKIBarGraphItem.h"

/*!
 @class       TKIBarGraph
 @abstract    Class for draw simple bar graph.
 */
@interface TKIBarGraphView : UIView

@property (nonatomic) BOOL animated;

/*! Return immutable TKIBarGraphItems */
- (NSArray *)items;

/*! Return a TKIBarGraphItem */
- (TKIBarGraphItem *)itemWithName:(NSString *)inName;

/*! Return a rectangle for specified view by name. 
 *  Returns CGRectZero if name is not found.
 */
- (CGRect)rectWithName:(NSString *)inName;

/*! Reset all items */
- (void)resetAllGraphItem;

/*! Set graphItem with item info */
- (void)addItemWithName:(NSString *)inName color:(UIColor *)inColor val:(CGFloat)inVal;

/*! Update item */
- (void)updateItemWithName:(NSString *)inName val:(CGFloat)inValue;
- (void)updateItemWithName:(NSString *)inName color:(UIColor *)inColor val:(CGFloat)inValue;

@end
