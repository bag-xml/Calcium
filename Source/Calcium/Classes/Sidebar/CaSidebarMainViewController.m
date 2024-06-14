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
    //If classes BEGON
    if(VERSION_MIN(@"7.0")) {
        //Customization of the background view
        
        //figma doesnt work on any of my machines
        self.debugLabel.text = @"Calcium";
        //thats why i have to do this
        
        //bg
        self.utiltyBackground.image = [UIImage imageNamed:@"SidebarTopLeaderFlat"];
        self.historyView.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:83.0/255.0 alpha:1.0];
        
        //Buttons
        [self.settingsButton setImage:[UIImage imageNamed:@"flatGear"] forState:UIControlStateNormal];
        [self.settingsButton.titleLabel setShadowOffset:CGSizeMake(0, 0)];
        [self.settingsButton setTitleColor:[UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.Guide setImage:[UIImage imageNamed:@"flatGuide"] forState:UIControlStateNormal];
        [self.Guide.titleLabel setShadowOffset:CGSizeMake(0, 0)];
        [self.Guide setTitleColor:[UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.About setImage:[UIImage imageNamed:@"flatContact"] forState:UIControlStateNormal];
        [self.About.titleLabel setShadowOffset:CGSizeMake(0, 0)];
        [self.About setTitleColor:[UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.Clear setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.Clear.titleLabel setShadowOffset:CGSizeMake(0, 0)];
        [self.Clear setTitleColor:[UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        //Statusbar adjustment
        if ([self respondsToSelector:@selector(topLayoutGuide)]) {
            self.tableView.contentInset = UIEdgeInsetsMake(20., 0., 0., 0.);
        }
    } else if(VERSION_MIN(@"6.0")) {
        //figma thingy
        self.debugLabel.text = @"";
    }
    //If classes END
}

//Sidebar table view properties BEGIN

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 256;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *historyCell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    //iOS 7's block
    if(VERSION_MIN(@"7.0")) {
        historyCell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
        [historyCell.textLabel setShadowOffset:CGSizeMake(0, 0)];
        [historyCell.detailTextLabel setShadowOffset:CGSizeMake(0, 0)];
    }
    //End of iOS 7's block
    
    //History cell LOGICAL properties
    historyCell.textLabel.text = [NSString stringWithFormat:@"Conversation %ld",(long)indexPath.row];
    historyCell.detailTextLabel.text = [NSString stringWithFormat:@"05/03/2007"];
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
        [contentViewController didReceiveResponseData:[NSString stringWithFormat:@"%@", cellTitle ]];
    }
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    if(VERSION_MIN(@"7.0")) {
        [self performSegueWithIdentifier:@"sidebar to Guide-iOS7" sender:self];
    } else if(VERSION_MIN(@"5.0")) {
        [self performSegueWithIdentifier:@"sidebar to Guide-iOS6" sender:self];
    }
}


- (IBAction)about:(id)sender {
    NSLog(@"--ACTION-- Pressed About button in sidebar");
    /*
    if(VERSION_MIN(@"7.0")) {
        [self performSegueWithIdentifier:@"sidebar to About-iOS7" sender:self];
    } else if(VERSION_MIN(@"5.0")) {
        [self performSegueWithIdentifier:@"sidebar to About-iOS6" sender:self];
    }
     *///to About-6
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *aboutViewController = [storyboard instantiateViewControllerWithIdentifier:@"About-6"];
    
    UINavigationController *navigationController = (UINavigationController *)self.slideMenuController.contentViewController;
    CaChatViewController *contentViewController = navigationController.viewControllers.firstObject;
    if ([contentViewController isKindOfClass:[CaChatViewController class]]) {
        [contentViewController.navigationController pushViewController:aboutViewController animated:NO];
        [self.slideMenuController hideMenu:YES];
        
    }
}

- (IBAction)clear:(id)sender {
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
/*    */
@end
