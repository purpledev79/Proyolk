//
//  Messages+CoreDataProperties.h
//  Proyolk
//
//  Created by Shiv ram on 16/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Messages+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Messages (CoreDataProperties)

+ (NSFetchRequest<Messages *> *)fetchRequest;

@property (nonatomic) BOOL delivered;
@property (nonatomic) BOOL incoming;
@property (nullable, nonatomic, copy) NSString *messageId;
@property (nullable, nonatomic, copy) NSString *messageText;
@property (nullable, nonatomic, copy) NSString *notificationId;
@property (nonatomic) BOOL seen;
@property (nullable, nonatomic, copy) NSString *time;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *fname;
@property (nullable, nonatomic, copy) NSString *lname;

@end

NS_ASSUME_NONNULL_END
