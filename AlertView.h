

#import <UIKit/UIKit.h>

@interface AlertView : UIViewController
@property(nonatomic,strong) UIAlertView *alert;

-(void)showAlertView:(NSString *)Msg;
-(void)DissmissAlertView;
-(void)DissmissAlertView2;
-(void)showAlertView1:(NSString *)Msg;
@end
