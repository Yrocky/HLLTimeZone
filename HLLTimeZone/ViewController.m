//
//  ViewController.m
//  HLLTimeZone
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"
#import "HLLRegion.h"
#import "HLLTimeZoneWrapper.h"
#import "HLLTimeZoneManager.h"

#import "HLLSortA_ZDataSource.h"
#import "HLLSortObject.h"

#define SortA_ZDataSource

static NSString * const kTimeZoneCellIdentifier = @"timeZoneCellIdentifier";

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableDictionary * timeZoneDatas;
@property (nonatomic) HLLSortA_ZDataSource * dataSource;
@property (nonatomic) NSArray * regions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#ifdef SortA_ZDataSource
    
    _dataSource = [[HLLSortA_ZDataSource alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[_dataSource cellIdentifier]];
    
    self.tableView.dataSource = _dataSource;

#else
    
    _timeZoneDatas = [NSMutableDictionary dictionary];
    
    NSArray * allTimeZones = [[HLLTimeZoneManager shareTimeZoneManager] allTimeZones];
    
    HLLSortObject * sort = [[HLLSortObject alloc] init];
    
    NSDictionary * sortDictionary = [sort sortCollection:allTimeZones
                        forEachObjectFromAToZWithKeyPath:@"localeName"];
    
    _timeZoneDatas = [NSMutableDictionary dictionaryWithDictionary:sortDictionary];
    
    NSArray * allKeys = [sort sortCollectioinAscendingOrder:self.timeZoneDatas.allKeys];
    
    _regions = allKeys;
    
    self.tableView = self;
#endif
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return self.regions.count;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.regions[section];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * timeZones = [self.timeZoneDatas objectForKey:self.regions[section]];
    return timeZones.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTimeZoneCellIdentifier forIndexPath:indexPath];
    
    NSArray * timeZones = [self.timeZoneDatas objectForKey:self.regions[indexPath.section]];
    HLLTimeZoneWrapper * timeZoneWrapper = timeZones[indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZoneWrapper.localeName ? : @" "];
    return cell;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.regions;
}
@end
