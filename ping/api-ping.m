//
//  api-ping.m
//  ping
//
//  Created by Dan Peddle on 21/02/15.
//  Copyright (c) 2015 Dan Peddle. All rights reserved.
//

#import "api-ping.h"
#import <PromiseKit/PromiseKit.h>

static NSString *const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";

@implementation APIPing
@synthesize shouldExit;
@synthesize exitCode;

- (APIPing *)init
{
    self = [super init];
    shouldExit = false;
    exitCode = 0;
    DDLogVerbose(@"API init");
    return self;
}

- (void)finish:(int)code
{
    exitCode = code;
    shouldExit = true;
}

- (PMKPromise*)start
{

    NSString *reqURL;
    PMKPromise *request;
    reqURL = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    request = [NSURLConnection GET:reqURL]
        .then(^(NSData *data) {
          DDLogVerbose(@"%@", data);
          [self finish:0];
        })
        .catch(^(NSError *error) {
          NSHTTPURLResponse *rsp =
              error.userInfo[PMKURLErrorFailingURLResponseKey];
          int HTTPStatusCode = rsp.statusCode;
          [self finish:1];
          DDLogVerbose(@"%@", error);
        });
    return request;
    //    NSString* string = [NSString
    //    stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    //    NSURL* url = [NSURL URLWithString:string];
    //    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //
    //    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]
    //    initWithRequest:request];
    //    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    //
    //    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation*
    //    operation, id responseObject) {
    //
    //        NSDictionary * data = (NSDictionary * ) responseObject;
    //        DDLogVerbose(@"%@", data[@"data"]);
    //        shouldExit = true;
    //
    //    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
    //        DDLogCError(@"uhoh %@", error);
    //        exitCode = 1;
    //        shouldExit = true;
    //    }];
    //
    //    [operation start];

    DDLogVerbose(@"API start");
}

- (void)finalize
{
    [super finalize];
    DDLogVerbose(@"finalize called");
}

@end
