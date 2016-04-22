//
//  main.m
//  门禁管理系统
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "System.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {      
        System *s1=[[System alloc]init];
        [s1 setStaff:[[NSMutableArray alloc] initWithCapacity:100]];
        [s1 show];
    }
    return 0;
}
