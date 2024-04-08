//
//  CaChatViewController.m
//  Calcium
//
//  Created by bag.xml on 18/02/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import "CaChatViewController.h"

@interface CaChatViewController ()
{
    NSMutableArray *bubbleData;
}
@end

@implementation CaChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Definition of variables, ones which are used on the bottom.
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    CGFloat iOSVersion = [systemVersion floatValue];
    BOOL firstLaunchCheck = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
    //end
    
    //Sidebar setup block
    self.slideMenuController.bouncing = YES;
    self.slideMenuController.gestureSupport = APLSlideMenuGestureSupportDrag;
    self.slideMenuController.separatorColor = [UIColor grayColor];
    //Setup block end
    
    //Table view options
    
    //temp population
    self.bubbleTableView.bubbleDataSource = self;
    self.bubbleTableView.watchingInRealTime = YES;
    self.bubbleTableView.delegate = self;
    self.bubbleTableView.snapInterval = 2800;
    self.bubbleDataArray = [NSMutableArray array];
    self.bubbleTableView.showAvatars = [[NSUserDefaults standardUserDefaults] boolForKey:@"showPFP"];
    [self.bubbleTableView reloadData];
    //table view options OFF
    
    //RFactory delegate
    self.requestFactory = [[CaRequestFactory alloc] init];
    self.requestFactory.delegate = self;
    //RFD end
    //Delegate decs
    [self.inputField setDelegate:self];
    //Delegate decs end
    
    //event notification block BEGIN
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //event notification block END
    
    //OS Specific settings BEGIN
    if(iOSVersion < 6.0) {
        NSLog(@"User uses iOS 5");
    } else if(iOSVersion < 7.0) {
        NSLog(@"User uses iOS 6");
    } else if(iOSVersion > 7.0) {
        NSLog(@"User uses iOS 7 or newer");
    }
    //OS Specific settings END
    
    //first launch block, performs a segue if the application has been launched for the first ever time.
    if (firstLaunchCheck == NO) {
        if(iOSVersion <7.0) {
            [self performSegueWithIdentifier:@"to Welcomepage-iOS6" sender:self];
        } else if(iOSVersion >7.0) {
            [self performSegueWithIdentifier:@"to Welcomepage-iOS7" sender:self];
        }
    }
    //first launch block END
}


//Text field properties BEGIN
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    self.inputFieldPlaceholder.hidden = self.inputField.text.length != 0;
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView {
    self.inputFieldPlaceholder.hidden = self.inputField.text.length != 0;
}

-(void) textViewDidEndEditing:(UITextView *)textView {
    self.inputFieldPlaceholder.hidden = self.inputField.text.length != 0;
}
//Text field properties END

//Button actions
- (IBAction)modeSwitch:(id)sender {
    BOOL imageMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"imageGenerationModeEnabled"];
    BOOL clearAlways = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysClear"];
    if (imageMode == YES) {
        UIImage *correspondingMode = [UIImage imageNamed:@"PictureModeGlyph"];
        NSLog(@"--BUTTON ACTION-- User switched to chat mode from gen mode");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"imageGenerationModeEnabled"];
        [SVProgressHUD showErrorWithStatus:@"Switched to Chat Mode"];
        self.navigationItem.title = @"Chat";
        
        //Clears history
        if(clearAlways == YES) {
            NSLog(@"Chat history has been cleared.");
            [self.bubbleDataArray removeAllObjects];
            [self.bubbleTableView reloadData];
        }
        
        //Input field
        self.inputFieldPlaceholder.text = @"Type something in...";
        self.inputField.text = @"";
        [self.modeButton setImage:correspondingMode];
        
    } else if (imageMode == NO) {
        UIImage *correspondingMode = [UIImage imageNamed:@"hamburger"];
        NSLog(@"--BUTTON ACTION-- User switched to gen from chat mode");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"imageGenerationModeEnabled"];
        [SVProgressHUD showSuccessWithStatus:@"Switched to Image Generation Mode"];
        self.navigationItem.title = @"Generate Image";
        
        //Clears history
        if(clearAlways == YES) {
            NSLog(@"Chat history has been cleared.");
            [self.bubbleDataArray removeAllObjects];
            [self.bubbleTableView reloadData];
        }

        BOOL switchForFirstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"didIWarnYou"];
        if(switchForFirstTime == NO) {
            NSString *errorMessage = @"For Image Generation you may need a more advanced API key that has DALL-E and GPT-4 access.";
            [self showAlertWithTitle:@"Hey" message:errorMessage];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didIWarnYou"];
        }
        //input field dishery
        self.inputFieldPlaceholder.text = @"Generate something...";
        self.inputField.text = @"";
        [self.modeButton setImage:correspondingMode];
    }

}

