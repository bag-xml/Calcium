//
//  CaSidebarMainViewController.m
//  Calcium
//
//  Created by bag.xml on 18/02/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import "CaSidebarMainViewController.h"

@interface CaSidebarMainViewController ()

@end

@implementation CaSidebarMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SIDEBAR TABLE VIEW LOADED");
    //Variables
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    CGFloat iOSVersion = [systemVersion floatValue];
    //Var END
    
    //If classes BEGON
    if(iOSVersion > 7.0) {
        //Customization of the background view
        
        //figma doesnt work on any of my machines
        self.debugLabel.text = @"Welcome";
        
        //thats why i have to do this
        
        //bg
        self.utiltyBackground.image = [UIImage imageNamed:@"SidebarTopLeaderFlat"];
        self.historyView.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:83.0/255.0 alpha:1.0];
        
        //Buttons
        [self.settingsButton setImage:[UIImage imageNamed:@"hamburger"] forState:UIControlStateNormal];
        [self.settingsButton.titleLabel setShadowOffset:CGSizeMake(0, 0)];
        [self.settingsButton setTitleColor:[UIColor colorWithRed:116.0/255.0 green:116.0/255.0 blue:116.0/255.0 alpha:1.0] forState:UIControlStateNormal]; // Change color as needed
        
        [self.Guide setImage:[UIImage imageNamed:@"hamburger"] forState:UIControlStateNormal];
        [self.Guide.titleLabel setShadowOffset:CGSizeMake(0, 0)];
        
        [self.About setImage:[UIImage imageNamed:@"hamburger"] forState:UIControlStateNormal];
        [self.About.titleLabel setShadowOffset:CGSizeMake(0, 0)];
        //Statusbar adjustment
        if ([self respondsToSelector:@selector(topLayoutGuide)]) {
            self.tableView.contentInset = UIEdgeInsetsMake(20., 0., 0., 0.);
        }
    } else if(iOSVersion > 6.0) {
        //figma thingy
        self.debugLabel.text = @"";
    }
    //If classes END
}

//Sidebar table view properties BEGIN

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *historyCell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    
    //Optical tweaking of elements inside of historyCell
    historyCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    [historyCell.textLabel setShadowOffset:CGSizeMake(0, 0)];
    //History cell LOGICAL properties
    historyCell.textLabel.text = [NSString stringWithFormat:@"Conversation %ld",(long)indexPath.row];
    historyCell.detailTextLabel.text = [NSString stringWithFormat:@"01/09/2007"];
    return historyCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellTitle = selectedCell.textLabel.text;
    NSLog(@"User selected history cell, conversation name is %@", cellTitle);
    
    UINavigationController *navigationController = (UINavigationController *)self.slideMenuController.contentViewController;
    CaChatViewController *contentViewController = navigationController.viewControllers.firstObject;
    if ([contentViewController isKindOfClass:[CaChatViewController class]]) {
        contentViewController.navigationItem.title = cellTitle;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.slideMenuController hideMenu:YES];
    NSLog(@"Throwing back to main chat view)");
}

//SIdebar table view properties END

//FUNCTIONS BLOCK BEGIN
- (void)reloadEngine {
}
//Button actions

- (IBAction)settings:(id)sender {
    //Temporary, opens cydia for the time being
    [self showAlertWithTitle:@"In-App settings can't be changed here." message:@"To change In-App settings, open the Settings app."];
}

- (IBAction)guide:(id)sender {
    NSLog(@"--ACTION-- Pressed Guide button in sidebar");
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    CGFloat iOSVersion = [systemVersion floatValue];
    if(iOSVersion > 7.0) {
        [self performSegueWithIdentifier:@"sidebar to Guide-iOS7" sender:self];
    } else if(iOSVersion < 7.0) {
        [self performSegueWithIdentifier:@"sidebar to Guide-iOS6" sender:self];
    }
}


- (IBAction)about:(id)sender {
    //needed variables
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    CGFloat iOSVersion = [systemVersion floatValue];
    
    NSLog(@"--ACTION-- Pressed About button in sidebar");
    if(iOSVersion >7.0) {
        [self performSegueWithIdentifier:@"sidebar to About-iOS7" sender:self];
    } else if(iOSVersion <7.0) {
        [self performSegueWithIdentifier:@"sidebar to About-iOS6" sender:self];
    }
}

- (IBAction)debug:(id)sender {
    NSLog(@"--ACTION-- Pressed Guide button in sidebar");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    exit(0);
}

//Button actions END


//Misc class Begin
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
//Misc class End

@end
