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
    
    self.tableView.delegate = self;
    //need to make a 4-inch check in order to give the right tableview background image, remember, i love consistency.
    if(IS_IPHONE_5) {
        [SVProgressHUD showSuccessWithStatus:@"5"];
        self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutTableBG@R4"]];
    } else if(IS_IPHONE_4) {
        [SVProgressHUD showSuccessWithStatus:@"4"];
        self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutTableBG@2x"]];
    } else if(IS_IPHONE_3GS) {
        [SVProgressHUD showSuccessWithStatus:@"3GS"];
        self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutTableBG"]];
    }
    
    //beauty
    [UINavigationBar.appearance setBackgroundImage:[UIImage imageNamed:@"DarkUITitlebarBG"] forBarMetrics:UIBarMetricsDefault];
}
//s

//button actions
- (IBAction)back:(id)sender {
    [self performSegueWithIdentifier:@"iOS6-about to main" sender:self];
}
@end
