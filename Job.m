
#import "Job.h"
#import "SavePrefrences.h"
#import "BoardPopUp.h"
#import "Jobpopup.h"
#import "LeftRightDrawer.h"
#import "AllValidationsViewController.h"
#import "ManageArray.h"
#import "CommonProfile.h"
#import "JobsViewController.h"
#import "ChatViewController.h"

@interface Job ()
{
    
    UIView *actionView,*middle_label,*option,*main,*podcast_details,*main1;
    UIScrollView *scrollbar;
    UILabel *job_lbl,*job_lbl1,*project_lbl1,*NameLabel,* project_lbl,*interview_lbl,*recruitment;
    UILabel *allprojects,*postedProject,*country,*sate,*city,*Select_Industry,*Select_Sub_Industry;
    UIView *JobBarView,*prMainView;
    int tag,iscallback,cellheight,whichto;
    UIViewController *vc1;
    LeftRightDrawer *drawer;
    BoardPopUp *bpop;
    Jobpopup *jpop;
    NSArray *applicantAr;
    NSMutableArray *applidjobAr,*postedProjectAr,*awrdJobAr,*allProAr;
    AllValidationsViewController *av;
    UILabel *appliedjob,*awardedjob,*notification_bar2;
    NSString *jobId;
    UITextField *searchapply;
    NSMutableArray *popUpAr,*JobAr;
    UIImageView *add;
    int isbar;
    NSString *u_id;
    int jobid1,limit,showawadjobpop,showpopallproject;
    UIButton *acppt,*decline;
    ManageArray *mang;
    int friendid,height,showpopfrapply,showpopProject;
    CommonProfile *mpop;
    float scrollpostion;
    NSDictionary* advSearchParams;
  }
@end

@implementation Job
@synthesize jobAppliedTableview,jobAwaredjobtableview,poprojectTableView,allPoTableView,applicantTableView,mynotification;
- (void)viewDidLoad {
    [super viewDidLoad];
    drawer=[[LeftRightDrawer alloc]init];
    bpop=[[BoardPopUp alloc]init];
    jpop=[[Jobpopup alloc]init];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.view.backgroundColor=[UIColor colorWithRed:189.0f/255 green:189.0f/255 blue:189.0f/255 alpha:1.0f];
    av=[[AllValidationsViewController alloc]init];
    bpop=[[BoardPopUp alloc]init];
    
    //  [self reteriveAppliedJob];
    
    mang=[[ManageArray alloc]init];
    mpop=[[CommonProfile alloc]init];
    [self retrieveJobNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortJobsList:) name:@"JOB_SORT_CHANGE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(advanceJobSearch:) name:@"JOB_ADVANCE_SEARCH" object:nil];

}

- (void)sortJobsList:(NSNotification*)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(advSearchParams) [self advanceBoardSearchCall:advSearchParams];
        if (searchapply.text.length) {
            [self searchAppliedJob];
        }else{
            if (whichto==0) {
                [self reteriveAppliedJob];
            }else if (whichto==1){
                [self reteriveAwardedJob];
            }else if (whichto==3){
                [self reterivePostedProjects];
            }else if (whichto==4){
                [self reteriveAllProjects];
            }
        }
    });
}

- (void)advanceJobSearch:(NSNotification*)notification{
    NSDictionary* dataDict = notification.userInfo;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self advanceBoardSearchCall:dataDict];
    });
}

- (void)advanceBoardSearchCall:(NSDictionary*)dataDict{
    NSMutableDictionary* tempDict = dataDict.mutableCopy;
    [tempDict setValue:[self getSortKey] forKey:@"val"];
    advSearchParams = tempDict.copy;
    
    if(whichto==0)//award job
    {
        applidjobAr = [[NSMutableArray alloc]init];
        iscallback=0;
        [[SavePrefrences sharedInstance].skthand emitData:@"AppliedJobs" :@"advncJobTabJob" :@"":@"":advSearchParams :self];
    }
    else if(whichto==1)//applied job
    {
        awrdJobAr=[[NSMutableArray alloc]init];
        iscallback=1;
        [[SavePrefrences sharedInstance].skthand emitData:@"AwardJobs" :@"advncopenJob" :@"":@"":advSearchParams :self];
        
    }
    else if (whichto==3)
    {
        postedProjectAr=[[NSMutableArray alloc]init];
        iscallback=3;
        [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"advncpstdjob" :@"":@"":advSearchParams :self];
    }
    else if (whichto==4)
    {
        allProAr=[[NSMutableArray alloc]init];
        iscallback=4;
        [[SavePrefrences sharedInstance].skthand emitData:@"AllProjects" :@"advncJobPosted" :@"":@"":advSearchParams :self];
    }
}


-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{
    av=[[AllValidationsViewController alloc]init];
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];
    if([popUpAr count]>0){
        [popUpAr addObject:prMainView];
    }
    else{
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-70, 50)];
    NameLabel.text=title;
    NameLabel.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    NameLabel.textColor=[UIColor blackColor];
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [prMainView addSubview:NameLabel];
    
    
    UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel.frame.size.width+NameLabel.frame.origin.x, [SavePrefrences sharedInstance ].naviHght+15, 30, 50)];
    closeView.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
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
    
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    scrollbar.backgroundColor=[ff valueForKey:@"popupcolor"];
    [prMainView addSubview:scrollbar];
    
    
    return prMainView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)retrieveJobNotifications
{
    
    NSLog(@"Job notification is %@",[SavePrefrences sharedInstance].allNotifictionDic);
    JobAr=[[NSMutableArray alloc]init];
    
    if([[SavePrefrences sharedInstance].allNotifictionDic count]>0)
    {
        JobAr=[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"29"];
        
    }
    
    for (NSInteger i = (int)JobAr.count - 1; i >= 0 ; i--)
    {
        NSString * time=[[JobAr valueForKey:@"time"] objectAtIndex:i];
        // NSString * ntc= [[JobAr valueForKey:@"ntc"] objectAtIndex:i];
        
        //if(([ntc intValue]==11)||([ntc intValue]==12)||([ntc intValue]==13)||([ntc intValue]==14)||([ntc intValue]==15))
        {
            if([[[SavePrefrences sharedInstance].notiWithoutADR allKeys] containsObject:time])
            {
                [JobAr removeObjectAtIndex:i];
            }
            else
            {
                [[SavePrefrences sharedInstance].notiWithoutADR setValue:time forKey:time];
            }
        }
        
    }
    
    
    [SavePrefrences sharedInstance].ischkjob=@"1";
    
    NSLog(@"board array is %@",JobAr);
    [self customizeActionBar];
}
-(void)customizeActionBar
{
    [drawer initArs:self];
    if([JobAr count]>0)
    {
        [self setTabBarWithNotifications];
    }
    else
    {
        [self setTabBar];
    }
    
}

// tab2 job  [UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f]
// tab3 proj  [UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f]
// tab1 noti  [UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f]

- (NSString*)getSortKey{
    NSString* sortKey = [[NSUserDefaults standardUserDefaults] valueForKey:@"JOB_SORT_KEY"];
    if (!sortKey.length) sortKey = @"1";
    return sortKey;
}

#pragma mark tabSetup
-(void) setTabBarWithNotifications
{
    tag=0;
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    
    option=[[UIView alloc]initWithFrame:CGRectMake(0, 70,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    option.backgroundColor=[stack valueForKey:@"backcolor"];
    [self.view addSubview:option];
    
    int hght=(option.frame.size.height-100)/4;
    float lty=(hght)/4;
    NSLog(@"hght===== %d",hght);
    NSLog(@"lty========= %f",lty);
    
    UILabel *Notification=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [SavePrefrences sharedInstance].screenWidth/3 , lty)];
    Notification.text=@"Notification";
    Notification.userInteractionEnabled=false;
    Notification.textAlignment=NSTextAlignmentCenter;
    [Notification setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Notification.backgroundColor=[UIColor clearColor];
    Notification.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    [option addSubview:Notification];
    
    notification_bar2=[[UILabel alloc]initWithFrame:CGRectMake(0,Notification.frame.size.height+Notification.frame.origin.y,[SavePrefrences sharedInstance].screenWidth/4, 3)];
    notification_bar2.backgroundColor=[stack valueForKey:@"Videocolor"];
    [option addSubview:notification_bar2];
    
    UITapGestureRecognizer *notificationReg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jobNotiView)];
    [notificationReg setNumberOfTouchesRequired:1];
    [notificationReg setDelegate:self];
    Notification.userInteractionEnabled = YES;
    Notification.tag=0;
    [Notification addGestureRecognizer:notificationReg];
    
    
    job_lbl=[[UILabel alloc]initWithFrame:CGRectMake(Notification.frame.size.width+Notification.frame.origin.x, 0, [SavePrefrences sharedInstance].screenWidth/4,lty)];
    job_lbl.text=@"Jobs";
    job_lbl.textAlignment=NSTextAlignmentCenter;
    [job_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    job_lbl.backgroundColor=[stack valueForKey:@"backcolor"];
    job_lbl.textColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    [option addSubview:job_lbl];
    
    job_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(Notification.frame.size.width+Notification.frame.origin.x, job_lbl.frame.size.height+job_lbl.frame.origin.y, [SavePrefrences sharedInstance].screenWidth/4, 3)];
    //job_lbl1.backgroundColor=[stack valueForKey:@"Profcolor"];
    job_lbl1.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];

    [option addSubview:job_lbl1];
    

    
    UITapGestureRecognizer *Myjobreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(JobBar)];
    [Myjobreg setNumberOfTouchesRequired:1];
    [Myjobreg setDelegate:self];
    job_lbl.userInteractionEnabled = YES;
    [job_lbl addGestureRecognizer:Myjobreg];
    
    project_lbl=[[UILabel alloc]initWithFrame:CGRectMake(job_lbl.frame.size.width+job_lbl.frame.origin.x,0, [SavePrefrences sharedInstance].screenWidth/4,lty)];
    project_lbl.text=@"Projects";
    project_lbl.textAlignment=NSTextAlignmentCenter;
    [project_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    project_lbl.backgroundColor=[stack valueForKey:@"backcolor"];
    project_lbl.textColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    [option addSubview:project_lbl];
    
    project_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(job_lbl.frame.size.width+job_lbl.frame.origin.x,project_lbl.frame.size.height+project_lbl.frame.origin.y , [SavePrefrences sharedInstance].screenWidth/4,3)];
    project_lbl1.backgroundColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    [option addSubview:project_lbl1];
    
    
    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, job_lbl.frame.size.height+job_lbl.frame.origin.y, option.frame.size.height, 1)];
    lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [option addSubview:lblLine];

    
    UITapGestureRecognizer *MyProjectreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ProjectBar)];
    [MyProjectreg setNumberOfTouchesRequired:1];
    [MyProjectreg setDelegate:self];
    project_lbl.userInteractionEnabled = YES;
    [project_lbl addGestureRecognizer:MyProjectreg];
    
    
    
    
    
    JobBarView=[[UIView alloc]initWithFrame:CGRectMake(0, job_lbl1.frame.size.height+job_lbl1.frame.origin.y, [SavePrefrences sharedInstance].screenWidth, lty)];
    JobBarView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    JobBarView.hidden=true;
    [option addSubview:JobBarView];
    
    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, JobBarView.frame.size.height+JobBarView.frame.origin.y, [SavePrefrences sharedInstance].screenWidth,lty)];
    middle_label.hidden=true;
    middle_label.backgroundColor=[stack valueForKey:@"clearColor"];
    [option addSubview:middle_label];
    
   [self jobNotiView];
    
    
    
