

#import "MainController.h"
#import "SavePrefrences.h"
#import "AllValidationsViewController.h"
#import "ManageArray.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Yolking.h"
#import "LeftRightDrawer.h"
#import "NotificationHandler.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LandingViewController.h"
//#import <GoogleOpenSource/GoogleOpenSource.h>


@interface MainController ()
{
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIView * actionView,*prMainView;
    UIView *mainView,*loginview,*prlogview ,*lgwith,*videomainview,*main,*mainouterView;
    NSMutableArray *leftAr,*leftImgAr,*rightAr,*rightimgAr ;
    NSArray *dataind,*profilear1;
    UITextField *uname,*pass,*fname,*lname,*midname,*email,*username,*password,*confirmpass;
    UILabel *indus,*NameLabel;
    NSString *indid;
    MainController *vc1;
    NSMutableArray * nwfr,* cbfr,*popUpAr;
    AllValidationsViewController *av;
    int iscallback,isind;
    ManageArray *mngAr;
    UIScrollView *mainScrollView1,*scrollbar;
    NSString *imgBuffer;
    NSString *randomImgName;
    LeftRightDrawer * drawer;
    NotificationHandler *nobj;
    AVPlayer *player;
    NSString * toplay;
    NSString *url;
    UITextField *txt;
    int height;
}
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GIDSignIn sharedInstance].clientID = @"799567353048-uais2r6cipfmfkt5dleaf7ggguevibtu.apps.googleusercontent.com";
    
   
    
     [GIDSignIn sharedInstance].delegate = self;
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    naviWidth = self.navigationController.navigationBar.frame.size.width;
    naviHght =  self.navigationController.navigationBar.frame.size.height;
    stbarHght= (float)[[UIApplication sharedApplication] statusBarFrame].size.height;
    
    [SavePrefrences sharedInstance].screenHeight=screenHeight;
    [SavePrefrences sharedInstance].screenWidth=screenWidth;
    [SavePrefrences sharedInstance].naviHght=naviHght;
    [SavePrefrences sharedInstance].naviWidth=naviWidth;
    [SavePrefrences sharedInstance].stbarHght=stbarHght;
    [SavePrefrences sharedInstance].textsize=20;
    
    drawer=[[LeftRightDrawer alloc]init];
    av=[[AllValidationsViewController alloc]init];
    
    NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
    self.view.backgroundColor=[cc valueForKey:@"bodycolor"];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self loginView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"IS_LOGGED_IN"]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSocketConnection:) name:@"SOCKET_CONNECTED" object:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (_isRegister) {
        [self signIn];
    }
}

- (void)handleSocketConnection:(NSNotification *)notification{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"IS_LOGGED_IN"]) {
        userNameStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"USERNAME"];
        passwordStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"PASSWORD"];
        [self logintoserver:nil];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SOCKET_CONNECTED" object:nil];
}



- (void)keyboardWasShown:(NSNotification *)notification
{
    
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    height = MIN(keyboardSize.height,keyboardSize.width);
    int width = MAX(keyboardSize.height,keyboardSize.width);
    
    NSLog(@"keyboard height is %d",height);
    
}

-(void)loginView
{
    url=@"https://www.proyolk.com";
    toplay=[url stringByAppendingString:@"/upload/provid/wel.mp4"];
    
    [SavePrefrences sharedInstance].uid=@"";
    [SavePrefrences sharedInstance].sid=@"";
    [SavePrefrences sharedInstance].un=@"";
    [SavePrefrences sharedInstance].roleid=@"";
    [SavePrefrences sharedInstance].rl=@"";
    [SavePrefrences sharedInstance].at=@"";
    
    mainScrollView1=[[UIScrollView alloc]initWithFrame:CGRectMake( 0,0,screenWidth,screenHeight)];
    mainScrollView1.backgroundColor=[UIColor colorWithRed:49/255.0f green:61/255.0f blue:77/255.0f alpha:1.0f];
    [self.view addSubview:mainScrollView1];

    
    loginview= [[UIView alloc] initWithFrame:CGRectMake(0,0,mainScrollView1.frame.size.width,mainScrollView1.frame.size.height)];
    loginview.backgroundColor=[UIColor colorWithRed:49/255.0f green:61/255.0f blue:77/255.0f alpha:1.0f];
    [mainScrollView1 addSubview:loginview];
    
    outerImageview= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,screenWidth,screenHeight)];
    outerImageview.backgroundColor=[UIColor darkGrayColor];
  //  outerImageview.image=[UIImage imageNamed:@"splashscreen.png"];
    [loginview addSubview:outerImageview];
    [outerImageview setHidden:YES];
    
//    statusbarvw=[[UIView alloc]initWithFrame:CGRectMake(0, 0,  screenWidth,70)];
//    statusbarvw.backgroundColor =[UIColor colorWithRed:34/255.0f green:42/255.0f blue:54/255.0f alpha:1.0f];
//    
//    [loginview addSubview:statusbarvw];
//    
//    UIImageView *logo =[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 120, 38)];
//    logo.image = [UIImage imageNamed:@"logo_new.png"];
//    logo.backgroundColor=[UIColor clearColor];
//  //  [loginview addSubview:logo];
//    
//    
//    UIImageView *signup =[[UIImageView alloc]initWithFrame:CGRectMake(loginview.frame.size.width-80, 30, 25, 25)];
//    signup.image = [UIImage imageNamed:@"signupicon.png"];
//    signup.backgroundColor=[UIColor clearColor];
//    [loginview addSubview:signup];
//    
//    UITapGestureRecognizer *signges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signIn)];
//    signges.delegate =self;
//    signges.numberOfTapsRequired = 1;
//    signup.userInteractionEnabled = YES;
//    [signup addGestureRecognizer:signges];
//    
//    
//    UIImageView *video =[[UIImageView alloc]initWithFrame:CGRectMake(loginview.frame.size.width-40, 30, 25, 25)];
//    video.image = [UIImage imageNamed:@"playtutorial.png"];
//    video.backgroundColor=[UIColor clearColor];
//    [loginview addSubview:video];
//    
//    UITapGestureRecognizer *videoreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoplay)];
//    videoreg.delegate =self;
//    videoreg.numberOfTapsRequired = 1;
//    video.userInteractionEnabled = YES;
//    [video addGestureRecognizer:videoreg];
//    
    
//    UIImageView *logoicn =[[UIImageView alloc]initWithFrame:CGRectMake(loginview.frame.size.width/2-50,statusbarvw.frame.size.height+statusbarvw.frame.origin.y+10 ,100, 100)];
//
//   // UIImageView *logoicn =[[UIImageView alloc]initWithFrame:CGRectMake(loginview.frame.size.width/2-50,statusbarvw.frame.size.height+40 ,100, 100)];
//    logoicn.image = [UIImage imageNamed:@"mainlogo.png"];
//    logoicn.backgroundColor=[UIColor clearColor];
//    [loginview addSubview:logoicn];
    
    //changed
//    int w =loginview.frame.size.width/2;
//    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(w/2, logoicn.frame.size.height+logoicn.frame.origin.y+10, loginview.frame.size.width/2, 2)];
//    lblLine.backgroundColor=[UIColor whiteColor];
//    [loginview addSubview:lblLine];

    
//    UILabel *welcome=[[UILabel alloc] initWithFrame:CGRectMake(loginview.frame.size.width/2-100, lblLine.frame.size.height+lblLine.frame.origin.y+10, 120, 30)];
//    welcome.backgroundColor=[UIColor clearColor];
//    welcome.textAlignment=NSTextAlignmentRight;
//    welcome.font =[UIFont fontWithName:@"HelveticaNeue" size:20];
//    welcome.textColor=[UIColor whiteColor];
//    welcome.text=@"Welcome To ";
//    [loginview addSubview:welcome];
    
