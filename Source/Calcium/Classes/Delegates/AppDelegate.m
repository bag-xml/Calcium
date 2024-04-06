//
//  AppDelegate.m
//  Calcium
//
//  Created by bag.xml on 18/02/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"App finished launching");
    //Pre-set preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    //Predefined values FOR the preferences
    NSString *aiPrompt = @"";
    NSString *defaultApiEndpoint = @"https://api.openai.com/v1/chat/completions";
    NSString *defaultAIModel = @"gpt-3.5-turbo";
    //predef block end
    
    if (![defaults objectForKey:@"apiEndpoint"]) {
        [defaults setObject:defaultApiEndpoint forKey:@"apiEndpoint"];
    }
    if (![defaults objectForKey:@"AIModel"]) {
        [defaults setObject:defaultAIModel forKey:@"AIModel"];
    }
    if (![defaults objectForKey:@"aiPrompt"]) {
        [defaults setObject:aiPrompt forKey:@"aiPrompt"];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"imageGenerationModeEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //Pref block END
    
    //First launch check
    BOOL firstLaunchCheck = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
    if (firstLaunchCheck == NO) {
        NSLog(@"User never opened the app, or deleted the firstLaunchCheck key, instantiating the first launch sequence");
    } else if (firstLaunchCheck == YES)
        NSLog(@"User isn't here for the first time..");
    //FL Check block END
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"Will resign active");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"Did enter background");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"Will enter foregrond");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"Did become active");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"Will terminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
