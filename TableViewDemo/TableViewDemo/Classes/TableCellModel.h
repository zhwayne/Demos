//
//  TableCellModel.h
//  TableViewDemo
//
//  Created by Wayne on 16/3/31.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TableCellModel : NSObject

@property (strong) Class regClass;  // Use to assign a class for table view cell.
@property (nullable, strong) id object; // It provides a data source for cell.

/**
 *  If you set the `regClass` and response the `height` in `TableUpdateProtocol`, the `height` property here will not be used.
 */
@property CGFloat height;   // Default is 44.
@property (nullable) CGFloat (^heightWithBlock)(UITableView *, NSIndexPath *);   // Default return 44.

@property (nullable, copy) void (^didSelectedAction)(UITableView *, NSIndexPath *);

@end
NS_ASSUME_NONNULL_END