//    UILabel *welcome1=[[UILabel alloc] initWithFrame:CGRectMake(welcome.frame.size.width+welcome.frame.origin.x,lblLine.frame.size.height+lblLine.frame.origin.y+10, 120, 30)];
//    welcome1.backgroundColor=[UIColor clearColor];
//    welcome1.textAlignment=NSTextAlignmentLeft;
//    welcome1.font =[UIFont fontWithName:@"HelveticaNeue" size:20];
//    welcome1.textColor=[UIColor colorWithRed:240.0f/255.0f green:199.0f/255.0f blue:3.0f/255.0f alpha:1.0f];
//    welcome1.text=@" Proyolk";
//    [loginview addSubview:welcome1];
    
    //changed added view
//    UIView *findView=[[UIView alloc]initWithFrame:CGRectMake(loginview.frame.size.width/2-loginview.frame.size.width/2+10, welcome1.frame.size.height+welcome1.frame.origin.y+10, screenWidth-20, 30)];
//    findView.layer.cornerRadius=5;
//    findView.backgroundColor =[UIColor colorWithRed:170.0/255.0f green:170.0/255.0f blue:170.0/255.0f alpha:0.30f];
//    [loginview addSubview:findView];
//
//    UIView *lblDot=[[UIView alloc] initWithFrame:CGRectMake(findView.frame.size.width/2-80, findView.frame.size.height/2-3, 6, 6)];
//    lblDot.backgroundColor=[UIColor whiteColor];
//    lblDot.layer.cornerRadius=3;
//    [findView addSubview:lblDot];

//    UIView *lblDot2=[[UIView alloc] initWithFrame:CGRectMake(findView.frame.size.width/2+42, findView.frame.size.height/2-3, 6, 6)];
//    lblDot2.backgroundColor=[UIColor whiteColor];
//    lblDot2.layer.cornerRadius=3;
//    [findView addSubview:lblDot2];
//
//   // UILabel *find=[[UILabel alloc] initWithFrame:CGRectMake(loginview.frame.size.width/2-loginview.frame.size.width/2, welcome.frame.size.height+welcome.frame.origin.y+10, screenWidth-5, 20)];
//    
//    
//    UILabel *findLbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, findView.frame.size.width, findView.frame.size.height)];
//    findLbl.backgroundColor=[UIColor clearColor];
//    findLbl.textAlignment=NSTextAlignmentCenter;
//    findLbl.font =[UIFont fontWithName:@"HelveticaNeue" size:12];
//    findLbl.textColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    findLbl.text=@"Find Jobs      Video Conferencing      Stream Podcast";
//    [findView addSubview:findLbl];
    

    
//    find1=[[UITextView alloc] initWithFrame:CGRectMake(10, findView.frame.size.height+findView.frame.origin.y+15, screenWidth-20, 100)];
//    find1.userInteractionEnabled=NO;
//    find1.backgroundColor=[UIColor clearColor];
//    find1.textAlignment=NSTextAlignmentCenter;
//    find1.font =[UIFont fontWithName:@"HelveticaNeue" size:14];
//    find1.textColor=[UIColor whiteColor];
//    find1.text=@" Proyolk is a virtual incubator for professionals,businesses, start-ups and students. Proyolk facilitates real time collaboration, peer-to-peer communication and self learning through workshops. ";
//    find1.editable=NO;
//    [loginview addSubview:find1];
    
    
    prlogview= [[UIView alloc] initWithFrame:CGRectMake(20,find1.frame.size.height+find1.frame.origin.y+30,(screenWidth-20)/2-50,40)];
    prlogview.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:199.0f/255.0f blue:3.0f/255.0f alpha:1.0f];
    prlogview.layer.cornerRadius=10;
    [self.view addSubview:prlogview];
    
    plogin=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,prlogview.frame.size.width , prlogview.frame.size.height )];
    plogin.backgroundColor=[UIColor clearColor];
    plogin.textColor=[UIColor colorWithRed:49.0f/255.0f green:61.0f/255.0f blue:77.0f/255.0f alpha:2.0f];
    //changed Proyolk Login to login
    plogin.text=@"Login";
    plogin.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
   // plogin.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    //[UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f]
    plogin.textAlignment = NSTextAlignmentCenter;

    [prlogview addSubview:plogin];
    
    
    UITapGestureRecognizer *loginges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    loginges.delegate =self;
    loginges.numberOfTapsRequired = 1;
    plogin.userInteractionEnabled = YES;
    [plogin addGestureRecognizer:loginges];
    
    
    lgwith= [[UIView alloc] initWithFrame:CGRectMake(prlogview.frame.size.width+60,find1.frame.size.height+find1.frame.origin.y+30,(screenWidth-20)/2-20,40)];
    lgwith.backgroundColor=[UIColor clearColor];
    lgwith.layer.cornerRadius=10;
    [self.view addSubview:lgwith];
    
    
    NSMutableArray *imglogo=[[NSMutableArray alloc]init];
    [imglogo addObject:@"fb.png"];
    //[imglogo addObject:@"twitter.png"];
    [imglogo addObject:@"google.png"];
    [imglogo addObject:@"in.png"];
    
    NSMutableArray *colorDic=[[NSMutableArray alloc]init];
    
    [colorDic addObject:[UIColor colorWithRed:59.0f/255.0f green:89.0f/255.0f blue:152.0f/255.0f alpha:1.0f]];
 //   [colorDic addObject:[UIColor colorWithRed:0.0f/255.0f green:172.0f/255.0f blue:137.0f/255.0f alpha:1.0f]];
    [colorDic addObject:[UIColor colorWithRed:244.0f/255.0f green:67.0f/255.0f blue:64.0f/255.0f alpha:1.0f]];
    [colorDic addObject:[UIColor colorWithRed:1.0f/255.0f green:119.0f/255.0f blue:181.0f/255.0f alpha:1.0f]];
    
    
    int left=lgwith.frame.size.width/4;
    int xsp=left;
    //changed enabled
    for(int x=0;x<[imglogo count];x++)
    {
        UIButton *imglog =[[UIButton alloc]initWithFrame:CGRectMake(xsp,0 ,left, lgwith.frame.size.height)];
        [imglog setImage:[UIImage imageNamed:[imglogo objectAtIndex:x]] forState:UIControlStateNormal];
        if(x==0)
        {
            imglog.layer.cornerRadius=5;
        }
        [imglog addTarget:self action:@selector(Loginhere:) forControlEvents:UIControlEventTouchUpInside];
        imglog.backgroundColor=[colorDic objectAtIndex:x];
        imglog.tag=x;
        [lgwith addSubview:imglog];
        xsp=xsp+left;
    }
   
    
    [self login];

}

-(void)loginWithFacebook:(UITapGestureRecognizer*)sender{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSLog(@"fetched user:%@", result);
            }
        }];
        
    }
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"email"]fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
            
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
        } else {
            NSLog(@"Logged in");
            [self fetchUserInfo];
        }
    }];
}

-(IBAction)Loginhere:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if((int)btn.tag==0)
    {
    
        if ([FBSDKAccessToken currentAccessToken]) {
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSLog(@"fetched user:%@", result);
                }
            }];
            
        }
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions: @[@"email"]fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                NSLog(@"Process error");
                
            } else if (result.isCancelled) {
                NSLog(@"Cancelled");
            } else {
                NSLog(@"Logged in");
                [self fetchUserInfo];
            }
        }];
        
        
    }
    
    else if((int)btn.tag==1)
    {
       
        [[GIDSignIn sharedInstance]signIn];
        
        
//        [[GIDSignIn sharedInstance] signIn];
//        int x=0;
//        int sum=9*3;
//        NSLog(@"Sum of two number is====%d",sum);
        //
        //        GPPSignIn *signIn = [GPPSignIn sharedInstance;]
        //        signIn.shouldFetchGooglePlusUser = YES;
        //
        //         static NSString * const kClientId = @"1002942129263-b2phd9a55uvmphnja8259rmsb3cekmk4.apps.googleusercontent.com";
        //         signIn.clientID = kClientId;
        //        signIn.scopes = @[ kGTLAuthScopePlusLogin ];
        //               signIn.delegate = self;
        //
    }
    
    else if((int)btn.tag==2)
    {
        self.oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginViewDidFinish:)
                                                     name:@"loginViewDidFinish"
                                                   object:self.oAuthLoginView];
        
        [self presentViewController:self.oAuthLoginView animated:YES completion:nil];
        
