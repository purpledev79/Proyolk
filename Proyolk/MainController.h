
#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "CallTo Parent.h"
#import <linkedin-sdk/LISDK.h>
#import "OAuthLoginView.h"
#import <GoogleSignIn/GoogleSignIn.h>
@interface MainController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent,GIDSignInDelegate>

{
    UIImageView *outerImageview;
    UIView *statusbarvw;
    UILabel *plogin;
    UITextView *find1;
    NSString* userNameStr;
    NSString* passwordStr;
}

@property BOOL isRegister;
@property BOOL isTutorial;
@property BOOL isNavigatedFromLanding;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;


@property(nonatomic,strong)IBOutlet UITableView *lefttableView,*righttableView,*cabinetTableview;

@end
