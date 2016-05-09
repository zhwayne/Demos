//
//  ViewController.m
//  TableViewDemo
//
//  Created by Wayne on 16/3/25.
//  Copyright (c) 2016 Wayne. All rights reserved.
//


#import "ViewController.h"
#import "TableRapidIntegration.h"
#import "NameCell.h"
#import "ImageCell.h"

@interface ViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TableRapidIntegration *ri;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    
    TableCellModel *rModel1 = [[TableCellModel alloc] init];
    rModel1.regClass = [NameCell class];
    rModel1.object = @{@"name": @"zhwayne"};
    rModel1.height = 60;
    
    TableCellModel *rModel2 = [[TableCellModel alloc] init];
    rModel2.regClass = [NameCell class];
    rModel2.object = @{@"name": @"hlzz"};
    
    TableSectionExtraModel *exModel = [[TableSectionExtraModel alloc] init];
    exModel.height = CGFLOAT_MIN;
    
    TableSectionExtraModel *exModel2 = [[TableSectionExtraModel alloc] init];
    exModel2.height = 20;
    
    TableSectionModel *sModel1 = [[TableSectionModel alloc] init];
    sModel1.items = @[rModel1, rModel2];
    sModel1.header = exModel;
    sModel1.footer = exModel2;
    
    ///
    TableCellModel *rModel11 = [[TableCellModel alloc] init];
    rModel11.regClass = [ImageCell class];
    rModel11.object = [UIColor magentaColor];
    
    TableCellModel *rModel12 = [[TableCellModel alloc] init];
    rModel12.regClass = [ImageCell class];
    rModel12.object = [UIColor orangeColor];
    rModel12.didSelectedAction = ^(UITableView *tableView, NSIndexPath *indexPath) {
        NSLog(@"%@", indexPath.description);
    };
    
    TableSectionModel *sModel2 = [[TableSectionModel alloc] init];
    sModel2.items = @[rModel11, rModel12];
    
    self.ri.sectionItems = @[sModel1, sModel2];
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
        _tableView.delegate = self.ri;
        _tableView.dataSource = self.ri
        ;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[NameCell class] forCellReuseIdentifier:@"NameCell"];
        [_tableView registerClass:[ImageCell class] forCellReuseIdentifier:@"ImageCell"];
    }

    return _tableView;
}

- (TableRapidIntegration *)ri {
    if (!_ri) {
        _ri = [[TableRapidIntegration alloc] init];
    }
    
    return _ri;
}


@end
