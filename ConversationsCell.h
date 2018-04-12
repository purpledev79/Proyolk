//
//  ConversationsCell.h
//  Proyolk
//
//  Created by Shiv ram on 06/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GIBadgeView.h>

@interface ConversationsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLbl;
@property (strong, nonatomic) IBOutlet UIView *onlineStatus;
@property (strong, nonatomic) IBOutlet UILabel *onlineStatusLbl;
@property (strong, nonatomic) IBOutlet GIBadgeView *chatBadge;
@property (strong, nonatomic) IBOutlet UIImageView *chatIcon;

@end
