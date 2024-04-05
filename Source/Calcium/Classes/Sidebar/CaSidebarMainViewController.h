//
//  CaSidebarMainViewController.h
//  Calcium
//
//  Created by bag.xml on 18/02/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APLSlideMenuViewController.h"
#import "SVProgressHUD.h"
#import "CaChatViewController.h"

@interface CaSidebarMainViewController : UITableViewController

@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property UIRefreshControl *refreshControl;

@end
