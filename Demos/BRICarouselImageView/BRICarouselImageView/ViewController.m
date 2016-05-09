//
//  ViewController.m
//  BRICarouselImageView
//
//  Created by ByRongInvest on 15/11/26.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import "ViewController.h"
#import "BRICarouselImageView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BRICarouselImageView *v;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_v setImages:@[@"http://h.hiphotos.baidu.com/image/w%3D310/sign=c4afa47ff01fbe091c5ec5155b610c30/a044ad345982b2b76fc6a2cd33adcbef76099b5a.jpg",
                    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=db54e4050ed79123e0e092759d355917/f2deb48f8c5494eee1cbbb142ff5e0fe98257ed5.jpg",
                    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=e490b7316c061d957d4631394bf50a5d/f7246b600c338744a669e175530fd9f9d72aa00f.jpg"]];
    _v.autoScroll = YES;
    _v.delayTimeInterval = 1;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
