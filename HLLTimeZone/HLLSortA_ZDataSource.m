//
//  HLLSortA_ZDataSource.m
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLSortA_ZDataSource.h"
#import "TimeZone/HLLTimeZoneManager.h"
#import "TimeZone/HLLTimeZoneWrapper.h"
#import "TimeZone/HLLRegion.h"


@interface HLLSortA_ZDataSource ()

@property (nonatomic) NSArray * regions;

@end

@implementation HLLSortA_ZDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSArray * knownRegions = [[HLLTimeZoneManager shareTimeZoneManager] knownRegions];
        
        NSLog(@"%@",knownRegions);
        
        _regions = knownRegions;
    }
    return self;
}

- (NSString *)cellIdentifier{

    return @"SortA_ZDataSource";
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    HLLRegion * region = self.regions[section];
    return [region.timeZoneWrappers count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return [self.regions count];
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    HLLRegion * region = self.regions[section];
    return region.name;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    HLLRegion * region = self.regions[indexPath.section];
    HLLTimeZoneWrapper * timeZoneWrapper = region.timeZoneWrappers[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZoneWrapper.localeName ? : @" "];
    
    return cell;
}
@end
