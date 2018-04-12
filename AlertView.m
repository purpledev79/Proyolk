
#import "AlertView.h"

@implementation AlertView
UIAlertView   *alert;

-(void)showAlertView:(NSString *)Msg
{
    
        alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:Msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        UIImageView *imgMultiples1 =[[UIImageView
                                      alloc]initWithFrame:CGRectMake(0,0, alert.frame.size.width,
                                                                     alert.frame.size.height)]; imgMultiples1.image = [UIImage imageNamed:@"noimg.png"];
        [alert addSubview:imgMultiples1];
        [alert show];
    
}
-(void)showAlertView1:(NSString *)Msg
{
    
    alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:Msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    UIImageView *imgMultiples1 =[[UIImageView
                                  alloc]initWithFrame:CGRectMake(0,0, alert.frame.size.width,
                                                                 alert.frame.size.height)]; imgMultiples1.image = [UIImage imageNamed:@"noimg.png"];
    [alert addSubview:imgMultiples1];
    [alert show];
    
}

-(void)DissmissAlertView
{
        [alert dismissWithClickedButtonIndex:0 animated:NO];
}
-(void)DissmissAlertView2
{
 //   [alert dismissWithClickedButtonIndex:0 animated:NO];
}




@end
