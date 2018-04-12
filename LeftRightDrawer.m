

#import "LeftRightDrawer.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "SavePrefrences.h"
#import "ProfileView.h"
#import "AddCalendar.h"
#import "CalendarPopup.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MainBord.h"
#import "Podcast.h"
#import "Job.h"
#import "ManageArray.h"
#import "Storage.h"
#import "Support.h"
#import "AllValidationsViewController.h"
#import "MainController.h"
#import "Yolking.h"
#import "Chat.h"
#import "ProfileView.h"
#import "CommonProfile.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "openChat.h"
#import "NotificationHandler.h"
#import "ChatConversationsController.h"
#import "ChatViewController.h"
#import "ProfileViewController.h"
#import "ChatStorageEngine.h"
#import "GIBadgeView.h"
#import "LandingViewController.h"


@interface LeftRightDrawer ()
{
    UIView *videomainview,*webviewView,*mainouterView;
    UIView * actionView,*prMainView,*headerView,*cell_View,*viewfortable;
    NSMutableArray *leftAr,*leftImgAr,*rightAr,*rightimgAr,*nwfr,*cbfr,*leftImgArSelected;
    UIViewController *vc1;
    UITextField *mail,*search_lbl,*search_lbl1;
    int iscallback;
    
    NSMutableArray *CommAr,*cabntAr,*NetAr;
    UIScrollView *mainScrollView1,*scrollbar;
    UIImageView *imggeter,*userpic;
    AllValidationsViewController *allValidVC;
    ManageArray *mngAr;
    UILabel *NameLabel,*yokingnotiview,*offline,*online;
    NSMutableArray *popUpAr;
    UIView * imageview;
    ProfileView *prfv;
    AVPlayer *player;
    UIImageView *isonimg;
    UIView *middleView;
    int isbar,cellheight;
    CommonProfile *cmpop;
    NSString *frndid,*videoResume;
    UILabel *Community,*commbar,*yellowcomm,*yellowcbnt,*yellownet;
    NSMutableArray *notiiconAr;
    NSMutableDictionary *inviteBtndic,*alinvitedAr;
    int net,index;
    UIAlertView *alrt;
    NSString *image,*usrname,*fname,*lname,*friendid;
    AVPlayerViewController *playerViewController;
    int limit,whichtocall;
    float scrollpostion;
    NSString *frId;
    
    GIBadgeView *chatBadge, *yolkingBadge, *boardBadge, *calendarBadge;
}
@property(nonatomic,strong)NSMutableArray *popUpAr;
@end

@implementation LeftRightDrawer
@synthesize lefttableView,righttableView,cabinetTableview,commTableView,cbntTableView,netTableView,profilear1, mainView;
- (void)viewDidLoad {
    [super viewDidLoad];
    prfv =[[ProfileView alloc]init];
    allValidVC=[[AllValidationsViewController alloc]init];
    
    self.view.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"bodycolor"];
    notiiconAr=[[NSMutableArray alloc]init];
     playerViewController = [[AVPlayerViewController alloc] init];
     mngAr=[[ManageArray alloc]init];
    
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:@"reloadData" object:nil];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

-(void)reloadData:(NSNotification*)notification
{
    [self.lefttableView reloadData];
    
    iscallback=6;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile":@"showProfile" :@"":@"":dic1 :self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(UIView *) MainViewwithouttitle:(UIViewController *)Vc
{
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    allValidVC=[[AllValidationsViewController alloc]init];
    
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
  //  prMainView.backgroundColor=[UIColor clearColor];
    
    UITapGestureRecognizer *closereg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmisspop)];
    [closereg setNumberOfTouchesRequired:1];
    [closereg setDelegate:self];
    prMainView.userInteractionEnabled = YES;
    [prMainView addGestureRecognizer:closereg];
    
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 72)];
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[ff valueForKey:@"actionBar"];
    [prMainView addSubview:headerView];
    
    return prMainView;
}
-(UIView *) MainViewforttitle:(UIViewController *)Vc
{
    
    
  //  NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    allValidVC=[[AllValidationsViewController alloc]init];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(-2, 0, prMainView.frame.size.width+4, 72)];
    
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[UIColor redColor];//[ff valueForKey:@"actionBar"];
    [prMainView addSubview:headerView];
    
    return prMainView;
}


-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{
    
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.2f];
    

    [Vc.view addSubview:prMainView];
    vc1=Vc;
    
    
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+85, prMainView.frame.size.width-70, 50)];
    NameLabel.text=title;
    NameLabel.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    NameLabel.font=[UIFont systemFontOfSize:14];
    NameLabel.textColor=[UIColor blackColor];
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [prMainView addSubview:NameLabel];
    
    UIView *closeView=[[UIView alloc]initWithFrame:CGRectMake(NameLabel.frame.size.width+NameLabel.frame.origin.x,  [SavePrefrences sharedInstance ].naviHght+85, 30, 50)];
    closeView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f  green:215.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    [prMainView addSubview:closeView];
    
    UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 25, 25)];
    [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
    cross.userInteractionEnabled=YES;
    [closeView addSubview:cross];
    
    UITapGestureRecognizer *closereg = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(closeView1)];
    [closereg setNumberOfTouchesRequired:1];
    [closereg setDelegate:self];
    closeView.userInteractionEnabled = YES;
    [closeView addGestureRecognizer:closereg];
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20,NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40,[SavePrefrences sharedInstance].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance].stbarHght+70))];
    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    scrollbar.backgroundColor=[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:.6f];
    [prMainView addSubview:scrollbar];
    return prMainView;
}

-(void)closeView1
{
    [prMainView removeFromSuperview];
}
-(void) initArs :(UIViewController *)Vc
{
    
    mngAr=[[ManageArray alloc]init];
    vc1=Vc;
    leftAr=[[NSMutableArray alloc]init];
    leftImgAr=[[NSMutableArray alloc]init];
    rightAr=[[NSMutableArray alloc]init];
    rightimgAr=[[NSMutableArray alloc]init];
    leftImgArSelected=[[NSMutableArray alloc]init];

    [leftAr addObject:@"Yolking"];
    [leftAr addObject:@"Chat"];
    [leftAr addObject:@"Profile"];
    [leftAr addObject:@"Calendar"];
    [leftAr addObject:@"Video"];
    [leftAr addObject:@"Storage"];
    

    [leftAr addObject:@"Board"];
    [leftAr addObject:@"PodCast"];
    [leftAr addObject:@"Job"];
    [leftAr addObject:@"Support"];
    [leftAr addObject:@"LogOut"];
    
    [leftImgAr addObject:@"yolkingicn.png"];
    [leftImgAr addObject:@"drawerchat.png"];
    [leftImgAr addObject:@"profile.png"];
    [leftImgAr addObject:@"calendaricn.png"];
    [leftImgAr addObject:@"video.png"];
    [leftImgAr addObject:@"storageicn.png"];
    

    [leftImgAr addObject:@"boardicn.png"];
    [leftImgAr addObject:@"podcast.png"];
    [leftImgAr addObject:@"jobs.png"];
    [leftImgAr addObject:@"support.png"];
    [leftImgAr addObject:@"logout.png"];
    
    [leftImgArSelected addObject:@"yolkingselected.png"];
    [leftImgArSelected addObject:@"chatselected.png"];
    [leftImgArSelected addObject:@"profileselected.png"];
    [leftImgArSelected addObject:@"calendarselected.png"];
    [leftImgArSelected addObject:@"videoselected.png"];
    [leftImgArSelected addObject:@"storageselected.png"];
    

    [leftImgArSelected addObject:@"boardselected.png"];
    [leftImgArSelected addObject:@"podcastselected.png"];
    [leftImgArSelected addObject:@"jobsselected.png"];
    [leftImgArSelected addObject:@"support.png"];
    [leftImgArSelected addObject:@"logout.png"];
    if (self.flag==101) {
        [self customizeActionBar1];
    }
    else{
        [self customizeActionBar];
    }
    
    
    
}

-(void)customizeActionBar
{
    
    vc1.view.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    actionView=[[UIView alloc]initWithFrame:CGRectMake(-2, -2,  [SavePrefrences
                                                               sharedInstance].screenWidth+4,72)];

    actionView.backgroundColor =[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    
    actionView.layer.borderWidth=1;
    actionView.layer.borderColor=[[UIColor colorWithRed:126.0f/255 green:184.0f/255 blue:230.0f/255 alpha:1.0f] CGColor];

    [vc1.view addSubview:actionView];
    
    UIImageView *leftdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(5, 25, 40, 40)];
    leftdrawr.image = [UIImage imageNamed:@"drawerwhite.png"];
    leftdrawr.backgroundColor=[UIColor clearColor];
    [actionView addSubview:leftdrawr];
    
    UITapGestureRecognizer *addleftges = [[UITapGestureRecognizer
                                           alloc]initWithTarget:self action:@selector(openLeftDrawer)];
    [addleftges setNumberOfTouchesRequired:1];
    leftdrawr.userInteractionEnabled = YES;
    [leftdrawr addGestureRecognizer:addleftges];
    
    UIImageView *logo =[[UIImageView alloc]initWithFrame:CGRectMake(actionView.frame.size.width/2-75, 20, 150, 50)];
    logo.image = [UIImage imageNamed:@"logo_new.png"];
    logo.backgroundColor=[UIColor clearColor];
    [actionView addSubview:logo];
    
    
    
    UIImageView *rightdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(actionView.frame.size.width-60, 20, 50, 50)];
    rightdrawr.image = [UIImage imageNamed:@"cabineticon.png"];
    rightdrawr.backgroundColor=[UIColor clearColor];
    [actionView addSubview:rightdrawr];
    
    UITapGestureRecognizer *addrightges = [[UITapGestureRecognizer
                                            alloc]initWithTarget:self action:@selector(openRightDrawer)];
    [addrightges setNumberOfTouchesRequired:1];
    [addrightges setDelegate:self];
    rightdrawr.userInteractionEnabled = YES;
    [rightdrawr addGestureRecognizer:addrightges];
    
}


-(void)customizeActionBar1
{
    
    
    
    vc1.view.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    
    
    actionView=[[UIView alloc]initWithFrame:CGRectMake(-2, -2,  [SavePrefrences
                                                                 sharedInstance].screenWidth+4,72)];
    
    actionView.backgroundColor =[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    
    actionView.layer.borderWidth=1;
    actionView.layer.borderColor=[[UIColor colorWithRed:126.0f/255 green:184.0f/255 blue:230.0f/255 alpha:1.0f] CGColor];
    
    [vc1.view addSubview:actionView];
    
    UIImageView *leftdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 30, 25)];
    leftdrawr.image = [UIImage imageNamed:@"back1.png"];
    leftdrawr.backgroundColor=[UIColor clearColor];
    [actionView addSubview:leftdrawr];
    
    UITapGestureRecognizer *addleftges = [[UITapGestureRecognizer
                                           alloc]initWithTarget:self action:@selector(openbackButton)];
    [addleftges setNumberOfTouchesRequired:1];
    leftdrawr.userInteractionEnabled = YES;
    [leftdrawr addGestureRecognizer:addleftges];
    
    UIImageView *logo =[[UIImageView alloc]initWithFrame:CGRectMake(actionView.frame.size.width/2-75, 20, 150, 50)];
    logo.image = [UIImage imageNamed:@"logo_new.png"];
    logo.backgroundColor=[UIColor clearColor];
    [actionView addSubview:logo];
    
    
    
    UIImageView *rightdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(actionView.frame.size.width-60, 20, 50, 50)];
    rightdrawr.image = [UIImage imageNamed:@"cabineticon.png"];
    rightdrawr.backgroundColor=[UIColor clearColor];
    [actionView addSubview:rightdrawr];
    
    UITapGestureRecognizer *addrightges = [[UITapGestureRecognizer
                                            alloc]initWithTarget:self action:@selector(openRightDrawer)];
    [addrightges setNumberOfTouchesRequired:1];
    [addrightges setDelegate:self];
    rightdrawr.userInteractionEnabled = YES;
    [rightdrawr addGestureRecognizer:addrightges];
    
}


-(void)openbackButton{
    UIView *ppv=[self.popArr objectAtIndex:self.popArr.count-1] ;
    [self.popArr removeObjectAtIndex:popUpAr.count];
    [ppv removeFromSuperview];
    [self customizeActionBar];
    self.flag = 0;
}





-(UIView *)openLeftDrawer
{
    //here left menu
    mainView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight+[SavePrefrences sharedInstance].stbarHght+5)];
    [vc1.view addSubview:mainView];
    mainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.1f];
    
    UIView *uiPostCmnt = [[UIView alloc]initWithFrame:CGRectMake(0,[SavePrefrences sharedInstance].naviHght+[SavePrefrences sharedInstance].stbarHght+6,mainView.frame.size.width/2-115,mainView.frame.size.height-(actionView.frame.size.height-5))];
    
    NSMutableDictionary *bd=[SavePrefrences sharedInstance].colorDictionry;
    uiPostCmnt.backgroundColor=[UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:242.0f/255.0f alpha:1.0f];//[bd valueForKey:@"bodycolor"];
    [mainView addSubview:uiPostCmnt];
    
    UITapGestureRecognizer *addrightges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [addrightges setNumberOfTouchesRequired:1];
    [addrightges setDelegate:self];
    mainView.userInteractionEnabled = YES;
    [mainView addGestureRecognizer:addrightges];
    
    lefttableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,uiPostCmnt.frame.size.width, uiPostCmnt.frame.size.height-([SavePrefrences sharedInstance].stbarHght+5))];
    lefttableView.delegate = self;
    lefttableView.dataSource = self;
    lefttableView.scrollEnabled = YES;
    lefttableView.backgroundColor=[UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:242.0f/255.0f alpha:1.0f];//[bd valueForKey:@"bodycolor"];
    lefttableView.separatorColor=[UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:242.0f/255.0f alpha:1.0f];//[bd valueForKey:@"bodycolor"];
    [uiPostCmnt addSubview:lefttableView];
    
    
    
    return uiPostCmnt;
    
}

