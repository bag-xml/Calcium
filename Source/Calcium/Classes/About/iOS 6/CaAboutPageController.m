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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UITitlebarBG"]];
}

@end
