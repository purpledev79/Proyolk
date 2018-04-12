#import "Podcast.h"
#import "AllValidationsViewController.h"
#import "SavePrefrences.h"
#import "PodcastPopUp.h"
#import "BoardPopUp.h"
#import "PodcastPopUp.h"
#import "popups.h"
#import "LeftRightDrawer.h"
#import "ManageArray.h"


@interface Podcast ()

{
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIView *actionView,*middle_label,*option,*main,*podcast_details,*main1;
    UIScrollView *scrollbar;
    NSMutableArray *popUpAr,*podAr;
    UITextField *search_lbl;
    UIImageView *searchbutton,*three_dots;
    UILabel *upcomming_event,*recent_event;
    BoardPopUp *bpop1;
    UILabel *Search_bar,*Search_bar1;
    int iscallback,chkEvent;
    UILabel *Podcast_bar, *Podcast_bar1;
    NSArray *upcomAr,*rcntAr;
    PodcastPopUp *ppop;
    popups *spop;
    UILabel *notification_bar2,*Search_bar2;
    UIView *cell_View;
    UIButton *advance;
    LeftRightDrawer *drawer;
    UIView *hidview;
    UIButton *acppt,*decline;
    int cellheight;
    NSString *podsid,*uId;
    ManageArray *mang;
    NSMutableArray *acceptBtnAr,*rejectBtnAr,*messageLablAr;
    
}
@end

@implementation Podcast
@synthesize upcomingtableView,recentTableView,mynotification;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [SavePrefrences sharedInstance].textsize=18;
    
    drawer=[[LeftRightDrawer alloc]init];
    spop=[[popups alloc]init];
    bpop1=[[BoardPopUp alloc]init];
    ppop=[[PodcastPopUp alloc]init];
    mang= [[ManageArray alloc]init];
    self.view.backgroundColor=[UIColor colorWithRed:189.0f/255 green:189.0f/255 blue:189.0f/255 alpha:1.0f];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    // [self retrieveNotifications];
    [self customizeActionBar];
}



-(void)customizeActionBar
{
    
    
    [SavePrefrences sharedInstance].ischkpodcast=@"1";
    podAr =[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"];
    NSLog(@"pod ar====%@",podAr);
    
    
    
    for (NSInteger i = (int)podAr.count - 1; i >= 0 ; i--)
    {
        NSString * time=[[podAr valueForKey:@"time"] objectAtIndex:i];
        NSString * ntc= [[podAr valueForKey:@"ntc"] objectAtIndex:i];
        
        if(([ntc intValue]==18)||([ntc intValue]==19)||([ntc intValue]==20)||([ntc intValue]==21)||([ntc intValue]==22))
        {
            if([[[SavePrefrences sharedInstance].notiWithoutADR allKeys] containsObject:time])
            {
                [podAr removeObjectAtIndex:i];
            }
            else
            {
                [[SavePrefrences sharedInstance].notiWithoutADR setValue:time forKey:time];
            }
        }
        
    }
    
    
    
    
    
    [drawer initArs:self];
    
    
    if([podAr count]>0)
    {
        [self setTabBar];
        
//        hidview.hidden=true;
//        middle_label.hidden=true;
//        [self clearRecentEventview];
//        [self clearupcomingEventview];
        
        //here added this method to add search bar in search tab
        [self SearchView];

    }
    else
    {
        [self TabbarWithoutNotification];
         [self SearchView];
        
    }
   
}


#pragma mark setTabBar
// tab1  [UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f]
// tab2  [UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f]
// tab3  [UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f]


-(void) setTabBar
{
    //[self retrieveNotifications];
    NSMutableDictionary *pd=[SavePrefrences sharedInstance].colorDictionry;
    
   

    option=[[UIView alloc]initWithFrame:CGRectMake(0, 70, screenWidth, screenHeight)];
    option.backgroundColor=[pd valueForKey:@"backcolor"];
    [self.view addSubview:option];
    
    int hght=(option.frame.size.height-100)/4;
    float lty=(hght)/4;
   //130:197:246
    UILabel *Notification=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth/3 +0.6, lty)];
    Notification.text=@"Notification";
    Notification.userInteractionEnabled=false;
    Notification.textAlignment=NSTextAlignmentCenter;
    [Notification setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Notification.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    Notification.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    [option addSubview:Notification];
    
    
    notification_bar2=[[UILabel alloc]initWithFrame:CGRectMake(0,Notification.frame.size.height+Notification.frame.origin.y, screenWidth/3, 3)];
    notification_bar2.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    [option addSubview:notification_bar2];
    
    UITapGestureRecognizer *notificationReg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(NotiView)];
    [notificationReg setNumberOfTouchesRequired:1];
    [notificationReg setDelegate:self];
    Notification.userInteractionEnabled = YES;
    Notification.tag=0;
    [Notification addGestureRecognizer:notificationReg];
    
    
    
    
    UILabel *Search_lbl=[[UILabel alloc]initWithFrame:CGRectMake(Notification.frame.size.width+Notification.frame.origin.x, 0, screenWidth/3,lty)];
    Search_lbl.text=@"Search";
    Search_lbl.textAlignment=NSTextAlignmentCenter;
    [Search_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Search_lbl.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    Search_lbl.textColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    [option addSubview:Search_lbl];
    
    Search_bar=[[UILabel alloc]initWithFrame:CGRectMake(notification_bar2.frame.size.width+notification_bar2.frame.origin.x, Search_lbl.frame.size.height+Search_lbl.frame.origin.y, screenWidth/3, 3)];
    Search_bar.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [option addSubview:Search_bar];
    
    Search_bar2=[[UILabel alloc]initWithFrame:CGRectMake(notification_bar2.frame.size.width+notification_bar2.frame.origin.x, Search_lbl.frame.size.height+Search_lbl.frame.origin.y, screenWidth/3, 3)];
    Search_bar2.hidden=true;
    Search_bar2.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    [option addSubview:Search_bar2];
    
    
    UITapGestureRecognizer *searchlblreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Searchlist)];
    [searchlblreg setNumberOfTouchesRequired:1];
    [searchlblreg setDelegate:self];
    Search_lbl.userInteractionEnabled = YES;
    [Search_lbl addGestureRecognizer:searchlblreg];
    
    
    
    UILabel *Podcast_lbl=[[UILabel alloc]initWithFrame:CGRectMake(Search_lbl.frame.size.width+Search_lbl.frame.origin.x,0, screenWidth/3,lty)];
    Podcast_lbl.text=@"Podcast";
    Podcast_lbl.textAlignment=NSTextAlignmentCenter;
    [Podcast_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Podcast_lbl.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    Podcast_lbl.textColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    [option addSubview:Podcast_lbl];
    
    Podcast_bar=[[UILabel alloc]initWithFrame:CGRectMake(Search_bar.frame.size.width+Search_bar.frame.origin.x,Podcast_lbl.frame.size.height+Podcast_lbl.frame.origin.y , screenWidth/2,3)];
    Podcast_bar.backgroundColor=[UIColor clearColor];
    [option addSubview:Podcast_bar];
    
    UITapGestureRecognizer *MyPodreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Podcast)];
    [MyPodreg setNumberOfTouchesRequired:1];
    [MyPodreg setDelegate:self];
    Podcast_lbl.userInteractionEnabled = YES;
    [Podcast_lbl addGestureRecognizer:MyPodreg];
    
    hidview=[[UIView alloc]initWithFrame:CGRectMake(0, Search_bar2.frame.size.height+Search_bar2.frame.origin.y, screenWidth, lty)];
    hidview.backgroundColor=[UIColor greenColor];
    hidview.hidden=true;
    [option addSubview:hidview];
    
    
    upcomming_event=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth/2, lty)];
    upcomming_event.text=@"Upcoming Event";
    upcomming_event.textAlignment=NSTextAlignmentCenter;
    [upcomming_event setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    upcomming_event.backgroundColor=[pd valueForKey:@"backcolor"];
    upcomming_event.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    [hidview addSubview:upcomming_event];
    
    
    UITapGestureRecognizer *upcomingEventreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retrieveUpcomingEvent)];
    [upcomingEventreg setNumberOfTouchesRequired:1];
    [upcomingEventreg setDelegate:self];
    upcomming_event.userInteractionEnabled = YES;
    upcomming_event.tag=10;
    [upcomming_event addGestureRecognizer:upcomingEventreg];
    
    recent_event=[[UILabel alloc]initWithFrame:CGRectMake(upcomming_event.frame.size.width+upcomming_event.frame.origin.x,0, screenWidth/2, lty)];
    recent_event.text=@"Recent Event";
    recent_event.textAlignment=NSTextAlignmentCenter;
    [recent_event setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    recent_event.backgroundColor=[pd valueForKey:@"backcolor"];
    recent_event.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:183.0f/255 alpha:1.0f];
    [hidview addSubview:recent_event];
    
    UITapGestureRecognizer *RecentEventreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retrieveRecentEvent)];
    [RecentEventreg2 setNumberOfTouchesRequired:1];
    [RecentEventreg2 setDelegate:self];
    recent_event.userInteractionEnabled = YES;
    recent_event.tag=11;
    [recent_event addGestureRecognizer:RecentEventreg2];
    
    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, hidview.frame.size.height+hidview.frame.origin.y, screenWidth, lty)];
    middle_label.backgroundColor=[UIColor colorWithRed:244.0/255 green:244.0/255 blue:255.0/255 alpha:1.0];
    middle_label.hidden=true;
    [option addSubview:middle_label];
    
    [self NotiView];
}

