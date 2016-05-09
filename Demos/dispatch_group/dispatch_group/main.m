//
//  main.m
//  dispatch_group
//
//  Created by ByRongInvest on 15/12/4.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Start");
        
        dispatch_group_t myGroup = dispatch_group_create();
        
        dispatch_group_enter(myGroup);
        dispatch_async(dispatch_queue_create("myq", 0), ^{
            NSLog(@"t1 doing...");
            [NSThread sleepForTimeInterval:6];
            
//            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"t1 done");
                
                dispatch_group_leave(myGroup);
//            });
        });
        
        
        dispatch_group_enter(myGroup);
        dispatch_async(dispatch_queue_create("myq", 0), ^{
            NSLog(@"t2 doing...");
            [NSThread sleepForTimeInterval:3];
//            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"t2 done");
                
                dispatch_group_leave(myGroup);
//            });
        });
        
        
        dispatch_group_notify(myGroup, dispatch_get_main_queue(), ^{
            NSLog(@"all done");
        });
        
        NSLog(@"-------------- ******** ------------");
        
        getchar();
    }
    return 0;
}
