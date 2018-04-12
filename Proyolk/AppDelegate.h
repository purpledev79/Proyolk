//
//  AppDelegate.h
//  Proyolk
//
//  Created by PURPLE on 2/9/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomingCallAlert.h"
#import "VideoChatController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) NSArray* allFriends;
@property (strong, nonatomic) IncomingCallAlert *incoming;
@property(nonatomic, assign) BOOL callOngoing;
@property (strong, nonatomic) NSMutableArray* conferenceMembers;
@property (strong, nonatomic) VideoChatController* videoController;
@property (strong, nonatomic) NSString* currentChatUser;

@end

/*
 UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
 pass.leftView = paddingView2;
 pass.leftViewMode = UITextFieldViewModeAlways;
 pass.clipsToBounds=YES;

 UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
 name.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName: color}];

 */
