



#import "MainBord.h"
#import "SavePrefrences.h"
#import "AllValidationsViewController.h"
#import "BoardPopUp.h"
#import "Podcast.h"
#import "MainController.h"
#import "LeftRightDrawer.h"
#import "ManageArray.h"
#import "CommonProfile.h"




@interface MainBord ()
{
    int selectedtab ;
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIView *actionView,*main,*middle_label,*option,*pop_up,*prMainView,*headerView;
    UIViewController *vc1;
    UITextView *My_Board,*Shared_Board,*Community;
    NSMutableArray *popUpAr;
    UITextField *Title,*Grade,*Command_On,*Command_By,*Posted_On,*Board_Posted_By;
    AllValidationsViewController *av;
    UILabel *NameLabel,*My_board_bar1,*My_board_bar2,*Shared_Board_bar1,*Shared_Board_bar2,*My_community_bar1,*My_community_bar2,*notification_bar1,*notification_bar2;
    BoardPopUp *bpop;
    LeftRightDrawer *drawer;
    ManageArray * mngAr;
    int iscallback,frienduid, b_id,chk, chkBoard,limit,showSharedpop,showCommpop,shomainpop;
    float scrollPostion;
    UITextField *search_lbl, *search1,*search;
    MainController *viewcnt;
    NSMutableArray *BrdAr;
    NSMutableDictionary *lineLabAr,*showMessageAr,*declineAr;
    NSArray *bAr,*keyAr;
    NSMutableArray *myBordAr,*sharedAr,*commAr;
    NSString *BrdId;
    CommonProfile *cmpop;
    NSString * noti_id;
}
@end



@implementation MainBord
@synthesize myBoardtablevw,sharedboardTableVw,commTableView,mynotification;
- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedtab = 1;
    mngAr=[[ManageArray alloc]init];
    drawer=[[LeftRightDrawer alloc]init];
    cmpop=[[CommonProfile alloc]init];
    
    av=[[AllValidationsViewController alloc]init];
    screenHeight= [SavePrefrences sharedInstance].screenHeight;
    screenWidth= [SavePrefrences sharedInstance].screenWidth;
    naviHght= [SavePrefrences sharedInstance].naviHght;
    naviWidth= [SavePrefrences sharedInstance].naviWidth;
    stbarHght= [SavePrefrences sharedInstance].stbarHght;
    
    bpop=[[BoardPopUp alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    [self retrieveNotify];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingBoardRequest:) name:@"BOARD_REQUEST" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBoardList:) name:@"BOARD_SAVED" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortBoardsList:) name:@"BOARD_SORT_CHANGE" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BOARD_REQUEST" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BOARD_SAVED" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BOARD_SORT_CHANGE" object:nil];
}

- (void)incomingBoardRequest:(NSNotification*)notification{
    [self getYokingData];
}

- (void)refreshBoardList:(NSNotification*)notification{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self retiveMyBoard];
    });
}

- (void)sortBoardsList:(NSNotification*)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(selectedtab == 1){
            if (search_lbl.text.length) {
                [self search];
            }else {
                [myBordAr removeAllObjects];
                [self retiveMyBoard];
            }
        }else if (selectedtab == 2){
            if (search_lbl.text.length) {
                [self sharedSimpleSearch];
            }else [self retrieveSharedBoard];
        }else{
            if (search_lbl.text.length) {
                [self CommunitySearch];
            }else [self retrieveCommunityBoard];
            
        }
    });
}

#pragma mark HeaderView Setup
-(UIView *) MainViewwithouttitle:(UIViewController *)Vc
{
    av=[[AllValidationsViewController alloc]init];
    
    NSLog(@"pop ar count in mainview2 %lu",[popUpAr count]);
    
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];;
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 56)];
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [prMainView addSubview:headerView];
    
    return prMainView;
}

- (NSString*)getSortKey{
    NSString* sortKey = [[NSUserDefaults standardUserDefaults] valueForKey:@"BOARD_SORT_KEY"];
    if (!sortKey.length) sortKey = @"1";
    NSLog(@"TEH SORET KEY OS **** %@", sortKey);
    return sortKey;
}

-(void) retiveMyBoard{
    iscallback=0;
    selectedtab = 1;
    NSLog(@"limiee====%d",limit);
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [dic setValue:[self getSortKey] forKey:@"val"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getBoard" :@"":@"":dic :self];
    
}

-(void) retrieveSharedBoard
{
    scrollPostion=0;
    limit=0;
    sharedAr=[[NSMutableArray alloc]init];
    [self reteriveSharedBoard1];
    
}
-(void) reteriveSharedBoard1
{
    iscallback=1;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [dic setObject:[self getSortKey] forKey:@"val"];
    [[SavePrefrences sharedInstance].skthand emitData:@"SharedBoard" :@"getSharedBoard" :@"":@"":dic :self];
}



-(void)retrieveCommunityBoard
{
    limit=0;
    scrollPostion=0;
    commAr=[[NSMutableArray alloc]init];
    [self reteriveCommunityBoard1];
    
}

-(void)reteriveCommunityBoard1
{
    iscallback=2;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [dic setObject:[self getSortKey] forKey:@"val"];
    [[SavePrefrences sharedInstance].skthand emitData:@"ComnBoard" :@"getAllBoard" :@"":@"":dic :self];
}


-(void)customizeActionBar:(UIViewController*)Vc
{
    [drawer initArs:self];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    [self MainViewwithouttitle:vc1];
    
    main=[[UIView alloc]initWithFrame:CGRectMake(0,70, screenWidth, screenHeight)];
    main.backgroundColor=[ff valueForKey:@"backcolor"];
    [self.view addSubview:main];
    if([BrdAr count]>0){
        [self setTabBar];
    }else{
        [self TabbarWithoutNotification];
    }
}

#pragma mark Tab Setup
//tabNoti [UIColor colorWithRed:130.0/255.0 green:197.0/255.0 blue:246.0/255.0 alpha:1];
//tab1 [UIColor colorWithRed:52.0/255.0 green:127.0/255.0 blue:103.0/255.0 alpha:1];
//tab2 [UIColor colorWithRed:108.0/255.0 green:114.0/255.0 blue:41.0/255.0 alpha:1];
//tab3 [UIColor colorWithRed:189.0/255.0 green:164.0/255.0 blue:226.0/255.0 alpha:1];

-(void)setTabBar
{
    option=[[UIView alloc]initWithFrame:CGRectMake(0,0, screenWidth, 45)];
    option.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:252.0f/255 alpha:1.0];
    [main addSubview:option];
    
    NSMutableDictionary *bc=[SavePrefrences sharedInstance].colorDictionry;
    
    
    
    UITextView *Notification=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, screenWidth/4 +0.4, 40)];
    Notification.text=@"Notification";
    Notification.scrollEnabled=NO;
    Notification.editable = NO;
    
    Notification.textAlignment=NSTextAlignmentCenter;
    [Notification setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Notification.backgroundColor=[UIColor clearColor];;
    Notification.textColor=[UIColor colorWithRed:130.0/255.0 green:197.0/255.0 blue:246.0/255.0 alpha:1];
    [option addSubview:Notification];
    
    notification_bar1=[[UILabel alloc]initWithFrame:CGRectMake(0,Notification.frame.size.height+Notification.frame.origin.y, screenWidth/4, 5)];
    notification_bar1.backgroundColor=[UIColor clearColor];
    [option addSubview:notification_bar1];
    
    notification_bar2=[[UILabel alloc]initWithFrame:CGRectMake(0,Notification.frame.size.height+Notification.frame.origin.y, screenWidth/4, 5)];
    notification_bar2.backgroundColor=[UIColor colorWithRed:130.0/255.0 green:197.0/255.0 blue:246.0/255.0 alpha:1];
    notification_bar2.hidden=false;
    [option addSubview:notification_bar2];
    
    UILabel *line1=[[UILabel alloc]initWithFrame:CGRectMake(0,Notification.frame.size.height+Notification.frame.origin.y+3, screenWidth/4, 2)];
    line1.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [option addSubview:line1];
    
    UITapGestureRecognizer *notificationReg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(NotificationView)];
    [notificationReg setNumberOfTouchesRequired:1];
    [notificationReg setDelegate:self];
    Notification.userInteractionEnabled = YES;
    Notification.tag=0;
    [Notification addGestureRecognizer:notificationReg];
    
    
    My_Board=[[UITextView alloc]initWithFrame:CGRectMake(Notification.frame.size.width+Notification.frame.origin.x,0, screenWidth/4, 40)];
    My_Board.text=@"My Board";
    // My_Board.userInteractionEnabled=NO;
    My_Board.scrollEnabled=NO;
    My_Board.editable = NO;
    
    My_Board.textAlignment=NSTextAlignmentCenter;
    [My_Board setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    My_Board.backgroundColor=[UIColor clearColor];//[bc valueForKey:@"Boardcolor"];
    My_Board.textColor=[UIColor colorWithRed:52.0/255.0 green:127.0/255.0 blue:103.0/255.0 alpha:1];//[bc valueForKey:@"Videocolor"];
    [option addSubview:My_Board];
    
    My_board_bar1=[[UILabel alloc]initWithFrame:CGRectMake(notification_bar1.frame.size.width+notification_bar1.frame.origin.x,My_Board.frame.size.height+My_Board.frame.origin.y,screenWidth/4 +0.4,5)];
    My_board_bar1.backgroundColor=[bc valueForKey:@"backcolor"];
    [option addSubview:My_board_bar1];
    
    My_board_bar2=[[UILabel alloc]initWithFrame:CGRectMake(notification_bar1.frame.size.width+notification_bar1.frame.origin.x,My_Board.frame.size.height+My_Board.frame.origin.y,screenWidth/4 +0.4, 5)];
    My_board_bar2.backgroundColor=[UIColor colorWithRed:52.0/255.0 green:127.0/255.0 blue:103.0/255.0 alpha:1];
    [option addSubview:My_board_bar2];
    My_board_bar2.hidden=true;
    
    UILabel *linelabel=[[UILabel alloc]initWithFrame:CGRectMake(notification_bar1.frame.size.width+notification_bar1.frame.origin.x,My_Board.frame.size.height+My_Board.frame.origin.y+3,screenWidth/4 +0.4, 2)];
    linelabel.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [option addSubview:linelabel];
    
    
    UITapGestureRecognizer *Myboardreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MyboardView)];
    [Myboardreg setNumberOfTouchesRequired:1];
    [Myboardreg setDelegate:self];
    My_Board.userInteractionEnabled = YES;
    [My_Board addGestureRecognizer:Myboardreg];
    
    Shared_Board=[[UITextView alloc]initWithFrame:CGRectMake(My_Board.frame.size.width+My_Board.frame.origin.x, 0, screenWidth/4, 40)];
    // Shared_Board.userInteractionEnabled=NO;
    Shared_Board.scrollEnabled=NO;
    Shared_Board.editable = NO;
    
    Shared_Board.text=@"Shared Board";
    Shared_Board.textAlignment=NSTextAlignmentCenter;
    [Shared_Board setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Shared_Board.backgroundColor=[UIColor clearColor];;
    Shared_Board.textColor=[UIColor colorWithRed:108.0/255.0 green:114.0/255.0 blue:41.0/255.0 alpha:1];//[bc valueForKey:@"Videocolor"];
    [option addSubview:Shared_Board];
    
    Shared_Board_bar1=[[UILabel alloc]initWithFrame:CGRectMake(My_board_bar1.frame.size.width+My_board_bar1.frame.origin.x,Shared_Board.frame.size.height+Shared_Board.frame.origin.y,screenWidth/4 +0.4,5)];
    Shared_Board_bar1.backgroundColor=[bc valueForKey:@"backcolor"];
    [option addSubview:Shared_Board_bar1];
    
    Shared_Board_bar2=[[UILabel alloc]initWithFrame:CGRectMake(My_board_bar1.frame.size.width+My_board_bar1.frame.origin.x,Shared_Board.frame.size.height+Shared_Board.frame.origin.y,screenWidth/4 +0.4,5)];
    Shared_Board_bar2.backgroundColor=[UIColor colorWithRed:108.0/255.0 green:114.0/255.0 blue:41.0/255.0 alpha:1];
    Shared_Board_bar2.hidden=true;
    [option addSubview:Shared_Board_bar2];
    
    UILabel *linelabel1=[[UILabel alloc]initWithFrame:CGRectMake(My_board_bar1.frame.size.width+My_board_bar1.frame.origin.x,Shared_Board.frame.size.height+Shared_Board.frame.origin.y+3,screenWidth/4 +0.4,2)];
    linelabel1.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [option addSubview:linelabel1];
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SharedBoardView)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    Shared_Board.userInteractionEnabled=YES;
    [Shared_Board addGestureRecognizer:sworkingreg];
    
    Community=[[UITextView alloc]initWithFrame:CGRectMake(Shared_Board.frame.size.width+Shared_Board.frame.origin.x,0,screenWidth/4, 40)];
    Community.userInteractionEnabled=NO;
    // Community.scrollEnabled=NO;
    Community.editable = NO;
    
    Community.text=@"Community Board";
    Community.textAlignment=NSTextAlignmentCenter;
    [Community setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    Community.backgroundColor=[UIColor clearColor];;
    Community.textColor=[UIColor colorWithRed:189.0/255.0 green:164.0/255.0 blue:226.0/255.0 alpha:1];//[bc valueForKey:@"Videocolor"];
    [option addSubview:Community];
    
    My_community_bar1=[[UILabel alloc]initWithFrame:CGRectMake(Shared_Board_bar1.frame.size.width+Shared_Board_bar1.frame.origin.x,Community.frame.size.height+Community.frame.origin.y,screenWidth/4, 5)];
    My_community_bar1.backgroundColor=[bc valueForKey:@"backcolor"];
    [option addSubview:My_community_bar1];
    
    My_community_bar2=[[UILabel alloc]initWithFrame:CGRectMake(Shared_Board_bar1.frame.size.width+Shared_Board_bar1.frame.origin.x, Community.frame.size.height+Community.frame.origin.y, screenWidth/4, 5)];
    My_community_bar2.backgroundColor= [UIColor colorWithRed:189.0/255.0 green:164.0/255.0 blue:226.0/255.0 alpha:1];
    My_community_bar2.hidden=true;
    [option addSubview:My_community_bar2];
    
    UILabel *linelabel11=[[UILabel alloc]initWithFrame:CGRectMake(Shared_Board_bar1.frame.size.width+Shared_Board_bar1.frame.origin.x, Community.frame.size.height+Community.frame.origin.y+3, screenWidth/4, 2)];
    linelabel11.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [option addSubview:linelabel11];
    
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CommunityboardView)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    Community.userInteractionEnabled = YES;
    [Community addGestureRecognizer:communityeg];
    
    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, option.frame.size.height+option.frame.origin.y, screenWidth, 30)];
    middle_label.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:252.0f/255 alpha:1.0];//[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:147.0f/255 alpha:1.0f];
    [main addSubview:middle_label];
    [self NotificationView];
}


