//
//  ViewController.m
//  HLLTimeZone
//
//  Created by admin on 16/2/25.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"

static NSString * const kTimeZoneCellIdentifier = @"timeZoneCellIdentifier";

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSArray * timeZones;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTimeZoneCellIdentifier];
    NSArray * timeZones = [NSTimeZone knownTimeZoneNames];
    _timeZones = timeZones;
}

#pragma mark - UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return self.timeZones.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTimeZoneCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.timeZones[indexPath.row]];
    return cell;
}
@end
