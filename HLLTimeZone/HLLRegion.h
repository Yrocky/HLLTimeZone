//
//  HLLRegion.h
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLRegion : NSObject

@property (nonatomic ,strong) NSString * name;

/**
 *  获得对应区域下的所有具体时区列表
 *
 *  @return 具体时区列表
 */
- (NSArray *) timeZoneWrappers;

/**
 *  使用HLLRegion的类方法获取已知时区列表
 *
 *  @return 已知时区列表
 */
+ (NSArray *)knownRegions;
@end
