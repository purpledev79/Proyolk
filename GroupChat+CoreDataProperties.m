//
//  GroupChat+CoreDataProperties.m
//  Proyolk
//
//  Created by Shiv ram on 16/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "GroupChat+CoreDataProperties.h"

@implementation GroupChat (CoreDataProperties)

+ (NSFetchRequest<GroupChat *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GroupChat"];
}

@dynamic delivered;
@dynamic incoming;
@dynamic messageId;
@dynamic messageText;
@dynamic seen;
@dynamic time;
@dynamic userId;

@end
