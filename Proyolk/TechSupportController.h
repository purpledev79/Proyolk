//
//  TechSupportController.h
//  Proyolk
//
//  Created by Padam on 10/19/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "openChat.h"
#import "AddTicket.h"
#import "SavePrefrences.h"
#import "LeftRightDrawer.h"
#import "BoardPopUp.h"
#import "Podcast.h"
#import "popups.h"
#import "PodcastPopUp.h"
#import "StoragePopUp.h"
#import "AllValidationsViewController.h"
#import "MainController.h"
#import "ManageArray.h"
#import "ViewTicket.h"
@interface TechSupportController : UIViewController
{
    int flag;
    UIButton *btnAdd;
    NSMutableArray *arrTickets;
}
@end
