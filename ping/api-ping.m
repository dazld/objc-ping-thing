//
//  api-ping.m
//  ping
//
//  Created by Dan Peddle on 21/02/15.
//  Copyright (c) 2015 Dan Peddle. All rights reserved.
//

#import "api-ping.h"

static NSString* const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";

@implementation APIPing
@synthesize shouldExit;
@synthesize exitCode;

- (APIPing*)init
{
    self = [super init];
    shouldExit = false;
    exitCode = 0;
    DDLogVerbose(@"API init");
    return self;
}

- (void)start
{

    NSString* string = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    NSURL* url = [NSURL URLWithString:string];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* operation, id responseObject) {
        
        NSDictionary * data = (NSDictionary * ) responseObject;
        DDLogVerbose(@"%@", data[@"data"]);
        shouldExit = true;

    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        DDLogCError(@"uhoh %@", error);
        exitCode = 1;
        shouldExit = true;
    }];

    [operation start];

    DDLogVerbose(@"API start");
}

- (void) finalize {
    [super finalize];
    DDLogVerbose(@"finalize called");
}

@end