//    project_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(job_lbl.frame.size.width+job_lbl.frame.origin.x,project_lbl.frame.size.height+project_lbl.frame.origin.y , [SavePrefrences sharedInstance].screenWidth/3,3)];
//    project_lbl1.backgroundColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
//    [option addSubview:project_lbl1];
    
    
//    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, job_lbl.frame.size.height+job_lbl.frame.origin.y, option.frame.size.height, 1)];
//    lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
//    [option addSubview:lblLine];
    
    
    
}

#pragma mark jobNotiView
-(void)jobNotiView
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    project_lbl1.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Educolor"];
    job_lbl1.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Profcolor"];
    notification_bar2.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff  valueForKey:@"Videocolor"];
   
    JobBarView.hidden=true;
    middle_label.hidden=true;
    [jobAwaredjobtableview removeFromSuperview];
    [jobAppliedTableview removeFromSuperview];
    [allPoTableView removeFromSuperview];
    [poprojectTableView removeFromSuperview];
    
    
    
    NSLog(@"job notifications");
    mynotification =  [[UITableView alloc] initWithFrame:CGRectMake(5,notification_bar2.frame.size.height+notification_bar2.frame.origin.y+10,[SavePrefrences sharedInstance].screenWidth-10,[SavePrefrences sharedInstance].screenHeight-100)];
    mynotification.delegate = self;
    mynotification.dataSource = self;
    mynotification.scrollEnabled = YES;
    mynotification.backgroundColor=[ff valueForKey:@"backcolor"];
    mynotification.separatorColor=[ff valueForKey:@"backcolor"];
    [option addSubview:mynotification];
    
}

#pragma mark 2 Tabs without notification
-(void) setTabBar
{
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    tag=0;
    option=[[UIView alloc]initWithFrame:CGRectMake(0, 70, [SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    //option.backgroundColor=[UIColor blackColor];
    option.backgroundColor=[stack valueForKey:@"backcolor"];
    [self.view addSubview:option];
    
    int hght=(option.frame.size.height-100)/4;
    float lty=(hght)/4;
    NSLog(@"hght===== %d",hght);
    NSLog(@"lty========= %f",lty);
    
    job_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [SavePrefrences sharedInstance].screenWidth/4,lty)];
    job_lbl.text=@"Jobs";
    job_lbl.textAlignment=NSTextAlignmentCenter;
    [job_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    job_lbl.backgroundColor=[stack valueForKey:@"backcolor"];
    job_lbl.textColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    [option addSubview:job_lbl];
    
    job_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, job_lbl.frame.size.height+job_lbl.frame.origin.y, [SavePrefrences sharedInstance].screenWidth/4, 3)];
    job_lbl1.backgroundColor=[UIColor clearColor];
    [option addSubview:job_lbl1];
    
    UITapGestureRecognizer *Myjobreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(JobBar)];
    [Myjobreg setNumberOfTouchesRequired:1];
    [Myjobreg setDelegate:self];
    job_lbl.userInteractionEnabled = YES;
    [job_lbl addGestureRecognizer:Myjobreg];
    
    
    
    project_lbl=[[UILabel alloc]initWithFrame:CGRectMake(job_lbl.frame.size.width+job_lbl.frame.origin.x,0, [SavePrefrences sharedInstance].screenWidth/4,lty)];
    project_lbl.text=@"Projects";
    project_lbl.textAlignment=NSTextAlignmentCenter;
    [project_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    project_lbl.backgroundColor=[stack valueForKey:@"backcolor"];
    project_lbl.textColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    [option addSubview:project_lbl];
    
    project_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(job_lbl.frame.size.width+job_lbl.frame.origin.x-0.4,project_lbl.frame.size.height+project_lbl.frame.origin.y, [SavePrefrences sharedInstance].screenWidth/4,3)];
    project_lbl1.backgroundColor=[UIColor clearColor];
    [option addSubview:project_lbl1];
    UITapGestureRecognizer *MyProjectreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ProjectBar)];
    [MyProjectreg setNumberOfTouchesRequired:1];
    [MyProjectreg setDelegate:self];
    project_lbl.userInteractionEnabled = YES;
    [project_lbl addGestureRecognizer:MyProjectreg];
    
    
    interview_lbl=[[UILabel alloc]initWithFrame:CGRectMake(project_lbl1.frame.size.width+project_lbl1.frame.origin.x,0, [SavePrefrences sharedInstance].screenWidth/4,lty)];
    interview_lbl.text=@"Interview";
    interview_lbl.textAlignment=NSTextAlignmentCenter;
    [interview_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    interview_lbl.backgroundColor=[stack valueForKey:@"backcolor"];
    interview_lbl.textColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    [option addSubview:interview_lbl];
    
    UITapGestureRecognizer *Myjobreg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(interviewBar)];
    [Myjobreg1 setNumberOfTouchesRequired:1];
    [Myjobreg1 setDelegate:self];
    interview_lbl.userInteractionEnabled = YES;
    [interview_lbl addGestureRecognizer:Myjobreg1];
    
    recruitment=[[UILabel alloc]initWithFrame:CGRectMake(interview_lbl.frame.size.width+interview_lbl.frame.origin.x,0, [SavePrefrences sharedInstance].screenWidth/4,lty)];
    recruitment.text=@"Recruitment";
    recruitment.textAlignment=NSTextAlignmentCenter;
    [recruitment setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    recruitment.backgroundColor=[stack valueForKey:@"backcolor"];
    recruitment.textColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    [option addSubview:recruitment];
    
//    project_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(job_lbl.frame.size.width+job_lbl.frame.origin.x-0.4,project_lbl.frame.size.height+project_lbl.frame.origin.y, [SavePrefrences sharedInstance].screenWidth/4,3)];
//    project_lbl1.backgroundColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
//    [option addSubview:project_lbl1];
    
    
    
    
    JobBarView=[[UIView alloc]initWithFrame:CGRectMake(0, job_lbl1.frame.size.height+job_lbl1.frame.origin.y, [SavePrefrences sharedInstance].screenWidth, lty)];
    JobBarView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    JobBarView.hidden=true;
    [option addSubview:JobBarView];
    
    
    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, JobBarView.frame.size.height+JobBarView.frame.origin.y, [SavePrefrences sharedInstance].screenWidth,lty)];
    middle_label.backgroundColor=[stack valueForKey:@"clearColor"];
    [option addSubview:middle_label];
    UITapGestureRecognizer *Myjobreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recruitBar)];
    [Myjobreg2 setNumberOfTouchesRequired:1];
    [Myjobreg2 setDelegate:self];
    recruitment.userInteractionEnabled = YES;
    [recruitment addGestureRecognizer:Myjobreg2];
    [self JobBar];
    
}


-(void)interviewBar{
    if (self.containerView ) {
        [self.containerView removeFromSuperview];
    }
    [jobAppliedTableview removeFromSuperview];
    [jobAwaredjobtableview removeFromSuperview];
    [mynotification removeFromSuperview];
    JobBarView.hidden = true;

    [self clearSearchView];
    [allPoTableView removeFromSuperview];
    [poprojectTableView removeFromSuperview];
//    [mynotification removeFromSuperview];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"Interview"];
    [self addChildViewController:viewController];
    self.containerView = viewController.view;
    viewController.view.frame = option.frame;
    viewController.view.backgroundColor =[UIColor clearColor];
    [option addSubview:viewController.view];
    [option bringSubviewToFront:viewController.view];
    [viewController didMoveToParentViewController:self];

}
-(void)recruitBar{
    if (self.containerView ) {
        [self.containerView removeFromSuperview];
    }
    [jobAppliedTableview removeFromSuperview];
    [jobAwaredjobtableview removeFromSuperview];
    [mynotification removeFromSuperview];
    [self clearSearchView];
    JobBarView.hidden = true;
    [allPoTableView removeFromSuperview];
    [poprojectTableView removeFromSuperview];
    //[mynotification removeFromSuperview];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"JobsViewController"];
    [self addChildViewController:viewController];
    self.containerView = viewController.view;
    viewController.view.frame = option.frame;
     viewController.view.backgroundColor =[UIColor clearColor];
    [option addSubview:viewController.view];
    [option bringSubviewToFront:viewController.view];
    [viewController didMoveToParentViewController:self];

}


#pragma mark JobBar First
/*
 
 // tab2 job  [UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f]
 // tab3 proj  [UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f]
 // tab1 noti  [UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f]

 */
