//
//  RequestManager.h
//  TodayExtension
//
//  Created by ggt on 2017/1/12.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Complete)(NSDictionary *data, NSError *error);

@interface RequestManager : NSObject

+ (void)requestHotMovieComplete:(Complete)complete;

@end
