//
//  CaWelcomeViewController.m
//  Calcium
//
//  Created by bag.xml on 18/02/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import "CaWelcomeViewController.h"

@interface CaWelcomeViewController ()

@end

@implementation CaWelcomeViewController

- (void)viewWillAppear:(BOOL)animated {
    NSDictionary *titleTextAttributes = @{
                                          UITextAttributeTextColor: [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0],
                                          UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
                                          UITextAttributeTextShadowColor: [UIColor blackColor]
                                          };
    
    // Apply the attributes to the navigation bar
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
    
    [UINavigationBar.appearance setBackgroundImage:[UIImage imageNamed:@"DarkUITitlebarBG"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillDisappear:(BOOL)animated {
    [UINavigationBar.appearance setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"WELCOME VIEW LOADED - - - iOS 6/5");
    //sidebar optimization for welcome view
    self.slideMenuController.gestureSupport = NO;
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"--EVENT-- Signed off first launch sequence!");
    //sign off first launch sequence requirement (TEMP)
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
}

@end
