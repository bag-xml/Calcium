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
    
    NSString *authenticationSecret = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    BOOL useHeadlessBrowserEngine = [[NSUserDefaults standardUserDefaults] boolForKey:@"useMiddleman"];
    
    if(iOSVersion < 7.0) {
        if(useHeadlessBrowserEngine == YES) {
            NSLog(@"User desires headless browser engine, will request this way.");
            //config
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"requestPerformedWithMiddleman"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didGenerateImage"];
            //Request code for the headless chatgpt engine
            //NOT YET
            
        } else if(useHeadlessBrowserEngine == NO) {
            NSLog(@"User does not want to use a middleman, this is okay.");
            //configuration
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"requestPerformedWithMiddleman"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didGenerateImage"];
            
            NSString *apiaryURL = @"http://api.openai.com/v1/chat/completions";
            NSURL *apiaryRequestURL = [NSURL URLWithString:apiaryURL];
            
            NSMutableURLRequest *apiaryCommunicationRequest = [NSMutableURLRequest requestWithURL:apiaryRequestURL];
            NSMutableDictionary *completionRequestBody = [NSMutableDictionary dictionaryWithDictionary:@{@"model": @"gpt-3.5-turbo", @"messages": @[@{@"role": @"user", @"content": messagePayload}]}];

            
            NSData *completionRBData = [NSJSONSerialization dataWithJSONObject:completionRequestBody options:0 error:nil];
            
            //Headers for the apiary URL Request
            [apiaryCommunicationRequest setHTTPMethod:@"POST"];
            [apiaryCommunicationRequest setHTTPBody:completionRBData];
            [apiaryCommunicationRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [apiaryCommunicationRequest setValue:[NSString stringWithFormat:@"Bearer %@", authenticationSecret] forHTTPHeaderField:@"Authorization"];
            //Goes directly to OpenAI
            
            //Debug alert view
            dispatch_async(dispatch_get_main_queue(), ^{
                [self displayAlertView:@"--apiaryCommunicatorLOG: Non-Middleman ChatGeneration -- POST-Request log" message:[NSString stringWithFormat:@"JSON Body: %@, auth header: 'Bearer %@', endpoint: %@", completionRequestBody, authenticationSecret, apiaryRequestURL]];
            });
            //Remove after communicator development
            
            //Starting the request
            NSURLConnection *communicatorCall = [[NSURLConnection alloc] initWithRequest:apiaryCommunicationRequest delegate:self];
            NSLog(@"Preparing request to %@, with the content %@ and authorization %@", apiaryURL, completionRequestBody, authenticationSecret);
            [communicatorCall start];
        }
    } else if(iOSVersion > 7.0) {
        if(useHeadlessBrowserEngine == YES) {
            //headless code
        } else if(useHeadlessBrowserEngine == NO) {
            //conventional openai endpoint engineering
            //use 7.0+ because nsurlsession
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self displayAlertView:@"--apiaryCommunicatorLOG: Non-Middleman ChatGeneration -- POST-Request log" message:[NSString stringWithFormat:@"iOS 7+ NSURLSession RequestBlock not implemented, CaRequestFactory"]];
            });
        }
    }
}

- (void)startImageGenerationRequest:(NSString *)messageContent {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayAlertView:@"--apiaryCommunicatorLOG: Non-Middleman ImageGeneration -- POST-Request log" message:@"Not implemented."];
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
                [self displayAlertView:@"--apiaryCommunicatorLOG: Non-Middleman-ChatGeneration Response" message:[NSString stringWithFormat:@"%@", apiaryResponseJournal]];
                });
                
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didReceiveResponseData:[NSString stringWithFormat:@"%@", apiaryResponseJournal]];
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
 
 - - - */
@end
