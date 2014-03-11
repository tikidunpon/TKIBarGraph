//
//  TKITableCell.h
//  TKIBarGraphSample
//
//  Created by 田中 幸一 on 2014/03/09.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKIBarGraphView.h"

@interface TKITableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet TKIBarGraphView *barGraphView;
@end
