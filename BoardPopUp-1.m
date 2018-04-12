#import "BoardPopUp.h"
#import "AllValidationsViewController.h"
#import "SavePrefrences.h"
#import "Podcast.h"
#import "MainBord.h"
#import "ManageArray.h"
#import "AppDelegate.h"
#import "BoardListController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface BoardPopUp ()
{
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    AllValidationsViewController *av;
    UIView *prMainView,*cell_View,*headerView,*pop_up,*main,*viewfortable;
    UIButton *invite,*Search;
    UIViewController *vc1;
    UITextField *search_lbl;
    UITextView *type_commnt;
    UILabel *NameLabel,*public;
    NSMutableArray *popUpAr,*publicAr;
    UIScrollView *scrollbar;
    UITextField *title, *search;
    UITextView *question,*Message;
    UILabel *E_alpha,*publish;
    UILabel * Select_Industry,*Proyolk_Friends1,*Proyolk_Friends2,*graybarPrylk,*yellowcbnt,*yellownet,*uname_lbl;
    UILabel *yellowPrylk;
    UILabel* Select_Sub_Industry,*NameLabel1;
    UILabel *comment_lbl,*ques_lbl;
    id sender1,sender2,sender3;
    int pubpri,issort,iscalender;
    int iscallpub,iscallback;
    UIView *publicview,*datePickerView;
    UIButton *onebtncbnt;
    int b_id,selGint,selgrade,isempty;
    NSString *indid,*subid;
    NSArray *commentBAr,*quesAr,*dataind,*subdataind,*inviteAr,*comnIndAr,*calmemAr,*cbntAr,*netwrkAr,*proylkAr;
    MainBord *mpop;
    UIDatePicker *datepicker;
    NSMutableArray * backData;
    UITextField *Title,*Command_On,*Command_By,*Posted_On,*Board_Posted_By;
    UILabel *Grade;
    int isdate,chkboard,tablecellheight,kid;
    NSString *cmnttxt,*isselect;
    UIImageView *video,*attach,*docicon;
    NSMutableArray * inViteFrAr,*barAr, *gradAr,*gradeViewAr;
    
    NSMutableDictionary * alreadyInvitedDic;
    UIButton *apply;
    UIImageView *share;
    UIImageView *comment;
    UIImageView *shareuser;
    NSArray *metaBrd;
    ManageArray *manag;
    int bold,italic,underline,limit;
    NSString *htmlString;
    NSString *titlebtn;
    
}
@end

@implementation BoardPopUp
@synthesize  commentTableView,inviteTableView,ProyolkTableView,networkTableview,ProyolkFrndTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    av = [[AllValidationsViewController alloc]init];
    mpop =[[MainBord alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{
    if ([title isEqualToString:@"Sort By"]) {
        prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,150,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
        [Vc.view addSubview:prMainView];
        vc1=Vc;
        prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
        if([popUpAr count]>0)
        {
            [popUpAr addObject:prMainView];
        }
        else{
            
            popUpAr =[[NSMutableArray alloc]init];
            [popUpAr addObject:prMainView];
        }
        
        NSLog(@"array of popup  %lu",[popUpAr count]);
        
        NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-70+30, 40+20)];
        NameLabel.text=title;
        NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        NameLabel.textAlignment=NSTextAlignmentCenter;
        NameLabel.layer.cornerRadius=10;
        NameLabel.clipsToBounds = YES;
        [prMainView addSubview:NameLabel];
        
        
        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-15, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
        [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
        scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[colorset valueForKey:@"popupcolor"];
        scrollbar.layer.cornerRadius=10;
        scrollbar.clipsToBounds = YES;

        [prMainView addSubview:scrollbar];
        

    }
    else
    {
        prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
        [Vc.view addSubview:prMainView];
        vc1=Vc;
        prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
        if([popUpAr count]>0)
        {
            [popUpAr addObject:prMainView];
        }
        else{
            
            popUpAr =[[NSMutableArray alloc]init];
            [popUpAr addObject:prMainView];
        }
        
        NSLog(@"array of popup  %lu",[popUpAr count]);
        
        NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, [SavePrefrences sharedInstance ].screenWidth-40, 40+20)];
        NameLabel.text=title;
        NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        NameLabel.textAlignment=NSTextAlignmentCenter;
        NameLabel.layer.cornerRadius=10;
        NameLabel.clipsToBounds = YES;
        [prMainView addSubview:NameLabel];
        
        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
        [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
        scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[colorset valueForKey:@"popupcolor"];
        scrollbar.layer.cornerRadius=10;
        scrollbar.clipsToBounds = YES;
        [prMainView addSubview:scrollbar];
    }

    return prMainView;
}


-(UIView *) MainViewfortable:(UIViewController *)Vc:(NSString *) title
{
    av=[[AllValidationsViewController alloc]init];
    
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    NameLabel1=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-70, 40+20)];
    NameLabel1.text=title;
    NameLabel1.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    NameLabel1.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    NameLabel1.textColor=[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f];
    NameLabel1.textAlignment=NSTextAlignmentCenter;
    NameLabel1.layer.cornerRadius=10;
    NameLabel1.clipsToBounds = YES;
    [prMainView addSubview:NameLabel1];
    
    
    UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel1.frame.size.width+NameLabel1.frame.origin.x-20, [SavePrefrences sharedInstance ].naviHght+15, 30+20, 50)];
    closeView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    closeView.layer.cornerRadius=10;
    closeView.clipsToBounds = YES;

    [prMainView addSubview:closeView];
    
    //here on click row
    UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(22, 2, 25, 25)];
    [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
    cross.userInteractionEnabled=YES;
    [closeView addSubview:cross];
    
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    cross.userInteractionEnabled = YES;
    [cross addGestureRecognizer:communityeg];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    viewfortable=[[UIView alloc]initWithFrame:CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+100))];
    viewfortable.backgroundColor=[ff valueForKey:@"backcolor"];
    viewfortable.layer.cornerRadius=10;
    viewfortable.clipsToBounds = YES;
    [prMainView addSubview:viewfortable];
    
    
    return prMainView;
}

-(UIView *) MainViewwithouttitle:(UIViewController *)Vc
{
    av=[[AllValidationsViewController alloc]init];
    
    NSLog(@"pop ar count in mainview2   %lu",[popUpAr count]);
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//colorWithRed:132.0f/255.0f green:132.0f/255.0f blue:132.0f/255.0f alpha:.5f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 56)];
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    [prMainView addSubview:headerView];
    
    return prMainView;
}





-(void)advanceSearch:(UIViewController *)Vc:(int)advnceID
{
    [self MainView:Vc :@"   Advance Search"];
    float screenWidth=[SavePrefrences sharedInstance].screenWidth;
    float screenHeight=[SavePrefrences sharedInstance].screenHeight;
    int height=35;
    
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    scrollbar.frame=CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+100));
    
    Title=[[UITextField alloc] initWithFrame:CGRectMake(20,NameLabel.frame.size.height+NameLabel.frame.origin.y-90, scrollbar.frame.size.width-11-30,height)];
    Title.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Title.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    Title.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName: color}];

    [Title setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Title.delegate=self;
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    Title.leftView = paddingView;
    Title.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    [scrollbar addSubview:Title];
    
    UITextField *Grade=[[UITextField alloc]initWithFrame:CGRectMake(20,Title.frame.size.height+Title.frame.origin.y+12, scrollbar.frame.size.width-11-30,  height)];
    Grade.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Grade.placeholder=@"Grade";
    Grade.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Grade" attributes:@{NSForegroundColorAttributeName: color}];

    Grade.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    ///////////////
    UIView *paddingView111 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    Grade.leftView = paddingView111;
    Grade.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    Grade.clipsToBounds=YES;
    [Grade setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [scrollbar addSubview:Grade];
    
   /* UITapGestureRecognizer *selgGes = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(selectGrade)];
    [selgGes setNumberOfTouchesRequired:1];
    [selgGes setDelegate:self];
    Grade.userInteractionEnabled = YES;
    [Grade addGestureRecognizer:selgGes];*/
    
    Command_On=[[UITextField alloc]initWithFrame:CGRectMake(20,Grade.frame.size.height+Grade.frame.origin.y+12, scrollbar.frame.size.width-11-30, height)];
    Command_On.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Command_On.tag=0;
    Command_On.layer.borderColor=[[ff valueForKey:@"Videocolor"] CGColor];
    Command_On.placeholder=@"Commented On";
    Command_On.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Commented On" attributes:@{NSForegroundColorAttributeName: color}];

    [Command_On setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Command_On.clipsToBounds=YES;
    ///////////////
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    Command_On.leftView = paddingView1;
    Command_On.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    Command_On.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    [scrollbar addSubview:Command_On];
    
    UITapGestureRecognizer *sharereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [sharereg setNumberOfTouchesRequired:1];
    [sharereg setDelegate:self];
    Command_On.userInteractionEnabled = YES;
    [Command_On addGestureRecognizer:sharereg];
    
    Command_By=[[UITextField alloc]initWithFrame:CGRectMake(20,Command_On.frame.size.height+Command_On.frame.origin.y+12,scrollbar.frame.size.width-11-30, height)];
    Command_By.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Command_By.placeholder=@"Commented By";
    Command_By.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Commented By" attributes:@{NSForegroundColorAttributeName: color}];

    [Command_By setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Command_By.delegate=self;
    Command_By.clipsToBounds=YES;
    ///////////////
    UIView *paddingView12 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    Command_By.leftView = paddingView12;
    Command_By.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    Command_By.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    [scrollbar addSubview:Command_By];
    
    Posted_On=[[UITextField
                alloc]initWithFrame:CGRectMake(20,Command_By.frame.size.height+Command_By.frame.origin.y+12,scrollbar.frame.size.width-11-30, height)];
    Posted_On.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Posted_On.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    Posted_On.placeholder=@"Posted On";
    Posted_On.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Posted On" attributes:@{NSForegroundColorAttributeName: color}];

    [ Posted_On setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Posted_On.tag=1;
    Posted_On.clipsToBounds=YES;
    ///////////////
    UIView *paddingView13 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    Posted_On.leftView = paddingView13;
    Posted_On.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    [scrollbar addSubview: Posted_On];
    
    UITapGestureRecognizer *sharereg1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(date:)];
    [sharereg1 setNumberOfTouchesRequired:1];
    [sharereg1 setDelegate:self];
    Posted_On.userInteractionEnabled = YES;
    [Posted_On addGestureRecognizer:sharereg1];
    
    Board_Posted_By=[[UITextField alloc]initWithFrame:CGRectMake(20,Posted_On.frame.size.height+Posted_On.frame.origin.y+12 , scrollbar.frame.size.width-11-30, height)];
    Board_Posted_By.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Board_Posted_By.placeholder=@"Board Posted By";
    Board_Posted_By.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Board Posted By" attributes:@{NSForegroundColorAttributeName: color}];

    Board_Posted_By.delegate=self;
    Board_Posted_By.clipsToBounds=YES;
    [Board_Posted_By setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////////
    UIView *paddingView14 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    Board_Posted_By.leftView = paddingView14;
    Board_Posted_By.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    Board_Posted_By.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    [scrollbar addSubview:Board_Posted_By];
    
    Select_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20,Board_Posted_By.frame.size.height+Board_Posted_By.frame.origin.y+12, scrollbar.frame.size.width-11-30, height)];
    Select_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Select_Industry.text=@"  Select Industry";
    Select_Industry.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    [Select_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Industry.clipsToBounds=YES;
    [scrollbar addSubview:Select_Industry];
    
    UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(selectInduct)];
    [ind setNumberOfTouchesRequired:1];
    [ind setDelegate:self];
    Select_Industry.userInteractionEnabled = YES;
    [Select_Industry addGestureRecognizer:ind];
    
    Select_Sub_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20,Select_Industry.frame.size.height+Select_Industry.frame.origin.y+12, scrollbar.frame.size.width-11-30,height)];
    Select_Sub_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Select_Sub_Industry.text=@"  Select Sub Industry";
    [ Select_Sub_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Sub_Industry.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    Select_Sub_Industry.clipsToBounds=YES;
    [scrollbar addSubview: Select_Sub_Industry];
    
    UITapGestureRecognizer *ind2 = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self action:@selector(selecSubInd)];
    [ind2 setNumberOfTouchesRequired:1];
    [ind2 setDelegate:self];
    Select_Sub_Industry.userInteractionEnabled = YES;
    Select_Sub_Industry.tag=[indid intValue];
    [Select_Sub_Industry addGestureRecognizer:ind2];
    
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame=CGRectMake(35,Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+15, scrollbar.frame.size.width/2-40, 35);
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [submit setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [submit addTarget:self
               action:@selector(advanceSearchDetails:)forControlEvents:UIControlEventTouchUpInside];
    if(advnceID==0)
    {
        submit.tag=0;
    }
    else if(advnceID==1)
    {
        submit.tag=1;
    }
    else if(advnceID==2)
    {
        submit.tag=2;
    }
    submit.backgroundColor=[ff valueForKey:@"clearColor"];
    [scrollbar addSubview:submit];
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake(submit.frame.size.width+submit.frame.origin.x+15,Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+15,
                           scrollbar.frame.size.width/2-40, 35);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancelIt:)
    forControlEvents:UIControlEventTouchUpInside];
    
    close.backgroundColor=[ff valueForKey:@"clearColor"];
    
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, 30);
    
}
-(IBAction)cancelIt:(id)sender
{
    
    [self dissmisspop1];
    
}

- (NSString*)getSortKey{
    NSString* sortKey = [[NSUserDefaults standardUserDefaults] valueForKey:@"BOARD_SORT_KEY"];
    if (!sortKey.length) sortKey = @"1";
    return sortKey;
}

-(void)dissmisspop1
{
    int cnt=(int)[popUpAr count]-1;
    NSLog(@"pop ar count===%d",cnt);
    
    if([popUpAr count]>0)
    {
        UIView *ppv=[popUpAr objectAtIndex:cnt] ;
        [ppv removeFromSuperview];
        [popUpAr removeObjectAtIndex:cnt];
        
    }
    if([popUpAr count]==0)
    {
        id<CallTo_Parent>  cb= vc1;
        [cb callMethod:nil];
        
    }
}