//
    }
    
    
}
-(void)LinkedInacess
{
    NSLog(@"Inside Linked in access");
    
    [[LISDKAPIHelper sharedInstance] getRequest:@"https://api.linkedin.com/v1/people/~" success:^(LISDKAPIResponse *response)
     {
         NSData* data = [response.data dataUsingEncoding:NSUTF8StringEncoding];
         NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"Authenticated user name : %@ %@", [dictResponse valueForKey: @"firstName"], [dictResponse valueForKey: @"lastName"]);
     }error:^(LISDKAPIError *apiError)
     {
         NSLog(@"Error : %@", apiError);
     }];
    
}


#pragma mark - Login via Linked In

-(void) loginViewDidFinish:(NSNotification*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // We're going to do these calls serially just for easy code reading.
    // They can be done asynchronously
    // Get the profile, then the network updates
    [self profileApiCall];
    
}

- (void)profileApiCall
{
    //    NSURL *url = [NSURL URLWithString:@"http://api.linkedin.com/v1/people/~"];
    NSURL *url = [NSURL URLWithString:@"https://api.linkedin.com/v1/people/~:(id,picture-url,firstName,lastName,email-address)?format=json"];
    
    OAMutableURLRequest *request =
    [[OAMutableURLRequest alloc] initWithURL:url
                                    consumer:_oAuthLoginView.consumer
                                       token:_oAuthLoginView.accessToken
                                    callback:nil
                           signatureProvider:nil];
    
    [request setValue:@"json" forHTTPHeaderField:@"x-li-format"];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(profileApiCallResult:didFinish:)
                  didFailSelector:@selector(profileApiCallResult:didFail:)];
}

- (void)profileApiCallResult:(OAServiceTicket *)ticket didFinish:(NSData *)data
{
    NSString *responseBody = [[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding];
    
    NSDictionary *profile = [responseBody objectFromJSONString];
    
    if ([profile valueForKey:@"status"] != nil) {
    }
    else{
        if ( profile )
        {
            NSMutableDictionary *dictParam = [[NSMutableDictionary alloc] init];
            NSString * emailid=  [profile valueForKey:@"emailAddress"];
            NSString *frstname=[profile valueForKey:@"firstName"];
            NSString *lastname=[profile valueForKey:@"lastName"];
            
            
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setValue:emailid forKey:@"email"];
            [dic setValue:frstname forKey:@"first_name"];
            [dic setValue:lastname forKey:@"last_name"];
            
            iscallback=4;
            
            [[SavePrefrences sharedInstance].skthand emitData:@"Home" :@"fbLog" :@"" :@"" :dic :self];
        
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)profileApiCallResult:(OAServiceTicket *)ticket didFail:(NSData *)error
{
    NSLog(@"profileApiCallResult : %@",[error description]);
}




-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"resultis:%@",result);
                 
                 NSString * emailid=  [result valueForKey:@"email"];
                 NSString *frstname=[result valueForKey:@"first_name"];
                 NSString *lastname=[result valueForKey:@"last_name"];
                 
                 
                 NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                 [dic setValue:emailid forKey:@"email"];
                 [dic setValue:frstname forKey:@"first_name"];
                 [dic setValue:lastname forKey:@"last_name"];
                 
                 iscallback=4;
                 
                 [[SavePrefrences sharedInstance].skthand emitData:@"Home" :@"fbLog" :@"" :@"" :dic :self];
                 
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
    
}


