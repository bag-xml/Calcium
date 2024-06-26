//
//  CaChatViewController.h
//  Calcium
//
//  Created by bag.xml on 18/02/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APLSlideMenuViewController.h"
#import "NSBubbleData.h"
#import "SVProgressHUD.h"
#import "UIBubbleTableView.h"
#import "TRMalleableFrameView.h"
#import "CaRequestFactory.h"
#import "UIImage+Utils.h"
#import "Base64.h"

#define VERSION_MIN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CaChatViewController : UIViewController <UIBubbleTableViewDataSource, UIBubbleTableViewDelegate, UIActionSheetDelegate, CaRequestFactoryDelegate, UIImagePickerControllerDelegate>


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
@property (strong, nonatomic) UIImageView *inputFieldImageView;

//

//main toolbar
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
//toolbar block end

//misc declarations
@property bool viewingPresentTime;
@property (strong, nonatomic) NSString *currentImage;
@property (nonatomic, strong) NSMutableArray *bubbleDataArray;
//end

//RFC
@property (nonatomic, strong) CaRequestFactory *requestFactory;
@property (nonatomic, strong) NSMutableData *apiaryResponseData;

//sdifrgwe8d9pkrieu
@property UIRefreshControl *reloadControl;

@end