-(UIView *) openRightDrawer
{
    [self reteriveFriends ];
    return nil;
}

-(void) showRightDrawer
{
    
    [self dismiss];
    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight+[SavePrefrences sharedInstance].stbarHght)];
    mainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.1f];;
    [vc1.view addSubview:mainView];
    
    UIView *uiPostCmnt = [[UIView alloc]
                          initWithFrame:CGRectMake([SavePrefrences sharedInstance].screenWidth/2+15,[SavePrefrences sharedInstance].naviHght+[SavePrefrences sharedInstance].stbarHght+6,mainView.frame.size.width/2+50,mainView.frame.size.height-(actionView.frame.size.height-5) -[SavePrefrences sharedInstance].stbarHght)];
    uiPostCmnt.backgroundColor=[UIColor whiteColor];
    uiPostCmnt.layer.backgroundColor=[[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]CGColor];
    [mainView addSubview:uiPostCmnt];
    
    UITapGestureRecognizer *addrightges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [addrightges setNumberOfTouchesRequired:1];
    [addrightges setDelegate:self];
     mainView.userInteractionEnabled = YES;
    [mainView addGestureRecognizer:addrightges];
    
    //header
    UIView *friendview = [[UIView alloc]initWithFrame:CGRectMake(0,0,uiPostCmnt.frame.size.width-30+12,35)];
    friendview.backgroundColor=[UIColor colorWithRed:244.0f/255 green:236.0f/255 blue:197.0f/255 alpha:1.0f];//[ff valueForKey:@"rightDrawer"];
    [uiPostCmnt addSubview:friendview];
    
    
    UIImageView *logo1 =[[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 35, 35)];
    logo1.image = [UIImage imageNamed:@"cabineticon.png"];
    logo1.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"rightDrawer"];
    [friendview addSubview:logo1];
    
    
    UILabel *ntfr=[[UILabel alloc] initWithFrame:CGRectMake(logo1.frame.size.width+logo1.frame.origin.x+1, 2,friendview.frame.size.width-60, 30)];
    ntfr.backgroundColor=[UIColor clearColor];
    //ntfr.font = [UIFont fontWithName:@"Bold" size:13];
    [ntfr setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ntfr.textColor=[UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0f];;
    ntfr.text=@" Network";
    ntfr.textAlignment=NSTextAlignmentLeft;
    [friendview addSubview:ntfr];
    
    UIImageView *logo =[[UIImageView alloc]initWithFrame:CGRectMake(friendview.frame.size.width/2+30, 7, 30, 30)];
    logo.image = [UIImage imageNamed:@"search.png"];
    logo.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];;
    [friendview addSubview:logo];
    
   
    
    UITapGestureRecognizer *searchreg1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchFriends)];
    [searchreg1 setNumberOfTouchesRequired:1];
    [searchreg1 setDelegate:self];
    ntfr.userInteractionEnabled = YES;
    [ntfr addGestureRecognizer:searchreg1];
    
    UITapGestureRecognizer *searchreg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchFriends)];
    [searchreg setNumberOfTouchesRequired:1];
    [searchreg setDelegate:self];
    logo.userInteractionEnabled = YES;
    [logo addGestureRecognizer:searchreg];
   
    
    //header
    UIView *cabinetview = [[UIView alloc]initWithFrame:CGRectMake(0,uiPostCmnt.frame.size.height/2,uiPostCmnt.frame.size.width-30+12,35)];
    cabinetview.backgroundColor=[UIColor colorWithRed:244.0f/255 green:236.0f/255 blue:197.0f/255 alpha:1.0f];//[ff valueForKey:@"rightDrawer"];
    [uiPostCmnt addSubview:cabinetview];
    
    UIImageView *logo2 =[[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 35, 35)];
    logo2.image = [UIImage imageNamed:@"cabineticon.png"];
    logo2.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"rightDrawer"];
    [cabinetview addSubview:logo2];
    
//    UIImageView *logoCabinat =[[UIImageView alloc]initWithFrame:CGRectMake(friendview.frame.size.width/2+30, 7, 20, 20)];
//    logoCabinat.image = [UIImage imageNamed:@"search.png"];
//    logoCabinat.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];;
//    [cabinetview addSubview:logoCabinat];

    
    
    UILabel *cbfr=[[UILabel alloc] initWithFrame:CGRectMake(logo2.frame.size.width+logo2.frame.origin.x+1, 2,friendview.frame.size.width-60, 30)];
    cbfr.backgroundColor=[UIColor clearColor];
    //cbfr.font = [UIFont fontWithName:@"Bold" size:13];
    [cbfr setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    cbfr.textColor=[UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0f];
    cbfr.text=@"Cabinet";
    cbfr.textAlignment=NSTextAlignmentLeft;
    [cabinetview addSubview:cbfr];
    
    righttableView = [[UITableView alloc] initWithFrame:CGRectMake(.5,friendview.frame.size.height+1,uiPostCmnt.frame.size.width,uiPostCmnt.frame.size.height/2-35)];
    righttableView.delegate = self;
    righttableView.dataSource = self;
    righttableView.scrollEnabled = YES;
    righttableView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[UIColor whiteColor];
    righttableView.separatorColor=[UIColor clearColor];
    [uiPostCmnt addSubview:righttableView];
    
    cabinetTableview = [[UITableView alloc] initWithFrame:CGRectMake(.5,cabinetview.frame.size.height+cabinetview.frame.origin.y,uiPostCmnt.frame.size.width, uiPostCmnt.frame.size.height/2-(actionView.frame.size.height-34))];
    cabinetTableview.delegate = self;
    cabinetTableview.dataSource = self;
    cabinetTableview.scrollEnabled = YES;
    cabinetTableview.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[UIColor whiteColor];
    cabinetTableview.separatorColor=[UIColor clearColor];
    [uiPostCmnt addSubview:cabinetTableview];
    
}
-(void)searchFriends
{
    
    scrollpostion=0;
    [self dismiss];
    [self MainViewforttitle:vc1];
    [self initArs:vc1];
    
   //  NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 40, 40)];
    [bckarrow setImage:[UIImage imageNamed:@"drawerwhite.png"]];
    bckarrow.userInteractionEnabled=YES;
    [headerView addSubview:bckarrow];
    
    UIImageView *rightdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(actionView.frame.size.width-60, 20, 50, 50)];
    rightdrawr.image = [UIImage imageNamed:@"cabineticon.png"];
    rightdrawr.backgroundColor=[UIColor clearColor];
    [headerView addSubview:rightdrawr];

    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    bckarrow.userInteractionEnabled = YES;
    [bckarrow addGestureRecognizer:communityeg];
    
    //(leftdrawr.frame.size.width+80, 20, 150, 50)
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.size.width/2-75,20,150, 50)];
    [logo setImage:[UIImage imageNamed:@"logo_new.png"]];
    
    [headerView addSubview:logo];
    
    //header line
    headerView.layer.borderWidth=1;
    headerView.layer.borderColor=[[UIColor colorWithRed:126.0f/255 green:184.0f/255 blue:230.0f/255 alpha:1.0f] CGColor];

    
    float div= (headerView.frame.size.width)/3;
    
    
    NSMutableArray *shareAr=[[NSMutableArray alloc]init];
    [shareAr addObject:@"Community"];
    [shareAr addObject:@"Cabinet"];
    [shareAr addObject:@"Network"];
    float incx=0;
    for(int x=0; x<[shareAr count];x++)
    {
        Community=[[UILabel alloc]initWithFrame:CGRectMake(incx, headerView.frame.size.height+headerView.frame.origin.y,div+ 0.4, 40)];
        Community.text=[shareAr objectAtIndex:x];
        Community.textAlignment=NSTextAlignmentCenter;
        [Community setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        Community.textColor=[UIColor grayColor];
        Community.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
        [prMainView addSubview:Community];
        
        UITapGestureRecognizer *gradereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearchBar:)];
        [gradereg setNumberOfTouchesRequired:1];
        [gradereg setDelegate:self];
        Community.userInteractionEnabled = YES;
        Community.tag=x;
        [Community addGestureRecognizer:gradereg];
        
        commbar=[[UILabel alloc]initWithFrame:CGRectMake(incx, Community.frame.size.height+Community.frame.origin.y, div+0.4, 5)];
        commbar.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
        [prMainView addSubview:commbar];
        incx=incx+div;
    }
    
    yellowcomm=[[UILabel alloc]initWithFrame:CGRectMake(0, Community.frame.size.height+Community.frame.origin.y, div, 5)];
    yellowcomm.backgroundColor=[UIColor colorWithRed:46.0f/255 green:115.0f/255 blue:92.0f/255 alpha:1.0f];//[ff valueForKey:@"Yellowbtncolor"];
    yellowcomm.hidden=false;
    [prMainView addSubview:yellowcomm];
    
    yellowcbnt=[[UILabel alloc]initWithFrame:CGRectMake(yellowcomm.frame.size.width+yellowcomm.frame.origin.x, Community.frame.size.height+Community.frame.origin.y, div, 5)];
    yellowcbnt.backgroundColor=[UIColor colorWithRed:46.0f/255 green:115.0f/255 blue:92.0f/255 alpha:1.0f];//[ff valueForKey:@"Yellowbtncolor"];
    yellowcbnt.hidden=true;
    [prMainView addSubview:yellowcbnt];
    
    yellownet=[[UILabel alloc]initWithFrame:CGRectMake(yellowcbnt.frame.size.width+yellowcbnt.frame.origin.x, Community.frame.size.height+Community.frame.origin.y, div, 5)];
    yellownet.backgroundColor=[UIColor colorWithRed:46.0f/255 green:115.0f/255 blue:92.0f/255 alpha:1.0f];//[ff valueForKey:@"Yellowbtncolor"];
    yellownet.hidden=true;
    [prMainView addSubview:yellownet];
    
    middleView=[[UIView alloc]initWithFrame:CGRectMake(0, yellownet.frame.size.height+yellownet.frame.origin.y, prMainView.frame.size.width,40)];
    middleView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[ff valueForKey:@"backcolor"];
    [prMainView addSubview:middleView];
    
    UIView *LineMiddleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,2)];
    LineMiddleView.backgroundColor=[UIColor lightGrayColor];//colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[ff valueForKey:@"backcolor"];
    [middleView addSubview:LineMiddleView];

    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, (middleView.frame.size.width/2)-25, 30)];
   // search_lbl.placeholder=@"Search";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    search_lbl.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: color}];

    search_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    search_lbl.backgroundColor=[UIColor colorWithRed:214.0f/255 green:224.0f/255 blue:232.0f/255 alpha:1.0f];
    search_lbl.layer.cornerRadius=4;
    //search_lbl.layer.borderWidth=1;
    search_lbl.clipsToBounds=YES;
    search_lbl.delegate=self;
     [search_lbl addTarget:self action:@selector(searchHere:) forControlEvents:UIControlEventEditingChanged];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = paddingView2;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
    [middleView addSubview:search_lbl];
    
    search_lbl1=[[UITextField alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+5, 5, middleView.frame.size.width/2-25, 30)];
   // search_lbl1.placeholder=@"Location";
    search_lbl1.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Location" attributes:@{NSForegroundColorAttributeName: color}];

    search_lbl1.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    search_lbl1.backgroundColor=[UIColor colorWithRed:214.0f/255 green:224.0f/255 blue:232.0f/255 alpha:1.0f];
    search_lbl1.layer.cornerRadius=4;
    //search_lbl1.layer.borderWidth=1;
    search_lbl1.clipsToBounds=YES;
    search_lbl1.delegate=self;
    UIView *paddingView22 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl1.leftView = paddingView22;
    search_lbl1.leftViewMode = UITextFieldViewModeAlways;
    [middleView addSubview:search_lbl1];
    
    UIImageView *searchnow=[[UIImageView alloc]initWithFrame:CGRectMake(search_lbl1.frame.size.width+search_lbl1.frame.origin.x+5,5, 25, 25)];
    searchnow.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];
    searchnow.image=[UIImage imageNamed:@"search.png"];
    [middleView addSubview:searchnow];
    
    UITapGestureRecognizer *searchreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchHere:)];
    [searchreg setNumberOfTouchesRequired:1];
    [searchreg setDelegate:self];
    searchnow.userInteractionEnabled = YES;
    searchnow.tag=isbar;
    [searchnow addGestureRecognizer:searchreg];
    
    
    viewfortable=[[UIView alloc]initWithFrame:CGRectMake(0, middleView.frame.size.height+middleView.frame.origin.y, prMainView.frame.size.width, prMainView.frame.size.height-(middleView.frame.size.height+middleView.frame.origin.y+headerView.frame.size.height+headerView.frame.origin.y-60))];
    viewfortable.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
    [prMainView addSubview:viewfortable];
    
    [self retrievecommunityFriends];
    
}


-(void)retrievecommunityFriends
{
    
    iscallback=16;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:@"" forKey:@"str"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"UserSearch" :@"memSearch" :@"" :@"" :dic :self];
}