-(void) NotiView
{
    
    [upcomingtableView removeFromSuperview];
    [recentTableView removeFromSuperview];
    
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    NSLog(@"helllo noti");
    notification_bar2.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    hidview.hidden=true;
    middle_label.hidden=true;
    Search_bar2.hidden=true;
    
    
    mynotification =  [[UITableView alloc] initWithFrame:CGRectMake(0,notification_bar2.frame.size.height+notification_bar2.frame.origin.y+5,middle_label.frame.size.width,screenHeight-(middle_label.frame.size.height+middle_label.frame.origin.y+90))];
    mynotification.delegate = self;
    mynotification.dataSource = self;
    mynotification.scrollEnabled = YES;
    mynotification.backgroundColor=[ff valueForKey:@"backcolor"];
    mynotification.separatorColor=[ff valueForKey:@"backcolor"];
    [option addSubview:mynotification];
    
}



#pragma mark TabbarWithoutNotification

// tab1  [UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f]
// tab2  [UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f]
// tab3  [UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f]


-(void) TabbarWithoutNotification
{
   // [self retrieveNotifications];
    NSMutableDictionary *pd=[SavePrefrences sharedInstance].colorDictionry;
    
    
    option=[[UIView alloc]initWithFrame:CGRectMake(0, 70, screenWidth, screenHeight)];
    option.backgroundColor=[pd valueForKey:@"backcolor"];
    [self.view addSubview:option];
    
    int hght=(option.frame.size.height-100)/4;
    float lty=(hght)/4;
    
    
    UILabel *Search_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth/2,lty)];
    Search_lbl.text=@"Search";
    Search_lbl.textAlignment=NSTextAlignmentCenter;
    [Search_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Search_lbl.backgroundColor=[pd valueForKey:@"clearColor"];
    Search_lbl.textColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    [option addSubview:Search_lbl];
    
    Search_bar=[[UILabel alloc]initWithFrame:CGRectMake(0, Search_lbl.frame.size.height+Search_lbl.frame.origin.y, screenWidth/2, 3)];
    Search_bar.backgroundColor=[UIColor clearColor];
    [option addSubview:Search_bar];
    
    Search_bar2=[[UILabel alloc]initWithFrame:CGRectMake(0, Search_lbl.frame.size.height+Search_lbl.frame.origin.y, screenWidth/2, 3)];
    Search_bar2.hidden=true;
    Search_bar2.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    [option addSubview:Search_bar2];
    
    
    UITapGestureRecognizer *searchlblreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Searchlist)];
    [searchlblreg setNumberOfTouchesRequired:1];
    [searchlblreg setDelegate:self];
    Search_lbl.userInteractionEnabled = YES;
    [Search_lbl addGestureRecognizer:searchlblreg];
    
    
    
    UILabel *Podcast_lbl=[[UILabel alloc]initWithFrame:CGRectMake(Search_lbl.frame.size.width+Search_lbl.frame.origin.x,0, screenWidth/2,lty)];
    Podcast_lbl.text=@"Podcast";
    Podcast_lbl.textAlignment=NSTextAlignmentCenter;
    [Podcast_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Podcast_lbl.backgroundColor=[pd valueForKey:@"clearColor"];
    Podcast_lbl.textColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    [option addSubview:Podcast_lbl];
    
    Podcast_bar=[[UILabel alloc]initWithFrame:CGRectMake(Search_bar.frame.size.width+Search_bar.frame.origin.x,Podcast_lbl.frame.size.height+Podcast_lbl.frame.origin.y , screenWidth/2,3)];
    Podcast_bar.backgroundColor=[UIColor clearColor];
    [option addSubview:Podcast_bar];
    
    UITapGestureRecognizer *MyPodreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Podcast)];
    [MyPodreg setNumberOfTouchesRequired:1];
    [MyPodreg setDelegate:self];
    Podcast_lbl.userInteractionEnabled = YES;
    [Podcast_lbl addGestureRecognizer:MyPodreg];
    
    hidview=[[UIView alloc]initWithFrame:CGRectMake(0, Search_bar2.frame.size.height+Search_bar2.frame.origin.y, screenWidth, lty)];
    hidview.backgroundColor=[UIColor greenColor];
    hidview.hidden=true;
    [option addSubview:hidview];
    //130:197:246
    upcomming_event=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth/2, lty)];
    upcomming_event.text=@"Upcoming Event";
    upcomming_event.textAlignment=NSTextAlignmentCenter;
    [upcomming_event setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    upcomming_event.backgroundColor=[pd valueForKey:@"backcolor"];
    upcomming_event.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    [hidview addSubview:upcomming_event];
    
    
    UITapGestureRecognizer *upcomingEventreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retrieveUpcomingEvent)];
    [upcomingEventreg setNumberOfTouchesRequired:1];
    [upcomingEventreg setDelegate:self];
    upcomming_event.userInteractionEnabled = YES;
    upcomming_event.tag=10;
    [upcomming_event addGestureRecognizer:upcomingEventreg];
    
    recent_event=[[UILabel alloc]initWithFrame:CGRectMake(upcomming_event.frame.size.width+upcomming_event.frame.origin.x,0, screenWidth/2, lty)];
    recent_event.text=@"Recent Event";
    recent_event.textAlignment=NSTextAlignmentCenter;
    [recent_event setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    recent_event.backgroundColor=[pd valueForKey:@"backcolor"];
    recent_event.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:183.0f/255 alpha:1.0f];
    [hidview addSubview:recent_event];
    
    UITapGestureRecognizer *RecentEventreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retrieveRecentEvent)];
    [RecentEventreg2 setNumberOfTouchesRequired:1];
    [RecentEventreg2 setDelegate:self];
    recent_event.userInteractionEnabled = YES;
    recent_event.tag=11;
    [recent_event addGestureRecognizer:RecentEventreg2];
    
    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, hidview.frame.size.height+hidview.frame.origin.y, screenWidth, lty)];
    middle_label.backgroundColor=[UIColor colorWithRed:244.0/255 green:244.0/255 blue:255.0/255 alpha:1.0];
    middle_label.hidden=true;
    [option addSubview:middle_label];
    
    [self SearchView];
    [self Searchlist];
    
}



