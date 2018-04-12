//
//  ChangePassword.h
//  Proyolk
//
//  Created by iFlame on 12/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavePrefrences.h"
@interface ChangePassword : UIView
{
    int isCallBack;
}
-(IBAction)btnSendAction:(id)sender;
-(IBAction)btnCancelAction:(id)sender;
@property(nonatomic,strong) IBOutlet UITextField *txtPassword,*txtConfirmPassword,*txtOldPassword;
@property(nonatomic,strong) NSString *strFlag;
@end
