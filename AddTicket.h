//
//  AddTicket.h
//  Proyolk
//
//  Created by iFlame on 15/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTicketDelegate <NSObject>

-(void)getOpenTicket;

@end

@interface AddTicket : UIView{
    NSString *imgBuffer;
    NSString *randomImgName;
    NSMutableArray *arrPriority;
    int selectedIndex;
}
@property(nonatomic,assign)id<AddTicketDelegate> delegate;

-(IBAction)btnSendAction:(id)sender;
-(IBAction)btnCancelAction:(id)sender;
-(IBAction)btnAttachmentAction:(id)sender;
@property(nonatomic,strong) NSString *strFlag;
@property(nonatomic,strong) IBOutlet UILabel *lblTitle,*lblFileName;
@property(nonatomic,strong) IBOutlet UITextField *txtName,*txtEmail,*txtTitle,*txtPriority;
@property(nonatomic,strong) IBOutlet UITextView *txtMessage;

@end