-(void)Searchlist
{
    hidview.hidden=false;
    middle_label.hidden=false;
    Search_bar2.hidden=false;
    notification_bar2.backgroundColor=[UIColor clearColor];
    [mynotification removeFromSuperview];
    [self retrieveUpcomingEvent];
}

-(void)SearchView
  {
      int divx=middle_label.frame.size.width/4;
      
        int divy=middle_label.frame.size.width/2;
      //225:232:239
    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(5, 3.5,middle_label.frame.size.width/2+75,middle_label.frame.size.height-7)];
    search_lbl.backgroundColor=[UIColor colorWithRed:225.0f/255 green:232.0f/255 blue:239.0f/255 alpha:1.0f];
    search_lbl.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
   // search_lbl.placeholder=@"Search...";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    search_lbl.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search..." attributes:@{NSForegroundColorAttributeName: color}];

    search_lbl.layer.cornerRadius=1.5;
    search_lbl.delegate=self;
    //////////
    UIView *padding1   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = padding1 ;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
//      [search_lbl addTarget:self action:@selector(SearchUpRecent:) forControlEvents:UIControlEventEditingChanged];

      /////////
    [middle_label addSubview:search_lbl];
    
    searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+7, 4,25,25)];
    searchbutton.backgroundColor=[UIColor clearColor];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *RecentEventreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SearchUpRecent:)];
    [RecentEventreg2 setNumberOfTouchesRequired:1];
    [RecentEventreg2 setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:RecentEventreg2];
    
    
   /* industry_btn=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 3.5, divy/3 -30, middle_label.frame.size.height-6)];
    industry_btn.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
      [industry_btn setImage:[UIImage imageNamed:@"industry.png"] forState:UIControlStateNormal];
      [industry_btn addTarget:self action:@selector(PodcastIndSearch:) forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:industry_btn];*/
    
    advance=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+7, 0, middle_label.frame.size.height, middle_label.frame.size.height)];
    advance.backgroundColor=[UIColor clearColor];
      [advance setImage:[UIImage imageNamed:@"advance-search.png"] forState:UIControlStateNormal];
    [advance addTarget:self action:@selector(PodcastAdvance:) forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:advance];
    
      UIView *imgset=[[UIView alloc]initWithFrame:CGRectMake(advance.frame.size.width+advance.frame.origin.x+7, 0, 35, middle_label.frame.size.height)];
      imgset.backgroundColor=[UIColor clearColor];
      [middle_label addSubview:imgset];
  
      UIImageView *three_dots=[[UIImageView  alloc]initWithFrame:CGRectMake(0, 3.5, 25, middle_label.frame.size.height-7)];
      three_dots.image=[UIImage imageNamed:@"more.png"];
      [imgset addSubview:three_dots];
      
      UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(sortnow:)];
      [sworkingreg2 setNumberOfTouchesRequired:1];
      [sworkingreg2 setDelegate:self];
      imgset.userInteractionEnabled = YES;
      imgset.tag=1;
      [imgset addGestureRecognizer:sworkingreg2];
    
    [self upcomingEvent];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"predddd");
    [textField resignFirstResponder];
    return YES;
}


-(void)SearchUpRecent:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    if((int)tg.view.tag==upcomming_event.tag)
    {
        iscallback=1;
        
        [dic1 setObject:@"" forKey:@"indus"];
        [dic1 setObject:@"" forKey:@"topic"];
        [dic1 setObject:search_lbl.text forKey:@"key"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"SearchPod" :@"searchPod" :@"":@"":dic1 :self];
    }
    else if ((int)tg.view.tag==recent_event.tag)
    {
        iscallback=3;
        [dic1 setObject:@"" forKey:@"indus"];
        [dic1 setObject:@"" forKey:@"topic"];
        [dic1 setObject:search_lbl.text forKey:@"key"];
        [[SavePrefrences sharedInstance].skthand emitData:@"RecentPod" :@"searchPodrecent" :@"":@"":dic1 :self];
    }
}
-(void)retrieveUpcomingEvent
{
    iscallback=0;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setValue:@"0" forKey:@"limit"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"SearchPod" :@"getPodSrch" :@"":@"":dic1 :self];
}


-(void)retrieveRecentEvent
{
    iscallback=2;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setValue:@"0" forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"RecentPod" :@"getPodRecent" :@"":@"":dic1 :self];
}
#pragma mark tableView
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


