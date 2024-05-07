//
//  CaRequestFactory.m
//  Calcium
//
//  Created by bag.xml on 06/04/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

//Apiary communicator class which interacts with the ChatGPT API

#import "CaRequestFactory.h"

@implementation CaRequestFactory

- (void)startTextRequest:(NSString *)messagePayload {
    NSLog(@"ChatCommunicator active, will prepare request now.");
    //OSBlock
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    CGFloat iOSVersion = [systemVersion floatValue];
    
    NSString *serverURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverURL"];
    
    if(iOSVersion < 7.0) {
        NSLog(@"Initializing Chat Completion request, iOS 5.0-6.1.6");
        
        NSURL *apiaryRequestURL = [NSURL URLWithString:serverURL];
        
        NSMutableURLRequest *apiaryCommunicationRequest = [NSMutableURLRequest requestWithURL:apiaryRequestURL];
        NSMutableDictionary *completionRequestBody = [NSMutableDictionary dictionaryWithDictionary:@{@"max_context_length": @2048, @"max_length": @100, @"prompt": messagePayload, @"quiet": @false, @"rep_pen": @1.1, @"rep_pen_range": @256, @"rep_pen_slope": @1, @"temperature": @0.5, @"tfs": @1, @"top_a": @0, @"top_k": @100, @"top_p": @0.9, @"typical": @1}];

        NSData *completionRBData = [NSJSONSerialization dataWithJSONObject:completionRequestBody options:0 error:nil];

        [apiaryCommunicationRequest setHTTPMethod:@"POST"];
        [apiaryCommunicationRequest setHTTPBody:completionRBData];
        [apiaryCommunicationRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayAlertView:@"--apiaryCommunicatorLOG: CompletionRequest Log" message:[NSString stringWithFormat:@"JSON Body: %@", completionRequestBody]];
        });
        
        NSURLConnection *communicatorCall = [[NSURLConnection alloc] initWithRequest:apiaryCommunicationRequest delegate:self];
        [communicatorCall start];

    
    } else if(iOSVersion > 7.0) {
    }
}

- (void)startImageGenerationRequest:(NSString *)messageContent {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayAlertView:@"Communicator Log" message:@"Not implemented."];
        });
    });
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Check the client's OS for if-blocks 
        NSLog(@"API has responded");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        BOOL didTheRequestWithMiddleman = [[NSUserDefaults standardUserDefaults] boolForKey:@"requestPerformedWithMiddleman"];
        BOOL didImageGeneration = [[NSUserDefaults standardUserDefaults] boolForKey:@"didGenerateImage"];
        
        NSDictionary *apiaryResponseJournal = [NSJSONSerialization JSONObjectWithData:self.apiaryResponseData options:0 error:nil];
        NSLog(@"Apiary Response: %@", apiaryResponseJournal);
        NSLog(@"Executing code block dependent on request config now");
        
        //In case of any error
        NSDictionary *apiaryError = [apiaryResponseJournal objectForKey:@"error"];
        if(apiaryError) {
            NSLog(@"error");
            NSString *errorBody = [apiaryError objectForKey:@"message"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self displayAlertView:@"Apiary Error" message:errorBody];
            });
        }
        
        if(didTheRequestWithMiddleman == YES) {
            NSLog(@"Middleman Request = YES");
            if(didImageGeneration == YES) {
                NSLog(@"Image Generation = YES");
            } else if(didImageGeneration == NO) {
                NSLog(@"Image Generation = NO");
            }
            
        } else if(didTheRequestWithMiddleman == NO) {
            NSLog(@"Middleman Request = No");
            if(didImageGeneration == YES) {
                NSLog(@"Image Generation = YES");
            } else if(didImageGeneration == NO) {
                NSLog(@"Image Generation = NO");
                [self sendReset];
                //Debug, delete at the end of Calcium development
                dispatch_async(dispatch_get_main_queue(), ^{
                });
                
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didReceiveResponseData:[NSString stringWithFormat:@"%@", apiaryResponseJournal]];
            NSString *response = [[[apiaryResponseJournal objectForKey:@"results"] objectAtIndex:0] valueForKey:@"text"];
            [self.delegate didReceiveResponseData:response];
            self.apiaryResponseData = nil;
        });
    });
}

//MISC FUNCTION
- (void)displayAlertView:(NSString *)title message:(NSString *)message {
    UIAlertView *connectDisplay = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [connectDisplay show];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (!self.apiaryResponseData) {
        self.apiaryResponseData = [NSMutableData data];
    }
    [self.apiaryResponseData appendData:data];
}

- (void)sendReset {
    NSLog(@"Resetting previous request parameters");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"didGenerateImage"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"requestPerformedWithMiddleman"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"Done");
}

/* - - -
 
 dispatch_async(dispatch_get_main_queue(), ^{
 //[self.delegate didReceiveResponseData:[NSString stringWithFormat:@"a" ]];
 });
 
 sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ Mavericks.app
 - - - */
@end
