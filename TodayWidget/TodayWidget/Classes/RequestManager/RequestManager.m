//
//  RequestManager.m
//  TodayExtension
//
//  Created by ggt on 2017/1/12.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "RequestManager.h"
#import "RequestURL.h"
#import "AFNetworking.h"

@implementation RequestManager

+ (void)requestHotMovieComplete:(Complete)complete {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"city" : @"深圳"};
    [manager GET:hotMovie parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        if (complete) {
            complete(responseObject, nil);
        };
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complete) {
            complete(nil, error);
        }
    }];
}

@end
