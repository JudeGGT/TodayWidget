//
//  MovieCell.m
//  TodayWidget
//
//  Created by ggt on 2017/1/15.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "MovieCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#import "MovieModel.h"

#define kTopBottom 2
#define kLeft 10

#define kFont 14

@interface MovieCell ()

@property (nonatomic, weak) UIImageView *movieImageView; /**< 电影图片 */
@property (nonatomic, weak) UILabel *movieNameLabel; /**< 电影名 */
@property (nonatomic, weak) UILabel *castsLabel; /**< 演员 */
@property (nonatomic, weak) UILabel *averageLabel; /**< 分数 */
@property (nonatomic, weak) UILabel *yearLabel; /**< 电影年份 */

@end

@implementation MovieCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"MovieCell";
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MovieCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setConstraints];
    }
    
    return self;
}

#pragma mark - UI


- (void)setupUI {
    
    // 1.电影图片
    UIImageView *movieImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:movieImageView];
    self.movieImageView = movieImageView;
    
    // 2.电影名字
    UILabel *movieNameLabel = [[UILabel alloc] init];
    movieNameLabel.font = [UIFont systemFontOfSize:kFont];
    movieNameLabel.numberOfLines = 0;
    [self.contentView addSubview:movieNameLabel];
    self.movieNameLabel = movieNameLabel;
    
    // 3.演员
    UILabel *castsLabel = [[UILabel alloc] init];
    castsLabel.font = [UIFont systemFontOfSize:12];
    castsLabel.numberOfLines = 0;
    castsLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
    [self.contentView addSubview:castsLabel];
    self.castsLabel = castsLabel;
    
    // 4.分数
    UILabel *averageLabel = [[UILabel alloc] init];
    averageLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:averageLabel];
    self.averageLabel = averageLabel;
    
    // 5.电影年份
    UILabel *yearLabel = [[UILabel alloc] init];
    yearLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:yearLabel];
    self.yearLabel = yearLabel;
}

#pragma mark - Constraints

- (void)setConstraints {
    
    // 1.电影图片
    [self.movieImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kLeft);
        make.top.equalTo(self.contentView).offset(kTopBottom);
        make.bottom.equalTo(self.contentView).offset(-kTopBottom);
        make.width.mas_equalTo(50);
    }];
    
    // 2.评分
    [self.averageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.yearLabel);
        make.top.equalTo(self.movieImageView);
    }];
    
    // 3.年份
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.movieImageView);
    }];
    
    // 4.电影名字
    [self.movieNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.movieImageView);
        make.left.equalTo(self.movieImageView.mas_right).offset(10);
        make.right.equalTo(self.yearLabel.mas_left).offset(-10);
    }];
    
    // 5.演员
    [self.castsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.movieNameLabel.mas_bottom);
        make.left.right.equalTo(self.movieNameLabel);
        make.bottom.equalTo(self.movieImageView);
    }];
    
    
}

- (void)setModel:(MovieModel *)model {
    
    _model = model;
    
    // 1.电影图片
    [self.movieImageView sd_setImageWithURL:[NSURL URLWithString:model.imgURL]];
    
    // 2.电影名字
    self.movieNameLabel.text = model.title;
    
    // 3.演员
    self.castsLabel.text = model.casts;
    
    // 4.分数
    self.averageLabel.text = [NSString stringWithFormat:@"%.1lf", [model.average floatValue]];
    
    // 5.年份
    NSInteger width = ceil([model.year boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.width);
    self.yearLabel.text = model.year;
    [self.yearLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
}

@end