-(void)JobBar
{
    isbar=0;
    JobBarView.hidden = false;
    if (self.containerView ) {
          [self.containerView removeFromSuperview];
    }
  
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
   /* project_lbl1.backgroundColor=[stack valueForKey:@"Educolor"];
    notification_bar2.backgroundColor=[UIColor blackColor];
    job_lbl1.backgroundColor=[stack valueForKey:@"Videocolor"];*/
    
//    project_lbl1.backgroundColor=[UIColor clearColor];
//    notification_bar2.backgroundColor=[UIColor clearColor];
//    job_lbl1.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];

   /* int w =self.view.frame.size.width;
    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 1.25)];
    lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [JobBarView addSubview:lblLine];*/

    [allPoTableView removeFromSuperview];
    [poprojectTableView removeFromSuperview];
    [mynotification removeFromSuperview];
    
    JobBarView.hidden=false;
    middle_label.hidden=false;
    
    [postedProject setHidden:YES];
    [allprojects setHidden:YES];

    [self clearSearchView];
    //130:197:246
    appliedjob=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,JobBarView.frame.size.width/2, JobBarView.frame.size.height)];
    appliedjob.text=@"Awarded Jobs";
    appliedjob.textAlignment=NSTextAlignmentCenter;
    [appliedjob setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    appliedjob.backgroundColor=[UIColor colorWithRed:244.0/255 green:244.0/255 blue:255.0/255 alpha:1.0];
    appliedjob.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];

    [JobBarView addSubview:appliedjob];
    
    
   
    UITapGestureRecognizer *appliedjobreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reteriveAppliedJob)];
    [appliedjobreg setNumberOfTouchesRequired:1];
    [appliedjobreg setDelegate:self];
    appliedjob.userInteractionEnabled = YES;
    [appliedjob addGestureRecognizer:appliedjobreg];
    
    awardedjob=[[UILabel alloc]initWithFrame:CGRectMake(appliedjob.frame.size.width+appliedjob.frame.origin.x, 0, JobBarView.frame.size.width/2, JobBarView.frame.size.height)];
    awardedjob.text=@"Applied Jobs";
    awardedjob.textAlignment=NSTextAlignmentCenter;
    [awardedjob setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    awardedjob.backgroundColor=[UIColor colorWithRed:244.0/255 green:244.0/255 blue:255.0/255 alpha:1.0];
    awardedjob.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];

    [JobBarView addSubview:awardedjob];
    
    UITapGestureRecognizer *awardedjobreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reteriveAwardedJob)];
    [awardedjobreg setNumberOfTouchesRequired:1];
    [awardedjobreg setDelegate:self];
    awardedjob.userInteractionEnabled = YES;
    [awardedjob addGestureRecognizer:awardedjobreg];
    
    int divy=middle_label.frame.size.width/2;
    
    
    NSLog(@"wid==================== %d",(divy/2 - 65));
    NSLog(@"Inside seach view");
    searchapply=[[UITextField alloc]initWithFrame:CGRectMake(5, 3.5,divy+60,middle_label.frame.size.height-6)];
    searchapply.backgroundColor=[UIColor colorWithRed:225.0f/255 green:232.0f/255 blue:239.0f/255 alpha:1.0f];
   // searchapply.placeholder=@"Search";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    searchapply.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: color}];

    searchapply.layer.cornerRadius=1.5;
    searchapply.textColor=[UIColor colorWithRed:153.0f/255 green:152.0f/255 blue:152.0f/255 alpha:1.0f];
    searchapply.delegate=self;
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    searchapply.leftView = paddingView2;
    searchapply.leftViewMode = UITextFieldViewModeAlways;
     [searchapply addTarget:self action:@selector(searchAppliedJob:) forControlEvents:UIControlEventEditingChanged];
    [middle_label addSubview:searchapply];

    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(searchapply.frame.size.width+searchapply.frame.origin.x+5, 4,30,30)];
    searchbutton.backgroundColor=[UIColor clearColor];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAppliedJob)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:sworkingreg2];
    
    
    
   /* UIButton *industry_btn=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 3.5,divy/3 -30, middle_label.frame.size.height-6)];
    industry_btn.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
    [industry_btn setImage:[UIImage imageNamed:@"industry.png"] forState:UIControlStateNormal];
    industry_btn.tag=0;
    [industry_btn addTarget:self action:@selector(IndusSearch:) forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:industry_btn];*/
    
   // UIButton *advance=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 0,divy/3 -20, middle_label.frame.size.height)];
    UIButton *advance=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, -3, middle_label.frame.size.height+5 , middle_label.frame.size.height+5)];
    advance.backgroundColor=[UIColor clearColor];
    [advance setImage:[UIImage imageNamed:@"advance-search.png"] forState:UIControlStateNormal];
    [advance addTarget:self action:@selector(searchAdvance:) forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:advance];
    
    UIView *imgset=[[UIView alloc]initWithFrame:CGRectMake(advance.frame.size.width+advance.frame.origin.x+10, 0, 40, middle_label.frame.size.height)];
    imgset.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:imgset];
    
    
    UIImageView *three_dots=[[UIImageView  alloc]initWithFrame:CGRectMake(0, +3, 25, middle_label.frame.size.height-10)];
    three_dots.image=[UIImage imageNamed:@"more.png"];
    [imgset addSubview:three_dots];
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sortbyjob)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    imgset.userInteractionEnabled = YES;
    imgset.tag=0;
    [imgset addGestureRecognizer:sworkingreg];
    
    limit=0;
    scrollpostion=0;
    showpopfrapply=0;
    applidjobAr=[[NSMutableArray alloc]init];
    
    int w =self.view.frame.size.width;
    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 1.25)];
    lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [JobBarView addSubview:lblLine];
    
    [self reteriveAppliedJob];
}


#pragma mark ProjectBar Second

-(void)ProjectBar
{
    if (self.containerView ) {
        [self.containerView removeFromSuperview];
    }
    JobBarView.hidden = false;
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    
    isbar=1;
   /* project_lbl1.backgroundColor=[stack valueForKey:@"Videocolor"];
    job_lbl1.backgroundColor=[stack valueForKey:@"Profcolor"];
    notification_bar2.backgroundColor=[UIColor blackColor];*/
    
    
  /*  project_lbl1.backgroundColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    notification_bar2.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    job_lbl1.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];*/

//    project_lbl1.backgroundColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
//    notification_bar2.backgroundColor=[UIColor clearColor];
//    job_lbl1.backgroundColor=[UIColor clearColor];

    [jobAppliedTableview removeFromSuperview];
    [jobAwaredjobtableview removeFromSuperview];
    [mynotification removeFromSuperview];
    
   middle_label.hidden=false;
    JobBarView.hidden=false;
  
    [postedProject setHidden:NO];
    [allprojects setHidden:NO];

    [self clearSearchView];
    
    
    postedProject=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,JobBarView.frame.size.width/2, JobBarView.frame.size.height)];
    postedProject.text=@"Posted";
    postedProject.textAlignment=NSTextAlignmentCenter;
    [postedProject setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    postedProject.backgroundColor=[stack valueForKey:@"backcolor"];
    postedProject.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    [JobBarView addSubview:postedProject];
    
    
    UITapGestureRecognizer *projectobreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reterivePostedProjects)];
    [projectobreg setNumberOfTouchesRequired:1];
    [projectobreg setDelegate:self];
    postedProject.userInteractionEnabled = YES;
    [JobBarView addGestureRecognizer:projectobreg];
    
    allprojects=[[UILabel alloc]initWithFrame:CGRectMake(postedProject.frame.size.width+postedProject.frame.origin.x, 0, JobBarView.frame.size.width/2,  JobBarView.frame.size.height)];
    allprojects.text=@"All";
    allprojects.textAlignment=NSTextAlignmentCenter;
    [allprojects setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    allprojects.backgroundColor=[stack valueForKey:@"backcolor"];
    allprojects.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];
    [JobBarView addSubview:allprojects];
    
    UITapGestureRecognizer *appliedjobreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reteriveAllProjects)];
    [appliedjobreg setNumberOfTouchesRequired:1];
    [appliedjobreg setDelegate:self];
    allprojects.userInteractionEnabled = YES;
    [allprojects addGestureRecognizer:appliedjobreg];
    
    
    
    
    int divy=middle_label.frame.size.width/2;
    
    searchapply=[[UITextField alloc]initWithFrame:CGRectMake(5, 3.5,divy+40,middle_label.frame.size.height-6)];
    searchapply.placeholder=@"Search";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    searchapply.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: color}];

    searchapply.layer.cornerRadius=1.5;
    searchapply.delegate=self;
    searchapply.backgroundColor=[UIColor colorWithRed:225.0f/255 green:232.0f/255 blue:239.0f/255 alpha:1.0f];;
    searchapply.textColor=[UIColor colorWithRed:153.0f/255 green:152.0f/255 blue:152.0f/255 alpha:1.0f];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    searchapply.leftView = paddingView2;
    searchapply.leftViewMode = UITextFieldViewModeAlways;
    [middle_label addSubview:searchapply];
    
    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(searchapply.frame.size.width+searchapply.frame.origin.x+5,4, 25,middle_label.frame.size.height-12)];
    searchbutton.backgroundColor=[UIColor clearColor];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAppliedJob)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:sworkingreg2];
    
    
    
   /* UIButton *industry_btn=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 3.5, divy/3-30, middle_label.frame.size.height-6)];
    industry_btn.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
    [industry_btn setImage:[UIImage imageNamed:@"industry.png"] forState:UIControlStateNormal];
    industry_btn.tag=0;
    [industry_btn addTarget:self action:@selector(IndusSearch:) forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:industry_btn];*/
    

    UIButton *advance=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, -3,middle_label.frame.size.height+5, middle_label.frame.size.height+5)];
    
    advance.backgroundColor=[UIColor clearColor];
    [advance setImage:[UIImage imageNamed:@"advance-search.png"] forState:UIControlStateNormal];
    [advance addTarget:self action:@selector(searchAdvance:) forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:advance];
    
    
    UIView *addit=[[UIView alloc]initWithFrame:CGRectMake(advance.frame.size.width+advance.frame.origin.x, 0-2, 40, middle_label.frame.size.height+5)];
    addit.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:addit];
    
    add=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  middle_label.frame.size.height, middle_label.frame.size.height)];
    add.image=[UIImage imageNamed:@"addfolderwhite.png"];
    [addit addSubview:add];
    
    UITapGestureRecognizer *sworkingreg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddnewProject)];
    [sworkingreg1 setNumberOfTouchesRequired:1];
    [sworkingreg1 setDelegate:self];
    addit.userInteractionEnabled = YES;
    [addit addGestureRecognizer:sworkingreg1];
    
    UIView *imgset=[[UIView alloc]initWithFrame:CGRectMake(addit.frame.size.width+addit.frame.origin.x, 0, 35, middle_label.frame.size.height)];
    imgset.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:imgset];
    
    
    UIImageView *three_dots=[[UIImageView  alloc]initWithFrame:CGRectMake(0, +3, 25, middle_label.frame.size.height-10)];
    three_dots.image=[UIImage imageNamed:@"more.png"];
    [imgset addSubview:three_dots];
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sortbyjob)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    imgset.userInteractionEnabled = YES;
    imgset.tag=0;
    [imgset addGestureRecognizer:sworkingreg];
    
    int w =self.view.frame.size.width;
    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 1.25)];
    lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [JobBarView addSubview:lblLine];
    

    [self reterivePostedProjects];
    
}



-(void)clearSearchView
{
    NSArray *search=[middle_label subviews];
    for(UIView *f in search)
    {
        [f removeFromSuperview];
    }
    
}

-(void)reteriveAppliedJob // this is award job
{
    appliedjob.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[stack valueForKey:@"Videocolor"];
    awardedjob.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[stack valueForKey:@"Yellowbtncolor"];
    
    [jobAwaredjobtableview removeFromSuperview];
    iscallback=0;
    scrollpostion=0;
    limit=0;
    [applidjobAr removeAllObjects];
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [dic setValue:[self getSortKey] forKey:@"val"];
    [[SavePrefrences sharedInstance].skthand emitData:@"AppliedJobs" :@"getopenJobs" :@"":@"":dic :self];
}


-(void)reteriveAwardedJob // this is applied job
{
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    awardedjob.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[stack valueForKey:@"Yellowbtncolor"];
   appliedjob.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];
    //[stack valueForKey:@"Videocolor"];
    
    [jobAppliedTableview removeFromSuperview];
    
    limit=0;
    scrollpostion=0;
    awrdJobAr=[[NSMutableArray alloc]init];
    showawadjobpop=0;
    [self reterievAwardJobAr1];
    
}

-(void)reterievAwardJobAr1
{
     iscallback=1;
     NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [dic setValue:[self getSortKey] forKey:@"val"];
    [[SavePrefrences sharedInstance].skthand emitData:@"AwardJobs" :@"showAppliedJobs" :@"":@"":dic :self];
}




-(void)reteriveAllProjects
{
    
    
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    postedProject.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];
    allprojects.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    
    
    [poprojectTableView removeFromSuperview];
    
    limit=0;
    scrollpostion=0;
    showpopallproject=0;
    allProAr=[[NSMutableArray alloc]init];
    [self reteriveAllProjects1];
    
}

