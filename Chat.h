//
//  Chat.h
//  Proyolk
//
//  Created by PURPLE on 4/27/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "CallTo Parent.h"
#import "UIImageView+WebCache.h"
#import "NotificationHandler.h"
@interface Chat : UIViewController<PjsCallBack,CallTo_Parent,UITextViewDelegate,UITextFieldDelegate>{
    NSMutableArray *arrKey;
    NSMutableArray *arrFriendList;
    NSDictionary* conversations;
    NSDictionary* datedConversations;
}
@property(nonatomic,strong)IBOutlet UITableView *chattableView;
@property(nonatomic,strong) NSMutableDictionary *dictionaryByDate;
-(void)isTyping:(NSArray *)data;
-(void) op;

@end