#pragma mark 3 tab without notificatio
//tabNoti [UIColor colorWithRed:130.0/255.0 green:197.0/255.0 blue:246.0/255.0 alpha:1];
//tab1 [UIColor colorWithRed:52.0/255.0 green:127.0/255.0 blue:103.0/255.0 alpha:1];
//tab2 [UIColor colorWithRed:108.0/255.0 green:114.0/255.0 blue:41.0/255.0 alpha:1];
//tab3 [UIColor colorWithRed:189.0/255.0 green:164.0/255.0 blue:226.0/255.0 alpha:1];

-(void)TabbarWithoutNotification
{
    scrollPostion=0;
    limit=0;
    shomainpop=0;
    myBordAr=[[NSMutableArray alloc]init];
    [self retiveMyBoard];
    
    option=[[UIView alloc]initWithFrame:CGRectMake(0,0, screenWidth, 45)];
    option.backgroundColor=[UIColor clearColor];
    [main addSubview:option];
    
    UILabel *linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, option.frame.size.height-2, option.frame.size.width, 2)];
    linelabel.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [option addSubview:linelabel];
    
    NSMutableDictionary *bc=[SavePrefrences sharedInstance].colorDictionry;
    
    My_Board=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth/3, 40)];
    My_Board.text=@"My Board";
    My_Board.textAlignment=NSTextAlignmentCenter;
    [My_Board setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    My_Board.backgroundColor=[bc valueForKey:@"clearColor"];
    My_Board.textColor=[UIColor colorWithRed:52.0/255.0 green:127.0/255.0 blue:103.0/255.0 alpha:1];;
    [option addSubview:My_Board];
    
    My_board_bar1=[[UILabel alloc]initWithFrame:CGRectMake(0, My_Board.frame.size.height+My_Board.frame.origin.y, screenWidth/3, 5)];
    My_board_bar1.backgroundColor=[UIColor clearColor];//[bc valueForKey:@"clearColor"];
    [option addSubview:My_board_bar1];
    
    My_board_bar2=[[UILabel alloc]initWithFrame:CGRectMake(0, My_Board.frame.size.height+My_Board.frame.origin.y, screenWidth/3, 5)];
    My_board_bar2.backgroundColor=[UIColor colorWithRed:52.0/255.0 green:127.0/255.0 blue:103.0/255.0 alpha:1];//[bc valueForKey:@"clearColor"];
    My_board_bar2.hidden=false;
    [option addSubview:My_board_bar2];
    
    UITapGestureRecognizer *Myboardreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MyboardView)];
    [Myboardreg setNumberOfTouchesRequired:1];
    [Myboardreg setDelegate:self];
    My_Board.userInteractionEnabled = YES;
    My_Board.tag=0;
    [My_Board addGestureRecognizer:Myboardreg];
    
    Shared_Board=[[UILabel alloc]initWithFrame:CGRectMake(My_Board.frame.size.width+My_Board.frame.origin.x, 0, screenWidth/3, 40)];
    Shared_Board.text=@"Shared Board";
    Shared_Board.textAlignment=NSTextAlignmentCenter;
    [Shared_Board setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Shared_Board.backgroundColor=[bc valueForKey:@"clearColor"];
    Shared_Board.textColor=[UIColor colorWithRed:108.0/255.0 green:114.0/255.0 blue:41.0/255.0 alpha:1];
    [option addSubview:Shared_Board];
    
    Shared_Board_bar1=[[UILabel alloc]initWithFrame:CGRectMake(My_Board.frame.size.width+My_Board.frame.origin.x, Shared_Board.frame.size.height+Shared_Board.frame.origin.y, screenWidth/3, 5)];
    Shared_Board_bar1.backgroundColor=[UIColor clearColor];
    [option addSubview:Shared_Board_bar1];
    
    Shared_Board_bar2=[[UILabel alloc]initWithFrame:CGRectMake(My_Board.frame.size.width+My_Board.frame.origin.x, Shared_Board.frame.size.height+Shared_Board.frame.origin.y, screenWidth/3, 5)];
    Shared_Board_bar2.backgroundColor=[UIColor colorWithRed:108.0/255.0 green:114.0/255.0 blue:41.0/255.0 alpha:1];
    Shared_Board_bar2.hidden=true;
    [option addSubview:Shared_Board_bar2];
    
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SharedBoardView)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    Shared_Board.userInteractionEnabled = YES;
    [Shared_Board addGestureRecognizer:sworkingreg];
    
    Community=[[UILabel alloc]initWithFrame:CGRectMake(Shared_Board.frame.size.width+Shared_Board.frame.origin.x, 0, screenWidth/3, 40)];
    Community.text=@"Community Board";
    Community.textAlignment=NSTextAlignmentCenter;
    [Community setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Community.backgroundColor=[bc valueForKey:@"clearColor"];
    Community.textColor=[UIColor colorWithRed:189.0/255.0 green:164.0/255.0 blue:226.0/255.0 alpha:1];
    [option addSubview:Community];
    
    
    My_community_bar1=[[UILabel alloc]initWithFrame:CGRectMake(Shared_Board.frame.size.width+Shared_Board.frame.origin.x, Community.frame.size.height+Community.frame.origin.y, screenWidth/3, 5)];
    My_community_bar1.backgroundColor=[bc valueForKey:@"clearColor"];
    [option addSubview:My_community_bar1];
    
    My_community_bar2=[[UILabel alloc]initWithFrame:CGRectMake(Shared_Board.frame.size.width+Shared_Board.frame.origin.x, Community.frame.size.height+Community.frame.origin.y, screenWidth/3, 5)];
    My_community_bar2.backgroundColor=[UIColor colorWithRed:189.0/255.0 green:164.0/255.0 blue:226.0/255.0 alpha:1];
    My_community_bar2.hidden=true;
    [option addSubview:My_community_bar2];
    
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CommunityboardView)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    Community.userInteractionEnabled = YES;
    [Community addGestureRecognizer:communityeg];
    
    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, option.frame.size.height+option.frame.origin.y, screenWidth, 30)];
    middle_label.backgroundColor=[bc valueForKey:@"clearColor"];//[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:147.0f/255 alpha:1.0f];
    [main addSubview:middle_label];
    [self MyboardView];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"predddd");
    [textField resignFirstResponder];
    return YES;
}


-(void)retrieveNotify{
    BrdAr=[[NSMutableArray alloc]init];
    NSArray* boardNotifs = [[NSUserDefaults standardUserDefaults] valueForKey:@"BOARD_NOTIF_COUNT"];
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"date"
                                        ascending:NO];
    NSArray *sortDescriptors = @[dateDescriptor];
    
    if([boardNotifs count]){
        BrdAr = [boardNotifs sortedArrayUsingDescriptors:sortDescriptors].mutableCopy;
    }

    //    for (NSInteger i = (int)BrdAr.count - 1; i >= 0 ; i--){
    //        NSString * time=[[BrdAr valueForKey:@"time"] objectAtIndex:i];
    //        NSString * ntc= [[BrdAr valueForKey:@"ntc"] objectAtIndex:i];
    //
    //        if(([ntc intValue]==11)||([ntc intValue]==12)||([ntc intValue]==13)||([ntc intValue]==14)||([ntc intValue]==15))
    //        {
    //            if([[[SavePrefrences sharedInstance].notiWithoutADR allKeys] containsObject:time])
    //            {
    //                [BrdAr removeObjectAtIndex:i];
    //            }
    //            else
    //            {
    //                [[SavePrefrences sharedInstance].notiWithoutADR setValue:time forKey:time];
    //            }
    //        }
    //    }
    //
    //    NSLog(@"board array is %@",BrdAr);
    
    [self customizeActionBar:self];
}