-(void)upcomingEvent
{
    NSMutableDictionary *pd=[SavePrefrences sharedInstance].colorDictionry;
    
    //  [self clearRecentEventview];
    [recentTableView removeFromSuperview];
    //  [mynotification removeFromSuperview];
    //130:197:246
    upcomming_event.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    recent_event.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    searchbutton.tag=upcomming_event.tag;
    search_lbl.tag=upcomming_event.tag;
  //  industry_btn.tag=upcomming_event.tag;
    advance.tag=upcomming_event.tag;
    three_dots.tag=upcomming_event.tag;
    
    chkEvent=10;
    
    upcomingtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, middle_label.frame.size.height+middle_label.frame.origin.y+5,middle_label.frame.size.width,screenHeight-(middle_label.frame.size.height+middle_label.frame.origin.y+50))];
    upcomingtableView.delegate = self;
    upcomingtableView.dataSource = self;
    upcomingtableView.scrollEnabled = YES;
    upcomingtableView.backgroundColor=[pd valueForKey:@"backcolor"];
    upcomingtableView.separatorColor=[pd valueForKey:@"backcolor"];
    
    [option addSubview:upcomingtableView];
    
    
}

-(void)RecentEvent
{
    
    NSMutableDictionary *pd=[SavePrefrences sharedInstance].colorDictionry;
    //  [self clearupcomingEventview];
    
    [upcomingtableView removeFromSuperview];
    //  [mynotification removeFromSuperview];
    recent_event.textColor=[pd valueForKey:@"Yellowbtncolor"];
    upcomming_event.textColor=[pd valueForKey:@"Videocolor"];
   
    recent_event.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    upcomming_event.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];

    
    searchbutton.tag=recent_event.tag;
    search_lbl.tag=recent_event.tag;
   // industry_btn.tag=recent_event.tag;
    advance.tag=recent_event.tag;
    three_dots.tag=recent_event.tag;
    
    chkEvent=11;
    
    recentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, middle_label.frame.size.height+middle_label.frame.origin.y+5,middle_label.frame.size.width,screenHeight-(middle_label.frame.size.height+middle_label.frame.origin.y+50))];
    
    recentTableView.delegate = self;
    recentTableView.dataSource = self;
    recentTableView.scrollEnabled = YES;
    recentTableView.backgroundColor=[pd valueForKey:@"backcolor"];
    recentTableView.separatorColor=[pd valueForKey:@"backcolor"];
    [option addSubview:recentTableView];
    
}





