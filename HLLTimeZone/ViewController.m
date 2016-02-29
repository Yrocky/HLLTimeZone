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

#import "HLLSortRegionsDataSource.h"
#import "HLLSortA_ZDataSource.h"
#import "HLLSortObject.h"
#import "HLLSortLocalizedIndexedCollationDataSource.h"

#define SortA_ZDataSource

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong) id<UITableViewDataSource,HLLSortProtocol> dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HLLSortLocalizedIndexedCollationDataSource * locaitonIndexCollectionDataSource = [[HLLSortLocalizedIndexedCollationDataSource alloc] init];

    [self setupTableViewDataSource:locaitonIndexCollectionDataSource];
    
#ifdef SortA_ZDataSource
    
//    HLLSortA_ZDataSource * _A_ZDataSource = [[HLLSortA_ZDataSource alloc] init];
//    
//    [self setupTableViewDataSource:_A_ZDataSource];
#else
    
    HLLSortRegionsDataSource * _regionDataSource  = [[HLLSortRegionsDataSource alloc] init];
    
    [self setupTableViewDataSource:_regionDataSource];

#endif
}

- (void) setupTableViewDataSource:(id<UITableViewDataSource,HLLSortProtocol>)dataSource{

    _dataSource = dataSource;
    
    self.title = [dataSource name];
    
    self.navigationItem.title = [dataSource navigationBarName];
    
    self.tableView.dataSource = dataSource;
    
    [self.tableView registerClass:[dataSource cellClass] forCellReuseIdentifier:[dataSource cellIdentifier]];
}
@end
