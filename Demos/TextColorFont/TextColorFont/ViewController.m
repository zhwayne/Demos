//
//  ViewController.m
//  TextColorFont
//
//  Created by ByRongInvest on 16/1/7.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableAttributedString+StyleSet.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableAttributedString *attrStr = [NSMutableAttributedString ss_string:self.label.text];
    [attrStr ss_addFont:[UIFont systemFontOfSize:34]
                            color:[UIColor greenColor]
                            range:NSMakeRange(2, 4)];
    [attrStr ss_addStrikeoutWithRange:NSMakeRange(1, 7)];
    [attrStr ss_addFont:[UIFont boldSystemFontOfSize:44] indexFromTheEnd:15];
    self.label.attributedText = attrStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
