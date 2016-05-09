//
//  TableRapidIntegration.m
//  TableViewDemo
//
//  Created by Wayne on 16/3/31.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "TableRapidIntegration.h"
#import <objc/runtime.h>
#import "TableCellModel.h"
#import "TableSectionModel.h"
#import "TableUpdateProtocol.h"

@implementation TableRapidIntegration

//static char *cellSectionModelsKey = "cellSectionModelsKey";
//
//- (void)setSectionItems:(NSArray<TableSectionModel *> *)sectionItems {
//
//    objc_setAssociatedObject(self, cellSectionModelsKey, sectionItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (NSArray<TableSectionModel *> *)sectionItems {
//
//    return objc_getAssociatedObject(self, cellSectionModelsKey);
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TableSectionModel *sectionModel = self.sectionItems[section];
    return sectionModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableSectionModel *sectionModel = self.sectionItems[indexPath.section];
    TableCellModel *rowModel = sectionModel.items[indexPath.row];
    
    NSCAssert(rowModel.regClass, @"Need to assign regClass for TableCellModel.");
    
    UITableViewCell <TableUpdateProtocol>* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(rowModel.regClass)];
    
    if ([cell respondsToSelector:@selector(updateContentWithObject:)]) {
        [cell updateContentWithObject:rowModel.object];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    TableSectionExtraModel *sectionExtraModel = ((TableSectionModel *)self.sectionItems[section]).header;
    return [self _sectionExtraViewWithTableView:tableView sectionExtraModel:sectionExtraModel];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    TableSectionExtraModel *sectionExtraModel = ((TableSectionModel *)self.sectionItems[section]).footer;
    return [self _sectionExtraViewWithTableView:tableView sectionExtraModel:sectionExtraModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    TableSectionExtraModel *sectionExtraModel = ((TableSectionModel *)self.sectionItems[section]).header;
    return [self _sectionExtraHeightWithTableView:tableView sectionExtraModel:sectionExtraModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    TableSectionExtraModel *sectionExtraModel = ((TableSectionModel *)self.sectionItems[section]).footer;
    return [self _sectionExtraHeightWithTableView:tableView sectionExtraModel:sectionExtraModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableSectionModel *sectionModel = self.sectionItems[indexPath.section];
    TableCellModel *rowModel = sectionModel.items[indexPath.row];
    
    if (rowModel.regClass) {
        UITableViewCell <TableUpdateProtocol>*cell = [self _templateCellForReuseIdentifier:NSStringFromClass(rowModel.regClass) tableView:tableView];
        if ([cell respondsToSelector:@selector(theHeight)]) {
            return cell.theHeight;
        }
        
        if (rowModel.heightWithBlock) {
            return rowModel.heightWithBlock(tableView, indexPath);
        }
        
        return rowModel.height;
    }
    
    return rowModel.height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell <TableUpdateProtocol>* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(didSelected)]) {
        [cell didSelected];
    }
    else {
        TableSectionModel *sectionModel = self.sectionItems[indexPath.section];
        TableCellModel *rowModel = sectionModel.items[indexPath.row];
        
        if (rowModel.didSelectedAction) {
            rowModel.didSelectedAction(tableView, indexPath);
        }
    }
}


#pragma mark - Private

- (UIView *)_sectionExtraViewWithTableView:(UITableView *)tableView sectionExtraModel:(TableSectionExtraModel *)sectionExtraModel {
    if (sectionExtraModel.regClass) {
        UIView <TableUpdateProtocol>*view = (UIView <TableUpdateProtocol>*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(sectionExtraModel.regClass)];
        if ([view respondsToSelector:@selector(updateContentWithObject:)]) {
            [view updateContentWithObject:sectionExtraModel.object];
        }
        return view;
    }
    
    return [[UIView alloc] init];
}

- (CGFloat)_sectionExtraHeightWithTableView:(UITableView *)tableView sectionExtraModel:(TableSectionExtraModel *)sectionExtraModel {
    if (sectionExtraModel.regClass) {
        UIView <TableUpdateProtocol>*view = [self _templateHeaderFooterViewForReuseIdentifier:NSStringFromClass(sectionExtraModel.regClass) tableView:tableView];
        if ([view respondsToSelector:@selector(theHeight)]) {
            return view.theHeight;
        }
        
        return sectionExtraModel.height;
    }
    
    return sectionExtraModel.height;
}


- (id)_templateCellForReuseIdentifier:(NSString *)identifier tableView:(UITableView *)tableView {
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    NSMutableDictionary *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    
    if (!templateCell) {
        templateCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        NSAssert(templateCell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateCellsByIdentifiers[identifier] = templateCell;
    }
    
    return templateCell;
}

- (id)_templateHeaderFooterViewForReuseIdentifier:(NSString *)identifier tableView:(UITableView *)tableView {
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    NSMutableDictionary *templateHeaderFooterViewsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateHeaderFooterViewsByIdentifiers) {
        templateHeaderFooterViewsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateHeaderFooterViewsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UIView *templateView= templateHeaderFooterViewsByIdentifiers[identifier];
    
    if (!templateView) {
        templateView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        NSAssert(templateView != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        templateView.translatesAutoresizingMaskIntoConstraints = NO;
        templateHeaderFooterViewsByIdentifiers[identifier] = templateView;
    }
    
    return templateView;
}

@end
