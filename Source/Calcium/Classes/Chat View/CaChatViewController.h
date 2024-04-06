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
#import "CaRequestFactory.h"

@interface CaChatViewController : UIViewController <UIBubbleTableViewDataSource, UIBubbleTableViewDelegate, UIActionSheetDelegate, CaRequestFactoryDelegate>


//mainview
@property (weak, nonatomic) IBOutlet UIBubbleTableView *bubbleTableView;
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
@property (nonatomic, strong) NSMutableArray *bubbleDataArray;
//end

//RFC
@property (nonatomic, strong) CaRequestFactory *requestFactory;

@end