#pragma  mark tab0 noti
-(void) NotificationView
{
    [self clearSharedBoardView];
    [self clearCommunityboardView];
    [self clearMyboardview];
    
    [commTableView removeFromSuperview];
    [sharedboardTableVw removeFromSuperview];
    [myBoardtablevw removeFromSuperview];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    My_Board.backgroundColor=[ff valueForKey:@"clearColor"];
    Shared_Board.backgroundColor=[ff valueForKey:@"clearColor"];
    Community.backgroundColor=[ff valueForKey:@"clearColor"];
    
    middle_label.hidden=true;
    
    My_board_bar2.hidden=true;
    Shared_Board_bar2.hidden=true;
    My_community_bar2.hidden=true;
    notification_bar2.hidden=false;
    
    /* UILabel *linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, middle_label.frame.size.width, 2)];
     linelabel.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
     [main addSubview:linelabel];*/
    
    mynotification=[[UITableView alloc] initWithFrame:CGRectMake(2, middle_label.frame.size.height+middle_label.frame.origin.y-20+2,main.frame.size.width,main.frame.size.height-(middle_label.frame.size.height+option.frame.size.height+70))];
    mynotification.delegate = self;
    mynotification.dataSource = self;
    mynotification.scrollEnabled = YES;
    mynotification.backgroundColor=[ff valueForKey:@"backcolor"];
    mynotification.separatorColor=[UIColor clearColor];//[ff valueForKey:@"backcolor"];
    [main addSubview:mynotification];
    
}

#pragma mark tab2

-(void)showSharedBord
{
    [self clearMyboardview];
    [self clearCommunityboardView];
    
    [mynotification removeFromSuperview];
    [myBoardtablevw removeFromSuperview];
    [commTableView removeFromSuperview];
    
    /*UILabel *linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, middle_label.frame.size.width, 2)];
     linelabel.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
     [middle_label addSubview:linelabel];*/
    
    
    middle_label.hidden=false;
    My_board_bar2.hidden=true;
    notification_bar2.hidden=true;
    My_community_bar2.hidden=true;
    Shared_Board_bar2.hidden=false;
    
    chkBoard=1;
    
    
    search1=[[UITextField alloc]initWithFrame:CGRectMake(5, 5,(middle_label.frame.size.width/2 + 60), middle_label.frame.size.height-6)];
    search1.backgroundColor=[UIColor colorWithRed:225.0f/255 green:232.0f/255 blue:239.0f/255 alpha:1.0f];
    search1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    // search1.placeholder=@"Search";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    search1.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: color}];
    
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search1.leftView = paddingView;
    search1.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    
    [search1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    search1.delegate=self;
    [middle_label addSubview:search1];
    
    float wid=[SavePrefrences sharedInstance].screenWidth-search1.frame.size.width+5;
    wid=(wid-30)/4;
    
    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(search1.frame.size.width+search1.frame.origin.x+5, 5, 25,middle_label.frame.size.height-10)];
    searchbutton.backgroundColor=[UIColor clearColor];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *sworkingreg3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sharedSimpleSearch)];
    [sworkingreg3 setNumberOfTouchesRequired:1];
    [sworkingreg3 setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:sworkingreg3];
    
    /* UIButton *industry_btn=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 3.5,wid, middle_label.frame.size.height-6)];
     industry_btn.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
     [industry_btn setImage:[UIImage imageNamed:@"industry.png"] forState:UIControlStateNormal  ];
     industry_btn.tag=0;
     [industry_btn addTarget:self action:@selector(IndSearch:)forControlEvents:UIControlEventTouchUpInside];
     // [middle_label addSubview:industry_btn];*/
    
    UIButton *advance=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+15, 0, 40, middle_label.frame.size.height+5)];
    advance.backgroundColor=[UIColor clearColor];
    [advance setImage:[UIImage imageNamed:@"advance-search.png"] forState:UIControlStateNormal];
    advance.tag=1;
    [advance addTarget:self action:@selector(advncesearch:)
      forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:advance];
    
    //    UIView *imgset=[[UIView alloc]initWithFrame:CGRectMake(advance.frame.size.width+advance.frame.origin.x+5, 0, 35, middle_label.frame.size.height)];
    //    imgset.backgroundColor=[UIColor clearColor];
    //    [middle_label addSubview:imgset];
    
    
    UIImageView *three_dots=[[UIImageView  alloc]initWithFrame:CGRectMake(advance.frame.size.width+advance.frame.origin.x+10, 6, 25, middle_label.frame.size.height-8)];
    three_dots.image=[UIImage imageNamed:@"more.png"];
    [middle_label addSubview:three_dots];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(sortby:)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    three_dots.userInteractionEnabled = YES;
    three_dots.tag=1;
    [three_dots addGestureRecognizer:sworkingreg2];
    
    
    sharedboardTableVw = [[UITableView alloc] initWithFrame:CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y+5,main.frame.size.width,main.frame.size.height-(middle_label.frame.size.height+option.frame.size.height+90))];
    sharedboardTableVw.delegate = self;
    sharedboardTableVw.dataSource = self;
    sharedboardTableVw.scrollEnabled = YES;
    NSMutableDictionary *pc=[SavePrefrences sharedInstance].colorDictionry;
    sharedboardTableVw.backgroundColor=[pc valueForKey:@"backcolor"];
    sharedboardTableVw.separatorColor=[UIColor clearColor];
    [main addSubview:sharedboardTableVw];
    
}




-(void)clearNotBoardView
{
    NSArray *board2 = [middle_label subviews];
    for (UIView *v in board2)
    {
        [v removeFromSuperview];
    }
}

#pragma mark tab1

-(void) MyboardView
{
    NSMutableDictionary *bc=[SavePrefrences sharedInstance].colorDictionry;
    scrollPostion=0;
    limit=0;
    shomainpop=0;
    myBordAr=[[NSMutableArray alloc]init];
    [self retiveMyBoard];
    [self clearSharedBoardView];
    [self clearCommunityboardView];
    [self clearNotBoardView];
    
    middle_label.hidden=false;
    
    [mynotification removeFromSuperview];
    [sharedboardTableVw removeFromSuperview];
    [commTableView removeFromSuperview];
    
    My_board_bar2.hidden=false;
    Shared_Board_bar2.hidden=true;
    My_community_bar2.hidden=true;
    notification_bar2.hidden=true;
    
    /*UILabel *linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, middle_label.frame.size.width, 2)];
     linelabel.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
     [middle_label addSubview:linelabel];*/
    
    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(5, 5,(middle_label.frame.size.width/2)+60, middle_label.frame.size.height-6)];
    search_lbl.backgroundColor=[UIColor colorWithRed:225.0f/255 green:232.0f/255 blue:239.0f/255 alpha:1.0f];
    search_lbl.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    // search_lbl.placeholder=@"Search";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    search_lbl.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: color}];
    
    [search_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    search_lbl.delegate=self;
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = paddingView;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    
    [middle_label addSubview:search_lbl];
    
    chkBoard=0;
    
    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+5.7,5,25,middle_label.frame.size.height-10)];
    searchbutton.backgroundColor=[bc valueForKey:@"clearColor"];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    searchbutton.tag=3;
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *sworkingreg1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(search)];
    [sworkingreg1 setNumberOfTouchesRequired:1];
    [sworkingreg1 setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:sworkingreg1];
    
    
    /* UIButton *indus=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5,3.5, div/3-25, middle_label.frame.size.height-6)];
     indus.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
     [indus setImage:[UIImage imageNamed:@"industry.png"] forState:UIControlStateNormal];
     indus.tag=20;
     [indus addTarget:self action:@selector(IndSearch:)forControlEvents:UIControlEventTouchUpInside];
     //[middle_label addSubview:indus];*/
    
    
    UIView *addit=[[UIView alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+10, 0, 40, middle_label.frame.size.height+5)];
    addit.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:addit];
    
    UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,addit.frame.size.width, addit.frame.size.height)];
    img1.image=[UIImage imageNamed:@"addfolderwhite.png"];
    [addit addSubview:img1];
    
    UITapGestureRecognizer *sworkingreg3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddNewBoardGesture)];
    [sworkingreg3 setNumberOfTouchesRequired:1];
    [sworkingreg3 setDelegate:self];
    addit.userInteractionEnabled = YES;
    [addit addGestureRecognizer:sworkingreg3];
    
    UIView *imgset=[[UIView alloc]initWithFrame:CGRectMake(addit.frame.size.width+addit.frame.origin.x+10, 6, 25, middle_label.frame.size.height-8)];
    imgset.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:imgset];
    
    UIImageView *three_dots=[[UIImageView  alloc]initWithFrame:CGRectMake(0, 0, 25, imgset.frame.size.height)];
    three_dots.image=[UIImage imageNamed:@"more.png"];
    [imgset addSubview:three_dots];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sortby:)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    imgset.userInteractionEnabled = YES;
    imgset.tag=0;
    [imgset addGestureRecognizer:sworkingreg2];
    
    
    myBoardtablevw = [[UITableView alloc] initWithFrame:CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y+5,main.frame.size.width,main.frame.size.height-(middle_label.frame.size.height+option.frame.size.height+90))];
    myBoardtablevw.delegate = self;
    myBoardtablevw.dataSource = self;
    myBoardtablevw.scrollEnabled = YES;
    myBoardtablevw.backgroundColor=[bc valueForKey:@"backcolor"];
    myBoardtablevw.separatorColor=[UIColor clearColor];
    [main addSubview:myBoardtablevw];
    
}
-(void)search
{
    if (![[search_lbl.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]) {
        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Text First" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }
    myBordAr=[[NSMutableArray alloc]init];
    scrollPostion=0;
    limit=0;
    [self searchboard];
    
}


-(void)searchboard{
    iscallback=3;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setObject:search_lbl.text forKey:@"title"];
    [dic setObject:@"" forKey:@"myind"];
    [dic setObject:@"" forKey:@"mydep"];
    [dic setObject:[self getSortKey] forKey:@"val"];
    [dic setObject:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"srchMyBoard" :@"":@"":dic :self];
}


-(void)clearMyboardview
{
    NSArray *board1 = [middle_label subviews];
    
    for (UIView *v in board1)
    {
        [v removeFromSuperview];
    }
}

-(void)SharedBoardView
{
    NSLog(@"inside shared board");
    selectedtab = 2;
    showSharedpop=0;
    [self retrieveSharedBoard];
}


-(void)sharedSimpleSearch
{
    if (![[search1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]) {
        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Text First" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }
    limit=0;
    scrollPostion=0;
    sharedAr=[[NSMutableArray alloc]init];
    [self sharedSimpleSearch1];
    
}

-(void)sharedSimpleSearch1
{
    iscallback=4;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setObject:search1.text forKey:@"title"];
    [dic1 setObject:[self getSortKey] forKey:@"val"];
    [dic1 setObject:@"" forKey:@"myind"];
    [dic1 setObject:@"" forKey:@"mydep"];
    [dic1 setObject:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"SharedBoard" :@"srchShareBoard" :@"":@"":dic1 :self];
    
}


-(void)clearSharedBoardView
{
    NSArray *board2 = [middle_label subviews];
    for (UIView *v in board2)
    {
        [v removeFromSuperview];
    }
}

-(void)CommunityboardView
{
    selectedtab = 3;
    showCommpop=0;
    [self retrieveCommunityBoard];
    
    
}

#pragma mark tab3

-(void)showCommunityBoardView
{
    [self clearMyboardview];
    [self clearSharedBoardView];
    
    
    [mynotification removeFromSuperview];
    [sharedboardTableVw removeFromSuperview];
    [myBoardtablevw removeFromSuperview];
    
    middle_label.hidden=false;
    
    My_board_bar2.hidden=true;
    notification_bar2.hidden=true;
    My_community_bar2.hidden=false;
    Shared_Board_bar2.hidden=true;
    
    chkBoard=2;
    
    
    /* UILabel *linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, middle_label.frame.size.width, 2)];
     linelabel.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
     [middle_label addSubview:linelabel];*/
    
    
    search=[[UITextField alloc]initWithFrame:CGRectMake(5, 5,middle_label.frame.size.width/2 +60, middle_label.frame.size.height-7)];
    search.backgroundColor=[UIColor colorWithRed:225.0f/255 green:232.0f/255 blue:239.0f/255 alpha:1.0f];
    search.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    // search.placeholder=@"Search";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    search.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: color}];
    
    [search setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search.leftView = paddingView;
    search.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    
    search.delegate=self;
    [middle_label addSubview:search];
    
    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(search.frame.size.width+search.frame.origin.x+5,5,25,middle_label.frame.size.height-10)];
    searchbutton.backgroundColor=[UIColor clearColor];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *sreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CommunitySearch)];
    [sreg2 setNumberOfTouchesRequired:1];
    [sreg2 setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:sreg2];
    
    
    UIButton *advance=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+15, 0, 40, middle_label.frame.size.height+5)];
    advance.backgroundColor=[UIColor clearColor];//colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
    [advance setImage:[UIImage imageNamed:@"advance-search.png"] forState:UIControlStateNormal];
    advance.tag=2;
    [advance addTarget:self action:@selector(advncesearch:)
      forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:advance];
    
    
    UIView *imgset=[[UIView alloc]initWithFrame:CGRectMake(advance.frame.size.width+advance.frame.origin.x+10, 6, 25, middle_label.frame.size.height-8)];
    imgset.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:imgset];
    
    
    UIImageView *three_dots=[[UIImageView  alloc]initWithFrame:CGRectMake(0, 0, 25, imgset.frame.size.height)];
    three_dots.image=[UIImage imageNamed:@"more.png"];
    [imgset addSubview:three_dots];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(sortby:)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    imgset.userInteractionEnabled = YES;
    imgset.tag=2;
    [imgset addGestureRecognizer:sworkingreg2];
    
    commTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, middle_label.frame.size.height+middle_label.frame.origin.y+5,main.frame.size.width,main.frame.size.height-(middle_label.frame.size.height+option.frame.size.height+90))];
    commTableView.delegate = self;
    commTableView.dataSource = self;
    commTableView.scrollEnabled = YES;
    NSMutableDictionary *pc=[SavePrefrences sharedInstance].colorDictionry;
    commTableView.backgroundColor=[pc valueForKey:@"backcolor"];
    commTableView.separatorColor=[UIColor clearColor];
    [main addSubview:commTableView];
    
    
    //
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSRange textFieldRange = NSMakeRange(0, [textField.text length]);
    if (NSEqualRanges(range, textFieldRange) && [string length] == 0) {
        // Game on: when you return YES from this, your field will be empty
        if(selectedtab == 1){
            [myBordAr removeAllObjects];
            [self retiveMyBoard];
        }else if (selectedtab == 2){
            [sharedAr removeAllObjects];
            [self retrieveSharedBoard];
        }else{
            [commAr removeAllObjects];
            [self retrieveCommunityBoard];
        }
    }
    return YES;
}

