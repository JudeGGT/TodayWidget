
//
//  MovieModel.m
//  TodayExtension
//
//  Created by ggt on 2017/1/12.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "MovieModel.h"
#import <objc/runtime.h>

@implementation MovieModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"casts"]) {
        NSMutableString *castsValue = [NSMutableString string];
        if (![value isKindOfClass:NSClassFromString(@"NSString")]) {
            for (NSDictionary *dict in value) {
                [castsValue appendString:dict[@"name"]];
                [castsValue appendString:@"  "];
            }
            value = castsValue;
        }
    } else if ([key isEqualToString:@"images"]) {
        key = @"imgURL";
        value = value[@"large"];
    } else if ([key isEqualToString:@"rating"]) {
        key = @"average";
        value = value[@"average"];
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

/**
 *  归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count;
    
    // 获得指向当前类的所有属性的指针
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        // 获取指向当前类的一个属性的指针
        objc_property_t property = properties[i];
        // 获取C字符串属性名
        const char *name = property_getName(property);
        // C字符串转OC字符串
        NSString *propertyName = [NSString stringWithUTF8String:name];
        // 通过关键词取值
        NSString *propertyValue = [self valueForKeyPath:propertyName];
        // 编码属性
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
    free(properties);
}


/**
 *  解档
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        unsigned int count;
        // 获得指向当前类的所有属性的指针
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            // 获取指向当前类的一个属性的指针
            objc_property_t property = properties[i];
            // 获取C字符串的属性名
            const char *name = property_getName(property);
            // C字符串转OC字符串
            NSString *propertyName = [NSString stringWithUTF8String:name];
            // 解码属性值
            NSString *propertyValue = [aDecoder decodeObjectForKey:propertyName];
            [self setValue:propertyValue forKey:propertyName];
        }
        // 记得释放
        free(properties);
    }
    
    return self;
}

@end
