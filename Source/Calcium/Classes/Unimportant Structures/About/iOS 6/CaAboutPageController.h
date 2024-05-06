//
//  CaAboutPageController.h
//  Calcium
//
//  Created by bag.xml on 08/03/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double) 568) < DBL_EPSILON)
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double) 480) < DBL_EPSILON)
#define IS_IPHONE_3GS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double) 240) < DBL_EPSILON)

@interface CaAboutPageController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
