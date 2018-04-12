

#import <UIKit/UIKit.h>

@interface ManageArray : UIViewController
-(NSString *)concatUrl :(NSString *)newurl;
-(BOOL) checkStringNull:(NSString *) str;
-(NSArray *)sortDateAr:(NSArray *) dataAr:(UIViewController *)vc;
-(NSArray *) convertojson:(NSObject *)data;
-(NSString *) timeConverter:(NSString *)ServerTime;
-(BOOL) checkContaine:(NSArray *)msg;
-(long long) getConvertedTimemili;
-(void) showMessageToUser;

@end
