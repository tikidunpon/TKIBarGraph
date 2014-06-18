//
//  TKIViewController.m
//  TKIBarGraphSample
//
//  Created by 田中 幸一 on 2014/03/09.
//  Copyright (c) 2014年 xxx. All rights reserved.
//

#import "TKIViewController.h"
#import "TKITableCell.h"
#import "TKIBarGraphItem.h"

@interface TKIViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@end

@implementation TKIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKITableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if ( [cell.barGraphView.items count] > 0 )
    {
        return cell;
    }
    
    if (indexPath.row == 0) {
        [cell.barGraphView addItemWithName:@"Test1" color:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.4] val:10];
        [cell.barGraphView addItemWithName:@"Test2" color:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.6] val:20];
        [cell.barGraphView addItemWithName:@"Test3" color:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.8] val:30];
        [cell.barGraphView addItemWithName:@"Test4" color:[UIColor yellowColor] val:2];
    }
    else
    {
        [cell.barGraphView addItemWithName:@"Test1" dictionary:@{ [UIColor redColor]   : @10,
                                                                  [UIColor greenColor] : @10,
                                                                  [UIColor blueColor]  : @10}];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 選択されたセル内のバーグラフアイテムを取得
    TKITableCell    *cell          = (TKITableCell *)[tableView cellForRowAtIndexPath:indexPath];
    TKIBarGraphItem *barGraphItem  = cell.barGraphView.items[2];
    
    // バーグラフを更新
    // [cell.barGraphView updateItemWithName:@"Test1" color:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.4] val:barGraphItem.val + 20];
    NSNumber *updateVal = [NSNumber numberWithInteger:(barGraphItem.val + 10)];
    [cell.barGraphView updateItemWithName:@"Test1" dictionary:@{ [UIColor redColor]   : updateVal,
                                                                 [UIColor greenColor] : @10,
                                                                 [UIColor blueColor]  : @10 }];
    [cell.barGraphView setNeedsDisplay];
}

@end