-(void)videoplay
{
    [videomainview removeFromSuperview];
    [player pause];
    videomainview = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    videomainview.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];
    [self.view addSubview:videomainview];
    
    UIView *innerVideopop = [[UIView alloc] initWithFrame:CGRectMake(20,100,[SavePrefrences sharedInstance].screenWidth-40,[SavePrefrences sharedInstance].screenHeight-350)];
    innerVideopop.backgroundColor=[UIColor blackColor];
    [videomainview addSubview:innerVideopop];
    
    //NSURL *videoURL = [NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    
    @try {
        NSURL *videoURL = [NSURL URLWithString:toplay];
        
        NSLog(@"video pppp===%@",toplay);
        
        player = [AVPlayer playerWithURL:videoURL];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        
        playerLayer.frame = CGRectMake(0, 10, innerVideopop.frame.size.width, innerVideopop.frame.size.height);
        [innerVideopop.layer addSublayer:playerLayer];
        [player play];
        
        float wid=innerVideopop.frame.size.width/4;
        
        
        NSMutableArray * images=[[NSMutableArray alloc]init];
        [images addObject:@"screenshortone.png"];
        [images addObject:@"screenshorttwo.png"];
        [images addObject:@"screenshortthree.png"];
        [images addObject:@"screenshortwel.png"];
        
        int xsp=23;
        
        
        for(int x=0;x<[images count];x++)
        {
            UIImageView *imglog =[[UIImageView alloc]initWithFrame:CGRectMake(xsp, innerVideopop.frame.size.height+innerVideopop.frame.origin.y+10,wid-5, 80)];
            imglog.image = [UIImage imageNamed:[images objectAtIndex:x]];
            [videomainview addSubview:imglog];
            xsp=xsp+wid;
            
            UITapGestureRecognizer *imglogreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeVideo:)];
            imglogreg.delegate =self;
            imglog.tag=x;
            imglogreg.numberOfTapsRequired = 1;
            imglog.userInteractionEnabled = YES;
            [imglog addGestureRecognizer:imglogreg];
        }
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception=====%@",exception);
    }
    
    NSLog(@"all urls=====%@",toplay);
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(videomainview.frame.size.width/2-50, innerVideopop.frame.size.height+innerVideopop.frame.origin.y+110, 100, 40)];
    [save setTitle: @"Dismiss" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor blackColor];
    save.layer.borderColor=[[UIColor whiteColor] CGColor];
    save.layer.borderWidth=1;
    [save addTarget:self action:@selector(dissmissVideo:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [videomainview addSubview:save];
    
    
}


-(void)changeVideo:(id)sender
{
    UITapGestureRecognizer * tg=(UITapGestureRecognizer *)sender;
    int tagid=(int)tg.view.tag;
    
    
    
    if(tagid==0)
    {
        toplay=[url stringByAppendingString:@"/upload/provid/pro1.mp4"];
    }
    else if(tagid==2)
    {
        toplay=[url stringByAppendingString:@"/upload/provid/pro2.mp4"];
    }
    else if (tagid==3)
    {
        toplay=[url stringByAppendingString:@"/upload/provid/pro3.mp4"];
    }
    else
    {
        toplay=[url stringByAppendingString:@"/upload/provid/wel.mp4"];
    }
    
    [self videoplay];
}

-(IBAction)btnRegister:(id)sender
{
    [self signIn];
}


-(IBAction)dissmissVideo:(id)sender
{
    [player pause];
    [videomainview removeFromSuperview];
}

-(void)signIn
{
    NSLog(@"signin pressed");
    
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,actionView.frame.size.height,screenWidth,screenHeight)];
    mainView.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.1f];
    [self.view addSubview:mainView];
    
    UIView *popupy= [[UIView alloc] initWithFrame:CGRectMake(20,60,screenWidth-40,50)];
    //popupy.backgroundColor=[UIColor colorWithRed:247.0f/255.0f green:199.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
    popupy.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    popupy.layer.cornerRadius=10;

    [mainView addSubview:popupy];
    
    UILabel *prsign=[[UILabel alloc] initWithFrame:CGRectMake(0, 10,popupy.frame.size.width , 30)];
    prsign.backgroundColor=[UIColor clearColor];
    prsign.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    prsign.textAlignment=NSTextAlignmentCenter;
    prsign.text=@"Join Proyolk Now-It`s Free !";
    prsign.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //prsign.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
    
    
    [popupy addSubview:prsign];
    
    
    
    UIScrollView  *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, popupy.frame.size.height+popupy.frame.origin.y-15, screenWidth-40, screenHeight-130)];
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.backgroundColor=[UIColor colorWithRed:214.0f/255.0f green:224.0f/255.0f blue:232.0f/255.0f alpha:1.0f];//[ff valueForKey:@"popupcolor"];
    
    scrollView.layer.cornerRadius=10;
    
    [mainView addSubview:scrollView];
    
    
    fname=[[UITextField alloc] initWithFrame:CGRectMake(10, 20,scrollView.frame.size.width-20 , 35)];
    fname.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    fname.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    fname.delegate = self;
   // fname.placeholder=@"First Name";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    fname.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];

    //fname.layer.cornerRadius=5;
    fname.delegate=self;
    // fname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    fname.userInteractionEnabled=YES;
    fname.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    fname.leftView = paddingView;
    fname.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    [scrollView addSubview:fname];
    
    
    
    
    midname=[[UITextField alloc] initWithFrame:CGRectMake(10, fname.frame.size.height+fname.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
     midname.delegate = self;
    midname.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    midname.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    ///////////////
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    midname.leftView = paddingView1;
    midname.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    
   // midname.placeholder=@"Middle Name";
    midname.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Middle Name" attributes:@{NSForegroundColorAttributeName: color}];

    // midname.layer.cornerRadius=5;
    midname.delegate=self;
    // midname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    midname.userInteractionEnabled=YES;
    midname.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    // midname.layer.borderWidth=2.0f;
    [scrollView addSubview:midname];
    
    
    
    lname=[[UITextField alloc] initWithFrame:CGRectMake(10, midname.frame.size.height+midname.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
       lname.delegate = self;
   // lname.backgroundColor=[UIColor whiteColor];
   // lname.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    lname.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    lname.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    ///////////////
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    lname.leftView = paddingView2;
    lname.leftViewMode = UITextFieldViewModeAlways;
    ////////////

   // lname.placeholder=@"Last Name";
   // UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    lname.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];

    //lname.layer.cornerRadius=5;
    lname.delegate=self;
    // lname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    lname.userInteractionEnabled=YES;
    lname.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    // lname.layer.borderWidth=2.0f;
    [scrollView addSubview:lname];
    
    
    email=[[UITextField alloc] initWithFrame:CGRectMake(10, lname.frame.size.height+lname.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
     email.delegate = self;
   // email.backgroundColor=[UIColor whiteColor];
   // email.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    ///////////////
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    email.leftView = paddingView3;
    email.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    email.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    email.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

  //  email.placeholder=@"Email";
   // UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    email.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];

    // email.layer.cornerRadius=5;
    email.delegate=self;
    // email.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    email.userInteractionEnabled=YES;
    email.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    //  email.layer.borderWidth=2.0f;
    [scrollView addSubview:email];
    
    
    
    
    username=[[UITextField alloc] initWithFrame:CGRectMake(10, email.frame.size.height+email.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
     username.delegate = self;
    //username.backgroundColor=[UIColor whiteColor];
   // username.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    username.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    username.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    ///////////////
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    username.leftView = paddingView4;
    username.leftViewMode = UITextFieldViewModeAlways;
    ////////////

 //   username.placeholder=@"User Name";
    username.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: color}];

    // username.layer.cornerRadius=5;
    username.delegate=self;
    //  username.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    username.userInteractionEnabled=YES;
    username.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    // username.layer.borderWidth=2.0f;
    [scrollView addSubview:username];
    

    password=[[UITextField alloc] initWithFrame:CGRectMake(10, username.frame.size.height+username.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
  //  password.backgroundColor=[UIColor whiteColor];
  //  password.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    password.delegate = self;
    password.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    password.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    ///////////////
    UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    password.leftView = paddingView5;
    password.leftViewMode = UITextFieldViewModeAlways;
    ////////////

   // password.placeholder=@"Password";
    password.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];

    // password.layer.cornerRadius=5;
    password.delegate=self;
    //  password.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    password.userInteractionEnabled=YES;
    password.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    // password.layer.borderWidth=2.0f;
    password.secureTextEntry=YES;
    [scrollView addSubview:password];
    
    
    confirmpass=[[UITextField alloc] initWithFrame:CGRectMake(10, password.frame.size.height+password.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
   // confirmpass.backgroundColor=[UIColor whiteColor];
  //  confirmpass.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    confirmpass.delegate = self;
    confirmpass.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    confirmpass.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    ///////////////
    UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    confirmpass.leftView = paddingView6;
    confirmpass.leftViewMode = UITextFieldViewModeAlways;
    ////////////

   // confirmpass.placeholder=@"Confirm Password";
    confirmpass.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];

    // confirmpass.layer.cornerRadius=5;
    confirmpass.delegate=self;
    //confirmpass.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    confirmpass.userInteractionEnabled=YES;
    confirmpass.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    // confirmpass.layer.borderWidth=2.0f;
    confirmpass.secureTextEntry=YES;
    [scrollView addSubview:confirmpass];
    
    
    
    indus=[[UILabel alloc] initWithFrame:CGRectMake(10, confirmpass.frame.size.height+confirmpass.frame.origin.y+10,scrollView.frame.size.width-10 , 40)];
    indus.textColor=[UIColor darkGrayColor];
    indus.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
   // confirmpass.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    //colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    indus.text=@" Select";
    // indus.layer.cornerRadius=5;
    //  indus.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    indus.userInteractionEnabled=YES;
    indus.clipsToBounds=YES;
    indus.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    //  indus.layer.borderWidth=2.0f;
    [scrollView addSubview:indus];
    
    UITapGestureRecognizer *lndges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInduct)];
    lndges.delegate =self;
    lndges.numberOfTapsRequired = 1;
    indus.userInteractionEnabled = YES;
    [indus addGestureRecognizer:lndges];

    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(0, indus.frame.origin.y+indus.frame.size.height+20, scrollView.frame.size.width/2, 35)];
    [save setTitle: @"Sign Up" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];
    [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    
    [save addTarget:self action:@selector(signuptoserver:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [scrollView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(scrollView.frame.size.width/2, indus.frame.origin.y+indus.frame.size.height+20, scrollView.frame.size.width/2, 35)];
    [cancel setTitle: @"Close" forState: UIControlStateNormal];
    cancel.layer.cornerRadius=5;
    cancel.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];
    [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [cancel addTarget:self action:@selector(cancelRegistration) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [scrollView addSubview:cancel];
    
    
    scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width,cancel.frame.size.height+cancel.frame.origin.y+20);
    
    
    
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.width,cancel.frame.size.height+cancel.frame.origin.y);
}

/*{
    NSLog(@"signin pressed");
    
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,actionView.frame.size.height,screenWidth,screenHeight)];
    mainView.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.1f];
    [self.view addSubview:mainView];
    
    UIView *popupy= [[UIView alloc] initWithFrame:CGRectMake(20,60,screenWidth-40,50)];
    //popupy.backgroundColor=[UIColor colorWithRed:247.0f/255.0f green:199.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
    popupy.backgroundColor=[UIColor colorWithRed:214.0f/255.0f green:224.0f/255.0f blue:232.0f/255.0f alpha:1.0f];

    [mainView addSubview:popupy];
    
    UILabel *prsign=[[UILabel alloc] initWithFrame:CGRectMake(0, 10,popupy.frame.size.width , 30)];
    prsign.backgroundColor=[UIColor clearColor];
    prsign.textColor=[UIColor colorWithRed:58.0f/255.0f green:67.0f/255.0f blue:107.0f/255.0f alpha:1.0f];
    prsign.textAlignment=NSTextAlignmentCenter;
    prsign.text=@"Join Proyolk Now-It`s Free !";
    prsign.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //prsign.font=[UIFont fontWithName:@"HelveticaNeue" size:16];

    
    [popupy addSubview:prsign];
    
    
    
    UIScrollView  *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, popupy.frame.size.height+popupy.frame.origin.y, screenWidth-40, screenHeight-230)];
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.backgroundColor=[UIColor colorWithRed:214.0f/255.0f green:224.0f/255.0f blue:232.0f/255.0f alpha:1.0f];//[ff valueForKey:@"popupcolor"];
    [mainView addSubview:scrollView];
    
    
    
    fname=[[UITextField alloc] initWithFrame:CGRectMake(10, 20,scrollView.frame.size.width-20 , 35)];
    fname.backgroundColor=[UIColor whiteColor];
    fname.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    fname.placeholder=@" First Name";
    fname.layer.cornerRadius=5;
    fname.delegate=self;
    fname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    fname.userInteractionEnabled=YES;
    fname.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    fname.layer.borderWidth=2.0f;
    [scrollView addSubview:fname];
    
    
    lname=[[UITextField alloc] initWithFrame:CGRectMake(10, fname.frame.size.height+fname.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
    lname.backgroundColor=[UIColor whiteColor];
    lname.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    lname.placeholder=@" Last Name";
    lname.layer.cornerRadius=5;
    lname.delegate=self;
    lname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    lname.userInteractionEnabled=YES;
    lname.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    lname.layer.borderWidth=2.0f;
    [scrollView addSubview:lname];
    
    
    
    midname=[[UITextField alloc] initWithFrame:CGRectMake(10, lname.frame.size.height+lname.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
    midname.backgroundColor=[UIColor whiteColor];
    midname.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    midname.placeholder=@" Middle Name";
    midname.layer.cornerRadius=5;
    midname.delegate=self;
    midname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    midname.userInteractionEnabled=YES;
    midname.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    midname.layer.borderWidth=2.0f;
    [scrollView addSubview:midname];
    
    email=[[UITextField alloc] initWithFrame:CGRectMake(10, midname.frame.size.height+midname.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
    email.backgroundColor=[UIColor whiteColor];
    email.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    email.placeholder=@" Email";
    email.layer.cornerRadius=5;
    email.delegate=self;
    email.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    email.userInteractionEnabled=YES;
    email.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    email.layer.borderWidth=2.0f;
    [scrollView addSubview:email];
    
    
    
    indus=[[UILabel alloc] initWithFrame:CGRectMake(10, email.frame.size.height+email.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
    indus.backgroundColor=[UIColor whiteColor];
    indus.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    indus.text=@"Select Industry";
    indus.layer.cornerRadius=5;
    indus.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    indus.userInteractionEnabled=YES;
    indus.clipsToBounds=YES;
    indus.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    indus.layer.borderWidth=2.0f;
    [scrollView addSubview:indus];
    
    UITapGestureRecognizer *lndges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInduct)];
    lndges.delegate =self;
    lndges.numberOfTapsRequired = 1;
    indus.userInteractionEnabled = YES;
    [indus addGestureRecognizer:lndges];
    
    
    username=[[UITextField alloc] initWithFrame:CGRectMake(10, indus.frame.size.height+indus.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
    username.backgroundColor=[UIColor whiteColor];
    username.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    username.placeholder=@" Username";
    username.layer.cornerRadius=5;
    username.delegate=self;
    username.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    username.userInteractionEnabled=YES;
    username.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    username.layer.borderWidth=2.0f;
    [scrollView addSubview:username];
    
    
    password=[[UITextField alloc] initWithFrame:CGRectMake(10, username.frame.size.height+username.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
    password.backgroundColor=[UIColor whiteColor];
    password.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    password.placeholder=@" Password";
    password.layer.cornerRadius=5;
    password.delegate=self;
    password.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    password.userInteractionEnabled=YES;
    password.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    password.layer.borderWidth=2.0f;
    password.secureTextEntry=YES;
    [scrollView addSubview:password];
    
    
    confirmpass=[[UITextField alloc] initWithFrame:CGRectMake(10, password.frame.size.height+password.frame.origin.y+10,scrollView.frame.size.width-20 , 35)];
    confirmpass.backgroundColor=[UIColor whiteColor];
    confirmpass.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
    confirmpass.placeholder=@"Confirm Password";
    confirmpass.layer.cornerRadius=5;
    confirmpass.delegate=self;
    confirmpass.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
    confirmpass.userInteractionEnabled=YES;
    confirmpass.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    confirmpass.layer.borderWidth=2.0f;
    confirmpass.secureTextEntry=YES;
    [scrollView addSubview:confirmpass];
    
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35, confirmpass.frame.origin.y+confirmpass.frame.size.height+10, scrollView.frame.size.width/2-40, 35)];
    [save setTitle: @"Sign Up" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];
    [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    
    [save addTarget:self action:@selector(signuptoserver:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:58.0f/255.0f green:67.0f/255.0f blue:107.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [scrollView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+15, confirmpass.frame.origin.y+confirmpass.frame.size.height+10, popupy.frame.size.width/2-40, 35)];
    [cancel setTitle: @"Close" forState: UIControlStateNormal];
    cancel.layer.cornerRadius=5;
    cancel.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];
    [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [cancel addTarget:self action:@selector(dismiss1:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:58.0f/255.0f green:67.0f/255.0f blue:107.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [scrollView addSubview:cancel];
    
    
    
    
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.width,cancel.frame.size.height+cancel.frame.origin.y+20);
}*/

-(void)login
{
    
    [mainScrollView1 setUserInteractionEnabled:YES];
    //[outerImageview setHidden:NO];
    [prlogview setHidden:YES];
    [lgwith setHidden:YES];
    
    
   // mainView= [[UIView alloc] initWithFrame:CGRectMake(0,actionView.frame.size.height-20,screenWidth,screenHeight)];
    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,statusbarvw.frame.size.height+20,screenWidth,screenHeight)];
    mainView.backgroundColor=[UIColor colorWithRed:10/255.0f green:34/255.0f blue:41/255.0f alpha:.0f];
    [self.view addSubview:mainView];
    
    [mainView setHidden:YES];
  //  UIView *outerview= [[UIView alloc] initWithFrame:CGRectMake(20,screenHeight/2,screenWidth-40,screenHeight/2-100)];

    UIView *outerview= [[UIView alloc] initWithFrame:CGRectMake(20, 100,screenWidth-40, self.view.frame.size.height-230)];
    outerview.backgroundColor=[UIColor clearColor];
    outerview.layer.cornerRadius=15;
    [loginview addSubview:outerview];
    
    //Proyolk Logo
    
    UIImageView* logoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, screenWidth-40, 36)];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    [logoView setImage:[UIImage imageNamed:@"proyolk_logo"]];
    [loginview addSubview:logoView];
    
    //Facebook Login View
    
    UIView* fbView = [[UIView alloc] initWithFrame:CGRectMake(10, 40, outerview.frame.size.width-20, 44)];
    [fbView setBackgroundColor:[UIColor colorWithRed:0.23 green:0.28 blue:0.53 alpha:1.0]];
    [fbView.layer setCornerRadius:3];
    [outerview addSubview:fbView];
    
    UIImageView* fbIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 24, 24)];
    [fbIcon setContentMode:UIViewContentModeScaleAspectFit];
    [fbIcon setImage:[UIImage imageNamed:@"facebook_icon"]];
    [fbView addSubview:fbIcon];
    
    UILabel* fbLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, fbView.frame.size.width, 44)];
    [fbLbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
    [fbLbl setTextAlignment:NSTextAlignmentCenter];
    [fbLbl setTextColor:[UIColor whiteColor]];
    [fbLbl setText:@"Sign up using Facebook"];
    [fbView addSubview:fbLbl];
    
    UITapGestureRecognizer* fbBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginWithFacebook:)];
    [fbBtn setNumberOfTapsRequired:1];
    [fbView addGestureRecognizer:fbBtn];
    
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    
    UILabel* orLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, fbView.frame.origin.y+50, outerview.frame.size.width, 44)];
    [orLbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
    [orLbl setTextAlignment:NSTextAlignmentCenter];
    [orLbl setTextColor:color];
    [orLbl setText:@"Or"];
    [outerview addSubview:orLbl];

    
  //  int onfith= outerview.frame.size.height/5;
    
    uname=[[UITextField alloc] initWithFrame:CGRectMake(10, fbView.frame.size.height+fbView.frame.origin.y+50,outerview.frame.size.width-20 , 40)];
    uname.backgroundColor=[UIColor colorWithRed:85.0f/255.0f green:102.0f/255.0f blue:128.0f/255.0f alpha:0.30f];
    uname.textColor=[UIColor colorWithRed:204.0f/255.0f green:214.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
 //   uname.placeholder=@"Username";
    
    uname.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];

    uname.layer.cornerRadius=2;
    uname.delegate=self;
    uname.layer.cornerRadius = 3;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    uname.leftView = paddingView1;
    uname.leftViewMode = UITextFieldViewModeAlways;
    uname.userInteractionEnabled=YES;
    uname.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
    [outerview addSubview:uname];
    
   UIImageView *unameImg=[[UIImageView alloc] initWithFrame:CGRectMake(uname.frame.size.width-26, uname.frame.origin.y+6, 26 , 26)];
    unameImg.image=[UIImage imageNamed:@"loginicon.png"];
    [outerview addSubview:unameImg];

    
    pass=[[UITextField alloc] initWithFrame:CGRectMake(10, uname.frame.size.height+uname.frame.origin.y+20,outerview.frame.size.width-20, 40)];
    pass.backgroundColor=[UIColor colorWithRed:85.0f/255.0f green:102.0f/255.0f blue:128.0f/255.0f alpha:0.30f];
    pass.textColor=[UIColor colorWithRed:204.0f/255.0f green:214.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
    pass.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    pass.layer.cornerRadius=3;
    pass.delegate=self;
    pass.userInteractionEnabled=YES;
    pass.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    pass.leftView = paddingView2;
    pass.leftViewMode = UITextFieldViewModeAlways;
    pass.secureTextEntry=YES;
    [outerview addSubview:pass];
    
    
    UIImageView *passImg=[[UIImageView alloc] initWithFrame:CGRectMake(pass.frame.size.width-26, uname.frame.size.height+uname.frame.origin.y+20+5, 26, 26)];
    passImg.image=[UIImage imageNamed:@"password.png"];
    [outerview addSubview:passImg];

    
    uname.text=@"";
    pass.text=@"";

    
  //  UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35, pass.frame.origin.y+pass.frame.size.height+20, outerview.frame.size.width/2-40, onfith-15)];

    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(10, pass.frame.origin.y+pass.frame.size.height+20, outerview.frame.size.width-20, 40)];
    [save setTitle: @"Log in" forState: UIControlStateNormal];
    [save setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16]];
    save.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:199.0f/255.0f blue:3.0f/255.0f alpha:1.0f];//[UIColor colorWithRed:10.0f/255.0f green:48.0f/255.0f blue:144.0f/255.0f alpha:1.0f];
    [save addTarget:self action:@selector(logintoserver:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:49.0f/255.0f green:61.0f/255.0f blue:77.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    save.layer.cornerRadius=3;
    save.clipsToBounds=YES;
    [outerview addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(10, save.frame.origin.y+save.frame.size.height+20, outerview.frame.size.width/2-40, 35)];
    [cancel setTitle: @"Discard" forState: UIControlStateNormal];
    cancel.layer.cornerRadius=5;
    cancel.backgroundColor=[UIColor colorWithRed:10.0f/255.0f green:48.0f/255.0f blue:144.0f/255.0f alpha:1.0f];
    [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [cancel addTarget:self action:@selector(dismiss1:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  //  [outerview addSubview:cancel];
    
   // UILabel *forgetpass=[[UILabel alloc] initWithFrame:CGRectMake((save.frame.size.width-30)/2, save.frame.size.height+save.frame.origin.y,200 , onfith-15)];
    UILabel *registerbtn=[[UILabel alloc] initWithFrame:CGRectMake(10, save.frame.size.height+save.frame.origin.y,200 , 35)];

  //  UILabel *registerbtn=[[UILabel alloc] initWithFrame:CGRectMake(save.frame.size.width/2-50, save.frame.size.height+save.frame.origin.y,200 , onfith-15)];

    registerbtn.backgroundColor=[UIColor clearColor];
    registerbtn.textColor=[UIColor whiteColor];
    registerbtn.text=@"Register";
    registerbtn.textAlignment=NSTextAlignmentLeft;
    registerbtn.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    registerbtn.font=[UIFont boldSystemFontOfSize:14.0f];
    registerbtn.clipsToBounds=YES;
    [outerview addSubview:registerbtn];
    

    UITapGestureRecognizer *forgetgesReg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signIn)];
    forgetgesReg.delegate =self;
    forgetgesReg.numberOfTapsRequired = 1;
    registerbtn.userInteractionEnabled = YES;
    [registerbtn addGestureRecognizer:forgetgesReg];

    
    UILabel *forgetpass=[[UILabel alloc] initWithFrame:CGRectMake(save.frame.size.width/2-30, save.frame.size.height+save.frame.origin.y,200 , 35)];
    forgetpass.backgroundColor=[UIColor clearColor];
    forgetpass.textColor=[UIColor whiteColor];
    forgetpass.text=@"Password ?";
    forgetpass.textAlignment=NSTextAlignmentRight;
    forgetpass.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    forgetpass.font=[UIFont boldSystemFontOfSize:14.0f];
    forgetpass.clipsToBounds=YES;
    [outerview addSubview:forgetpass];
    
    UITapGestureRecognizer *forgetges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetpass)];
    forgetges.delegate =self;
    forgetges.numberOfTapsRequired = 1;
    forgetpass.userInteractionEnabled = YES;
    [forgetpass addGestureRecognizer:forgetges];
    
    mainScrollView1.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, outerview.frame.size.height+outerview.frame.origin.y+150);

}


