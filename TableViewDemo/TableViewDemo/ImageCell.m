//
//  ImageCell.m
//  TableViewDemo
//
//  Created by Wayne on 16/3/26.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell
@synthesize theHeight;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    
    return self;
}

- (CGFloat)theHeight {
    return 100;
}

- (void)updateContentWithObject:(id)object {
    self.imageView.image = createImage((UIColor *)object, CGSizeMake(24, 24));
}


UIImage* createImage(UIColor *color, CGSize size)
{
    CGRect rect= CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
