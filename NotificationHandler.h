//
//  NotificationHandler.h
//  Proyolk
//
//  Created by PURPLE on 5/9/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PjsCallBack.h"

@interface NotificationHandler : NSObject<PjsCallBack>
-(void)ManageNotification:(NSArray*)Notidic;
-(void)isTyping:(NSArray*)Notidic;
- (void)handleVideoCallWithMeta:(NSDictionary*)meta data:(NSDictionary*)data;
- (void)handleChatMessage:(NSArray*)message;
- (void)initiateVideoCall:(NSString*)userId;
- (void)showCallNotificationBackground:(NSString*)userId;
- (void)gotoVideoScreen:(NSString*)userId confArr:(NSArray*)confArr isAccepted:(BOOL)isAccepted;
@end
