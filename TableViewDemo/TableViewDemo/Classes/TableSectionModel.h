//
//  TableSectionModel.h
//  TableViewDemo
//
//  Created by Wayne on 16/3/31.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TableSectionExtraModel.h"

@class TableCellModel;

NS_ASSUME_NONNULL_BEGIN
@interface TableSectionModel : NSObject

@property (strong) TableSectionExtraModel *header;  // Model for section header.
@property (strong) TableSectionExtraModel *footer;  // Model for section footer.
@property (nullable, strong) NSArray <TableCellModel *>*items;  // Models for cells

@end
NS_ASSUME_NONNULL_END