-(IBAction)advanceSearchDetails:(id)sender{
    UIButton *btn=(UIButton*)sender;
    
    av=[[AllValidationsViewController alloc]init];
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc] init];
    
    if(Title.text==NULL || Command_On.text==NULL || Command_By.text==NULL || Posted_On.text==NULL || Board_Posted_By.text==NULL){
        isempty=1;
    }else{
        isempty=0;
    }
    
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    if (Title.text.length) [dic1 setObject:Title.text forKey:@"key"];
    if (Command_On.text.length) [dic1 setObject:Command_On.text forKey:@"cmntOn"];
    if (Command_By.text.length) [dic1 setObject:Command_By.text forKey:@"cmntdby"];
    if (Posted_On.text.length) [dic1 setObject:Posted_On.text forKey:@"postedon"];
    if (Board_Posted_By.text.length) [dic1 setObject:Board_Posted_By.text forKey:@"postedby"];
    if(Grade.text.length) [dic1 setObject:Grade.text forKey:@"postedby"];
    
    
    if([isselect isEqual:@"selected"]){
        [dic1 setObject:indid forKey:@"indus"];
        [dic1 setObject:subid forKey:@"topics"];
    }else{
        [dic1 setObject:@"" forKey:@"indus"];
        [dic1 setObject:@"" forKey:@"topics"];
    }
    
    [dic1 setObject:[self getSortKey] forKey:@"val"];
    
    if((int)btn.tag==0){
        iscallback=8;
        NSLog(@"board view callback");
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"advncSrchMyBd" :@"":@"":dic1 :self];
    }else if((int)btn.tag==1){
        iscallback=9;
        [[SavePrefrences sharedInstance].skthand emitData:@"SharedBoard" :@"advShareSrch" :@"":@"":dic1 :self];
    }else if((int)btn.tag==2){
        iscallback=10;
        [[SavePrefrences sharedInstance].skthand emitData:@"ComnBoard" :@"advnceSrchAll" :@"":@"":dic1 :self];
    }
}


-(void)addnewBoard:(UIViewController *)Vc
{
    [self MainView:Vc :@"   Add New Board"];
    
    
    scrollbar.frame=CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, 400);
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    
    title=[[UITextField alloc]initWithFrame:CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y-90,scrollbar.frame.size.width-11-30, 30)];
    title.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    title.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    title.clipsToBounds=YES;
    title.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName: color}];
    [title setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    title.delegate=self;
    ///////////////
    UIView *paddingView14 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    title.leftView = paddingView14;
    title.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    [scrollbar addSubview:title];
    
    
    UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(20, title.frame.size.height+title.frame.origin.y+15, scrollbar.frame.size.width-10-30, scrollbar.frame.size.height-(title.frame.size.height+title.frame.origin.y+180))];
    descriptionView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];

    [scrollbar addSubview:descriptionView];
    
    //78:119:145
    ques_lbl=[[UILabel alloc]initWithFrame:CGRectMake(1, 3,  descriptionView.frame.size.width-10, 20)];
    ques_lbl.text=@"  Question?";
    [ques_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ques_lbl.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    ques_lbl.backgroundColor=[UIColor clearColor];
    [descriptionView addSubview:ques_lbl];
    
    question=[[UITextView alloc]initWithFrame:CGRectMake(3, 0,  descriptionView.frame.size.width-10,descriptionView.frame.size.height)];
    question.clipsToBounds=YES;
    question.delegate=self;
    question.tag=222;
    question.backgroundColor=[UIColor clearColor];
    question.textColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0f];
    
    [descriptionView addSubview:question];

    
    
    Select_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20, descriptionView.frame.origin.y+descriptionView.frame.size.height+15, scrollbar.frame.size.width-10-30, 30)];
    Select_Industry.text=@"  Select Industry";
    Select_Industry.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    [Select_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Select_Industry.clipsToBounds=YES;
    [scrollbar addSubview:Select_Industry];
    
    UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInduct)];
    [ind setNumberOfTouchesRequired:1];
    [ind setDelegate:self];
    Select_Industry.userInteractionEnabled = YES;
    [Select_Industry addGestureRecognizer:ind];
    
    
    Select_Sub_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20, Select_Industry.frame.origin.y+Select_Industry.frame.size.height+15, scrollbar.frame.size.width-10-30, 30)];
    Select_Sub_Industry.text=@"  Select Sub Industry";
    [Select_Sub_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Sub_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Select_Sub_Industry.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    Select_Sub_Industry.clipsToBounds=YES;
    [scrollbar addSubview:Select_Sub_Industry];
    
    UITapGestureRecognizer *ind1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecSubInd)];
    [ind1 setNumberOfTouchesRequired:1];
    [ind1 setDelegate:self];
    Select_Sub_Industry.userInteractionEnabled = YES;
    [Select_Sub_Industry addGestureRecognizer:ind1];
    
    
//    publicAr=[[NSMutableArray alloc]init];
//    [publicAr addObject:@"Public"];
//    [publicAr addObject:@"Private"];
//    [publicAr addObject:@"Friend"];
//    
//    int widx=scrollbar.frame.size.width/3 ;
//    int lx=5;
//    int settag=0;
//    for(int x=0; x<[publicAr count];x++)
//    {
//        UIButton *public_btn =[[UIButton alloc]initWithFrame:CGRectMake(lx, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+10, 15, 15)];
//        public_btn.layer.cornerRadius=7.5;
//        public_btn.backgroundColor=[UIColor whiteColor];
//        [public_btn addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
//        [public_btn setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
//        public_btn.tag=settag;
//        [scrollbar addSubview:public_btn];
//        
//        public=[[UILabel alloc]initWithFrame:CGRectMake(public_btn.frame.origin.x+public_btn.frame.size.width+2, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+5,widx-10, 25)];
//        public.text=[publicAr objectAtIndex:x];
//        public.textColor=[UIColor blackColor];
//        [scrollbar addSubview:public];
//        
//        lx=lx+widx;
//        settag++;
//    }
//    
//    publicview=[[UIView alloc]initWithFrame:CGRectMake(5, public.frame.size.width+public.frame.origin.y-60, screenWidth-20,30)];
//    [scrollbar addSubview:publicview];
//    publicview.hidden=true;
//    publicview.backgroundColor=[UIColor clearColor];
//    
//    NSMutableArray * memberAr=[[NSMutableArray alloc]init];
//    [memberAr addObject:@"Cabinet Members"];
//    [memberAr addObject:@"Network Members"];
//    int incfx=5,brdx=(scrollbar.frame.size.width/2);
//    for(int i=0;i<[memberAr count];i++)
//    {
//        UIButton *cb_btn =[[UIButton alloc]initWithFrame:CGRectMake(incfx, 2, 15, 15)];
//        cb_btn.layer.cornerRadius=7.5;
//        cb_btn.backgroundColor=[UIColor whiteColor];
//        [cb_btn addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
//        [cb_btn setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
//        cb_btn.tag=10+i;
//        [publicview addSubview:cb_btn];
//        
//        UILabel *cabinet=[[UILabel alloc]initWithFrame:CGRectMake(cb_btn.frame.size.width+cb_btn.frame.origin.x+5, 0 ,brdx-18, 20)];
//        cabinet.text=[memberAr objectAtIndex:i];
//        cabinet.textColor=[UIColor blackColor];
//        [cabinet setFont:[UIFont fontWithName:@"Times New Roman" size:14]];
//        cabinet.backgroundColor=[UIColor clearColor];
//        [publicview addSubview:cabinet];
//        
//        incfx=brdx+incfx;
//        
//    }
    
    UIButton *save=[[UIButton alloc]initWithFrame:CGRectMake(35, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+20, scrollbar.frame.size.width/2 -40, 35)];
    save.backgroundColor=[ff valueForKey:@"clearColor"];
    [save setTitle:@"Save" forState:UIControlStateNormal];
    [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [save addTarget:self action:@selector(savingDetails:) forControlEvents:UIControlEventTouchUpInside];
    [save setClipsToBounds:YES];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [scrollbar addSubview:save];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+15, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+20, scrollbar.frame.size.width/2 -40, 35)];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    close.backgroundColor=[ff valueForKey:@"clearColor"];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [close setClipsToBounds:YES];
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, close.frame.size.height+close.frame.origin.y);
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if(textView.tag==11111)
    {
        [cmnt setHidden:YES];
    }
    if(textView.tag==222)
    {
        [ques_lbl setHidden:YES];
    }

}
-(void)privateView:(UIViewController*)Vc
{
    manag=[[ManageArray alloc]init];
    
    [self MainView:Vc :@"   User Search"];
    inViteFrAr=[[NSMutableArray alloc]init];
    scrollbar.frame=CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, 0);
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    float screenWidth=[SavePrefrences sharedInstance].screenWidth;
    float screenHeight=[SavePrefrences sharedInstance].screenHeight;
    
    UIView *main_view_private=[[UIView alloc] initWithFrame:CGRectMake(20,NameLabel.frame.size.height+NameLabel.frame.origin.y, prMainView.frame.size.width-40, screenHeight-150)];
    main_view_private.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[ff valueForKey:@"popupcolor"];
    [prMainView addSubview:main_view_private];
    
    UILabel *Proyolk_Friends=[[UILabel alloc] initWithFrame:CGRectMake(5,5,main_view_private.frame.size.width/3+20, 30)];
    
    Proyolk_Friends.text=@"Proyolk Friends";
    [Proyolk_Friends setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Proyolk_Friends.textColor=[UIColor blackColor];
    Proyolk_Friends.backgroundColor=[ff valueForKey:@"popupcolor"];
    [main_view_private addSubview:Proyolk_Friends];
    
    UILabel *bar_frnd=[[UILabel alloc] initWithFrame:CGRectMake(0, Proyolk_Friends.frame.size.height+Proyolk_Friends.frame.origin.y,main_view_private.frame.size.width/3+20, 5)];
    bar_frnd.backgroundColor=[ff valueForKey:@"clearColor"];
    [main_view_private addSubview: bar_frnd];
    
    search=[[UITextField alloc] initWithFrame:CGRectMake(5, bar_frnd.frame.size.height+bar_frnd.frame.origin.y+2, main_view_private.frame.size.width/2+20, 25)];
   // search.placeholder=@"Search Name...";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    search.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search Name..." attributes:@{NSForegroundColorAttributeName: color}];

    search.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search.leftView = paddingView;
    search.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    [main_view_private addSubview:search];
    
    UIButton *Search_btn=[[UIButton alloc]initWithFrame:CGRectMake(search.frame.size.width+search.frame.origin.x+5,bar_frnd.frame.size.height+bar_frnd.frame.origin.y+2,main_view_private.frame.size.width/2-50,25)];
    [Search_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Search_btn.backgroundColor=[ff valueForKey:@"clearColor"];
    //[Search setTitle:@"Search" forState:UIControlStateNormal];
    [search setBackground:[UIImage imageNamed:@"search.png"]];
    [Search_btn addTarget:self action:@selector(searchFriends:) forControlEvents:UIControlEventTouchUpInside];
    [Search_btn setClipsToBounds:YES];
    [main_view_private addSubview:Search_btn];
    
    inviteTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, Search_btn.frame.size.height+Search_btn.frame.origin.y+10,main_view_private.frame.size.width-20,main_view_private.frame.size.height-80)];
    inviteTableView.delegate = self;
    inviteTableView.dataSource = self;
    inviteTableView.scrollEnabled = YES;
    inviteTableView.backgroundColor=[UIColor clearColor];//colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[ff valueForKey:@"clearColor"];
   // inviteTableView.separatorColor=[ff valueForKey:@"popupcolor"];
    [main_view_private addSubview:inviteTableView];
    

}

-(void)sortby:(UIViewController*)Vc:(int)sortID
{
    [self MainView:Vc :@"Sort By"];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y, scrollbar.frame.size.width, 100 );
    
    scrollbar.scrollEnabled=NO;
    NSMutableArray *sortAr=[[NSMutableArray alloc]init];
    [sortAr addObject:@"Comment"];
    [sortAr addObject:@"Post"];
    [sortAr addObject:@"Most Active"];
    
    int hy=scrollbar.frame.size.width+scrollbar.frame.origin.x-350;
    for(int x=0;x<[sortAr count];x++ )
    {
        
        UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(hy+10, 8, NameLabel.frame.size.width/3, 30)];
        descriptionView.backgroundColor=[UIColor clearColor];
        [scrollbar addSubview:descriptionView];

        UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(0,5, 15,  15)];
        img.layer.cornerRadius=7.5;
        [img addTarget:self action:@selector(SelectSort:) forControlEvents: UIControlEventTouchUpInside];
        [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        if(x==(issort-1))
        {
            sender1=img;
            [img setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        img.tag=x;
        [descriptionView addSubview:img];

        
        comment_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 25)];
        [comment_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        comment_lbl.textColor=[UIColor colorWithRed:183.0f/255.0f green:182.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
        comment_lbl.text=[sortAr objectAtIndex: x];
        [descriptionView addSubview:comment_lbl];
        
        hy=hy+100;
        
    }
    int w=scrollbar.frame.size.width;
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake(w/2-w/4, comment_lbl.frame.size.height+comment_lbl.frame.origin.y+20, 80, 35)];
    submit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    submit.backgroundColor=[ff valueForKey:@"clearColor"];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitSortby:) forControlEvents:UIControlEventTouchUpInside];
    if(sortID==0)
    {
        submit.tag=0;
    }
    else if(sortID==1)
    {
        submit.tag=1;
    }
    else if(sortID==2)
    {
        submit.tag=2;
    }
    [submit setClipsToBounds:YES];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:submit];
    
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake(submit.frame.size.width+submit.frame.origin.x+15,comment_lbl.frame.size.height+comment_lbl.frame.origin.y+20, 80, 35);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancelIt:) forControlEvents:UIControlEventTouchUpInside];
    close.backgroundColor=[ff valueForKey:@"clearColor"];
    [scrollbar addSubview:close];
    
  //  scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, 300);
    
    
    
}

