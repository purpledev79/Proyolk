//
//  ChatConversationsController.h
//  Proyolk
//
//  Created by Shiv ram on 06/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftRightDrawer.h"
#import "PjsCallBack.h"

@interface ChatConversationsController : UIViewController<UITableViewDataSource, UITableViewDelegate, PjsCallBack>{
    NSDictionary* allConversations;
    NSDictionary* datedConversations;
    LeftRightDrawer* drawer;
}
@property (strong, nonatomic) IBOutlet UITableView *conversationsTable;

@end
