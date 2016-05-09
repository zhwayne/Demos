//
//  ViewController.m
//  JavaScriptCoreDemo
//
//  Created by Wayne on 16/3/21.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()
<
WKNavigationDelegate
>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation ViewController

- (void)awakeFromNib {
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(raload)]];
    
    
    [self.view addSubview:self.webView];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[webView]-0-|"
                               options:0
                               metrics:nil
                               views:_NSDictionaryOfVariableBindings(@"webView", self.webView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[webView]-0-|"
                               options:0
                               metrics:nil
                               views:_NSDictionaryOfVariableBindings(@"webView", self.webView)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://test.zhwayne.com"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.f]];
}

#pragma mark - Getter

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.backgroundColor =[UIColor magentaColor];
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        _webView.navigationDelegate = self;
    }
    
    return _webView;
}

#pragma mark -

- (void)raload {
    NSLog(@"asdf");
}

#pragma mark -

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (webView.title) {
        self.title = webView.title;
    }
}

@end
