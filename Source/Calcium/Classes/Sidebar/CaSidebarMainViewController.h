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

#define VERSION_MIN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CaSidebarMainViewController : UITableViewController

@property (nonatomic, strong) NSIndexPath *currentIndexPath;


//Declarations

//Main 2 Views
@property (strong, nonatomic) IBOutlet UITableView *historyView;

@property (weak, nonatomic) IBOutlet UIImageView *utiltyBackground;

//TEMPORARY
@property (weak, nonatomic) IBOutlet UILabel *debugLabel;

//TEMPORARY END

//Three Utility buttons INSIDE view
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (weak, nonatomic) IBOutlet UIButton *Guide;

@property (weak, nonatomic) IBOutlet UIButton *About;

@property (weak, nonatomic) IBOutlet UIButton *Clear;

@property UIRefreshControl *refreshControl;
@end
