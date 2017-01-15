//
//  MovieModel.h
//  TodayExtension
//
//  Created by ggt on 2017/1/12.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *imgURL; /**< 图片链接 */
@property (nonatomic, copy) NSString *title; /**< 电影名 */
@property (nonatomic, copy) NSString *casts; /**< 演员 */
@property (nonatomic, strong) NSNumber *average; /**< 分数 */
@property (nonatomic, copy) NSString *year; /**< 年份 */

+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