-(void)tapSearchBar:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    isbar=(int)tg.view.tag;
    if(isbar==0)
    {
        scrollpostion=0;
        CommAr =[[NSMutableArray alloc]init];
        limit=0;
        whichtocall=0;
        search_lbl.text=NULL;
        search_lbl1.hidden=false;
        search_lbl.frame=CGRectMake(10, 5, middleView.frame.size.width/2-25, 30);
        yellowcomm.hidden=false;
        yellowcbnt.hidden=true;
        yellownet.hidden=true;
        [netTableView removeFromSuperview];
        [cbntTableView removeFromSuperview];
        [self retrievecommunityFriends];
        
    }
    if(isbar==1)
    {
        scrollpostion=0;
        cabntAr =[[NSMutableArray alloc]init];
        limit=0;
        whichtocall=1;
        search_lbl.text=NULL;
        yellowcomm.hidden=true;
        yellowcbnt.hidden=false;
        yellownet.hidden=true;
        search_lbl1.hidden=true;
        search_lbl.frame=CGRectMake(10, 5, middleView.frame.size.width-50, 30);
       
        [commTableView removeFromSuperview];
        [netTableView removeFromSuperview];
        [self reterivecabFrnd];
        
    }
    if(isbar==2)
    {
        scrollpostion=0;
        NetAr=[[NSMutableArray alloc]init];
        limit=0;
        whichtocall=2;
        search_lbl.text=NULL;
        yellowcomm.hidden=true;
        yellowcbnt.hidden=true;
        yellownet.hidden=false;
        search_lbl1.hidden=true;
        search_lbl.frame=CGRectMake(10, 5, middleView.frame.size.width-50, 30);
        [commTableView removeFromSuperview];
        [cbntTableView removeFromSuperview];
        [self reteriveNetFrnd];
      
    }
    
}
-(void) reterivecabFrnd
{
    iscallback=7;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"CabSearch" :@"CabSearch" :@"" :@"" :dic :self];
}

-(void) reteriveNetFrnd
{
    iscallback=8;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"NetSearch" :@"NetSearch" :@"" :@"" :dic :self];
    
}






-(void)searchHere:(id)sender
{
    
    NSLog(@"srch limit");
    limit=0;
    scrollpostion=0;
    CommAr=[[NSMutableArray alloc]init];
    NetAr=[[NSMutableArray alloc]init];
    cabntAr=[[NSMutableArray alloc]init];
    [self serchHere];
}

-(void)serchHere
{
    
    NSLog(@"isbar===%d",isbar);
    
    if(isbar==0)
    {
        iscallback=9;
        whichtocall=3;
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setValue:search_lbl.text forKey:@"str"];
        [dic setValue:search_lbl1.text forKey:@"loc"];
        [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"srchUsrSrch" :@"" :@"" :dic :self];
        
        
    }
    else if (isbar==1)
    {
        whichtocall=4;
        iscallback=10;
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setValue:search_lbl.text forKey:@"str"];
        [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"srchCabSrch" :@"" :@"" :dic :self];
        
    }
    else if (isbar==2)
    {
        whichtocall=5;
        iscallback=11;
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setValue:search_lbl.text forKey:@"str"];
        [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"srchNetSrch" :@"" :@"" :dic :self];
        
    }
}




-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([searchStr isEqualToString:@""]) {
        [self serchHere];
    }

    return YES;
}



-(void)CommunityFriends
{
    
    [commTableView removeFromSuperview];
    commTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0,viewfortable.frame.size.width-20, viewfortable.frame.size.height)];
    commTableView.delegate = self;
    commTableView.dataSource = self;
    commTableView.scrollEnabled = YES;
    commTableView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    commTableView.separatorColor=[UIColor clearColor];
    [viewfortable addSubview:commTableView];
    
}
-(void)CabinetFriends
{
    NSLog(@"inside cabinet table");
    [cbntTableView removeFromSuperview];
    cbntTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0,viewfortable.frame.size.width-20, viewfortable.frame.size.height)];
    cbntTableView.delegate = self;
    cbntTableView.dataSource = self;
    cbntTableView.scrollEnabled = YES;
    cbntTableView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    cbntTableView.separatorColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [viewfortable addSubview:cbntTableView];
    
}
-(void)NetworkFriends
{
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    [netTableView removeFromSuperview];
    
    netTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0,viewfortable.frame.size.width-20, viewfortable.frame.size.height)];
    netTableView.delegate = self;
    netTableView.dataSource = self;
    netTableView.scrollEnabled = YES;
    netTableView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];///[ff valueForKey:@"backcolor"];
    netTableView.separatorColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [viewfortable addSubview:netTableView];
    
}

-(void)dissmisspop
   {
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

-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
  {
    
    if(theTableView==lefttableView)
    {
        
        cellheight=60;
        return [leftAr count];
    }
    
    else if(theTableView==righttableView)
    {
        cellheight=40;
        return  [nwfr count];
    }
    else if(theTableView==cabinetTableview)
    {
        cellheight=40;
        return  [cbfr count];
    }
    else if (theTableView==cbntTableView)
    {
        cellheight=60;
        alinvitedAr=[[NSMutableDictionary alloc]init];
        inviteBtndic =[[NSMutableDictionary alloc]init];
       
        
        return [cabntAr count];
    }
    else if (theTableView==commTableView)
    {
        cellheight=60;
        alinvitedAr=[[NSMutableDictionary alloc]init];
        inviteBtndic =[[NSMutableDictionary alloc]init];
        
   
        
        return [CommAr count];
    }
    else if (theTableView==netTableView)
    {
        cellheight=60;
        alinvitedAr=[[NSMutableDictionary alloc]init];
        inviteBtndic =[[NSMutableDictionary alloc]init];
        return [NetAr count];
    }
    

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
     
        if(theTableView==lefttableView){
            int count=0;
            
            NSString *MyCellIdentifier = @"MyCellIdentifier";
            UITableViewCell *cell = [self.lefttableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
            
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            cell.backgroundColor=[UIColor colorWithRed:141/255.0f green:141/255.0f blue:141/255.0f alpha:.0f];
            cell.tag=indexPath.row;
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openLeftMenu:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            cell.userInteractionEnabled = YES;
            [cell addGestureRecognizer:tapRecognizer];
            
            UIImageView *leftdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(lefttableView.frame.size.width/2-22, 10,44 ,50)];
            leftdrawr.contentMode = UIViewContentModeScaleAspectFit;
            leftdrawr.image = [UIImage imageNamed:[leftImgAr objectAtIndex:indexPath.row]];
            leftdrawr.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:leftdrawr];
            
            userDefaults = [NSUserDefaults standardUserDefaults];
            strTag = [userDefaults valueForKey:@"strTag"];
            NSLog(@"strTag.....%@",strTag);
            
            if ([strTag isEqualToString:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]){
                leftdrawr.image = [UIImage imageNamed:[leftImgArSelected objectAtIndex:indexPath.row]];
                NSLog(@"leftdrawr.image changed....");
            }
            NSString *strIndex=[NSString stringWithFormat:@"%ld", (long)indexPath.row];
            if ([strIndex isEqualToString:@"0"]){
                if (strTag == NULL){
                    leftdrawr.image = [UIImage imageNamed:[leftImgArSelected objectAtIndex:indexPath.row]];
                }
            }
            
            UILabel *iname=[[UILabel alloc] initWithFrame:CGRectMake(5,leftdrawr.frame.size.height+5, lefttableView.frame.size.width-10 , 30)];
            iname.backgroundColor=[UIColor clearColor];
            iname.textAlignment=NSTextAlignmentCenter;
            iname.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
            iname.textColor=[UIColor clearColor];//[ct valueForKey:@"popupcolor"];
            iname.text=[leftAr objectAtIndex:indexPath.row];
            [cell.contentView addSubview:iname];
            
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"Board"]){
                NSMutableArray * a9=[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"];
                NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:a9];
                a9 = [orderedSet array];
                
                NSArray* notiCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"BOARD_NOTIF_COUNT"];
                int unreadMsg = (int)notiCount.count;
                boardBadge = [GIBadgeView new];
                boardBadge.badgeValue = unreadMsg;
                [leftdrawr addSubview:boardBadge];
                boardBadge.topOffset = 5;
                boardBadge.rightOffset = 5;
                
                for(int x=0;x<[a9 count];x++)
                {
                    // NSArray * jsonObject=[mngAr convertojson:[a9 objectAtIndex: x]];
                    NSString *uid=[[a9 objectAtIndex: x] valueForKey:@"uid"];
                    //  NSString *ntc1=[[a9 objectAtIndex: x] valueForKey:@"ntc"];
                    //if(jsonObject!=nil)
                    //{
                    if([[SavePrefrences sharedInstance].uid intValue] !=[uid intValue])
                    {
                        
                        
                        NSString * brdid=[[a9 objectAtIndex:x] valueForKey:@"noti_id"];
                        if([[[SavePrefrences sharedInstance].isAlViedDic allKeys] containsObject:brdid])
                        {
                            
                        }
                        else{
                            count++;
                        }
                        
                        
                    }
                    NSLog(@"count is===========%d",count);
                    
                }
            }
            
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"Yolking"]){
                NSString* notiCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"YOLKING_COUNT"];
                int unreadMsg = notiCount.intValue;
                yolkingBadge = [GIBadgeView new];
                yolkingBadge.badgeValue = unreadMsg;
                [leftdrawr addSubview:yolkingBadge];
                yolkingBadge.topOffset = 5;
                yolkingBadge.rightOffset = 5;
            }
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"Chat"]){
                long unreadMsg = [[ChatStorageEngine sharedManager] getUnreadMessageCount:nil];
                chatBadge = [GIBadgeView new];
                chatBadge.badgeValue = unreadMsg;
                [leftdrawr addSubview:chatBadge];
                chatBadge.topOffset = 5;
                chatBadge.rightOffset = 5;
            }
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"Profile"])
            {
            }
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"Calendar"])
            {
                NSLog(@"calendar======khali");
                if([[SavePrefrences sharedInstance].allNotifictionDic count]>0)
                {
                    NSArray* calNotis =[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"];
                    long calCount = (long)calNotis.count;
                    calendarBadge = [GIBadgeView new];
                    calendarBadge.badgeValue = calCount;
                    [leftdrawr addSubview:calendarBadge];
                    calendarBadge.topOffset = 5;
                    calendarBadge.rightOffset = 5;
                }
            }
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"Video"])
            {
                
            }
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"Storage"])
            {
                NSMutableArray * a24=[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"24"];
                {
                    NSLog(@"a24=======%@",a24);
                    for(int x=0;x<[a24 count];x++)
                    {
                        // NSString * brdid=[[a24 objectAtIndex:x] valueForKey:@"time"] ;
                        NSString *uid=[[a24 objectAtIndex: x] valueForKey:@"uid"];
                        NSString * brdid=[[a24 objectAtIndex:x] valueForKey:@"noti_id"];
                        
                        if([[SavePrefrences sharedInstance].uid intValue] !=[uid intValue])
                        {
                            if([[[SavePrefrences sharedInstance].isAlViedDic allKeys] containsObject:brdid])
                            {
                                
                                //                    if([[[SavePrefrences sharedInstance].isAlViedDic allKeys] containsObject:brdid])
                                //                    {
                                //                        if([[SavePrefrences sharedInstance].ischkstor intValue]==0)
                                //                        {
                                //                            count=count+1;
                                //                        }
                                //                    }
                                //                    else
                                //                    {
                                //                      [[SavePrefrences sharedInstance].isAlViedDic setValue:brdid forKey:brdid];
                                //                       count=count+1;
                                //                    }
                            }
                            else{
                                count++;
                            }
                        }
                    }
                }
            }
            
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"Support"])
            {
                NSMutableArray * a24=[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"24"];
                {
                    NSLog(@"a24=======%@",a24);
                    for(int x=0;x<[a24 count];x++)
                    {
                        NSString *uid=[[a24 objectAtIndex: x] valueForKey:@"uid"];
                        NSString * brdid=[[a24 objectAtIndex:x] valueForKey:@"noti_id"];
                        
                        if([[SavePrefrences sharedInstance].uid intValue] !=[uid intValue])
                        {
                            if([[[SavePrefrences sharedInstance].isAlViedDic allKeys] containsObject:brdid])
                            {
                                
                            }
                            else{
                                count++;
                            }
                        }
                    }
                }
            }
            
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"PodCast"])
            {
                NSLog(@"a16======khali");
                
                
                NSMutableArray * a16=[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"];
                
                NSLog(@"a16======%@",a16);
                
                
                if(a16!=nil)
                {
                    for(int x=0;x<[a16 count];x++)
                    {
                        NSString *uid=[[a16 objectAtIndex: x] valueForKey:@"uid"];
                        //NSString *ntc1=[[a16 objectAtIndex: x] valueForKey:@"ntc"];
                        
                        if([[SavePrefrences sharedInstance].uid intValue] !=[uid intValue])
                        {
                            
                            
                            NSString * brdid=[[a16 objectAtIndex:x] valueForKey:@"noti_id"];
                            if([[[SavePrefrences sharedInstance].isAlViedDic allKeys] containsObject:brdid])
                            {
                            }
                            else{
                                count++;
                            }
                            
                            
                            //NSArray * jsonObject=[mngAr convertojson:[a16 objectAtIndex: x]];
                            //if(jsonObject!=nil)
                            //{
                            //                     NSString * brdid=[jsonObject valueForKey:@"podId"];
                            //                    if([[[SavePrefrences sharedInstance].isAlViedDic allKeys] containsObject:brdid])
                            //                      {
                            //                        if([[SavePrefrences sharedInstance].ischkboard intValue]==0)
                            //                        {
                            //                            count=count+1;
                            //                        }
                            //                        else if([ntc1 intValue]==16||[ntc1 intValue]==17)
                            //                        {
                            //                            count++;
                            //                        }
                            //
                            //                    }
                            //                    else
                            //                    {
                            //                        [[SavePrefrences sharedInstance].isAlViedDic setValue:brdid forKey:brdid];
                            //                        count=count+1;
                            //                    }
                            
                            //}
                            
                        }
                    }
                }
            }
            if([[leftAr objectAtIndex:indexPath.row] isEqual:@"Job"]){
                NSLog(@"inside job======");
                
                NSMutableArray * a29=[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"29"];
                NSLog(@"inside job======%@",a29);
                
                for(int x=0;x<[a29 count];x++)
                {
                    //NSString * ntc=[[a29 objectAtIndex:x] valueForKey:@"ntc"];
                    
                    //NSLog(@"ntc=================%@",ntc);
                    
                    //                NSString * brdid;
                    //                if([ntc intValue]==29)
                    //                {
                    //                 
                    //                     NSArray * jsonObject=[mngAr convertojson:[a29 objectAtIndex: x]];
                    //                     brdid=[jsonObject valueForKey:@"jobId"];
                    //                }
                    //                else if([ntc intValue]==30)
                    //                {
                    //                  brdid=[[a29 objectAtIndex:x] valueForKey:@"time"];
                    //                }
                    NSString *uid=[[a29 objectAtIndex: x] valueForKey:@"uid"];
                    if([[SavePrefrences sharedInstance].uid intValue] !=[uid intValue])
                    {
                        //
                        NSString * brdid=[[a29 objectAtIndex:x] valueForKey:@"noti_id"];
                        if([[[SavePrefrences sharedInstance].isAlViedDic allKeys] containsObject:brdid])
                        {
                        }
                        else
                        {
                            count++;
                        }
                        
                        //if([[[SavePrefrences sharedInstance].isAlViedDic allKeys] containsObject:brdid])
                        //                        {
                        //                            if([[SavePrefrences sharedInstance].ischkjob intValue]==0)
                        //                            {
                        //                                count=count+1;
                        //                            }
                        //                        }
                        //                        else
                        //                        {
                        //                            [[SavePrefrences sharedInstance].isAlViedDic setValue:brdid forKey:brdid];
                        //                            count=count+1;
                        //                        }
                        
                        
                    }
                }
            }
            
            return cell;
        }
    else if(theTableView==righttableView){
        NSArray * nwfrl= [nwfr objectAtIndex:indexPath.row];
        
        NSString *fname1=[nwfrl valueForKey:@"fname"];
        NSString *MyCellIdentifier = @"MyCellIdentifier";
        UITableViewCell *cell = [self.righttableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openNetpop:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        cell.userInteractionEnabled = YES;
        cell.tag=indexPath.row;
        [cell addGestureRecognizer:tapRecognizer];
        
        if (indexPath.row==0)
        {
            
        }
        else
        {

        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100,0,self.view.bounds.size.width,0.75)];
        separator.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:separator];
        }

        
        UIImageView *leftdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.size.height/2-13, 27, 27)];
        leftdrawr.image = [UIImage imageNamed:@"username.png"];
        leftdrawr.backgroundColor=[UIColor clearColor];
        leftdrawr.layer.cornerRadius=13;
        leftdrawr.clipsToBounds=YES;
        [cell.contentView addSubview:leftdrawr];
        
        NSString *Img =  [nwfrl valueForKey:@"img"];
        Img= [mngAr concatUrl:Img];
          [leftdrawr sd_setImageWithURL:[NSURL URLWithString:Img]];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//        if(Img.length<12)
