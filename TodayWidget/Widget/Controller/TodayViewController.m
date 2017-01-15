//
//  TodayViewController.m
//  Widget
//
//  Created by ggt on 2017/1/15.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import <NotificationCenter/NotificationCenter.h>
#import "AFNetworking.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#import "TodayViewController.h"
#import "MovieModel.h"
#import "MovieCell.h"

@interface TodayViewController () <NCWidgetProviding, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< tableView */
@property (nonatomic, strong) NSArray *dataSource; /**< 数据源 */

@end

@implementation TodayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self readData];
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 10.0f) {
        
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tableView];
}

#pragma mark - NCWidgetProviding

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {

    completionHandler(NCUpdateResultNewData);
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    
    self.preferredContentSize = maxSize;
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    
    return UIEdgeInsetsZero;
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [MovieCell cellWithTableView:tableView];
    
    MovieModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *str = [NSString stringWithFormat:@"TodayWidget://%ld", (long)indexPath.row];
    [self.extensionContext openURL:[NSURL URLWithString:str] completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"唤起App成功");
        }
    }];
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 55;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    return _tableView;

}

#pragma mark - Method

/**
 读取数据
 */
- (void)readData {
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.id-bear"];
    NSArray *dataArray = [defaults objectForKey:@"hotMovie"];
    for (NSData *modelData in dataArray) {
        MovieModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
        [array addObject:model];
    }
    self.dataSource = array;
    [self.tableView reloadData];
}

@end
