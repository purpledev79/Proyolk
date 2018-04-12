//
//  ViewTicket.h
//  Proyolk
//
//  Created by Padam on 11/17/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTicket : UIView
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtPriority,*txtlastActon,*txtCreated,*txtAttachment;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
- (IBAction)btnCancelAction:(id)sender;

@end