-(void)cancelRegistration{
    [mainView removeFromSuperview];
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LandingViewController* landing = [mainStoryboard instantiateViewControllerWithIdentifier:@"LANDING_VIEW"];
    [appDel.navigationController setViewControllers:@[landing] animated:NO];
}

-(IBAction)dismiss1:(id)sender
{
    [mainView removeFromSuperview];
}
-(void) dissmissmainView
{
    [mainView removeFromSuperview];
}


-(IBAction)signuptoserver:(id)sender
{
   
    
        
   if([fname.text isEqual:@""] || [midname.text isEqual:@""] || [lname.text isEqual:@""] || [username.text isEqual:@""] || [password.text isEqual:@""] || [confirmpass.text isEqual:@""])
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"All fields are mandatory" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
    }
        else if(![av NSStringIsValidEmail:email.text])
        {
            return;
        }
    

        else if ([indus.text isEqual:@"Select Industry"])
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Industry" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
            return;
        }
        else  if([av checkNull:username]&&[av checkNull:password])
        {
            
            if(password.text.length<1)
            {
                UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Weak Password!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alrt show];
                return;
            }
            if (![password.text isEqual:confirmpass.text])
            {
                UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Password Does Not Matched" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alrt show];
                return;
            }
            
            
            else
            {
               // [self checkUserNameExits];
                NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                [dic setValue:username.text forKey:@"str"];
                
                
                iscallback=101;
                
                [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"unAvail" :@"" :@"" :dic :self];
                
                
                
                
            }
        }
    
}


