//
//  TableSectionExtraModel.h
//  TableViewDemo
//
//  Created by Wayne on 16/3/31.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TableSectionExtraModel : NSObject

@property (nullable, strong) Class regClass;   // Use to assign a class for table view section header or footer view.
@property (nullable, strong) id object; // It provides a data source for section header or footer view.

/**
 *  If you set the `regClass` and response the `height` in `TableUpdateProtocol`, the `height` property here will not be used.
 */
@property CGFloat height; // Default is CGFLOAT_MIN

@end
NS_ASSUME_NONNULL_END
