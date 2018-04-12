//
//  ChatViewController.h
//  Proyolk
//
//  Created by Shiv ram on 31/01/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"

@interface ChatViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, PjsCallBack>
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *userStatus;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userImage;
@property (strong, nonatomic) NSArray *messagesArr;
@property (strong, nonatomic) NSArray *participants;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *onlineStatusLbl;
@property (strong, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) IBOutlet UIView *userDescView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableToDescViewConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableToHeaderConstraint;

@end