-(IBAction)SelectSort:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    issort=(int)btn.tag;
    
    if(issort==0||issort==1||issort==2)
    {
        [sender1 setImage:[UIImage imageNamed:@"radiounselect.png"]forState:UIControlStateNormal];
        sender1=sender;
        [sender setImage:[UIImage imageNamed:@"radioselect.png"]forState:UIControlStateNormal];
    }
}


-(void)calMem:(UIViewController *) Vc:(NSArray*)calAr
{
    inviteAr=calAr;
    [self privateView:Vc];
    
}

-(void)IndustrySearch:(UIViewController*)Vc:(int)indusId:(int)limit1
{
    
    limit=limit1;
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    NSLog(@"inside industry search");
    [self MainView:Vc :@"   Industry Search"];
    float screenWidth=[SavePrefrences sharedInstance].screenWidth;
    
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y-20, scrollbar.frame.size.width, 200 );
    
    
    Select_Industry=[[UILabel alloc]initWithFrame:CGRectMake(10, NameLabel.frame.size.height+NameLabel.frame.origin.y-80, screenWidth-60, 35)];
    Select_Industry.text=@"  Select Industry";
    Select_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Select_Industry.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [Select_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Industry.clipsToBounds=YES;
    [scrollbar addSubview:Select_Industry];
    
    UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInduct)];
    [ind setNumberOfTouchesRequired:1];
    [ind setDelegate:self];
    Select_Industry.userInteractionEnabled = YES;
    [Select_Industry addGestureRecognizer:ind];
    
    Select_Sub_Industry=[[UILabel alloc]initWithFrame:CGRectMake(10, Select_Industry.frame.size.height+Select_Industry.frame.origin.y+20, screenWidth-60, 35)];
    Select_Sub_Industry.text=@"  Select Sub Industry";
    [Select_Sub_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Sub_Industry.clipsToBounds=YES;
    Select_Sub_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    Select_Sub_Industry.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    [scrollbar addSubview:Select_Sub_Industry];
    
    
    UITapGestureRecognizer *ind2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecSubInd)];
    [ind2 setNumberOfTouchesRequired:1];
    [ind2 setDelegate:self];
    Select_Sub_Industry.userInteractionEnabled = YES;
    Select_Sub_Industry.tag=[indid intValue];
    [Select_Sub_Industry addGestureRecognizer:ind2];
    
    
    Search=[[UIButton alloc]initWithFrame:CGRectMake(35, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+20, scrollbar.frame.size.width/2-40, 35)];
    [Search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Search.backgroundColor=[ff valueForKey:@"clearColor"];
    //[Search setTitle:@"Search" forState:UIControlStateNormal];
    [search setBackground:[UIImage imageNamed:@"search.png"]];
    [Search addTarget:self action:@selector(SearchByIndus:) forControlEvents:UIControlEventTouchUpInside];
    if(indusId==0)
    {
        Search.tag=0;
    }
    else if(indusId==1)
    {
        Search.tag=1;
    }
    else if (indusId==10)
    {
        Search.tag=2;
    }
    else if (indusId==11)
    {
        Search.tag=3;
    }
    else if (indusId==13)
    {
        Search.tag=4;
    }
    else if(indusId==100)
    {
        Search.tag=5;
    }
    else if(indusId==101)
    {
        Search.tag=6;
    }
    
    else if(indusId==103)
    {
        Search.tag=7;
    }
    else if(indusId==104)
    {
        Search.tag=8;
    }
    else if(indusId==105)
    {
        Search.tag=9;
    }
    else if (indusId==20)
    {
        Search.tag=10;
    }
    
    [Search setClipsToBounds:YES];
    [Search setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [scrollbar addSubview:Search];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(Search.frame.size.width+Search.frame.origin.x+5, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+20, scrollbar.frame.size.width/2-40, 35)];
    [close setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
    close.backgroundColor=[ff valueForKey:@"clearColor"];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [close addTarget:self action:@selector(cancelIt:) forControlEvents:UIControlEventTouchUpInside];
    [close setClipsToBounds:YES];
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, scrollbar.frame.size.height-600);
    
    
    
}