//        {
//            leftdrawr.image = [UIImage imageNamed:Img];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if (imageData.length<=0)
//                leftdrawr.image = [UIImage imageNamed:@"username.png"];
//            else
//                leftdrawr.image = [UIImage imageWithData:imageData];
//            
//        }
        leftdrawr.userInteractionEnabled =YES;
        
        UILabel *iname=[[UILabel alloc]initWithFrame:CGRectMake(leftdrawr.frame.size.width+20, 5,cell.frame.size.width-(leftdrawr.frame.size.width+20+140), 20)];
        iname.backgroundColor=[UIColor clearColor];
        iname.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        iname.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"rightDrawer"];
        
        NSString *fname=[nwfrl valueForKey:@"fname"];
        NSString *lname=[nwfrl valueForKey:@"lname"];
        
        if(![fname isEqual:[NSNull null]])
            iname.text=[[fname stringByAppendingString:@" "]stringByAppendingString:lname];
        else
            iname.text=@"Not Found";
        
        [cell.contentView addSubview:iname];
        
        
        NSString *io = [nwfrl valueForKey:@"isonline"];
        
        if (![io isEqual:[NSNull null]])
        {
            int dd=[io intValue];
            if(dd==1)
            {
                isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-98,25 ,14, 14)];
                isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
                isonimg.backgroundColor=[UIColor clearColor];
                [cell.contentView addSubview:isonimg];
            }
            if(dd==0)
            {
                isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-98,27 ,9, 9)];
               // isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
                isonimg.backgroundColor=[UIColor lightGrayColor];
                isonimg.layer.cornerRadius=4.5;
                [cell.contentView addSubview:isonimg];

            }

        }
        
        UILabel *linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, iname.frame.origin.y+34,cell.frame.size.width, .5)];
        linelabel.backgroundColor=[UIColor grayColor];
       // [cell.contentView addSubview:linelabel];
        
        
        
        return cell;
    }
    
    else if(theTableView==cabinetTableview)
    {
        
        NSString *MyCellIdentifier = @"MyCellIdentifier";
        UITableViewCell *cell = [self.cabinetTableview dequeueReusableCellWithIdentifier:MyCellIdentifier];
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(opencabinetpop:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        cell.userInteractionEnabled = YES;
        cell.tag=indexPath.row;
        [cell addGestureRecognizer:tapRecognizer];
        
        if (indexPath.row==0)
        {
            
        }
        else
        {
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100,0,self.view.bounds.size.width,0.75)];
            separator.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:separator];
        }
        
        NSArray * cbfrl= [cbfr objectAtIndex:indexPath.row];
        
        NSString *fname=[cbfrl valueForKey:@"fname"];
        NSString *lname=[cbfrl valueForKey:@"lname"];
        
        
        UIImageView *leftdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.size.height/2-13, 27, 27)];
        leftdrawr.image = [UIImage imageNamed:@"username.png"];
        leftdrawr.backgroundColor=[UIColor clearColor];
        leftdrawr.layer.cornerRadius=13;
        leftdrawr.clipsToBounds=YES;
        [cell.contentView addSubview:leftdrawr];
        
        NSString *Img =  [cbfrl valueForKey:@"img"];

        Img= [mngAr concatUrl:Img];
         [leftdrawr sd_setImageWithURL:[NSURL URLWithString:Img]];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//        if(Img.length<12)
