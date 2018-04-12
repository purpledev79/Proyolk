//
//  IncomingCallAlert.h
//  Proyolk
//
//  Created by Shiv ram on 06/01/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomingCallAlert : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *callerImageView;
@property (strong, nonatomic) IBOutlet UILabel *callerNameLbl;
@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSDictionary* contact;
@property (strong, nonatomic) NSArray* confArr;
@property BOOL isShowing;
- (IBAction)acceptCallAction:(id)sender;
- (IBAction)rejectCallAction:(id)sender;

@end
