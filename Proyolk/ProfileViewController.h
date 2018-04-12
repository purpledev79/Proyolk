//
//  ProfileViewController.h
//  Proyolk
//
//  Created by Shiv ram on 03/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"

@interface ProfileViewController : UIViewController<UIImagePickerControllerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, PjsCallBack>

@property (nonatomic, strong) NSString* userId;

-(void) callMethod:(NSArray *)meta;

@end
