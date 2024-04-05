//
//  CaChatViewController.h
//  Calcium
//
//  Created by bag.xml on 18/02/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APLSlideMenuViewController.h"
#import "SVProgressHUD.h"
#import "UIBubbleTableView.h"
#import "TRMalleableFrameView.h"
@interface CaChatViewController : UIViewController


//mainview
@property (weak, nonatomic) IBOutlet UIBubbleTableView *chatTableView;
//mainview end

//toolbar, and its children, block begin
//left button
@property (weak, nonatomic) IBOutlet UIBarButtonItem *modeButton;

//right button
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendButton;

//pill
@property (weak, nonatomic) IBOutlet UITextView *inputField;
@property (weak, nonatomic) IBOutlet UILabel *inputFieldPlaceholder;
@property (weak, nonatomic) IBOutlet UIImageView *insetShadow;
@property (weak, nonatomic) IBOutlet UIView *pill;

//

//main toolbar
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
//toolbar block end

//misc declarations
@property bool viewingPresentTime;
//end

@property (readonly, nonatomic) UIView *container;

//TEST
@property (nonatomic, strong) NSMutableArray *bubbleDataArray;

@end
