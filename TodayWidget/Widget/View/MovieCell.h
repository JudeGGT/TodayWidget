//
//  MovieCell.h
//  TodayWidget
//
//  Created by ggt on 2017/1/15.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieModel;

@interface MovieCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) MovieModel *model; /**< 模型 */

@end
