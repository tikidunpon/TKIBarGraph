//
//  TKIBarGraph.h
//  TKIBarGraphSample
//
//  Created by 田中 幸一 on 2014/03/09.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class       TKIBarGraph
 @abstract    class for draw simple bar graph.
 */
@interface TKIBarGraphView : UIView

@property (nonatomic) BOOL animation;

/*!set graphItem with item info */
- (void)addItemWithName:(NSString *)inName color:(UIColor *)inColor val:(CGFloat)inVal;

/*!return immutable TKIBarGraphItems */
- (NSArray *)items;

/*!reset all items */
- (void)resetAllGraphItem;

/*!update item */
- (void)updateItemWithName:(NSString *)inName color:(UIColor *)inColor val:(CGFloat)inVal;

@end
