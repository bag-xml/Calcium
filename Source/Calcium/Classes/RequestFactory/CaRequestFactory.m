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
        NSLog(@"Communicator active, will prepare request now.");
        //free api key cheat mod apk 100% free unlimited credit!!!!
        NSString *authenticationSecret = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
        
        BOOL useHeadlessBrowserEngine = [[NSUserDefaults standardUserDefaults] boolForKey:@"useMiddleman"];
        
        if(useHeadlessBrowserEngine == YES) {
            NSLog(@"User desires headless browser engine, will request this way.");
            //config
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"requestPerformedWithMiddleman"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didGenerateImage"];
            //Request code for the headless chatgpt engine
            
        } else if(useHeadlessBrowserEngine == NO) {
            NSLog(@"User does not want to use a middleman, this is okay.");
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
            NSLog(@"Preparing request to %@, with the content %@ and authorization %@", apiaryURL, completionRequestBody, authenticationSecret);
            [communicatorCall start];
        }
}

- (void)startImageGenerationRequest:(NSString *)messageContent {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"API has responded");
        BOOL didTheRequestWithMiddleman = [[NSUserDefaults standardUserDefaults] boolForKey:@"requestPerformedWithMiddleman"];
        BOOL didImageGeneration = [[NSUserDefaults standardUserDefaults] boolForKey:@"didGenerateImage"];
        
        NSDictionary *apiaryResponseJournal = [NSJSONSerialization JSONObjectWithData:self.apiaryResponseData options:0 error:nil];
        NSLog(@"Apiary Response: %@", apiaryResponseJournal);
        NSLog(@"Executing code block dependent on request config now");
        
        //In case of any error
        NSDictionary *apiaryError = [apiaryResponseJournal objectForKey:@"error"];
        if(apiaryError) {
            NSLog(@"error");
            NSString *errorCode = [apiaryError objectForKey:@"code"];
            if([errorCode isEqualToString:@"invalid_api_key"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showErrorWithStatus:@"Invalid API key."];
                });

            }
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
                //at the VERY end
                [self sendReset];
            }
        }

        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.delegate didReceiveResponseData:[NSString stringWithFormat:@"a" ]];
        });
    });
}

//MISC FUNCTION
- (void)displayAlertView {
    UIAlertView *connectDisplay = [UIAlertView.alloc initWithTitle:@"Connecting" message:@"\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [connectDisplay show];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Ensure that receivedData is initialized
    if (!self.apiaryResponseData) {
        self.apiaryResponseData = [NSMutableData data];
    }
    // Append the received data to receivedData
    [self.apiaryResponseData appendData:data];
}

- (void)sendReset {
    NSLog(@"Resetting previous request parameters");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"didGenerateImage"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"requestPerformedWithMiddleman"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"Done");
}

@end
