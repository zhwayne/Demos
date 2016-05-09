//
//  AppDelegate.m
//  test
//
//  Created by ByRongInvest on 15/12/7.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] message:[NSString stringWithFormat:@"url:%@\nsourceApplication:%@\nannotation:%@", url, sourceApplication, annotation] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] message:[NSString stringWithFormat:@"url:%@\noptions:%@", url, options] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    return YES;
}

@end
