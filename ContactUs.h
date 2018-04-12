//
//  ContactUs.h
//  Proyolk
//
//  Created by iFlame on 12/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavePrefrences.h"
@interface ContactUs : UIView{
    int isCallback;
}
-(IBAction)btnSendAction:(id)sender;
-(IBAction)btnCancelAction:(id)sender;
@property(nonatomic,strong) NSString *strFlag;
@property(nonatomic,strong) IBOutlet UILabel *lblTitle;
@property(nonatomic,strong) IBOutlet UITextField *txtName,*txtEmail;
@property(nonatomic,strong) IBOutlet UITextView *txtMessage;
@end
