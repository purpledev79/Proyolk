

#import <UIKit/UIKit.h>

@interface SelectCountry : UIViewController

-(void) getCountryList:(UIViewController *) vc;
-(void) getState:(UIViewController*)cc:(NSString*)cid;
-(void) getCity:(UIViewController*)cc:(NSString*)sid;
@end
