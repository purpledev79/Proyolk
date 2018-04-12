

//#import "ViewController.h"
//#import "SavePrefrences.h"
//#import "AllValidationsViewController.h"
//#import "ManageArray.h"
//#import "ProfileView.h"
////#import "AddCalendar.h"
////#import "CalendarPopup.h"
//#import <AVKit/AVKit.h>
////#import "MainBord.h"
////#import "Podcast.h"
////#import "Job.h"
//#import "LeftRightDrawer.h"
//#import "Yolking.h"
//
//#import <AVFoundation/AVFoundation.h>
//@interface ViewController ()
//{
//float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
//    UIView * actionView,*prMainView;
//    UIView *mainView,*loginview,*prlogview ,*lgwith,*videomainview,*main;
//    NSMutableArray *leftAr,*leftImgAr,*rightAr,*rightimgAr;
//    NSArray *dataind,*profilear1;
//    UITextField *uname,*pass,*fname,*lname,*midname,*email,*username,*password,*confirmpass,*emailid;
//    UILabel *indus,*NameLabel;
//    NSString *indid;
//    ViewController *vc1;
//    NSMutableArray * nwfr,* cbfr,*popUpAr;
//    AllValidationsViewController *av;
//    int iscallback,isind;
//    ManageArray *mngAr;
//    UIScrollView *mainScrollView1,*scrollbar;
//    NSString *imgBuffer;
//    NSString *randomImgName;
//   // UIImageView *imggeter;
//    Yolking *ypop;
//    LeftRightDrawer * drawer;
// 
//}
//@end
//
//@implementation ViewController
//@synthesize lefttableView,righttableView,cabinetTableview;
//- (void)viewDidLoad
// {
//    [super viewDidLoad];
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    screenWidth = screenRect.size.width;
//    screenHeight = screenRect.size.height;
//    naviWidth = self.navigationController.navigationBar.frame.size.width;
//    naviHght =  self.navigationController.navigationBar.frame.size.height;
//    stbarHght= (float)[[UIApplication sharedApplication] statusBarFrame].size.height;
// 
//     
//     [SavePrefrences sharedInstance].screenHeight=screenHeight;
//     [SavePrefrences sharedInstance].screenWidth=screenWidth;
//     [SavePrefrences sharedInstance].naviHght=naviHght;
//     [SavePrefrences sharedInstance].naviWidth=naviWidth;
//     [SavePrefrences sharedInstance].stbarHght=stbarHght;
//     [SavePrefrences sharedInstance].textsize=20;
//    
//     drawer=[[LeftRightDrawer alloc]init];
//     av=[[AllValidationsViewController alloc]init];
//     ypop=[[Yolking alloc]init];
//     
//
//     
//     
//     NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
//     
//     self.view.backgroundColor=[UIColor clearColor];
//       [self.navigationController setNavigationBarHidden:YES animated:NO];
//     [self loginView];
//     
//  
// }
//
//-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
//{
//    NSMutableDictionary *colorset=[SavePrefrences sharedInstance].colorDictionry;
//    av=[[AllValidationsViewController alloc]init];
//    
//    UIColor *color = [UIColor blackColor];
//    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,500)];
//    [Vc.view addSubview:prMainView];
//    vc1=Vc;
//    prMainView.backgroundColor=[UIColor colorWithRed:132.0f/255.0f green:132.0f/255.0f blue:132.0f/255.0f alpha:.5f];
//    if([popUpAr count]>0)
//    {
//        [popUpAr addObject:prMainView];
//    }
//    else{
//        
//        popUpAr =[[NSMutableArray alloc]init];
//        [popUpAr addObject:prMainView];
//    }
//    
//    
//    NSLog(@"array of popup  %lu",[popUpAr count]);
//    
//    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-70, 50)];
//    NameLabel.text=title;
//    NameLabel.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    NameLabel.font=[UIFont systemFontOfSize:14];
//    NameLabel.textColor=[UIColor blackColor];
//    NameLabel.textAlignment=NSTextAlignmentCenter;
//    [prMainView addSubview:NameLabel];
//    
//    
//    UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel.frame.size.width+NameLabel.frame.origin.x, [SavePrefrences sharedInstance ].naviHght+15, 30, 50)];
//    closeView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    [prMainView addSubview:closeView];
//    
//    UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 25, 25)];
//    [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
//    cross.userInteractionEnabled=YES;
//    [closeView addSubview:cross];
//    
//    
//    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//    [communityeg setNumberOfTouchesRequired:1];
//    [communityeg setDelegate:self];
//    cross.userInteractionEnabled = YES;
//    [cross addGestureRecognizer:communityeg];
// 
//    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
//    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
//    scrollbar.backgroundColor=[colorset valueForKey:@"Videocolor"];
//    [prMainView addSubview:scrollbar];
//    
//    return prMainView;
//}
//
//-(void)loginView
//{
//    
//    [SavePrefrences sharedInstance].uid=@"";
//    [SavePrefrences sharedInstance].sid=@"";
//    [SavePrefrences sharedInstance].un=@"";
//    [SavePrefrences sharedInstance].roleid=@"";
//    [SavePrefrences sharedInstance].rl=@"";
//    [SavePrefrences sharedInstance].at=@"";
//
//    loginview= [[UIView alloc] initWithFrame:CGRectMake(0,0,screenWidth,screenHeight)];
//    loginview.backgroundColor=[UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:.5f];
//    [self.view addSubview:loginview];
//    
//    UIView *statusbarvw=[[UIView alloc]initWithFrame:CGRectMake(0, 0,  screenWidth,70)];
//    statusbarvw.backgroundColor=[UIColor yellowColor];
//    statusbarvw.backgroundColor =[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:147.0f/255.0f alpha:1.0f];
//    [loginview addSubview:statusbarvw];
//    
//    
//    UIImageView *logo =[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 140, 35)];
//    logo.image = [UIImage imageNamed:@"logo.png"];
//    logo.backgroundColor=[UIColor clearColor];
//    [loginview addSubview:logo];
//    
//    
//    UIImageView *signup =[[UIImageView alloc]initWithFrame:CGRectMake(loginview.frame.size.width-80, 30, 25, 25)];
//    signup.image = [UIImage imageNamed:@"signupicon.png"];
//    signup.backgroundColor=[UIColor clearColor];
//    [loginview addSubview:signup];
//    
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
//    
//    UIImageView *logoicn =[[UIImageView alloc]initWithFrame:CGRectMake(loginview.frame.size.width/2-40,statusbarvw.frame.size.height+50 ,80, 80)];
//    logoicn.image = [UIImage imageNamed:@"mainlogo.png"];
//    logoicn.backgroundColor=[UIColor clearColor];
//    [loginview addSubview:logoicn];
//    
//    UILabel *welcome=[[UILabel alloc] initWithFrame:CGRectMake(loginview.frame.size.width/2-100, logoicn.frame.size.height+logoicn.frame.origin.y, 200, 30)];
//    welcome.backgroundColor=[UIColor clearColor];
//    welcome.textAlignment=NSTextAlignmentCenter;
//    welcome.font =[UIFont fontWithName:@"Helvetica-Bold" size:20];
//    welcome.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
//    welcome.text=@"Welcome To Proyolk";
//    [loginview addSubview:welcome];
//    
//    
//    UILabel *find=[[UILabel alloc] initWithFrame:CGRectMake(loginview.frame.size.width/2-loginview.frame.size.width/2, welcome.frame.size.height+welcome.frame.origin.y, loginview.frame.size.width, 20)];
//    find.backgroundColor=[UIColor clearColor];
//    find.textAlignment=NSTextAlignmentCenter;
//    find.font =[UIFont fontWithName:@"Helvetica-Bold" size:18];
//    find.textColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    find.text=@"Finds Jobs Video ConferencingStream";
//    [loginview addSubview:find];
//    
//    UITextView *find1=[[UITextView alloc] initWithFrame:CGRectMake(loginview.frame.size.width/2-175, find.frame.size.height+find.frame.origin.y-10, 350, 150)];
//    find1.userInteractionEnabled=NO;
//    find1.backgroundColor=[UIColor clearColor];
//    find1.textAlignment=NSTextAlignmentCenter;
//    find1.font =[UIFont fontWithName:@"Helvetica-Bold" size:18];
//    find1.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
//    find1.text=@"Proyolk is a virtual incubator for Professional,startup and student.proyolk facilate real time colaboration,peer to peer communication and self learning through work shop ";
//    [loginview addSubview:find1];
//    
//    
//    
//     prlogview= [[UIView alloc] initWithFrame:CGRectMake(20,find1.frame.size.height+find1.frame.origin.y+50,(screenWidth-20)/2-20,50)];
//    prlogview.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    prlogview.layer.cornerRadius=10;
//    [self.view addSubview:prlogview];
//    
//    UIImageView *whtlogo =[[UIImageView alloc]initWithFrame:CGRectMake(5,10 ,30, 30)];
//    whtlogo.image = [UIImage imageNamed:@"iconproyolk.png"];
//    whtlogo.backgroundColor=[UIColor clearColor];
//    [prlogview addSubview:whtlogo];
//   
//    UILabel *vline=[[UILabel alloc] initWithFrame:CGRectMake(whtlogo.frame.size.width+whtlogo.frame.origin.x+4, 10, 1, 30)];
//    vline.backgroundColor=[UIColor whiteColor];
//    vline.textColor=[UIColor whiteColor];
//    [prlogview addSubview:vline];
//    
//    
//    UILabel *plogin=[[UILabel alloc] initWithFrame:CGRectMake(vline.frame.size.width+vline.frame.origin.x+4, 10,prlogview.frame.size.width-(vline.frame.size.width+vline.frame.origin.x+4) , 30)];
//    plogin.backgroundColor=[UIColor clearColor];
//    plogin.textColor=[UIColor whiteColor];
//    plogin.text=@"Proyolk Login";
//    plogin.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
//    [prlogview addSubview:plogin];
//    
//    
//    UITapGestureRecognizer *loginges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
//    loginges.delegate =self;
//    loginges.numberOfTapsRequired = 1;
//    plogin.userInteractionEnabled = YES;
//    [plogin addGestureRecognizer:loginges];
//    
//    
//   lgwith= [[UIView alloc] initWithFrame:CGRectMake(prlogview.frame.size.width+40,find1.frame.size.height+find1.frame.origin.y+50,(screenWidth-20)/2-20,50)];
//    lgwith.backgroundColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
//    lgwith.layer.cornerRadius=10;
//    [self.view addSubview:lgwith];
//    
//    int xsp=5;
//    NSMutableArray *imglogo=[[NSMutableArray alloc]init];
//     [imglogo addObject:@"fb.png"];
//     [imglogo addObject:@"twitter.png"];
//     [imglogo addObject:@"google.png"];
//     [imglogo addObject:@"in.png"];
//      int left=lgwith.frame.size.width/4;
//    
//    
//    for(int x=0;x<[imglogo count];x++)
//    {
//        UIImageView *imglog =[[UIImageView alloc]initWithFrame:CGRectMake(xsp,10 ,left, 30)];
//        imglog.image = [UIImage imageNamed:[imglogo objectAtIndex:x]];
//        imglog.backgroundColor=[UIColor clearColor];
//        [lgwith addSubview:imglog];
//        xsp=xsp+left;
//    }
//    
//}
//
//-(void)videoplay
//{
//    videomainview = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
//    [vc1.view addSubview:videomainview];
//    videomainview.backgroundColor=[UIColor blackColor];
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(videomainview.frame.size.width-50, 30, 30, 30)];
//    [save setTitle: @"X" forState: UIControlStateNormal];
//    save.backgroundColor=[UIColor whiteColor];
//    [save addTarget:self action:@selector(dissmissVideo:) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    save.layer.cornerRadius=5;
//    [videomainview addSubview:save];
//    
//    NSURL *videoURL = [NSURL URLWithString:@"upload/provid/wel.mp4"];
//    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    
//    playerLayer.frame = videomainview.bounds;
//    [videomainview.layer addSublayer:playerLayer];
//    [player play];
//     NSLog(@"Play VIdeo");
//    
//}
//-(void)signIn
//{
//    NSLog(@"signin pressed");
//    
//    
//    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
//    
//    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,actionView.frame.size.height,screenWidth,screenHeight)];
//    mainView.backgroundColor=[UIColor colorWithRed:172/255.0f green:172/255.0f blue:172/255.0f alpha:.5f];
//    [self.view addSubview:mainView];
//    
//    UIView *popupy= [[UIView alloc] initWithFrame:CGRectMake(0,20,screenWidth,50)];
//    popupy.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    [mainView addSubview:popupy];
//    
//    UILabel *prsign=[[UILabel alloc] initWithFrame:CGRectMake(popupy.frame.size.width/2-70, 10,140 , 30)];
//    prsign.backgroundColor=[UIColor clearColor];
//    prsign.textColor=[UIColor blackColor];
//    prsign.textAlignment=NSTextAlignmentCenter;
//    prsign.text=@"Proyolk SignUp";
//    prsign.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
//    [popupy addSubview:prsign];
//    
//    
//    
//    UIScrollView  *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, popupy.frame.size.height+stbarHght, screenWidth, screenHeight-60)];
//    scrollView.delegate = self;
//    scrollView.scrollEnabled = YES;
//    scrollView.backgroundColor=[ff valueForKey:@"Videocolor"];
//    scrollView.contentSize = CGSizeMake(screenWidth,screenHeight+100);
//    [mainView addSubview:scrollView];
//    
//    
//    
//    fname=[[UITextField alloc] initWithFrame:CGRectMake(10, 10,scrollView.frame.size.width-20 , 50)];
//    fname.backgroundColor=[UIColor whiteColor];
//    fname.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    fname.placeholder=@"Enter First Name";
//    fname.layer.cornerRadius=5;
//    fname.delegate=self;
//    fname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    fname.userInteractionEnabled=YES;
//    fname.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
//    fname.layer.borderWidth=2.0f;
//    [scrollView addSubview:fname];
//    
//    
//    
//    lname=[[UITextField alloc] initWithFrame:CGRectMake(10, fname.frame.size.height+fname.frame.origin.y+10,scrollView.frame.size.width-20 , 50)];
//    lname.backgroundColor=[UIColor whiteColor];
//    lname.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    lname.placeholder=@"Enter Last Name";
//    lname.layer.cornerRadius=5;
//    lname.delegate=self;
//    lname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    lname.userInteractionEnabled=YES;
//    lname.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
//    lname.layer.borderWidth=2.0f;
//    [scrollView addSubview:lname];
//    
//    
//    
//    midname=[[UITextField alloc] initWithFrame:CGRectMake(10, lname.frame.size.height+lname.frame.origin.y+10,scrollView.frame.size.width-20 , 50)];
//    midname.backgroundColor=[UIColor whiteColor];
//    midname.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    midname.placeholder=@"Enter Middle Name";
//    midname.layer.cornerRadius=5;
//    midname.delegate=self;
//    midname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    midname.userInteractionEnabled=YES;
//    midname.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
//    midname.layer.borderWidth=2.0f;
//    [scrollView addSubview:midname];
//    
//    email=[[UITextField alloc] initWithFrame:CGRectMake(10, midname.frame.size.height+midname.frame.origin.y+10,scrollView.frame.size.width-20 , 50)];
//    email.backgroundColor=[UIColor whiteColor];
//    email.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    email.placeholder=@"Enter Email";
//    email.layer.cornerRadius=5;
//    email.delegate=self;
//    email.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    email.userInteractionEnabled=YES;
//    email.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
//    email.layer.borderWidth=2.0f;
//    [scrollView addSubview:email];
//    
//    
//    
//    indus=[[UILabel alloc] initWithFrame:CGRectMake(10, email.frame.size.height+email.frame.origin.y+10,scrollView.frame.size.width-20 , 50)];
//    indus.backgroundColor=[UIColor whiteColor];
//    indus.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    indus.text=@"Select Industry";
//    indus.layer.cornerRadius=5;
//    indus.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    indus.userInteractionEnabled=YES;
//    indus.clipsToBounds=YES;
//    indus.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
//    indus.layer.borderWidth=2.0f;
//    [scrollView addSubview:indus];
//   
//    UITapGestureRecognizer *lndges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInduct)];
//    lndges.delegate =self;
//    lndges.numberOfTapsRequired = 1;
//    indus.userInteractionEnabled = YES;
//    [indus addGestureRecognizer:lndges];
//    
//    
//    username=[[UITextField alloc] initWithFrame:CGRectMake(10, indus.frame.size.height+indus.frame.origin.y+10,scrollView.frame.size.width-20 , 50)];
//    username.backgroundColor=[UIColor whiteColor];
//    username.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    username.placeholder=@"Enter Username";
//    username.layer.cornerRadius=5;
//    username.delegate=self;
//    username.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    username.userInteractionEnabled=YES;
//    username.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
//    username.layer.borderWidth=2.0f;
//    [scrollView addSubview:username];
//    
//    
//    password=[[UITextField alloc] initWithFrame:CGRectMake(10, username.frame.size.height+username.frame.origin.y+10,scrollView.frame.size.width-20 , 50)];
//    password.backgroundColor=[UIColor whiteColor];
//    password.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    password.placeholder=@"Enter Password";
//    password.layer.cornerRadius=5;
//    password.delegate=self;
//    password.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    password.userInteractionEnabled=YES;
//    password.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
//    password.layer.borderWidth=2.0f;
//    password.secureTextEntry=YES;
//    [scrollView addSubview:password];
//    
//    
//    confirmpass=[[UITextField alloc] initWithFrame:CGRectMake(10, password.frame.size.height+password.frame.origin.y+10,scrollView.frame.size.width-20 , 50)];
//    confirmpass.backgroundColor=[UIColor whiteColor];
//    confirmpass.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    confirmpass.placeholder=@"Confirm Password";
//    confirmpass.layer.cornerRadius=5;
//    confirmpass.delegate=self;
//    confirmpass.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    confirmpass.userInteractionEnabled=YES;
//    confirmpass.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
//    confirmpass.layer.borderWidth=2.0f;
//    confirmpass.secureTextEntry=YES;
//    [scrollView addSubview:confirmpass];
//    
//    
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(40, confirmpass.frame.origin.y+confirmpass.frame.size.height+10, scrollView.frame.size.width/2-40, 45)];
//    [save setTitle: @"Save" forState: UIControlStateNormal];
//    save.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
//    [save addTarget:self action:@selector(signuptoserver:) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    save.layer.cornerRadius=5;
//    [scrollView addSubview:save];
//    
//    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, confirmpass.frame.origin.y+confirmpass.frame.size.height+10, popupy.frame.size.width/2-40, 45)];
//    [cancel setTitle: @"Discard" forState: UIControlStateNormal];
//    cancel.layer.cornerRadius=5;
//    cancel.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
//    
//    [cancel addTarget:self action:@selector(dismiss1:) forControlEvents:UIControlEventTouchUpInside];
//    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [scrollView addSubview:cancel];
//    
//    
//}
//
//-(void)login
//{
//    
// 
//    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,actionView.frame.size.height,screenWidth,screenHeight)];
//    mainView.backgroundColor=[UIColor colorWithRed:172/255.0f green:172/255.0f blue:172/255.0f alpha:.5f];
//    [self.view addSubview:mainView];
//    
//    
//    UIView *popupy= [[UIView alloc] initWithFrame:CGRectMake(20,screenHeight/2-100,screenWidth-40,screenHeight/2-10)];
//    popupy.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:199.0f/255.0f blue:5.0f/255.0f alpha:1.f];
//    popupy.layer.cornerRadius=15;
//    [mainView addSubview:popupy];
//    
//      int onfith= popupy.frame.size.height/5;
//    
//    UIView *stbar= [[UIView alloc] initWithFrame:CGRectMake(5,5,popupy.frame.size.width-10,onfith-20)];
//    stbar.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:199.0f/255.0f blue:5.0f/255.0f alpha:1.f];
//    stbar.layer.cornerRadius=5;
//    [popupy addSubview:stbar];
//    
//    
//    UILabel *login=[[UILabel alloc] initWithFrame:CGRectMake(stbar.frame.size.width/2-60, stbar.frame.size.height/2-15,120 , 30)];
//    login.text=@"Proyolk Login";
//    login.textAlignment=NSTextAlignmentCenter;
//    login.font=[UIFont fontWithName:@"Times New Roman" size:18];
//    login.textColor=[UIColor colorWithRed:10.0f/255.0f green:48.0f/255.0f blue:144.0f/255.0f alpha:1.0f];
//    login.font=[UIFont boldSystemFontOfSize:18.0f];
//    [stbar addSubview:login];
//    
//    
//    
//    uname=[[UITextField alloc] initWithFrame:CGRectMake(10, login.frame.size.height+login.frame.origin.y+20,popupy.frame.size.width-20 , onfith-10)];
//    uname.backgroundColor=[UIColor whiteColor];
//    uname.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    uname.placeholder=@"Username";
//    uname.layer.cornerRadius=5;
//    uname.delegate=self;
//    uname.text=@"test4";
//      uname.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    uname.userInteractionEnabled=YES;
//    uname.font=[UIFont fontWithName:@"Times Nedw Roman" size:18];
//    uname.layer.borderWidth=2.0f;
//    [popupy addSubview:uname];
//    
//    
//    
//    
//    pass=[[UITextField alloc] initWithFrame:CGRectMake(10, uname.frame.size.height+uname.frame.origin.y+20,popupy.frame.size.width-20, onfith-10)];
//    pass.backgroundColor=[UIColor whiteColor];
//    pass.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:2.0f];
//    pass.placeholder=@"Password";
//    pass.layer.cornerRadius=5;
//    pass.delegate=self;
//    pass.text=@"123456";
//    pass.layer.borderColor=[[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f]CGColor];
//    pass.userInteractionEnabled=YES;
//    pass.font=[UIFont fontWithName:@"Times New Roman" size:18];
//    pass.layer.borderWidth=2.0f;
//    pass.secureTextEntry=YES;
//    [popupy addSubview:pass];
//    
//    UILabel *forgetpass=[[UILabel alloc] initWithFrame:CGRectMake(stbar.frame.size.width/2, pass.frame.size.height+pass.frame.origin.y,200 , onfith-15)];
//    forgetpass.backgroundColor=[UIColor clearColor];
//    forgetpass.textColor=[UIColor blackColor];
//    forgetpass.text=@"Forget Password ?";
//    forgetpass.textAlignment=NSTextAlignmentCenter;
//    forgetpass.font=[UIFont fontWithName:@"Times New Roman" size:14];
//    forgetpass.font=[UIFont boldSystemFontOfSize:14.0f];
//    [popupy addSubview:forgetpass];
//    
//    
//    
//    UITapGestureRecognizer *forgetges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetpass)];
//    forgetges.delegate =self;
//    forgetges.numberOfTapsRequired = 1;
//    forgetpass.userInteractionEnabled = YES;
//    [forgetpass addGestureRecognizer:forgetges];
//    
//    
//    
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(40, forgetpass.frame.origin.y+forgetpass.frame.size.height+5, popupy.frame.size.width/2-40, onfith-15)];
//    [save setTitle: @"Login" forState: UIControlStateNormal];
//    save.backgroundColor=[UIColor colorWithRed:10.0f/255.0f green:48.0f/255.0f blue:144.0f/255.0f alpha:1.0f];
//    [save addTarget:self action:@selector(logintoserver:) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//     save.layer.cornerRadius=5;
//    [popupy addSubview:save];
//    
//    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, forgetpass.frame.origin.y+forgetpass.frame.size.height+5, popupy.frame.size.width/2-40, onfith-15)];
//    [cancel setTitle: @"Discard" forState: UIControlStateNormal];
//    cancel.layer.cornerRadius=5;
//    cancel.backgroundColor=[UIColor colorWithRed:10.0f/255.0f green:48.0f/255.0f blue:144.0f/255.0f alpha:1.0f];
//    
//    [cancel addTarget:self action:@selector(dismiss1:) forControlEvents:UIControlEventTouchUpInside];
//    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [popupy addSubview:cancel];
//    
//    		    
//    
//    
// }
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//
//-(IBAction)dismiss1:(id)sender
//{
//    [mainView removeFromSuperview];
//}
//-(void) dissmissmainView
//{
//    [mainView removeFromSuperview];
//}
//
//
//-(IBAction)signuptoserver:(id)sender
//{
//   if([av checkNull:fname]&&[av checkNull:lname]&&[av checkNull:midname]&&[av checkNull:email])
//   {
//       if(![av NSStringIsValidEmail:email.text])
//       {
//           UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Valid Email" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//           [alrt show];
//       }
//   if ([indus.text isEqual:@"Select Industry"])
//   {
//       UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Industry First" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//       [alrt show];
//   }
// else  if([av checkNull:username]&&[av checkNull:password])
//   {
//       
//  if(password.text.length<8)
//    {
//        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Week Password Atleast 8 charachter Required" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alrt show];
//    }
//    else if (![password.text isEqual:confirmpass.text])
//    {
//        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Password Does Not Matched" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alrt show];
//    }
//    else
//    {
//        iscallback=1;
//        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//        [dic1 setValue:fname.text forKey:@"fn"];
//        [dic1 setValue:midname.text forKey:@"mn"];
//        [dic1 setValue:lname.text forKey:@"ln"];
//        [dic1 setValue:username.text forKey:@"un"];
//        [dic1 setValue:email.text forKey:@"email"];
//        [dic1 setValue:password.text forKey:@"pass"];
//        [dic1 setValue:indid forKey:@"slctInd"];
//        [[SavePrefrences sharedInstance].skthand emitData:@"Home" :@"su" :@"":@"":dic1 :self];
//      }
//    }
//  }
//}
//-(IBAction)logintoserver:(id)sender
//{
//    NSString *unametxt=uname.text;
//    NSString *upasstxt=pass.text;
//
//    if(unametxt.length<=0||upasstxt.length<=0)
//    {
//        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Username Or Password	" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alrt show];
//    }
//    else
//    {
//        iscallback=2;
//        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//        [dic1 setValue:unametxt forKey:@"un"];
//        [dic1 setValue:upasstxt forKey:@"pwd"];
//        [[SavePrefrences sharedInstance].skthand emitData:@"Home" :@"auth" :@"":@"":dic1 :self];
//    }
//    
//}
//
//-(void) dismiss
//{
//      [mainView removeFromSuperview];
//}
//
//-(void) selectInduct
//  {
//    iscallback=0;
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getInd" :@"":@"":dic1 :self];
//   }
//
//-(void) showInd
//{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Butikka"message:@"Select Industry:"preferredStyle:UIAlertControllerStyleActionSheet];
//    for(int x=0;x<[dataind count];x++)
//    {
//        
//        NSString *stname=[[dataind valueForKey:@"industry_name"] objectAtIndex:x];
//        NSString *idd=[[dataind valueForKey:@"i_id"] objectAtIndex:x];
//        
//        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                                        {
//                                            NSString * tile= [action title];
//                                            indid=idd;
//                                             indus.text=stname;
//                                        }];
//        [alert addAction:drivingAction];
//    }
//    
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
//
//}
//
//
//
//-(void) forgetpass
//{
//    NSLog(@"forget pass");
//    NSMutableDictionary *prf=[SavePrefrences sharedInstance].colorDictionry;
//    [self MainView:self :@"Recovery Password"];
//    
//    emailid=[[UITextField alloc]initWithFrame:CGRectMake(25, 25, scrollbar.frame.size.width-30, 25)];
//    emailid.placeholder=@" Enter email-id here";
//    emailid.backgroundColor=[UIColor whiteColor];
//    emailid.layer.cornerRadius=5;
//    emailid.clipsToBounds=YES;
//    [scrollbar addSubview:emailid];
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(40, emailid.frame.size.height+emailid.frame.origin.y+10, scrollbar.frame.size.width/2-40, 35)];
//    [save setTitle: @"Done" forState: UIControlStateNormal];
//    save.backgroundColor=[prf valueForKey:@"Yellowbtncolor"];
//   // [save addTarget:self action:@selector(saveEmployementProfile:) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    save.layer.cornerRadius=6;
//    save.tag=0;
//    [scrollbar addSubview:save];
//    
//    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, emailid.frame.size.height+emailid.frame.origin.y+10, scrollbar.frame.size.width/2-40, 35)];
//    [cancel setTitle: @"Close" forState: UIControlStateNormal];
//    cancel.backgroundColor=[prf valueForKey:@"Yellowbtncolor"];
//    //[cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
//    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    cancel.layer.cornerRadius=6;
//    [scrollbar addSubview:cancel];
//    
//    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, 500);
//
//    
//  
//
//}
//-(void) callBack:(NSArray *)META  :(NSArray *)DATA
//{
//  
//    if(iscallback==0)
//    {
//       dataind=DATA;
//        NSLog(@"industry list %@",dataind);
//          [self showInd];
//    }
//    else if(iscallback==1)
//    {
//      NSArray *da=[META  valueForKey:@"d"];
//      [SavePrefrences sharedInstance].uid=[META  valueForKey:@"uid"];
//      [SavePrefrences sharedInstance].sid=[META  valueForKey:@"sid"];
//      [SavePrefrences sharedInstance].at=[META valueForKey:@"at"];
//      [SavePrefrences sharedInstance].un=[[da objectAtIndex:0 ] valueForKey:@"uname"];
//      [SavePrefrences sharedInstance].roleid=[[da objectAtIndex:0 ] valueForKey:@"role_id"];
//        
//         [self dismiss];
//         [loginview removeFromSuperview];
//         [prlogview removeFromSuperview];
//         [lgwith removeFromSuperview];
//             //[self customizeActionBar];
//           //     [self reteriveFriends];
//        
//        [drawer initArs:self];
//        
//        
//        
//        
//    }
//    else if(iscallback==2)
//    {
//        [SavePrefrences sharedInstance].uid=[META valueForKey:@"uid"];
//        [SavePrefrences sharedInstance].sid=[META valueForKey:@"sid"];
//        [SavePrefrences sharedInstance].at=[META valueForKey:@"at"];
//        [SavePrefrences sharedInstance].un=[META valueForKey:@"un"];
//        [SavePrefrences sharedInstance].roleid=[META valueForKey:@"rl"];
//        
//        [self dismiss];
//        [loginview removeFromSuperview];
//        [prlogview removeFromSuperview];
//        [lgwith removeFromSuperview];
//  
//         [drawer initArs:self];
//        [self reteriveFriends];
//        
//        
//    }
//    else if (iscallback==3)
//    {
//          [SavePrefrences sharedInstance].frndAr=[META valueForKey:@"fr"];
//         NSArray *notiAr =[META valueForKey:@"notis"];
//        NSLog( @"value of array is %@",notiAr);
//     if([notiAr count]>0)
//     {
//         for(int x=0;x<[notiAr count];x++)
//         {
//         NSString *userid=[[notiAr objectAtIndex:x]valueForKey:@"uid"];
//             NSLog(@"userid id %@",userid);
//             if (![[[SavePrefrences sharedInstance].notificationDic allKeys] containsObject:userid])
//              {
//                  NSLog(@" id is %@",userid);
//                  
//                 NSMutableArray * mymsgAr=[[NSMutableArray alloc]init];
//                [mymsgAr addObject:[notiAr objectAtIndex:x]];
//                  NSLog(@"valueee======== %@",mymsgAr);
//                [[SavePrefrences sharedInstance].notificationDic setValue:mymsgAr forKey:userid];
//              }
//             else
//             {
//                 NSLog(@"here value is === %@",[notiAr objectAtIndex:x]);
//                [(NSMutableArray *) [[SavePrefrences sharedInstance].notificationDic valueForKey:[NSString stringWithFormat:@"%@",userid]] addObject:[notiAr objectAtIndex:x]] ;
//             }
//         }
//           //NSLog(@"mutable dictionary is %@",[SavePrefrences sharedInstance].notificationDic);
//    }
//        
//    }
// }
//-(void) reteriveFriends
// {
//     iscallback=3;
//     NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//     [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
//     [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"genData" :@"":@"":dic1 :self];
//     
// }
//
//-(void) viewDidAppear:(BOOL)animated
//{
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
//
//- (void)didReceiveMemoryWarning
// {
//    [super didReceiveMemoryWarning];
//    
// }
//-(void)callMethod:(NSArray *)meta
//{
//    
//}
//
//
//
//
//
//
//
//
//@end
