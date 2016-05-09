//
//  NameCell.m
//  TableViewDemo
//
//  Created by Wayne on 16/3/26.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "NameCell.h"

@implementation NameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    
    return self;
}


- (void)updateContentWithObject:(id)object {
    self.textLabel.text = object[@"name"];
}

@end