-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if(theTableView==upcomingtableView)
    {
        cellheight=195;
        return [upcomAr count];
    }
    else if(theTableView==recentTableView)
    {
        cellheight=185;
        return [rcntAr count];
    }
    else if (theTableView==mynotification)
    {
        cellheight=70;
        acceptBtnAr=[[NSMutableArray alloc]init];
        rejectBtnAr=[[NSMutableArray alloc]init];
        messageLablAr=[[NSMutableArray alloc]init];
        
       
        for(int c=0;c<[podAr count];c++)
        {
            NSString * bid=[[podAr valueForKey:@"uid"] objectAtIndex:c];
            NSLog(@"bid====%@",bid);
            if([bid intValue] ==[[SavePrefrences sharedInstance].uid intValue])
            {
                [podAr removeObjectAtIndex:c];
            }
        }
        return [podAr count];
        
        
       
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *pd=[SavePrefrences sharedInstance].colorDictionry;
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.upcomingtableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.backgroundColor=[pd valueForKey:@"backcolor"];
    
    if(theTableView==upcomingtableView)
    {
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 5, screenWidth-10, 180)];
        cell_View.backgroundColor=[pd valueForKey:@"backcolor"];
        [cell addSubview: cell_View];
        
        NSString *title=[[upcomAr objectAtIndex:indexPath.row]valueForKey:@"title"];
        NSString *description=[[upcomAr objectAtIndex:indexPath.row]valueForKey:@"description"];
        NSString *duration=[[upcomAr objectAtIndex:indexPath.row]valueForKey:@"duration"];
        NSString *start_time=[[upcomAr objectAtIndex:indexPath.row]valueForKey:@"start_time"];
        NSString *po_id=[[upcomAr objectAtIndex:indexPath.row]valueForKey:@"po_id"];
        NSString *uid=[[upcomAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *image=[[upcomAr objectAtIndex:indexPath.row]valueForKey:@"image"];
        NSString *timelog=[[upcomAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];

        
        UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUprcntEvent:)];
        [sworkingreg2 setNumberOfTouchesRequired:1];
        [sworkingreg2 setDelegate:self];
        cell.userInteractionEnabled = YES;
        cell.tag=indexPath.row;
        [cell addGestureRecognizer:sworkingreg2];
        
        UILabel *uname_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell_View.frame.size.width, 25) ];
        uname_lbl.text=title;
        uname_lbl.textColor=[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0];
        uname_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [cell_View addSubview:uname_lbl];
        
        UIButton *Participant=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        Participant.frame=CGRectMake(5, 5, cell_View.frame.size.width-10, 25);
        [Participant setTitle:@"Participate" forState:UIControlStateNormal];
        Participant.tag=[po_id intValue];
        [Participant setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [Participant setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
        Participant.layer.cornerRadius=6;
        Participant.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        if([[SavePrefrences sharedInstance].uid intValue]==[uid intValue])
        {
            Participant.hidden=true;
        }
        else
        {
            Participant.hidden=false;
        }
        Participant.backgroundColor=[pd valueForKey:@"Videocolor"];
        [cell_View addSubview:Participant];

        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,uname_lbl.frame.size.height+uname_lbl.frame.origin.y+2,self.view.bounds.size.width,1)];
        separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
        [cell_View addSubview:separator];
        
        int hight1=cell_View.frame.size.height/2+10;
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, separator.frame.size.height+separator.frame.origin.y+5, hight1, hight1)];
        img.image=[UIImage imageNamed:@"pictureicn.png"];
        img.backgroundColor=[UIColor lightGrayColor];
        [cell_View addSubview:img];
        NSString * url=[mang concatUrl:image];
        if(url.length<12)
        {
            img.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            if(imageData.length<=0)
                img.image = [UIImage imageNamed:@"username.png"];
            else
                img.image = [UIImage imageWithData:imageData];
        }
        
        
        ////////////////////////
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x, separator.frame.size.height+separator.frame.origin.y+10, cell_View.frame.size.width-45, cell_View.frame.size.height-100)];
        viewDetails.backgroundColor=[UIColor clearColor];
        viewDetails.clipsToBounds=YES;
        [cell_View addSubview:viewDetails];
        
        UILabel *Scheduled1=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 100, 20)];
        Scheduled1.text=@"Scheduled On :  ";
        Scheduled1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Scheduled1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Scheduled1.textAlignment=NSTextAlignmentRight;
        Scheduled1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Scheduled1];
        
        UILabel *Scheduled=[[UILabel alloc]initWithFrame:CGRectMake(Scheduled1.frame.size.width+2,  0, 200, 20) ];
        Scheduled.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        Scheduled.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        Scheduled.text= timelog;
        [viewDetails addSubview:Scheduled];
      
        
        UILabel *Duration1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Scheduled1.frame.size.height+Scheduled1.frame.origin.y+2, 100, 20)];
        Duration1.text=@"Duration :  ";
        Duration1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Duration1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Duration1.textAlignment=NSTextAlignmentRight;
        Duration1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Duration1];
        
        UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration1.frame.size.width+2+2, Scheduled1.frame.size.height+Scheduled1.frame.origin.y+2, 200, 20)];
        duration_time.textAlignment=NSTextAlignmentLeft;
        duration_time.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        duration_time.text=duration;
        [viewDetails addSubview:duration_time];
        
        UILabel *Time1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Duration1.frame.size.height+Duration1.frame.origin.y+2,100, 20)];
        Time1.text=@"Start Time :  ";
        Time1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Time1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Time1.textAlignment=NSTextAlignmentRight;
        Time1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Time1];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Time1.frame.size.width+2+2,  Duration1.frame.size.height+Duration1.frame.origin.y+2, 200, 20)];
        time.text=start_time;
        time.textAlignment=NSTextAlignmentLeft;
        time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        time.textColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
        [viewDetails addSubview:time];
        
        ///////////////////////

        UITextView *subName=[[UITextView alloc]initWithFrame:CGRectMake(10, img.frame.size.height+img.frame.origin.y +5, cell_View.frame.size.width, 45) ];
        subName.text=description;
        subName.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        subName.backgroundColor=[UIColor clearColor];
        subName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        subName.editable=NO;
        [cell_View addSubview:subName];

        
        
        return cell;
    }
    if(theTableView==recentTableView)
    {
        
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 5, screenWidth-10, 180)];
        cell_View.backgroundColor=[pd valueForKey:@"backcolor"];
        [cell addSubview: cell_View];
        
        NSString *start_time=[[rcntAr objectAtIndex:indexPath.row]valueForKey:@"start_time"];
        NSString *title=[[rcntAr objectAtIndex:indexPath.row]valueForKey:@"title"];
        NSString *description=[[rcntAr objectAtIndex:indexPath.row]valueForKey:@"description"];
        NSString *duration=[[rcntAr objectAtIndex:indexPath.row]valueForKey:@"duration"];
        NSString *po_id=[[rcntAr objectAtIndex:indexPath.row]valueForKey:@"po_id"];
        NSString *uid=[[rcntAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *image=[[rcntAr objectAtIndex:indexPath.row]valueForKey:@"image"];
        NSString *timelog=[[rcntAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];
        
   /*
//
//        UIButton *Participant=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        Participant.frame=CGRectMake(15, bar.frame.size.height+bar.frame.origin.y+10, 80, 25);
//        [Participant setTitle:@"Participate" forState:UIControlStateNormal];
//        [Participant setFont:[UIFont fontWithName:@"Times New Roman" size:12]];
//        [Participant setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
//        Participant.layer.cornerRadius=6;
//        if([[SavePrefrences sharedInstance].uid intValue]==[uid intValue])
//        {
//            Participant.hidden=true;
//        }
//        else
//        {
//            Participant.hidden=false;
//        }
//        Participant.backgroundColor=[pd valueForKey:@"Videocolor"];
//        [cell_View addSubview:Participant];
        
        
        
      
        UIButton *readmore=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        readmore.frame=CGRectMake(cell_View.frame.size.width-100, bar.frame.size.height+bar.frame.origin.y+10, 80, 25);
        [readmore setTitle:@"Read More" forState:UIControlStateNormal];
        [readmore setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        //[readmore addTarget:self action:@selector(readMorePod:) forControlEvents:UIControlEventTouchUpInside];
        [readmore setTitleColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
         readmore.layer.cornerRadius=6;
         readmore.tag=[po_id intValue];
         readmore.backgroundColor=[pd valueForKey:@"Videocolor"];
        
        UITapGestureRecognizer *sreadmore = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUprcntEvent:)];
        [sreadmore setNumberOfTouchesRequired:1];
        [sreadmore setDelegate:self];
        readmore.userInteractionEnabled = YES;
        readmore.tag=indexPath.row;
        [readmore addGestureRecognizer:sreadmore];
        [cell_View addSubview:readmore];*/
        
        UITapGestureRecognizer *sworkingreg3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUprcntEvent:)];
        [sworkingreg3 setNumberOfTouchesRequired:1];
        [sworkingreg3 setDelegate:self];
        cell.userInteractionEnabled = YES;
        cell.tag=indexPath.row;
        [cell addGestureRecognizer:sworkingreg3];

        UILabel *uname_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell_View.frame.size.width, 25) ];
        uname_lbl.text=title;
        uname_lbl.textColor=[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0];
        uname_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [cell_View addSubview:uname_lbl];
        
        UIButton *Participant=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        Participant.frame=CGRectMake(5, 5, cell_View.frame.size.width-10, 25);
        [Participant setTitle:@"Participate" forState:UIControlStateNormal];
        Participant.tag=[po_id intValue];
        [Participant setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [Participant setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
        Participant.layer.cornerRadius=6;
        Participant.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        if([[SavePrefrences sharedInstance].uid intValue]==[uid intValue])
        {
            Participant.hidden=true;
        }
        else
        {
            Participant.hidden=false;
        }
        Participant.backgroundColor=[pd valueForKey:@"Videocolor"];
        [cell_View addSubview:Participant];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,uname_lbl.frame.size.height+uname_lbl.frame.origin.y+2,self.view.bounds.size.width,1)];
        separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
        [cell_View addSubview:separator];
        
        int hight1=cell_View.frame.size.height/2+10;
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, separator.frame.size.height+separator.frame.origin.y+5, hight1, hight1)];
        img.image=[UIImage imageNamed:@"pictureicn.png"];
        img.backgroundColor=[UIColor lightGrayColor];
        img.layer.cornerRadius=hight1/2;
        img.clipsToBounds=YES;
        [cell_View addSubview:img];
        NSString * url=[mang concatUrl:image];
        if(url.length<12)
        {
            img.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            if(imageData.length<=0)
                img.image = [UIImage imageNamed:@"username.png"];
            else
                img.image = [UIImage imageWithData:imageData];
        }
        
        
        ////////////////////////
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x, separator.frame.size.height+separator.frame.origin.y+10, cell_View.frame.size.width-45, cell_View.frame.size.height-100)];
        viewDetails.backgroundColor=[UIColor clearColor];
        viewDetails.clipsToBounds=YES;
        [cell_View addSubview:viewDetails];
        
        UILabel *Scheduled1=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 100, 20)];
        Scheduled1.text=@"Scheduled On :  ";
        Scheduled1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Scheduled1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Scheduled1.textAlignment=NSTextAlignmentRight;
        Scheduled1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Scheduled1];
        
        UILabel *Scheduled=[[UILabel alloc]initWithFrame:CGRectMake(Scheduled1.frame.size.width+2,  0, 200, 20) ];
        Scheduled.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        Scheduled.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        Scheduled.text= timelog;
        [viewDetails addSubview:Scheduled];
        
        
        UILabel *Duration1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Scheduled1.frame.size.height+Scheduled1.frame.origin.y+2, 100, 20)];
        Duration1.text=@"Duration :  ";
        Duration1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Duration1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Duration1.textAlignment=NSTextAlignmentRight;
        Duration1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Duration1];
        
        UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration1.frame.size.width+2+2, Scheduled1.frame.size.height+Scheduled1.frame.origin.y+2, 200, 20)];
        duration_time.textAlignment=NSTextAlignmentLeft;
        duration_time.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        duration_time.text=duration;
        [viewDetails addSubview:duration_time];
        
        
        UILabel *Time1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Duration1.frame.size.height+Duration1.frame.origin.y+2,100, 20)];
        Time1.text=@"Start Time :  ";
        Time1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Time1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Time1.textAlignment=NSTextAlignmentRight;
        Time1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Time1];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Time1.frame.size.width+2+2,  Duration1.frame.size.height+Duration1.frame.origin.y+2, 200, 20)];
        time.text=start_time;
        time.textAlignment=NSTextAlignmentLeft;
        time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        time.textColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
        [viewDetails addSubview:time];
        
        ///////////////////////
        
        UITextView *subName=[[UITextView alloc]initWithFrame:CGRectMake(10, img.frame.size.height+img.frame.origin.y +5, cell_View.frame.size.width, 45) ];
        subName.text=description;
        subName.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        subName.backgroundColor=[UIColor clearColor];
        subName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        subName.editable=NO;
        [cell_View addSubview:subName];
        
        return cell;
    }
    if(theTableView==mynotification)
    {
        
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 5, screenWidth-10, 70)];
        cell_View.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        [cell addSubview: cell_View];
        
        NSArray * data=[podAr objectAtIndex:indexPath.row];
        NSString *uname=[data valueForKey:@"uname"];
        NSString *lastname=[data valueForKey:@"lname"];
        NSString *ntc=[data valueForKey:@"ntc"];
        NSString *noti_id=[data valueForKey:@"noti_id"];
     
        UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.size.height/2-13, 35, 35)];
      //  [userpic setImage:[UIImage imageNamed:@"user.png"]];
        userpic.layer.cornerRadius=17;
        userpic.clipsToBounds=YES;
        [cell_View addSubview:userpic];

        UILabel *timlb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell_View.frame.size.width-10, 20)];
        timlb.text=@"Few Sec Ago";
        timlb.textColor=[UIColor blackColor];
        [timlb setFont:[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:13]];
        timlb.textAlignment=NSTextAlignmentRight;
        timlb.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:timlb];

        UILabel *title_lbl11=[[UILabel alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10,timlb.frame.size.height+timlb.frame.origin.y,cell_View.frame.size.width-10, 20)];
        title_lbl11.backgroundColor=[UIColor clearColor];
        title_lbl11.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        title_lbl11.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        title_lbl11.text=[NSString stringWithFormat:@"%@ %@", uname, lastname];
        [cell_View addSubview:title_lbl11];

        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10, title_lbl11.frame.size.height+title_lbl11.frame.origin.y+5,cell_View.frame.size.width-10, 20)];
        title_lbl.backgroundColor=[UIColor clearColor];
        title_lbl.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        [cell_View addSubview:title_lbl];
        title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        [messageLablAr addObject:title_lbl];

        acppt=[[UIButton alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+20,title_lbl.frame.size.height+title_lbl.frame.origin.y+5,70,20)];
        acppt.backgroundColor=[pd valueForKey:@"clarColor"];
        [acppt setTitle:@"Accept" forState:UIControlStateNormal];
        [acppt setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        acppt.titleLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
        acppt.tag=indexPath.row;
      
        [acceptBtnAr addObject:acppt];

        [cell_View addSubview:acppt];

        UIImageView *acceptImg = [[UIImageView alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+20+70,title_lbl.frame.size.height+title_lbl.frame.origin.y+5,20,20)];
        acceptImg.image=[UIImage imageNamed:@"accept1.png"];
        [cell_View addSubview:acceptImg];

        decline=[[UIButton alloc]initWithFrame:CGRectMake(acppt.frame.size.width+acppt.frame.origin.x+20,title_lbl.frame.size.height+title_lbl.frame.origin.y+5,70,20)];
        decline.backgroundColor=[pd valueForKey:@"clarColor"];
        [decline setTitle:@"Decline" forState:UIControlStateNormal];
        [decline setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        decline.titleLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        decline.tag=indexPath.row;
      
        [rejectBtnAr addObject:decline];

        [cell_View addSubview:decline];

        UIImageView *declineImage = [[UIImageView alloc]initWithFrame:CGRectMake(acppt.frame.size.width+acppt.frame.origin.x+20+70,title_lbl.frame.size.height+title_lbl.frame.origin.y+5,20,20)];
        declineImage.image=[UIImage imageNamed:@"deny.png"];
        [cell_View addSubview:declineImage];
        
        UIButton *btnChat = [[UIButton alloc]initWithFrame:CGRectMake(declineImage.frame.size.width+declineImage.frame.origin.x+15+30,title_lbl.frame.size.height+title_lbl.frame.origin.y+5, 20,20)];
        btnChat.backgroundColor= [UIColor clearColor];
        [btnChat setBackgroundImage:[UIImage imageNamed:@"chatNew.png"] forState:UIControlStateNormal];
        btnChat.layer.cornerRadius=5;
        btnChat.tag=0;
        [cell_View addSubview:btnChat];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,btnChat.frame.size.height+btnChat.frame.origin.y+7,self.view.bounds.size.width,1)];
        separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:0.75];
        [cell_View addSubview:separator];
        
        NSString * tit;
        
        if([ntc intValue]==16)
        {
            
            NSArray * jsonObject=[mang convertojson:data];
            NSString * tit1,*podId;
            if([mang checkContaine:jsonObject])
            {
                tit1=[jsonObject valueForKey:@"title"];
                podId=[jsonObject valueForKey:@"podId"];
                tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc16] stringByAppendingString:tit1];
            }
            else
            {
                tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc16] ;
            }
            [acppt addTarget:self action:@selector(acceptPodcast:) forControlEvents:UIControlEventTouchUpInside];
            
            [decline addTarget:self action:@selector(acceptPodcast:) forControlEvents:UIControlEventTouchUpInside];
            
            title_lbl.text=tit;
            
        }
        else if([ntc intValue]==17)
            
        {
            NSArray * jsonObject=[mang convertojson:data];
            NSString * tit1,*podId;
            if([mang checkContaine:jsonObject])
            {
                tit1=[jsonObject valueForKey:@"title"];
                podId=[jsonObject valueForKey:@"podId"];
                tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc17] stringByAppendingString:tit1];
            }
            else
            {
                tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc17];
            }
            title_lbl.text=tit;
            [acppt addTarget:self action:@selector(acceptPodcast:) forControlEvents:UIControlEventTouchUpInside];
            [decline addTarget:self action:@selector(acceptPodcast:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        else if([ntc intValue]==18)
        {
            acppt.hidden=true;
            decline.hidden=true;
            acceptImg.hidden=true;
            declineImage.hidden=true;

            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc18];
            [[SavePrefrences sharedInstance].isAlViedDic setValue:noti_id forKey:noti_id];
            
            title_lbl.text=tit;
        }
        
        else if([ntc intValue]==19)
        {
            acppt.hidden=true;
            decline.hidden=true;
            acceptImg.hidden=true;
            declineImage.hidden=true;

            
             NSArray * jsonObject=[mang convertojson:data];
            NSString * tit1=[jsonObject valueForKey:@"title"];
            tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc19] stringByAppendingString:tit1];
            title_lbl.text=tit;
            [[SavePrefrences sharedInstance].isAlViedDic setValue:noti_id forKey:noti_id];
        }
        
        
        
        
        
        
        
        return cell;
        
    }
    
    return cell;
    
}

