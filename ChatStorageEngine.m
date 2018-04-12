//
//  ChatStorageEngine.m
//  Proyolk
//
//  Created by Shiv ram on 27/01/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "ChatStorageEngine.h"
#import "SavePrefrences.h"

static MDMPersistenceController *persistenceController;
static NSFetchedResultsController *fetchedResultsController;

@implementation ChatStorageEngine

//@synthesize persistenceController;

+ (id)sharedManager {
    static ChatStorageEngine *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (NSArray*)loadMessages:(NSString*)forUser {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Messages"];
    fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES] ];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@",forUser];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSInteger count = [persistenceController.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    NSUInteger size = 20;
    count -= size;
    [fetchRequest setFetchOffset:count>0?count:0];
    [fetchRequest setFetchLimit:size];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSArray *results = [persistenceController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!results) {
        NSLog(@"Couldn't fetch last weight: %@", [error localizedDescription]);
    } else {
        
    }
    return results;
}

- (NSArray*)loadGroupMessages {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"GroupChat"];
    fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES] ];
    NSError *error;
    NSInteger count = [persistenceController.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    NSUInteger size = 20;
    count -= size;
    [fetchRequest setFetchOffset:count>0?count:0];
    [fetchRequest setFetchLimit:size];
    [fetchRequest setReturnsObjectsAsFaults:NO];

    NSArray *results = [persistenceController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!results) {
        NSLog(@"Couldn't fetch last weight: %@", [error localizedDescription]);
    } else {
        
    }
    return results;
}

- (NSDictionary*)loadConversations{
    
    @try {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Messages"];
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setPropertiesToFetch:@[@"userId"]];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSError *error;
    NSArray *results = [persistenceController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!results) {
        NSLog(@"Couldn't fetch last weight: %@", [error localizedDescription]);
    } else {
        NSMutableDictionary* conversations = [[NSMutableDictionary alloc] init];
        for (NSDictionary* record in results) {
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Messages"];
            fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO] ];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@",record[@"userId"]];
            [fetchRequest setPredicate:predicate];
            NSError *error;
            [fetchRequest setFetchLimit:1];
            [fetchRequest setReturnsObjectsAsFaults:NO];
            NSArray *lastMessage = [persistenceController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            if (!lastMessage) {
                NSLog(@"Couldn't fetch last message: %@", [error localizedDescription]);
            } else {
                [conversations setObject:lastMessage.firstObject forKey:record[@"userId"]];
            }
        }
        return conversations.copy;
    }
        return nil;
        
    } @catch (NSException *exception) {
        return nil;
    }
}

+ (MDMPersistenceController*)persistenceController{
    return persistenceController;
}

- (id)init {
    if (self = [super init]) {
        NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"ChatModel" withExtension:@"momd"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSURL *storeUrl = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:@"chatmodel.sqlite"]];
        persistenceController = [[MDMPersistenceController alloc] initWithStoreURL:storeUrl modelURL:modelUrl];
    }
    return self;
}

- (void)saveMessage:(NSDictionary*)packet isIncoming:(BOOL)isIncoming{
    if (!packet[@"message"][@"mess"]) {
        return;
    }
    NSLog(@"1. Message Sending start");
    NSString* userId = [NSString stringWithFormat:@"%@", packet[@"uid"]];
    if (isIncoming && [userId isEqualToString:[NSString stringWithFormat:@"%@",[SavePrefrences sharedInstance].uid]]) {
        return;
    }
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Messages"
                                                  inManagedObjectContext:persistenceController.managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Messages"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"messageId == %@",[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", packet[@"message"][@"messId"]]]];
    [fetchRequest setPredicate:predicate];
    NSError *error;
//    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    //ERROR IS HERE
    NSArray *results = [persistenceController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(results.count==0){
        NSLog(@"CATCH");
    }
    if (results.count == 0) {
        NSLog(@"2. Results more then 0");
        Messages *message = [[Messages alloc] initWithEntity:entityDesc
                              insertIntoManagedObjectContext:persistenceController.managedObjectContext];
        if (isIncoming) {
            NSLog(@"3. Incoming..");
            message.userId = userId;
            message.time = [NSString stringWithFormat:@"%@", packet[@"time"]];
            message.messageId = [NSString stringWithFormat:@"%@", packet[@"message"][@"messId"]];
            message.messageText = packet[@"message"][@"mess"];
            message.incoming = YES;
            message.seen = NO;
            message.delivered = NO;
            message.notificationId = packet[@"noti_id"];
            message.fname = packet[@"fname"];
            message.lname = packet[@"lname"];
        }else{
            NSLog(@"3. Sending..");
            if (packet[@"time"]) {
                message.time = [NSString stringWithFormat:@"%@", packet[@"time"]];
            }else{
                double interval = [[NSDate date] timeIntervalSince1970];
                long long timeInt = ((long long)interval*1000);
                message.time = [NSString stringWithFormat:@"%lld", timeInt];
            }
            message.userId = [NSString stringWithFormat:@"%@", packet[@"fruid"]];
            message.messageId = [NSString stringWithFormat:@"%@", packet[@"message"][@"messId"]];
            message.messageText = packet[@"message"][@"mess"];
            message.incoming = NO;
            message.seen = NO;
            message.delivered = NO;
            message.notificationId = @"";
            message.fname = packet[@"fname"];
            message.lname = packet[@"lname"];
        }
        
        if([persistenceController.managedObjectContext save:&error])
        {
            NSLog(@"4. managedObjectContext");
            NSDictionary* userInfo;
            if (isIncoming) {
                userInfo = @{@"uid" : packet[@"uid"]};
            }else
                userInfo = @{@"uid" : packet[@"fruid"]};
            
            NSLog(@"5. Notification Sent");
            [persistenceController saveContextAndWait:YES completion:^(NSError *error) {
                if (error) {
                    NSLog(@"ERROR:%@", [error localizedDescription]);
                }else{
                    [self removeOlderEntries:message.userId];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"IM_MESSAGE_SAVED" object:nil userInfo:userInfo];

                }
            }];
            
        } else {
            NSLog(@"Couldn't save: %@", [error localizedDescription]);
        }
    }
}