-(void) reteriveAllProjects1
 {
     iscallback=4;
      NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
     [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
     [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
     [dic setValue:[self getSortKey] forKey:@"val"];
     [[SavePrefrences sharedInstance].skthand emitData:@"AllProjects" :@"getAllJobs" :@"":@"":dic :self];
 }



-(void)reterivePostedProjects
{
    limit=0;
    scrollpostion=0;
    showpopProject=0;
    postedProjectAr=[[NSMutableArray alloc]init];
    
    [self reterivePostedProject1];
    
}

-(void)reterivePostedProject1
{
    iscallback=3;
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    postedProject.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    allprojects.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [dic setValue:[self getSortKey] forKey:@"val"];
    [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"getJobsPosted" :@"":@"":dic :self];
    
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"predddd");
    [textField resignFirstResponder];
    return YES;
}

-(void) searchAppliedJob
{
   
    limit=0;
    scrollpostion=0;
    [applidjobAr removeAllObjects];
    [postedProjectAr removeAllObjects];
    [self searchAppliedJob1];
}

-(void) searchAppliedJob1
{
    NSLog(@"search applied");
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:@"" forKey:@"ind"];
    [dic setValue:@"" forKey:@"top"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [dic setValue:searchapply.text forKey:@"key"];
    [dic setValue:[self getSortKey] forKey:@"val"];
    iscallback=5;
    
    if(whichto==0)
    {
        [[SavePrefrences sharedInstance].skthand emitData:@"AppliedJobs" :@"srchopenJobs" :@"":@"":dic :self];
    }
    else if(whichto==1)
    {
        [[SavePrefrences sharedInstance].skthand emitData:@"AwardJobs" :@"srchappliedJobs" :@"":@"":dic :self];
    }
    else if (whichto==3)
    {
        [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"srchpstdJobs" :@"":@"":dic :self];
    }
    else if (whichto==4)
    {
        [[SavePrefrences sharedInstance].skthand emitData:@"AllProjects" :@"srchAllJobs" :@"":@"":dic :self];
    }
}


-(IBAction)IndusSearch:(id)sender
{
    
    if(whichto==0)
    {
        // bpop=[[BoardPopUp alloc]init];
        [bpop IndustrySearch :self:100:0];
    }
    else if(whichto==1)
    {
        // bpop=[[BoardPopUp alloc]init];
        [bpop IndustrySearch :self:101:0];
    }
    else if(whichto==3)
    {
        // bpop=[[BoardPopUp alloc]init];
        [bpop IndustrySearch :self:104:0];
    }
    else if(whichto==4)
    {
        // bpop=[[BoardPopUp alloc]init];
        [bpop IndustrySearch :self:105:0];
    }
}

-(void)showAppliedJob
{
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    
    [jobAwaredjobtableview removeFromSuperview];
    whichto=0;
    jobAppliedTableview = [[UITableView alloc] initWithFrame:CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y+10,[SavePrefrences sharedInstance].screenWidth,([SavePrefrences sharedInstance].screenHeight)-(middle_label.frame.size.height+middle_label.frame.origin.y+90))];
    jobAppliedTableview.delegate = self;
    jobAppliedTableview.dataSource = self;
    jobAppliedTableview.scrollEnabled = YES;
    jobAppliedTableview.backgroundColor=[stack valueForKey:@"backcolor"];
    jobAppliedTableview.separatorColor=[stack valueForKey:@"backcolor"];
    [option addSubview:jobAppliedTableview];
    
}

-(void)showAwardedJob
{
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    
    [jobAppliedTableview removeFromSuperview];
    
    whichto=1;
    jobAwaredjobtableview = [[UITableView alloc] initWithFrame:CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y+10,[SavePrefrences sharedInstance].screenWidth,([SavePrefrences sharedInstance].screenHeight)-(middle_label.frame.size.height+middle_label.frame.origin.y+90))];
    jobAwaredjobtableview.delegate = self;
    jobAwaredjobtableview.dataSource = self;
    jobAwaredjobtableview.scrollEnabled = YES;
    jobAwaredjobtableview.backgroundColor=[stack valueForKey:@"backcolor"];
    jobAwaredjobtableview.separatorColor=[stack valueForKey:@"backcolor"];
    [option addSubview:jobAwaredjobtableview];
    
}