-(IBAction)readMorePod:(id)sender
{
    UIButton * btn=(UIButton *)sender;
    int podid=(int)btn.tag;
    iscallback=5;
   
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%d",podid] forKey:@"pId"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"PodReadMore" :@"" :@"" :dic :self ];
 
     
    
}




-(IBAction)acceptPodcast:(id)sender

{
    
    UIButton * btn =(UIButton*)sender;
    
    UIButton *actbtn =[acceptBtnAr objectAtIndex:(int)btn.tag];
    
    UIButton *rejbtn =[rejectBtnAr objectAtIndex:(int)btn.tag];
    
    UILabel *titlelabl1 =[ messageLablAr objectAtIndex:(int)btn.tag];
    
    acppt.hidden=true;
    rejbtn.hidden=true;
    
    NSArray *data= [podAr objectAtIndex:(int)btn.tag];
    
    NSString *uname=[data valueForKey:@"uname"];
    
    NSString *sentto=[data valueForKey:@"uid"];
    
    NSString *ntc=[data valueForKey:@"ntc"];
    
    NSArray * jsonObject=[mang convertojson:data];
    
    NSString *tit1,*podId;
    if([mang checkContaine:jsonObject])
    {
        podId=[jsonObject valueForKey:@"podId"];
        tit1=[jsonObject valueForKey:@"title"];
    }
    else
    {
        podId=[jsonObject valueForKey:@"podId"];
       
    }
    NSString *frid=[data valueForKey:@"uid"];
    
    iscallback=4;
    
    if([ntc intValue]==16)
    {
       NSArray * jsonObject=[mang convertojson:data];
        NSString * ms=@"";
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[NSString stringWithFormat:@"%@",podId] forKey:@"podId"];
        [dic setObject:[NSString stringWithFormat:@"%@",sentto] forKey:@"uidFrom"];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        
        [dic setObject:@"1" forKey:@"affectedRows"];
        
        if([btn.titleLabel.text isEqual:@"Accept"])
        {
            
            [dic setObject:@"1" forKey:@"ar"];
            
            [podAr removeObjectAtIndex:(int)btn.tag];
            
            NSString *ntctxt=@" You have Accepted PodCast Invitation of ";
            
            NSString *title;
            
            if([mang checkContaine:jsonObject])
            {
                
                title=[jsonObject valueForKey:@"title"];
                 ms=[ntctxt stringByAppendingString:title];
                
            }
            else
            {
                 ms=ntctxt ;
            }
            titlelabl1.text=ms;
            [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podAR" :@"" :@"" :dic :self];
            
        }
        
        else if([btn.titleLabel.text isEqual:@"Decline"])
        {
            
            [dic setObject:@"2" forKey:@"ar"];
            [podAr removeObjectAtIndex:(int)btn.tag];
             NSString *ntctxt;
            
            if([mang checkContaine:jsonObject])
            {
                
              NSString * title=[jsonObject valueForKey:@"title"];
              ntctxt=[@" You have Rejected PodCast Invitation of " stringByAppendingString:title ];
                
            }
            else
            {
                ntctxt= @" You have Rejected PodCast Invitation of ";
            }
            
            ms=[ntctxt stringByAppendingString:uname];
            
            titlelabl1.text=ms;
            
            [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podAR" :@"" :@"" :dic :self];
            
        }
        
//        for(int x=0;x<[[SavePrefrences sharedInstance].notiYolkingAr count];x++)
//        {
//         
//          
//            
//            
//            NSArray *data=[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:x];
//            
//            NSString * ntc = [data valueForKey:@"ntc"];
//            
//            NSString * frid1 = [data valueForKey:@"uid"];
//            
//            if([ntc intValue]==16)
//            {
//            
//                NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
//                NSArray * jsonObject=[mang convertojson:data];
//                NSString * brdID = [jsonObject valueForKey:@"podId"];
//                if([brdID intValue]==[podId intValue])
//                    
//                {
//                    
//                    if([frid intValue]==[frid1 intValue])
//                        
//                    {
//                        
//                        NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
//                        
//                        [dic setValue:date forKey:@"time"];
//                        
//                        [dic setValue:ms forKey:@"mes"];
//                        
//                        [[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:x] setValue:dic forKey:@"brdStstus"];
//                        
//                        break;
//                        
//                    }
//                    
//                }
//                
//            }
//            
      //  }
        
        [mynotification reloadData];
        
    }
    
    else if([ntc intValue]==17)
        
    {
        NSString * ms=@"";
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:[NSString stringWithFormat:@"%@",podId] forKey:@"podId"];
        
        [dic setObject:[NSString stringWithFormat:@"%@",sentto] forKey:@"uidFrom"];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        
        [dic setObject:@"1" forKey:@"affectedRows"];
        
         NSArray * jsonObject=[mang convertojson:data];
        
        if([btn.titleLabel.text isEqual:@"Accept"])
        {
            
            [dic setObject:@"1" forKey:@"ar"];
            
            [podAr removeObjectAtIndex:(int)btn.tag];
            NSString *ntctxt;
            if([mang checkContaine:jsonObject])
            {
                NSString *title=[jsonObject valueForKey:@"title"];
                ntctxt=[@"You have accepted podcast Join Request " stringByAppendingString:title];
            }
            else
            {
                ntctxt=@"You have accepted podcast Join Request " ;
            }

            ms=ntctxt;
            titlelabl1.text=ms;
            [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podAR1" :@"" :@"" :dic :self];
            
        }
        
        else if([btn.titleLabel.text isEqual:@"Decline"])
        {
            
            [dic setObject:@"2" forKey:@"ar"];
            
            [podAr removeObjectAtIndex:(int)btn.tag];
            
            NSString *ntctxt=@" You have Rejected podcast Join Request ";
            
            ms= [ntctxt stringByAppendingString:uname];
            
            titlelabl1.text=ms;
            
            [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podAR1" :@"" :@"" :dic :self];
            
        }
        
//        for(int x=0;x<[[SavePrefrences sharedInstance].notiYolkingAr count];x++)
//            
//        {
//            
//            NSArray *data=[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:x];
//            
//            NSString * ntc = [data valueForKey:@"ntc"];
//            
//            NSString * frid1 = [data valueForKey:@"uid"];
//            
//            if([ntc intValue]==17)
//            {
//                
//                NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
//                NSArray * jsonObject=[mang convertojson:data];
//                
//                NSString * brdID = [jsonObject valueForKey:@"podId"];
//                
//                if([brdID intValue]==[podId intValue])
//                 {
//                    if([frid intValue]==[frid1 intValue])
//                    {
//                        NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
//                        [dic setValue:date forKey:@"time"];
//                        [dic setValue:ms forKey:@"mes"];
//                        [[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:x] setValue:dic forKey:@"brdStstus"];
//                        break;
//                        
//                    }
//                    
//                }
//                
//            }
//            
//        }
        
        [mynotification reloadData];
        
    }
    
}

-(void)openUprcntEvent:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    if(chkEvent==10)
    {
        podsid=[[upcomAr objectAtIndex:(int)tg.view.tag]valueForKey:@"po_id"];
        uId=[[upcomAr objectAtIndex:(int)tg.view.tag]valueForKey:@"u_id"];
    }
    if(chkEvent==11)
    {
        podsid=[[rcntAr objectAtIndex:(int)tg.view.tag]valueForKey:@"po_id"];
        uId=[[rcntAr objectAtIndex:(int)tg.view.tag]valueForKey:@"u_id"];
    }
    
    [ppop openUprcntEvent : self:podsid:uId:chkEvent];
    
}
-(void)clearRecentEventview
{
    NSArray *middle1=([podcast_details subviews]);
    
    for(UIView *vm in middle1)
    {
        [vm removeFromSuperview];
        
    }
}
-(void)clearupcomingEventview
{
    NSArray *middle1=([podcast_details subviews]);
    
    for(UIView *vm in middle1)
    {
        [vm removeFromSuperview];
        
    }
}

-(void)Podcast
{
    Podcast_bar.hidden=FALSE;
    
    [ppop setTabBar:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)sortnow:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    [spop sortbypop:self:(int)tg.view.tag];
}
-(IBAction)PodcastIndSearch:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [bpop1 IndustrySearch:self:(int)btn.tag:0];
    
}

