//
//  ViewController.m
//  Autolayout
//
//  Created by ByRongInvest on 16/1/19.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.label1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(10));
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
