//
//  ChatStorageEngine.h
//  Proyolk
//
//  Created by Shiv ram on 27/01/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDMCoreData.h"
#import "Messages+CoreDataClass.h"
#import "GroupChat+CoreDataClass.h"

@interface ChatStorageEngine : NSObject

//@property (nonatomic, retain) MDMPersistenceController *persistenceController;

+ (id)sharedManager;

+ (MDMPersistenceController*)persistenceController;

- (void)saveMessage:(NSDictionary*)packet isIncoming:(BOOL)isIncoming;

- (void)saveGroupMessage:(NSDictionary*)packet isIncoming:(BOOL)isIncoming;

- (void)saveMessageStatus:(NSString*)messageId isSeen:(BOOL)isSeen isIncoming:(BOOL)isIncoming;

- (NSArray*)loadMessages:(NSString*)forUser;

- (NSArray*)loadGroupMessages;

- (NSDictionary*)loadConversations;

- (void)removeGroupChat;

- (long)getUnreadMessageCount:(NSString*)forUser;
@end