-(IBAction)PodcastAdvance:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [ppop PodcastAdvance:self:(int)btn.tag];
}


-(void) callMethod:(NSArray *)meta
{
    NSString * chk=[meta objectAtIndex:0];
    NSLog(@"Valuuuuuuuuuu bac in podcast===%@",meta);
    if([meta count]>1)
    {
        
        NSMutableArray * ar=[meta objectAtIndex:1];
        if([ar count]>0)
        {
            if([chk isEqual:@"industySearch"])
            {
                if(chkEvent==10)
                {
                    upcomAr=ar;
                    [upcomingtableView reloadData];
                }
                else if (chkEvent==11)//recent
                {
                    rcntAr=ar;
                    [recentTableView reloadData];
                }
            }
            if([chk isEqual:@"adSerch"])
            {
                if(chkEvent==10)
                {
                    upcomAr=ar;
                    [upcomingtableView reloadData];
                }
                else if (chkEvent==11)//recent
                {
                    rcntAr=ar;
                    [recentTableView reloadData];
                }
            }
            
            if([chk isEqual:@"usortby"])
            {
                if(chkEvent==10)
                {
                    upcomAr=ar;
                    [upcomingtableView reloadData];
                }
                else if (chkEvent==11)//recent
                {
                    rcntAr=ar;
                    [recentTableView reloadData];
                }
            }
            if([chk isEqual:@"podindustry"])
            {
                
                NSLog(@"sdjskdsd");
                
                id<CallTo_Parent> cb= ppop;
                [cb callMethod:meta];
            }
            
            
            if([chk isEqual:@"libsort"])
            {
                
                NSLog(@"libsort meta====%@",meta);
                
                id<CallTo_Parent> cb=ppop ;
                [cb callMethod:meta];
            }
            
            
            if([chk isEqual:@"podcastsort"])
            {
                id<CallTo_Parent> cb=ppop ;
                [cb callMethod:meta];
                
            }
            
            
            if([chk isEqual:@"podsharedsort"])
            {
                
                id<CallTo_Parent> cb=ppop ;
                [cb callMethod:meta];
                
            }
            
        }
        
        else
        {
            if(iscallback==0||iscallback==1)//upcomming
            {
                NSLog(@"Advance serch upcomming");
                UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alrt show];
                
            }
            else if(iscallback==2||iscallback==2)//recent
            {
                NSLog(@"Advance serch recent");
                UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alrt show];
                //              rcntAr=ar;
                //              [recentTableView reloadData];
            }
            
        }
        
        
    }
    
}