//        {
//            leftdrawr.image = [UIImage imageNamed:Img];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if (imageData.length<=0)
//                leftdrawr.image = [UIImage imageNamed:@"username.png"];
//            else
//                leftdrawr.image = [UIImage imageWithData:imageData];
//        }
        leftdrawr.userInteractionEnabled =YES;
        
        UILabel *iname=[[UILabel alloc]initWithFrame:CGRectMake(leftdrawr.frame.size.width+20, 5,cell.frame.size.width-(leftdrawr.frame.size.width+20+140), 20)];
        iname.backgroundColor=[UIColor clearColor];
        iname.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        iname.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"rightDrawer"];
        iname.text=[[fname stringByAppendingString:@" "]stringByAppendingString:lname];
        [cell.contentView addSubview:iname];
        
        NSString *io = [cbfrl valueForKey:@"isonline"];
        if (![io isEqual:[NSNull null]])
        {
            int dd=[io intValue];
            if(dd==1)
            {
                UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-100,25 ,14, 14)];
                isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
                isonimg.backgroundColor=[UIColor clearColor];
                [cell.contentView addSubview:isonimg];
            }
            if(dd==0)
            {
                isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-98,27 ,9, 9)];
                // isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
                isonimg.backgroundColor=[UIColor lightGrayColor];
                isonimg.layer.cornerRadius=4.5;
                [cell.contentView addSubview:isonimg];
                
            }

        }
        
        return cell;
        
    }
    else if(theTableView==commTableView)
    {
        @try {
         
        NSString *MyCellIdentifier = @"MyCellIdentifier";
        UITableViewCell *cell = [self.commTableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.clipsToBounds=YES;
        
        
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, commTableView.frame.size.width, 73)];
        cell_View.backgroundColor=[UIColor clearColor];
       // cell_View.layer.borderWidth=1;
       // cell_View.layer.borderColor=[[UIColor redColor] CGColor];
       // cell_View.layer.cornerRadius=6;
      //  cell_View.clipsToBounds=YES;
        [cell addSubview: cell_View];
        
            if (indexPath.row==0)
            {
                
            }
            else
            {

        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,0.75)];
        separator.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:separator];
            }
            
        
        NSString *fname=[[CommAr objectAtIndex:indexPath.row]valueForKey:@"fname"];
        NSString *lname=[[CommAr objectAtIndex:indexPath.row]valueForKey:@"lname"];
        NSString *isonline=[[CommAr objectAtIndex:indexPath.row]valueForKey:@"isonline"];
        NSString *u_id=[[CommAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        
        userpic=[[UIImageView alloc]initWithFrame:CGRectMake(3, cell.frame.size.height/2-10, 35, 35)];
        userpic.backgroundColor=[UIColor clearColor];
            userpic.layer.cornerRadius=17;
        userpic.layer.masksToBounds = YES;
       // [userpic setImage:[UIImage imageNamed:@"user.png"]];
        
        NSString *Img =  [[CommAr valueForKey:@"img"]objectAtIndex:indexPath.row ];
        Img= [mngAr concatUrl:Img];
         [userpic sd_setImageWithURL:[NSURL URLWithString:Img]];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//        if(Img.length<12)
//        {
//            userpic.image = [UIImage imageNamed:Img];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if (imageData.length<=0)
//                userpic.image = [UIImage imageNamed:@"username.png"];
//            else
//                userpic.image = [UIImage imageWithData:imageData];
//            
//        }

        
        [cell_View addSubview:userpic];
        //here
        UILabel  * uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5+1,cell_View.frame.size.height/2 -18,cell_View.frame.size.width/2 -20, 22)];
        uname_lbl.textColor=[UIColor  grayColor];//colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
        if([allValidVC checkNullStr:fname])
        {
            uname_lbl.text=[[fname stringByAppendingString:@" "]stringByAppendingString:lname];
        }
        uname_lbl.backgroundColor=[UIColor clearColor];
        [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        [cell_View addSubview: uname_lbl];
        
           
        offline=[[UILabel alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-50, cell_View.frame.size.height/2 -18 ,80, 22)];
        offline.textColor=[UIColor  grayColor];//colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
        offline.backgroundColor=[UIColor clearColor];
        offline.text=@"Offline";
        [offline setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [cell_View addSubview: offline];
        
        if (![isonline isEqual:[NSNull null]])
        {
            int dd=[isonline intValue];
            if(dd==1)
            {
                offline.hidden=true;
                
                isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-70, cell_View.frame.size.height/2 -15 ,15, 15)];
                isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
                isonimg.backgroundColor=[UIColor clearColor];
                [cell_View addSubview:isonimg];
                
               // online=[[UILabel alloc]initWithFrame:CGRectMake(isonimg.frame.size.width+isonimg.frame.origin.x+5,uname_lbl.frame.size.height+uname_lbl.frame.origin.y+7 ,80, 20)];

                online=[[UILabel alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-50, cell_View.frame.size.height/2 -18 ,80, 22)];
                online.textColor=[UIColor  grayColor];//colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
                online.backgroundColor=[UIColor clearColor];
                online.text=@"Online";
                [online setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
                [cell_View addSubview: online];
                
            }
            else{
                isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-70+2, cell_View.frame.size.height/2 -11 ,9, 9)];
                isonimg.backgroundColor=[UIColor grayColor];
                isonimg.layer.cornerRadius=4.5;
                [cell_View addSubview:isonimg];
            }
            
        }
            
        else{
            isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-70+2, cell_View.frame.size.height/2 -11 ,9, 9)];
            isonimg.backgroundColor=[UIColor grayColor];
            isonimg.layer.cornerRadius=4.5;
            [cell_View addSubview:isonimg];
        }
        
        //here
        UIButton *invite=[[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-150, cell_View.frame.size.height/2-18, 100,22)];
        [invite setTitleColor:[UIColor colorWithRed:46.0f/255 green:116.0f/255 blue:92.0f/255 alpha:1.0] forState:UIControlStateNormal];
        invite.backgroundColor=[UIColor clearColor];
        [invite setTitle:@"Invite" forState:UIControlStateNormal];
        [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        invite.tag=indexPath.row;
            
        invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        [invite addTarget:self action:@selector(sendFriendReq:) forControlEvents:UIControlEventTouchUpInside];
        invite.layer.cornerRadius=4;
        [invite setClipsToBounds:YES];
        [cell_View addSubview:invite];
        
        NSString *status=[[CommAr objectAtIndex:indexPath.row]valueForKey:@"status"];
        if([[alinvitedAr allKeys] containsObject:[NSString stringWithFormat:@"%d",(int)indexPath.row]])
        {
            [invite setTitle:@"Request Sent" forState:UIControlStateNormal];
            //invite.backgroundColor=[UIColor grayColor];
            invite.backgroundColor=[UIColor clearColor];
            [invite setTitleColor:[UIColor colorWithRed:46.0f/255 green:116.0f/255 blue:92.0f/255 alpha:1.0] forState:UIControlStateNormal];

        }
      else  if(status==nil||status==NULL||[status isEqual:[NSNull null]]||status == (id)[NSNull null])
        {
            [invite setTitle:@"Invite" forState:UIControlStateNormal];
            invite.backgroundColor=[UIColor clearColor];
            [invite setTitleColor:[UIColor colorWithRed:46.0f/255 green:116.0f/255 blue:92.0f/255 alpha:1.0] forState:UIControlStateNormal];

        }
        else if([status intValue]==0)
        {
            [invite setTitle:@"Request Sent" forState:UIControlStateNormal];
           // invite.backgroundColor=[UIColor redColor];
            invite.backgroundColor=[UIColor clearColor];
            [invite setTitleColor:[UIColor colorWithRed:46.0f/255 green:116.0f/255 blue:92.0f/255 alpha:1.0] forState:UIControlStateNormal];

        }
        
        else if([status intValue]==1)
        {
            [invite setTitle:@"My Friend" forState:UIControlStateNormal];
           // invite.backgroundColor=[UIColor grayColor];
            
            invite.backgroundColor=[UIColor clearColor];
            [invite setTitleColor:[UIColor colorWithRed:46.0f/255 green:116.0f/255 blue:92.0f/255 alpha:1.0] forState:UIControlStateNormal];

        }
        [inviteBtndic setObject:invite forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        
        scrollpostion= commTableView.contentOffset.y+600;
            
            return cell;

        }
        @catch (NSException *exception)
        {
            NSLog(@"Exception is======%@",exception);
        }
        
        
    }
    else if(theTableView==cbntTableView)
    {//whitecolor
        
        NSString *MyCellIdentifier = @"MyCellIdentifier";
        UITableViewCell *cell = [self.cbntTableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:252.0f/255 alpha:1.0];//[ff valueForKey:@"backcolor"];
        

        cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cbntTableView.frame.size.width, 73)];
        cell_View.backgroundColor=[UIColor clearColor];
        [cell addSubview: cell_View];
        
        if (indexPath.row==0)
        {
            
        }
        else
        {

        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,0.75)];
        separator.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:separator];
        }
        NSString *uname=[[cabntAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *isonline=[[cabntAr objectAtIndex:indexPath.row]valueForKey:@"isonline"];
        NSString *u_id=[[cabntAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        
        userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.size.height/2-10, 35, 35)];
        userpic.backgroundColor=[UIColor clearColor];
        userpic.layer.cornerRadius=17;
        userpic.layer.masksToBounds=YES;
        [userpic setImage:[UIImage imageNamed:@"username.png"]];
        
        NSString *Img =  [[cabntAr valueForKey:@"img"]objectAtIndex:indexPath.row ];
        Img= [mngAr concatUrl:Img];
         [userpic sd_setImageWithURL:[NSURL URLWithString:Img]];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//        if(Img.length<12)
//        {
//            userpic.image = [UIImage imageNamed:Img];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if (imageData.length<=0)
//                userpic.image = [UIImage imageNamed:@"username.png"];
//            else
//                userpic.image = [UIImage imageWithData:imageData];
//            
//        }

        [cell_View addSubview:userpic];
        //here
        //userpic.frame.size.width+userpic.frame.origin.x+5,cell_View.frame.size.height/2 -18,cell_View.frame.size.width/2 -20, 22
        UILabel  * uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5+3,cell_View.frame.size.height/2 -18,cell_View.frame.size.width/2 -20, 22)];
        uname_lbl.textColor=[UIColor grayColor];//colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
        if([allValidVC checkNullStr:uname])
        {
            uname_lbl.text=uname;
        }
        uname_lbl.backgroundColor=[UIColor clearColor];
        [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        [cell_View addSubview: uname_lbl];
        
        //here
        UIButton *invite=[[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-150, cell_View.frame.size.height/2-18, 100,22)];
        [invite setTitleColor:[UIColor colorWithRed:46.0f/255 green:116.0f/255 blue:92.0f/255 alpha:1.0] forState:UIControlStateNormal];
        invite.backgroundColor=[UIColor clearColor];
        [invite setTitle:@"My Friend" forState:UIControlStateNormal];
        [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        invite.tag=indexPath.row;
        
        invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [invite addTarget:self action:@selector(sendFriendReq:) forControlEvents:UIControlEventTouchUpInside];
        invite.layer.cornerRadius=4;
        [invite setClipsToBounds:YES];
        [cell_View addSubview:invite];

        
        
        //cell_View.frame.size.width+cell_View.frame.origin.x-50, cell_View.frame.size.height/2 -18 ,80, 22
        offline=[[UILabel alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-50, cell_View.frame.size.height/2 -18 ,80, 22)];
        offline.textColor=[UIColor grayColor];//colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
        offline.backgroundColor=[UIColor clearColor];
        offline.text=@"Offline";
        [offline setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [cell_View addSubview: offline];
        
        
        
        //cell_View.frame.size.width+cell_View.frame.origin.x-70, cell_View.frame.size.height/2 -12 ,15, 15
        if (![isonline isEqual:[NSNull null]])
        {
            int dd=[isonline intValue];
            if(dd==1)
            {
                offline.hidden=true;
                
                isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-70, cell_View.frame.size.height/2 -15 ,15, 15)];
                isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
                isonimg.backgroundColor=[UIColor clearColor];
                [cell_View addSubview:isonimg];
                
                online=[[UILabel alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-50, cell_View.frame.size.height/2 -18 ,80, 22)];
                online.textColor=[UIColor  grayColor];
                online.backgroundColor=[UIColor clearColor];
                online.text=@"Online";
                [online setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
                [cell_View addSubview: online];
            }
            else
               {
                
                    isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-70+2, cell_View.frame.size.height/2 -11 ,9, 9)];
                    isonimg.backgroundColor=[UIColor grayColor];
                    isonimg.layer.cornerRadius=4.5;
                    [cell_View addSubview:isonimg];
                }
        }
           else{
               isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-70+2, cell_View.frame.size.height/2 -11 ,9, 9)];
                isonimg.backgroundColor=[UIColor grayColor];
                isonimg.layer.cornerRadius=4.5;
                [cell_View addSubview:isonimg];
            }
       
         scrollpostion= cbntTableView.contentOffset.y+600;
        
        return cell;
        
    }
    else if(theTableView==netTableView)
    {
        NSString *MyCellIdentifier = @"MyCellIdentifier";
        UITableViewCell *cell = [self.netTableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0];
        
        
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, netTableView.frame.size.width, 73)];
        cell_View.backgroundColor=[UIColor clearColor];
      //  cell_View.layer.borderWidth=1;
       // cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
       // cell_View.layer.cornerRadius=6;
        [cell addSubview: cell_View];
        
        if (indexPath.row==0)
        {
            
        }
        else
        {
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,0.75)];
        separator.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:separator];
        }
        
        NSString *uname=[[NetAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *isonline=[[NetAr objectAtIndex:indexPath.row]valueForKey:@"isonline"];
        NSString *uid=[[NetAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *status=[[NetAr objectAtIndex:indexPath.row]valueForKey:@"status"];
        
        UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.size.height/2-10, 35, 35)];
        userpic.backgroundColor=[UIColor clearColor];
        [userpic setImage:[UIImage imageNamed:@"username.png"]];
        userpic.layer.cornerRadius=17;
        userpic.layer.masksToBounds=YES;
        
        
        NSString *Img =  [[NetAr valueForKey:@"img"]objectAtIndex:indexPath.row ];
        Img= [mngAr concatUrl:Img];
         [userpic sd_setImageWithURL:[NSURL URLWithString:Img]];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//        if(Img.length<12)
//        {
//            userpic.image = [UIImage imageNamed:Img];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if (imageData.length<=0)
//                userpic.image = [UIImage imageNamed:@"username.png"];
//            else
//                userpic.image = [UIImage imageWithData:imageData];
//            
//        }

        [cell_View addSubview:userpic];
        
        //userpic.frame.size.width+userpic.frame.origin.x+5,cell_View.frame.size.height/2 -18,cell_View.frame.size.width/2 -20, 22
        //cell_View.frame.size.width+cell_View.frame.origin.x-50, cell_View.frame.size.height/2 -18 ,80, 22
        //cell_View.frame.size.width+cell_View.frame.origin.x-70, cell_View.frame.size.height/2 -12 ,15, 15

        
        UILabel  *uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5+3,cell_View.frame.size.height/2 -18,cell_View.frame.size.width/2 -20, 22)];
        uname_lbl.textColor=[UIColor  grayColor];//colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
        if([allValidVC checkNullStr:uname])
        {
            uname_lbl.text=uname;
        }
        uname_lbl.backgroundColor=[UIColor clearColor];
        [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        [cell_View addSubview: uname_lbl];
        
        //here
        UIButton *invite=[[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-150, cell_View.frame.size.height/2-18, 100,22)];
        [invite setTitleColor:[UIColor colorWithRed:46.0f/255 green:116.0f/255 blue:92.0f/255 alpha:1.0] forState:UIControlStateNormal];
        invite.backgroundColor=[UIColor clearColor];
        [invite setTitle:@"My Friend" forState:UIControlStateNormal];
        [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        invite.tag=indexPath.row;
        invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [invite addTarget:self action:@selector(sendFriendReq:) forControlEvents:UIControlEventTouchUpInside];
        invite.layer.cornerRadius=4;
        [invite setClipsToBounds:YES];
        [cell_View addSubview:invite];

        
        
        offline=[[UILabel alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-50, cell_View.frame.size.height/2 -18 ,80, 22)];
        offline.textColor=[UIColor  grayColor];//colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
        offline.backgroundColor=[UIColor clearColor];
        offline.text=@"Ofline";
        [offline setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [cell_View addSubview: offline];
        
        
        if (![isonline isEqual:[NSNull null]])
        {
            int dd=[isonline intValue];
            if(dd==1)
            {
                offline.hidden=true;
                
                isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-70, cell_View.frame.size.height/2 -12 ,15, 15)];
                isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
                isonimg.backgroundColor=[UIColor clearColor];
                [cell_View addSubview:isonimg];
                
                online=[[UILabel alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-50, cell_View.frame.size.height/2 -18 ,80, 22)];
                online.textColor=[UIColor  grayColor];//colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
                online.backgroundColor=[UIColor clearColor];
                online.text=@"Online";
                [online setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
                [cell_View addSubview: online];
                
            }
            else
            {
                isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-70+2, cell_View.frame.size.height/2 -11 ,9, 9)];
                isonimg.backgroundColor=[UIColor grayColor];
                isonimg.layer.cornerRadius=4.5;
                [cell_View addSubview:isonimg];
            }
            
        }
        else{
            isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-70+2, cell_View.frame.size.height/2 -11 ,9, 9)];
            isonimg.backgroundColor=[UIColor grayColor];
            isonimg.layer.cornerRadius=4.5;
            [cell_View addSubview:isonimg];
        }
       
       scrollpostion= netTableView.contentOffset.y+600;
        
        return cell;
        
    }
    
        
    } @catch (NSException *exception) {
        NSLog(@"Exception ios=====%@",exception);
    }
        
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return cellheight;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath  *)indexPath
{
    if(tableView==lefttableView)
    {
     //   leftdrawr.image = [UIImage imageNamed:[leftImgArSelected objectAtIndex:indexPath.row]];
      //  NSLog(@"leftdrawr.image......");
        
      //  [self openLeftMenu1:indexPath.row];
    }
}*/

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

    NSLog(@"scrolll  viewww     %ld",(maximumOffset - currentOffset));
    
    
    if (maximumOffset - currentOffset <= -100)
    {
        if(whichtocall==0)//commTableView
        {
             limit=limit+18;
             [self retrievecommunityFriends];
        }
        else if(whichtocall==1)//reterivecabFrnd
        {
            limit=limit+18;
            [self reterivecabFrnd];
             NSLog(@"herererereree1");
        
        }
        else if(whichtocall==2)//netTableView
        {
            NSLog(@"herererereree2");
            limit=limit+18;
            [self reteriveNetFrnd];
        }
        
        else if(whichtocall==3)//community search
        {
             limit=limit+18;
            [self serchHere];
           
        }
        else if(whichtocall==4)//cabi search
        {
            limit=limit+18;
            [self serchHere];
            
        }
        else if(whichtocall==5)//net search
        {
              limit=limit+18;
            [self serchHere];
          
        }
        
    }
    
}


-(IBAction)sendFriendReq:(id)sender
{
    UIButton *btn1=(UIButton*)sender;
    if([btn1.titleLabel.text isEqual:@"Invite"])
    {
    int fr=(int)btn1.tag;
    
    UIButton *btn= [inviteBtndic valueForKey:[NSString stringWithFormat:@"%d",fr]];
    [btn setTitle:@"Request Sent" forState:normal];
    
    btn.backgroundColor=[UIColor clearColor];
    
    [alinvitedAr setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    
    
    if(isbar==0)
    {
     frndid=[[CommAr objectAtIndex:fr]valueForKey:@"u_id"];
    }
    if(isbar==1)
    {
     frndid=[[cabntAr objectAtIndex:fr]valueForKey:@"u_id"];
    }
    if(isbar==2)
     {
     frndid=[[NetAr objectAtIndex:fr]valueForKey:@"u_id"];
    }
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic1 setValue:frndid forKey:@"fruid"];
    iscallback=12;
    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"friendReq" :@"" :@"" :dic1 :self];
    }
    
}


