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

}

//Button actions
- (IBAction)Done:(id)sender {
    [self performSegueWithIdentifier:@"TurnBack-6" sender:self];
}


@end
