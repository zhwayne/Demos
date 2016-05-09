//
//  main.m
//  Set
//
//  Created by ByRongInvest on 15/12/28.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *s = [NSString stringWithFormat:@"%s", [@"F" UTF8String]];
        
        NSArray *arr1 = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G"];
        NSSet *set1 = [NSSet setWithArray:arr1];
        
        NSArray *arr2 = @[@"1", @"2", @"B", @"F", @"3", @"A", @"4"];
        NSSet *set2 = [NSSet setWithArray:arr2];
        
        NSMutableSet *set = [set1 mutableCopy];
        [set intersectSet:set2];
        
        NSLog(@"%@", set);
        
        NSLog(@"%p", s);
        NSLog(@"%p", arr1[5]);
        
        NSLog(@"%@", [set containsObject:s] ? @"YES" : @"NO");
    }
    return 0;
}
