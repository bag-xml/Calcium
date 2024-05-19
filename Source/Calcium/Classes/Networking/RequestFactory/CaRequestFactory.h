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
- (void)setTyping:(BOOL)typing;
@end

@interface CaRequestFactory : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSURLSessionDelegate>
@property (nonatomic, weak) id<CaRequestFactoryDelegate> delegate;

//Data
@property (nonatomic, strong) NSMutableData *apiaryResponseData;

- (void)startTextRequest:(NSString *)messagePayload withBase64Image:(NSString *)base64Image;
- (void)startTextRequest:(NSString *)messagePayload;
- (void)startImageGenerationRequest:(NSString *)messageContent;
@end

