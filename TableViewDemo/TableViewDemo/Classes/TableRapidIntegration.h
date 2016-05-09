//
//  TableRapidIntegration.h
//  TableViewDemo
//
//  Created by Wayne on 16/3/31.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TableUpdateProtocol.h"
#import "TableSectionModel.h"
#import "TableSectionExtraModel.h"
#import "TableCellModel.h"


@interface TableRapidIntegration : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray <TableSectionModel *>*sectionItems;   // Model for every section in a table view.

@end
