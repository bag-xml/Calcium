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
        //Basically what this does is prevent jag-in into the statusbar (fuck you ios 7)
        if ([self respondsToSelector:@selector(topLayoutGuide)]) {
            self.tableView.contentInset = UIEdgeInsetsMake(20., 0., 0., 0.);
        }
    } else if(iOSVersion > 6.0) {
    
    }
    //If classes END
}

//Sidebar table view properties BEGIN

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *historyCell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
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
    [self performSegueWithIdentifier:@"sidebar to Guide" sender:self];
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