-(IBAction)logintoserver:(id)sender
{
    if (sender) {
        userNameStr = uname.text;
        passwordStr = pass.text;
    }
    NSString *unametxt=userNameStr;
    NSString *upasstxt=passwordStr;
    
    if([[SavePrefrences sharedInstance].isavilNet isEqual:@"yes"])
    {
        
        if(unametxt.length<=0||upasstxt.length<=0)
        {
            NSString* message;
            if(!upasstxt.length) message = @"Please enter your password";
            if(!unametxt.length) message = @"Please enter your username";
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
        }
        else
        {
            iscallback=2;
            [[NSUserDefaults standardUserDefaults] setValue:unametxt forKey:@"USERNAME"];
            [[NSUserDefaults standardUserDefaults] setValue:upasstxt forKey:@"PASSWORD"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IS_LOGGED_IN"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
            [dic1 setValue:unametxt forKey:@"un"];
            [dic1 setValue:upasstxt forKey:@"pwd"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Home" :@"auth" :@"":@"":dic1 :self];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk"  message:@"Network not Available."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(void) dismiss
{
    [mainView removeFromSuperview];
}




-(void) selectInduct
{
    iscallback=0;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getInd" :@"":@"":dic1 :self];
}

-(void) showInd
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Industry:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[dataind count];x++)
    {
        
        NSString *stname=[[dataind valueForKey:@"industry_name"] objectAtIndex:x];
        NSString *idd=[[dataind valueForKey:@"i_id"] objectAtIndex:x];
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            indid=idd;
                                            indus.text=[NSString stringWithFormat:@"%@", stname];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{
    NSMutableDictionary *colorset=[SavePrefrences sharedInstance].colorDictionry;
    av=[[AllValidationsViewController alloc]init];
    
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].screenHeight/3 -30, prMainView.frame.size.width-70, 50)];
    NameLabel.text=title;
    NameLabel.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
    NameLabel.textColor=[UIColor blackColor];
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [prMainView addSubview:NameLabel];
    
    
    UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel.frame.size.width+NameLabel.frame.origin.x, [SavePrefrences sharedInstance].screenHeight/3 -30, 30, 50)];
    closeView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
    [prMainView addSubview:closeView];
    
    UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 25, 25)];
    [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
    cross.userInteractionEnabled=YES;
    [closeView addSubview:cross];
    
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    closeView.userInteractionEnabled = YES;
    [closeView addGestureRecognizer:communityeg];
    
    
    
    
    
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, 150)];
    scrollbar.backgroundColor=[colorset valueForKey:@"popupcolor"];
    [prMainView addSubview:scrollbar];
    
    return prMainView;
}
-(void)dissmisspop
{
    NSLog(@"pop ar count=before==%lu",[popUpAr count]);
    
    int cnt=(int)[popUpAr count]-1;
    NSLog(@"pop ar count===%d",cnt);
    
    if([popUpAr count]>0)
    {
        UIView *ppv=[popUpAr objectAtIndex:cnt] ;
        [popUpAr removeObjectAtIndex:cnt];
        [ppv removeFromSuperview];
        
    }
    if([popUpAr count]==0)
    {
        id<CallTo_Parent> cb= vc1;
       
        [cb callMethod:nil];
        
    }
}

