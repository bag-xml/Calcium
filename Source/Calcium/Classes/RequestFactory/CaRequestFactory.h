//
//  CaRequestFactory.h
//  Calcium
//
//  Created by bag.xml on 06/04/24.
//  Copyright (c) 2024 Mali 357. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIBubbleTableView.h"
#import "SVProgressHUD.h"
@protocol CaRequestFactoryDelegate <NSObject>
- (void)didReceiveResponseData:(NSData *)data;
@end

@interface CaRequestFactory : NSObject <NSURLConnectionDelegate>
@property (nonatomic, weak) id<CaRequestFactoryDelegate> delegate;

//Data
@property (nonatomic, strong) NSMutableData *apiaryResponseData;
- (void)startTextRequest:(NSString *)messagePayload;
@end

