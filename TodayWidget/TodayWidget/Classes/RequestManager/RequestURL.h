//
//  RequestURL.h
//  TodayExtension
//
//  Created by ggt on 2017/1/12.
//  Copyright © 2017年 GGT. All rights reserved.
//

#ifndef RequestURL_h
#define RequestURL_h

/// 端口
#define hostString @"https://api.douban.com"

/// 热映
#define hotMovie [NSString stringWithFormat:@"%@/v2/movie/in_theaters", hostString]

/// 即将上映
#define coming_soon [NSString stringWithFormat:@"%@/v2/movie/coming_soon", hostString]

#endif /* RequestURL_h */
