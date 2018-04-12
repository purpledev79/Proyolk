//
//  LandingViewController.h
//  Proyolk
//
//  Created by Shiv ram on 03/04/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AKVideoImageView.h>

@interface LandingViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *videoBGView;
- (IBAction)signUpAction:(id)sender;
- (IBAction)loginAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *signUpBtn;

@end