-(void) openLeftMenu:(id)sender{
    UITapGestureRecognizer *tapges=(UITapGestureRecognizer *)sender;
    int idd=(int)[tapges.view tag];
    
    // [dictStatus setValue:[NSString stringWithFormat:@"%d",idd] forKey:@"status"];
    
    strTag=[NSString stringWithFormat:@"%d",idd];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:strTag forKey:@"strTag"];
    [userDefaults synchronize];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(idd==0){
        //  NSMutableDictionary *dictStatus=[[NSMutableDictionary alloc]init];
        
        
        
        NSString *MyCellIdentifier = @"MyCellIdentifier";
        UITableViewCell *cell = [self.lefttableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        
        // cell.imageView.image = [UIImage imageNamed:@"chatselected.png"];
        //  cell.leftdrawr.image = [UIImage imageNamed:@"chatselected.png"];//[leftImgAr objectAtIndex:indexPath.row]];
        
        //yolking
        Yolking *vc2=[[Yolking alloc]initWithNibName:@"Yolking" bundle:nil];
        [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
        
        
        //[self yolk];
        
        
    }
    else if (idd==1)
    {
        //chat
        [self dissmissmainView];
        UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ChatConversationsController* conversations = [mainStoryboard instantiateViewControllerWithIdentifier:@"CONVERSATIONS"];
        [appDelegate.navigationController setViewControllers:@[conversations] animated:NO];
    }
    else if(idd==2)
    {
        [self dissmissmainView];
        ProfileViewController *vc2 = [[ProfileViewController alloc] init];
        if([[SavePrefrences sharedInstance].uid isKindOfClass:[NSNumber class]]){
            vc2.userId = [(NSNumber*)[SavePrefrences sharedInstance].uid stringValue];
        }else{
            vc2.userId = [SavePrefrences sharedInstance].uid;
        }
        [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
        
//        self.view.backgroundColor=[UIColor colorWithRed:189/255.0f green:189/255.0f blue:189/255.0f alpha:1.0f];
//        iscallback=6;
//        
//        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//        [[SavePrefrences sharedInstance].skthand emitData:@"Profile":@"showProfile" :@"":@"":dic1 :self];
        //profile
    }
    
    else if(idd==3)
    {
        [self dissmissmainView];
        AddCalendar *vc2 = [[AddCalendar alloc] initWithNibName:@"AddCalendar"
                                                         bundle:nil];
        [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
        
        //calendar
    }
    else if(idd==4)
    {
        //video
        [self dissmissmainView];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (appDelegate.videoController) {
            [appDelegate.navigationController setViewControllers:@[appDelegate.videoController] animated:NO];
        }else{
            UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            appDelegate.videoController = [mainStoryboard instantiateViewControllerWithIdentifier:@"VideoChatController"];
            [appDelegate.navigationController setViewControllers:@[appDelegate.videoController] animated:NO];
        }
        //  [mngAr showMessageToUser];
        
    }
    else if(idd==5)
    {
        [self dissmissmainView];
        Storage *vc2 = [[Storage alloc] initWithNibName:@"Storage" bundle:nil];
        [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
        //storage
    }
    
    else if(idd==8)
    {
        [self dissmissmainView];
        Job *vc2=[[Job alloc]initWithNibName:@"Job" bundle:nil];
        [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
        
    }
    
    else if(idd==6)
    {
        //Board
        [self dissmissmainView];
        MainBord *vc2 = [[MainBord alloc] init];
        [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
    }
    else if(idd==7)
    {
        //podcast
        [self dissmissmainView];
        Podcast *vc2=[[Podcast alloc]initWithNibName:@"Podcast" bundle:nil];
        [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
    }
    
    else if(idd==9)
    {
        //job
        [self dissmissmainView];
        //  [self dissmissmainView];
        UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Support *vc2=[mainStoryboard instantiateViewControllerWithIdentifier:@"Support"];
        [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
    }
    else if(idd==10)
    {
        iscallback=5;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[SavePrefrences sharedInstance].un forKey:@"un"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"logOut":@"":@"":dic1 :self];
        [[GIDSignIn sharedInstance] signOut];
        [[GIDSignIn sharedInstance] disconnect];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IS_LOGGED_IN"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"USERNAME"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"PASSWORD"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

-(void )addProfileimage:(NSArray *) profileAr
{
    //here profile editing
    profilear1=profileAr;
    
    NSMutableDictionary *bd=[SavePrefrences sharedInstance].colorDictionry;
    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,actionView.frame.size.height,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight-(actionView.frame.size.height))];
    mainView.backgroundColor=[bd valueForKey:@"bodycolor"];
    [vc1.view addSubview:mainView];
    
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,[SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    mainScrollView1.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[UIColor colorWithRed:172/255.0f  green:172/255.0f blue:172/255.0f alpha:0.0f];
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake([SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight);
    
    [mainView addSubview:mainScrollView1];
    
    
    imageview=[[UIView alloc] initWithFrame:CGRectMake(10, 60, mainScrollView1.frame.size.width-20, 100)];
    imageview.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[UIColor colorWithRed:70/255.0f green:130/255.0f  blue:180/255.0f alpha:1.0f];
    imageview.layer.cornerRadius=30;

    [mainScrollView1 addSubview:imageview];
    
    imggeter=[[UIImageView alloc]initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, 10, 100, 100)];
    imggeter.layer.backgroundColor=[[UIColor clearColor] CGColor];
    imggeter.layer.cornerRadius=50;
    imggeter.layer.borderWidth=1.0;
    imggeter.layer.masksToBounds = YES;
    imggeter.layer.borderColor=[[UIColor colorWithRed:217.0f/255.0f green:179.0f/255.0f blue:27.0f/255.0f alpha:1.0f]  CGColor];
    imggeter.layer.borderWidth=2.5;

    [mainScrollView1 addSubview:imggeter];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOption)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    imggeter.userInteractionEnabled = YES;
    [imggeter addGestureRecognizer:tapRecognizer];

    NSString *img=[[profileAr valueForKey:@"img"] objectAtIndex:0];
    videoResume=[[profileAr valueForKey:@"videoResume"] objectAtIndex:0];
    NSString * url=[mngAr concatUrl:img];
    
    NSLog(@"imag vw %lu",(unsigned long)url.length);
    if(url.length<12)
    {
        imggeter.image = [UIImage imageNamed:@"username.png"];
    }
    else
    {
         [imggeter sd_setImageWithURL:[NSURL URLWithString:url]];
        
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//        
//        if (imageData.length<=0)
//            imggeter.image = [UIImage imageNamed:@"username.png"];
//        else
//            imggeter.image = [UIImage imageWithData:imageData];
    }
    imggeter.userInteractionEnabled = YES;
    
     NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,  imggeter.frame.origin.y+imggeter.frame.size.height, mainScrollView1.frame.size.width, 22)];
    if([mngAr checkStringNull:[[profileAr valueForKey:@"fname"] objectAtIndex:0]])
    {
        NameLabel.text=[[profileAr valueForKey:@"fname"] objectAtIndex:0];
    }
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];//[UIColor whiteColor];
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [mainScrollView1 addSubview:NameLabel];
    
    //here line below name
    int w =self.view.frame.size.width/2;
    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(w/2+w/4, NameLabel.frame.size.height+NameLabel.frame.origin.y+3, w/2, 1.25)];
    lblLine.backgroundColor=[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    [mainScrollView1 addSubview:lblLine];

    
    UILabel *location=[[UILabel alloc]initWithFrame:CGRectMake(0,lblLine.frame.size.height+lblLine.frame.origin.y+3, self.view.frame.size.width, 22)];
    if([mngAr checkStringNull:[[profileAr valueForKey:@"city"]objectAtIndex:0]])
    {
        location.text=[[[[[[profileAr valueForKey:@"city"]objectAtIndex:0] stringByAppendingString:@","]stringByAppendingString:[[profileAr valueForKey:@"state"]objectAtIndex:0]]stringByAppendingString:@","]stringByAppendingString:[[profileAr valueForKey:@"country"]objectAtIndex:0]];
    }

    location.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
    location.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    location.textAlignment=NSTextAlignmentCenter;
    [mainScrollView1 addSubview:location];
    [self addButtons];
    
}

-(void) addButtons
{
    NSMutableArray *btnAr=[[NSMutableArray alloc]init];
    [btnAr addObject:@"Profile"];
    [btnAr addObject:@"Education"];
    [btnAr addObject:@"Employment"];
    [btnAr addObject:@"Certificate"];
    [btnAr addObject:@"Award"];
    [btnAr addObject:@"Video Resume"];
    
    NSMutableArray *coloAr=[[NSMutableArray alloc]init];
   /* NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
    
    [coloAr addObject:[cc valueForKey:@"Profcolor"]];
    [coloAr addObject:[cc valueForKey:@"Educolor"]];
    [coloAr addObject:[cc valueForKey:@"Emplcolor"]];
    [coloAr addObject:[cc valueForKey:@"Certcolor"]];
    [coloAr addObject:[cc valueForKey:@"Awardscolor"]];
    [coloAr addObject:[cc valueForKey:@"Videocolor"]];*/
    
    
    [coloAr addObject:[UIColor colorWithRed:112.0f/255.0f green:185.0f/255.0f blue:164.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:143.0f/255.0f green:151.0f/255.0f blue:93.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:189.0f/255.0f green:162.0f/255.0f blue:226.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:131.0f/255.0f green:168.0f/255.0f blue:210.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:233.0f/255.0f green:181.0f/255.0f blue:175.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f]];

    
    int lineviewY=imageview.frame.size.height+imageview.frame.origin.y+10;
    UIView *lineView1;
    for(int x=0;x<[btnAr count];x++)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,lineviewY, [SavePrefrences sharedInstance].screenWidth, 40)];
        lineView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        lineView.tag=x;
        [mainScrollView1 addSubview:lineView];
        
        UILabel *btnArrowRoght =[[UILabel alloc]initWithFrame:CGRectMake(0,2,[SavePrefrences sharedInstance].screenWidth,lineView.frame.size.height-5)];
        btnArrowRoght.backgroundColor=[UIColor colorWithRed:172/255.0f green:172/255.0f blue:172/255.0f alpha:0.0f];
        btnArrowRoght.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        btnArrowRoght.userInteractionEnabled=YES;
        btnArrowRoght.text=[btnAr objectAtIndex:x];
        NSMutableDictionary *txt=[SavePrefrences sharedInstance].colorDictionry;
        btnArrowRoght.textColor= [coloAr objectAtIndex:x];//[UIColor blackColor];
        btnArrowRoght.textAlignment=NSTextAlignmentCenter;
        [lineView addSubview:btnArrowRoght];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openProfile:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [lineView addGestureRecognizer:tapRecognizer];
        
        UIImageView *rightimgview = [[UIImageView alloc]initWithFrame:CGRectMake(btnArrowRoght.frame.size.width+5,20, 20, 20)];
        [rightimgview setImage:[UIImage imageNamed:@"arrow.png"]];
        rightimgview.userInteractionEnabled= YES;
       // [lineView addSubview:rightimgview];
        lineviewY= lineviewY+60;
        
        //here line
        int w =self.view.frame.size.width/2;
        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(w/2, btnArrowRoght.frame.size.height+btnArrowRoght.frame.origin.y+3, w, 1.25)];
        lblLine.backgroundColor=[coloAr objectAtIndex:x];//[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
        [lineView addSubview:lblLine];

    }
    
    int hsp=20;
    int div3=([SavePrefrences sharedInstance].screenWidth-30)/3;
    
    NSMutableArray *listar=[[NSMutableArray alloc]init];
    [listar addObject:@"resume_mail.png"];
    [listar addObject:@"resume_upload.png"];
    [listar addObject:@"resume_download.png"];
    
    for(int x=0;x<[listar count];x++)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(hsp,lineviewY+20, [SavePrefrences sharedInstance].screenWidth/3+30, 50)];
        lineView.backgroundColor=[UIColor clearColor];
        float wid=lineView.frame.size.width/2 -10;
        
        if (x==0) {
            UIImageView *rightimgview = [[UIImageView alloc]initWithFrame:CGRectMake(lineView.frame.size.width/2 -(wid/2),10,30, 25)];
            rightimgview.tag=x;
            [rightimgview setImage:[UIImage imageNamed:[listar objectAtIndex:x]]];
            rightimgview.userInteractionEnabled= YES;
            [mainScrollView1 addSubview:lineView];
            [lineView addSubview:rightimgview];
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(filUpload:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            [rightimgview addGestureRecognizer:tapRecognizer];

        }
        else
        {
            UIImageView *rightimgview = [[UIImageView alloc]initWithFrame:CGRectMake(lineView.frame.size.width/2 -(wid/2),5,30, 30)];
            rightimgview.tag=x;
            [rightimgview setImage:[UIImage imageNamed:[listar objectAtIndex:x]]];
            rightimgview.userInteractionEnabled= YES;
            [mainScrollView1 addSubview:lineView];
            [lineView addSubview:rightimgview];
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(filUpload:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            [rightimgview addGestureRecognizer:tapRecognizer];

        }
        
        hsp=hsp+div3;
    }
    
    lineviewY= lineviewY+10;
    mainScrollView1.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, lineView1.frame.size.height+lineviewY+70);
    
}