- (IBAction)sendButton:(id)sender {
    NSLog(@"--BUTTON ACTION-- Send button tapped");
    BOOL imageMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"imageGenerationModeEnabled"];
    if(imageMode == YES) {
        NSLog(@"imageMode == YES");
        NSLog(@"Image generation mode is enabled, therefore the function for image generation is executed.");
        NSString *messageContent = self.inputField.text;
        if(messageContent.length < 3) {
            //preventative, for both ugliness and effectiveness
            [self showAlertWithTitle:@"Too short" message:@"Your message is too short, please type in something longer (and don't waste your API key credit)."];
        } else {
            [self imageGenRequest];

        }
        //kaboom
    } else if(imageMode == NO) {
        NSLog(@"imageMode == NO");
        NSLog(@"Chat mode is enabled, therefore the function for image generation is executed.");

        NSString *messagePayload = self.inputField.text;
        if(messagePayload.length < 3) {
            //preventative, for both ugliness and effectiveness
            [self showAlertWithTitle:@"Too short" message:@"Your message is too short, please type in something longer (and don't waste your API key credit)."];
        } else {
            [self chatRequest];
            self.inputField.text = @"";
        }
    }
}

- (IBAction)exposeSidebar:(id)sender {
    //Sidebar thingy
    NSLog(@"--BUTTON ACTION-- User pressed left hambuger button, Exposing sidebar now!");
    [self.slideMenuController showLeftMenu:YES];
}
- (IBAction)escapeRequest:(id)sender {
    NSLog(@"--ACTION-- Did escape Tap");
    [self.inputField resignFirstResponder];
}

- (IBAction)didLongPress:(id)sender {
    NSLog(@"--ACTION-- Did long press");
    //Show action sheet
    UIActionSheet *messageActionSheet = [[UIActionSheet alloc] initWithTitle:@"What do you want to do" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Clear conversation" otherButtonTitles:nil];
    [messageActionSheet setTag:1];
    [messageActionSheet setDelegate:self];
    [messageActionSheet showInView:self.view];
}
//Button action block end

//Temporary request classes

- (void)chatRequest {
    NSLog(@"Chat request is being prepared");
    NSString *messagePayload = self.inputField.text;
    [self.requestFactory startTextRequest:messagePayload];
}

- (void)imageGenRequest {
    NSLog(@"Image generation request is being prepared");

    [SVProgressHUD showSuccessWithStatus:@"calderon"];
}

- (void)didReceiveResponseData:(NSData *)data {
    [self.bubbleTableView reloadData];
}

//Temp request classes END

//Keyboard event block begin
- (void)keyboardWillShow:(NSNotification *)notification {

	int keyboardHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
	float keyboardAnimationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
	int keyboardAnimationCurve = [[notification.userInfo objectForKey: UIKeyboardAnimationCurveUserInfoKey] integerValue];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:keyboardAnimationDuration];
	[UIView setAnimationCurve:keyboardAnimationCurve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[self.bubbleTableView setHeight:self.view.height - keyboardHeight - self.toolbar.height];
	[self.toolbar setY:self.view.height - keyboardHeight - self.toolbar.height];
	[UIView commitAnimations];
	
	
	if(self.viewingPresentTime)
		[self.bubbleTableView setContentOffset:CGPointMake(0, self.bubbleTableView.contentSize.height - self.bubbleTableView.frame.size.height) animated:NO];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	
	float keyboardAnimationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
	int keyboardAnimationCurve = [[notification.userInfo objectForKey: UIKeyboardAnimationCurveUserInfoKey] integerValue];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:keyboardAnimationDuration];
	[UIView setAnimationCurve:keyboardAnimationCurve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[self.bubbleTableView setHeight:self.view.height - self.toolbar.height];
	[self.toolbar setY:self.view.height - self.toolbar.height];
	[UIView commitAnimations];
}
//Keyboard event block end

//Bubble table view attributes BEGIN
- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView {
    return self.bubbleDataArray.count;
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row {
    return [self.bubbleDataArray objectAtIndex:row];
}

// Implement optional delegate method
- (void)bubbleTableView:(UIBubbleTableView *)tableView didSelectRow:(NSUInteger)row {
    [SVProgressHUD showErrorWithStatus:@"Selected"];
}


//END
//Miscellaneous functions that get called from other block components BEGIN
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

-(void)scrollChatToBottom {
    [self.bubbleTableView scrollBubbleViewToBottomAnimated:false];
}
//END

@end