- (void)removeOlderEntries:(NSString*)userId{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Messages"];
    fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES] ];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@",userId];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *results = [persistenceController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!results) {
        NSLog(@"Couldn't fetch last weight: %@", [error localizedDescription]);
    } else {
        if (results.count>20) {
            for (int i=0; i<(results.count-20); i++) {
                Messages* msg = results[i];
                [persistenceController.managedObjectContext deleteObject:msg];
                if([persistenceController.managedObjectContext save:&error]) {
                    [persistenceController saveContextAndWait:YES completion:^(NSError *error) {
                        if (error) {
                            NSLog(@"ERROR:%@", [error localizedDescription]);
                        }else NSLog(@"Deleted Older Chat");
                    }];
                } else {
                    NSLog(@"Couldn't save: %@", [error localizedDescription]);
                }
            }
        }
    }

}

- (void)saveGroupMessage:(NSDictionary*)packet isIncoming:(BOOL)isIncoming{
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"GroupChat"
                                                  inManagedObjectContext:persistenceController.managedObjectContext];
    GroupChat *message = [[GroupChat alloc] initWithEntity:entityDesc
                          insertIntoManagedObjectContext:persistenceController.managedObjectContext];
    if (isIncoming) {
        message.userId = [NSString stringWithFormat:@"%@", packet[@"uid"]];
        message.time = [NSString stringWithFormat:@"%@", packet[@"time"]];
        message.messageId = [NSString stringWithFormat:@"%@", packet[@"message"][@"messId"]];
        message.messageText = packet[@"message"][@"mess"];
        message.incoming = YES;
        message.seen = NO;
        message.delivered = NO;
    }else{
        message.userId = [NSString stringWithFormat:@"%@", packet[@"fruid"]];
        double interval = [[NSDate date] timeIntervalSince1970];
        long long timeInt = ((long long)interval*1000);
        message.time = [NSString stringWithFormat:@"%lld", timeInt];
        message.messageId = [NSString stringWithFormat:@"%@", packet[@"message"][@"messId"]];
        message.messageText = packet[@"message"][@"mess"];
        message.incoming = NO;
        message.seen = NO;
        message.delivered = NO;
    }
    
    NSError *error;
    if([persistenceController.managedObjectContext save:&error]) {
        NSDictionary* userInfo;
        userInfo = @{@"uid" : @"000"};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GC_MESSAGE_SAVED" object:nil userInfo:userInfo];
        
        [persistenceController saveContextAndWait:YES completion:^(NSError *error) {
            if (error) {
                NSLog(@"ERROR:%@", [error localizedDescription]);
            }
        }];
    } else {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
}

- (void)saveMessageStatus:(NSString*)messageId isSeen:(BOOL)isSeen isIncoming:(BOOL)isIncoming{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Messages"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"messageId == %@",[NSString stringWithFormat:@"%@", messageId]];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSArray *results = [persistenceController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!results || results.count==0) {
        NSLog(@"Couldn't fetch last weight: %@", [error localizedDescription]);
    } else {
        Messages* message = results[0];
        if (isSeen) {
            message.seen = YES;
            message.delivered = YES;
        }else message.delivered = YES;
        if([persistenceController.managedObjectContext save:&error]) {
            if (isIncoming) {
                NSDictionary* userInfo;
                userInfo = @{@"uid" : message.userId};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"IM_MESSAGE_SAVED" object:nil userInfo:userInfo];
            }
            [persistenceController saveContextAndWait:YES completion:^(NSError *error) {
                if (error) {
                    NSLog(@"ERROR:%@", [error localizedDescription]);
                }
            }];
        } else {
            NSLog(@"Couldn't save: %@", [error localizedDescription]);
        }
    }
}

- (long)getUnreadMessageCount:(NSString*)forUser{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Messages"];
    fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES] ];
    NSPredicate *predicate;
    if (forUser) {
        predicate = [NSPredicate predicateWithFormat:@"userId == %@ AND incoming == YES AND seen == NO",forUser];
    }else predicate = [NSPredicate predicateWithFormat:@"incoming == YES AND seen == NO"];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *results = [persistenceController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!results) {
        NSLog(@"Couldn't fetch last weight: %@", [error localizedDescription]);
    } else {
        
    }
    return results.count;
}

- (void)removeGroupChat{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"GroupChat"];
    NSError *error;
    NSArray *results = [persistenceController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (GroupChat* gc in results) {
        [persistenceController.managedObjectContext deleteObject:gc];
    }
    if([persistenceController.managedObjectContext save:&error]) {
        [persistenceController saveContextAndWait:YES completion:^(NSError *error) {
            if (error) {
                NSLog(@"ERROR:%@", [error localizedDescription]);
            }else NSLog(@"Deleted Group Chat");
        }];
    } else {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
}

@end
