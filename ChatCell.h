//
//  ChatCell.h
//  Proyolk
//
//  Created by Shiv ram on 31/01/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *messageLbl;
@property (strong, nonatomic) IBOutlet UIImageView *senderImage;
@property (strong, nonatomic) IBOutlet UIImageView *messageStatusIcon;

@end