-(void)downloadResume:(NSString*)Path1
{
    
    webviewView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [vc1.view addSubview:webviewView];
    webviewView.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.6f];
    
    
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, webviewView.frame.size.width, webviewView.frame.size.height-100)];
    //[webView setDelegate:self];
    NSURL *url1 = [NSURL URLWithString:Path1];
    
    NSLog(@"url of resume===%@",url1);
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url1];
    [webView loadRequest:requestObj];
    webView.scalesPageToFit=YES;
    
    [webviewView addSubview:webView];
    
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(webviewView.frame.size.width/2-50, webView.frame.size.height+webView.frame.origin.y+30, 100, 40)];
    [save setTitle: @"Close" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor blackColor];
    save.layer.borderColor=[[UIColor clearColor] CGColor];
    save.layer.borderWidth=1;
    [save addTarget:self action:@selector(dissmissWebView:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [webviewView addSubview:save];
    
    
    
}

-(IBAction)dissmissWebView:(id)sender{
    [webviewView removeFromSuperview];
}


-(void) filUpload:(id)sender
{
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    int idd=(int)tapRecognizer.view.tag;
    
    if(idd==0)
    {
        NSLog(@"send email");
        [self sendEmail:vc1];
    }
    else if (idd==1)
    {
//        NSLog(@"upload");
//        [mngAr showMessageToUser];
        
       [self video];
    }
    else if (idd==2)
    {
        NSLog(@"download");
        NSString *upload= [[[SavePrefrences sharedInstance].skthand btkurl] stringByAppendingString:[NSString stringWithFormat:@"%@/",@"upload"]];
       NSString *rsume=[upload stringByAppendingString:[NSString stringWithFormat:@"%@/",[SavePrefrences sharedInstance].uid]];
        NSString *path=[rsume stringByAppendingString:[NSString stringWithFormat:@"%@/",@"Resume"]];
        NSString *pathis=[path stringByAppendingString:@"resume.pdf"];
        
        NSLog(@"path is %@",pathis);
       // https://proyolk.com/upload/515/Resume/resume.pdf
        //https://proyolk.com/upload/10/Resume/resume.pdf
        [self downloadResume:pathis];
        
        
        
//        NSString *upload= [[[SavePrefrences sharedInstance].skthand btkurl] stringByAppendingString:[NSString stringWithFormat:@"%@/",@"upload"]];
//        NSString *rsume=[upload stringByAppendingString:[NSString stringWithFormat:@"%@/",[SavePrefrences sharedInstance].uid]];
//        NSString *path=[rsume stringByAppendingString:[NSString stringWithFormat:@"%@/",@"Resume"]];
//        NSString *pathis=[path stringByAppendingString:@"resume.pdf"];
//        
//        NSLog(@"path is %@",pathis);
//        
//        
//        [self downloadResume:pathis];
    }
}




- (void)video {
   imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,      nil];
    [vc1 presentViewController:imagePicker animated:YES completion:nil];
    
//    [vc1 presentModalViewController:imagePicker animated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
   
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
                 NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
                 NSString *moviePath = [videoUrl path];
                 if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        
        
        
                     if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
                         UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
                     }
        
        
                     
                 }
                 [self uploadVideo:moviePath];
    }];
    // [self dismissViewControllerAnimated:YES completion:^{
//
   //  }];
   
   
    

    
   
}


-(void)uploadVideo:(NSString *)moviePath{
    
    NSData *videoData = [NSData dataWithContentsOfFile:moviePath];
    
    NSString *videoBuffer= [videoData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString *imgName = [self randomImagName];
    iscallback=100;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:videoBuffer forKey:@"buffer1"];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setObject:imgName forKey:@"pic"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"uploadVd" :@"" :@"no" :dic :self ];
    
    

}
-(NSString *) randomImagName
{
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
    for (int i=0; i<12; i++)
    {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    NSString *rnd=[randomString stringByAppendingString:@".mov"];
    
    return rnd;
}


-(void)sendEmail:(UIViewController*)Vc
{
//    [self MainView:Vc :@"Mail"];
//    
//    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
//    
//    scrollbar.frame=CGRectMake(20,NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, 200);
//    scrollbar.backgroundColor=[ff valueForKey:@"Videocolor"];
//    
//    
//    
//    UILabel *sendresume=[[UILabel alloc]initWithFrame:CGRectMake(30, 10,scrollbar.frame.size.width-20, 30)];
//    sendresume.text=@"Send Resume";
//    sendresume.textColor=[UIColor blackColor];
//    [scrollbar addSubview:sendresume];
//    
//    mail=[[UITextField alloc]initWithFrame:CGRectMake(20,sendresume.frame.size.height+sendresume.frame.origin.y+10,scrollbar.frame.size.width-40, 35)];
//    mail.backgroundColor=[UIColor whiteColor];
//    mail.layer.cornerRadius=5;
//    mail.clipsToBounds=YES;
//    mail.placeholder=@" Enter Email";
//    mail.delegate=self;
//    [scrollbar addSubview:mail];
//    
//    UIButton *submit = [[UIButton
//                         alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2-70,
//                                                        mail.frame.size.height+mail.frame.origin.y+10, scrollbar.frame.size.width/2-30,
//                                                        35)];
//    [submit setTitle: @"Submit" forState: UIControlStateNormal];
//    submit.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
//    [submit addTarget:self action:@selector(submitMail:)
//     forControlEvents:UIControlEventTouchUpInside];
//    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    submit.layer.cornerRadius=6;
//    submit.tag=0;
//    [scrollbar addSubview:submit];
//    
//    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width,
//                                     scrollbar.frame.size.height);
    
    
        
        
        NSMutableDictionary *edtprf=[SavePrefrences sharedInstance].colorDictionry;
        
        mainouterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
        mainouterView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
        mainouterView.layer.cornerRadius=10;
        [vc1.view addSubview:mainouterView];
        
        
        UIView *outerView = [[UIView alloc] initWithFrame:CGRectMake(10,([SavePrefrences sharedInstance].screenHeight/2)-100,mainouterView.frame.size.width-20,150)];
        outerView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        outerView.layer.cornerRadius=10;
        [mainouterView addSubview:outerView];
        
        
        UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,outerView.frame.size.width,150)];
        innerView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        innerView.layer.cornerRadius=10;
        [outerView addSubview:innerView];
        
        //233:243:253
        
        UILabel *titlab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, innerView.frame.size.width, 40)];
        titlab.text=@"Send E-mail";
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
        
        mail=[[UITextField alloc]initWithFrame:CGRectMake(10, titlab.frame.size.height+titlab.frame.origin.y+15, innerView.frame.size.width-25, 30)];
       // mail.placeholder=@"Enter Email";
        UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        mail.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Enter Email" attributes:@{NSForegroundColorAttributeName: color}];

        mail.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
        mail.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        mail.leftView = paddingView2;
        mail.leftViewMode = UITextFieldViewModeAlways;

        mail.layer.cornerRadius=4;
        mail.delegate=self;
        [mail setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        [innerView addSubview:mail];
        
        UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35, mail.frame.size.height+mail.frame.origin.y+10, innerView.frame.size.width/2-40, 35)];
        [save setTitle: @"Send" forState: UIControlStateNormal];
        save.backgroundColor=[edtprf valueForKey:@"Yellowbtncolor"];
        [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        [save addTarget:self action:@selector(submitMail:) forControlEvents:UIControlEventTouchUpInside];
        [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
      //  save.layer.cornerRadius=5;
        [innerView addSubview:save];
        
        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+5, mail.frame.size.height+mail.frame.origin.y+10, innerView.frame.size.width/2-40, 35)];
        [cancel setTitle: @"Discard" forState: UIControlStateNormal];
        cancel.backgroundColor=[edtprf valueForKey:@"Yellowbtncolor"];
        [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        [cancel addTarget:self action:@selector(discard1:) forControlEvents:UIControlEventTouchUpInside];
        [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
       // cancel.layer.cornerRadius=5;
        [innerView addSubview:cancel];
        
    
}

-(IBAction)discard1:(id)sender
{
    [mainouterView removeFromSuperview];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
    
}
-(IBAction)submitMail:(id)sender
{
   
    
    if([allValidVC NSStringIsValidEmail:mail.text])
    {
        [self.view endEditing:YES];
          [mainouterView removeFromSuperview];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:mail.text forKey:@"to"];
        [dic setObject:@"7" forKey:@"tp"];
        
        iscallback=17;
       
        [[SavePrefrences sharedInstance].skthand emitData:@"ProyolkMails" :@"getEmailData" :@"" :@"":dic :self];
        
       
    }
}

-(void) openProfile:(id)sender
{
    UITapGestureRecognizer *ges=(UITapGestureRecognizer*) sender;
    int idd=(int)[ges.view tag];
    if(idd==0)
    {
        
        NSLog(@"Profile is clicked");
        
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"0";
        [[vc1 navigationController ]pushViewController:vc2 animated:YES];
        
    }
    if(idd==1)
    {
        
        NSLog(@"Profile is clicked");
        
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"1";
        [[vc1 navigationController]pushViewController:vc2 animated:YES];
        
    }if(idd==2)
    {
        
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"2";
        [[vc1 navigationController]pushViewController:vc2 animated:YES];
        
    }
    if(idd==3)
    {
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"3";
        [[vc1 navigationController]pushViewController:vc2 animated:YES];
        
    }
    if(idd==4)
    {
        
        NSLog(@"Profile is clicked");
        
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"4";
        [[vc1 navigationController]pushViewController:vc2 animated:YES];
        
    }
    
    else if(idd==5)
    {
        [self playVideoResunme];
    }
    
}
-(void)playVideoResunme
{
    
    
    
    [videomainview removeFromSuperview];
    if(player!=nil)
      [player pause];
    
    videomainview = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    videomainview.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];
    [vc1.view addSubview:videomainview];
    
    UIView *innerVideopop = [[UIView alloc] initWithFrame:CGRectMake(20,100,[SavePrefrences sharedInstance].screenWidth-40,[SavePrefrences sharedInstance].screenHeight-350)];
    innerVideopop.backgroundColor=[UIColor blackColor];
    [videomainview addSubview:innerVideopop];
    
    
    
    
   if(videoResume==nil||videoResume==NULL||[videoResume isEqual:[NSNull null]]||videoResume == (id)[NSNull null])
   {
     [videomainview removeFromSuperview];
       
     UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Video Resume Not Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//       UIImageView *imgMultiples1 =[[UIImageView
//                                     alloc]initWithFrame:CGRectMake(0,0, alert.frame.size.width,
//                                                                    alert.frame.size.height)]; imgMultiples1.image = [UIImage imageNamed:@"noimg.png"];
//       [alert addSubview:imgMultiples1];
       [alert show];
   }
   else
   {
      // https://proyolk.com/upload/515/videoResume/CrazyFrog-AxelF.3gp
       NSString  *url=@"https://www.proyolk.com";
       NSString *toplay=[url stringByAppendingString:videoResume];
        NSLog(@"fffffff=========%@",toplay);
  
    
    
    NSURL *videoURL = [NSURL URLWithString:toplay];
    player = [AVPlayer playerWithURL:videoURL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = CGRectMake(0, 10, innerVideopop.frame.size.width, innerVideopop.frame.size.height);
    [innerVideopop.layer addSublayer:playerLayer];
    [player play];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(videomainview.frame.size.width/2-50, innerVideopop.frame.size.height+innerVideopop.frame.origin.y+50, 100, 40)];
    [save setTitle: @"Dismiss" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor blackColor];
    save.layer.borderColor=[[UIColor redColor] CGColor];
    save.layer.borderWidth=1;
    [save addTarget:self action:@selector(dissmissVideo:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [videomainview addSubview:save];

    
    
    
//    //AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
//    
//    //videoURL = [NSURL URLWithString:@"http://techslides.com/demos/sample-videos/small.mp4"];
//    
//    videoURL = [NSURL URLWithString:toplay];
//    
//    
//    AVURLAsset *asset = [AVURLAsset assetWithURL: videoURL];
//    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
//    
//    AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
//    
//    playerViewController.player = player;
//    
//    [playerViewController.view setFrame:CGRectMake(0, 10, innerVideopop.frame.size.width, innerVideopop.frame.size.height)];
//    
//    playerViewController.showsPlaybackControls = YES;
//    
//    [innerVideopop addSubview:playerViewController.view];
//    
//    
    [player play];
   }
    
    //NSLog(@"urls====%@",videoURL);
}





-(void)chooseOption
{

    ProfileView *vc2=[[ProfileView alloc]init];
    vc2.istab=@"0";
    [[vc1 navigationController ]pushViewController:vc2 animated:YES];
    
}

-(void) dismiss
{
    [mainView removeFromSuperview];
}

-(IBAction)dismiss1:(id)sender
{

    [mainView removeFromSuperview];
}
-(void) dissmissmainView
{
    [mainView removeFromSuperview];
}

-(IBAction)dissmissVideo:(id)sender
{
    [player pause];
    [videomainview removeFromSuperview];
}

-(void) reteriveFriends
{
    iscallback=3;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"genData":@"":@"":dic1 :self];
    
}

