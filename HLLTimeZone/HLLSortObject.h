//
//  HLLSortObject.h
//  HLLTimeZone
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLSortObject : NSObject

- (void) sortUsingComparator:(NSComparator)cmptr;

//- (void) sortUsingComparator:(NSComparator)cmptr
//
//NSSortDescriptor * localeNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"localeName" ascending:YES comparator:^NSComparisonResult(NSString * localeName1,NSString * localeName2) {
//    return [localeName1 localizedStandardCompare:localeName2];
//}];
@end