-(void) callBack:(NSArray *)meta:(NSArray *)data
{
    NSLog(@"meta======= %@",meta);
    NSLog(@"data=======%@",data);
    if(iscallback==0)
    {
        upcomAr=data;
        [self upcomingEvent];
    }
    else if (iscallback==1)
    {
        upcomAr=data;
        if([upcomAr count]>0)
        {
            [upcomingtableView reloadData];
        }
        else
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No Results" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
        }
    }
    else if (iscallback==2)
    {
        
        rcntAr=data;
        [self RecentEvent];
    }
    else if (iscallback==3)
    {
        NSLog(@"meta===recent search==== %@",meta);
        NSLog(@"data===recent===search=%@",data);
        rcntAr=data;
        if([rcntAr count]>0)
        {
            [recentTableView reloadData];
            
        }
        else
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No Results" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
        }
        
    }
    else if (iscallback==4)
    {
        //        NSString *s=[data valueForKey:@"s"];
        //        if([s isEqualToString:@"Successfully Accepted."])
        //        {
        //           linelbl.text=@"You accepted Podcast Invitation";
        //
        //        }
        //        else if ([s isEqualToString:@"Successfully Rejected."])
        //        {
        //           linelbl.text=@"You rejected Podcast Invitation";
        //        }
        //        else if([data count]==0)
        //        {
        //            NSLog(@"lkhsdf");
        //        }
    }
    else if(iscallback==5)
    {
        NSLog(@"metya in call5===%@",meta);
        NSLog(@"data in call5===%@",data);
        
        //[ppop readMore:self:data];
        
        
    }
    
    
    
}






@end
