//
//  CaGuideController.m
//  Calcium
//
//  Created by bag.xml on 06/05/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import "CaGuideController.h"

@interface CaGuideController ()

@end

@implementation CaGuideController


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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.Done setBackgroundImage:[UIImage imageNamed:@"BarButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.Done setBackgroundImage:[UIImage imageNamed:@"BarButtonPressed"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
}

//Button actions
- (IBAction)Done:(id)sender {
    [self performSegueWithIdentifier:@"TurnBack-6" sender:self];
}


@end
