//
//  ChangePassword.m
//  Proyolk
//
//  Created by iFlame on 12/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "ChangePassword.h"

@implementation ChangePassword

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)viewDidLoad {

 _txtPassword.delegate=self;
 _txtConfirmPassword.delegate=self;
    
}


-(IBAction)btnSendAction:(id)sender
{
    if([_txtPassword.text isEqual:@""] || [_txtConfirmPassword.text isEqual:@""])
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Password and ConfirmPassword" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
    }
    else  if (![_txtPassword.text isEqual:_txtConfirmPassword.text])
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Password Does Not Matched" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return;
    } else {
    
    
   // NSString *strText = [NSString stringWithFormat:@"Old Password :%@\nNew Password :%@\nConfirm Password :%@\n",self.txtOldPassword.text,self.txtPassword.text,self.txtConfirmPassword.text];
    
    isCallBack=1;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:self.txtOldPassword.text forKey:@"old"];
    [dic1 setObject:self.txtPassword.text forKey:@"new1"];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    if ([self.strFlag integerValue]==0)
//    {
//        [dic1 setObject:self.txtConfirmPassword.text forKey:@"conf"];
//        [dic1 setObject:@"Email Regarding Proyolk ContactUs" forKey:@"sub"];
//    }
    //    else
    //    {
    //        [dic1 setObject:self.txtMessage.text forKey:@"cmnt"];
    //        [dic1 setObject:@"Email Regarding Proyolk Feedback" forKey:@"sub"];
    //    }
    
    //[dic1 setObject:strText forKey:@"txt"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking":@"chngPass" :@"":@"":dic1 :self];
    

     //   [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    }
    
}
-(IBAction)btnCancelAction:(id)sender{
    [self removeFromSuperview];
}

-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    [self removeFromSuperview];
}
@end