#pragma mark tableView
-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if(theTableView==jobAppliedTableview)
    {
        cellheight=200;
        return [applidjobAr count];
    }
    
    else  if(theTableView==jobAwaredjobtableview)
    {
        cellheight=200;
        return [awrdJobAr count];
    }
    
    else if(theTableView==poprojectTableView)
    {
        cellheight=150;
        return [postedProjectAr count];
    }
    
    else if(theTableView==allPoTableView)
    {
        cellheight=200;
        return [allProAr count];
    }
    else if (theTableView==applicantTableView)
    {
        cellheight=100;
        return [applicantAr count];
    }
    else if (theTableView==mynotification)
    {
        cellheight=112;
        
        
        int cnt=0;
        return [JobAr count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.jobAppliedTableview dequeueReusableCellWithIdentifier:MyCellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.backgroundColor=[stack valueForKey:@"backcolor"];
    
    if(theTableView==jobAppliedTableview)
    {
        [jobAwaredjobtableview removeFromSuperview];
        [poprojectTableView removeFromSuperview];
        [allPoTableView removeFromSuperview];
        [applicantTableView removeFromSuperview];
        [mynotification removeFromSuperview];
        
        UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 0, jobAppliedTableview.frame.size.width-10, cellheight)];
        cell_View.backgroundColor=[UIColor clearColor];
        [cell addSubview: cell_View];
        
        UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openApplidJobdetail :)];
        [prev setNumberOfTouchesRequired:1];
        [prev setDelegate:self];
        cell_View.tag=indexPath.row;
        cell_View.userInteractionEnabled = YES;
        [cell_View addGestureRecognizer:prev];
        
        NSString *title=[[applidjobAr objectAtIndex:indexPath.row]valueForKey:@"title"];
        NSString *durationa=[[applidjobAr objectAtIndex:indexPath.row]valueForKey:@"duration"];
        NSString *job_desc=[[applidjobAr objectAtIndex:indexPath.row]valueForKey:@"job_desc"];
        NSString *job_id=[[applidjobAr objectAtIndex:indexPath.row]valueForKey:@"job_id"];
        NSString *timelog=[[applidjobAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];
        NSString *u_id=[[applidjobAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *uname=[[applidjobAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *imge1=[[applidjobAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        NSString *status=[[applidjobAr objectAtIndex:indexPath.row]valueForKey:@"status"];
        
        NSLog(@"print jobid %@",job_id);
        
        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell_View.frame.size.width-10, 25) ];
        if([av checkNullStr:title])
        {
            title_lbl.text=[NSString stringWithFormat:@"%@",title];
        }
        title_lbl.textColor=[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0];
        title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        title_lbl.textAlignment=NSTextAlignmentLeft;
        [cell_View addSubview:title_lbl];
        
        
        UILabel *TimeTitle=[[UILabel alloc] initWithFrame:CGRectMake( 5, 6, cell_View.frame.size.width-15, 25)];
        TimeTitle.text=@"24/06/2016";
        TimeTitle.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        TimeTitle.textColor=[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0];
        TimeTitle.textAlignment=NSTextAlignmentRight;
        TimeTitle.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:TimeTitle];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y+2,cell_View.bounds.size.width-15,1)];
        separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
        [cell_View addSubview:separator];

        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, separator.frame.size.height+separator.frame.origin.y+3, 50, 50)];
        img.image=[UIImage imageNamed:@"pictureicn.png"];
        img.layer.cornerRadius=25;
        img.clipsToBounds=YES;
        [cell_View addSubview:img];
        
        NSString * url=[mang concatUrl:imge1];
        if(url.length<12)
        {
            img.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            if (imageData.length<=0)
                img.image = [UIImage imageNamed:@"username.png"];
            else
                img.image = [UIImage imageWithData:imageData];
        }
        
        
        /* UIImageView *imgdel=[[UIImageView alloc]initWithFrame:CGRectMake(podcast_details.frame.size.width-20, 5, 20, 20)];
         imgdel.image=[UIImage imageNamed:@"delete.png"];
         [cell_View addSubview:imgdel];*/
        
        UITapGestureRecognizer *imagereg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openFriendProfile:)];
        [imagereg setNumberOfTouchesRequired:1];
        [imagereg setDelegate:self];
        img.tag=[u_id intValue];
        img.userInteractionEnabled = YES;
        [img addGestureRecognizer:imagereg];

        
        ////////////////////////
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x-12, separator.frame.size.height+separator.frame.origin.y+10, cell_View.frame.size.width-45, cell_View.frame.size.height-100)];
        viewDetails.backgroundColor=[UIColor clearColor];
        viewDetails.clipsToBounds=YES;
        [cell_View addSubview:viewDetails];
        
        UILabel *Status1=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 100, 20)];
        Status1.text=@"Status :  ";
        Status1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Status1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Status1.textAlignment=NSTextAlignmentRight;
        Status1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Status1];
        
        UILabel *subName=[[UILabel alloc]initWithFrame:CGRectMake(Status1.frame.size.width+2,  0, 200, 20) ];
        if([av checkNullStr:status])
        {
            subName.text=[NSString stringWithFormat:@"%@",status];
        }
        subName.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        subName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:subName];

        
        UILabel *Time1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Status1.frame.size.height+Status1.frame.origin.y+2,100, 20)];
        Time1.text=@"Time :  ";
        Time1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Time1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Time1.textAlignment=NSTextAlignmentRight;
        Time1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Time1];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Time1.frame.size.width+2+2,  Status1.frame.size.height+Status1.frame.origin.y+2, 200, 20)];
        if([av checkNullStr:timelog])
        {
            time.text=[NSString stringWithFormat:@"%@",timelog];
        }
        time.textAlignment=NSTextAlignmentLeft;
        time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        time.textColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
        [viewDetails addSubview:time];

        
        
        UILabel *Duration1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Time1.frame.size.height+Time1.frame.origin.y+2, 100, 20)];
        Duration1.text=@"Duration :  ";
        Duration1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Duration1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Duration1.textAlignment=NSTextAlignmentRight;
        Duration1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Duration1];
        
        UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration1.frame.size.width+2+2, Time1.frame.size.height+Time1.frame.origin.y+2, 200, 20)];
        if([av checkNullStr:durationa])
        {
            duration_time.text=[NSString stringWithFormat:@"%@",durationa];
        }
        duration_time.textAlignment=NSTextAlignmentLeft;
        duration_time.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:duration_time];

        
        UILabel *PostedBy1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Duration1.frame.size.height+Duration1.frame.origin.y+2, 100, 20)];
        PostedBy1.text=@"Posted By :  ";
        PostedBy1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        PostedBy1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        PostedBy1.textAlignment=NSTextAlignmentRight;
        PostedBy1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:PostedBy1];
        
        UILabel *postedby=[[UILabel alloc]initWithFrame:CGRectMake(PostedBy1.frame.size.width+2+2, Duration1.frame.size.height+Duration1.frame.origin.y+2,200, 20)];
        if([av checkNullStr:uname])
        {
            postedby.text=[NSString stringWithFormat:@"%@",uname];
        }
        postedby.textAlignment=NSTextAlignmentLeft;
        postedby.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        postedby.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:postedby];

        ///////////////////////

        
        UITextView *desc=[[UITextView alloc]initWithFrame:CGRectMake(5, viewDetails.frame.size.height+viewDetails.frame.origin.y,cell_View.frame.size.width-15 , 45) ];
        if([av checkNullStr:job_desc])
        {
            desc.text=[NSString stringWithFormat:@"%@",job_desc];
        }
        desc.placeholder = @"Job Description";
        desc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        desc.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        desc.backgroundColor=[UIColor clearColor];
        desc.editable=NO;

        [cell_View addSubview:desc];
        
        scrollpostion= jobAppliedTableview.contentOffset.y+600;
        return cell;
    }
    else if(theTableView==jobAwaredjobtableview)
    {
        
        [jobAppliedTableview removeFromSuperview];
        [poprojectTableView removeFromSuperview];
        [allPoTableView removeFromSuperview];
        [applicantTableView removeFromSuperview];
        [mynotification removeFromSuperview];
        
        
        
        UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 0, jobAwaredjobtableview.frame.size.width-10, cellheight)];
        cell_View.backgroundColor=[UIColor clearColor];
       // cell_View.layer.borderWidth=1;
      //  cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
       // cell_View.layer.cornerRadius=6;
        [cell addSubview: cell_View];
        
        NSString *title=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"title"];
        NSString *durationa=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"duration"];
        NSString *job_desc=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"job_desc"];
        NSString *job_id=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"job_id"];
        NSString *timelog=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];
        NSString *fid=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *uname=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *imge=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        NSString *status=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"status"];
        NSString *industry_name=[[awrdJobAr objectAtIndex:indexPath.row]valueForKey:@"industry_name"];
        
        
        
        UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openApplidJobdetail:)];
        [prev setNumberOfTouchesRequired:1];
        [prev setDelegate:self];
        cell_View.userInteractionEnabled = YES;
        cell_View.tag=indexPath.row;
        [cell_View addGestureRecognizer:prev];
        
        
        
       /* UIImageView *imgdel=[[UIImageView alloc]initWithFrame:CGRectMake(podcast_details.frame.size.width-20, 5, 20, 20)];
        imgdel.image=[UIImage imageNamed:@"delete.png"];
        [cell_View addSubview:imgdel];*/
        
        //        UITapGestureRecognizer *opt=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteit)];
        //        opt.numberOfTapsRequired=1;
        //        [imgdel setUserInteractionEnabled:YES];
        //        [imgdel addGestureRecognizer:opt];
        //
        
        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell_View.frame.size.width-10, 25) ];
        if([av checkNullStr:title])
        {
            title_lbl.text=[NSString stringWithFormat:@"%@",title];
        }
        title_lbl.textColor=[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0];
        title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        title_lbl.textAlignment=NSTextAlignmentLeft;
        [cell_View addSubview:title_lbl];

        UILabel *TimeTitle=[[UILabel alloc] initWithFrame:CGRectMake( 5, 6, cell_View.frame.size.width-15, 25)];
        TimeTitle.text=@"24/06/2016";
        TimeTitle.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        TimeTitle.textColor=[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0];
        TimeTitle.textAlignment=NSTextAlignmentRight;
        TimeTitle.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:TimeTitle];

        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y+2,cell_View.bounds.size.width-15,1)];
        separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
        [cell_View addSubview:separator];

        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, separator.frame.size.height+separator.frame.origin.y+3, 50, 50)];
        img.image=[UIImage imageNamed:@"pictureicn.png"];
        img.layer.cornerRadius=25;
        img.clipsToBounds=YES;
        [cell_View addSubview:img];
        
        NSString * url=[mang concatUrl:imge];
        if(url.length<12)
        {
            img.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            
            if (imageData.length<=0)
                img.image = [UIImage imageNamed:@"username.png"];
            else
                img.image = [UIImage imageWithData:imageData];
        }
        
        UITapGestureRecognizer *imagereg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openFriendProfile:)];
        [imagereg setNumberOfTouchesRequired:1];
        [imagereg setDelegate:self];
        img.tag=[fid intValue];
        img.userInteractionEnabled = YES;
        [img addGestureRecognizer:imagereg];

        ////////////////////////
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x-12, separator.frame.size.height+separator.frame.origin.y+10, cell_View.frame.size.width-45, cell_View.frame.size.height-100)];
        viewDetails.backgroundColor=[UIColor clearColor];
        viewDetails.clipsToBounds=YES;
        [cell_View addSubview:viewDetails];
        
        UILabel *Status1=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 100, 20)];
        Status1.text=@"Status :  ";
        Status1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Status1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Status1.textAlignment=NSTextAlignmentRight;
        Status1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Status1];
        
        UILabel *subName=[[UILabel alloc]initWithFrame:CGRectMake(Status1.frame.size.width+2+2,  0, 200, 20) ];
        if([av checkNullStr:status])
        {
            subName.text=[NSString stringWithFormat:@"%@",status];
        }
        subName.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        subName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:subName];
        
        
        
        UILabel *Time1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Status1.frame.size.height+Status1.frame.origin.y+2,100, 20)];
        Time1.text=@"Time :  ";
        Time1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Time1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Time1.textAlignment=NSTextAlignmentRight;
        Time1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Time1];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Time1.frame.size.width+2+2,  Status1.frame.size.height+Status1.frame.origin.y+2, 200, 20)];
        if([av checkNullStr:timelog])
        {
            time.text=[NSString stringWithFormat:@"%@",timelog];
        }
        time.textAlignment=NSTextAlignmentLeft;
        time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        time.textColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
        [viewDetails addSubview:time];
        
        
        
        UILabel *Duration1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Time1.frame.size.height+Time1.frame.origin.y+2, 100, 20)];
        Duration1.text=@"Duration :  ";
        Duration1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Duration1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Duration1.textAlignment=NSTextAlignmentRight;
        Duration1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Duration1];
        
        UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration1.frame.size.width+2+2, Time1.frame.size.height+Time1.frame.origin.y+2, 200, 20)];
        if([av checkNullStr:durationa])
        {
            duration_time.text=[NSString stringWithFormat:@"%@",durationa];
        }
        duration_time.textAlignment=NSTextAlignmentLeft;
        duration_time.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:duration_time];
        
        
        UILabel *PostedBy1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Duration1.frame.size.height+Duration1.frame.origin.y+2, 100, 20)];
        PostedBy1.text=@"Posted By :  ";
        PostedBy1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        PostedBy1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        PostedBy1.textAlignment=NSTextAlignmentRight;
        PostedBy1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:PostedBy1];
        
        UILabel *postedby=[[UILabel alloc]initWithFrame:CGRectMake(PostedBy1.frame.size.width+2+2, Duration1.frame.size.height+Duration1.frame.origin.y+2,200, 20)];
        if([av checkNullStr:uname])
        {
            postedby.text=[NSString stringWithFormat:@"%@",uname];
        }
        postedby.textAlignment=NSTextAlignmentLeft;
        postedby.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        postedby.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:postedby];
        
        
        
        ///////////////////////
        
        UITextView *desc=[[UITextView alloc]initWithFrame:CGRectMake(5, viewDetails.frame.size.height+viewDetails.frame.origin.y,cell_View.frame.size.width-15 , 45) ];
        desc.placeholder = @"Description";
        if([av checkNullStr:job_desc])
        {
            desc.text=[NSString stringWithFormat:@"%@",job_desc];
        }
        desc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        desc.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        desc.backgroundColor=[UIColor clearColor];
        desc.editable=NO;

        [cell_View addSubview:desc];

        
        
        scrollpostion= jobAwaredjobtableview.contentOffset.y+600;
        return cell;
    }
    else if(theTableView==allPoTableView)
    {
        
        [jobAppliedTableview removeFromSuperview];
        [jobAwaredjobtableview removeFromSuperview];
        [poprojectTableView removeFromSuperview];
        [applicantTableView removeFromSuperview];
        [mynotification removeFromSuperview];
        
        
        UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 0, allPoTableView.frame.size.width-10, cellheight)];
        cell_View.backgroundColor=[UIColor clearColor];
        [cell addSubview: cell_View];
        
        NSString *title=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"title"];
        NSString *durationa=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"duration"];
        NSString *job_desc=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"job_desc"];
        NSString *job_id=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"job_id"];
        NSString *timelog=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];
        NSString *u_id=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *uname=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *imge=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        NSString *status=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"status"];
        NSString *industry_name=[[allProAr objectAtIndex:indexPath.row]valueForKey:@"industry_name"];
        
        NSLog(@"inside====%@",title);
        
        UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openApplidJobdetail:)];
        [prev setNumberOfTouchesRequired:1];
        [prev setDelegate:self];
        cell_View.userInteractionEnabled = YES;
        cell_View.tag=indexPath.row;
        [cell_View addGestureRecognizer:prev];
        
        
        
        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell_View.frame.size.width-10, 25) ];
        if([av checkNullStr:title])
        {
            title_lbl.text=[NSString stringWithFormat:@"%@",title];
        }
        title_lbl.textColor=[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0];
        title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        title_lbl.textAlignment=NSTextAlignmentLeft;
        [cell_View addSubview:title_lbl];
        
        
        UILabel *TimeTitle=[[UILabel alloc] initWithFrame:CGRectMake( 5, 6, cell_View.frame.size.width-15, 25)];
        TimeTitle.text=@"24/06/2016";
        TimeTitle.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        TimeTitle.textColor=[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0];
        TimeTitle.textAlignment=NSTextAlignmentRight;
        TimeTitle.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:TimeTitle];
        
        
        
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y+2,cell_View.bounds.size.width-15,1)];
        separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
        [cell_View addSubview:separator];
        
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, separator.frame.size.height+separator.frame.origin.y+3, 50, 50)];
        img.image=[UIImage imageNamed:@"pictureicn.png"];
        img.layer.cornerRadius=25;
        img.clipsToBounds=YES;
        [cell_View addSubview:img];
        
        NSString * url=[mang concatUrl:imge];
        if(url.length<12)
        {
            img.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            
            if (imageData.length<=0)
                img.image = [UIImage imageNamed:@"username.png"];
            else
                img.image = [UIImage imageWithData:imageData];
        }
        
        
        /* UIImageView *imgdel=[[UIImageView alloc]initWithFrame:CGRectMake(podcast_details.frame.size.width-20, 5, 20, 20)];
         imgdel.image=[UIImage imageNamed:@"delete.png"];
         [cell_View addSubview:imgdel];*/
        
        UITapGestureRecognizer *imagereg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openFriendProfile:)];
        [imagereg setNumberOfTouchesRequired:1];
        [imagereg setDelegate:self];
        img.tag=[u_id intValue];
        img.userInteractionEnabled = YES;
        [img addGestureRecognizer:imagereg];
        
        
        ////////////////////////
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x-12, separator.frame.size.height+separator.frame.origin.y+10, cell_View.frame.size.width-45, cell_View.frame.size.height-100)];
        viewDetails.backgroundColor=[UIColor clearColor];
        viewDetails.clipsToBounds=YES;
        [cell_View addSubview:viewDetails];
        
        UILabel *Status1=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 100, 20)];
        Status1.text=@"Status :  ";
        Status1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Status1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Status1.textAlignment=NSTextAlignmentRight;
        Status1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Status1];
        
        UILabel *subName=[[UILabel alloc]initWithFrame:CGRectMake(Status1.frame.size.width+2+2,  0, 200, 20) ];
        if([av checkNullStr:status])
        {
            subName.text=[NSString stringWithFormat:@"%@",status];
        }
        subName.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        subName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:subName];
        
        
        UILabel *Time1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Status1.frame.size.height+Status1.frame.origin.y+2,100, 20)];
        Time1.text=@"Time :  ";
        Time1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Time1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Time1.textAlignment=NSTextAlignmentRight;
        Time1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Time1];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Time1.frame.size.width+2+2,  Status1.frame.size.height+Status1.frame.origin.y+2, 200, 20)];
        if([av checkNullStr:timelog])
        {
            time.text=[NSString stringWithFormat:@"%@",timelog];
        }
        time.textAlignment=NSTextAlignmentLeft;
        time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        time.textColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
        [viewDetails addSubview:time];
        
        
        
        UILabel *Duration1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Time1.frame.size.height+Time1.frame.origin.y+2, 100, 20)];
        Duration1.text=@"Duration :  ";
        Duration1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Duration1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Duration1.textAlignment=NSTextAlignmentRight;
        Duration1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Duration1];
        
        UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration1.frame.size.width+2, Time1.frame.size.height+Time1.frame.origin.y+2, 200, 20)];
        if([av checkNullStr:durationa])
        {
            duration_time.text=[NSString stringWithFormat:@"%@",durationa];
        }
        duration_time.textAlignment=NSTextAlignmentLeft;
        duration_time.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:duration_time];
        
        
        UILabel *PostedBy1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Duration1.frame.size.height+Duration1.frame.origin.y+2, 100, 20)];
        PostedBy1.text=@"Posted By :  ";
        PostedBy1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        PostedBy1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        PostedBy1.textAlignment=NSTextAlignmentRight;
        PostedBy1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:PostedBy1];
        
        UILabel *postedby=[[UILabel alloc]initWithFrame:CGRectMake(PostedBy1.frame.size.width+2+2, Duration1.frame.size.height+Duration1.frame.origin.y+2,200, 20)];
        if([av checkNullStr:uname])
        {
            postedby.text=[NSString stringWithFormat:@"%@",uname];
        }
        postedby.textAlignment=NSTextAlignmentLeft;
        postedby.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        postedby.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:postedby];
        
        ///////////////////////

        UITextView *desc=[[UITextView alloc]initWithFrame:CGRectMake(5, viewDetails.frame.size.height+viewDetails.frame.origin.y,cell_View.frame.size.width-15 , 45) ];
        desc.placeholder = @"Description";
        if([av checkNullStr:job_desc])
        {
            desc.text=[NSString stringWithFormat:@"%@",job_desc];
        }
        desc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        desc.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        desc.backgroundColor=[UIColor clearColor];
        desc.editable=NO;

        [cell_View addSubview:desc];

        
        
        
        scrollpostion= allPoTableView.contentOffset.y+600;
        return cell;
    }
    else if(theTableView==poprojectTableView)
    {
        [jobAppliedTableview removeFromSuperview];
        [jobAwaredjobtableview removeFromSuperview];
        [allPoTableView removeFromSuperview];
        [applicantTableView removeFromSuperview];
        [mynotification removeFromSuperview];
        
        UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 0, poprojectTableView.frame.size.width-10, cellheight)];
        cell_View.backgroundColor=[UIColor clearColor];
        //cell_View.layer.borderWidth=1;
       // cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
       // cell_View.layer.cornerRadius=6;
        [cell addSubview: cell_View];
        
        NSString *title=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"title"];
        NSString *durationa=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"duration"];
        NSString *job_desc=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"job_desc"];
        NSString *job_id=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"job_id"];
        NSString *timelog=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];
        NSString *u_id=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *uname=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *imge=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        NSString *status=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"status"];
        NSString *industry_name=[[postedProjectAr objectAtIndex:indexPath.row]valueForKey:@"industry_name"];
        
        jobId=job_id;
        
        NSLog(@"inside====%@",title);
        
        UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openApplidJobdetail:)];
        [prev setNumberOfTouchesRequired:1];
        [prev setDelegate:self];
        cell_View.userInteractionEnabled = YES;
        cell_View.tag=indexPath.row;
        [cell_View addGestureRecognizer:prev];

       /* UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        img.image=[UIImage imageNamed:@"pictureicn.png"];
        [cell_View addSubview:img];
        
        
        NSString * url=[mang concatUrl:imge];
        if(url.length<12)
        {
            img.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            
            if (imageData.length<=0)
                img.image = [UIImage imageNamed:@"username.png"];
            else
                img.image = [UIImage imageWithData:imageData];
        }
        
        UITapGestureRecognizer *imagereg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openFriendProfile:)];
        [imagereg setNumberOfTouchesRequired:1];
        [imagereg setDelegate:self];
        img.tag=[u_id intValue];
        img.userInteractionEnabled = YES;
        [img addGestureRecognizer:imagereg];*/
        
        //78:119:145
        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell_View.frame.size.width-10, 25) ];
        if([av checkNullStr:title])
        {
            title_lbl.text=[NSString stringWithFormat:@"%@",title];
        }
        title_lbl.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
        title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [cell_View addSubview:title_lbl];
      
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y+2,cell_View.bounds.size.width-15,1)];
        separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
        [cell_View addSubview:separator];

        
        
        
        ////////////////////////
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(0, separator.frame.size.height+separator.frame.origin.y+1, cell_View.frame.size.width, cell_View.frame.size.height-40)];
        viewDetails.backgroundColor=[UIColor clearColor];
        viewDetails.clipsToBounds=YES;
        [cell_View addSubview:viewDetails];
        
        UILabel *Duration1=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 100, 20)];
        Duration1.text=@"Duration :  ";
        Duration1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Duration1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Duration1.textAlignment=NSTextAlignmentLeft;
        Duration1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Duration1];
        
        UILabel *subName=[[UILabel alloc]initWithFrame:CGRectMake(Duration1.frame.size.width,  0, 200, 20) ];
        subName.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        subName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        subName.text=[NSString stringWithFormat:@"%@",durationa];
        [viewDetails addSubview:subName];
        
        
        UILabel *Status1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Duration1.frame.size.height+Duration1.frame.origin.y+2,100, 20)];
        Status1.text=@"Status :  ";
        Status1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Status1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Status1.textAlignment=NSTextAlignmentLeft;
        Status1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Status1];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Status1.frame.size.width,  Duration1.frame.size.height+Duration1.frame.origin.y+2, 200, 20)];
        if([av checkNullStr:status])
        {
            time.text=[NSString stringWithFormat:@"%@",status];
        }
        time.textAlignment=NSTextAlignmentLeft;
        time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        time.textColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
        [viewDetails addSubview:time];
        
        UIButton *edst = [[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width/2+cell_View.frame.size.width/4, Duration1.frame.size.height+Duration1.frame.origin.y+2, 80, 20)];
        [edst setTitle: @"Edit Status" forState: UIControlStateNormal];
        [edst setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        edst.backgroundColor=[UIColor clearColor];
        [edst addTarget:self action:@selector(ChangeStatus:) forControlEvents:UIControlEventTouchUpInside];
        [edst setTitleColor:[UIColor colorWithRed:0.0/255 green:46.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        edst.layer.cornerRadius=6;
        //edst.tag=[jobId intValue];
        edst.tag=indexPath.row;
        [viewDetails addSubview:edst];

        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(edst.frame.size.width+edst.frame.origin.x, Duration1.frame.size.height+Duration1.frame.origin.y+2+5, 13, 10)];
        img.image=[UIImage imageNamed:@"downArrow.png"];
        [viewDetails addSubview:img];
        
        
        UILabel *Description1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Status1.frame.size.height+Status1.frame.origin.y+2, 100, 20)];
        Description1.text=@"Description : ";
        Description1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Description1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Description1.textAlignment=NSTextAlignmentLeft;
        Description1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Description1];
        
        UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Description1.frame.size.width, Status1.frame.size.height+Status1.frame.origin.y+2, 200, 20)];
        if([av checkNullStr:job_desc])
        {
            duration_time.text=[NSString stringWithFormat:@"%@",job_desc];
        }
        duration_time.textAlignment=NSTextAlignmentLeft;
        duration_time.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [viewDetails addSubview:duration_time];
        
        
        UILabel *Posted1=[[UILabel alloc] initWithFrame:CGRectMake( viewDetails.frame.size.width-200, Description1.frame.size.height+Description1.frame.origin.y+2, 200, 20)];
        Posted1.text=[NSString stringWithFormat:@"Posted By :  %@",uname];
        Posted1.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        Posted1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Posted1.textAlignment=NSTextAlignmentRight;
        Posted1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Posted1];
        
       /* UILabel *postedData=[[UILabel alloc]initWithFrame:CGRectMake(Posted1.frame.size.width,  Description1.frame.size.height+Description1.frame.origin.y+2, 200, 20) ];
        postedData.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        postedData.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        postedData.text=[NSString stringWithFormat:@"%@",uname];
        [viewDetails addSubview:postedData];*/


        ///////////////////////
        UIButton *ed = [[UIButton alloc]initWithFrame:CGRectMake(15, Posted1.frame.size.height+Posted1.frame.origin.y+5, cell_View.frame.size.width/2-10, 25)];
        [ed setTitle: @"Edit Details" forState: UIControlStateNormal];
        ed.backgroundColor=[UIColor clearColor];
        [ed addTarget:self action:@selector(EditDetails:) forControlEvents:UIControlEventTouchUpInside];
        [ed setTitleColor:[UIColor colorWithRed:0.0/255 green:46.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        ed.layer.cornerRadius=6;
        [ed setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        ed.tag=[jobId intValue];
        [viewDetails addSubview:ed];
        
     /*   UIButton *viewapp = [[UIButton alloc]initWithFrame:CGRectMake(ed.frame.size.width+ed.frame.origin.x+5, Posted1.frame.size.height+Posted1.frame.origin.y+5, cell_View.frame.size.width/2-10, 25)];
        [viewapp setTitle: @"View Applicant" forState: UIControlStateNormal];
        viewapp.backgroundColor=[UIColor clearColor];
        [viewapp addTarget:self action:@selector(ViewApplicant:) forControlEvents:UIControlEventTouchUpInside];
        [viewapp setTitleColor:[UIColor colorWithRed:0.0/255 green:46.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [viewapp setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        viewapp.layer.cornerRadius=6;
        viewapp.tag=[job_id intValue];
        [viewDetails addSubview:viewapp]; */
        

        
        
        scrollpostion= poprojectTableView.contentOffset.y+600;
        return cell;
    }
    if(theTableView==applicantTableView)
    {
        
        
        
        UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 0, applicantTableView.frame.size.width-10, cellheight)];
        cell_View.backgroundColor=[UIColor clearColor];
      //  cell_View.layer.borderWidth=1;
      //  cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
      //  cell_View.layer.cornerRadius=6;
        [cell addSubview: cell_View];
        
        
        
        
        
        NSString *uname=[[applicantAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *u_id=[[applicantAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *status=[[applicantAr objectAtIndex:indexPath.row]valueForKey:@"status"];
        NSString *imgpath=[[applicantAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        
        
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
        //[img setImage:[UIImage imageNamed:@"user.png"]];
        img.backgroundColor=[UIColor redColor];
        img.layer.cornerRadius=30;
        img.clipsToBounds=YES;
        [cell_View addSubview:img];
        
        NSString * url=[mang concatUrl:imgpath];
        
        
        if(url.length<12)
        {
            img.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            
            if (imageData.length<=0)
                img.image = [UIImage imageNamed:@"username.png"];
            else
                img.image = [UIImage imageWithData:imageData];
        }
        
        
        
        
        
        
        
        UIImageView *img2=[[UIImageView alloc]initWithFrame:CGRectMake( img.frame.size.height+img.frame.origin.y+5, 20, 30, 30)];
        [img2 setImage:[UIImage imageNamed:@"chatattachments.png"]];
        img2.backgroundColor=[UIColor whiteColor];
        [cell_View addSubview:img2];
        
        UIButton *accept = [[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-100, 20, 80, 25)];
        NSString *st=@"Accept";
        accept.backgroundColor=[UIColor clearColor];
        if([status intValue] ==1)
        {
            st=@"Accepted";
            accept.backgroundColor=[UIColor grayColor];
        }
        [accept setTitle: st forState: UIControlStateNormal];
        
        [accept addTarget:self action:@selector(Accept:) forControlEvents:UIControlEventTouchUpInside];
        [accept setTitleColor:[UIColor colorWithRed:0.0/255 green:46.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        accept.layer.cornerRadius=6;
        [accept setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        accept.tag=[u_id intValue];
        [cell_View addSubview:accept];
        
        UILabel *ulabel=[[UILabel alloc]initWithFrame:CGRectMake(20, img.frame.size.height+img.frame.origin.y+5, 100, 30)];
        ulabel.backgroundColor=[UIColor whiteColor];
        ulabel.text=uname;
        [cell_View addSubview:ulabel];
        
          scrollpostion= applicantTableView.contentOffset.y+600;
        
        return cell;
        
    }
    if(theTableView==mynotification)
    {
        
        [jobAppliedTableview removeFromSuperview];
        [jobAwaredjobtableview removeFromSuperview];
        [poprojectTableView removeFromSuperview];
        [allPoTableView removeFromSuperview];
        [applicantTableView removeFromSuperview];
        
        UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 0, mynotification.frame.size.width-10, cellheight)];
        cell_View.backgroundColor=[UIColor clearColor];
        [cell addSubview: cell_View];
        NSMutableDictionary *pd=[SavePrefrences sharedInstance].colorDictionry;
        
        
        NSArray * data=[JobAr objectAtIndex:indexPath.row];
        NSDictionary* itemDict = (NSDictionary*)data;
        NSString *uname=[data valueForKey:@"uname"];
        NSString *ntc=[data valueForKey:@"ntc"];
        NSString *lastname=[data valueForKey:@"fname"];
        NSString *pofrm=[data valueForKey:@"uid"];
        NSString *time=[data valueForKey:@"time"];
        NSString *uid=[data valueForKey:@"uid"];
        NSString *noti_id=[data valueForKey:@"noti_id"];
        time=[mang timeConverter:time];

        
        UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.size.height/2-17, 35, 35)];
       // [userpic setImage:[UIImage imageNamed:@"user.png"]];
        [cell_View addSubview:userpic];
        
        //here
        UILabel *timlb=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.view.frame.size.width-20,15)];
        timlb.text=[NSString stringWithFormat:@"%@",time];
        timlb.textColor=[UIColor blackColor];//colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];//;
        [timlb setFont:[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:12]];
        timlb.textAlignment=NSTextAlignmentRight;
        timlb.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:timlb];
        
        //here
        UILabel*user_lbl=[[UILabel alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10, 20, 110,15)];
        user_lbl.text=uname;
        [user_lbl setFont:[UIFont fontWithName:@"HelveticaNeue-Semibold" size:14]];
        user_lbl.backgroundColor=[UIColor clearColor];
        user_lbl.textColor=[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];//[ff valueForKey:@"Scrollcolor"];
        [cell_View addSubview:user_lbl];
        
        
        UITextView *line_lbl=[[UITextView alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, user_lbl.frame.size.height+user_lbl.frame.origin.y+3,cell_View.frame.size.width-25, 40)];
        line_lbl.backgroundColor=[UIColor clearColor];
        line_lbl.font=[UIFont systemFontOfSize:12];
        line_lbl.textColor=[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        line_lbl.userInteractionEnabled=NO;
        line_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        line_lbl.editable=NO;

        [cell_View addSubview:line_lbl];
        
        
        //here commented for getting notifications (need to uncomment)
        [[SavePrefrences sharedInstance].isAlViedDic setValue:noti_id forKey:noti_id];
         NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:@"bd" forKey:@"aid"];
        
        NSMutableArray * ar=[[NSMutableArray alloc]init];
        [ar addObject:noti_id];
        [dic setObject:ar forKey:@"notiIds"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];

        //till here
        NSString* userId = [NSString stringWithFormat:@"%@", itemDict[@"uid"]];
        if ([self contactFromId:userId]) {
            UIButton *btnChat = [[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width/2+cell_View.frame.size.width/4+20,line_lbl.frame.size.height+line_lbl.frame.origin.y, 30,30)];
            btnChat.backgroundColor= [UIColor clearColor];
            [btnChat setBackgroundImage:[UIImage imageNamed:@"chatNew.png"] forState:UIControlStateNormal];
            btnChat.layer.cornerRadius=5;
            btnChat.tag=indexPath.row;
            [btnChat addTarget:self action:@selector(goChatUser:) forControlEvents:UIControlEventTouchUpInside];
            [cell_View addSubview:btnChat];
        }
        
        NSString * tit;
        if([ntc intValue]==29)
        {
            NSArray * jsonObject=[mang convertojson:data];
            NSString *title=[jsonObject valueForKey:@"title"];
            if([uid intValue]==[[SavePrefrences sharedInstance].uid intValue])
            {
                tit=[@"You applied for a " stringByAppendingString:[NSString stringWithFormat:@"%@ Project ",title]];
            }
            else
            {
                tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc29] stringByAppendingString:[NSString stringWithFormat:@"%@ Project ",title] ];
            }
            line_lbl.text=tit;
        }
        if([ntc intValue]==30)
        {
            if([uid intValue]==[[SavePrefrences sharedInstance].uid intValue])
            {
                tit=@"You accepted a project";
            }
            else
            {
                tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc30];
            }
            line_lbl.text=tit;
        }
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,cell_View.bounds.size.height-3,cell_View.bounds.size.width-15,1)];
        separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
        [cell.contentView addSubview:separator];

        
        return cell;
    }
     
     
    return cell;
 }