-(void)CommunitySearch{
    
    NSLog(@"s1===%@",search1.text);
    NSLog(@"s===%@",search.text);
    
    if (![[search.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]) {
        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Text First" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }
    
    iscallback=0;
    scrollPostion=0;
    commAr=[[NSMutableArray alloc]init];
    [self CommunitySearch1];
}


-(void)CommunitySearch1{
    NSLog(@"Inside community search");
    
    iscallback=5;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setObject:search.text forKey:@"title"];
    [dic1 setObject:[self getSortKey] forKey:@"val"];
    [dic1 setObject:@"" forKey:@"myind"];
    [dic1 setObject:@"" forKey:@"mydep"];
    [dic1 setObject:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"ComnBoard" :@"srchAllBoard" :@"":@"":dic1 :self];
}

-(IBAction)IndSearch:(id)sender{
    UIButton *btn=(UIButton*)sender;
    [bpop IndustrySearch:self:(int)btn.tag:0];
}

-(IBAction)advncesearch:(id)sender{
    scrollPostion=0;
    limit=0;
    
    UIButton *btn=(UIButton*)sender;
    [bpop advanceSearch:self:(int)btn.tag];
}

//-(void)advnceSearch1:(int)idd
//{
//
//    [bpop advanceSearch:self:(int)btn.tag];
//}


-(void)sortby:(id)sender{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    [bpop sortby:self:(int)tg.view.tag];
}

-(void)clearCommunityboardView{
    NSArray *board3 = [middle_label subviews];
    for (UIView *v in board3)
    {
        [v removeFromSuperview];
    }
}

-(void)AddNewBoardGesture{
    
    [bpop addnewBoard:self];
}

#pragma mark tableView Setup

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath{
    int number1=0;
    
    if(tableView==myBoardtablevw)
    {
        int x=((int)[myBordAr count]-1)-(int)indexPath.row;
        NSString *cmnt_content=[[myBordAr objectAtIndex:x]valueForKey:@"cmnt_content"];
        NSString *uname=[[myBordAr objectAtIndex:x]valueForKey:@"uname"];
        NSString *img1=[[myBordAr objectAtIndex:x]valueForKey:@"img"];
        if([cmnt_content isEqual:[NSNull null]] )//&& [uname isEqual:[NSNull null]] && [cmnt_content isEqual:[NSNull null]])
        {
            NSLog(@"NULLLLLLLLL");
            number1 = 40;
        }
        else
        {
            number1 = 85;
        }
        
    }
    else if(tableView==sharedboardTableVw)
    {
        NSString *uname=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *cmnt_content=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"cmnt_content"];
        NSString *img1=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        if([cmnt_content isEqual:[NSNull null]] )//&& [uname isEqual:[NSNull null]] && [cmnt_content isEqual:[NSNull null]])
        {
            NSLog(@"NULLLLLLLLL");
            number1 = 40;
        }
        else
        {
            number1 = 85;
        }
    }
    else if (tableView==commTableView)
    {
        NSString *uname=[[commAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *cmnt_content=[[commAr objectAtIndex:indexPath.row]valueForKey:@"cmnt_content"];
        NSString *img1=[[commAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        if([cmnt_content isEqual:[NSNull null]] )//&& [uname isEqual:[NSNull null]] && [cmnt_content isEqual:[NSNull null]])
        {
            NSLog(@"NULLLLLLLLL");
            number1 = 40;
        }
        else
        {
            number1 = 85;
        }

    }
    
     if (tableView==mynotification){
        number1 = 120;
    }
    return number1;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if(mngAr==nil)
        mngAr =[[ManageArray alloc]init];
    
    if(theTableView==myBoardtablevw)
    {
        
        return [myBordAr count];
    }
    else if(theTableView==sharedboardTableVw)
    {
        
        NSLog(@"array cout  ====%lu",[sharedAr count]);
        return [sharedAr count];
    }
    else if (theTableView==commTableView)
    {
        return [commAr count];
    }
    
    else if (theTableView==mynotification)
    {
        
        showMessageAr=[[NSMutableDictionary alloc]init];
        lineLabAr=[[NSMutableDictionary alloc]init];
        declineAr=[[NSMutableDictionary alloc]init];
        
        return [BrdAr count];
    }
    
    
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.myBoardtablevw
                             dequeueReusableCellWithIdentifier:MyCellIdentifier];
    @try {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        
        NSMutableDictionary *bd=[SavePrefrences sharedInstance].colorDictionry;
        cell.backgroundColor=[bd valueForKey:@"backcolor"];
        UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theTableView.frame.size.width, 80)];
        cell_View.backgroundColor=[UIColor clearColor];
        [cell addSubview: cell_View];
        
        
        
        if(theTableView==myBoardtablevw){
            int x=((int)[myBordAr count]-1)-(int)indexPath.row;
            
            NSString *title= [[myBordAr objectAtIndex:x]valueForKey:@"title"];
            NSString *cmnt_content=[[myBordAr objectAtIndex:x]valueForKey:@"cmnt_content"];
            NSString *cmnt_time=[[myBordAr objectAtIndex:x]valueForKey:@"cmnt_time"];
            NSString *b_id=[[myBordAr objectAtIndex:x]valueForKey:@"b_id"];
            NSString *timelog=[[myBordAr objectAtIndex:x]valueForKey:@"timelog"];
            NSString *uname=[[myBordAr objectAtIndex:x]valueForKey:@"uname"];
            NSString *img1=[[myBordAr objectAtIndex:x]valueForKey:@"img"];
            NSString *frid=[[myBordAr objectAtIndex:x]valueForKey:@"u_id"];
            
            
            UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openComments:)];
            [sworkingreg2 setNumberOfTouchesRequired:1];
            [sworkingreg2 setDelegate:self];
            cell.userInteractionEnabled = YES;
            cell.tag=[b_id intValue];
            [cell addGestureRecognizer:sworkingreg2];
            
            UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5,5,cell_View.frame.size.width/2, 20)];
            title_lbl.backgroundColor=[UIColor clearColor];
            title_lbl.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
            [title_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            if([av checkNullStr:title])
            {
                title_lbl.text=title;
            }
            [cell_View addSubview:title_lbl];
            
            
            
            if([cmnt_content isEqual:[NSNull null]] )//&& [uname isEqual:[NSNull null]] && [cmnt_content isEqual:[NSNull null]])
            {
            }
            else
            {
                UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y+2,self.view.bounds.size.width-20,1)];
                separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
                [cell_View addSubview:separator];
                
                
                UILabel *date_log=[[UILabel alloc]initWithFrame:CGRectMake(title_lbl.frame.size.width+title_lbl.frame.origin.x+5,5,(cell_View.frame.size.width/2)-15, 20)];
                date_log.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
                date_log.textAlignment=NSTextAlignmentRight;
                [date_log setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
                if([av checkNullStr:timelog])
                {
                    date_log.text=timelog;
                }
                [cell_View addSubview:date_log];
                
                
                UILabel *gap=[[UILabel alloc]initWithFrame:CGRectMake(5, title_lbl.frame.size.height+title_lbl.frame.origin.y, cell_View.frame.size.width-10, 1)];
                gap.backgroundColor=[UIColor grayColor];
                gap.textColor=[UIColor yellowColor];
                // [cell_View addSubview:gap];
                
                UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(5, gap.frame.size.height+gap.frame.origin.y+6, 40, 38)];
                [image setImage:[UIImage imageNamed:@"username.png"]];
                // image.tag=[frnduid intValue];
                [ cell_View addSubview: image];
                
                NSString * url=[mngAr concatUrl:img1];
                if(url.length<12)
                {
                    image.image = [UIImage imageNamed:@"username.png"];
                }
                else
                {
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                    
                    if (imageData.length<=0)
                        image.image = [UIImage imageNamed:@"username.png"];
                    else
                        image.image = [UIImage imageWithData:imageData];
                }
                
                
                UITapGestureRecognizer *imagereg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openFriendProfile:)];
                [imagereg setNumberOfTouchesRequired:1];
                [imagereg setDelegate:self];
                image.tag=[frid intValue];
                image.userInteractionEnabled = YES;
                [image addGestureRecognizer:imagereg];
                
                
                
                UILabel *uname_lbl=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5,gap.frame.size.height+gap.frame.origin.y+5,(cell_View.frame.size.width-image.frame.size.width)/2-10, 15)];
                uname_lbl.text=uname;
                uname_lbl.textColor=[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0];
                [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
                [cell_View addSubview:uname_lbl];
                
                UILabel *comment=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5,uname_lbl.frame.size.height+uname_lbl.frame.origin.y+2,
                                                                          (cell_View.frame.size.width-image.frame.size.width)/2-10, 20)];
                if([av checkNullStr:cmnt_content])
                {
                    NSString * htmlString = cmnt_content;
                    NSAttributedString * attrStr = [[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil
                                                                                     error:nil];
                    
                    comment.attributedText=attrStr;
                }
                [comment setFont:[UIFont fontWithName:@"HelveticaNeue-italic" size:13]];
                comment.backgroundColor=[UIColor clearColor];
                comment.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];;
                [cell_View addSubview:comment];
                
                UILabel *date2=[[UILabel alloc]initWithFrame:CGRectMake(comment.frame.size.width+comment.frame.origin.x,gap.frame.size.height+gap.frame.origin.y+5,cell_View.frame.size.width-(image.frame.size.width+comment.frame.size.width)-10,20)];
                date2.textAlignment=NSTextAlignmentRight;
                if([av checkNullStr:cmnt_time])
                {
                    date2.text=cmnt_time;
                }
                date2.textColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
                [date2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
                //[cell_View addSubview:date2];
                
            }
            
            
            scrollPostion= myBoardtablevw.contentOffset.y+600;
            
            return cell;
        }
        else if (theTableView==sharedboardTableVw)
        {
            NSString *title=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"title"];
            NSString *timelog=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];
            NSString *uname=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            NSString *cmnt_content=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"cmnt_content"];
            NSString *cmnt_time=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"cmnt_time"];
            NSString *b_id=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"b_id"];
            NSString *frnduid=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            NSString *img1=[[sharedAr objectAtIndex:indexPath.row]valueForKey:@"img"];
            
            
            
            
            UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openComments:)];
            [sworkingreg2 setNumberOfTouchesRequired:1];
            [sworkingreg2 setDelegate:self];
            cell.userInteractionEnabled = YES;
            cell.tag=[b_id intValue];
            
            [cell addGestureRecognizer:sworkingreg2];
            
            UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5,5,cell_View.frame.size.width/2, 20)];
            title_lbl.backgroundColor=[UIColor clearColor];
            [title_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            title_lbl.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
            if([av checkNullStr:title])
            {
                title_lbl.text=title;
            }
            [cell_View addSubview:title_lbl];
            
            
            
            if([cmnt_content isEqual:[NSNull null]] )//&& [uname isEqual:[NSNull null]] && [cmnt_content isEqual:[NSNull null]])
            {
            }
            else
            {
                UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y+2,self.view.bounds.size.width-20,1)];
                separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
                [cell_View addSubview:separator];
                
                UILabel *date_log=[[UILabel alloc]initWithFrame:CGRectMake(title_lbl.frame.size.width+title_lbl.frame.origin.x+5, 5,(cell_View.frame.size.width/2)-15, 20)];
                date_log.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
                date_log.textAlignment=NSTextAlignmentRight;
                [date_log setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
                if([av checkNullStr:timelog])
                {
                    date_log.text=timelog;
                }
                [cell_View addSubview:date_log];
                
                UILabel *gap=[[UILabel alloc]initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y,cell_View.frame.size.width-10, 1)];
                gap.backgroundColor=[UIColor grayColor];
                gap.textColor=[UIColor yellowColor];
                // [cell_View addSubview:gap];
                
                UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(5,gap.frame.size.height+gap.frame.origin.y+6, 40, 38)];
                [image setImage:[UIImage imageNamed:@"username.png"]];
                image.tag=[frnduid intValue];
                [ cell_View addSubview: image];
                
                
                NSString * url=[mngAr concatUrl:img1];
                if(url.length<12)
                {
                    image.image = [UIImage imageNamed:@"username.png"];
                }
                else
                {
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                    
                    if (imageData.length<=0)
                        image.image = [UIImage imageNamed:@"username.png"];
                    else
                        image.image = [UIImage imageWithData:imageData];
                }
                
                
                
                
                UITapGestureRecognizer *imagereg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openFriendProfile:)];
                [imagereg setNumberOfTouchesRequired:1];
                [imagereg setDelegate:self];
                image.userInteractionEnabled = YES;
                [image addGestureRecognizer:imagereg];
                
                
                UILabel *uname_lbl=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5,gap.frame.size.height+gap.frame.origin.y+5,(cell_View.frame.size.width-image.frame.size.width)/2-10, 15)];
                uname_lbl.text=uname;
                uname_lbl.textColor=[UIColor colorWithRed:78.0/255 green:119.0/255
                                                     blue:145.0/255 alpha:1.0];
                [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
                [cell_View addSubview:uname_lbl];
                
                
                UILabel *comment=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+3,
                                                                          uname_lbl.frame.size.height+uname_lbl.frame.origin.y+2,
                                                                          (cell_View.frame.size.width-image.frame.size.width)/2-10, 20)];
                if([av checkNullStr:cmnt_content])
                {
                    NSString * htmlString = cmnt_content;
                    NSAttributedString * attrStr = [[NSAttributedString alloc]
                                                    initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{
                                                                                                                                  NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil
                                                    error:nil];
                    
                    comment.attributedText=attrStr;
                }
                [comment setFont:[UIFont fontWithName:@"HelveticaNeue-italic" size:13]];
                comment.backgroundColor=[UIColor clearColor];
                comment.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];;
                [cell_View addSubview:comment];
                
                UILabel *date2=[[UILabel alloc]initWithFrame:CGRectMake(comment.frame.size.width+comment.frame.origin.x,gap.frame.size.height+gap.frame.origin.y+5,cell_View.frame.size.width-(image.frame.size.width+comment.frame.size.width)-10,
                                                                        20)];
                date2.textAlignment=NSTextAlignmentRight;
                date2.backgroundColor=[UIColor clearColor];
                if([av checkNullStr:cmnt_time])
                {
                    date2.text=cmnt_time;
                }
                date2.textColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255
                                                 blue:48.0f/255 alpha:1.0f];
                [date2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
                
            }
            
            
            //[cell_View addSubview:date2];
            scrollPostion= sharedboardTableVw.contentOffset.y+600;
            return  cell;
        }
        else if (theTableView==commTableView)
        {
            
            NSString *title=[[commAr objectAtIndex:indexPath.row]valueForKey:@"title"];
            NSString *timelog=[[commAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];
            NSString *uname=[[commAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            NSString *cmnt_content=[[commAr objectAtIndex:indexPath.row]valueForKey:@"cmnt_content"];
            NSString *cmnt_time=[[commAr objectAtIndex:indexPath.row]valueForKey:@"cmnt_time"];
            NSString *b_id=[[commAr objectAtIndex:indexPath.row]valueForKey:@"b_id"];
            NSString *question=[[commAr objectAtIndex:indexPath.row]valueForKey:@"question"];
            NSString *frnduid=[[commAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            NSString *img1=[[commAr objectAtIndex:indexPath.row]valueForKey:@"img"];
            
            
            
            
            
            UITapGestureRecognizer *sworkingreg3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openComments:)];
            [sworkingreg3 setNumberOfTouchesRequired:1];
            [sworkingreg3 setDelegate:self];
            cell.userInteractionEnabled = YES;
            cell.tag=[b_id intValue];
            [cell addGestureRecognizer:sworkingreg3];
            
            UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5,5,cell_View.frame.size.width/2, 20)];
            title_lbl.backgroundColor=[UIColor clearColor];//78:119:145
            title_lbl.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
            if([av checkNullStr:title])
            {
                title_lbl.text=[NSString stringWithFormat:@"%@",title];
            }
            [title_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [cell_View addSubview:title_lbl];
            
            
            if([cmnt_content isEqual:[NSNull null]] )//&& [uname isEqual:[NSNull null]] && [cmnt_content isEqual:[NSNull null]])
            {
            }
            else{
                UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y+2,self.view.bounds.size.width-20,1)];
                separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
                [cell_View addSubview:separator];
                
                UILabel *date_log=[[UILabel alloc]initWithFrame:CGRectMake(title_lbl.frame.size.width+title_lbl.frame.origin.x+5,5,(cell_View.frame.size.width/2)-15, 20)];
                date_log.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
                date_log.textAlignment=NSTextAlignmentRight;
                [date_log setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
                if([av checkNullStr:timelog])
                {
                    date_log.text=[NSString stringWithFormat:@"%@",timelog];
                }
                [cell_View addSubview:date_log];
                
                
                
                UILabel *gap=[[UILabel alloc]initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y, cell_View.frame.size.width-10, 1)];
                gap.backgroundColor=[UIColor grayColor];
                gap.textColor=[UIColor yellowColor];
                //[cell_View addSubview:gap];
                
                UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(5,gap.frame.size.height+gap.frame.origin.y+6, 40, 38)];
                [image setImage:[UIImage imageNamed:@"username.png"]];
                image.tag=[frnduid intValue];
                [ cell_View addSubview: image];
                
                NSString * url=[mngAr concatUrl:img1];
                if(url.length<12)
                {
                    image.image = [UIImage imageNamed:@"username.png"];
                }
                else
                {
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                    
                    if (imageData.length<=0)
                        image.image = [UIImage imageNamed:@"username.png"];
                    else
                        image.image = [UIImage imageWithData:imageData];
                }
                
                
                UITapGestureRecognizer *imagereg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openFriendProfile:)];
                [imagereg setNumberOfTouchesRequired:1];
                [imagereg setDelegate:self];
                image.userInteractionEnabled = YES;
                image.tag=[frnduid intValue];
                [image addGestureRecognizer:imagereg];
                
                UILabel *uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5, gap.frame.size.height+gap.frame.origin.y+5,(cell_View.frame.size.width-image.frame.size.width)/2-10, 15)];
                if([av checkNullStr:uname])
                {
                    uname_lbl.text=[NSString stringWithFormat:@"%@",uname];
                    
                }
                uname_lbl.textColor=[UIColor colorWithRed:78.0/255 green:119.0/255
                                                     blue:145.0/255 alpha:1.0];
                [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
                [cell_View addSubview:uname_lbl];
                
                UILabel *comment=[[UILabel
                                   alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5,
                                                                  uname_lbl.frame.size.height+uname_lbl.frame.origin.y+2,
                                                                  (cell_View.frame.size.width-image.frame.size.width)/2-10, 20)];
                if([av checkNullStr:cmnt_content])
                {
                    NSString * htmlString = cmnt_content;
                    NSAttributedString * attrStr = [[NSAttributedString alloc]
                                                    initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{
                                                                                                                                  NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil
                                                    error:nil];
                    
                    comment.attributedText=attrStr;
                }
                [comment setFont:[UIFont fontWithName:@"HelveticaNeue-italic" size:13]];
                comment.backgroundColor=[UIColor clearColor];
                comment.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];;
                [cell_View addSubview:comment];
                
                UILabel *date2=[[UILabel
                                 alloc]initWithFrame:CGRectMake(comment.frame.size.width+comment.frame.origin.x,gap.frame.size.height+gap.frame.origin.y+5,cell_View.frame.size.width-(image.frame.size.width+comment.frame.size.width)-10,
                                                                20)];
                date2.textAlignment=NSTextAlignmentRight;
                date2.backgroundColor=[UIColor clearColor];
                if([av checkNullStr:cmnt_time])
                {
                    date2.text=[NSString stringWithFormat:@"%@",cmnt_time];
                }
                date2.textColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255
                                                 blue:48.0f/255 alpha:1.0f];
                [date2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
                //[cell_View addSubview:date2];
                
                
            }
            
            scrollPostion= commTableView.contentOffset.y+600;
            
            return  cell;
            
        }
        else if(theTableView==mynotification)
        {
            cell_View.frame = CGRectMake(0, 0, theTableView.frame.size.width, 120);
            [SavePrefrences sharedInstance].ischkboard=@"1";
            if((int)indexPath.row <(int)[BrdAr count])
            {
                NSArray * data=[BrdAr objectAtIndex:indexPath.row];
                NSDictionary* dataDic = (NSDictionary*)data;
                NSString *firstname=[data valueForKey:@"fname"] ;
                NSString *lastname=[data valueForKey:@"lname"] ;
                NSDateFormatter *dtf = [[NSDateFormatter alloc] init];
                [dtf setDateFormat:@"MMM dd, hh:mm a"];
                NSDate *date = dataDic[@"date"];
                NSString *time = [dtf stringFromDate:date];
                NSString *uname = [data valueForKey:@"uname"] ;
                NSString *noti_id=[data valueForKey:@"noti_id"] ;
                NSString *img1=[data valueForKey:@"img"];
                
                int ntc=[[data valueForKey:@"ntc"] intValue];
//                time=[mngAr timeConverter:time];
                NSString * tit;
                
//                NSLog(@"time isss===%@",time);
                
                UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(3,10, 40, 40)];
                [image setImage:[UIImage imageNamed:@"username.png"]];
                [ cell_View addSubview: image];
                
                NSString * url=[mngAr concatUrl:img1];
                if(url.length<12)
                {
                    image.image = [UIImage imageNamed:@"username.png"];
                }
                else
                {
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                    
                    if (imageData.length<=0)
                        image.image = [UIImage imageNamed:@"username.png"];
                    else
                        image.image = [UIImage imageWithData:imageData];
                }
                
                UILabel *uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+8, 14,cell_View.frame.size.width-45, 20)];
                if([av checkNullStr:uname])
                {
                    uname_lbl.text=[NSString stringWithFormat:@"%@",uname];
                }
                uname_lbl.textColor=[UIColor colorWithRed:153.0/255 green:153.0/255  blue:153.0/255 alpha:1.0];
                [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
                [cell_View addSubview:uname_lbl];
                
                UITextView *line_lbl=[[UITextView alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+6,uname_lbl.frame.size.height+uname_lbl.frame.origin.y,cell_View.frame.size.width-image.frame.size.width+image.frame.origin.x+10, 40)];
                line_lbl.backgroundColor=[UIColor clearColor];
                line_lbl.editable=NO;
                line_lbl.textColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
                line_lbl.text=tit;
                line_lbl.userInteractionEnabled=NO;
                line_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
                [cell_View addSubview:line_lbl];
                
                
                
                UILabel *time1=[[UILabel alloc]initWithFrame:CGRectMake(0,0,cell_View.frame.size.width-10, 15)];
                time1.backgroundColor=[UIColor clearColor];
                time1.textColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
                time1.text=time;
                time1.textAlignment=NSTextAlignmentRight;
                time1.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
                [cell_View addSubview:time1];
                
                
                
                UIImageView *acceptImg = [[UIImageView alloc]initWithFrame:CGRectMake((cell_View.frame.size.width/2)-105+66,line_lbl.frame.size.height+line_lbl.frame.origin.y+1, 20,20)];
                acceptImg.image=[UIImage imageNamed:@"accept1.png"];
                [cell_View addSubview:acceptImg];
                
                
                UIButton  *acppt=[[UIButton alloc]initWithFrame:CGRectMake((cell_View.frame.size.width/2)-105,line_lbl.frame.size.height+line_lbl.frame.origin.y-10,80,40)];
                acppt.backgroundColor=[UIColor clearColor];
                acppt.tag = indexPath.row;
                [acppt setTitle:@"Accept" forState:UIControlStateNormal];
                [acppt setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
                [acppt setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
                acppt.titleLabel.font=[UIFont systemFontOfSize:12];
                acppt.layer.zPosition = MAXFLOAT;
                [cell_View addSubview:acppt];
                if(ntc==10)
                {
                    NSArray * jsonObject=[mngAr convertojson:data];
                    NSString *brdid,*titled;
                    if([mngAr checkContaine:jsonObject])
                    {
                        brdid=[jsonObject valueForKey:@"brdID"];
                        titled=[jsonObject valueForKey:@"title"];
                        if ([dataDic[@"mess"] rangeOfString:@"has requested to join your"].location != NSNotFound) {
                            tit = [NSString stringWithFormat:@"%@ has requested to join your board %@", uname, titled];
                        }else tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc10] stringByAppendingString:titled];
                    }
                    else
                    {
                        brdid=[jsonObject valueForKey:@"brdID"];
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc10] ;
                    }
                    acppt.hidden=false;
                    acceptImg.hidden=false;
                    line_lbl.text= tit;
                    [acppt addTarget:self action:@selector(acceptAppBoard:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
                else  if(ntc==11)
                {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc11 ];
                    acppt.hidden=true;
                    acceptImg.hidden=true;
                    
                    line_lbl.text= tit;
                    [[SavePrefrences sharedInstance].isAlViedDic setValue:noti_id forKey:noti_id];
                    
                }
                else if(ntc==12)
                {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc12 ];
                    acppt.hidden=true;
                    acceptImg.hidden=true;
                    
                    line_lbl.text=tit;
                    [[SavePrefrences sharedInstance].isAlViedDic setValue:noti_id forKey:noti_id];
                }
                else if(ntc==13)
                {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc13];
                    acppt.hidden=true;
                    acceptImg.hidden=true;
                    
                    line_lbl.text=tit;
                    [[SavePrefrences sharedInstance].isAlViedDic setValue:noti_id forKey:noti_id];
                }
                else if(ntc==14)
                {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc14];
                    acppt.hidden=true;
                    acceptImg.hidden=true;
                    
                    line_lbl.text=tit;
                    [[SavePrefrences sharedInstance].isAlViedDic setValue:noti_id forKey:noti_id];
                }
                else if(ntc==15)
                {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc15];
                    acppt.hidden=true;
                    acceptImg.hidden=true;
                    
                    line_lbl.text=tit;
                    [[SavePrefrences sharedInstance].isAlViedDic setValue:noti_id forKey:noti_id];
                }
                else if(ntc==9)
                {
                    NSArray * jsonObject=[mngAr convertojson:data];
                    NSString *brdid,*titled;
                    if([mngAr checkContaine:jsonObject])
                    {
                        brdid=[jsonObject valueForKey:@"brdID"];
                        titled=[jsonObject valueForKey:@"title"];
                        tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc9] stringByAppendingString:titled];
                    }
                    else
                    {
                        brdid=[jsonObject valueForKey:@"brdID"];
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc9] ;
                    }
                    
                    
                    [acppt addTarget:self action:@selector(acceptBoard:) forControlEvents:UIControlEventTouchUpInside];
                    acppt.hidden=false;
                    acceptImg.hidden=false;
                    
                    line_lbl.text= tit;
                    
                }
                acppt.tag=indexPath.row;
                [cell_View addSubview:acppt];
                
                UIImageView *declineImage = [[UIImageView alloc]initWithFrame:CGRectMake((cell_View.frame.size.width/2)+5+66,line_lbl.frame.size.height+line_lbl.frame.origin.y+1, 20,20)];
                declineImage.image=[UIImage imageNamed:@"deny.png"];
                [cell_View addSubview:declineImage];
                
                
                UIButton *decline=[[UIButton alloc]initWithFrame:CGRectMake((cell_View.frame.size.width/2)+5,line_lbl.frame.size.height+line_lbl.frame.origin.y-10,80,40)];
                decline.tag = indexPath.row;
                decline.backgroundColor = [ff valueForKey:@"clearColor"];
                [decline setTitle:@"Decline" forState:UIControlStateNormal];
                if(ntc==11 || ntc==12 || ntc==13||ntc==14||ntc==15)
                {
                    decline.hidden=true;
                    declineImage.hidden=true;
                    
                    
                    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
                    [dic setObject:@"bd" forKey:@"aid"];
                    NSMutableArray * ar=[[NSMutableArray alloc]init];
                    [ar addObject:noti_id];
                    [dic setObject:ar forKey:@"notiIds"];
                    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
                    
                    
                }
                else if(ntc==10)
                {
                    [decline addTarget:self action:@selector(declineAppBoard:) forControlEvents:UIControlEventTouchUpInside];
                    decline.hidden=false;
                    declineImage.hidden=false;
                    
                }
                
                
                else if (ntc==9)
                {
                    if ([dataDic[@"uid"] intValue] == [SavePrefrences sharedInstance].uid.intValue) {
                        acppt.hidden = YES;
                        acceptImg.hidden = YES;
                        decline.hidden = YES;
                        declineImage.hidden = YES;
                    }else{
                        acppt.hidden = NO;
                        acceptImg.hidden = NO;
                        decline.hidden = NO;
                        declineImage.hidden = NO;
                    }
                    [decline addTarget:self action:@selector(declineBoard:) forControlEvents:UIControlEventTouchUpInside];
                }
                [decline setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
                decline.titleLabel.font=[UIFont systemFontOfSize:12];
                
                [cell_View addSubview:decline];
                decline.tag=indexPath.row;
                
                
                UIButton *btnChat = [[UIButton alloc]initWithFrame:CGRectMake(decline.frame.size.width+decline.frame.origin.x+15+30,line_lbl.frame.size.height+line_lbl.frame.origin.y+1.5, 25,25)];
                btnChat.backgroundColor= [UIColor clearColor];
                [btnChat setBackgroundImage:[UIImage imageNamed:@"chatNew.png"] forState:UIControlStateNormal];
                btnChat.layer.cornerRadius=5;
                btnChat.tag=0;
                [cell_View addSubview:btnChat];
                
                UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(20,btnChat.frame.size.height+btnChat.frame.origin.y+2,self.view.bounds.size.width-20,1)];
                separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
                [cell_View addSubview:separator];
                
                [declineAr setValue:decline forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
                [showMessageAr setValue:acppt forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
                [lineLabAr setValue:line_lbl forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
                
            }
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception is===%@",exception);
    }
    @finally {
        
    }
    
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    NSLog(@"scrolll  viewww     %ld",(maximumOffset - currentOffset));
    
    NSLog(@"iscallback==in scroll==%d",iscallback);
    
    if (maximumOffset - currentOffset <= -100)
    {
        
        if(iscallback==0)
        {
            NSLog(@"inside one");
            limit=limit+18;
            [self retiveMyBoard];
        }
        else if(iscallback==3)
        {
             NSLog(@"inside two");
            limit=limit+18;
            [self searchboard];
           
        }
        else if(iscallback==1)
        {
            NSLog(@"inside three");
            limit=limit+18;
            [self reteriveSharedBoard1];
            
        }
        else if(iscallback==4)
        {
            NSLog(@"inside four");
            limit=limit+18;
            [self sharedSimpleSearch1];
            
        }
        else if(iscallback==2)
        {
            NSLog(@"inside five");
            limit=limit+18;
            [self reteriveCommunityBoard1];
            
        }
        else if(iscallback==5)
        {
            NSLog(@"inside six");
            limit=limit+18;
            [self CommunitySearch1];
    
        }
        
        
        
        
        
    }
}



