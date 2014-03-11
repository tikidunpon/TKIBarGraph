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

/*!set graphItem with item info */
- (void)addItemName:(NSString *)inName color:(UIColor *)inColor val:(NSInteger)inVal;

/*!return immutable TKIBarGraphItems */
- (NSArray *)items;
@end