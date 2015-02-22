//
//  main.m
//  ping
//
//  Created by Dan Peddle on 21/02/15.
//  Copyright (c) 2015 Dan Peddle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "lumberjack.h"
#import "api-ping.h"

int ddLogLevel = LOG_LEVEL_ALL;

int main(int argc, const char* argv[])
{

    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    NSRunLoop* runLoop;
    APIPing* req;

    runLoop = [NSRunLoop currentRunLoop];
    req = [[APIPing alloc] init];
    [req start];

    while ((!(req.shouldExit)) && (([runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]])))
        ;

    return (req.exitCode);
}
