//
//  ViewController.m
//  TodayExtension
//
//  Created by ggt on 2017/1/12.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "RequestManager.h"
#import "MovieModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< tableView */
@property (nonatomic, strong) NSArray *dataSource; /**< 数据源 */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
}



#pragma mark - UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kCellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self requestData];
    }
}



#pragma mark - 懒加载

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(20);
        }];
    }
    
    return _tableView;
}

- (NSArray *)dataSource {
    
    if (_dataSource == nil) {
        _dataSource = @[@"正在热映", @"即将上映", @"Top250", @"口碑榜", @"北美票房榜", @"新片榜"];
    }
    
    return _dataSource;

}



#pragma mark - RequestData

/**
 请求数据
 */
- (void)requestData {
    
    [RequestManager requestHotMovieComplete:^(NSDictionary *data, NSError *error) {
        if (error) {
            NSLog(@"数据请求失败");
            return;
        }
        NSArray *dataArray = data[@"subjects"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            MovieModel *model = [MovieModel modelWithDict:dict];
            NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:model];
            [modelArray addObject:modelData];
        }
        [self savaDataWithArray:modelArray];
    }];
}


/**
 存储数据模型

 @param dataArray 数据模型数组
 */
- (void)savaDataWithArray:(NSArray *)dataArray {
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.id-bear"];
    [defaults setObject:dataArray forKey:@"hotMovie"];
    [defaults synchronize];
}

@end
