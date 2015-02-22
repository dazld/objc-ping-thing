//
//  api-ping.h
//  ping
//
//  Created by Dan Peddle on 21/02/15.
//  Copyright (c) 2015 Dan Peddle. All rights reserved.
//

#ifndef ping_api_ping_h
#define ping_api_ping_h

#import <Foundation/Foundation.h>
#import <AFNetworking/AFnetworking.h>
#import <PromiseKit/PromiseKit.h>
#import "lumberjack.h"

@interface APIPing : NSObject {

    bool shouldExit;
    int exitCode;
}
@property (nonatomic, readwrite) bool shouldExit;
@property (nonatomic, readwrite) int exitCode;

- (PMKPromise*)start;
@end

#endif
