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

static NSString * const kTimeZoneCellIdentifier = @"timeZoneCellIdentifier";

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSArray * regions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _regions = [HLLRegion knownRegions];
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return self.regions.count;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    HLLRegion * region = self.regions[section];
    return region.name;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    HLLRegion * region = self.regions[section];
    if ([region.name isEqualToString:@"GMT"]) {

    }
    return region.timeZoneWrappers.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTimeZoneCellIdentifier forIndexPath:indexPath];
    
    HLLRegion * region = self.regions[indexPath.section];
    HLLTimeZoneWrapper * timeZoneWrapper = region.timeZoneWrappers[indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@",timeZoneWrapper.localeName ? : @" "];
    return cell;
}
@end
