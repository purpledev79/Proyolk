//
//  ContactUs.m
//  Proyolk
//
//  Created by iFlame on 12/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "ContactUs.h"

@implementation ContactUs

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
-(IBAction)btnSendAction:(id)sender{
    
    
    if (![self NSStringIsValidEmail:self.txtEmail.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Please enter valid email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else{
        NSString *strText = [NSString stringWithFormat:@"Name :%@\nEmail :%@\nComments :%@\n",self.txtName.text,self.txtEmail.text,self.txtMessage.text];
        
        isCallback=6;
        
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:self.txtName.text forKey:@"name"];
        [dic1 setObject:self.txtEmail.text forKey:@"email"];
        if ([self.strFlag integerValue]==0) {
            [dic1 setObject:self.txtMessage.text forKey:@"comment"];
            [dic1 setObject:@"Email Regarding Proyolk ContactUs" forKey:@"sub"];
        }
        else{
            [dic1 setObject:self.txtMessage.text forKey:@"cmnt"];
            [dic1 setObject:@"Email Regarding Proyolk Feedback" forKey:@"sub"];
        }
        
        [dic1 setObject:strText forKey:@"txt"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Yolking":@"feedBack" :@"":@"":dic1 :self];
    
    }
    
    
    
   
    //[self removeFromSuperview];
}
-(IBAction)btnCancelAction:(id)sender{
    [self removeFromSuperview];
}

-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    [self removeFromSuperview];
}

@end
