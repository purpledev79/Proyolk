

#import <UIKit/UIKit.h>
 #import "PjsCallBack.h"
#import "CallTo Parent.h"
@interface ProfileView :UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent>{
    int limit;
}
@property(nonatomic)int strUserId;
@property(nonatomic,strong) NSArray *ProfileAr;
@property(nonatomic,strong) NSString *scrollCtSt;
@property(nonatomic,strong) NSString *isCallBack;
@property(nonatomic,strong) NSArray *countryAr;
@property(nonatomic,retain)NSString *istab;
-(void) showEmployment:(NSArray *) employmntAr;
-(void)showProfileDetail:(UIView *)imgvw;
-(void)addProfileimage:(NSArray*)ProfileAr;
-(void)educationDetail;
@end
