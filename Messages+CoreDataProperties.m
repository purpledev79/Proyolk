//
//  Messages+CoreDataProperties.m
//  Proyolk
//
//  Created by Shiv ram on 16/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Messages+CoreDataProperties.h"

@implementation Messages (CoreDataProperties)

+ (NSFetchRequest<Messages *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Messages"];
}

@dynamic delivered;
@dynamic incoming;
@dynamic messageId;
@dynamic messageText;
@dynamic notificationId;
@dynamic seen;
@dynamic time;
@dynamic userId;
@dynamic fname;
@dynamic lname;

@end
