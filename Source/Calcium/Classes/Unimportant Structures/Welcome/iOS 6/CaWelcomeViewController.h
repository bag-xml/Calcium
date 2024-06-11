//
//  CaWelcomeViewController.h
//  Calcium
//
//  Created by bag.xml on 18/02/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APLSlideMenuViewController.h"

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double) 568) < DBL_EPSILON)
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double) 480) < DBL_EPSILON)
#define IS_IPHONE_3GS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double) 240) < DBL_EPSILON)

@interface CaWelcomeViewController : UITableViewController

@end