-(IBAction)goChatUser:(id)sender{
    UIButton* btn = (UIButton*)sender;
    NSArray * data=[JobAr objectAtIndex:btn.tag];
    NSDictionary* itemDict = (NSDictionary*)data;
    
    UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChatViewController *vc2=[mainStoryboard instantiateViewControllerWithIdentifier:@"CHAT_SCREEN"];
    NSString* uid = [NSString stringWithFormat:@"%@", itemDict[@"uid"]];
    vc2.userId = uid;
    [self showViewController:vc2 sender:nil];
}

- (NSDictionary*)contactFromId:(NSString*)userId{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for (NSDictionary* dict in appDelegate.allFriends) {
        if ([[NSString stringWithFormat:@"%@", dict[@"u_id"]] isEqualToString:userId]) {
            return dict;
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return cellheight;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    NSLog(@"scrolll  viewww     %ld",(maximumOffset - currentOffset));
    
    
    if (maximumOffset - currentOffset <= -100)
    {
        if(iscallback==0)
        {
        limit=limit+18;
        [self reteriveAppliedJob];
        }
        else if(iscallback==5)
        {
             limit=limit+18;
            [self searchAppliedJob1];
        }
        else if(iscallback==3)
        {
            limit=limit+18;
            [self reterivePostedProject1];
        }
        else if(iscallback==1)
        {
            limit=limit+18;
            [self reterievAwardJobAr1];
        }
        
        else if(iscallback==4)
        {
            limit=limit+18;
            [self reteriveAllProjects1];
        }
        else
        {
            
            
            if(whichto==0)
            {
                // bpop=[[BoardPopUp alloc]init];
                limit=limit+18;
                [bpop IndustrySearch :self:100:limit];
            }
            else if(whichto==1)
            {
                    limit=limit+18;
                // bpop=[[BoardPopUp alloc]init];
                [bpop IndustrySearch :self:101:limit];
            }
            else if(whichto==3)
            {
                    limit=limit+18;
                // bpop=[[BoardPopUp alloc]init];
                [bpop IndustrySearch :self:104:limit];
            }
            else if(whichto==4)
            {
                    limit=limit+18;
                // bpop=[[BoardPopUp alloc]init];
                [bpop IndustrySearch :self:105:limit];
            }
            
        }
        
        
        
        
    }
}


-(void)openFriendProfile:(id)sender{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    friendid=(int)tg.view.tag;
    
    iscallback=8;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",friendid] forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile":@"showProfile" :@"":@"":dic1 :self];
}

-(IBAction)Accept:(id)sender{
    iscallback=7;
    
    UIButton *btn=(UIButton *)sender;
    if([btn.titleLabel.text isEqual:@"Accept"])
    {
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[NSString stringWithFormat:@"%d",(int)(btn.tag)] forKey:@"id"];
        [dic1 setObject:[NSString stringWithFormat: @"%d",jobid1] forKey:@"jid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"accept" :@"" :@"" :dic1 :self ];
        
        [btn setTitle:@"Accepted" forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor grayColor];
    }
}



-(IBAction)ViewApplicant:(id)sender{
    UIButton *btn=(UIButton *)sender;
    iscallback=6;
    
    jobid1=(int)btn.tag;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"jid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"getApplicants" :@"":@"":dic1 :self];
}

-(void)ShowApplicants{
    [self MainView: self:@" Applicants"];
    NSMutableDictionary*clr=[SavePrefrences sharedInstance].colorDictionry;
    applicantTableView = [[UITableView alloc] initWithFrame:CGRectMake(20,NameLabel.frame.size.height+NameLabel.frame.origin.y,scrollbar.frame.size.width,scrollbar.frame.size.height)];
    applicantTableView.delegate = self;
    applicantTableView.dataSource = self;
    applicantTableView.scrollEnabled = YES;
    applicantTableView.backgroundColor=[clr valueForKey:@"backcolor"];
    applicantTableView.separatorColor=[clr valueForKey:@"backcolor"];
    [prMainView addSubview:applicantTableView];
}


-(void)AddnewProject{
    [jpop AddnewProject:self];
}

-(IBAction)EditDetails:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [jpop editJobdeatils:self:(int)btn.tag];
}