-(void) forgetpass
{
    
    
    
    NSMutableDictionary *edtprf=[SavePrefrences sharedInstance].colorDictionry;
    
    mainouterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    mainouterView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    mainouterView.layer.cornerRadius=10;
    [self.view addSubview:mainouterView];
    
    
    UIView *outerView = [[UIView alloc] initWithFrame:CGRectMake(10,([SavePrefrences sharedInstance].screenHeight/2)-100,mainouterView.frame.size.width-20,150)];
    outerView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    outerView.layer.cornerRadius=10;
    [mainouterView addSubview:outerView];
    
    
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,outerView.frame.size.width,150)];
    innerView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    innerView.layer.cornerRadius=10;
    [outerView addSubview:innerView];
    
  
    
   UILabel *titlab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, innerView.frame.size.width, 40)];
    titlab.text=@"Recover Password";
    titlab.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    titlab.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
    titlab.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    titlab.layer.cornerRadius=10;
    titlab.clipsToBounds=YES;
    titlab.textAlignment=NSTextAlignmentCenter;
    [innerView addSubview:titlab];
    
    
   /* UILabel *coverLowerpart=[[UILabel alloc] initWithFrame:CGRectMake(0, titlab.frame.size.height+titlab.frame.origin.y-10, innerView.frame.size.width, 10)];
    coverLowerpart.backgroundColor=[UIColor colorWithRed:50.0f/255.0f green:98.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
    [innerView addSubview:coverLowerpart];*/
    
    txt=[[UITextField alloc]initWithFrame:CGRectMake(10, titlab.frame.size.height+titlab.frame.origin.y+15, innerView.frame.size.width-25, 30)];
    //txt.placeholder=@"Enter Your Email ID";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    txt.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Enter Your Email ID" attributes:@{NSForegroundColorAttributeName: color}];

    txt.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    txt.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txt.leftView = paddingView;
    txt.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    txt.layer.cornerRadius=4;
    txt.delegate=self;
    [txt setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [innerView addSubview:txt];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35, txt.frame.size.height+txt.frame.origin.y+10, innerView.frame.size.width/2-40, 35)];
    [save setTitle: @"Send" forState: UIControlStateNormal];
    save.backgroundColor=[edtprf valueForKey:@"Yellowbtncolor"];
    [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [save addTarget:self action:@selector(recover:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [innerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+5, txt.frame.size.height+txt.frame.origin.y+10, innerView.frame.size.width/2-40, 35)];
    [cancel setTitle: @"Discard" forState: UIControlStateNormal];
    cancel.backgroundColor=[edtprf valueForKey:@"Yellowbtncolor"];
    [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [cancel addTarget:self action:@selector(discard1:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
     cancel.layer.cornerRadius=5;
    [innerView addSubview:cancel];

    
}
-(IBAction)discard1:(id)sender
{
    
    [mainouterView removeFromSuperview];
}



-(IBAction)recover:(id)sender
{
    
    if(![av NSStringIsValidEmail:txt.text])
    {
        return;
    }
    else
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:txt.text forKey:@"email"];
        iscallback=5;
        [[SavePrefrences sharedInstance].skthand emitData:@"Landing" :@"fP" :@"" :@"" :dic :self];
        
       // [mainouterView removeFromSuperview];
    }
    
  
    
}

-(IBAction)cancel:(id)sender{
    
    [self dissmisspop];
}

-(void) callBack:(NSArray *)META  :(NSArray *)DATA{
    if(iscallback==0){
        dataind=DATA;
        [self showInd];
    }
    else if(iscallback==1)
    {
//        NSArray *da=[META  valueForKey:@"d"];
//        [SavePrefrences sharedInstance].uid=[META  valueForKey:@"uid"];
//        [SavePrefrences sharedInstance].sid=[META  valueForKey:@"sid"];
//        [SavePrefrences sharedInstance].at=[META valueForKey:@"at"];
//        [SavePrefrences sharedInstance].un=[[da objectAtIndex:0 ] valueForKey:@"uname"];
//        [SavePrefrences sharedInstance].roleid=[[da objectAtIndex:0 ] valueForKey:@"role_id"];
//        
//        [self dismiss];
//        [loginview removeFromSuperview];
//        [prlogview removeFromSuperview];
//        [lgwith removeFromSuperview];
//        
//        
//        
//        
//        [drawer initArs:self];
        NSArray *ff=[META valueForKey:@"fbDt"];
        
        [SavePrefrences sharedInstance].uid=[META valueForKey:@"uid"];
        [SavePrefrences sharedInstance].sid=[META valueForKey:@"sid"];
        [SavePrefrences sharedInstance].at=[META valueForKey:@"at"];
        [SavePrefrences sharedInstance].un=[META valueForKey:@"un"];
        [SavePrefrences sharedInstance].roleid=[META valueForKey:@"rl"];
        [SavePrefrences sharedInstance].fname=[META valueForKey:@"fname"];
        [SavePrefrences sharedInstance].lname=[META valueForKey:@"lname"];
        [SavePrefrences sharedInstance].pro_image=[META valueForKey:@"img"];
        
        Yolking *obj=[[Yolking alloc]initWithNibName:@"Yolking" bundle:nil];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController setViewControllers:@[obj] animated:NO];
        
    }
    else if(iscallback==2)//login
    {
        [SavePrefrences sharedInstance].uid=[META valueForKey:@"uid"];
        [SavePrefrences sharedInstance].sid=[META valueForKey:@"sid"];
        [SavePrefrences sharedInstance].at=[META valueForKey:@"at"];
        [SavePrefrences sharedInstance].un=[META valueForKey:@"un"];
        [SavePrefrences sharedInstance].roleid=[META valueForKey:@"rl"];
        [SavePrefrences sharedInstance].fname=[META valueForKey:@"fname"];
        [SavePrefrences sharedInstance].lname=[META valueForKey:@"lname"];
        [SavePrefrences sharedInstance].pro_image=[META valueForKey:@"img"];
        
        [self dismiss];
        [loginview removeFromSuperview];
        [prlogview removeFromSuperview];
        [lgwith removeFromSuperview];
        
        [self reteriveFriends];
        
    }
    else if (iscallback==3)
    {
        NSLog(@"in callback");
        
        Yolking *obj=[[Yolking alloc]initWithNibName:@"Yolking" bundle:nil];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController setViewControllers:@[obj] animated:NO];
        
        [SavePrefrences sharedInstance].frndAr=[META valueForKey:@"fr"];
        nobj=[[NotificationHandler alloc]init];
        [nobj ManageNotification:[META valueForKey:@"notis"]];
        
    }
    else if (iscallback==4)
    {
        
        
        NSArray *ff=[META valueForKey:@"fbDt"];
        
        [SavePrefrences sharedInstance].uid=[META valueForKey:@"uid"];
        [SavePrefrences sharedInstance].sid=[META valueForKey:@"sid"];
        [SavePrefrences sharedInstance].at=[META valueForKey:@"at"];
        [SavePrefrences sharedInstance].un=[META valueForKey:@"un"];
        [SavePrefrences sharedInstance].roleid=[META valueForKey:@"rl"];
        [SavePrefrences sharedInstance].fname=[META valueForKey:@"fname"];
        [SavePrefrences sharedInstance].lname=[META valueForKey:@"lname"];
        [SavePrefrences sharedInstance].pro_image=[META valueForKey:@"img"];
        
        
        Yolking *obj=[[Yolking alloc]initWithNibName:@"Yolking" bundle:nil];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController setViewControllers:@[obj] animated:NO];
    }
    else if (iscallback==5)
    {
        [mainouterView removeFromSuperview];
        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:[DATA valueForKey:@"s"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
      
    }
    else if (iscallback==7)
    {
        //[mainouterView removeFromSuperview];
        NSMutableDictionary *dictData = (NSMutableDictionary *)DATA;
        if ([[dictData objectForKey:@"avail"]integerValue]==1) {
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"UserName already exists" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        
        
        
        
    }
    
    else if (iscallback==101)
    {
        //[mainouterView removeFromSuperview];
        NSMutableDictionary *dictData = (NSMutableDictionary *)DATA;
        if ([[dictData objectForKey:@"avail"]integerValue]==1) {
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"UserName already exists" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        else{
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setValue:email.text forKey:@"str"];
            
            
            iscallback=102;
            
            [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"emAvail" :@"" :@"" :dic :self];
            //[self checkEmailExits];
        }
        
        
        
    }

    
    else if (iscallback==102)
    {
        //[mainouterView removeFromSuperview];
        NSMutableDictionary *dictData = (NSMutableDictionary *)DATA;
        if ([[dictData objectForKey:@"avail"]integerValue]==1) {
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Email already exists" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        else{
            iscallback=1;
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
            [dic1 setValue:fname.text forKey:@"fn"];
            [dic1 setValue:midname.text forKey:@"mn"];
            [dic1 setValue:lname.text forKey:@"ln"];
            [dic1 setValue:username.text forKey:@"un"];
            [dic1 setValue:email.text forKey:@"email"];
            [dic1 setValue:password.text forKey:@"pass"];
            [dic1 setValue:indid forKey:@"slctInd"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Home" :@"su" :@"":@"":dic1 :self];
        }
    }
        else if(iscallback == 8){
             NSMutableDictionary *dictData = (NSMutableDictionary *)DATA;
            if ([[dictData objectForKey:@"avail"]integerValue]==1) {
                UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Email already exists" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
        }
}

        
    

    


-(void) reteriveFriends
{
    iscallback=3;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"genData" :@"":@"":dic1 :self];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)callMethod:(NSArray *)meta
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
   
    
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField == fname) {
        if (fname.text.length<=0) {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter First Name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
        }
    }
    else if (textField == midname) {
        if (midname.text.length<=0) {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Middle Name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
        }
    }
   else if (textField == lname) {
        if (lname.text.length<=0) {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Last Name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
    }
    }
       else if (textField == email) {
            if (email.text.length<=0) {
                UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Email" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alrt show];
            }
            else if(![av NSStringIsValidEmail:email.text])
            {
                return;
            }
            else {
                [self checkEmailExits];
            }
        }
    
          else  if (textField == username) {
                if (username.text.length<=0) {
                    UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Username" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    [alrt show];
                }
                else {
                    [self checkUserNameExits];
                }
            }
             else   if (textField == password) {
                    if (password.text.length<=0) {
                        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Password" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                        [alrt show];
                    }
                }
          else  if (textField == confirmpass) {
                if (confirmpass.text.length<=0) {
                    UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Confirm Password" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    [alrt show];
            }
              
            }
          else{
              
              NSString *unametxt=uname.text;
              NSString *upasstxt=pass.text;
              /*
              if([[SavePrefrences sharedInstance].isavilNet isEqual:@"yes"])
              {
                  
                 if(unametxt.length<=0||upasstxt.length<=0)
                  {
                      UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Username Or Password	" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                      [alrt show];
                  }
                  else
                  {
                      iscallback=2;
                      NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
                      [dic1 setValue:unametxt forKey:@"un"];
                      [dic1 setValue:upasstxt forKey:@"pwd"];
                      [[SavePrefrences sharedInstance].skthand emitData:@"Home" :@"auth" :@"":@"":dic1 :self];
                  }
              }
              else{
                  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk"  message:@"Network not Available."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                  [alert show];
              }*/
          }
    

}

-(void)checkUserNameExits{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:username.text forKey:@"str"];
    
    
    iscallback=7;
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"unAvail" :@"" :@"" :dic :self];
}
-(void)checkEmailExits{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:email.text forKey:@"str"];
    
    
    iscallback=8;
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"emAvail" :@"" :@"" :dic :self];
}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
}
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
{
    [self presentViewController:viewController animated:YES completion:nil];
}
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    //user signed in
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *email = user.profile.email;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:email forKey:@"email"];
    [dic setValue:fullName forKey:@"first_name"];
    [dic setValue:givenName forKey:@"last_name"];
    
    iscallback=4;
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Home" :@"fbLog" :@"" :@"" :dic :self];
    //get user data in "user" (GIDGoogleUser object)
}



@end