-(IBAction)SearchByIndus:(id)sender
{
    UIButton *btn=(UIButton*)sender;

    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    
    av=[[AllValidationsViewController alloc]init];
    if([av checkCombo:Select_Industry])
    {
        if([av checkCombo:Select_Sub_Industry])
        {
         [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
         [dic1 setObject:indid forKey:@"myind"];
         [dic1 setObject:subid forKey:@"mydep"];
        
    
    if((int)btn.tag==0)
    {
        iscallback=6;
      [[SavePrefrences sharedInstance].skthand emitData:@"SharedBoard" :@"srchShareBoard" :@"":@"":dic1 :self];
   
    }
    else if((int)btn.tag==1)
    {
        iscallback=7;
        [[SavePrefrences sharedInstance].skthand emitData:@"ComnBoard" :@"srchAllBoard" :@"":@"":dic1 :self];
        
    }
    else if ((int)btn.tag==2)
    {
        
        iscallback=11;
        [[SavePrefrences sharedInstance].skthand emitData:@"SearchPod" :@"searchPod" :@"":@"":dic1 :self];
        
    }
    else if ((int)btn.tag==3)
    {
        
        NSLog(@"recent pod industry search");
        
        iscallback=12;
        [[SavePrefrences sharedInstance].skthand emitData:@"RecentPod" :@"searchPodrecent" :@"":@"":dic1 :self];
        
    }
    else if ((int)btn.tag==4)
    {
        
        iscallback=17;
        
        
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podsrch" :@"":@"":dic1 :self];
        
    }
    
    else if ((int)btn.tag==5)
    {
        
        
        NSLog(@"im mherereree");
        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
        [dic2 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic2 setValue:indid forKey:@"ind"];
        [dic2 setValue:subid forKey:@"top"];
        [dic2 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
        [dic2 setValue:@"" forKey:@"key"];
        
        
        iscallback=18;
        
        
        [[SavePrefrences sharedInstance].skthand emitData:@"AppliedJobs" :@"srchopenJobs" :@"":@"":dic2 :self];
        
    }
    
    else if ((int)btn.tag==6)
    {
        
        iscallback=19;
        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
        [dic2 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic2 setValue:indid forKey:@"ind"];
        [dic2 setValue:subid forKey:@"top"];
         [dic2 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
        [dic2 setValue:@"" forKey:@"key"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"AwardJobs" :@"srchappliedJobs" :@"":@"":dic2 :self];
        
    }
    
    else if ((int)btn.tag==7)
    {
        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
        [dic2 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic2 setValue:indid forKey:@"ind"];
         [dic2 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
        [dic2 setValue:subid forKey:@"top"];
        [dic2 setValue:@"" forKey:@"key"];
        
        iscallback=20;//shared pod industry
        [[SavePrefrences sharedInstance].skthand emitData:@"SharedPod" :@"shrdSrch" :@"":@"":dic2 :self];
    }
    else if ((int)btn.tag==8)
    {
        iscallback=27;
        
        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
        [dic2 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic2 setValue:indid forKey:@"ind"];
         [dic2 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
        [dic2 setValue:subid forKey:@"top"];
        [dic2 setValue:@"" forKey:@"key"];

        [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"srchpstdJobs" :@"":@"":dic2 :self];
    }
    else if ((int)btn.tag==9)
    {
        
        iscallback=28;
        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
        [dic2 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic2 setValue:indid forKey:@"ind"];
        [dic2 setValue:subid forKey:@"top"];
         [dic2 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
        [dic2 setValue:@"" forKey:@"key"];

      [[SavePrefrences sharedInstance].skthand emitData:@"AllProjects" :@"srchAllJobs" :@"":@"":dic2 :self];
    }
    else if ((int)btn.tag==10)
    {
        iscallback=31;
        
        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
        [dic2 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic2 setValue:indid forKey:@"ind"];
         [dic2 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
        [dic2 setValue:subid forKey:@"top"];
        [dic2 setValue:@"" forKey:@"key"];
      [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"srchMyBoard" :@"":@"":dic2 :self];
    }
    }
    }
}



-(void)showcommentView:(UIViewController*)Vc:(int)b_id1:(int)whichBoard:(int)kid1
{
    
    chkboard=whichBoard;
    vc1=Vc;
    iscallback=0;
    b_id=b_id1 ;
    kid=kid1;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%d",b_id] forKey:@"id"];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getBoardQues" :@"":@"":dic :self];
    
    
}

-(void)showCommntView:(NSArray *) cmntAr:(NSArray *)meta
{
    
    [self MainViewwithouttitle:vc1];
    NSLog(@"inside show kiddd view  %d",kid);
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 50, 25)];
    [bckarrow setImage:[UIImage imageNamed:@"back1.png"]];
    bckarrow.userInteractionEnabled=YES;
    [headerView addSubview:bckarrow];
    
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoBack)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    bckarrow.userInteractionEnabled = YES;
    [bckarrow addGestureRecognizer:communityeg];
    
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.size.width/2-headerView.frame.size.width/3.5,5,headerView.frame.size.width/2-20, 50)];
    [logo setCenter:CGPointMake(headerView.center.x, logo.center.y)];
    [logo setContentMode:UIViewContentModeScaleAspectFit];
    [logo setImage:[UIImage imageNamed:@"logo_new.png"]];
    [headerView addSubview:logo];
    
    share=[[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.size.width-100, 10, 20, 20)];
    [share setImage:[UIImage imageNamed:@"share.png"]];
    [headerView addSubview:share];
    
    UITapGestureRecognizer *sharereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareit:)];
    [sharereg setNumberOfTouchesRequired:1];
    [sharereg setDelegate:self];
    share.userInteractionEnabled = YES;
    [share addGestureRecognizer:sharereg];
    
    comment=[[UIImageView alloc] initWithFrame:CGRectMake(share.frame.size.width+share.frame.origin.x+8, 6, 30, 30)];
    [comment setImage:[UIImage imageNamed:@"comment.png"]];
    [headerView addSubview:comment];
    
    UITapGestureRecognizer *cmntreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Comment)];
    [cmntreg setNumberOfTouchesRequired:1];
    [cmntreg setDelegate:self];
    comment.userInteractionEnabled = YES;
    [comment addGestureRecognizer:cmntreg];

    //advance-search.png
    shareuser=[[UIImageView alloc] initWithFrame:CGRectMake(comment.frame.size.width+comment.frame.origin.x+3, 10, 20, 20)];
    [shareuser setImage:[UIImage imageNamed:@"shareuser.png"]];
    [headerView addSubview:shareuser];
    
    UITapGestureRecognizer *cmntshareuser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openShareUser)];
    [cmntshareuser setNumberOfTouchesRequired:1];
    [cmntshareuser setDelegate:self];
    shareuser.userInteractionEnabled = YES;
    [shareuser addGestureRecognizer:cmntshareuser];

    
    
    UIView * commentMain=[[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y, prMainView.frame.size.width, prMainView.frame.size.height)];
    commentMain.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    [prMainView addSubview:commentMain];
    
    NSString * ques=[[quesAr objectAtIndex:0] valueForKey:@"question"];
    NSString * title=[[quesAr objectAtIndex:0] valueForKey:@"title"];
    NSString * bid=[[quesAr objectAtIndex:0] valueForKey:@"b_id"];
    NSString *userId=[[quesAr objectAtIndex:0]valueForKey:@"u_id"];
    
    
    UILabel *TitleComment=[[UILabel alloc] initWithFrame:CGRectMake(5, headerView.frame.size.height+headerView.frame.origin.y-40,commentMain.frame.size.width-10, 25)];
    TitleComment.textColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    if([av checkNullStr:title])
    {
        TitleComment.text=title;
    }
    [TitleComment setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [commentMain addSubview:TitleComment];
    
    UILabel *gap=[[UILabel alloc] initWithFrame:CGRectMake(5, TitleComment.frame.size.height+TitleComment.frame.origin.y, commentMain.frame.size.width-10, 1)];
    gap.backgroundColor=[UIColor grayColor];
    [commentMain addSubview:gap];
    
    UITextView *boardText=[[UITextView alloc] initWithFrame:CGRectMake(5, gap.frame.size.height+gap.frame.origin.y+5, commentMain.frame.size.width-10, 100)];
    boardText.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    boardText.textColor=[UIColor colorWithRed:128.0f/255 green:128.0f/255 blue:128.0f/255 alpha:1.0f];
    boardText.editable=NO;
    if([av checkNullStr:ques])
    {
        boardText.text=ques;
    }
    //boardText.allowsEditingTextAttributes=NO;
   // [boardText setUserInteractionEnabled:NO];
   // boardText.scrollEnabled=YES;
    [boardText setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [commentMain addSubview:boardText];
    
    
     NSLog(@"%@",metaBrd);
    
    NSDictionary *data = [metaBrd valueForKey:@"data"];
    data = [[data valueForKey:@"getshbd"] firstObject];
    if(data.count){
    if(![data[@"status"]boolValue]){
        titlebtn = @"APPLIED";
    }else{
        titlebtn = @"APPLY";
    }
    }else{
         titlebtn = @"APPLY";
    }
    apply=[[UIButton alloc]initWithFrame:CGRectMake([SavePrefrences sharedInstance].screenWidth/2+90, 5, 80, 35)];
    [apply setTitle: titlebtn forState: UIControlStateNormal];
    apply.userInteractionEnabled=YES;
    [apply setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
   
    apply.backgroundColor=[UIColor clearColor];
    [apply setTitleColor:[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    apply.tag=[bid intValue];
    [apply setClipsToBounds:YES];
    if(chkboard==0 || chkboard==1)
    {
        apply.hidden=true;
    }
    else{
        if([[SavePrefrences sharedInstance].uid intValue]==[userId intValue])
        {
            apply.hidden=true;
        }
        else
        {
            apply.hidden=false;
        }
    }
    [apply addTarget:self action:@selector(applyBoard:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:apply];
    
    UILabel *lblCommLine = [[UILabel alloc] initWithFrame:CGRectMake(5, boardText.frame.size.height+boardText.frame.origin.y+15,commentMain.frame.size.width-10, 1.2)];
    lblCommLine.backgroundColor=[UIColor colorWithRed:49.0f/255 green:61.0f/255 blue:77.0f/255 alpha:1.0f];
    [commentMain addSubview:lblCommLine];

    int widd=commentMain.frame.size.width;
    int widdd=widd/3.5;
    UILabel *lblComm = [[UILabel alloc] initWithFrame:CGRectMake(widd/2-widdd/2, boardText.frame.size.height+boardText.frame.origin.y,widd/3.5, 30)];
    lblComm.text=@"Comments";
    lblComm.textAlignment=NSTextAlignmentCenter;
    lblComm.textColor=[UIColor colorWithRed:0.0f/255 green:0.0f/255 blue:0.0f/255 alpha:1.0f];
    lblComm.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    [commentMain addSubview:lblComm];

    
    commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, lblComm.frame.size.height+lblComm.frame.origin.y,commentMain.frame.size.width-10,commentMain.frame.size.height-(boardText.frame.size.height+boardText.frame.origin.y+125))];
    commentTableView.delegate = self;
    commentTableView.dataSource = self;
    commentTableView.scrollEnabled = YES;
    commentTableView.backgroundColor=[UIColor clearColor];
    commentTableView.separatorColor=[UIColor clearColor];
    
    [commentMain addSubview:commentTableView];
    
    
    if(kid==1)
    {
        share.hidden=true;
        shareuser.hidden=true;
      //  comment11.hidden=false;
        comment.frame=CGRectMake(self.view.frame.size.width-40, 6, 30, 30);

    }
    
    
    if(kid==2)
    {
        share.hidden=true;
        comment.hidden=true;
        shareuser.hidden=true;

        NSLog(@"inside show comment view  %@",meta);
        NSArray *data=[meta valueForKey:@"data"];
        NSArray *getBoardShared =[data valueForKey:@"getBoardShared"];
        NSArray *getshbd = [data valueForKey:@"getshbd"];
        /*
         //   comment.frame=CGRectMake(self.view.frame.size.width-40, 6, 30, 30);
         comment11.hidden=false;

         */
        
        NSLog(@"inside  shateddd=========%@",getBoardShared);
        NSLog(@"inside  getShared=========%@",getshbd);
        
        int shared=0,status=0;
        
        for(int x=0;x<[getBoardShared count];x++)
        {
            shared=[[[getBoardShared objectAtIndex:x] valueForKey:@"shared"] intValue];
        }
        
        for(int x=0;x<[getshbd count];x++)
        {
            status=[[[getshbd objectAtIndex:x] valueForKey:@"status"] intValue];
        }
        
        if([[SavePrefrences sharedInstance].uid intValue]==[userId intValue])
        {
            apply.hidden=true;
        }
        else
        {
            
            if(shared==1)
            {
                //gray
                apply.userInteractionEnabled=false;
                [apply setTitle: titlebtn forState: UIControlStateNormal];
                comment.hidden=true;
                shareuser.hidden=true;

            }
            else
            {
                apply.hidden=false;
                
                
            }
        }
        
        if([getshbd count]>0)
        {
            if(status==1)
            {
                apply.hidden=true;
                comment.hidden=false;
                share.hidden=true;
                shareuser.hidden=true;
                comment.frame=CGRectMake(self.view.frame.size.width-44, 6, 30, 30);

            }
        }

    }
   
    if([[SavePrefrences sharedInstance].uid intValue]==[userId intValue])
    {
        comment.hidden=false;
        share.hidden=false;
        shareuser.hidden=false;
      //  comment.frame=CGRectMake(self.view.frame.size.width-40, 6, 30, 30);
    }
    
    
    
}
-(IBAction)applyBoard:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    //[self ShowApplyBoard :vc1:(int)btn.tag];
    int brdid=(int)btn.tag;
    iscallback=29;
  //  if([av checkNulltextview:Message])
      {
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",brdid] forKey:@"bdid"];
        //[dic1 setObject:Message.text forKey:@"title"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"ComnBoard" :@"applyBoard" :@"":@"":dic1 :self];
        [prMainView removeFromSuperview];
    }
}

//-(void)ShowApplyBoard:(UIViewController*)Vc:(int)BoardId
//{
//    
//    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
//    
//    [self MainView:Vc :@"Apply Board"];
//    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y,scrollbar.frame.size.width, 200 );
//    UILabel *type_msg=[[UILabel alloc]initWithFrame:CGRectMake(20, (NameLabel.frame.size.height+NameLabel.frame.origin.y)-110, scrollbar.frame.size.width-40, 35)];
//    type_msg.text=@"Type Your Message Here";
//    [type_msg setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
//    type_msg.textColor=[UIColor blackColor];
//    [scrollbar addSubview:type_msg];
//    
//    Message=[[UITextView alloc]initWithFrame:CGRectMake(20, type_msg.frame.size.height+type_msg.frame.origin.y+10, scrollbar.frame.size.width-40, 80)];
//    Message.backgroundColor=[UIColor whiteColor];
//    Message.layer.borderWidth=2;
//    [Message setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
//    Message.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
//    Message.layer.cornerRadius=6;
//    Message.delegate=self;
//    [scrollbar addSubview:Message];
//    
//    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake(20, Message.frame.size.height+Message.frame.origin.y+10, scrollbar.frame.size.width/2-40, 30)];
//    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
//    submit.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
//    [submit setTitle:@"Submit" forState:UIControlStateNormal];
//    [submit addTarget:self action:@selector(submitMessage:) forControlEvents:UIControlEventTouchUpInside];
//    submit.layer.cornerRadius=6;
//    submit.tag=BoardId;
//    [submit setClipsToBounds:YES];
//    [scrollbar addSubview:submit];
//    
//    
//    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    close.frame=CGRectMake(scrollbar.frame.size.width/2+20,Message.frame.size.height+Message.frame.origin.y+10, scrollbar.frame.size.width/2-40, 30);
//    [close setTitle:@"Close" forState:UIControlStateNormal];
//    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
//    [close setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
//    close.layer.cornerRadius=6;
//    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
//    close.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];;
//    [scrollbar addSubview:close];
//    
//    
//    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width,scrollbar.frame.size.height-500);
//}
//-(IBAction)submitMessage:(id)sender
//{
//    UIButton * btn=(UIButton*)sender;
//    int brdid=(int)btn.tag;
//    iscallback=29;
//    if([av checkNulltextview:Message])
//    {
//        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//        [dic1 setObject:[NSString stringWithFormat:@"%d",brdid] forKey:@"bdid"];
//        [dic1 setObject:Message.text forKey:@"title"];
//        
//        [[SavePrefrences sharedInstance].skthand emitData:@"ComnBoard" :@"applyBoard" :@"":@"":dic1 :self];
//        [prMainView removeFromSuperview];
//    }
//}
-(void)dismiss
{
    mainView1.hidden=YES;
}

#pragma mark BOARD USER LIST

-(void)openShareUser
{
    //here right menu
    
    mainView1 = [[UIView alloc] initWithFrame:CGRectMake(0,0,prMainView.frame.size.width, prMainView.frame.size.height)];
    mainView1.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.1f];
    [prMainView addSubview:mainView1];
    
    UITapGestureRecognizer *addrightges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [addrightges setNumberOfTouchesRequired:1];
    [addrightges setDelegate:self];
    mainView1.userInteractionEnabled = YES;
    [mainView1 addGestureRecognizer:addrightges];

    UIView *SubView = [[UIView alloc] initWithFrame:CGRectMake(prMainView.frame.size.width/2-30,headerView.frame.size.height+headerView.frame.origin.y,prMainView.frame.size.width/2+60, prMainView.frame.size.height)];
    SubView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [mainView1 addSubview:SubView];
    
    /////////////
    
    UIView *SubViewTop = [[UIView alloc] initWithFrame:CGRectMake(0,0, SubView.frame.size.width, SubView.frame.size.height/2-headerView.frame.size.height)];
    SubViewTop.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [SubView addSubview:SubViewTop];
    
    UILabel *lblTop = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SubViewTop.frame.size.width, 40)];
    lblTop.backgroundColor=[UIColor colorWithRed:244.0f/255 green:236.0f/255 blue:197.0f/255 alpha:1.0f];
    lblTop.text=@"  Share Users";
    lblTop.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [SubViewTop addSubview:lblTop];

    shareUsersTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SubViewTop.frame.size.width, SubViewTop.frame.size.height-40)];
    [shareUsersTable setDataSource:self];
    [shareUsersTable setDelegate:self];
    [shareUsersTable setBackgroundColor:[UIColor clearColor]];
    [shareUsersTable setTableFooterView:[UIView new]];
    [SubViewTop addSubview:shareUsersTable];
    ////////////////////
    
   // UIView *SubViewBottom = [[UIView alloc] initWithFrame:CGRectMake(prMainView.frame.size.width/2, SubViewTop.frame.size.height+SubViewTop.frame.origin.y, self.view.frame.size.width/2, self.view.frame.size.height/2-headerView.frame.size.height)];

    UIView *SubViewBottom = [[UIView alloc] initWithFrame:CGRectMake(0,SubViewTop.frame.size.height+SubViewTop.frame.origin.y, SubView.frame.size.width, SubView.frame.size.height/2)];
    SubViewBottom.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [SubView addSubview:SubViewBottom];
    
    UILabel *lblBottom = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SubViewBottom.frame.size.width, 40)];
    lblBottom.backgroundColor=[UIColor colorWithRed:244.0f/255 green:236.0f/255 blue:197.0f/255 alpha:1.0f];
    lblBottom.text=@"  Waiting Users";
    lblBottom.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [SubViewBottom addSubview:lblBottom];

    pendingUsersTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SubViewBottom.frame.size.width, SubViewBottom.frame.size.height-40)];
    [pendingUsersTable setDataSource:self];
    [pendingUsersTable setDelegate:self];
    [pendingUsersTable setBackgroundColor:[UIColor clearColor]];
    [pendingUsersTable setTableFooterView:[UIView new]];
    [SubViewBottom addSubview:pendingUsersTable];

    // CALL FOR BOARD USERS
    iscallback = 2001;
    pendingUsers = [[NSArray alloc] init];
    sharedUsers = [[NSArray alloc] init];
    NSDictionary* boardData = (NSDictionary*)metaBrd;
    NSDictionary *params = @{
                             @"id" : boardData[@"data"][@"id"],
                             @"uid" : [SavePrefrences sharedInstance].uid
                             };
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getBoardQues" :@"":@"":params :self];
}


-(void)Comment{
    [self MainView:vc1 :@"   Post Comment"];
    
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y, scrollbar.frame.size.width, 330 );
    gradeViewAr=[[NSMutableArray alloc]init];
    pop_up=[[UIView alloc]initWithFrame:CGRectMake(5,NameLabel.frame.size.height+NameLabel.frame.origin.y-100, scrollbar.frame.size.width-10,300)];
    pop_up.backgroundColor=[UIColor clearColor];
    [scrollbar addSubview:pop_up];
    
    UIButton *bold=[[UIButton alloc]initWithFrame:CGRectMake(20,3 ,25, 30)];
    [bold setTitle:@"B" forState:UIControlStateNormal];
    [bold setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bold setFont:[UIFont boldSystemFontOfSize:20]];
    [bold addTarget:self action:@selector(BoldText:) forControlEvents:UIControlEventTouchUpInside];
    bold.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [pop_up addSubview:bold];
    bold.userInteractionEnabled = YES;
    bold.layer.cornerRadius=13;

    bold.tag=0;
    
    UIButton  *Italic=[[  UIButton  alloc]initWithFrame:CGRectMake(bold.frame.size.width+bold.frame.origin.x+3,3,25, 30)];
    [Italic setTitle:@"I" forState:UIControlStateNormal];
    [Italic setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Italic setFont:[UIFont boldSystemFontOfSize:20]];
    [Italic addTarget:self action:@selector(ItalicText:) forControlEvents:UIControlEventTouchUpInside];
    Italic.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [pop_up addSubview:Italic];
    Italic.userInteractionEnabled = YES;
    Italic.layer.cornerRadius=13;

    Italic.tag=1;
    
    UIButton *Underline=[[UIButton alloc]initWithFrame:CGRectMake(Italic.frame.size.width+Italic.frame.origin.x+3,3,25, 30)];
    [Underline setTitle:@"U" forState:UIControlStateNormal];
    [Underline setFont:[UIFont boldSystemFontOfSize:20]];
    [Underline setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Underline addTarget:self action:@selector(UnderlineText:) forControlEvents:UIControlEventTouchUpInside];
    Underline.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [pop_up addSubview:Underline];
    Underline.userInteractionEnabled = YES;
    Underline.layer.cornerRadius=13;
    Underline.tag=2;
    
    UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(20,Underline.frame.size.height+Underline.frame.origin.y+10,pop_up.frame.size.width-10-30, 120)];
    descriptionView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    [pop_up addSubview:descriptionView];

    //problem
    cmnt=[[UILabel alloc]initWithFrame:CGRectMake(0, 3,  descriptionView.frame.size.width-10, 20)];
    cmnt.text=@"Type your Comment here";
    cmnt.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    cmnt.backgroundColor=[UIColor clearColor];
    [cmnt setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [descriptionView addSubview: cmnt];
    
    type_commnt=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,  descriptionView.frame.size.width-10,120)];
    type_commnt.delegate=self;
    type_commnt.backgroundColor=[UIColor clearColor];
    type_commnt.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [type_commnt setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    type_commnt.tag=11111;
    [descriptionView addSubview:type_commnt];
    
    video=[[UIImageView alloc]initWithFrame:CGRectMake(20,pop_up.frame.size.height-100, 28,28)];
    video.image = [UIImage imageNamed:@"cmntvideo.png"];
    [pop_up addSubview:video];
    
    UITapGestureRecognizer *ind2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openvideo:)];
    [ind2 setNumberOfTouchesRequired:1];
    [ind2 setDelegate:self];
    video.tag=0;
    video.userInteractionEnabled = YES;
    [video addGestureRecognizer:ind2];
    
    attach=[[UIImageView alloc]initWithFrame:CGRectMake(video.frame.size.width+video.frame.origin.x+3,pop_up.frame.size.height-100, 28, 28)];
    attach.image = [UIImage imageNamed:@"cmntattachment.png"];
    [pop_up addSubview:attach];
    
    UITapGestureRecognizer *ind3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openvideo:)];
    [ind3 setNumberOfTouchesRequired:1];
    [ind3 setDelegate:self];
    attach.userInteractionEnabled = YES;
    attach.tag=1;
    [attach addGestureRecognizer:ind3];
    
    docicon=[[UIImageView alloc]initWithFrame:CGRectMake(attach.frame.size.width+attach.frame.origin.x+3,pop_up.frame.size.height-100, 28, 28)];
    docicon.image = [UIImage imageNamed:@"cmntdocicon.png"];
    [pop_up addSubview:docicon];
    
    UITapGestureRecognizer *ind4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openvideo:)];
    [ind4 setNumberOfTouchesRequired:1];
    [ind4 setDelegate:self];
    docicon.userInteractionEnabled = YES;
        docicon.tag=2;
   // [docicon addGestureRecognizer:ind4];
    
    gradAr=[[NSMutableArray alloc]init];
    [gradAr addObject:@"E"];
    [gradAr addObject:@"D"];
    [gradAr addObject:@"C"];
    [gradAr addObject:@"B"];
    [gradAr addObject:@"A"];
    
    int grwid=pop_up.frame.size.width-30;
    int tagid=5;
    selgrade=0;
    for(int x=0;x<[gradAr count];x++)
    {
        
        E_alpha=[[UILabel alloc]initWithFrame:CGRectMake(grwid,pop_up.frame.size.height-100, 28, 28)];
        E_alpha.text=[gradAr objectAtIndex:x];
        [E_alpha setFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
        E_alpha.textAlignment=NSTextAlignmentCenter;
        E_alpha.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        E_alpha.textColor=[UIColor whiteColor];
        [[E_alpha layer] setCornerRadius:14];
        [[E_alpha layer] setMasksToBounds:YES];
        E_alpha.tag=tagid;
        [pop_up addSubview:E_alpha];

        [gradeViewAr addObject:E_alpha];
        grwid=grwid-30;
        tagid=tagid-1;
        
        UITapGestureRecognizer *gradereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectCommentGrade:)];
        [gradereg setNumberOfTouchesRequired:1];
        [gradereg setDelegate:self];
        E_alpha.userInteractionEnabled = YES;
        [E_alpha addGestureRecognizer:gradereg];
        
    }
    int w=pop_up.frame.size.height;
    publish=[[UILabel alloc]initWithFrame:CGRectMake(w/2-w/4, E_alpha.frame.size.height+E_alpha.frame.origin.y+25, 80, 25)];
    publish.text=@"Publish";
    publish.backgroundColor=[UIColor clearColor];//colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
    [publish setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    publish.textColor=[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0];
    publish.textAlignment=NSTextAlignmentCenter;
    [pop_up addSubview:publish];
    
    UITapGestureRecognizer *pubreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PostMyCommnet:)];
    [pubreg setNumberOfTouchesRequired:1];
    [pubreg setDelegate:self];
    publish.userInteractionEnabled = YES;
    [publish addGestureRecognizer:pubreg];
    
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake(publish.frame.size.width+publish.frame.origin.x+15,E_alpha.frame.size.height+E_alpha.frame.origin.y+25, 80, 25);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancelIt:) forControlEvents:UIControlEventTouchUpInside];
    close.backgroundColor=[UIColor clearColor];
    [pop_up addSubview:close];

    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, scrollbar.frame.size.height-800);
    htmlString = @"";
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"predddd");
    [textField resignFirstResponder];
    return YES;
}
-(void) openvideo:(id)sender
  {

    UITapGestureRecognizer * tg=(UITapGestureRecognizer *)sender;
    int idd= (int)tg.view.tag;
    
   // ManageArray * av=[[ManageArray alloc]init];
   // [av showMessageToUser];
      [self openGallary];
  
  }

