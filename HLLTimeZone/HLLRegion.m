//
//  HLLRegion.m
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLRegion.h"
#import "HLLTimeZoneWrapper.h"

#define SortNameUseThisAPI

@interface HLLRegion ()

@property (nonatomic) NSMutableArray * mutableTimeZoneWrappers;

@end
@implementation HLLRegion

static NSMutableArray * knownRegions = nil;

- (NSArray *)timeZoneWrappers{

    return self.mutableTimeZoneWrappers;
}

+ (NSArray *)knownRegions{

    if (knownRegions == nil) {
        [self setupKnownRegions];
    }
    return knownRegions;
}

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        _mutableTimeZoneWrappers = [NSMutableArray array];
    }
    return self;
}

+ (void) setupKnownRegions{

    NSArray * knownTimeZoneNames = [NSTimeZone knownTimeZoneNames];
    NSMutableArray * regions = [NSMutableArray arrayWithCapacity:knownTimeZoneNames.count];
    
    for (NSString * timeZoneName in knownTimeZoneNames) {
        
        NSArray * fullTimeZoneNames = [timeZoneName componentsSeparatedByString:@"/"];
        NSString * regionName = fullTimeZoneNames[0];
        HLLRegion * region = nil;
        
        //防止重复添加Region
        for (HLLRegion * tempRegion in regions) {
            if ([tempRegion.name isEqualToString:regionName]) {
                region = tempRegion;
                break;
            }
        }
        if (region == nil) {
            region = [[HLLRegion alloc] initWithName:regionName];
            [regions addObject:region];
        }
        
        NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:timeZoneName];

        // fix bug，如果region的name是GMT的时候由于其没有timeZone，导致添加了一个空白的timeZone
        if (fullTimeZoneNames.count > 1) {
            
            HLLTimeZoneWrapper * timeZoneWrapper = [[HLLTimeZoneWrapper alloc] initWithTimeZone:timeZone fullTimeZoneNames:fullTimeZoneNames];
            
            [region addTimeZoneWrapper:timeZoneWrapper];
        }
    }
    
    // 使用排序对regions和相应的HLLRegion对象下的timeZone也进行排序
    
    // regions ,按照name升序排列
#ifdef SortNameUseThisAPI
    
    // or use this
    [regions sortUsingComparator:^NSComparisonResult(HLLRegion * region1,HLLRegion * region2) {
        return [region1.name localizedStandardCompare:region2.name];
    }];
    
#else
    
    NSSortDescriptor * nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES comparator:^NSComparisonResult(NSString * name1,NSString * name2) {
        return [name1 localizedStandardCompare:name2];
    }];
    
    [regions sortUsingDescriptors:@[nameSortDescriptor]];
    
#endif
    
    // HLLRegion对象下的timeZone，按照localeName排序
    NSSortDescriptor * localeNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"localeName" ascending:YES comparator:^NSComparisonResult(NSString * localeName1,NSString * localeName2) {
        return [localeName1 localizedStandardCompare:localeName2];
    }];
    for (HLLRegion * region in regions) {
        
#ifdef SortNameUseThisAPI
        
        [region.mutableTimeZoneWrappers sortUsingComparator:^NSComparisonResult(HLLTimeZoneWrapper * timeZone1,HLLTimeZoneWrapper * timeZone2) {
            return [timeZone1.localeName localizedStandardCompare:timeZone2.localeName];
        }];
        
#else
        
        [region.mutableTimeZoneWrappers sortUsingDescriptors:@[localeNameSortDescriptor]];
        
#endif
    }
    
    knownRegions = regions;
}

- (void) addTimeZoneWrapper:(HLLTimeZoneWrapper *)timeZoneWrapper{

    [self.mutableTimeZoneWrappers addObject:timeZoneWrapper];
}
@end
