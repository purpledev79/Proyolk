//
//  GroupChat+CoreDataProperties.h
//  Proyolk
//
//  Created by Shiv ram on 16/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "GroupChat+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GroupChat (CoreDataProperties)

+ (NSFetchRequest<GroupChat *> *)fetchRequest;

@property (nonatomic) BOOL delivered;
@property (nonatomic) BOOL incoming;
@property (nullable, nonatomic, copy) NSString *messageId;
@property (nullable, nonatomic, copy) NSString *messageText;
@property (nonatomic) BOOL seen;
@property (nullable, nonatomic, copy) NSString *time;
@property (nullable, nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
