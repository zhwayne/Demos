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
UIWebViewDelegate
>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation ViewController

- (void)awakeFromNib {
    
    
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
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.201:8080/user/lightupMain.html"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.f]];
}

#pragma mark - Getter

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.backgroundColor =[UIColor magentaColor];
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        _webView.delegate = self;
    }
    
    return _webView;
}

#pragma mark -

- (void)raload {
    [self.webView reload];
}

#pragma mark - Web view delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.navigationItem.rightBarButtonItems = nil;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(raload)]];
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *titleJS = @"document.title";
    self.title = [[context evaluateScript:titleJS] toString];

    context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"%@", exception);
        con.exception = exception;
    };

    NSLog(@"%@", [context evaluateScript:@"getShareLink()"]);
}

@end