-(IBAction)ChangeStatus:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    NSString *job_id=[[postedProjectAr objectAtIndex:(int)btn.tag]valueForKey:@"job_id"];
   NSString *status=[[postedProjectAr objectAtIndex:(int)btn.tag]valueForKey:@"status"];
    
    [jpop ChangeStatus:self:[job_id intValue]:status];
}

-(void)openApplidJobdetail:(id)sender
{
    
    UITapGestureRecognizer * ges=(UITapGestureRecognizer *)sender;
    int tg= (int)ges.view.tag;
    if(whichto==0)
    {
        NSArray *ar=[applidjobAr objectAtIndex:tg] ;
        NSString *job_id=[ar valueForKey:@"job_id"];
        u_id=[ar valueForKey:@"u_id"];
        [jpop OpenJobDetails :self :[job_id intValue] :u_id:0];
    }
    else if (whichto==1)
    {
        NSArray *ar=[awrdJobAr objectAtIndex:tg] ;
        NSString *job_id=[ar valueForKey:@"job_id"];
        u_id=[ar valueForKey:@"u_id"];
        [jpop OpenJobDetails :self :[job_id intValue] :u_id:1];
    }
    if (whichto==3)
    {
        NSArray *ar=[postedProjectAr objectAtIndex:tg] ;
        NSString *job_id=[ar valueForKey:@"job_id"];
        u_id=[ar valueForKey:@"u_id"];
        [jpop OpenJobDetails :self :[job_id intValue] :u_id:3];
    }
    if (whichto==4)
    {
        NSArray *ar=[allProAr objectAtIndex:tg] ;
        NSString *job_id=[ar valueForKey:@"job_id"];
        u_id=[ar valueForKey:@"u_id"];
        [jpop OpenJobDetails :self :[job_id intValue] :u_id:4];
    }

}