-(void)openFriendProfile:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    frienduid=(int)tg.view.tag;
    NSLog(@"Hello");
    iscallback=6;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",frienduid] forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile":@"showProfile" :@"":@"":dic1 :self];
    
    
}


-(void)openOptions:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    
    
}


#pragma mark accept and reject action
-(IBAction)acceptBoard:(id)sender{
    UIButton *btn=(UIButton*)sender;
    UIButton * act=[showMessageAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UIButton * dec=[declineAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UILabel * lil=[lineLabAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    dec.hidden=true;
    act.hidden=true;
    
    int tagId=(int)btn.tag;
    
    NSDictionary *bdData=[BrdAr objectAtIndex:tagId];
    NSString* notifBoardID = [NSString stringWithFormat:@"%@", bdData[@"message"][@"brdID"]];
    NSString* notifFrndID = [NSString stringWithFormat:@"%@", bdData[@"uid"]];
    NSString* notifMyID = [NSString stringWithFormat:@"%@", bdData[@"fruid"]];
    NSDictionary* params = @{
                             @"ar" : @"1",
                             @"b_id" : notifBoardID,
                             @"uidFrom" : notifFrndID,
                             @"id" : notifMyID
                             };
        
    iscallback=9;
    [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] removeObjectAtIndex:tagId];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"brdAR" :@"" :@"" :params :self ];

}

-(IBAction)declineBoard:(id)sender{
    UIButton *btn=(UIButton*)sender;
    UIButton * act=[showMessageAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UIButton * dec=[declineAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UILabel * lil=[lineLabAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    
    dec.hidden=true;
    act.hidden=true;
    lil.text=@"you rejected Board Invitation";
    
    iscallback=9;
    int tagId=(int)btn.tag;
    NSDictionary *bdData=[BrdAr objectAtIndex:tagId];
    NSString* notifBoardID = [NSString stringWithFormat:@"%@", bdData[@"message"][@"brdID"]];
    NSString* notifFrndID = [NSString stringWithFormat:@"%@", bdData[@"uid"]];
    NSString* notifMyID = [NSString stringWithFormat:@"%@", bdData[@"fruid"]];
    NSDictionary* params = @{
                             @"ar" : @"2",
                             @"b_id" : notifBoardID,
                             @"uidFrom" : notifFrndID,
                             @"id" : notifMyID
                             };
    
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"brdAR" :@"" :@"" :params :self ];
}

-(IBAction)acceptAppBoard:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    UIButton * act=[showMessageAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UIButton * dec=[declineAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UILabel * lil=[lineLabAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    
    dec.hidden=true;
    act.hidden=true;
    lil.text=@"you accepted Board Application";
    
    iscallback=9;
    
    int tagId=(int)btn.tag;
    int cnt=(int)[BrdAr count];
    if(cnt<=tagId)
    {
        tagId=cnt-1;
    }
    
     NSArray * data=[BrdAr objectAtIndex:tagId];
     NSArray * jsonObject=[mngAr convertojson:data];
    
    
    NSString *brdid=[jsonObject valueForKey:@"brdID"];
    NSString *frid=[data valueForKey:@"uid"];
    noti_id=[data valueForKey:@"noti_id"];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setObject:@"1" forKey:@"ar"];
    [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"b_id"];
    [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
    
    
    cnt  = (int)[[(NSMutableArray *)[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] count];
    if(cnt<=tagId)
    {
        tagId=cnt-1;
    }
    
    
    [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] removeObjectAtIndex:tagId];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"brdJAR" :@"" :@"" :dic :self ];
    
//    for(int x=0;x<[[SavePrefrences sharedInstance].notiYolkingAr count];x++)
//      {
//        NSArray *data=[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:x];
//        NSString * ntc = [data valueForKey:@"ntc"];
//        NSString * frid1 = [data valueForKey:@"uid"];
//        if([ntc intValue]==10)
//        {
//            
//            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//             NSArray * jsonObject=[mngAr convertojson:data];
//            NSString * brdID = [jsonObject valueForKey:@"brdID"];
//            if([brdID intValue]==[brdid intValue])
//            {
//                if([frid intValue]==[frid1 intValue])
//                {
//                    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
//                    [dic setValue:date forKey:@"time"];
//                    [dic setValue:@" You have Accepted The Board Application " forKey:@"mes"];
//                    [[[SavePrefrences sharedInstance].notiYolkingAr  objectAtIndex:x] setValue:dic forKey:@"brdStstus"];
//                    break;
//                }
//            }
//            
//        }
//        
//    }
//    NSLog(@"ykng ar====%@",[SavePrefrences sharedInstance].notiYolkingAr);
    
    
    
    [mynotification reloadData];
    
}



-(IBAction)declineAppBoard:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    UIButton * act=[showMessageAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UIButton * dec=[declineAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UILabel * lil=[lineLabAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    
    dec.hidden=true;
    act.hidden=true;
    lil.text=@"you rejected Board Invitation";
    
    iscallback=9;
    int tagId=(int)btn.tag;
    
    
    
    int cnt=(int)[BrdAr count];
    
    if(cnt<=tagId)
    {
        tagId=cnt-1;
    }
    
    
    
     NSArray * jsonObject=[mngAr convertojson:BrdAr];
     NSArray *mes=[jsonObject objectAtIndex:tagId];
    
    NSString *brdid=[mes valueForKey:@"brdID"];
    NSString *frid=[[BrdAr valueForKey:@"uid"]objectAtIndex:tagId];
    noti_id =[[BrdAr valueForKey:@"noti_id"]objectAtIndex:tagId];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setObject:@"2" forKey:@"ar"];
    [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"b_id"];
    [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"brdJAR" :@"" :@"" :dic :self ];
    
    cnt  = (int)[[(NSMutableArray *)[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] count];
    if(cnt<=tagId)
    {
        tagId=cnt-1;
    }
    [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] removeObjectAtIndex:tagId];
    
    
//    for(int x=0;x<[[SavePrefrences sharedInstance].notiYolkingAr count];x++)
//    {
//        NSArray *data=[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:x];
//        NSString * ntc = [data valueForKey:@"ntc"];
//        NSString * frid1 = [data valueForKey:@"uid"];
//        if([ntc intValue]==10)
//        {
//            
//            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//            NSArray * jsonObject=[mngAr convertojson:data];
//            NSString * brdID = [jsonObject valueForKey:@"brdID"];
//            if([brdID intValue]==[brdid intValue])
//            {
//                if([frid intValue]==[frid1 intValue])
//                {
//                    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
//                    [dic setValue:date forKey:@"time"];
//                    [dic setValue:@" You have Rejected The Board Application " forKey:@"mes"];
//                    [[[SavePrefrences sharedInstance].notiYolkingAr  objectAtIndex:x] setValue:dic forKey:@"brdStstus"];
//                    break;
//                }
//            }
//            
//            
//            
//        }
//        
//    }
    [mynotification reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if(buttonIndex == 0)//OK button pressed
//    {
//        NSLog(@"inside if");
//        if(chkBoard==0)
//        {
//            NSLog(@"inside chkboard=== %d",chkBoard);
//            [self MyboardView];
//        }
//        else if (chkBoard==1)
//        {
//            [self showSharedBord];
//        }
//        else if (chkBoard==2)
//        {
//            [self showCommunityBoardView];
//        }
//    }
//}


#pragma mark NOTIFICATIONS 

-(void)getYokingData{
    float offset = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]] / 3600.0;
    iscallback=1900;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:[NSString stringWithFormat:@"%f",offset] forKey:@"offset"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"showMess" :@"" :@"" :dic :self ];
}

#pragma mark --

-(void)openComments:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer *)sender;
    [bpop showcommentView :self :(int)tg.view.tag:chkBoard:iscallback];
    
}
-(void) callBack:(NSArray *)meta :(NSArray *)data
{
    
     NSLog(@"iscallback in board====%d",iscallback);
     NSLog(@"scroll postion====%f",scrollPostion);
    
     if(iscallback==0)
       {
       if([data count]<=0)
        {
            if(shomainpop==1)
            {
           UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
           [alert show];
            }
            shomainpop=1;
        }
        else
        {
            //myBordAr=data;
            for(int x=(int)[data count]-1;x>=0;x--)
             {
                 if (![myBordAr containsObject:data[x]]) {
                     [myBordAr addObject:[data objectAtIndex:x]];
                 }
             }
            [myBoardtablevw performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
//             [myBoardtablevw setContentOffset:CGPointMake(0,scrollPostion)];
        }
      
    }
    else if (iscallback==1)
    {
        NSLog(@"meta dataaaa====%@",meta);
        NSLog(@"data for shared board is ====%@",data);
       
        //sharedAr=data;
        
        if([data count]<=0)
        {
            if(showSharedpop==1)
            {
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            }
            showSharedpop=1;
          
        }
        else
        {
            for(int x=0;x<[data count];x++)
       // for(int x=(int)[data count]-1;x>=0;x--)
            {
                [sharedAr addObject:[data objectAtIndex:x]];
            }
            [self showSharedBord];
            [sharedboardTableVw setContentOffset:CGPointMake(0,scrollPostion)];
            
        }
        if(showSharedpop==0)
           [self showSharedBord];
       }
    else if (iscallback==2)
    {
        if([data count]<=0)
        {
            if(showCommpop==1)
            {
                UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            showCommpop=1;
        }
        else
        {
           for(int x=0;x<[data count];x++)
           // for(int x=(int)[data count]-1;x>=0;x--)
            {
                [commAr addObject:[data objectAtIndex:x]];
            }
        }
        
        
       // commAr=data;
    //    NSLog(@"community board ar======%@",commAr);
        
        
        [self showCommunityBoardView];
          [commTableView setContentOffset:CGPointMake(0,scrollPostion)];
    }
    else if (iscallback==3)
    {
       if([data count]<=0)
        {
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        else
        {
           // for(int x=0;x<[data count];x++)
              for(int x=(int)[data count]-1;x>=0;x--)
              {
                [myBordAr addObject:[data objectAtIndex:x]];
              }
            [myBoardtablevw reloadData];
            [myBoardtablevw setContentOffset:CGPointMake(0,scrollPostion)];
        }
          //myBordAr=data;
         //[myBoardtablevw reloadData];
    }
    else if(iscallback==4)
    {
        //sharedAr=data;
        
        if([data count]<=0)
        {
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }else{
           for(int x=0;x<[data count];x++)
        // for(int x=(int)[data count]-1;x>=0;x--)
            {
                [sharedAr addObject:[data objectAtIndex:x]];
            }
             [sharedboardTableVw reloadData];
              //[self showSharedBord];
             [sharedboardTableVw setContentOffset:CGPointMake(0,scrollPostion)];
        }
        
     }
    else if (iscallback==5)
    {
        
       // commAr=data;
        
        if([data count]<=0)
        {
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
        }
        else
        {
            for(int x=0;x<[data count];x++)
           // for(int x=(int)[data count]-1;x>=0;x--)
            {
                [commAr addObject:[data objectAtIndex:x]];
            }
            
            [commTableView reloadData];
            [sharedboardTableVw setContentOffset:CGPointMake(0,scrollPostion)];
            
           }
         }
    else if (iscallback==6)
    {
        
        if([[SavePrefrences sharedInstance].uid intValue]==frienduid)
        {
            [drawer addProfileimage:data];
        }
        else
        {
            
            [cmpop addProfileimage :data:frienduid:self];
        }
    }
    
    else if(iscallback==9){
        
        NSLog(@"call back inside board===%@",meta);
        NSLog(@"call back inside  data board===%@",data);
        
        NSArray* boardNotifs = [[NSUserDefaults standardUserDefaults] valueForKey:@"BOARD_NOTIF_COUNT"];
        NSMutableArray* boardNotifsChanged = boardNotifs.mutableCopy;
        NSDictionary* callMeta = (NSDictionary*)meta;
        NSString* notificationId;
        for (NSDictionary* notif in boardNotifs) {
            NSString* boardID = [NSString stringWithFormat:@"%@", callMeta[@"data"][@"b_id"]];
            NSString* notifBoardID = [NSString stringWithFormat:@"%@", notif[@"message"][@"brdID"]];
            NSString* userID = [NSString stringWithFormat:@"%@", callMeta[@"data"][@"uidFrom"]];
            NSString* notifUserID = [NSString stringWithFormat:@"%@", notif[@"uid"]];
            if ([boardID isEqualToString:notifBoardID] && [userID isEqualToString:notifUserID]) {
                notificationId = notif[@"noti_id"];
                [boardNotifsChanged removeObject:notif];
                NSString* notiCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"YOLKING_COUNT"];
                int unreadMsg = notiCount.intValue;
                if (unreadMsg) unreadMsg = unreadMsg-1;
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", unreadMsg] forKey:@"YOLKING_COUNT"];
            }
        }
        [[NSUserDefaults standardUserDefaults] setValue:boardNotifsChanged forKey:@"BOARD_NOTIF_COUNT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self retrieveNotify];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:@"bd" forKey:@"aid"];
        [dic setObject:@[notificationId] forKey:@"notiIds"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
    }
    
    if (iscallback==1900) {
        NSMutableArray *notiAr1 = [[NSMutableArray alloc] init];
        NSMutableArray *boardNotifications = [[NSMutableArray alloc] init];
        for (NSMutableDictionary *dictData in data) {
            NSString *strDate = [dictData objectForKey:@"time"];
            __block NSDate *detectedDate;
            
            //Detect.
            NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingAllTypes error:nil];
            [detector enumerateMatchesInString:strDate
                                       options:kNilOptions
                                         range:NSMakeRange(0, [strDate length])
                                    usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop){
                                        detectedDate = result.date;
                                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                                        dateFormatter.dateFormat = @"MMM dd,yyyy";
                                        [dictData setObject:result.date forKey:@"date"];
                                        [dictData setObject:[dateFormatter stringFromDate:result.date] forKey:@"CreatedDate"];
                                        [notiAr1 addObject:dictData];
                                    }];
            
            if ([dictData[@"ntc"] intValue] == 9) {
                if((!dictData[@"status"]) || ([dictData[@"status"] intValue]==0))
                    [boardNotifications addObject:dictData];
            }
        }
        if (boardNotifications.count) {
            [[NSUserDefaults standardUserDefaults] setValue:boardNotifications forKey:@"BOARD_NOTIF_COUNT"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        NSMutableDictionary* dictionaryByDate = [NSMutableDictionary new];
        for(NSDictionary *dictionary in notiAr1){
            NSString *dateString = dictionary[@"CreatedDate"];
            NSDate  *date = dictionary[@"CreatedDate"];
            NSMutableArray *arrayWithSameDate = dictionaryByDate[dateString];
            if(! arrayWithSameDate){
                arrayWithSameDate = [NSMutableArray new];
                dictionaryByDate[dateString] = arrayWithSameDate;
            }
            [arrayWithSameDate addObject: dictionary];
        }
        
        for (NSString *strData in [dictionaryByDate allKeys]) {
            NSMutableArray *arrData  = [dictionaryByDate objectForKey:strData];
            NSArray* reversedArray = [[arrData reverseObjectEnumerator] allObjects];
            [dictionaryByDate setObject:reversedArray forKey:strData];
        }
        int ykcount = 0;
        if([data count]>0){
            for(int x=(int)[data count]-1; x>=0; x--){
                NSString *status=[[data valueForKey:@"status"] objectAtIndex:x];
                NSString *ntc=[[data valueForKey:@"ntc"] objectAtIndex:x];
                
                NSLog(@"statuss====%@",status);
                if([ntc intValue]==25){
                    if ([[[data valueForKey:@"uid"] objectAtIndex:x]integerValue]!=[[SavePrefrences sharedInstance].uid integerValue]) {
                        if(status==nil||status==NULL||[status isEqual:[NSNull null]]||status == (id)[NSNull null]){
                            ykcount++;
                            status=@"0";
                        }else if([status isEqual:@"Undefined"]){
                            ykcount++;
                            status=@"0";
                        }else if([status intValue]==0){
                            ykcount++;
                        }
                    }
                }
                [notiAr1 addObject:[data objectAtIndex:x]];
                
                if([ntc intValue]==9){
                    if ([[[data valueForKey:@"uid"] objectAtIndex:x]integerValue]!=[[SavePrefrences sharedInstance].uid integerValue]) {
                        if(status==nil||status==NULL||[status isEqual:[NSNull null]]||status == (id)[NSNull null]){
                            ykcount++;
                            status=@"0";
                        }else if([status isEqual:@"Undefined"]){
                            ykcount++;
                            status=@"0";
                        }else if([status intValue]==0){
                            ykcount++;
                        }
                    }
                }
            }
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", ykcount] forKey:@"YOLKING_COUNT"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //[notiTableView setContentOffset:CGPointMake(0,scrollpostion)];
        }else{
//            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//            [alert show];
        }
        [self retrieveNotify];
    }
}

-(void) callMethod:(NSArray *)meta
{
    
    NSLog(@"board callback is=====%d",iscallback);
    
    NSString * chk=[meta objectAtIndex:0];
    
    if(![chk isEqual:@"noresult"] )
    {
        
        NSLog(@"Valuuuuuuuuuu===%@",meta);
        NSLog(@"COUNT IS %lu",[meta count]);
        if([meta count]>1)
        {
            
            NSLog(@"meta is===%@",meta);
            
            NSMutableArray * ar=[meta objectAtIndex:1];
            
            
            
            
            if([ar count]>0)
            {
                if([chk isEqual:@"sortby"])
                {
                    myBordAr=ar;
                    [myBoardtablevw reloadData];
                }
                else if([chk isEqual:@"myboardIndustry"])
                {
                    scrollPostion=0;
                    [myBordAr removeAllObjects];
                    //for(int x=0;x<[ar count];x++)
                    for(int x=(int)[ar count]-1;x>=0;x--)
                    {
                        [myBordAr addObject:[ar objectAtIndex:x]];
                    }
                    [myBoardtablevw reloadData];
                    [myBoardtablevw setContentOffset:CGPointMake(0,scrollPostion)];
                    
                    
                }
                
                
                else if ([chk isEqual:@"newboard"])
                {
                    
                    myBordAr=ar;
                    [myBoardtablevw reloadData];
                    
                }
                else if ([chk isEqual:@"sharedIndustrySearch"])
                {
                    scrollPostion=0;
                    [sharedAr removeAllObjects];
                    for(int x=0;x<[ar count];x++)
                        // for(int x=(int)[ar count]-1;x>=0;x--)
                    {
                        [sharedAr addObject:[ar objectAtIndex:x]];
                    }
                    // sharedAr=ar;
                    [sharedboardTableVw reloadData];
                }
                else if ([chk isEqual:@"Sharedsortby"])
                {
                    
                    scrollPostion=0;
                    [sharedAr removeAllObjects];
                    for(int x=0;x<[ar count];x++)
                        //for(int x=(int)[ar count]-1;x>=0;x--)
                    {
                        [sharedAr addObject:[ar objectAtIndex:x]];
                    }
                    // sharedAr=ar;
                    [sharedboardTableVw reloadData];
                    
                    
                    //  sharedAr=ar;
                    //[sharedboardTableVw reloadData];
                }
                else if ([chk isEqual:@"Communitysortby"])
                {
                    //                commAr=ar;
                    //                [commTableView reloadData];
                    
                    scrollPostion=0;
                    [commAr removeAllObjects];
                    
                    for(int x=0;x<[ar count];x++)
                        //for(int x=(int)[ar count]-1;x>=0;x--)
                    {
                        [commAr addObject:[ar objectAtIndex:x]];
                    }
                    [commTableView reloadData];
                }
                else if ([chk isEqual:@"sharedAdvanceSearch"])
                {
                    // sharedAr=ar;
                    //[sharedboardTableVw reloadData];
                    
                    scrollPostion=0;
                    [sharedAr removeAllObjects];
                    for(int x=0;x<[ar count];x++)
                        //for(int x=(int)[ar count]-1;x>=0;x--)
                    {
                        [sharedAr addObject:[ar objectAtIndex:x]];
                    }
                    // sharedAr=ar;
                    [sharedboardTableVw reloadData];
                    
                    
                    
                }
                else if ([chk isEqual:@"CommunityAdvanceSearch"])
                {
                    //  commAr=ar;
                    //[commTableView reloadData];
                    scrollPostion=0;
                    [commAr removeAllObjects];
                    
                    for(int x=0;x<[ar count];x++)
                        // for(int x=(int)[ar count]-1;x>=0;x--)
                    {
                        [commAr addObject:[ar objectAtIndex:x]];
                    }
                    [commTableView reloadData];
                    
                    
                }
                else if ([chk isEqual:@"MyboardAdvanceSearch"])
                {
                    //myBordAr=ar;
                    //[myBoardtablevw reloadData];
                    
                    [myBordAr removeAllObjects];
                    
                    // for(int x=0;x<[ar count];x++)
                    for(int x=(int)[ar count]-1;x>=0;x--)
                    {
                        [myBordAr addObject:[ar objectAtIndex:x]];
                    }
                    [myBoardtablevw reloadData];
                    [myBoardtablevw setContentOffset:CGPointMake(0,scrollPostion)];
                    
                    
                    //[self retiveMyBoard];
                    
                }
                else if ([chk isEqual:@"CommunityIndustrySearch"])
                {
                    scrollPostion=0;
                    [commAr removeAllObjects];
                    
                    for(int x=0;x<[ar count];x++)
                        //for(int x=(int)[ar count]-1;x>=0;x--)
                    {
                        [commAr addObject:[ar objectAtIndex:x]];
                    }
                    [commTableView reloadData];
                    
                    
                    // commAr=ar;
                    //[commTableView reloadData];
                }
            }
            
            else
            {
                
                
                [myBoardtablevw removeFromSuperview];
                [sharedboardTableVw removeFromSuperview];
                [commTableView removeFromSuperview];
                
                //            NSString *isempty=[meta objectAtIndex:1];
                //            if([isempty intValue]==0)
                //            {
                //                if(chkBoard==0)
                //                {
                //                    [myBoardtablevw removeFromSuperview];
                //                }
                //                else if (chkBoard==1)
                //                {
                //                    [sharedboardTableVw removeFromSuperview];
                //                }
                //                else if(chkBoard==2)
                //                {
                //                    [commTableView removeFromSuperview];
                //                }
                //                
                //                UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No Results Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                //                [alrt show];
                //            }
            }
            
        }
        
        
    }
}



@end




