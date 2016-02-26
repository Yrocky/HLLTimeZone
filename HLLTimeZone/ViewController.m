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
#import "HLLTimeZoneConfigure.h"

static NSString * const kTimeZoneCellIdentifier = @"timeZoneCellIdentifier";

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableDictionary * timeZoneDatas;
@property (nonatomic) NSArray * regions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timeZoneDatas = [NSMutableDictionary dictionary];

    
    NSArray * allTimeZones = [[HLLTimeZoneConfigure shareTimeZoneConfigure] allTimeZones];
    
    for (HLLTimeZoneWrapper * timeZone in allTimeZones) {
        
        if (timeZone.localeName != nil) {
            
            NSString * strFirLetter = [self _letterOrderWithTimeZoneLocaleName:timeZone.localeName];

            NSAssert(strFirLetter != nil, @"'strFirLetter' Cant be nil");
            if ([[_timeZoneDatas allKeys] containsObject:strFirLetter]) {
                [[_timeZoneDatas objectForKey:strFirLetter] addObject:timeZone];
            }else{
                NSMutableArray * tempArray = [NSMutableArray array];
                [tempArray addObject:timeZone];
                [_timeZoneDatas setObject:tempArray forKey:strFirLetter];
            }
        }
    }
    
    NSLog(@"data:%@",_timeZoneDatas);
    
    NSArray * allkeys = [self.timeZoneDatas.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString * key1 ,NSString * key2) {
        return [key1 localizedStandardCompare:key2];
    }];
    _regions = allkeys;
}

/**
 *  根据英文字母进行归类
 *
 *  @param localeName 时区的localeName
 *
 *  @return 时区的localeName的首字母
 */
- (NSString *) _letterOrderWithTimeZoneLocaleName:(NSString *)localeName{
    
    //判断首字符是否为字母，由于这里全部是字母，所以把汉字分支去掉了
    NSString * regex = @"[A-Za-z]+";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    NSString * initialStr = [localeName length]?[localeName  substringToIndex:1]:@"";
    
    NSString * strFirLetter;
    if ([predicate evaluateWithObject:initialStr])
    {
        //首字母大写
        strFirLetter = [initialStr capitalizedString];
    }
    return strFirLetter;
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

@end
