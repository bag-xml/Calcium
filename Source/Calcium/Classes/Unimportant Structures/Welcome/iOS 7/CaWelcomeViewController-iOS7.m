//
//  CaWelcomeViewController-iOS7.m
//  Calcium
//
//  Created by bag.xml on 02/04/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import "CaWelcomeViewController-iOS7.h"

@interface CaWelcomeViewController_iOS7 ()

@end

@implementation CaWelcomeViewController_iOS7

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"WELCOME VIEW LOADED - - - iOS 7");
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
