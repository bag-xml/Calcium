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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //free api key cheat mod apk 100% free unlimited credit!!!!
        NSString *authenticationSecret = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
        
        BOOL useHeadlessBrowserEngine = [[NSUserDefaults standardUserDefaults] boolForKey:@"useMiddleman"];
        
        if(useHeadlessBrowserEngine == YES) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"requestPerformedWithMiddleman"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didGenerateImage"];
            //Request code for the headless chatgpt engine
        } else if(useHeadlessBrowserEngine == NO) {
            //configuration
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"requestPerformedWithMiddleman"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didGenerateImage"];
            
            NSString *apiaryURL = @"https://api.openai.com/v1/chat/completions";
            NSURL *apiaryRequestURL = [NSURL URLWithString:apiaryURL];
            
            NSMutableURLRequest *apiaryCommunicationRequest = [NSMutableURLRequest requestWithURL:apiaryRequestURL];
            NSMutableDictionary *completionRequestBody = [NSMutableDictionary dictionaryWithDictionary:@{@"role": @"user", @"content": messagePayload}];
            
            NSData *completionRBData = [NSJSONSerialization dataWithJSONObject:completionRequestBody options:0 error:nil];
            
            //Headers for the apiary URL Request
            [apiaryCommunicationRequest setHTTPMethod:@"POST"];
            [apiaryCommunicationRequest setHTTPBody:completionRBData];
            [apiaryCommunicationRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [apiaryCommunicationRequest setValue:[NSString stringWithFormat:@"Bearer %@", authenticationSecret] forHTTPHeaderField:@"Authorization"];
            //Goes directly to OpenAI
            
            //Starting the request
            NSURLConnection *communicatorCall = [[NSURLConnection alloc] initWithRequest:apiaryCommunicationRequest delegate:self];
            
            [communicatorCall start];
        }
    });
}

- (void)startImageGenerationRequest:(NSString *)messageContent {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL didTheRequestWithMiddleman = [[NSUserDefaults standardUserDefaults] boolForKey:@"requestPerformedWithMiddleman"];
        BOOL didImageGeneration = [[NSUserDefaults standardUserDefaults] boolForKey:@"didGenerateImage"];
        
        if(didTheRequestWithMiddleman == YES) {
            if(didImageGeneration == YES) {
                
            } else if(didImageGeneration == NO) {
                
            }
        } else if(didTheRequestWithMiddleman == NO) {
            if(didImageGeneration == YES) {
                
            } else if(didImageGeneration == NO) {
                
            }
        }
        
        
        
        
        
        
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.delegate didReceiveResponseData:[NSString stringWithFormat:@"a" ]];
        });
    });
}
@end