-(void)showPostedProject
{
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    whichto=3;
   
    [allPoTableView removeFromSuperview];
    poprojectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y+10,[SavePrefrences sharedInstance].screenWidth,([SavePrefrences sharedInstance].screenHeight)-(middle_label.frame.size.height+middle_label.frame.origin.y+90))];
    poprojectTableView.delegate = self;
    poprojectTableView.dataSource = self;
    poprojectTableView.scrollEnabled = YES;
    poprojectTableView.backgroundColor=[stack valueForKey:@"backcolor"];
    poprojectTableView.separatorColor=[stack valueForKey:@"backcolor"];
    [option addSubview:poprojectTableView];
    
}

-(void)showAllProject
{
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    whichto=4;
    [poprojectTableView removeFromSuperview];
    allPoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y+10,[SavePrefrences sharedInstance].screenWidth,([SavePrefrences sharedInstance].screenHeight)-(middle_label.frame.size.height+middle_label.frame.origin.y+90))];
    allPoTableView.delegate = self;
    allPoTableView.dataSource = self;
    allPoTableView.scrollEnabled = YES;
    allPoTableView.backgroundColor=[stack valueForKey:@"backcolor"];
    allPoTableView.separatorColor=[stack valueForKey:@"backcolor"];
    [option addSubview:allPoTableView];
    
    
}

-(void)sortbyjob
{
    [jpop sortby:self :whichto];
}

-(IBAction)searchAdvance:(id)sender
{
    [jpop searchAdvance:self:whichto];
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
        NSLog(@"pop count innnn");
        id<CallTo_Parent> cb= vc1;
        
        [cb callMethod:nil];
        
    }
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if(buttonIndex == 0)//OK button pressed
//    {
//        if(whichto==0)
//        {
//            limit=0;
//            scrollpostion=0;
//            showpopfrapply=0;
//            applidjobAr=[[NSMutableArray alloc]init];
//            [self reteriveAppliedJob];
//        }
//        else if(whichto==1)
//        {
//            [self reteriveAwardedJob];
//        }
//        else if(whichto==3)
//        {
//            
//            [self reterivePostedProjects];
//        }
//        else if(whichto==4)
//        {
//            [self reteriveAllProjects];
//        }
//        
//    }
//}

-(void) callBack:(NSArray *)meta :(NSArray *)data
{
    NSLog(@"Value of call backis %d",iscallback);
    if(iscallback==0)
    {
       // applidjobAr=data;
        
        
        if([data count]>0)
        {
        for(int x=0;x<[data count];x++)
          {
            [applidjobAr addObject:[data objectAtIndex:x]];
          }
          [self showAppliedJob];
         [jobAppliedTableview setContentOffset:CGPointMake(0,scrollpostion)];
        }
        else
        {
           if(showpopfrapply==1)
           {
          UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
           }
            showpopfrapply=1;
        }
        
        if(showpopfrapply==0)
           [self showAppliedJob];
       
        
    }
    
    else if(iscallback==1)
    {
        if([data count]>0)
        {
            for(int x=0;x<[data count];x++)
            {
                [awrdJobAr addObject:[data objectAtIndex:x]];
            }
            [self showAwardedJob];
            [jobAwaredjobtableview setContentOffset:CGPointMake(0,scrollpostion)];
        }
        else
        {
           // if(showawadjobpop==1)
            //{
                UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            //}
            showawadjobpop=1;
        }
        
        if(showawadjobpop==0)
           [self showAwardedJob];
        
        
        
        //awrdJobAr=data;
        //[self showAwardedJob];
    }
    
    else if(iscallback==3)
    {
       // postedProjectAr=data;
        
       
        if([data count]>0)
        {
            for(int x=0;x<[data count];x++)
            {
                [postedProjectAr addObject:[data objectAtIndex:x]];
            }
              [self showPostedProject];
              [poprojectTableView setContentOffset:CGPointMake(0,scrollpostion)];
          
        }
        else
        {
          if(showpopProject==1)
            {
                UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            showpopProject=1;
        }
       if(showpopProject==0)
         {
          [self showPostedProject];
         }
       }
    
    
    else if(iscallback==4)
    {
        
        NSLog(@"scrollpostion inside 4========%f",scrollpostion);
        
        if([data count]>0)
        {
            for(int x=0;x<[data count];x++)
            {
                [allProAr addObject:[data objectAtIndex:x]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAllProject];
            });
//            [allPoTableView setContentOffset:CGPointMake(0,scrollpostion)];
            
        }
        else
        {
            if(showpopallproject==1)
            {
                UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            showpopallproject=1;
        }
        if(showpopallproject==0)
        {
           [self showAllProject];
            [allPoTableView setContentOffset:CGPointMake(0,scrollpostion)];
        }
        
        
        //allProAr=data;
        //[self showAllProject];
        
    }
    else if(iscallback==5)
    {
         NSLog(@"which to===%d",whichto);
        if([data count]>0)
          {
            if(whichto==0)
            {
              if([data count]>0)
                {
                    for(int x=0;x<[data count];x++)
                    {
                        [applidjobAr addObject:[data objectAtIndex:x]];
                    }
                    
                    [jobAppliedTableview reloadData];
                    [jobAppliedTableview setContentOffset:CGPointMake(0,scrollpostion)];
                }
                else
                {
                    UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                    [alert show];
           
                }

                [jobAppliedTableview reloadData];
                
            }
            else if(whichto==1)
            {
                NSLog(@"awarded job");
                awrdJobAr=data;
                [jobAwaredjobtableview reloadData];
            }
            else if(whichto==3)
            {
               if([data count]>0)
                {
                    for(int x=0;x<[data count];x++)
                    {
                        [postedProjectAr addObject:[data objectAtIndex:x]];
                    }
                    [poprojectTableView reloadData];
                    [poprojectTableView setContentOffset:CGPointMake(0,scrollpostion)];
                    
                }
                else
                {
                        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No More Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                        [alert show];
                  
                }
                
               // postedProjectAr=data;
            }
            else if(whichto==4)
            {
                NSLog(@"all job");
                allProAr=data;
                [allPoTableView reloadData];
            }
        }
        else
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No New Result Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
            if(whichto==0)
            {
                [jobAppliedTableview reloadData];
            }
            else if(whichto==1)
            {
                [jobAwaredjobtableview reloadData];
            }
            else if(whichto==3)
            {
                
                [poprojectTableView reloadData];
            }
            else if(whichto==4)
            {
                [allPoTableView reloadData];
            }
        }
    }
    else if (iscallback==6)
    {
        applicantAr=data;
        if([applicantAr count]>0)
        {
            [self ShowApplicants];
        }
        else{
            [self dissmisspop];
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No Applicant" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
        }
    }
    else if(iscallback==7)
    {
        NSLog(@"inside meta=====%@",meta);
        NSLog(@"inside data=====%@",data);
    }
    
    else if (iscallback==8)
    {
        if([[SavePrefrences sharedInstance].uid intValue]==friendid)
        {
            [drawer addProfileimage:data];
        }
        else{
            [mpop addProfileimage :data:friendid:self];
        }
    }
    
    
    
}
-(void) callMethod:(NSArray *)meta
{
    NSString * chk=[meta objectAtIndex:0];
    NSLog(@"callback======%d",iscallback);
    
    NSLog(@"Valuuuuuuuuuu==ddddddd=%@",meta);
    
    NSLog(@"COUNT IS %lu",[meta count]);
    if([meta count]>1)
    {
        
        NSMutableArray * ar=[meta objectAtIndex:1];
        
        
        if([ar count]>0)
        {
            NSLog(@"value of which to %d",whichto);
            
            if([chk isEqual:@"awardjobindustry"])
            {
                applidjobAr=ar;
                [jobAppliedTableview reloadData];
            }
            else if ([chk isEqual:@"appliedjobindustry"])
            {
                awrdJobAr=ar;
                [jobAwaredjobtableview reloadData];
            }
            else if ([chk isEqual:@"awardjobsort"])
            {
                applidjobAr=ar;
                [jobAppliedTableview reloadData];
            }
            else if ([chk isEqual:@"applyjobsort"])
            {
                awrdJobAr=ar;
                [jobAwaredjobtableview reloadData];
            }
            else if ([chk isEqual:@"PostedSearch"])
            {
                postedProjectAr=ar;
                [poprojectTableView reloadData];
            }
            else if([chk isEqual:@"AllProjectSearch"])
            {
                allProAr=ar;
                [allPoTableView reloadData];
            }
            else if([chk isEqual:@"PostedProjectsort"])
            {
                postedProjectAr=ar;
                [poprojectTableView reloadData];
            }
            else if([chk isEqual:@"AllProjectsort"])
            {
                allProAr=ar;
                [allPoTableView reloadData];
            }
            else if([chk isEqual:@"awardJobAdvnce"])
            {
                applidjobAr=ar;
                [jobAppliedTableview reloadData];
            }
            else if([chk isEqual:@"AppliedJobAdvnce"])
            {
                awrdJobAr=ar;
                [jobAwaredjobtableview reloadData];
            }
            else if([chk isEqual:@"PostedProjectAdvnce"])
            {
                postedProjectAr=ar;
                [poprojectTableView reloadData];
            }
            else if([chk isEqual:@"AllProjectAdvnce"])
            {
                allProAr=ar;
                [allPoTableView reloadData];
            }
            else if ([chk isEqual:@"updatejobdetails"])
            {
                
                NSLog(@"Updating data");
                [self reterivePostedProjects];
            }
            else if ([chk isEqual:@"addnewjob"])
            {
                if (whichto==3)
                {
                    [self reterivePostedProjects];
                }
                else if (whichto==4)
                {
                    [self reteriveAllProjects];
                }
                
            }
            else if ([chk isEqual:@"changestatus"])
            {
                [self reterivePostedProjects];
            }
            
        }
        else
        {
            NSString *isempty=[meta objectAtIndex:2];
            if([isempty intValue]==0)
            {
                if(whichto==0)
                {
                    [jobAppliedTableview removeFromSuperview];
                }
                else if(whichto==1)
                {
                    [jobAwaredjobtableview removeFromSuperview];
                }
                else if(whichto==3)
                {
                    [poprojectTableView removeFromSuperview];
                }
                else if(whichto==4)
                {
                    [allPoTableView removeFromSuperview];
                }
                UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No Results" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                
               //[self alertView:alrt clickedButtonAtIndex:1];
                [alrt show];
                
            }
            
        }
    }
}

- (void)keyboardWasShown:(NSNotification *)notification
    {
     CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
     height = MIN(keyboardSize.height,keyboardSize.width);
     int width = MAX(keyboardSize.height,keyboardSize.width);
     
     NSLog(@"keyboard height is %d",height);
    
}



@end
