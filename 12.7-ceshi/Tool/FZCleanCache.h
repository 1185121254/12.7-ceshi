//
//  FZCleanCache.h
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/15.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^cleanCacheBlock)(void);

@interface FZCleanCache : NSObject

/**
 *  清理缓存
 */
+(void)cleanCache:(cleanCacheBlock)block;
/**
 *  整个缓存目录的大小
 */
+(float)folderSizeAtPath;


@end