-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    
    NSLog(@"callback is====%d",iscallback);
    if(iscallback==6)
    {
//        NSLog(@"profile checker metad==%@",meta);
//        NSLog(@"profile checker datad==%@",data);
        
        
        profilear1=data;
        [self addProfileimage:data];
    }
    else if (iscallback==3)
    {
        
//        NSLog(@"profile checker 3==%@",meta);
//        NSLog(@"profile checker dat3==%@",data);
        
        //NSArray *arfr=[meta valueForKey:@"fr"];
      //  nwfr=[[NSMutableArray alloc]init];
        //cbfr=[[NSMutableArray alloc]init];
        
        nwfr=[meta valueForKey:@"netFr"];
        cbfr=[meta valueForKey:@"cabFr"];
        
//        for(int x=0;x<[arfr count];x++)
//        {
//            NSArray * d=[arfr objectAtIndex:x] ;
//            NSString *ty = [d valueForKey:@"type"];
//            NSLog(@"user type===%@",ty);
//            
//            int dd;
//            if(ty==nil||ty==NULL||[ty isEqual:[NSNull null]]||ty == (id)[NSNull null])
//            {
//                dd=2;
//            }
//            else
//            {
//                dd=[ty intValue];
//            }
//            if(dd ==1)
//            {
//                [nwfr addObject:[arfr objectAtIndex:x]];
//                
//            }
//            else
//            {
//                [cbfr addObject:[arfr objectAtIndex:x]];
//            }
//        }
        [self showRightDrawer];
    }
    
    else if (iscallback==5)//logout
    {
        
        NSLog(@"helloooooo");
        
        NSArray *viewsToRemove = [self.view subviews];
        for (UIView *v in viewsToRemove)
        {
            [v removeFromSuperview];
        }
        FBSDKLoginManager *logout=[[FBSDKLoginManager alloc]init];
        [logout logOut];
        [FBSDKAccessToken setCurrentAccessToken:nil];
        [FBSDKProfile setCurrentProfile:nil];

        
        [SavePrefrences sharedInstance].uid=@"";
        [SavePrefrences sharedInstance].un=@"";
        [SavePrefrences sharedInstance].at=@"";
        [SavePrefrences sharedInstance].sid=@"";
        [SavePrefrences sharedInstance].fn=@"";
        [SavePrefrences sharedInstance].lname=@"";
        [SavePrefrences sharedInstance].token=@"";
        [SavePrefrences sharedInstance].roleid=@"";
        
           [[SavePrefrences sharedInstance].cartAr removeAllObjects];
           [SavePrefrences sharedInstance].indAr=nil;
           [[SavePrefrences sharedInstance].notificationDic removeAllObjects];
           [[SavePrefrences sharedInstance].chatWindowAr removeAllObjects];
           [[SavePrefrences sharedInstance].isAlViedDic removeAllObjects];
           [[SavePrefrences sharedInstance].notiYolkingAr removeAllObjects];
           [[SavePrefrences sharedInstance].notiWithoutADR removeAllObjects];
           [[SavePrefrences sharedInstance].allNotifictionDic removeAllObjects];
           [[SavePrefrences sharedInstance].chatRemovekey removeAllObjects];
           [[SavePrefrences sharedInstance].messageremovekey removeAllObjects];
           [SavePrefrences sharedInstance].yokingcount=[NSString stringWithFormat:@"%d",0];
        
        
        UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LandingViewController* vc2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"LANDING_VIEW"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
         [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
        
    }
    else if(iscallback==7)//reterivecabFrnd
    {
       // cabntAr=data;
        
        NSLog(@"data count========7===%@",data);
        
        if([data count]>0)
        {
        for(int x=0;x<[data count];x++)
        {
            [cabntAr addObject:[data objectAtIndex:x]];
        }
             [self CabinetFriends];
             [cabinetTableview setContentOffset:CGPointMake(0,scrollpostion)];
        }
        else
        {
        
            UIAlertView   *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alert show];
        }
    }
    else if (iscallback==8)// reteriveNetFrnd
    {
      
        if([data count]>0)
        {
        for(int x=0;x<[data count];x++)
        {
            [NetAr addObject:[data objectAtIndex:x]];
        }
            
            NSLog(@"Scroll postion===%f",scrollpostion);
            
              [self NetworkFriends];
              [netTableView setContentOffset:CGPointMake(0,scrollpostion)];
        }
        else
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        
        
       
    }
    else if (iscallback==9)//community search
    {
        if(CommAr==nil)
        {
            CommAr=[[NSMutableArray alloc]init];
        }
        if([data count]>0)
        {
            for(int x=0;x<[data count];x++)
            {
                [CommAr addObject:[data objectAtIndex:x]];
            }
             [commTableView reloadData];
            NSLog(@"Scroll postion==%f",scrollpostion);
            
             [commTableView setContentOffset:CGPointMake(0,scrollpostion)];
        }
        else
        {
            
            UIAlertView   *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        
        
//        CommAr=data;
       // [self CommunityFriends];
    }
    else if (iscallback==10)//cabnte search
    {
//         cabntAr=data;
//         [cbntTableView reloadData];
        
        
        if([data count]>0)
        {
            for(int x=0;x<[data count];x++)
            {
                [cabntAr addObject:[data objectAtIndex:x]];
            }
              [cbntTableView reloadData];
              [cabinetTableview setContentOffset:CGPointMake(0,scrollpostion)];
        }
        else
        {
            
            UIAlertView   *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alert show];
            
        }
        
        
       
    }
    else if (iscallback==11)//network search
      {
//        NetAr=data;
//        [netTableView reloadData];
        
        if([data count]>0)
        {
            for(int x=0;x<[data count];x++)
            {
                [NetAr addObject:[data objectAtIndex:x]];
            }
            
            
            [netTableView reloadData];
            [netTableView setContentOffset:CGPointMake(0,scrollpostion)];
        }
        else
        {
            
            UIAlertView   *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        
        
    }
    else if (iscallback==12)
    {

    }
    else if (iscallback==13)
    {
        
        cmpop=[[CommonProfile alloc]init];
        cmpop.flag = 101;
        [ cmpop addProfileimage:data :[friendid intValue] :vc1] ;
    }
    else if (iscallback==101){
    
        cmpop=[[CommonProfile alloc]init];
        cmpop.flag = 101;
        //[self.navigationController pushViewController:cmpop animated:YES];
        [ cmpop addProfileimage:data :[friendid intValue] :vc1] ;
    }
    
    else if (iscallback==14)
    {
        // network to cabinet
       [cbfr addObject:[nwfr objectAtIndex:index]];
        [cabinetTableview reloadData];
        
        [nwfr removeObjectAtIndex:index];
       
        [righttableView reloadData];
        
        
    }
    else if (iscallback==15)
    {
        // cabinet to network
        [nwfr addObject:[cbfr objectAtIndex:index]];
        [righttableView reloadData];
        
        [cbfr removeObjectAtIndex:index];
        [cabinetTableview reloadData];
    }
    else if(iscallback==16)
    {
        
        NSLog(@"scroll postion===%f",scrollpostion);
        
        if(CommAr==nil)
        {
            CommAr=[[NSMutableArray alloc]init];
        }
        
        if([data count]>0)
        {
        for(int x=0;x<[data count];x++)
        {
            [CommAr addObject:[data objectAtIndex:x]];
        }
          
        }
        else
        {
            
            UIAlertView   *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        
        [self CommunityFriends];
         [commTableView setContentOffset:CGPointMake(0,scrollpostion)];
    }
    else if(iscallback==17)
    {
        [mainouterView removeFromSuperview];
        
        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Your Resume Has been Sent" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    else if(iscallback == 100){
        UIAlertView   *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Video Resume uploaded Sucessfully." delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alert show];
    }
    
    
}

-(void) callMethod:(NSArray *)meta
{
}




-(void)openNetpop:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    
    net=0;
    index=(int)tg.view.tag;
    
    
    
    usrname=[[nwfr objectAtIndex:(int)tg.view.tag]valueForKey:@"uname"];
    fname=[[nwfr objectAtIndex:(int)tg.view.tag]valueForKey:@"fname"];
    lname=[[nwfr objectAtIndex:(int)tg.view.tag]valueForKey:@"lname"];
    friendid=[[nwfr objectAtIndex:(int)tg.view.tag]valueForKey:@"u_id"];
    image=[[nwfr objectAtIndex:(int)tg.view.tag]valueForKey:@"img"];
    image=[mngAr concatUrl:image];
    [self chatViewpop:image];
}
-(void)opencabinetpop:(id)sender
{
    net=1;
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    index=(int)tg.view.tag;
    
    usrname=[[cbfr objectAtIndex:(int)tg.view.tag]valueForKey:@"uname"];
    fname=[[cbfr objectAtIndex:(int)tg.view.tag]valueForKey:@"fname"];
    lname=[[cbfr objectAtIndex:(int)tg.view.tag]valueForKey:@"lname"];
    friendid=[[cbfr objectAtIndex:(int)tg.view.tag]valueForKey:@"u_id"];
    image=[[cbfr objectAtIndex:(int)tg.view.tag]valueForKey:@"img"];
    image=[mngAr concatUrl:image];
    [self chatViewpop:image];
    
}

-(void)chatViewpop:(NSString*)img
{
    [self MainViewwithouttitle:vc1];
    if(net==0)
    {
        frId=[[nwfr objectAtIndex:index] valueForKey:@"u_id"];
    }
    else if(net==1)
    {
//         NSLog(@"cab net ar===%@",cbfr);
         frId=[[cbfr objectAtIndex:index] valueForKey:@"u_id"];
    }
    prMainView.backgroundColor=[UIColor colorWithRed:0.0f/0.0f green:0.0f/0.0f blue:0.0f/0.0f alpha:.5f];
    headerView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    
    UIView *chatView=[[UIView alloc]initWithFrame:CGRectMake(25, [SavePrefrences sharedInstance].screenHeight/2-50, [SavePrefrences sharedInstance].screenWidth-50, 120)];
    chatView.backgroundColor=[UIColor colorWithRed:233.0f/255.0f green:243.0f/255.0f blue:253.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
    [prMainView addSubview:chatView];
    
    UIImageView *leftdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(5, 14, 90, 94)];
    leftdrawr.image = [UIImage imageNamed:@"username.png"];
    leftdrawr.backgroundColor=[UIColor clearColor];
    leftdrawr.layer.cornerRadius=45;
    leftdrawr.clipsToBounds=YES;

    [chatView addSubview:leftdrawr];
    NSLog(@"Circle Images Chnages===========%@",image);
    if(image.length<12)
    {
        leftdrawr.image = [UIImage imageNamed:image];
    }
    else
    {
         [leftdrawr sd_setImageWithURL:[NSURL URLWithString:image]];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
//        if (imageData.length<=0)
//            leftdrawr.image = [UIImage imageNamed:@"username.png"];
//        else
//            leftdrawr.image = [UIImage imageWithData:imageData];
    }
    leftdrawr.userInteractionEnabled =YES;
    
    UITapGestureRecognizer *addleftges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openfriendprofile)];
    [addleftges setNumberOfTouchesRequired:1];
    leftdrawr.userInteractionEnabled = YES;
    [leftdrawr addGestureRecognizer:addleftges];
    //233:243:253
    UILabel *username=[[UILabel alloc]initWithFrame:CGRectMake(leftdrawr.frame.size.width+leftdrawr.frame.origin.x+20, 5,chatView.frame.size.width, 25)];
    username.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    username.text=usrname;
    [username setFont:[UIFont systemFontOfSize:16]];
    [chatView addSubview:username];
    
    UILabel *fn=[[UILabel alloc]initWithFrame:CGRectMake(leftdrawr.frame.size.width+leftdrawr.frame.origin.x+20, username.frame.size.height+username.frame.origin.y+5, chatView.frame.size.width/2, 25)];
    fn.text=[[fname stringByAppendingString:@" "]stringByAppendingString:lname];
    fn.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];//[UIColor whiteColor];
    [fn setFont:[UIFont systemFontOfSize:14]];
    [chatView addSubview:fn];
    
    UIImageView *chat =[[UIImageView alloc]initWithFrame:CGRectMake(leftdrawr.frame.size.width+leftdrawr.frame.origin.x+15, fn.frame.size.height+fn.frame.origin.y+8, 30, 30)];
    chat.image = [UIImage imageNamed:@"chatNew.png"];
    chat.backgroundColor=[UIColor clearColor];
    [chatView addSubview:chat];
    
    
    UITapGestureRecognizer *chatges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goForChat)];
    [chatges setNumberOfTouchesRequired:1];
    chat.userInteractionEnabled = YES;
    [chat addGestureRecognizer:chatges];
    
    
    UIImageView *video =[[UIImageView alloc]initWithFrame:CGRectMake(chat.frame.size.width+chat.frame.origin.x+15, fn.frame.size.height+fn.frame.origin.y+5, 35, 32)];
    //
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.callOngoing){ video.image = [UIImage imageNamed:@"addToConference"];
    }else video.image = [UIImage imageNamed:@"chatvideoNew.png"];
    video.backgroundColor=[UIColor clearColor];
    [chatView addSubview:video];
    
    UITapGestureRecognizer *videoges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goForVideo)];
    [videoges setNumberOfTouchesRequired:1];
    video.userInteractionEnabled = YES;
    [video addGestureRecognizer:videoges];
    
    UIImageView *move =[[UIImageView alloc]initWithFrame:CGRectMake(video.frame.size.width+video.frame.origin.x+15, fn.frame.size.height+fn.frame.origin.y+10, 30, 25)];
    move.image = [UIImage imageNamed:@"refresNew.png"];
    move.backgroundColor=[UIColor clearColor];
    [chatView addSubview:move];
    
    UITapGestureRecognizer *moveges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveFriend:)];
    [moveges setNumberOfTouchesRequired:1];
    move.userInteractionEnabled = YES;
    [move addGestureRecognizer:moveges];
    
}

-(void)goForChat{
    openChat *opp=[[openChat alloc]init];
    [[SavePrefrences sharedInstance].chatWindowAr addObject:opp];
    NSLog(@"frid=====%@",frId);
    
    [SavePrefrences sharedInstance].chatId=frId;
    [opp openchat:vc1 withImage:nil];
}

- (void)goForVideo{
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"strTag"] isEqualToString:@"4"]) {
        NotificationHandler* nobj=[[NotificationHandler alloc]init];
        [nobj initiateVideoCall:[NSString stringWithFormat:@"%@", frId]];
    }else{
        id<CallTo_Parent> cb= vc1;
        
        [cb callMethod:frId];

    }
    
    [self dissmisspop];
    [self dismiss];
    
}

-(void)openfriendprofile:(NSString *)strFriendID
{
    
    [self dissmisspop];
    [self dissmissmainView];
    iscallback=101;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:strFriendID forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile":@"showProfile" :@"":@"":dic1 :self];
    
    
}

-(void)openfriendprofile
{
    
    [self dissmisspop];
      [self dissmissmainView];
    iscallback=13;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:friendid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile":@"showProfile" :@"":@"":dic1 :self];
    
    
}
-(void)moveFriend:(id)sender
{
    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to move ? " delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alrt show];
    [self alertView:alrt clickedButtonAtIndex:2];
    
    
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self dissmisspop];
      NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        
        if(net==0)
        {
            iscallback=14;
 
            
            [dic setValue:friendid forKey:@"id"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"chngeType" :@"" :@"" :dic :self];
        }
        if(net==1)
        {
            iscallback=15;
            
            [dic setValue:friendid forKey:@"id"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"chngeType" :@"" :@"" :dic :self];
        }

        
    }
        else if(buttonIndex==0)
        {
            NSLog(@"cancel");
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
            
        }
    }

@end



