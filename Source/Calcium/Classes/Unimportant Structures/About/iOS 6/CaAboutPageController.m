//
//  CaAboutPageController.m
//  Calcium
//
//  Created by bag.xml on 08/03/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import "CaAboutPageController.h"

@interface CaAboutPageController ()

@end

@implementation CaAboutPageController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //need to make a 4-inch check in order to give the right tableview background image, remember, i love consistency.
    [self.Done setBackgroundImage:[UIImage imageNamed:@"BarButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.Done setBackgroundImage:[UIImage imageNamed:@"BarButtonPressed"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    if(IS_IPHONE_5) {
        self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutTableBG@R4"]];
    } else if(IS_IPHONE_4) {
        self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutTableBG@2x"]];
    } else if(IS_IPHONE_3GS) {
        self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutTableBG"]];
    }
    
    //beauty
}

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

//button actions
- (IBAction)back:(id)sender {
    [self performSegueWithIdentifier:@"iOS6-about to main" sender:self];
    NSLog(@"User left about page");
}
@end
