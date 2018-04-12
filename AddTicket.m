//
//  AddTicket.m
//  Proyolk
//
//  Created by iFlame on 15/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "AddTicket.h"
#import "AppDelegate.h"
#import "SavePrefrences.h"
@implementation AddTicket

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
-(void)layoutSubviews{
    [super layoutSubviews];
    selectedIndex = 0;
    imgBuffer = @"";
    arrPriority = [NSMutableArray arrayWithObjects:@"Low",@"Medium",@"High",nil];
    UIPickerView *picker = [[UIPickerView alloc]init];
    picker.delegate = self;
    picker.dataSource = self;
    self.txtPriority.inputView = picker;
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, 320, 44)];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.translucent = YES;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWriting:)];
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    self.txtPriority.inputAccessoryView = toolBar;
    // init your parameters here, like set up fonts, colors, etc...
}
-(IBAction)doneWriting:(id)sender
{
    
    [self.txtPriority resignFirstResponder];
}
-(IBAction)btnSendAction:(id)sender
{
    
    if (self.txtTitle.text.length<=0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk"
    message:@"Enter title ticket." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    else  if (self.txtMessage.text.length<=0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk"
                                                       message:@"Enter Message." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else  if (self.txtPriority.text.length<=0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk"
                                                       message:@"Enter Priority." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
   

    else{
       
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.txtTitle.text forKey:@"title"];
    [dic setObject:self.txtMessage.text forKey:@"des"];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//        if(selectedIndex==0){
//            selectedIndex = 2;
//        }
//        else if (selectedIndex==2){
//            selectedIndex = 0;
//        }
//        else if (selectedIndex==1){
//            selectedIndex = 1;
//        }

    [dic setObject:[NSString stringWithFormat:@"%d",selectedIndex+1] forKey:@"priority"];
    [dic setObject:imgBuffer forKey:@"img"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Support" :@"submitTicket" :@"" :@"" :dic :self ];
    
        
    }
    
    // NSString *strText = [NSString stringWithFormat:@"Old Password :%@\nNew Password :%@\nConfirm Password :%@\n",self.txtOldPassword.text,self.txtPassword.text,self.txtConfirmPassword.text];
    
//    isCallBack=1;
//
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setObject:self.txtOldPassword.text forKey:@"old"];
//    [dic1 setObject:self.txtPassword.text forKey:@"new1"];
//    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    //    if ([self.strFlag integerValue]==0)
//    //    {
//    //        [dic1 setObject:self.txtConfirmPassword.text forKey:@"conf"];
//    //        [dic1 setObject:@"Email Regarding Proyolk ContactUs" forKey:@"sub"];
//    //    }
//    //    else
//    //    {
//    //        [dic1 setObject:self.txtMessage.text forKey:@"cmnt"];
//    //        [dic1 setObject:@"Email Regarding Proyolk Feedback" forKey:@"sub"];
//    //    }
//    
//    //[dic1 setObject:strText forKey:@"txt"];
//    
//    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking":@"chngPass" :@"":@"":dic1 :self];
//    
    
    //   [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    
}
-(IBAction)btnCancelAction:(id)sender{
    [self removeFromSuperview];
}
-(IBAction)btnAttachmentAction:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Mode:"preferredStyle:UIAlertControllerStyleActionSheet];
    
    AppDelegate *del = [[UIApplication sharedApplication]delegate];
    UIViewController *vc1 = [del.window rootViewController];
    UIAlertAction* drivingAction = [UIAlertAction actionWithTitle:@"Use Camera" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action){
                                                              [self openGallary];
                                                              
                                                          }];
    
    UIAlertAction *walkingAction = [UIAlertAction actionWithTitle:@"Use Gallary" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action){
                                                              [self openCamera];
                                                              
                                                          }];
    
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:drivingAction];
    [alert addAction:walkingAction];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
}

-(void)callBack:(NSArray *)meta :(NSArray *)data
{
       [self.delegate getOpenTicket];
    [self removeFromSuperview];
 
}

-(void) openCamera
{
    AppDelegate *del = [[UIApplication sharedApplication]delegate];
    UIViewController *vc1 = [del.window rootViewController];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [vc1 presentViewController:imagePickerController animated:YES completion:nil];
        }];
    }
    else{
        
        [vc1 presentViewController:imagePickerController animated:YES completion:nil];
    }
}

-(void) openGallary
{
    AppDelegate *del = [[UIApplication sharedApplication]delegate];
    UIViewController *vc1 = [del.window rootViewController];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [vc1 presentModalViewController:imagePicker animated:YES];
        randomImgName = [self randomImagName];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Camera Unavailable"  message:@"Unable to find a camera on your device."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Loading...." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage]:[info objectForKey:UIImagePickerControllerOriginalImage];
        NSData* data = UIImageJPEGRepresentation(outputImage, 1.0f);
        imgBuffer= [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [picker dismissViewControllerAnimated:YES completion:nil];
        randomImgName = [self randomImagName];
        self.lblFileName.text = randomImgName;
        // imggeter.image = outputImage;
        
        [alert dismissWithClickedButtonIndex:0 animated:NO];

    }];
    
    }


-(NSString *) randomImagName
{
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
    
    for (int i=0; i<12; i++)
    {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    NSString *rnd=[randomString stringByAppendingString:@".png"];
    
    return rnd;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedIndex = row;
    self.txtPriority.text = [arrPriority objectAtIndex:row];
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  [arrPriority objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrPriority.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}



@end