-(void) openGallary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePickerAlbum =[[UIImagePickerController alloc] init];
        imagePickerAlbum.delegate = self;
       
        imagePickerAlbum.allowsEditing = YES;
        imagePickerAlbum.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
         if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
            // UIWindow* keyWindow= [[UIApplication sharedApplication] keyWindow];
            // [keyWindow addSubview: self.view];
             UIViewController *activeController = [UIApplication sharedApplication].keyWindow.rootViewController;
             if ([activeController isKindOfClass:[UINavigationController class]])
             {
                 activeController = [(UINavigationController*) activeController visibleViewController];
             }
             activeController.modalPresentationStyle = UIModalPresentationFormSheet;
             activeController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
             [activeController presentModalViewController:imagePickerAlbum animated:YES];
       // [self presentViewController:imagePickerAlbum animated:YES completion:nil];
         }
       
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Attention" message:@"Please give this app permission to access your photo library in your settings app!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    //UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
  //  imageViewPreview.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)SelectCommentGrade:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    
    selgrade=(int)tg.view.tag;
    NSLog(@"selgrade is %d",selgrade);
    for(int c=0;c<[gradeViewAr count];c++)
    {
        UIView * uv= [gradeViewAr objectAtIndex:c];
        uv.backgroundColor=[UIColor grayColor];
    }
    if(selgrade>0)
    {
        UIView *g=[gradeViewAr objectAtIndex:5-selgrade];
        g.backgroundColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
    }
    
    
    NSLog(@"grade value is %d",selgrade);
}
-(IBAction)BoldText:(id)sender
{
  
    UIButton *btn=(UIButton *)sender;
    
   NSString *text= type_commnt.text;

    if(text==nil||text==NULL||[text isEqual:[NSNull null]]||text == (id)[NSNull null])
     {
     }
    else
    {
    if(bold==0)
      {
        btn.layer.borderColor=[[UIColor clearColor]CGColor];
        btn.layer.borderWidth=1;
        
         htmlString=[@"<b>" stringByAppendingString:[NSString stringWithFormat:@"%@</b> ",text]];
          
          NSLog(@"string is====%@",htmlString);
       if(italic==1)
       {
           //bold italic
           NSLog(@"inside italic");
         htmlString=[@"<b><i>" stringByAppendingString:[NSString stringWithFormat:@"%@</i></b> ",text]];
        }
        if(underline==1)
        {
         htmlString=[@"<b><u>" stringByAppendingString:[NSString stringWithFormat:@"%@</u></b> ",text]];
            //bold underline
        }
          if(underline==1&&italic==1)
          {
              htmlString=[@"<b><u><i>" stringByAppendingString:[NSString stringWithFormat:@"%@</i></u></b> ",text]];
              //bold underline
          }
          
          
     bold=1;
    }
    else if(bold==1)
    {
         btn.layer.borderColor=[[UIColor clearColor]CGColor];
      htmlString=text;
        if(italic==1)
        {
            htmlString=[@"<i>" stringByAppendingString:[NSString stringWithFormat:@"%@</i> ",text]];
            // italic
        }
        if(underline==1)
        {
             //htmlString = @"<u>Hellooooooo</u>";
                htmlString=[@"<u>" stringByAppendingString:[NSString stringWithFormat:@"%@</u> ",text]];
            // underline
        }
        if(italic==1&&underline==1)
        {
   
                htmlString=[@"<i><u>" stringByAppendingString:[NSString stringWithFormat:@"%@</u></i> ",text]];
            // italic underline
        }
        bold=0;
    }
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    type_commnt.attributedText = attributedString;
     //publish.tag=0;
}
-(IBAction)ItalicText:(id)sender
{
 
    UIButton *btn=(UIButton *)sender;
    
    NSString *text= type_commnt.text;
    
    if(text==nil||text==NULL||[text isEqual:[NSNull null]]||text == (id)[NSNull null])
    {
    }
    else
    {
       
        if(italic==0)
        {
            btn.layer.borderColor=[[UIColor clearColor]CGColor];
            btn.layer.borderWidth=1;
            
            htmlString=[@"<i>" stringByAppendingString:[NSString stringWithFormat:@"%@</i> ",text]];
            
            NSLog(@"string is====%@",htmlString);
            if(bold==1)
            {
                NSLog(@"insid itallic 1");
                //bold italic
                NSLog(@"inside italic");
                htmlString=[@"<b><i>" stringByAppendingString:[NSString stringWithFormat:@"%@</i></b> ",text]];
            }
            if(underline==1)
            {
                NSLog(@"insid itallic 2");
                htmlString=[@"<i><u>" stringByAppendingString:[NSString stringWithFormat:@"%@</u></i> ",text]];
                //bold underline
            }
            if(underline==1&&bold==1)
            {
                NSLog(@"insid itallic 3");
                htmlString=[@"<i><u><b>" stringByAppendingString:[NSString stringWithFormat:@"%@</b></u></i> ",text]];
                //bold underline
            }
            
            
            
            italic=1;
        }
        else if(italic==1)
        {
            btn.layer.borderColor=[[UIColor clearColor]CGColor];
            htmlString=text;
            if(bold==1)
            {
                NSLog(@"insid itallic 4");
                htmlString=[@"<b>" stringByAppendingString:[NSString stringWithFormat:@"%@</b> ",text]];
                // italic
            }
            if(underline==1)
            {
               NSLog(@"insid itallic 5");
                htmlString=[@"<u>" stringByAppendingString:[NSString stringWithFormat:@"%@</u> ",text]];
                // underline
            }
            if(bold==1&&underline==1)
            {
               NSLog(@"insid itallic 6");
                
                htmlString=[@"<b><u>" stringByAppendingString:[NSString stringWithFormat:@"%@</u></b> ",text]];
                // italic underline
            }
            italic=0;
        }
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    type_commnt.attributedText = attributedString;
    
   // [type_commnt setFont:[UIFont italicSystemFontOfSize:[UIFont systemFontSize]]];
   // publish.tag=1;
}
-(IBAction)UnderlineText:(id)sender
{
    
    
   
    UIButton *btn=(UIButton *)sender;
    
    NSString *text= type_commnt.text;
    
    if(text==nil||text==NULL||[text isEqual:[NSNull null]]||text == (id)[NSNull null])
    {
    }
    else
    {
        if(underline==0)
        {
            btn.layer.borderColor=[[UIColor clearColor]CGColor];
            btn.layer.borderWidth=1;
            
            htmlString=[@"<u>" stringByAppendingString:[NSString stringWithFormat:@"%@</u> ",text]];
            if(italic==1)
            {
                //bold italic
                NSLog(@"inside italic");
                htmlString=[@"<u><i>" stringByAppendingString:[NSString stringWithFormat:@"%@</i></u> ",text]];
            }
            if(bold==1)
            {
                htmlString=[@"<b><u>" stringByAppendingString:[NSString stringWithFormat:@"%@</u></b> ",text]];
                //bold underline
            }
            if(bold==1&&italic==1)
            {
                 htmlString=[@"<i><u><b>" stringByAppendingString:[NSString stringWithFormat:@"%@</b></u></i> ",text]];
            }
            underline=1;
        }
        else if(underline==1)
        {
            btn.layer.borderColor=[[UIColor clearColor]CGColor];
            htmlString=text;
            if(underline==1)
            {
                htmlString=[@"<u>" stringByAppendingString:[NSString stringWithFormat:@"%@</u> ",text]];
                // italic
            }
            if(bold==1)
            {
                //htmlString = @"<u>Hellooooooo</u>";
                htmlString=[@"<b>" stringByAppendingString:[NSString stringWithFormat:@"%@</b> ",text]];
                // underline
            }
            if(italic==1&&bold==1)
            {
                
                htmlString=[@"<i><b>" stringByAppendingString:[NSString stringWithFormat:@"%@</b></i> ",text]];
                // italic underline
            }
            underline=0;
        }
    }
           NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    type_commnt.attributedText = attributedString;
    
    
    
    
    
    
  
   // NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    //type_commnt.attributedText = [[NSAttributedString alloc] initWithString:type_commnt.text
      //                                                     attributes:underlineAttribute];
  
    

    publish.tag=2;
}
-(void)PostMyCommnet:(id)sender
{
    UITapGestureRecognizer *btn=(UITapGestureRecognizer*)sender;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    if([type_commnt.text length]>0)
    {
        iscallback=30;
        [dic1 setObject:[NSString stringWithFormat:@"%d",b_id] forKey:@"bid"];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        if(htmlString.length){
        [dic1 setObject:htmlString forKey:@"comment"];
        }else{
        [dic1 setObject:type_commnt.text forKey:@"comment"];
        }
        [dic1 setObject:[[NSMutableDictionary alloc]init] forKey:@"buffer"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",selgrade] forKey:@"grade"];
        [dic1 setObject:@"" forKey:@"keys"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"postComment" :@"":@"":dic1 :self];
    }
    else
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Comment cannot be empty" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        
        
    }
    
}
-(void)GoBack{
    NSLog(@"pop closed");
    backData=[[NSMutableArray alloc]init];
    [backData addObject:@"noresult"];
    [self dissmisspop];
}
-(void)shareit:(UIViewController*)Vc
{
    [self MainViewfortable:vc1 :@"   User Search"];
    viewfortable.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    float div= viewfortable.frame.size.width/3;
    NSMutableArray *shareAr=[[NSMutableArray alloc]init];
    [shareAr addObject:@"Proyolk Friends"];
    [shareAr addObject:@"Cabinet"];
    [shareAr addObject:@"Network"];
  /*  float incx=0;
    for(int x=0; x< [shareAr count];x++)
    {
        proyolk=[[UILabel alloc]initWithFrame:CGRectMake(incx, 4,div+0.4, 50)];
        proyolk.text=[shareAr objectAtIndex:x];
        proyolk.textAlignment=NSTextAlignmentCenter;
        [proyolk setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        proyolk.textColor=[UIColor blackColor];
        proyolk.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
        [viewfortable addSubview:proyolk];
        
        UITapGestureRecognizer *gradereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBar:)];
        [gradereg setNumberOfTouchesRequired:1];
        [gradereg setDelegate:self];
        proyolk.userInteractionEnabled = YES;
        proyolk.tag=x;
        [proyolk addGestureRecognizer:gradereg];
        
        graybarPrylk=[[UILabel alloc]initWithFrame:CGRectMake(incx, proyolk.frame.size.height+proyolk.frame.origin.y, div+0.4, 5)];
        graybarPrylk.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
        [viewfortable addSubview:graybarPrylk];
        
        incx=incx+div;
        
    }*/
    
     proyolkBtn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 4,div+0.4, 50)];
    [proyolkBtn1 setTitle: @"Proyolk Friends" forState: UIControlStateNormal];
    [proyolkBtn1 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    //proyolkBtn1.textAlignment=NSTextAlignmentCenter;
    [proyolkBtn1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn1 setBackgroundColor:[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];//[ff valueForKey:@"backcolor"];
    proyolkBtn1.tag=111;
    [proyolkBtn1 addTarget:self action:@selector(tapBar1:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn1];

     proyolkBtn2=[[UIButton alloc]initWithFrame:CGRectMake(proyolkBtn1.frame.size.width+proyolkBtn1.frame.origin.x, 4,div+0.4, 50)];
    [proyolkBtn2 setTitle: @"Cabinet" forState: UIControlStateNormal];
    //proyolkBtn2.textAlignment=NSTextAlignmentCenter;
    [proyolkBtn2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn2 setBackgroundColor:[UIColor  colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];
    [proyolkBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    proyolkBtn2.tag=222;
    [proyolkBtn2 addTarget:self action:@selector(tapBar2:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn2];

     proyolkBtn3=[[UIButton alloc]initWithFrame:CGRectMake(proyolkBtn2.frame.size.width+proyolkBtn2.frame.origin.x, 4,div+0.4, 50)];
    [proyolkBtn3 setTitle: @"Network" forState: UIControlStateNormal];
    //proyolkBtn1.textAlignment=NSTextAlignmentCenter;
    [proyolkBtn3 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn3 setBackgroundColor:[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];//[ff valueForKey:@"backcolor"];
    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    proyolkBtn3.tag=333;
    [proyolkBtn3 addTarget:self action:@selector(tapBar3:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn3];

    //130:197:246
    yellowPrylk=[[UILabel alloc]initWithFrame:CGRectMake(0, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
    yellowPrylk.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellowPrylk.hidden=false;
    [viewfortable addSubview:yellowPrylk];
    
    yellowcbnt=[[UILabel alloc]initWithFrame:CGRectMake(yellowPrylk.frame.size.width+yellowPrylk.frame.origin.x, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
    yellowcbnt.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellowcbnt.hidden=true;
    [viewfortable addSubview:yellowcbnt];
    
    yellownet=[[UILabel alloc]initWithFrame:CGRectMake(yellowcbnt.frame.size.width+yellowcbnt.frame.origin.x, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
    yellownet.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellownet.hidden=true;
    [viewfortable addSubview:yellownet];
    
   /* UILabel *linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, proyolk.frame.size.height+proyolk.frame.origin.y+3.5, viewfortable.frame.size.width, 2)];
    linelabel.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [viewfortable addSubview:linelabel];*/

    UIColor *color = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];

    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(10, yellowPrylk.frame.size.height+yellowPrylk.frame.origin.y+5, viewfortable.frame.size.width-55, 30)];
    search_lbl.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search Name..." attributes:@{NSForegroundColorAttributeName: color}];
    [search_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];

    search_lbl.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    search_lbl.delegate=self;
    search_lbl.clipsToBounds=YES;
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = paddingView;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    [viewfortable addSubview:search_lbl];
    
    Search=[[UIButton alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+10, yellownet.frame.size.height+yellownet.frame.origin.y+1, 30, 30)];
    [Search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Search.backgroundColor=[ff valueForKey:@"clearColor"];
    
    [Search setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    
    [Search addTarget:self action:@selector(searchHere:) forControlEvents:UIControlEventTouchUpInside];
    [Search setClipsToBounds:YES];
    [viewfortable addSubview:Search];
    
    
}
-(void)proyolkTable
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    ProyolkFrndTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, search_lbl.frame.size.height+search_lbl.frame.origin.y+5,viewfortable.frame.size.width-10,viewfortable.frame.size.height-search_lbl.frame.size.height-search_lbl.frame.origin.y+30)];
    ProyolkFrndTableView.delegate = self;
    ProyolkFrndTableView.dataSource = self;
    ProyolkFrndTableView.scrollEnabled = YES;
    ProyolkFrndTableView.backgroundColor= [ff valueForKey:@"clearColor"];
    ProyolkFrndTableView.separatorColor=[ff valueForKey:@"clearColor"];
    [viewfortable addSubview:ProyolkFrndTableView];
    
}
-(void)shareTable
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    ProyolkTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, search_lbl.frame.size.height+search_lbl.frame.origin.y,viewfortable.frame.size.width-10,viewfortable.frame.size.height-search_lbl.frame.size.height-search_lbl.frame.origin.y+30)];
    ProyolkTableView.delegate = self;
    ProyolkTableView.dataSource = self;
    ProyolkTableView.scrollEnabled = YES;
    ProyolkTableView.backgroundColor= [ff valueForKey:@"clearColor"];
    ProyolkTableView.separatorColor=[ff valueForKey:@"clearColor"];
    
    [viewfortable addSubview:ProyolkTableView];
}
-(void)networkTable
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    networkTableview = [[UITableView alloc] initWithFrame:CGRectMake(5, search_lbl.frame.size.height+search_lbl.frame.origin.y,viewfortable.frame.size.width-10,viewfortable.frame.size.height-search_lbl.frame.size.height-search_lbl.frame.origin.y+30)];
    networkTableview.delegate = self;
    networkTableview.dataSource = self;
    networkTableview.scrollEnabled = YES;
    networkTableview.backgroundColor= [ff valueForKey:@"clearColor"];
    networkTableview.separatorColor=[ff valueForKey:@"clearColor"];
    [viewfortable addSubview:networkTableview];
}



-(IBAction)searchHere:(id)sender
{
    
    UIButton *btn=(UIButton*)sender;
    
    
    if(btn.tag==0)
    {
        iscallback=26;
        NSLog(@"value is %d",iscallback);
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",b_id] forKey:@"bId"];
        [dic1 setObject:search_lbl.text forKey:@"mem"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getBoardMem" :@"":@"":dic1 :self];
    }
    else if (btn.tag==1)
    {
        iscallback=24;
        NSLog(@"value is %d",iscallback);
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",b_id] forKey:@"bId"];
        [dic1 setObject:search_lbl.text forKey:@"frnd"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getBdFrnd" :@"":@"":dic1 :self];
    }
    else if (btn.tag==2)
    {
        iscallback=25;
        NSLog(@"value is %d",iscallback);
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",b_id] forKey:@"bId"];
        [dic1 setObject:search_lbl.text forKey:@"frnd"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getBdFrndz" :@"":@"":dic1 :self];
    }
}
-(IBAction)tapBar1:(id)sender
//-(void)tapBar:(id)sender
{
        Search.tag=0;
        [ProyolkFrndTableView removeFromSuperview];
        [ProyolkTableView  removeFromSuperview];
        [networkTableview removeFromSuperview];
        yellownet.hidden=true;
        yellowcbnt.hidden=true;
        yellowPrylk.hidden=false;
      //  proyolk.textColor=[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0];
    [proyolkBtn1 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    [proyolkBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

-(IBAction)tapBar2:(id)sender
//-(void)tapBar:(id)sender
{
        Search.tag=1;
        yellowPrylk.hidden=true;
        yellowcbnt.hidden=false;
        yellownet.hidden=true;
        [networkTableview removeFromSuperview];
        [ProyolkFrndTableView removeFromSuperview];
        iscallback=22;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",b_id] forKey:@"bId"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"BoardFrndz" :@"":@"":dic1 :self];
    [proyolkBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn2 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(IBAction)tapBar3:(id)sender
//-(void)tapBar:(id)sender
{
        Search.tag=2;
        [ProyolkTableView removeFromSuperview];
        [ProyolkFrndTableView removeFromSuperview];
        yellownet.hidden=false;
        yellowPrylk.hidden=true;
        yellowcbnt.hidden=true;
        iscallback=23;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",b_id] forKey:@"bId"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"BoardFrndzz" :@"":@"":dic1 :self];
    [proyolkBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn3 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
}


-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section{
    
    if(manag==nil)
        manag=[[ManageArray alloc]init];
    
    if(theTableView==commentTableView)
    {
        tablecellheight=80;
        return [commentBAr count];
    }
    if(theTableView==inviteTableView)
    {
        tablecellheight=50;
        return [inviteAr count];
    }
    if(theTableView==ProyolkTableView)
    {
        tablecellheight=50;
         alreadyInvitedDic=[[NSMutableDictionary alloc]init];
        return [cbntAr count];
    }
    if (theTableView==networkTableview)
    {tablecellheight=50;
        
        alreadyInvitedDic=[[NSMutableDictionary alloc]init];
        return [netwrkAr count];
    }
    if(theTableView==ProyolkFrndTableView)
    {tablecellheight=50;
         alreadyInvitedDic=[[NSMutableDictionary alloc]init];
        return [proylkAr count];
    }
    if (theTableView == shareUsersTable) {
        return  [sharedUsers count];
    }
    if (theTableView == pendingUsersTable){
        return [pendingUsers count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.commentTableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    @try {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        
        if(theTableView==shareUsersTable){
            NSDictionary* aUser = sharedUsers[indexPath.row];
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, shareUsersTable.frame.size.width, 50)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
            [cell setBackgroundColor:[UIColor clearColor]];
            UIImageView* userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
            NSString *img = aUser[@"img"];
            img= [manag concatUrl:img];
            [userImageView sd_setImageWithURL:[NSURL URLWithString:img]];
            [cell_View addSubview:userImageView];
            UILabel* userNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, 200, 40)];
            [userNameLbl setText:aUser[@"uname"]];
            [cell_View addSubview:userNameLbl];
            return cell;
        }
        if(theTableView==pendingUsersTable){
            NSDictionary* aUser = pendingUsers[indexPath.row];
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, pendingUsersTable.frame.size.width, 50)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell addSubview: cell_View];
            UIImageView* userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
            NSString *img = aUser[@"img"];
            img= [manag concatUrl:img];
            [userImageView sd_setImageWithURL:[NSURL URLWithString:img]];
            [cell_View addSubview:userImageView];
            UILabel* userNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, 200, 40)];
            [userNameLbl setText:aUser[@"uname"]];
            [cell_View addSubview:userNameLbl];
            return cell;
        }
        
        if(theTableView==commentTableView)
        {
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, commentTableView.frame.size.width, 80)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(63,cell_View.bounds.size.height-1,cell_View.bounds.size.width-79,1)];
            separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            [cell_View addSubview:separator];

            
            NSString *cmnt_time=[[commentBAr objectAtIndex:indexPath.row]valueForKey:@"cmnt_time"];
            NSString *uname=[[commentBAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            NSString *cmnt_content=[[commentBAr objectAtIndex:indexPath.row]valueForKey:@"cmnt_content"];
            NSString *grade=[[commentBAr objectAtIndex:indexPath.row]valueForKey:@"grade"];
          //  NSString *uid=[[commentBAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            NSString *doc1=[[commentBAr objectAtIndex:indexPath.row]valueForKey:@"doc"];
            NSString *file=[[commentBAr objectAtIndex:indexPath.row]valueForKey:@"file"];
            NSString *img1=[[commentBAr objectAtIndex:indexPath.row]valueForKey:@"img"];

            NSLog(@"img1------%@",img1);
            
            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(3,15, 50, 50)];
            image.backgroundColor = [UIColor clearColor];
            ManageArray* mang=[[ManageArray alloc]init];
            NSString* imgUrl = [mang concatUrl:img1];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            image.image = [UIImage imageWithData:imageData];
            [ cell_View addSubview: image];
            
            NSString * url=img1;//[mngAr concatUrl:img1];
           //  [image sd_setImageWithURL:[NSURL URLWithString:url]];
//            if(url.length<12)
//            {
//                image.image = [UIImage imageNamed:@"username.png"];
//            }
//            else
//            {
//                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//                
//                if (imageData.length<=0)
//                    image.image = [UIImage imageNamed:@"username.png"];
//                else
//                    image.image = [UIImage imageWithData:imageData];
//            }

            
            uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+8, 15,cell_View.frame.size.width/2 -20-40, 15)];
            uname_lbl.textColor=[UIColor colorWithRed:96.0f/255.0f green:130.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
            if([av checkNullStr:uname])
            {
                uname_lbl.text=uname;
            }
            uname_lbl.backgroundColor=[UIColor clearColor];//colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
            [cell_View addSubview: uname_lbl];
            UILabel *date=[[UILabel alloc] initWithFrame:CGRectMake(uname_lbl.frame.size.width+uname_lbl.frame.origin.x, 2, cell_View.frame.size.width/2-20, 15)];
            [date setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            date.textAlignment=NSTextAlignmentRight;
            date.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            if([av checkNullStr:cmnt_time])
            {
                date.text=cmnt_time;
            }
            [cell_View addSubview:date];
            
            
            UILabel *comment=[[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+8, uname_lbl.frame.size.height+uname_lbl.frame.origin.y+2, cell_View.frame.size.width-30-40, 25)];
            if([av checkNullStr:cmnt_content])
            {
                htmlString = cmnt_content;
                NSAttributedString *attrStr=  [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding]  options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:  @(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
                comment.attributedText=attrStr;
            }
            
            [comment setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
            comment.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            [cell_View addSubview:comment];
            
            //grade black yellow
            UILabel *img=[[UILabel alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-40, comment.frame.size.height+comment.frame.origin.y,20, 20)];
            img.backgroundColor=[UIColor blackColor];
            img.text=[NSString stringWithFormat:@"%@",grade];
            img.textAlignment=NSTextAlignmentCenter;
            [img setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            img.textColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
            img.layer.borderWidth=1;
            img.layer.borderColor=[[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:1.0f] CGColor];

            [cell_View addSubview:img];
            
            UIImageView *video=[[UIImageView alloc] initWithFrame:CGRectMake(cell_View.frame.size.width-74, comment.frame.size.height+comment.frame.origin.y, 30, 30)];
            [video setImage:[UIImage imageNamed:@"video.png"]];
            [cell_View addSubview:video];
            
            UIImageView *doc=[[UIImageView alloc] initWithFrame:CGRectMake(cell_View.frame.size.width-64, comment.frame.size.height+comment.frame.origin.y, 20, 20)];
            doc.backgroundColor=[UIColor clearColor];
            [doc setImage:[UIImage imageNamed:@"cmntdocicon.png"]];
            [cell_View addSubview:doc];
            if(grade==nil||grade==NULL||[grade isEqual:[NSNull null]]||[grade isEqual:@""]||grade == (id)[NSNull null])
            {
                img.hidden=true;
            }
            
            if(doc1==nil||doc1==NULL||[doc1 isEqual:[NSNull null]]||[doc1 isEqual:@""]||doc1 == (id)[NSNull null])
            {   doc.hidden=true;
                
            }
            if(file==nil||file==NULL||[file isEqual:[NSNull null]]||[file isEqual:@""]||file == (id)[NSNull null])
            {
                video.hidden=true;
            }
            return cell;
        }
        else if(theTableView==inviteTableView)
        {
            cell.backgroundColor=[ff valueForKey:@"clearColor"];
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width-5, 50)];
            cell_View.backgroundColor=[UIColor clearColor];
            cell_View.clipsToBounds=YES;
            [cell addSubview: cell_View];
            cell.backgroundColor=[UIColor clearColor];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,cell_View.bounds.size.height-1,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            [cell_View addSubview:separator];

            NSString *uname=[[inviteAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            
            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 35, 35)];
            [image setImage:[UIImage imageNamed:@"username.png"]];
            [ cell_View addSubview: image];

            uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textAlignment=NSTextAlignmentLeft;
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            if([av checkNullStr:uname]){
                uname_lbl.text=uname;
            }
            uname_lbl.backgroundColor=[UIColor clearColor];//colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [cell_View addSubview: uname_lbl];
            
            
            UIButton *invite1=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
            invite1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [invite1 setBackgroundColor:[UIColor clearColor]];
            [invite1 setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            
            [invite1 setTitle:@"Invite" forState:UIControlStateNormal];
            [invite1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            invite1.tag=[[[inviteAr objectAtIndex:indexPath.row]valueForKey:@"u_id"] intValue];
            [invite1 addTarget:self action:@selector(inviteFrnd:) forControlEvents:UIControlEventTouchUpInside];
            [invite1 setClipsToBounds:YES];
            [cell_View addSubview:invite1];
            
            UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
            isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
            isonimg.backgroundColor=[UIColor clearColor];
            [cell_View addSubview:isonimg];

            return cell;
        }
        else if(theTableView==networkTableview)
        {
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 50)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
            
             cell.backgroundColor=[UIColor clearColor];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,cell_View.bounds.size.height-1,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            [cell_View addSubview:separator];

            NSString *uname=[[netwrkAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            
           UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
            userpic.backgroundColor=[UIColor clearColor];
           // [userpic setImage:[UIImage imageNamed:@"user.png"]];
            [cell_View addSubview:userpic];
            
            
            NSString *Img= [[netwrkAr objectAtIndex:indexPath.row]valueForKey:@"img"];
            Img= [manag concatUrl:Img];
            [userpic sd_setImageWithURL:[NSURL URLWithString:Img]];
            
            //            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if(Img.length<12)
//            {
//                userpic.image = [UIImage imageNamed:Img];
//            }
//            else
//            {
//                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//                if (imageData.length<=0)
//                    userpic.image = [UIImage imageNamed:@"username.png"];
//                else
//                    userpic.image = [UIImage imageWithData:imageData];
//                
//            }
            
            

            uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textAlignment=NSTextAlignmentLeft;
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            if([av checkNullStr:uname])
            {
                uname_lbl.text=uname;
            }
            uname_lbl.backgroundColor=[UIColor clearColor];//colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [cell_View addSubview: uname_lbl];
            

            
            invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-10-40,20)];
            invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            [invite setBackgroundColor:[UIColor clearColor]];
            NSString *status=[[netwrkAr objectAtIndex:indexPath.row]valueForKey:@"status"];
         
            NSString * msg=@"Invite";
            if(status==nil||status==NULL||[status isEqual:[NSNull null]]||[status isEqual:@""]||status == (id)[NSNull null])
            {
                
            }
            else{
                if([status intValue] ==0)
                {
                    msg=@"Invitation Sent";
                    invite.userInteractionEnabled=NO;
                    [invite setBackgroundColor:[UIColor clearColor]];

                }
                if([status intValue] ==1)
                {
                    msg=@"Shared";
                    invite.userInteractionEnabled=NO;
                    [invite setBackgroundColor:[UIColor clearColor]];

                }
                
            }
           
            [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            invite.tag=[[[netwrkAr objectAtIndex:indexPath.row]valueForKey:@"u_id"] intValue];
            [invite addTarget:self action:@selector(invitepro:) forControlEvents:UIControlEventTouchUpInside];
            [invite setClipsToBounds:YES];
            [cell_View addSubview:invite];
   
            UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
            isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
            isonimg.backgroundColor=[UIColor clearColor];
            [cell_View addSubview:isonimg];
            

            
            NSString * uid=[[netwrkAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            if([[alreadyInvitedDic allKeys] containsObject:[NSString stringWithFormat:@"%@",uid]])
            {
                msg=@"Remove";
                [invite setBackgroundColor:[UIColor clearColor]];
            }
            [invite setTitle:msg forState:UIControlStateNormal];
            return cell;
        }
        else if(theTableView==ProyolkTableView )
        {
               

            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width+5, 50)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
              cell.backgroundColor=[UIColor clearColor];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,cell_View.bounds.size.height-1,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            [cell_View addSubview:separator];

            NSString *uname=[[cbntAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            UIImageView * userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
            userpic.backgroundColor=[UIColor clearColor];
           // [userpic setImage:[UIImage imageNamed:@"user.png"]];
            [cell_View addSubview:userpic];
               
               
               NSString *Img= [[cbntAr objectAtIndex:indexPath.row]valueForKey:@"img"];
               Img= [manag concatUrl:Img];
               
               NSLog(@"cab img====%@",Img);
               [userpic sd_setImageWithURL:[NSURL URLWithString:Img]];
//               NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//               if(Img.length<12)
//               {
//                   userpic.image = [UIImage imageNamed:Img];
//               }
//               else
//               {
//                   NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//                   if (imageData.length<=0)
//                       userpic.image = [UIImage imageNamed:@"username.png"];
//                   else
//                       userpic.image = [UIImage imageWithData:imageData];
//               }
//            
            uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            if([av checkNullStr:uname])
            {
                uname_lbl.text=uname;
            }
            uname_lbl.backgroundColor=[UIColor clearColor];
            uname_lbl.textAlignment=NSTextAlignmentLeft;
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [cell_View addSubview: uname_lbl];
            
            
            
            
            
            invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
            [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [invite setBackgroundColor:[UIColor clearColor]];

               

            NSString *status=[[cbntAr objectAtIndex:indexPath.row]valueForKey:@"status"];
            NSLog(@"status issss netwrk=====%@",status);
            
            NSString * msg=@"Invite";
            
               if(status==nil||status==NULL||[status isEqual:[NSNull null]]||[status isEqual:@""]||status == (id)[NSNull null])
               {
                   
               }
               else{
                   if([status intValue] ==0)
                   {
                       msg=@"Invitation Sent";
                       invite.userInteractionEnabled=NO;
                       [invite setBackgroundColor:[UIColor clearColor]];

                   }
                   if([status intValue] ==1)
                   {
                       msg=@"Shared";
                       invite.userInteractionEnabled=NO;
                       [invite setBackgroundColor:[UIColor clearColor]];

                   }
                   
               }

            [invite setTitle:msg forState:UIControlStateNormal];
            [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            invite.tag=[[[cbntAr objectAtIndex:indexPath.row]valueForKey:@"u_id"] intValue];
            [invite addTarget:self action:@selector(invitepro:) forControlEvents:UIControlEventTouchUpInside];
            [invite setClipsToBounds:YES];
            [cell_View addSubview:invite];
            
          
            UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
            isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
            isonimg.backgroundColor=[UIColor clearColor];
            [cell_View addSubview:isonimg];

            NSString * uid=[[cbntAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            if([[alreadyInvitedDic allKeys] containsObject:[NSString stringWithFormat:@"%@",uid]])
            {
                msg=@"Remove";
                [invite setBackgroundColor:[UIColor clearColor]];

              //  invite.userInteractionEnabled=NO;
            }
            
            [invite setTitle:msg forState:UIControlStateNormal];
            return cell;
        }
        else if(theTableView==ProyolkFrndTableView )
        {
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 50)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
              cell.backgroundColor=[UIColor clearColor];
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,cell_View.bounds.size.height-1,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            [cell_View addSubview:separator];

            NSString *uname=[[proylkAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            // NSLog(@"proylkAr arr=====%@",proylkAr);
            
            
           UIImageView *  userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
            userpic.backgroundColor=[UIColor clearColor];
         //   [userpic setImage:[UIImage imageNamed:@"user.png"]];
            [cell_View addSubview:userpic];
            
            
            NSString *Img= [[proylkAr objectAtIndex:indexPath.row]valueForKey:@"img"];
            
               NSLog(@"proylkAr img====%@",Img);
            
            Img= [manag concatUrl:Img];
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if(Img.length<12)
//            {
//                userpic.image = [UIImage imageNamed:Img];
//            }
//            else
//            {
//                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//                if (imageData.length<=0)
//                    userpic.image = [UIImage imageNamed:@"username.png"];
//                else
//                    userpic.image = [UIImage imageWithData:imageData];
//                
//            }
//            
            
[userpic sd_setImageWithURL:[NSURL URLWithString:Img]];
            uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textAlignment=NSTextAlignmentLeft;
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            if([av checkNullStr:uname])
            {
                uname_lbl.text=uname;
            }
            uname_lbl.backgroundColor=[UIColor clearColor];
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [cell_View addSubview: uname_lbl];
            
            invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
            invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            [invite setBackgroundColor:[UIColor clearColor]];


            NSString *status=[[proylkAr objectAtIndex:indexPath.row]valueForKey:@"status"];
            NSLog(@"status issss netwrk=====%@",status);
            
            NSString * msg=@"Invite";
            [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            invite.tag=[[[proylkAr objectAtIndex:indexPath.row]valueForKey:@"u_id"] intValue];
            [invite addTarget:self action:@selector(invitepro:) forControlEvents:UIControlEventTouchUpInside];
            [invite setClipsToBounds:YES];
            [cell_View addSubview:invite];
            if(status==nil||status==NULL||[status isEqual:[NSNull null]]||[status isEqual:@""]||status == (id)[NSNull null])
            {
            }
            else{
                if([status intValue] ==0)
                {
                    msg=@"Invitation sent";
                    [invite setBackgroundColor:[UIColor clearColor]];
                }
                if([status intValue] ==1)
                {
                    msg=@"Shared";
                    [invite setBackgroundColor:[UIColor clearColor]];
                }
                
            }
            NSString * uid=[[proylkAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            if([[alreadyInvitedDic allKeys] containsObject:[NSString stringWithFormat:@"%@",uid]])
             {
                  msg=@"Remove";
             }
            else{
                
            }
            
            
             [invite setTitle:msg forState:UIControlStateNormal];
            
        }

        UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
        isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
        isonimg.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:isonimg];

        
        return cell;
    }
    @catch (NSException *exception) {
        NSLog(@"exception is===%@",exception);
    }
    @finally {
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath{
    if(tableView==shareUsersTable || tableView==pendingUsersTable) return 50;
    return tablecellheight;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(IBAction)invitepro:(id)sender
{
    NSLog(@"inviting");
    UIButton *btn=(UIButton *)sender;
    
   
    
    NSLog(@"btn title label====%@",btn.titleLabel.text);
    
    if([btn.titleLabel.text isEqualToString:@"Invite"])
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"u_from"];
        [dic setValue:[NSString stringWithFormat:@"%d",b_id] forKey:@"bId"];
        [dic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"u_to"];
        [dic setValue:[NSString stringWithFormat:@"%@",@"Friend"] forKey:@"key"];
        iscallback=21;
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"BdInviteMem" :@"" :@"" :dic :self ];
        
        [btn setTitle:@"Remove" forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor clearColor];
        [alreadyInvitedDic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
        
        
    }
    else if([btn.titleLabel.text isEqualToString:@"Remove"])
    {
         NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"u_from"];
        [dic setValue:[NSString stringWithFormat:@"%d",b_id] forKey:@"bId"];
        [dic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"u_to"];
        iscallback=21;
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"BdDelMemInvt" :@"" :@"" :dic :self ];
        
        [btn setTitle:@"Invite" forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor clearColor];
        [alreadyInvitedDic removeObjectForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
        
    }
    
   
    
    NSLog(@"already invited dic======%@",alreadyInvitedDic);
    
    
    
//    if([btn.titleLabel.text isEqual:@"Invite"])
//    {
//        [inViteFrAr addObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
//        [btn setTitle:@"Remove" forState:UIControlStateNormal];
//    }
//    else{
//        [inViteFrAr removeObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
//        [btn setTitle:@"Invite" forState:UIControlStateNormal];
//    }
    
    
    
}



-(IBAction) inviteFrnd:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    if([btn.titleLabel.text isEqual:@"Invite"])
    {
        [inViteFrAr addObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
        [btn setTitle:@"Remove" forState:UIControlStateNormal];
    }
    else{
        [inViteFrAr removeObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
        [btn setTitle:@"Invite" forState:UIControlStateNormal];
    }
    
    NSLog(@"frnd idd=====%@",backData);
    
    
}



-(IBAction)searchFriends:(id)sender
{
    iscallback=5;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic1 setObject:search.text forKey:@"mem"];
    [dic1 setObject:@" " forKey:@"bId"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getbdInviteMem" :@"":@"":dic1 :self];
    
}
-(IBAction)submitSortby:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    NSLog(@"submit details !!");
    if(issort==0)
    {
        issort=1;
    }
    else if(issort==1)
    {
        issort=2;
    }
    else if(issort==2)
    {
        issort=3;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", issort] forKey:@"BOARD_SORT_KEY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BOARD_SORT_CHANGE" object:nil];
    [self dissmisspop];
    
    
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [dic1 setObject:[NSString stringWithFormat:@"%d",issort] forKey:@"val"];
    
//    if((int)btn.tag==0)
//    {
//        iscallback=14;
//        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"sortingBoard" :@"":@"":dic1 :self];
//    }
//    else if((int)btn.tag==1)
//    {
//        iscallback=15;
//        [[SavePrefrences sharedInstance].skthand emitData:@"SharedBoard" :@"getSharedBoard" :@"":@"":dic1 :self];
//        
//    }
//    
//    else if((int)btn.tag==2)
//    {
//        iscallback=16;
//        [[SavePrefrences sharedInstance].skthand emitData:@"ComnBoard" :@"getAllBoard" :@"":@"":dic1 :self];
//        
//    }
    
    
}


-(IBAction)toggleButton:(id)sender
{
    
    iscallpub=1;
    
    UIButton *tappedButton = (UIButton*)sender;
    pubpri=(int)tappedButton.tag;
    
    if((int)tappedButton.tag==0 || (int)tappedButton.tag==1 ||(int)tappedButton.tag==2 )
    {
        [sender1  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        sender1=sender;
        [sender setImage:[UIImage imageNamed:@"radioselect.png"] forState:UIControlStateNormal];
        if((int)tappedButton.tag==0 )
        {
            publicview.hidden=true;
        }
        if((int)tappedButton.tag==1)
            
        {
            publicview.hidden=true;
            
            [self retrieveInviteFriends];
        }
        if (tappedButton.tag==2)
        {
            publicview.hidden=false;
        }
        
    }
    else if((int)tappedButton.tag==10 ||(int)tappedButton.tag==11)
    {
        NSLog(@"frnd is tapped");
        [sender  setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        [sender2  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        sender2=sender;
        
    }
    
}
-(void) reterivefrndforcal:(UIViewController *)vc:(int) ischeck
{
    vc1=vc;
    iscalender=ischeck;
    backData=[[NSMutableArray alloc]init];
    [backData addObject:@"frndlist"];
    
    [self retrieveInviteFriends];
}



-(void)retrieveInviteFriends
{
    iscallback=4;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic1 setObject:@"" forKey:@"bId"];
    [dic1 setObject:@"" forKey:@"mem"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getBoardMem" :@"":@"":dic1 :self];
    
}
-(IBAction)cancel:(id)sender{
    NSLog(@"hello world ");
    
    apply.userInteractionEnabled=YES;
    [apply setTitle:@"APPLY" forState:UIControlStateNormal];
    
    [self dissmisspop];
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
        NSLog(@"backkkkkkkkkkkkkk %@",backData);
        
        if(iscalender==2)
        {
            [backData addObject:inViteFrAr];
        }
        [cb callMethod:backData];
        
    }
}

-(IBAction)savingDetails:(id)sender
{
    
    av=[[AllValidationsViewController alloc]init];
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc] init];
                    
    
    

    
    if(pubpri==0)
    {
        pubpri=0;
        [dic1 setObject:[NSString stringWithFormat:@"%d",pubpri] forKey:@"vis"];
    }
    else if (pubpri==1)
    {
        //pubpri=1;
        NSMutableDictionary * arrData=[[NSMutableDictionary alloc]init];
        for(int x=0;x<[inViteFrAr count];x++)
        {
            NSMutableDictionary * userObj=[[NSMutableDictionary alloc]init];
            [userObj setValue:[inViteFrAr objectAtIndex:x] forKey:@"uid"];
            [arrData setValue:userObj forKey:[NSString stringWithFormat:@"i%d",x]];
        }
        [dic1 setValue:arrData forKey:@"uids"];
        
        
    }
    if(pubpri==10)
    {
        pubpri=2;
        [dic1 setObject:[NSString stringWithFormat:@"%d",pubpri] forKey:@"vis"];
    }
    else if (pubpri==11)
    {
        pubpri=3;
        [dic1 setObject:[NSString stringWithFormat:@"%d",pubpri] forKey:@"vis"];
    }
    
    if([av checkNull:title])
    {
        if([av checkNulltextview:question])
        {
            if([av checkCombo:Select_Industry]&&[av checkCombo:Select_Sub_Industry])
            {
                [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
                [dic1 setObject:title.text forKey:@"tt"];
                [dic1 setObject:question.text forKey:@"que"];
                [dic1 setObject:indid  forKey:@"inid"];
                [dic1 setObject:subid forKey:@"tid"];
   
                iscallback=13;
                [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"createBoard" :@"":@"":dic1 :self];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BOARD_SAVED" object:nil];
                [self dissmisspop];
            }
            
        }
    }
}



-(void) selectInduct{
    isselect=@"selected";
    iscallback=2;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getInd" :@"":@"":dic1 :self];
}

-(void) showInd{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@"Select Industry:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[dataind count];x++){
        NSString *stname=[[dataind valueForKey:@"industry_name"] objectAtIndex:x];
        NSString *idd=[[dataind valueForKey:@"i_id"] objectAtIndex:x];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            indid=idd;
                                            Select_Industry.text= [NSString stringWithFormat:@"  %@",stname];
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}
-(void)selecSubInd
{
    iscallback=3;
  if([Select_Industry.text hasPrefix:@"Select"])
  {
      UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:Select_Industry.text delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
      [alrt show];

  }
    else
  {
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:indid forKey:@"inid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getDep" :@"":@"":dic1 :self];
  }
}
-(void) showSubInd

{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@"Select Sub Industry:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[subdataind count];x++)
    {
        
        NSString *subname=[[subdataind valueForKey:@"topic_name"] objectAtIndex:x];
        NSString *subindid=[[subdataind valueForKey:@"t_id"] objectAtIndex:x];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:subname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            subid=subindid;
                                            Select_Sub_Industry.text=[NSString stringWithFormat:@"  %@",subname];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}

-(void) selectGrade
{
    NSMutableArray *g=[[NSMutableArray alloc]init];
    [g addObject:@"A"];
    [g addObject:@"B"];
    [g addObject:@"C"];
    [g addObject:@"D"];
    [g addObject:@"E"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@"Select Sub Industry:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[g count];x++)
    {
        
        NSString *subname=[g objectAtIndex:x];
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:subname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                        NSString * tile= [action title];
                        selGint=x;
                        Grade.text=[NSString stringWithFormat:@"  %@",subname];
                    }];
        [alert addAction:drivingAction];
    }
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}



-(void) date:(id) sender
{
    
    UITapGestureRecognizer * tg=(UITapGestureRecognizer *)sender;
    isdate=(int)tg.view.tag;
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [vc1.view addSubview:datePickerView ];
    datePickerView .backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:.5f];
    
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance].screenHeight/3, [SavePrefrences sharedInstance].screenWidth-40, 300)];
    
    datepicker.datePickerMode = UIDatePickerModeDate;
    
    
    datepicker.hidden = NO;
    [datepicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    datepicker.backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f];
    datepicker.layer.cornerRadius=60;
    datepicker.layer.masksToBounds=YES;
    datepicker.date = [NSDate date];
    
    [datePickerView addSubview:datepicker];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(datepicker.frame.size.width/2-55, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [save setTitle: @"OK" forState: UIControlStateNormal];
    save.tag=isdate;
    save.backgroundColor=[UIColor clearColor];
    [save addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [datePickerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor clearColor];
    [cancel addTarget:self action:@selector(nook:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [datePickerView addSubview:cancel];
    
}


-(IBAction)ok:(id)sender
{
    UIButton *ub=(UIButton *)sender;
    int tid =ub.tag;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"];
    
    if(tid==0)
    {
        
        Command_On.text = [NSString stringWithFormat:@"%@",
                           [df stringFromDate:datepicker.date]];
    }
    else{
        Posted_On.text = [NSString stringWithFormat:@"%@",
                          [df stringFromDate:datepicker.date]];
        
    }
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
    
}


-(IBAction)nook:(id)sender
{
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
}




-(void) callBack:(NSArray *)META  :(NSArray *)DATA
{
    NSLog(@"meta=====%@",META);
    NSLog(@"data=====%@",DATA);
    
    if(iscallback==0)
    {
        quesAr= [[META valueForKey:@"data"] valueForKey:@"getBoardCmnt"];
        metaBrd=META;
        
        iscallback=1;
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%d",b_id] forKey:@"id"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getBoardCmnts" :@"":@"":dic :self];
    }
    else if (iscallback==1)
    {
        
        commentBAr=DATA;
        [self showCommntView :commentBAr:metaBrd];
        
    }
    
    else if (iscallback==2)
    {
        
        dataind=DATA;
        [self showInd];
    }
    else if (iscallback==3)
    {
        subdataind=DATA;
        [self showSubInd];
    }
    else if (iscallback==4)
    {
        inviteAr=DATA;
        [self privateView:vc1];
    }
    else if (iscallback==5)
    {
        
        inviteAr=DATA;
        [inviteTableView reloadData];
    }
    else if (iscallback==6)
    {
        
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"sharedIndustrySearch"];
        [backData addObject:DATA];
        
        [self dissmisspop];
    }
    else if (iscallback==7)
    {
        
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"CommunityIndustrySearch"];
        [backData addObject:DATA];
        [self dissmisspop];
    }
    else if (iscallback==8)
    {
        
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"MyboardAdvanceSearch"];
        [backData addObject:DATA];
        [backData addObject:[NSString stringWithFormat:@"%d",isempty]];
        [self dissmisspop];
    }
    else if (iscallback==9)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"sharedAdvanceSearch"];
        [backData addObject:DATA];
          [backData addObject:[NSString stringWithFormat:@"%d",isempty]];
        [self dissmisspop];
    }
    else if (iscallback==10)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"CommunityAdvanceSearch"];
        [backData addObject:DATA];
           [backData addObject:[NSString stringWithFormat:@"%d",isempty]];
        [self dissmisspop];
    }
    else if (iscallback==11)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"industySearch"];
        [backData addObject:DATA];
        
        [self dissmisspop];
    }
    else if (iscallback==12)
    {
        
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"industySearch"];
        [backData addObject:DATA];
        NSLog(@"value in erecent pod backdata %@",backData);
        [self dissmisspop];
    }
    else if (iscallback==13)
    {
        NSArray * isSaved=[[META  valueForKey:@"data"] valueForKey:@"invite"];
        NSString *iscreated=[isSaved valueForKey:@"affectedRows"];
        NSLog(@"affected rows=====%@",iscreated);
        
        if([iscreated intValue]>0){
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Board Created Successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
            
            backData=[[NSMutableArray alloc]init];
            [backData addObject:@"newboard"];
            [backData addObject:DATA];
            [self dissmisspop];
        }else{
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Board Not Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
            
            [self dissmisspop];
        }
    }
    
    else if (iscallback==14)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"sortby"];
        [backData addObject:DATA];
        [self dissmisspop];
        
    }
    else if (iscallback==15)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"Sharedsortby"];
        [backData addObject:DATA];
        [self dissmisspop];
    }
    else if (iscallback==16)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"Communitysortby"];
        [backData addObject:DATA];
        [self dissmisspop];
    }
    else if (iscallback==17)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"podindustry"];
        [backData addObject:DATA];
        [self dissmisspop];
        
    }
    else if (iscallback==18)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"awardjobindustry"];
        [backData addObject:DATA];
        [backData addObject:[NSString stringWithFormat:@"%d",0]];
        [self dissmisspop];
        
    }
    
    else if (iscallback==19)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"appliedjobindustry"];
        [backData addObject:DATA];
        [backData addObject:[NSString stringWithFormat:@"%d",0]];
        [self dissmisspop];
        
    }
    
    
    else if (iscallback==20)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"sharedpodindustry"];
        [backData addObject:DATA];
        [self dissmisspop];
    }
    
    else if (iscallback==21)
    {
        
        //        commentBAr=DATA;
        //        [self dissmisspop];
        //        [commentTableView reloadData];
    }
    
    else if (iscallback==22)
    {
        NSArray *newdata= [META valueForKey:@"data"];
        cbntAr=[newdata valueForKey:@"friend"];
        [self shareTable];
        
    }
    else if (iscallback==23)
    {
        NSArray *netdata=  [META valueForKey:@"data"];
        netwrkAr=[netdata valueForKey:@"friend"];
        [self networkTable];
    }
    else if (iscallback==24)
    {
        cbntAr=DATA;
        [ProyolkTableView reloadData];
    }
    else if (iscallback==25)
    {
        netwrkAr=DATA;
        [networkTableview reloadData];
    }
    else if (iscallback==26)
    {
        proylkAr=DATA;
        NSLog(@"proyolAr is %@",proylkAr);
        [self proyolkTable];
    }
    else if (iscallback==27)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"PostedSearch"];
        [backData addObject:DATA];
        [backData addObject:[NSString stringWithFormat:@"%d",0]];
        [self dissmisspop];
    }
    else if (iscallback==28)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"AllProjectSearch"];
        [backData addObject:DATA];
        [backData addObject:[NSString stringWithFormat:@"%d",0]];
        [self dissmisspop];
    }
    else if (iscallback==29)
    {
        NSLog(@"board is applied");
        
        NSString *val=[[META  valueForKey:@"dt"] valueForKey:@"affectedRows"];
        
        if([val intValue]>0)
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Successfully Applied" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
            //[self dissmisspop];
            apply.userInteractionEnabled=NO;
           // apply.backgroundColor=[UIColor lightGrayColor];
            [apply setTitle:@"Applied" forState:UIControlStateNormal];
        }
        else
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Not Applied" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alrt show];
            apply.userInteractionEnabled=YES;
            [apply setTitle:@"APPLY" forState:UIControlStateNormal];
        }
        
        
    }
    else if (iscallback==30)
    {
        commentBAr=DATA;
        [self dissmisspop];
        [commentTableView reloadData];
    }
    else if (iscallback==31)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"myboardIndustry"];
        [backData addObject:DATA];
        [self dissmisspop];
   
    }
    else if (iscallback==2001){
        NSDictionary* metaDict = (NSDictionary*)META;
        sharedUsers = metaDict[@"data"][@"getBoardPart"];
        pendingUsers = metaDict[@"data"][@"getbrdcmnt"];
        [shareUsersTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        [pendingUsersTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }
}

@end


