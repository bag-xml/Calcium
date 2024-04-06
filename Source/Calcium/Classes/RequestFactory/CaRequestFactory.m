//
//  CaRequestFactory.m
//  Calcium
//
//  Created by bag.xml on 06/04/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import "CaRequestFactory.h"

@implementation CaRequestFactory

- (void)startTextRequest:(NSString *)messagePayload {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *apiaryEndpoint = [NSURL URLWithString:@"http://cydia.skyglow.es:5002/"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:apiaryEndpoint];
        
        [request setHTTPMethod:@"POST"];
        
        NSMutableDictionary *bodyData = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                        @"model": @"dall-e-3",
                                                                                        @"prompt": @"skeuomorphic phone icon",
                                                                                        @"n": @1,
                                                                                        @"size": @"256x256"
                                                                                        }];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyData options:0 error:nil];
        [request setHTTPBody:jsonData];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didReceiveResponseData:[NSString stringWithFormat:@"a" ]];
        });
    });
}
@end
