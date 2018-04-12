#import "AddCalendar.h"
#import "SavePrefrences.h"
#import "CalendarPopup.h"
#import "AllValidationsViewController.h"
#import "ManageArray.h"
#import "ManageArray.h"


@interface AddCalendar ()
{
    UITextField *name,*location;
    UIView *headercalendar,*headingView;
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIImageView *image1,*image2,*image3;
    UILabel *Select_Country_Zone,*Select_Zone,*Select_Time_Zone,*iday;
    AllValidationsViewController *av;
    int iscalpub;
  
    NSMutableArray * monthAr,*daysAr;
    UIImageView  *image4;
    UILabel *yeallab,*monthlbl,*datelbl,*weekstlbl;
    UIScrollView  *prfvwscr;
    NSMutableDictionary *weekdayAr;
    int year,month,day,prevDays,ret,daystartfrm,days,nextmonth,firstdate;
    NSArray *EventAr,*dayEventDataAr;
    UIColor * CALCELCOL,*celltextcol,
    *eventcol;
    CalendarPopup *cpop;
    int iscallback,isdayNextOrPrev,prevweek,nextweek,prefmonth,prefyear;;
    NSMutableArray *colorAr;
    NSArray * are,*weekeventAr;
    NSMutableDictionary *datesArray,*showMessageAr,*lineLabAr,*declineAr;;
    NSMutableArray *imgAr,*imgBtnAr,*calAr;
    UILabel *Toplbl,*lblDayName;
    ManageArray *manag;
    
}

@end

@implementation AddCalendar
@synthesize mynotification;

- (void)viewDidLoad
    {
    [super viewDidLoad];
        
       
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    naviWidth = self.navigationController.navigationBar.frame.size.width;
    naviHght =  self.navigationController.navigationBar.frame.size.height;
    stbarHght= (float)[[UIApplication sharedApplication] statusBarFrame].size.height;
  
        /* Toplbl = [[UILabel alloc]initWithFrame:CGRectMake(120,0,200,40)];
    Toplbl.font = [UIFont systemFontOfSize:25];
    Toplbl.numberOfLines = 1;
    Toplbl.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    Toplbl.adjustsFontSizeToFitWidth = YES;
    Toplbl.minimumScaleFactor = 10.0f/12.0f;
    Toplbl.clipsToBounds = YES;
    Toplbl.backgroundColor = [UIColor clearColor];
    Toplbl.textColor = [UIColor whiteColor];
    Toplbl.textAlignment = NSTextAlignmentLeft;
    Toplbl.text = @"ProYolk";*/
    
        UIImageView *logo =[[UIImageView alloc]initWithFrame:CGRectMake(118,0,150,48)];
        logo.image = [UIImage imageNamed:@"logo_new.png"];
        logo.backgroundColor=[UIColor clearColor];

        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:182.0/255 green:182.0/255 blue:182.0/255 alpha:1];
    [self.navigationController.navigationBar addSubview:logo];
    self.navigationController.navigationBar.barTintColor =[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    self.navigationController.navigationBar.backgroundColor =[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
        [self.navigationController setNavigationBarHidden:YES];
        self.view.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
        [self customizeActionBar];
    UIView *navBarLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.frame), CGRectGetWidth(self.navigationController.navigationBar.frame), 1.5)];
    navBarLineView.backgroundColor = [UIColor colorWithRed:126.0f/255 green:184.0f/255 blue:230.0f/255 alpha:1.0f];
    [self.navigationController.navigationBar addSubview:navBarLineView];

        
    headercalendar=[[UIView alloc] initWithFrame:CGRectMake(0, 70,screenWidth , 40)];
        NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
        headercalendar.backgroundColor=[brd valueForKey:@"backcolor"];;
   // headercalendar.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:headercalendar];
        manag=[[ManageArray alloc]init];
    calAr=[[NSMutableArray alloc]init];
    if([[SavePrefrences sharedInstance].allNotifictionDic count]>0)
    {
        calAr=[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"];
    }
    
    for (NSInteger i = (int)calAr.count - 1; i >= 0 ; i--)
    {
        NSString * time=[[calAr valueForKey:@"time"] objectAtIndex:i];
        NSString * ntc= [[calAr valueForKey:@"ntc"] objectAtIndex:i];
        
        if(([ntc intValue]==35)||([ntc intValue]==36)||([ntc intValue]==37)||([ntc intValue]==38))
        {
            if([[[SavePrefrences sharedInstance].notiWithoutADR allKeys] containsObject:time])
            {
                [calAr removeObjectAtIndex:i];
            }
            else
            {
                [[SavePrefrences sharedInstance].notiWithoutADR setValue:time forKey:time];
            }
        }
    }
    
    [SavePrefrences sharedInstance].ischkcal=@"1";
    if([calAr count]>0)
     {
        [self showHeaderforNotification];
     }
    else
     {
        [self showcalendar];
     }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self navigationController]setNavigationBarHidden:YES];
}
-(void)customizeActionBar
{
    drawer = [[LeftRightDrawer alloc]init];
    [drawer initArs:self];
   UIView *main=[[UIView alloc]initWithFrame:CGRectMake(0,70, screenWidth, screenHeight)];
    NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
    main.backgroundColor=[brd valueForKey:@"backcolor"];
    [self.view addSubview:main];
   // [self reteriveFriends];
    //[self ChatList];
}
-(void) reteriveFriends
{
    
    iscallback=3;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"genData":@"":@"":dic1 :self];
    
}


-(void) showHeaderforNotification
   {
    
    float wid= headercalendar.frame.size.width/2;
     UILabel  *notificationlabel=[[UILabel alloc]initWithFrame:CGRectMake(0,-2, wid,headercalendar.frame.size.height)];
     notificationlabel.text=@"Notification";
     notificationlabel.textAlignment=NSTextAlignmentCenter;
     notificationlabel.textColor=[UIColor blackColor];
     notificationlabel.backgroundColor=[UIColor clearColor];;
     [notificationlabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
     [headercalendar addSubview:notificationlabel];
     
     UILabel  *monthcal=[[UILabel alloc]initWithFrame:CGRectMake(wid,-2, wid,headercalendar.frame.size.height)];
      monthcal.text=@"Calendar";
      monthcal.backgroundColor=[UIColor clearColor];
      monthcal.textColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"Boardcolor"];
      monthcal.textAlignment=NSTextAlignmentCenter;
      [monthcal setFont:[UIFont fontWithName:@"Helvetica" size:14]];
      [headercalendar addSubview:monthcal];
     
     
     UITapGestureRecognizer *swcal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showcalendar)];
     [swcal setNumberOfTouchesRequired:1];
     [swcal setDelegate:self];
     monthcal.userInteractionEnabled = YES;
     [monthcal addGestureRecognizer:swcal];
       
       
       mynotification=[[UITableView alloc] initWithFrame:CGRectMake(0, headercalendar.frame.size.height+headercalendar.frame.origin.y-2,headercalendar.frame.size.width,self.view.frame.size.height-(headercalendar.frame.size.height))];
       mynotification.separatorStyle = UITableViewCellSeparatorStyleNone;
       
       mynotification.delegate = self;
       mynotification.dataSource = self;
       mynotification.scrollEnabled = YES;
       mynotification.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"backcolor"];
      // mynotification.separatorColor=[UIColor lightGrayColor];
       [self.view addSubview:mynotification];
       self.view.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"backcolor"];
       
 }

-(void)showcalendar
  {
    [headercalendar removeFromSuperview];
    [mynotification removeFromSuperview];
    
    self.view.backgroundColor=[UIColor whiteColor];
      
    [self showHeaderForMonth];
    CALCELCOL=[UIColor whiteColor];
      
    celltextcol=[UIColor colorWithRed:194.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0f];
   // eventcol=[UIColor colorWithRed:39.0f/255.0f green:59.0f/255.0f blue:73.0f/255.0f alpha:1.0f];
    
    cpop=[[CalendarPopup alloc]init];
    prfvwscr = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 108, [SavePrefrences sharedInstance ].screenWidth-35,[SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70+35))];
    prfvwscr.delegate = self;
    prfvwscr.scrollEnabled = YES;
    prfvwscr.backgroundColor=[UIColor clearColor];
    [self.view addSubview:prfvwscr];
    
    headingView = [[UIView alloc]initWithFrame:CGRectMake(0, headercalendar.frame.size.height+headercalendar.frame.origin.y+35,self.view.frame.size.width,48 )];
    headingView.backgroundColor=[UIColor colorWithRed:83.0/255 green:112.0/255 blue:139.0/255 alpha:1];
    [self.view addSubview:headingView];
    
    colorAr =[[NSMutableArray alloc]init];
    
    [colorAr addObject:[UIColor colorWithRed:164.0/255 green:189.0/255 blue:252.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:70.0/255 green:214.0/255 blue:219.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:122.0/255 green:231.0/255 blue:191.0/255 alpha:1]];
    
    [colorAr addObject:[UIColor colorWithRed:251.0/255 green:215.0/255 blue:91.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:68.0/255 green:173.0/255 blue:57.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:220.0/255 green:135.0/255 blue:132.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:220.0/255 green:33.0/255 blue:39.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:219.0/255 green:173.0/255 blue:255.0/255 alpha:1]];
    
    [self initCalendr];
    [self initCal];
     
 }




-(void)showHeaderForMonth
{
    currentCalViewType = @"month";
    
    headercalendar=[[UIView alloc] initWithFrame:CGRectMake(0, 70,screenWidth , 60)];
    NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
    headercalendar.backgroundColor=[brd valueForKey:@"backcolor"];;
    [self.view addSubview:headercalendar];
    
    
    int widx=headercalendar.frame.size.width/5;
    int one=widx-55;
    int two=widx+50;
    int three=widx+50;
    int four=widx-55;
    int five=widx-45;
    
    
    datelbl=[[UILabel alloc]initWithFrame:CGRectMake(10,15, 50,20)];
    datelbl.text=@"";
    datelbl.textColor = [UIColor colorWithRed:118.0/255 green:188.0/255 blue:244.0/255 alpha:1.0];
    datelbl.textAlignment=NSTextAlignmentLeft;
    
    [datelbl setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [headercalendar addSubview:datelbl];
    
    image1=[[UIImageView alloc]initWithFrame:CGRectMake(datelbl.frame.size.width+datelbl.frame.origin.x+20,15 ,one, 20)];
    image1.backgroundColor=[UIColor clearColor];
    [image1 setImage:[UIImage imageNamed:@"calendar_arrow_left.png"]];
    [headercalendar addSubview:image1];
    
    UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previous1)];
    [prev setNumberOfTouchesRequired:1];
    [prev setDelegate:self];
    image1.userInteractionEnabled = YES;
    [image1 addGestureRecognizer:prev];
    
    
    
    
    
    
    
    
    
    monthlbl=[[UILabel alloc]initWithFrame:CGRectMake(image1.frame.size.width+image1.frame.origin.x+20,10, 100,20)];
    monthlbl.textColor = [UIColor colorWithRed:118.0/255 green:188.0/255 blue:244.0/255 alpha:1.0];
    monthlbl.text=@"January";
    monthlbl.textAlignment=NSTextAlignmentCenter;
    [monthlbl setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [headercalendar addSubview:monthlbl];
    
    yeallab=[[UILabel alloc]initWithFrame:CGRectMake(monthlbl.frame.origin.x+10,25, monthlbl.frame.size.width-20,20)];
    yeallab.textColor = [UIColor colorWithRed:118.0/255 green:188.0/255 blue:244.0/255 alpha:1.0];
    yeallab.text=@"2016";
    yeallab.textAlignment=NSTextAlignmentCenter;
    [yeallab setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [headercalendar addSubview:yeallab];
    
    
    
    image2=[[UIImageView alloc]initWithFrame:CGRectMake(monthlbl.frame.size.width+monthlbl.frame.origin.x+20,15 , image1.frame.size.width, 20)];
    image2.backgroundColor=[UIColor clearColor];
    [image2 setImage:[UIImage imageNamed:@"calendar_arrow_right.png"]];
    [headercalendar addSubview:image2];
    
    UITapGestureRecognizer *next = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(next1)];
    [next setNumberOfTouchesRequired:1];
    [next setDelegate:self];
    image2.userInteractionEnabled = YES;
    [image2 addGestureRecognizer:next];
    
    
    
    UIButton *btnNew=[[UIButton alloc]initWithFrame:CGRectMake(image2.frame.size.width+image2.frame.origin.x+20,10, 30, 30)];
    btnNew.font = [UIFont fontWithName:@"Helvetica" size:14];
    btnNew.backgroundColor=[UIColor clearColor];
    [btnNew setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNew setTitle:@"New" forState:UIControlStateNormal];
    // [image3 setImage:[UIImage imageNamed:@"createblue.png"]];
    [headercalendar addSubview:btnNew];
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewCalender)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    btnNew.userInteractionEnabled = YES;
    [btnNew addGestureRecognizer:sworkingreg];
    
    image4=[[UIImageView alloc]initWithFrame:CGRectMake(btnNew.frame.size.width+btnNew.frame.origin.x+20,10, btnNew.frame.size.width, 30)];
    image4.backgroundColor=[UIColor clearColor];
    [image4 setImage:[UIImage imageNamed:@"calendaricn.png"]];
    [headercalendar addSubview:image4];
    
    UITapGestureRecognizer *viewCalender = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewCal)];
    [viewCalender setNumberOfTouchesRequired:1];
    [viewCalender setDelegate:self];
    image4.userInteractionEnabled = YES;
    [image4 addGestureRecognizer:viewCalender];
    
    
    
    
    
    
    
    }


-(void)showHeaderForDay
{
    currentCalViewType = @"day";
    
    int widx=headercalendar.frame.size.width/6;
    int one=widx-40;
    int onex=widx+10;
    int two=widx+30;
    int three=widx+35;
    int four=widx-40;
    int five=widx-35;
    
    
    datelbl=[[UILabel alloc]initWithFrame:CGRectMake(10,15, 50,20)];
    datelbl.text=@"10";
    datelbl.textColor = [UIColor colorWithRed:118.0/255 green:188.0/255 blue:244.0/255 alpha:1.0];
    datelbl.textAlignment=NSTextAlignmentLeft;
    [datelbl setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [headercalendar addSubview:datelbl];
    
    image1=[[UIImageView alloc]initWithFrame:CGRectMake(datelbl.frame.size.width+datelbl.frame.origin.x+20,15 ,one, 20)];
    image1.backgroundColor=[UIColor clearColor];
    [image1 setImage:[UIImage imageNamed:@"calendar_arrow_left.png"]];
    [headercalendar addSubview:image1];
    
    UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prevDay)];
    [prev setNumberOfTouchesRequired:1];
    [prev setDelegate:self];
    image1.userInteractionEnabled = YES;
    [image1 addGestureRecognizer:prev];
    
    
    
    
    
    
    
    
    
    monthlbl=[[UILabel alloc]initWithFrame:CGRectMake(image1.frame.size.width+image1.frame.origin.x+20,10, 100,20)];
    monthlbl.text=@"January";
    monthlbl.textColor = [UIColor colorWithRed:118.0/255 green:188.0/255 blue:244.0/255 alpha:1.0];
    monthlbl.textAlignment=NSTextAlignmentCenter;
    [monthlbl setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [headercalendar addSubview:monthlbl];
    
    yeallab=[[UILabel alloc]initWithFrame:CGRectMake(monthlbl.frame.origin.x+10,25, monthlbl.frame.size.width-20,20)];
    yeallab.textColor = [UIColor colorWithRed:118.0/255 green:188.0/255 blue:244.0/255 alpha:1.0];
    yeallab.text=@"2016";
    yeallab.textAlignment=NSTextAlignmentCenter;
    [yeallab setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [headercalendar addSubview:yeallab];
    
    
    
    image2=[[UIImageView alloc]initWithFrame:CGRectMake(monthlbl.frame.size.width+monthlbl.frame.origin.x+20,15 , image1.frame.size.width, 20)];
    image2.backgroundColor=[UIColor clearColor];
    [image2 setImage:[UIImage imageNamed:@"calendar_arrow_right.png"]];
    [headercalendar addSubview:image2];
    
    UITapGestureRecognizer *next = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextDay)];
    [next setNumberOfTouchesRequired:1];
    [next setDelegate:self];
    image2.userInteractionEnabled = YES;
    [image2 addGestureRecognizer:next];
    
    
    
   UIButton *btnNew=[[UIButton alloc]initWithFrame:CGRectMake(image2.frame.size.width+image2.frame.origin.x+20,10, 30, 30)];
    btnNew.font = [UIFont fontWithName:@"Helvetica" size:14];
    btnNew.backgroundColor=[UIColor clearColor];
    [btnNew setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNew setTitle:@"New" forState:UIControlStateNormal];
    // [image3 setImage:[UIImage imageNamed:@"createblue.png"]];
    [headercalendar addSubview:btnNew];
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewCalender)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    btnNew.userInteractionEnabled = YES;
    [btnNew addGestureRecognizer:sworkingreg];
    
    image4=[[UIImageView alloc]initWithFrame:CGRectMake(btnNew.frame.size.width+btnNew.frame.origin.x+20,10, btnNew.frame.size.width, 30)];
    image4.backgroundColor=[UIColor clearColor];
    [image4 setImage:[UIImage imageNamed:@"calendaricn.png"]];
    [headercalendar addSubview:image4];
    
    UITapGestureRecognizer *viewCalender = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewCal)];
    [viewCalender setNumberOfTouchesRequired:1];
    [viewCalender setDelegate:self];
    image4.userInteractionEnabled = YES;
    [image4 addGestureRecognizer:viewCalender];
    
    
}

-(void)showHeaderForWeek
{
    currentCalViewType = @"week";
    
    int widx=headercalendar.frame.size.width/6;
    int one=widx-40;
    int onex=widx+10;
    int two=widx+30;
    int three=widx+25;
    int four=widx-40;
    int five=widx-35;
    
    datelbl=[[UILabel alloc]initWithFrame:CGRectMake(10,15, 60,20)];
    datelbl.text=@"10";
    datelbl.textColor = [UIColor colorWithRed:118.0/255 green:188.0/255 blue:244.0/255 alpha:1.0];
    datelbl.textAlignment=NSTextAlignmentLeft;
    [datelbl setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [headercalendar addSubview:datelbl];
    
    image1=[[UIImageView alloc]initWithFrame:CGRectMake(datelbl.frame.size.width+datelbl.frame.origin.x+10,15 ,one, 20)];
    image1.backgroundColor=[UIColor clearColor];
    [image1 setImage:[UIImage imageNamed:@"calendar_arrow_left.png"]];
    [headercalendar addSubview:image1];
    
    UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prevWeek)];
    [prev setNumberOfTouchesRequired:1];
    [prev setDelegate:self];
    image1.userInteractionEnabled = YES;
    [image1 addGestureRecognizer:prev];
    
    
    
    
    
    
    
    
    
    monthlbl=[[UILabel alloc]initWithFrame:CGRectMake(image1.frame.size.width+image1.frame.origin.x+20,10, 100,20)];
    monthlbl.textColor = [UIColor colorWithRed:118.0/255 green:188.0/255 blue:244.0/255 alpha:1.0];
    monthlbl.text=@"January";
    monthlbl.textAlignment=NSTextAlignmentCenter;
    [monthlbl setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [headercalendar addSubview:monthlbl];
    
    yeallab=[[UILabel alloc]initWithFrame:CGRectMake(monthlbl.frame.origin.x+10,25, monthlbl.frame.size.width-20,20)];
    yeallab.textColor = [UIColor colorWithRed:118.0/255 green:188.0/255 blue:244.0/255 alpha:1.0];
    yeallab.text=@"2016";
    yeallab.textAlignment=NSTextAlignmentCenter;
    [yeallab setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [headercalendar addSubview:yeallab];
    
    
    
    image2=[[UIImageView alloc]initWithFrame:CGRectMake(monthlbl.frame.size.width+monthlbl.frame.origin.x+20,15 , image1.frame.size.width, 20)];
    image2.backgroundColor=[UIColor clearColor];
    [image2 setImage:[UIImage imageNamed:@"calendar_arrow_right.png"]];
    [headercalendar addSubview:image2];
    
    UITapGestureRecognizer *next = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextWeek)];
    [next setNumberOfTouchesRequired:1];
    [next setDelegate:self];
    image2.userInteractionEnabled = YES;
    [image2 addGestureRecognizer:next];
    
    
    
    UIButton *btnNew=[[UIButton alloc]initWithFrame:CGRectMake(image2.frame.size.width+image2.frame.origin.x+20,10, 30, 30)];
    btnNew.font = [UIFont fontWithName:@"Helvetica" size:14];
    btnNew.backgroundColor=[UIColor clearColor];
    [btnNew setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNew setTitle:@"New" forState:UIControlStateNormal];
    // [image3 setImage:[UIImage imageNamed:@"createblue.png"]];
    [headercalendar addSubview:btnNew];
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewCalender)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    btnNew.userInteractionEnabled = YES;
    [btnNew addGestureRecognizer:sworkingreg];
    
    image4=[[UIImageView alloc]initWithFrame:CGRectMake(btnNew.frame.size.width+btnNew.frame.origin.x+20,10, btnNew.frame.size.width, 30)];
    image4.backgroundColor=[UIColor clearColor];
    [image4 setImage:[UIImage imageNamed:@"calendaricn.png"]];
    [headercalendar addSubview:image4];
    
    UITapGestureRecognizer *viewCalender = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewCal)];
    [viewCalender setNumberOfTouchesRequired:1];
    [viewCalender setDelegate:self];
    image4.userInteractionEnabled = YES;
    [image4 addGestureRecognizer:viewCalender];
    

    
    
    
    
    
    
    
    
}
-(IBAction)addNewEvent:(id)sender{
    [self addEvent];

}

-(void)ViewCal{
    
    
    
    
    if (tblCalenderView.frame.origin.x  == self.view.frame.size.width) {
        iscallback=101;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"getCalender" :@"":@"":dic1 :self];
        
        
    }
    else{
        [UIView animateWithDuration:0.5
                         animations:^{
                             [tblCalenderView setFrame:CGRectMake(self.view.frame.size.width, prfvwscr.frame.origin.y,self.view.frame.size.width/2,prfvwscr.frame.size.height)];
                             
                         }
                         completion:^(BOOL finished){
                             // [view1.view removeFromSuperview];
                         }];
    
    }
    
   
    
}





-(void) nextDay
{
    isdayNextOrPrev=1;
    NSString * yearval=yeallab.text;
    NSString * dateval=datelbl.text;
    NSString *monthval=monthlbl.text;
    
    int ind=0;
    for(int x=0;x<[monthAr count];x++)
    {
        NSString *monthis=[monthAr objectAtIndex:x];
        if([monthis isEqual:monthval])
        {
            ind=x+1;
            day=[[daysAr objectAtIndex:x]intValue];
            break;
        }
    }
    
    if(ind==2)
    {
        
        if([yearval intValue]%4==0)
        {
            day=29;
        }
        else
        {
            day=28;
        }
    }
    int newdate= [dateval intValue];
    int newdate1=newdate+1;
    
    if(newdate1<=day)
    {
        datelbl.text=[NSString stringWithFormat:@"%d",newdate1];
    }
    else
    {
        if(ind<=11)
        {
            monthlbl.text=[monthAr objectAtIndex:ind];
            datelbl.text=@"1";
        }
        else
        {
            int nyr=[yearval intValue]+1;
            monthlbl.text=@"January";
            datelbl.text=@"1";
            yeallab.text=[NSString stringWithFormat:@"%d",nyr];
        }
    }
    
    
    iscallback=5;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic1 setValue:@"month" forKey:@"k"];
    [dic1 setValue:[NSString stringWithFormat:@"%@",yeallab.text] forKey:@"yr"];
    [dic1 setValue:[NSString stringWithFormat:@"%d",ind] forKey:@"mnt"];
    [dic1 setValue:[NSString stringWithFormat:@"%d",ind] forKey:@"mn"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"MydayEvent" :@"":@"":dic1 :self];
    
}
-(void) prevDay
{
    isdayNextOrPrev=0;
    NSString * yearval=yeallab.text;
    NSString * dateval=datelbl.text;
    NSString *monthval=monthlbl.text;
    
    int ind=0;
    for(int x=0;x<[monthAr count];x++)
    {
        NSString *monthis=[monthAr objectAtIndex:x];
        if([monthis isEqual:monthval])
        {
            ind=x;
            day=[[daysAr objectAtIndex:x]intValue];
            break;
        }
    }
    int newdate= [dateval intValue];
    int newdate1=newdate-1;
    
    if(newdate1>0)
    {
        datelbl.text=[NSString stringWithFormat:@"%d",newdate1];
    }
    else
    {
        if(ind>0)
        {
            
            if(ind==2)
            {
                if([yearval intValue]%4==0)
                {
                    day=29;
                }
                else
                {
                    day=28;
                }
            }
            else
            {
                day=[[daysAr objectAtIndex:ind-1] intValue];
                
            }
            
            datelbl.text=[NSString stringWithFormat:@"%d",day];
            monthlbl.text=[monthAr objectAtIndex:ind-1];
            
        }
        else
        {
            
            datelbl.text=@"31";
            monthlbl.text=@"December";
            int neyr= [yearval intValue]-1;
            yeallab.text=[NSString stringWithFormat:@"%d",neyr];
            
            
        }
        
        
    }
    
    
    
    iscallback=5;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic1 setValue:@"month" forKey:@"k"];
    [dic1 setValue:[NSString stringWithFormat:@"%@",yeallab.text] forKey:@"yr"];
    [dic1 setValue:[NSString stringWithFormat:@"%d",ind+1] forKey:@"mnt"];
    [dic1 setValue:[NSString stringWithFormat:@"%d",ind+1] forKey:@"mn"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"MydayEvent" :@"":@"":dic1 :self];
    
}






-(void) ViewCalender
{
    
    
//    AddCalend *containerView = [[[NSBundle mainBundle] loadNibNamed:@"AddCalend" owner:self options:nil] lastObject];
//    //  containerView.strFlag = @"0";
//    CGRect frame = containerView.frame;
//    frame.size.width = self.view.frame.size.width-40;
//    //frame.size.height = self.view.frame.size.height - 150;
//    containerView.frame = frame;
//    containerView.layer.cornerRadius = 5.0;
//    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
//    leftView.backgroundColor = [UIColor clearColor];
    //containerView.delegationListener = self;
    
    //    containerView.txtEmail.leftView = leftView;
    //
    //    containerView.txtEmail.leftViewMode = UITextFieldViewModeAlways;
    //    containerView.txtEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //
    //    UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    //    leftView1.backgroundColor = [UIColor clearColor];
    //    containerView.txtName.leftView = leftView1;
    //
    //    containerView.txtName.leftViewMode = UITextFieldViewModeAlways;
    //    containerView.txtName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //
    //
    //    UILabel * leftView3= [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    //    leftView3.backgroundColor = [UIColor clearColor];
    //    containerView.txtPriority.leftView = leftView3;
    //
    //    containerView.txtPriority.leftViewMode = UITextFieldViewModeAlways;
    //    containerView.txtPriority.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    
    
    //    UILabel * leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    //    leftView2.backgroundColor = [UIColor clearColor];
    //
    //
    //    containerView.txtTitle.leftView = leftView2;
    //
    //    containerView.txtTitle.leftViewMode = UITextFieldViewModeAlways;
    //    containerView.txtTitle.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[rootView addSubview:containerView];
//    containerView.center = self.view.center;
//    [self.view addSubview:containerView];
//    [self.view bringSubviewToFront:containerView];
    
    
  //  iscallback=3;
    
    [cpop addCalendar:self];
}



-(void) initCalendr
{
    
    monthAr=[[NSMutableArray alloc]init];
    [monthAr addObject:@"January"];
    [monthAr addObject:@"February"];
    [monthAr addObject:@"March"];
    [monthAr addObject:@"April"];
    [monthAr addObject:@"May"];
    [monthAr addObject:@"June"];
    [monthAr addObject:@"July"];
    [monthAr addObject:@"August"];
    [monthAr addObject:@"September"];
    [monthAr addObject:@"October"];
    [monthAr addObject:@"November"];
    [monthAr addObject:@"December"];
    
    
    daysAr =[[NSMutableArray alloc]init];
    [daysAr addObject:@"31"];
    [daysAr addObject:@"28"];
    [daysAr addObject:@"31"];
    [daysAr addObject:@"30"];
    [daysAr addObject:@"31"];
    [daysAr addObject:@"30"];
    [daysAr addObject:@"31"];
    [daysAr addObject:@"31"];
    [daysAr addObject:@"30"];
    [daysAr addObject:@"31"];
    [daysAr addObject:@"30"];
    [daysAr addObject:@"31"];
    
    weekdayAr=[[NSMutableDictionary alloc]init];
    [weekdayAr setValue:@"Sat-Mon" forKey:@"Sun"];
    [weekdayAr setValue:@"Sun-Tues" forKey:@"Mon"];
    [weekdayAr setValue:@"Mon-Wed" forKey:@"Tues"];
    [weekdayAr setValue:@"Tues-Thu" forKey:@"Wed"];
    [weekdayAr setValue:@"Wed-Fri" forKey:@"Thu"];
    [weekdayAr setValue:@"Thu-Sat" forKey:@"Fri"];
    [weekdayAr setValue:@"Fri-Sun" forKey:@"Sat"];
    
    
    imgAr=[[NSMutableArray alloc]init];
    [imgAr addObject:@"Month"];
    [imgAr addObject:@"Week"];
    [imgAr addObject:@"Day"];
    imgBtnAr=[[NSMutableArray alloc]init];
    
    int lx=130;
    int ly= 125 ;
    
    
    for(int i=0;i<[imgAr count] ;i++)
    {
      
//        UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(ly*i,lx-2,ly,38)];
        UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(ly*i,lx-2,ly,38)];
        
        
        [btn setTitle:[imgAr objectAtIndex:i] forState:UIControlStateNormal];
    //    img1.backgroundColor=[UIColor whiteColor];
        btn.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [imgBtnAr addObject:btn];
        btn.tag=i;
        [self.view addSubview: btn];
        
        if (i==0) {
        [btn setBackgroundColor:[UIColor colorWithRed:0/255 green:35.0/255 blue:80.0/255 alpha:1.0]];
        }
        else{
        [btn setBackgroundColor:[UIColor colorWithRed:110.0/255 green:184.0/255 blue:244.0/255 alpha:1.0]];
        }
        
     //
        
        if (i==0) {
            [btn setSelected:YES];
        }
        
        UITapGestureRecognizer *selreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selcaltype:)];
        [selreg setNumberOfTouchesRequired:1];
        [selreg setDelegate:self];
        btn.tag=i;
        btn.userInteractionEnabled = YES;
        [btn addGestureRecognizer:selreg];
        ly=125;
    }
    
    
}




-(void) showCalendar:(int) str
 {
    int hx=10;
    [prfvwscr removeFromSuperview];
     [tblCalenderView removeFromSuperview];

    prfvwscr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headercalendar.frame.size.height+headercalendar.frame.origin.y+78, [SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70+40+38))];
    prfvwscr.delegate = self;
    prfvwscr.scrollEnabled = YES;
    [self.view addSubview:prfvwscr];
     tblCalenderView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width,prfvwscr.frame.origin.y,self.view.frame.size.width/2,prfvwscr.frame.size.height) style:UITableViewStylePlain];
     NSMutableDictionary *bd=[SavePrefrences sharedInstance].colorDictionry;
     tblCalenderView.backgroundColor=[bd valueForKey:@"backcolor"];
     
     [self.view addSubview:tblCalenderView];
     [self.view bringSubviewToFront:tblCalenderView];
     int col1;
     if (str==2) {
            col1= (self.view.frame.size.width-40)/7 ;
     }
     else{
            col1= (self.view.frame.size.width)/7 ;
     }
    
    
    NSMutableArray *week_lbl=[[NSMutableArray alloc]init];
    [week_lbl addObject:@"S"];
    [week_lbl addObject:@"M"];
    [week_lbl addObject:@"T"];
    [week_lbl addObject:@"W"];
    [week_lbl addObject:@"Th"];
    [week_lbl addObject:@"F"];
    [week_lbl addObject:@"S"];
     hx = 0;
    for(int x=0;x<7;x++)
    {
        UILabel *heading=[[UILabel alloc]initWithFrame:CGRectMake(hx,0, col1,44)];
        heading.text=[week_lbl objectAtIndex:x];
        heading.textAlignment=NSTextAlignmentCenter;
        if(str==2)
        {
            
        heading.textAlignment=NSTextAlignmentCenter;
        }
        
        heading.backgroundColor=[UIColor colorWithRed:212.0/255 green:222.0/255 blue:230.0/255 alpha:1];
        heading.textColor=[UIColor colorWithRed:144.0/255 green:145.0/255 blue:146.0/255 alpha:1];
        [heading setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [headingView addSubview:heading];
        headingView.backgroundColor = [UIColor colorWithRed:212.0/255 green:222.0/255 blue:230.0/255 alpha:1];
        hx=hx+col1;
        
    }
}

-(void)selcaltype:(id)sender
{
    UITapGestureRecognizer * tg=(UITapGestureRecognizer * )sender;
    int i=(int)tg.view.tag;
    
    
    for(int x=0;x<[imgBtnAr count];x++)
    {
        UIButton *btn = [imgBtnAr objectAtIndex:x];
        
        
            [btn setBackgroundColor:[UIColor colorWithRed:110.0/255 green:184.0/255 blue:244.0/255 alpha:1.0]];
        
    }
    
    
    
    
    if (i==0)
    {
        [[imgBtnAr objectAtIndex:0] setBackgroundColor:[UIColor colorWithRed:0/255 green:35.0/255 blue:80.0/255 alpha:1.0]];
        
        [prfvwscr removeFromSuperview];
        [self clearHeaderview];
        [self showHeaderForMonth];
        [self showCalendar:1];
        [self initCal];
        
        
    }
    else if(i==1)
    {
         [[imgBtnAr objectAtIndex:1] setBackgroundColor:[UIColor colorWithRed:0/255 green:35.0/255 blue:80.0/255 alpha:1.0]];
        
        [self showWeekCal];
        
    }
    else if(i==2)
    {
        [[imgBtnAr objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0/255 green:35.0/255 blue:80.0/255 alpha:1.0]];
        iscallback=4;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setValue:@"month" forKey:@"k"];
        [dic1 setValue:[NSString stringWithFormat:@"%d",year] forKey:@"yr"];
        [dic1 setValue:[NSString stringWithFormat:@"%d",month] forKey:@"mnt"];
        [dic1 setValue:[NSString stringWithFormat:@"%d",month] forKey:@"mn"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"MydayEvent" :@"":@"":dic1 :self];
    }
    
}


-(void)showWeekCall1
{
    NSArray *viewsToRemove = [headingView subviews];
    for (UIView *v in viewsToRemove)
    {
        [v removeFromSuperview];
    }
    
    [self showCalendar:2];
    NSMutableArray *ar=[NSMutableArray arrayWithObjects:@"1 AM",@"2 AM",@"3 AM",@"4 AM",@"5 AM",@"6 AM",@"7 AM",@"8 AM",@"9 AM",@"10 AM",@"11 AM",@"12 AM",@"1 PM",@"2 PM",@"3 PM",@"4 PM",@"5 PM",@"6 PM",@"7 PM",@"8 PM",@"9 PM",@"10 PM",@"11 PM",@"12 PM",nil];
    int col=0;
    
    int wid=prfvwscr.frame.size.width/7;
    for(int i=0;i<[ar count];i++)
    {
        // NSString * dateis= [[datesArray o:i] valueForKey:[keysAr objectAtIndex:i]];
        
        UILabel *columns=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-85, col+1, 85, 30)];
        columns.textAlignment = NSTextAlignmentCenter;
        columns.text=[ar objectAtIndex:i];
        columns.textColor=[UIColor colorWithRed:148.0/255 green:148.0/255 blue:149.0/255 alpha:1.0];
        [columns setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        columns.backgroundColor=[UIColor whiteColor];
        
        [prfvwscr addSubview:columns];
        
        
        int rows=columns.frame.size.width+columns.frame.origin.x;
        for(int j=1;j<=7;j++)
        {
            
            UILabel *textfield_lbl=[[UILabel alloc]initWithFrame: CGRectMake(0,col+1,self.view.frame.size.width-85, 30)];
            textfield_lbl.backgroundColor=[UIColor whiteColor];
//            textfield_lbl.layer.borderColor=[[UIColor grayColor]CGColor];
//            textfield_lbl.layer.borderWidth=.5f;
            [prfvwscr addSubview:textfield_lbl];
            rows=rows+((prfvwscr.frame.size.width-columns.frame.size.width)/7);
            NSString *datval=[datesArray valueForKey:[NSString stringWithFormat:@"%d",j-1]];
            
            NSArray * daAr=[datval componentsSeparatedByString:@"-"];
            
            UITapGestureRecognizer *prev1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewEvent:)];
            [prev1 setNumberOfTouchesRequired:1];
            [prev1 setDelegate:self];
            textfield_lbl.userInteractionEnabled = YES;
            [textfield_lbl addGestureRecognizer:prev1];
            textfield_lbl.tag=[[daAr objectAtIndex:0] intValue];
            textfield_lbl.backgroundColor = [UIColor whiteColor];
            int caltime= i+1;
            int cut=0;
            
            
            for(int c=0;c<[datesArray count];c++)
            {
                
                NSString * datis=[datesArray valueForKey:[NSString stringWithFormat:@"%d",c]];
                //[datesArray valueForKey:[keysAr objectAtIndex:j-1]];
                NSArray * ar =[datis componentsSeparatedByString:@"-"];
                NSString * finaldate=@"";
                
                if([ar count]>2)
                {
                    
                    NSString *yr= [NSString stringWithFormat:@"%@", [ar objectAtIndex:2]] ;
                    NSString *mon=[NSString stringWithFormat:@"/%@",[ar objectAtIndex:1]];
                    NSString * da=[NSString stringWithFormat:@"/%@",[ar objectAtIndex:0]];
                    finaldate=[[yr stringByAppendingString:mon] stringByAppendingString:da];
                    
                    NSArray * evnt=[weekeventAr valueForKey:finaldate];
                    NSString *event_name;
                    
                    //NSLog(@"datee is======%@",finaldate);
                    //NSLog(@"event name===%@",evnt);
                    
                    
                    for(int x=0;x<[evnt count];x++)
                    {
                        if([evnt count]>0)
                        {
                            
                            NSString *color=    [[evnt valueForKey:@"color"] objectAtIndex:x];
                            NSString *event_id= [[evnt valueForKey:@"event_id"] objectAtIndex:x];
                            event_name = [[evnt valueForKey:@"event_name"] objectAtIndex:x];
                            NSString *time= [[evnt valueForKey:@"time"] objectAtIndex:x];
                            
                            NSArray * tt;
                            if(![time isEqual:[NSNull null]])
                                tt=  [time componentsSeparatedByString:@":"];
                            
                            
                            if([tt count]>=1)
                            {
                                for(int c=0;c<[tt count];c++)
                                {
                                    cut= [[tt objectAtIndex:0] intValue];
                                    if(cut==caltime)
                                    {
                                        
                                        
                                        NSLog(@"preweek tag=====%d",(int)textfield_lbl.tag);
                                        NSLog(@"preweek tag=====%@",[ar objectAtIndex:0] );
                                        if((int)textfield_lbl.tag==[[ar objectAtIndex:0] intValue])
                                        {
                                            
                                            textfield_lbl.text=event_name;
                                            textfield_lbl.textAlignment=NSTextAlignmentCenter;
                                            textfield_lbl.font=[UIFont systemFontOfSize:5];
                                            //textfield_lbl.backgroundColor=[UIColor redColor];
                                            
                                            textfield_lbl.tag=j-1;
                                            
                                            UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showweekEvent:)];
                                            [prev setNumberOfTouchesRequired:1];
                                            [prev setDelegate:self];
                                            textfield_lbl.userInteractionEnabled = YES;
                                            [textfield_lbl addGestureRecognizer:prev];
                                            NSString * color=[[evnt valueForKey:@"color"] objectAtIndex:x];
                                            
                                            textfield_lbl.textColor = [UIColor whiteColor];
                                            if([color intValue]==1)
                                                textfield_lbl.backgroundColor=[colorAr objectAtIndex:0];
                                            
                                            else if([color intValue]==2)
                                                textfield_lbl.backgroundColor=[colorAr objectAtIndex:1];
                                            
                                            else if([color intValue]==3)
                                                textfield_lbl.backgroundColor=[colorAr objectAtIndex:2];
                                            
                                            else if([color intValue]==4)
                                                textfield_lbl.backgroundColor=[colorAr objectAtIndex:3];
                                            else if([color intValue]==5)
                                                textfield_lbl.backgroundColor=[colorAr objectAtIndex:4];
                                            
                                            else if([color intValue]==6)
                                                textfield_lbl.backgroundColor=[colorAr objectAtIndex:5];
                                            
                                            else if([color intValue]==7)
                                                textfield_lbl.backgroundColor=[colorAr objectAtIndex:6];
                                            
                                            else if([color intValue]==8)
                                                textfield_lbl.backgroundColor=[colorAr objectAtIndex:7];
                                            else if([color intValue]==9)
                                                textfield_lbl.backgroundColor=[colorAr objectAtIndex:8];
                                            
                                            break;
                                        }
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        
        
        
        
        
        col=col+31;
        prfvwscr.contentSize=CGSizeMake(prfvwscr.frame.size.width, col);
        
    }
    
    
    
    
}

-(void)showweekEvent:(id)sender
{
    UITapGestureRecognizer * tg=(UITapGestureRecognizer *)sender;
    int t=(int) tg.view.tag;
    
    NSString *datis= [datesArray valueForKey:[NSString stringWithFormat:@"%d",t]];
    
    
    NSArray * ar =[datis componentsSeparatedByString:@"-"];
    NSString * finaldate=@"";
    
    if([ar count]>2)
    {
        
        NSString *yr= [NSString stringWithFormat:@"%@", [ar objectAtIndex:2]] ;
        NSString *mon=[NSString stringWithFormat:@"/%@",[ar objectAtIndex:1]];
        NSString * da=[NSString stringWithFormat:@"/%@",[ar objectAtIndex:0]];
        finaldate=[[yr stringByAppendingString:mon] stringByAppendingString:da];
        
    }
    
    NSArray * wA=  [weekeventAr valueForKey:finaldate];
    
    
    [cpop ViewweekEventList:self :wA];
    
    
    
}


-(void)showWeekCal
{
    [self clearHeaderview];
    [self showHeaderForWeek];
    
    
    [self getCurrentWeek];
    
    
    [self rtWeekcalcuevent];
    
    
}


-(void)rtWeekcalcuevent
  {
    
    int mon=0;
    for(int x=0;x<[monthAr count];x++)
    {
        
        
        if([monthlbl.text isEqual:[monthAr objectAtIndex:x]])
        {
            mon= x;
            break;
        }
    }
    
    int day= [[daysAr objectAtIndex:mon]intValue];
    
    NSLog(@"month=====%d",mon);
    
    if(mon==1)//feb
    {
        if([yeallab.text intValue]%4==0)
        {
            day=29;
        }
        else
        {
            day=28;
        }
    }
    
    datesArray=[[NSMutableDictionary alloc]init];
    if(prevweek>nextweek)
    {
        NSLog(@"hererrere222");
        NSLog(@"month============%d",mon);
        if(mon<11)
        {
            if(mon==0)
            {
                
                day=  [[daysAr objectAtIndex:mon] intValue];
                int inc=0;
                for(int x=prevweek;x<=day;x++)
                {
                    NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",12] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]-1]]];
                    [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                    inc=inc+1;
                    
                }
                
                for(int x=1;x<=nextweek;x++)
                {
                    
                    NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                    [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                    inc=inc+1;
                }
                
                
            }
            
            else
            {
                day=  [[daysAr objectAtIndex:mon-1] intValue];
                int inc=0;
                
                for(int x=prevweek;x<=day;x++)
                {
                    NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                    [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                    inc=inc+1;
                    
                }
                for(int x=1;x<=nextweek;x++)
                {
                    
                    NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                    [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                    inc=inc+1;
                }
            }
        }
        else
          {
            
            NSLog(@"before   %d",mon);
            day=[[daysAr objectAtIndex:11]intValue];
            NSLog(@"after   %d",day);
            int inc=0;
            for(int x=prevweek;x<=day;x++)
            {
             NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon] stringByAppendingString:[NSString stringWithFormat:@"-%@",yeallab.text]]];
                [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                inc=inc+1;
            }
            
            
            for(int x=1;x<=nextweek;x++)
            {
                NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                inc=inc+1;
            }
        }
    }
    else
    {
        int inc=0;
        NSLog(@"hererrere");
        for(int x=prevweek;x<=nextweek;x++)
        {
            NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%@",yeallab.text]]];
            [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
            inc=inc+1;
        }
    }
    
    iscallback=6;
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:@"week" forKey:@"k"];
    [dic setValue:[NSString stringWithFormat:@"%d",mon+1]forKey:@"month"];
      
    [dic setValue:[NSString stringWithFormat:@"%@",strCalenderName]forKey:@"calNames"];
    [dic setValue:[NSString stringWithFormat:@"%@",yeallab.text]forKey:@"year"];
    [dic setValue:datesArray forKey:@"mn"];
    iscallback=6;
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"MyWeekEvent" :@"" :@"" :dic :self];
    
    
}


-(NSString *) getCurrentWeek
{
    [self clearHeaderview];
    [self showHeaderForWeek];
    
    NSArray * ff=[self currentDayName:0];
    NSString *cuday=ff[0];
    NSString *cudateAR=ff[1];
    NSString *cuyear=ff[2];
    
    NSArray *yearAr=[cuyear componentsSeparatedByString:@" "];
    NSString *cuyearAR=yearAr[1];
    
    NSArray * dateAr= [cudateAR componentsSeparatedByString:@" "];
    NSString *cudate=dateAr[2];
    
    NSString *cumonth=dateAr[1];
    
    int cudateint= [cudate intValue];
    int weekEnddate=0,nextdate=0;
    if([cuday isEqual:@"Sunday"])
    {
        weekEnddate=0;
        nextdate=6;
    }
    else  if([cuday isEqual:@"Monday"])
    {
        weekEnddate=1;
        nextdate=5;
    }
    else  if([cuday isEqual:@"Tuesday"])
    {
        weekEnddate=2;
        nextdate=4;
    }
    
    else  if([cuday isEqual:@"Wednesday"])
    {
        weekEnddate=3;
        nextdate=3;
    }
    
    else  if([cuday isEqual:@"Thursday"])
    {
        weekEnddate=4;
        nextdate=2;
    }
    
    else  if([cuday isEqual:@"Friday"])
    {
        weekEnddate=5;
        nextdate=1;
    }
    
    else  if([cuday isEqual:@"Saturday"])
    {
        weekEnddate=6;
        nextdate=0;
    }
    
    prevweek=cudateint-weekEnddate;
    nextweek=cudateint+nextdate;
    
    //    NSLog(@"prevweek====%d",prevweek);
    //    NSLog(@"nextweek====%d",nextweek);
    
    NSString *finalweek=[[NSString stringWithFormat:@"%d-",prevweek]
                         stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
    
    NSLog(@"finalweek====%@",finalweek);
    
    datelbl.text=finalweek;
    monthlbl.text=cumonth;
    yeallab.text=cuyearAR;
    return nil;
}


-(void)nextWeek
{
    
    prevweek=prevweek+7;
    nextweek =nextweek+7;
    
    NSString *cumonth= monthlbl.text;
    int year2=[yeallab.text intValue];
    
    int ind=0;
    for(int x=0;x<[monthAr count];x++)
    {
        if([cumonth isEqual:[monthAr objectAtIndex:x]])
        {
            ind=x+1;
            break;
        }
    }
    
    if(ind==2)
    {
        if(year2%4==0)
        {
            day=29;
        }else
        {
            day=28;
        }
    }
    else{
        day=[[daysAr objectAtIndex:ind-1]intValue ];
    }
    if(nextweek>day && prevweek<=day)
    {
        if(ind<12)
        {
            
            if(ind==2)
            {
                if(year2%4==0)
                {
                    day=29;
                }
                else
                {
                    day=28;
                }
            }
            nextweek=nextweek-day;
            NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
            datelbl.text=nextweek1;
            monthlbl.text=[monthAr objectAtIndex:ind];
            
        }
        else
        {
            nextweek=nextweek-day;
            NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
            datelbl.text=nextweek1;
            monthlbl.text=@"January";
            yeallab.text=[NSString stringWithFormat:@"%d",[yeallab.text intValue]+1];
        }
        
    }
    else if(prevweek>day && nextweek<day)
    {
        if(ind>1)
        {
            int day=[[daysAr objectAtIndex:ind-2]intValue];
            if(ind==3)
            {
                if(year2%4==0)
                {
                    day=29;
                }
                else{
                    day=28;
                }
            }
            
            prevweek=prevweek-day;
            NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
            datelbl.text=nextweek1;
        }
        else
        {
            int day=[[daysAr objectAtIndex:11]intValue];
            prevweek=prevweek-day;
            NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
            datelbl.text=nextweek1;
        }
    }
    
    else if(nextweek>day && prevweek>day)
    {
        if(ind<=11)
        {
            int day1=[[daysAr objectAtIndex:ind-1]intValue];
            
            if(ind==2)
            {
                if(year2%4==0)
                {
                    day1=29;
                }
                else{
                    day1=28;
                }
            }
            prevweek=prevweek-day1;
            nextweek=nextweek-day1;
            NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
            datelbl.text=nextweek1;
            monthlbl.text=[monthAr objectAtIndex:ind];
        }
        else
        {
            int day1=[[daysAr objectAtIndex:ind-1]intValue];
            prevweek=prevweek-day1;
            nextweek=nextweek-day;
            NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
            datelbl.text=nextweek1;
            monthlbl.text=@"January";
            yeallab.text=[NSString stringWithFormat:@"%d",[yeallab.text intValue]+1];
            
        }
    }
    else
    {
        
        
        NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
        datelbl.text=nextweek1;
        
    }
    
    
    int mon=0;
    for(int x=0;x<[monthAr count];x++)
    {
        
        
        if([monthlbl.text isEqual:[monthAr objectAtIndex:x]])
        {
            mon= x;
            break;
        }
    }
    
    int day= [[daysAr objectAtIndex:mon]intValue];
    
    NSLog(@"month=====%d",mon);
    
    if(mon==1)//feb
    {
        if([yeallab.text intValue]%4==0)
        {
            day=29;
        }
        else
        {
            day=28;
        }
    }
    
    datesArray=[[NSMutableDictionary alloc]init];
    if(prevweek>nextweek)
    {
        NSLog(@"hererrere222");
        NSLog(@"month============%d",mon);
        if(mon<11)
        {
            if(mon==0)
            {
                
                day=  [[daysAr objectAtIndex:mon] intValue];
                int inc=0;
                for(int x=prevweek;x<=day;x++)
                {
                    NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",12] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]-1]]];
                    [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                    inc=inc+1;
                    
                }
                
                for(int x=1;x<=nextweek;x++)
                {
                    
                    NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                    [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                    inc=inc+1;
                }
                
                
            }
            
            else
            {
                day=  [[daysAr objectAtIndex:mon-1] intValue];
                int inc=0;
                
                for(int x=prevweek;x<=day;x++)
                {
                    NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                    [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                    inc=inc+1;
                    
                }
                for(int x=1;x<=nextweek;x++)
                {
                    
                    NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                    [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                    inc=inc+1;
                }
            }
        }
        
        
        else
        {
            
            NSLog(@"before   %d",mon);
            day=[[daysAr objectAtIndex:11]intValue];
            NSLog(@"after   %d",day);
            int inc=0;
            for(int x=prevweek;x<=day;x++)
            {
                NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon] stringByAppendingString:[NSString stringWithFormat:@"-%@",yeallab.text]]];
                [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                inc=inc+1;
            }
            
            
            for(int x=1;x<=nextweek;x++)
            {
                NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                inc=inc+1;
            }
        }
    }
    else
    {
        int inc=0;
        NSLog(@"hererrere");
        for(int x=prevweek;x<=nextweek;x++)
        {
            NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%@",yeallab.text]]];
            [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
            inc=inc+1;
        }
    }
    
    
    NSMutableDictionary * dic=
    [[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:@"week" forKey:@"k"];
    [dic setValue:[NSString stringWithFormat:@"%d",mon+1]forKey:@"month"];
    
    [dic setValue:[NSString stringWithFormat:@"%@",yeallab.text]forKey:@"year"];
    [dic setValue:datesArray forKey:@"mn"];
    iscallback=6;
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"MyWeekEvent" :@"" :@"" :dic :self];
    
    
    
    
}






-(void)prevWeek
{
    // Double - - shown in week date.
    
    prevweek=prevweek-7;
    nextweek =nextweek-7;
    
    NSString *cumonth= monthlbl.text;
    int year2=[yeallab.text intValue];
    
    int ind=0;
    for(int x=0;x<[monthAr count];x++)
    {
        if([cumonth isEqual:[monthAr objectAtIndex:x]])
        {
            ind=x;
            break;
        }
    }
    NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
    datelbl.text=nextweek1;
    
    
    if(prevweek<1)
    {
        if(ind>0)
        {
            day=[[daysAr objectAtIndex:ind-1] intValue];
            if(ind==2)
            {
                if(year2%4==0)
                {
                    day=29;
                }
                else
                {
                    day=28;
                }
            }
            prevweek=day+prevweek;
            NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
            datelbl.text=nextweek1;
        }
        
        else{
            day=[[daysAr objectAtIndex:11] intValue];
            prevweek=day+prevweek;
            NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
            datelbl.text=nextweek1;
        }
    }
    
    if(nextweek<1)
    {
        nextweek=prevweek+6;
        NSString *nextweek1 =[[NSString stringWithFormat:@"%d-",prevweek] stringByAppendingString:[NSString stringWithFormat:@"%d",nextweek]];
        weekstlbl.text=nextweek1;
        if(ind>0)
        {
            monthlbl.text=[monthAr objectAtIndex:ind-1];
        }
        else{
            monthlbl.text=@"December";
            yeallab.text=[NSString stringWithFormat:@"%d",[yeallab.text intValue]-1];
            
        }
        
    }
    
    NSLog(@"date is========%@",yeallab.text);
    NSLog(@"dadate label =====%@",datelbl.text);
    NSLog(@"month label =====%@",monthlbl.text);
    NSLog(@" =next week====%d",nextweek);
    NSLog(@" preev week====%d",prevweek);
    
    
    int mon=0;
    for(int x=0;x<[monthAr count];x++)
    {
        
        
        if([monthlbl.text isEqual:[monthAr objectAtIndex:x]])
        {
            mon= x;
            break;
        }
    }
    
    int day= [[daysAr objectAtIndex:mon]intValue];
    datesArray=[[NSMutableDictionary alloc]init];
    if(prevweek>nextweek)
      {
        NSLog(@"inside month====%d",mon);
        
        if(mon==0)
          {
            
            int prevday=[[daysAr objectAtIndex:11] intValue];
            
            int cuday=[[daysAr objectAtIndex:mon] intValue];
            
            NSLog(@"days of months======%d",prevday);
            NSLog(@"days of months======%d",cuday);
            int inc=0;
            for(int x=prevweek;x<=prevday;x++)
            {
                NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",12] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]-1]]];
                [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                inc=inc+1;
                //[datesArray addObject:finalDate];
                
            }
            
            for(int x=1;x<=nextweek;x++)
            {
                NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                inc=inc+1;
                
            }
            
            NSLog(@"inside zero==%@",datesArray);
          }
        else
        {
            
            NSLog(@"with in all momnth %d",mon);
            
            int prevday=[[daysAr objectAtIndex:mon-1] intValue];
            
            if((mon-1)==1)
            {
                if([yeallab.text intValue]%4==0)
                {
                    prevday=29;
                }
                else
                {
                    prevday=28;
                }
                NSLog(@"days of months======%d",prevday);
                
            }
            
            int inc=0;
            for(int x=prevweek;x<=prevday;x++)
            {
                NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                inc=inc+1;
            }
            
            for(int x=1;x<=nextweek;x++)
            {
                NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
                [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
                inc=inc+1;
                
            }
            
            NSLog(@"array of dates=====%@",datesArray);
            
        }
        
    }
    else
    {
        
        NSLog(@"With in mobnth===%d",day);
        
        
        
        
        int inc=0;
        for(int x=prevweek;x<=nextweek;x++)
        {
            NSString *finalDate=[[NSString stringWithFormat:@"%d",x] stringByAppendingString:[[NSString stringWithFormat:@"-%d",mon+1] stringByAppendingString:[NSString stringWithFormat:@"-%d",[yeallab.text intValue]]]];
            [datesArray setValue:finalDate forKey:[NSString stringWithFormat:@"%d",inc]];
            inc=inc+1;
            
        }
        NSLog(@"dates within all==%@",datesArray);
        
    }
    
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:@"week" forKey:@"k"];
    [dic setValue:[NSString stringWithFormat:@"%d",mon+1]forKey:@"month"];
    [dic setValue:[NSString stringWithFormat:@"%@",yeallab.text]forKey:@"year"];
    [dic setValue:datesArray forKey:@"mn"];
    
    
    
    iscallback=6;
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"MyWeekEvent" :@"" :@"" :dic :self];
    
    
}


-(void)clearHeaderview
{
    NSArray *header = [headercalendar subviews];
    for (UIView *v in header)
    {
        [v removeFromSuperview];
    }
}




-(void) showdayEventViews
   {
    [prfvwscr removeFromSuperview];
       [tblCalenderView removeFromSuperview];
     prfvwscr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headercalendar.frame.size.height+headercalendar.frame.origin.y+78, [SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70+35))];
    prfvwscr.delegate = self;
    prfvwscr.scrollEnabled = YES;
    prfvwscr.backgroundColor=[UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    [self.view addSubview:prfvwscr];
       tblCalenderView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width,prfvwscr.frame.origin.y,self.view.frame.size.width/2,prfvwscr.frame.size.height) style:UITableViewStylePlain];
       NSMutableDictionary *bd=[SavePrefrences sharedInstance].colorDictionry;
       tblCalenderView.backgroundColor=[bd valueForKey:@"backcolor"];
       [self.view addSubview:tblCalenderView];
       [self.view bringSubviewToFront:tblCalenderView];
     NSMutableArray *ar=[NSMutableArray arrayWithObjects:@"1 AM",@"2 AM",@"3 AM",@"4 AM",@"5 AM",@"6 AM",@"7 AM",@"8 AM",@"9 AM",@"10 AM",@"11 AM",@"12 AM",@"1 PM",@"2 PM",@"3 PM",@"4 PM",@"5 PM",@"6 PM",@"7 PM",@"8 PM",@"9 PM",@"10 PM",@"11 PM",@"12 PM",nil];
    int col=0;
    
    for(int i=0;i<[ar count];i++)
    {
        UILabel *columns=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-85, col+1, 85, 30)];
        columns.text=[ar objectAtIndex:i];
        columns.textAlignment = NSTextAlignmentCenter;
        columns.textColor=[UIColor colorWithRed:148.0/255 green:148.0/255 blue:149.0/255 alpha:1.0];
        [columns setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        columns.backgroundColor=[UIColor whiteColor];
        [prfvwscr addSubview:columns];
        
        
        UILabel *textfield_lbl=[[UILabel alloc]initWithFrame: CGRectMake(0, col+1,self.view.frame.size.width-85, 30)];
        UITapGestureRecognizer *prev1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewEvent:)];
        [prev1 setNumberOfTouchesRequired:1];
        [prev1 setDelegate:self];
        textfield_lbl.userInteractionEnabled = YES;
        [textfield_lbl addGestureRecognizer:prev1];
        
        textfield_lbl.backgroundColor=[UIColor whiteColor];
        textfield_lbl.textColor=[UIColor whiteColor];
        [prfvwscr addSubview:textfield_lbl];
        
        for(int x=0;x<[are count];x++)
        {
            NSString * timestr=[[are valueForKey:@"time"] objectAtIndex:x];
            NSArray * tar= [timestr  componentsSeparatedByString: @":"];
            if(i+1==[[tar objectAtIndex:0] intValue])
            {
                textfield_lbl.tag=[[[are valueForKey:@"event_id"] objectAtIndex:x]intValue];
                textfield_lbl.text=[[are valueForKey:@"event_name"] objectAtIndex:x];
               
                UITapGestureRecognizer *arg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editAndDelteEvent:)];
                [arg setNumberOfTouchesRequired:1];
                [arg setDelegate:self];
                textfield_lbl.userInteractionEnabled = YES;
                [textfield_lbl addGestureRecognizer:arg];
                textfield_lbl.textColor = [UIColor whiteColor];
                NSString * color=[[are valueForKey:@"color"] objectAtIndex:x];
                
                
                if([color intValue]==1)
                    textfield_lbl.backgroundColor=[colorAr objectAtIndex:0];
                
                else if([color intValue]==2)
                    textfield_lbl.backgroundColor=[colorAr objectAtIndex:1];
                
                else if([color intValue]==3)
                    textfield_lbl.backgroundColor=[colorAr objectAtIndex:2];
                
                else if([color intValue]==4)
                    textfield_lbl.backgroundColor=[colorAr objectAtIndex:3];
                else if([color intValue]==5)
                    textfield_lbl.backgroundColor=[colorAr objectAtIndex:4];
                
                else if([color intValue]==6)
                    textfield_lbl.backgroundColor=[colorAr objectAtIndex:5];
                
                else if([color intValue]==7)
                    textfield_lbl.backgroundColor=[colorAr objectAtIndex:6];
                
                else if([color intValue]==8)
                    textfield_lbl.backgroundColor=[colorAr objectAtIndex:7];
                else if([color intValue]==9)
                    textfield_lbl.backgroundColor=[colorAr objectAtIndex:8];
                
                break;
            }
            
        }
        col=col+31;
        
    }
    prfvwscr.contentSize=CGSizeMake(prfvwscr.frame.size.width, col);
    
}



-(void)showDay
{
    [tblCalenderView removeFromSuperview];

    [self clearHeaderview];
    [self showHeaderForDay];
    NSArray *viewsToRemove = [headingView subviews];
    for (UIView *v in viewsToRemove)
    {
        [v removeFromSuperview];
    }
//    tblCalenderView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width,prfvwscr.frame.origin.y,self.view.frame.size.width/2,prfvwscr.frame.size.height) style:UITableViewStylePlain];
//    tblCalenderView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:tblCalenderView];
//    [self.view bringSubviewToFront:tblCalenderView];
    
    
    iday=[[UILabel alloc]initWithFrame:CGRectMake(0,0,375,40)];
    [headingView addSubview:iday];
    iday.textAlignment=NSTextAlignmentCenter;
    iday.textColor = [UIColor colorWithRed:60.0/255 green:85.0/255 blue:125.0/255 alpha:1];
    iday.font = [UIFont fontWithName:@"Helvetica" size:14];;
    
    NSArray *foo=[self currentDayName:0];
    NSString* day1 = [foo objectAtIndex: 0];
    NSString* month1 = [foo objectAtIndex: 1];
    
    NSArray* foo1 = [month1 componentsSeparatedByString: @" "];
    month1 = [foo1 objectAtIndex: 1];
    NSString  *fday = [foo1 objectAtIndex: 2];
    int x=0;
    for(int p=0;p<[monthAr count];p++)
    {
        if([month1 isEqual:[monthAr objectAtIndex:p]])
        {
            x=p;
            break;
        }
    }
    
    x++;
    datelbl.text=fday;
    monthlbl.text=month1;
    yeallab.text=[NSString stringWithFormat:@"%d",year];
    
    NSString *fy= [NSString stringWithFormat:@"%d",year];
           NSString *fm=[NSString stringWithFormat:@"%d",x];
    NSString *fd=[NSString stringWithFormat:@"%@",fday];
    if ([day1 isEqualToString:@"Sunday"]) {
        iday.text=@"Sun";
    }
    else  if ([day1 isEqualToString:@"Monday"]) {
        iday.text=@"Mon";
    }
    else  if ([day1 isEqualToString:@"Tuesday"]) {
        iday.text=@"Tues";
    }
    else  if ([day1 isEqualToString:@"Wednesday"]) {
        iday.text=@"Wed";
    }
    else  if ([day1 isEqualToString:@"Thursday"]) {
        iday.text=@"Thu";
    }
    else  if ([day1 isEqualToString:@"Friday"]) {
        iday.text=@"Fri";
    }
    else  if ([day1 isEqualToString:@"Saturday"]) {
        iday.text=@"Sat";
    }
    
    
   
    
    
    NSString *nstr=[fy stringByAppendingString:[NSString stringWithFormat:@"/%@",fm]];
    nstr = [nstr stringByAppendingString:[NSString stringWithFormat:@"/%@",fd]];
    
    are= [dayEventDataAr valueForKey:nstr];
    
    [self showdayEventViews];
}

-(void) shownextDay
{
    
    int x=0;
    for(int p=0;p<[monthAr count];p++)
    {
        NSString * mnth= monthlbl.text;
        if([mnth isEqual:[monthAr objectAtIndex:p]])
        {
            x=p;
            break;
        }
    }
    
    x++;
    
    int  date=[datelbl.text intValue];
    NSArray *ff=[self currentDayName:1];
    iday.text=@"";
    if(isdayNextOrPrev==0)
    {
        iday.text=ff[0];
    }
    else{
        iday.text=ff[1];
    }
    
//    if ([iday.text isEqualToString:@"Sunday"]) {
//        iday.text=@"Sun";
//    }
//    else  if ([iday.text isEqualToString:@"Monday"]) {
//        iday.text=@"Mon";
//    }
//    else  if ([iday.text isEqualToString:@"Tuesday"]) {
//        iday.text=@"Tues";
//    }
//    else  if ([iday.text isEqualToString:@"Wednessday"]) {
//        iday.text=@"Wed";
//    }
//    else  if ([iday.text isEqualToString:@"Thursday"]) {
//        iday.text=@"Thu";
//    }
//    else  if ([iday.text isEqualToString:@"Friday"]) {
//        iday.text=@"Fri";
//    }
//    else  if ([iday.text isEqualToString:@"Saturday"]) {
//        iday.text=@"Sat";
//    }
    
    NSString *fy= yeallab.text;
    NSString *fm=[NSString stringWithFormat:@"%d",x];
    NSString *fd=datelbl.text;
    
    
    NSString *nstr=[fy stringByAppendingString:[NSString stringWithFormat:@"/%@",fm]];
    nstr = [nstr stringByAppendingString:[NSString stringWithFormat:@"/%@",fd]];
    
    NSLog(@"datae filter====%@",nstr);
    are= [dayEventDataAr valueForKey:nstr];
    
    NSLog(@"event of today are eeeeeee %@",are);
    
    [self showdayEventViews];
    
    
}

-(void) editAndDelteEvent:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer *)sender;
    [cpop addAndDelete:self:(int)tg.view.tag:are];
}




-(void) initCal
{
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"];
    NSString *date_String=[dateformate stringFromDate:[NSDate date]];
    
    NSArray* foo = [date_String  componentsSeparatedByString: @"-"];
    year= [[foo objectAtIndex: 0] intValue];
    month= [[foo objectAtIndex: 1] intValue];
    day= [[foo objectAtIndex: 2] intValue];
    nextmonth=month;
    
    NSLog(@"current month==%d",month);
    NSLog(@"current day==%d",day);
    
    
    daystartfrm=[self dayStartFrom:year :month];
    NSLog(@"daystartfrm init===%d",daystartfrm);
    ret=[self getPreviousDays:month-1:year:0];
    
    
    NSLog(@"inside init===%d",ret);
    
    monthlbl.text=[monthAr objectAtIndex:month-1];
    yeallab.text=[NSString stringWithFormat:@"%d",year];
    
    int ind;
    for(int x=0;x<[monthAr count];x++)
    {
        if([monthlbl.text isEqual:[monthAr objectAtIndex:x]])
        {
            ind=x;
            break;
        }
    }
    
    
    
    NSString *sdays= [daysAr objectAtIndex:ind];
    
    days=[sdays intValue];
    
    if(month==1)
    {
        if(year%4==0)
        {
            days=29;
        }
    }
    
    nextmonth=month-1;
    [self getEventsFrServ :month:year];
    
    
    
}




-(void) next1
{
    int ind=0;
    for(int x=0;x<[monthAr count];x++)
    {
        if([monthlbl.text isEqual:[monthAr objectAtIndex:x]])
        {
            ind=x;
            break;
        }
    }
    nextmonth=ind+1;
    if(nextmonth>=12)
    {
        nextmonth=0;
        year=year+1;
        yeallab.text=[NSString stringWithFormat:@"%d",year];
    }
    
    
    NSString *sdays= [daysAr objectAtIndex:nextmonth];
    days=[sdays intValue];
    
    ret=[self getPreviousDays:nextmonth:year:1];
    
    
    
    //NSLog(@"inside next   montttttttttttttt===%d",ret);
    
    
    
    daystartfrm=[self dayStartFrom:year :nextmonth+1];
    int newret=daystartfrm;
    // NSLog(@"daystartfrm init===%d",daystartfrm);
    
    
    if(nextmonth==1)
    {
        if(year%4==0)
        {
            days=29;
        }
    }
    
    [self getEventsFrServ:nextmonth+1:year];
    //   NSLog(@"days  %d",days);
    // [self caltoCalendar:ret:daystartfrm:days:nextmonth:year];
    
    
}

-(void) previous1
{
    
    int ind=0;
    for(int x=0;x<[monthAr count];x++)
    {
        if([monthlbl.text isEqual:[monthAr objectAtIndex:x]])
        {
            ind=x;
            break;
        }
    }
    
    
    nextmonth=ind-1;
    if(nextmonth<0)
    {
        nextmonth=11;
        year=year-1;
        yeallab.text=[NSString stringWithFormat:@"%d",year];
    }
    
    daystartfrm=[self dayStartFrom:year :nextmonth+1];
    
    //NSLog(@"daystartfrm init===%d",daystartfrm);
    
    ret=[self getPreviousDays:nextmonth :year:0];
    // NSLog(@"inside previous===%d",ret);
    
    NSString *sdays= [daysAr objectAtIndex:nextmonth];
    days=[sdays intValue];
    if(nextmonth==1)
    {
        if(year%4==0)
        {
            days=29;
        }
    }
    
    
    
    //NSLog(@"days  %d",days);
    [self getEventsFrServ:nextmonth+1:year];
    //[self caltoCalendar:ret:daystartfrm:days:nextmonth:year];
    
    
}

-(void) caltoCalendar:(int)ret:(int)daystartfrm:(int)days:(int)nextmonth:(int)year1
{
    
    
    NSLog(@"ret====%d",ret);
    NSLog(@"daystartfrm====%d",daystartfrm);
    NSLog(@"days====%d",days);
    NSLog(@"nextmonth====%d",nextmonth);
    NSLog(@"year1====%d",year1);
    
    
    
    float col=(prfvwscr.frame.size.width/7);
    float xinc=0,ync=1,rowdone=0;
    float ycol = (prfvwscr.frame.size.height/6);
    
    for(UIView *subview in [prfvwscr subviews]) {
        [subview removeFromSuperview];
    }
    
    
    
    for(int d=(ret-daystartfrm)+1;d<=ret;d++)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(xinc,ync,col,ycol)];
        view.backgroundColor = [UIColor whiteColor];
        [prfvwscr addSubview:view];
        
        UILabel *daycol=[[UILabel alloc]initWithFrame:CGRectMake((view.frame.size.width-col-10)/2,(view.frame.size.height-col-10)/2,col-10,col-10)];
        daycol.text=[NSString stringWithFormat:@"%d",d];
        daycol.textAlignment=NSTextAlignmentCenter;
        daycol.backgroundColor=[UIColor whiteColor];
        //daycol.layer.borderColor=[[UIColor blackColor]CGColor];
        [daycol setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        //daycol.layer.borderWidth=1;
        daycol.textColor=celltextcol;
        [view addSubview:daycol];
        
        
        xinc=xinc+col;
        rowdone++;
        if(rowdone==7)
        {
            ync=ync+ycol;
            xinc=3;
            rowdone=0;
        }
 
    }
    int firstdate=1;
    for(int x=daystartfrm;x<days+daystartfrm;x++)
    {
        
        
        NSString *fy= [NSString stringWithFormat:@"%d",year];
        NSString *fm=[NSString stringWithFormat:@"%d",nextmonth+1];
        NSString *fd=[NSString stringWithFormat:@"%d",firstdate];
        
        
        NSString *nstr=[fy stringByAppendingString:[NSString stringWithFormat:@"/%@",fm]];
        nstr = [nstr stringByAppendingString:[NSString stringWithFormat:@"/%@",fd]];
        
        
        NSArray * ar= [EventAr valueForKey:nstr];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(xinc,ync,col,ycol)];
        view.backgroundColor = [UIColor whiteColor];
        [prfvwscr addSubview:view];
        
        
        
        
        
        
        UILabel *daycol=[[UILabel alloc]initWithFrame:CGRectMake((view.frame.size.width-col-10)/2,(view.frame.size.height-col-10)/2,col-10,col-10)];
        daycol.text=[NSString stringWithFormat:@"%d",firstdate];
        daycol.textAlignment=NSTextAlignmentCenter;
        daycol.backgroundColor=[UIColor whiteColor];
        
        daycol.tag=firstdate;
        daycol.layer.cornerRadius = daycol.frame.size.width/2;
        daycol.layer.masksToBounds = YES;
        NSLog(@"next month=====%d",nextmonth);
         NSLog(@"month=====%d",month-1);
         NSLog(@"year1=====%d",year1);
         NSLog(@"year====%d",year);
        
        
        if(firstdate==day && nextmonth==month-1 && year1==year)
        {
            daycol.backgroundColor=[UIColor colorWithRed:211.0/255 green:211.0/255 blue:211.0/255 alpha:1.0];
            //daycol.text=[daycol.text stringByAppendingString:@" T"];
        }
        
        
        
        if([ar count]>0)
        {
            NSMutableDictionary *dictColor = [ar objectAtIndex:0];
            int colorcode  = [[dictColor objectForKey:@"color"]integerValue];
            
            
            daycol.backgroundColor=[colorAr objectAtIndex:colorcode-1];
            
            
            
            daycol.textColor=[UIColor whiteColor];
            
            UITapGestureRecognizer *arg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alreadyevnt:)];
            [arg setNumberOfTouchesRequired:1];
            [arg setDelegate:self];
            daycol.userInteractionEnabled = YES;
            [daycol addGestureRecognizer:arg];
            
        }
        else
        {
            UITapGestureRecognizer *arg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addEvent)];
            [arg setNumberOfTouchesRequired:1];
            [arg setDelegate:self];
            daycol.userInteractionEnabled = YES;
            [daycol addGestureRecognizer:arg];
        }
        
        
        //daycol.layer.borderColor=[[UIColor blackColor]CGColor];
        [daycol setFont:[UIFont fontWithName:@"Helvetica" size:20]];
       // daycol.layer.borderWidth=1;
        [view addSubview:daycol];
        
        firstdate=firstdate+1;
        xinc=xinc+col;
        rowdone++;
        if(rowdone==7)
        {
            
            ync=ync+ycol;
            xinc=0;
            rowdone=0;
        }
    }
    
    int dfo=1;
    for(int p=days;p<42;p++)
       {
        NSLog(@"days=====%d",days);
        NSLog(@"days=====%d",p);
           UIView *view = [[UIView alloc]initWithFrame:CGRectMake(xinc,ync,col,ycol)];
           view.backgroundColor = [UIColor whiteColor];
           [prfvwscr addSubview:view];
           
           
        UILabel *daycol=[[UILabel alloc]initWithFrame:CGRectMake((view.frame.size.width-col-10),(view.frame.size.height-col-15),col-10,col-15)];
        daycol.text=[NSString stringWithFormat:@"%d",dfo];
        daycol.textAlignment=NSTextAlignmentCenter;
        daycol.backgroundColor=[UIColor whiteColor];
       // daycol.layer.borderColor=[[UIColor blackColor]CGColor];
        [daycol setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        //daycol.layer.borderWidth=1;
        daycol.textColor=celltextcol;
        [view addSubview:daycol];
        
        
        firstdate=firstdate+1;
        xinc=xinc+col;
        dfo++;
        rowdone++;
        if(rowdone==7)
        {
            
            ync=ync+ycol;
            xinc=0;
            rowdone=0;
        }
        
    }
    monthlbl.text=[monthAr objectAtIndex:nextmonth];
    prfvwscr.contentSize=CGSizeMake(prfvwscr.frame.size.width, ync);
    prfvwscr.scrollEnabled=NO;
    
}



-(int) dayStartFrom:(int) year:(int) day
{
    
    NSString *conyears=[NSString stringWithFormat:@"%d",year];
    NSString  *condates=[NSString stringWithFormat:@"-%@",[NSString stringWithFormat:@"%d",day]];
    NSString *finaldate=[conyears stringByAppendingString:condates];
    NSString  *sfinal=[finaldate stringByAppendingString:[NSString stringWithFormat:@"-%@",@"1"]];
    
    NSString * da=sfinal;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:da];
    
    //NSLog(@"nsdasre dateFromString==%@",dateFromString);
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateFromString];
    components.day = 1;
    NSDate *firstDayOfMonthDate = [[NSCalendar currentCalendar] dateFromComponents: components];
    NSLog(@"First day of month: %@", [firstDayOfMonthDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    
    NSArray* foo = [[firstDayOfMonthDate descriptionWithLocale:[NSLocale currentLocale]] componentsSeparatedByString: @","];
    NSString* firstBit = [foo objectAtIndex: 0];
    
    
    
    if([firstBit isEqual:@"Sunday"])
        return 0;
    if([firstBit isEqual:@"Monday"])
        return 1;
    if([firstBit isEqual:@"Tuesday"])
        return 2;
    if([firstBit isEqual:@"Wednesday"])
        return 3;
    
    if([firstBit isEqual:@"Thursday"])
        return 4;
    if([firstBit isEqual:@"Friday"])
        return 5;
    if([firstBit isEqual:@"Saturday"])
        return 6;
    
    return 0;
}




-(NSArray *) currentDayName:(int)check
{
    
    if(check==0)//for current date
    {
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"dd.MM.yyyy";
        NSString *stringe = [formatter stringFromDate:[NSDate date]];
        
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [formatter dateFromString:stringe];
        
        NSLog(@"nsdasre fdgfg dateFromString==%@",dateFromString);
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateFromString];
        NSDate *firstDayOfMonthDate = [[NSCalendar currentCalendar] dateFromComponents: components];
        NSLog(@"First day of month ddd: %@", [firstDayOfMonthDate descriptionWithLocale:[NSLocale currentLocale]]);
        
        
        NSArray* foo = [[firstDayOfMonthDate descriptionWithLocale:[NSLocale currentLocale]] componentsSeparatedByString: @","];
        return foo;
    }
    else //for dynamic date
    {
        NSString *newDay= [weekdayAr valueForKey:iday.text] ;
        NSArray * dayAr=[newDay componentsSeparatedByString:@"-"];
        return dayAr;
    }
    
    return 0;
}



-(int) getPreviousDays:(int) month:(int)year:(int)isback
{
    if(month==11)
    {
        if(isback==0)
        {
            return 30;
        }
        else
        {
            if(isback==1)
            {
                return 30;
            }
            NSLog(@"inside month 11 %d",month);
            NSLog(@"inside year 11 %d",year);
            //get the value of january of prev month
            return 31;
        }
    }
    else
    {
        NSLog(@"inside month -1 %d",month);
        NSLog(@"inside year -1 %d",year);
        
        if(month==2)
        {
            if(year%4==0)
            {
                return 29;
            }
            else{
                return 28;
            }
        }
        else {
            if(month==0)
            {
                return 31;
            }
            else
            {
                NSLog(@"valu of dayassss  %d",[[daysAr objectAtIndex:month-1] intValue]);
                return  [[daysAr objectAtIndex:month-1] intValue];
            }
        }
    }
    
    return 0;
}

-(void) addEvent{
     NSLog(@"addNewEvent is===================================%@",@"addNewEvent is======%@");
    //iscallback=1;
//    if (currentCalendar) {
        [[NSUserDefaults standardUserDefaults] setObject:currentCalendar forKey:@"CURRENT_CAL"];
        [[NSUserDefaults standardUserDefaults] setValue:currentCalViewType forKey:@"CURRENT_EVENT_TYPE"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [cpop addEvent:self];
//    }
}

-(void) alreadyevnt:(id)sender
{
    UITapGestureRecognizer *tg= (UITapGestureRecognizer *)sender;
    
    
    NSString *fy= [NSString stringWithFormat:@"%d",year];
    NSString *fm=[NSString stringWithFormat:@"%d",nextmonth+1];
    NSString *fd=[NSString stringWithFormat:@"%d",(int)tg.view.tag];
    
    
    NSString *nstr=[fy stringByAppendingString:[NSString stringWithFormat:@"/%@",fm]];
    nstr = [nstr stringByAppendingString:[NSString stringWithFormat:@"/%@",fd]];
    NSLog(@"new String genrated  %@",nstr);
    
    
    [cpop ViewEventList:self :[EventAr valueForKey:nstr]];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void) getEventsFrServ:(int)month:(int)year
{
    
    prefmonth=month;
    prefyear=year;
    
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
   [dic1 setValue:strCalenderName forKey:@"calNames"];
    [dic1 setValue:@"month" forKey:@"k"];
    [dic1 setValue:[NSString stringWithFormat:@"%d",year] forKey:@"yr"];
    [dic1 setValue:[NSString stringWithFormat:@"%d",month] forKey:@"mnt"];
    NSString *newstr=[NSString stringWithFormat:@"-%d",month];
    newstr=[newstr stringByAppendingString:[NSString stringWithFormat:@"-%d",year]];
    [dic1 setValue:newstr forKey:@"mn"];
    iscallback=0;
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"ShowEventCal" :@"":@"":dic1 :self];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView == tblCalenderView) {
        return 45;
    }
    else
    return 85;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
  {
      if (theTableView == tblCalenderView) {
          return arrCalender.count;
      }
      else{
        showMessageAr=[[NSMutableDictionary alloc]init];
        lineLabAr=[[NSMutableDictionary alloc]init];
        declineAr=[[NSMutableDictionary alloc]init];
        return [calAr count];
      }
  }

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.mynotification dequeueReusableCellWithIdentifier:MyCellIdentifier];
    @try {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,1)];
        separator.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:separator];
        NSMutableDictionary *bd=[SavePrefrences sharedInstance].colorDictionry;
        cell.backgroundColor=[bd valueForKey:@"backcolor"];
        UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 3,self.view.frame.size.width-10, 78)];
        cell_View.backgroundColor=[UIColor clearColor];
//        cell_View.layer.borderWidth=1;
//        cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
        cell_View.layer.cornerRadius=6;
        [cell addSubview: cell_View];
        if (theTableView == tblCalenderView) {
            NSMutableDictionary *dictCalender = [arrCalender objectAtIndex:indexPath.row];
            UIButton *btnCheckMark=[[UIButton alloc]initWithFrame:CGRectMake(5, cell.frame.size.height/2-13, 35, 35)];
            [btnCheckMark setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
            btnCheckMark.tag = indexPath.row;
            [btnCheckMark addTarget:self action:@selector(btnCheckMarkAction:) forControlEvents:UIControlEventTouchUpInside];
            [btnCheckMark setImage:[UIImage imageNamed:@"radioselect.png"] forState:UIControlStateSelected];
           // [btnCheckMark setImage:[UIImage imageNamed:@"chatic.png"]];
            [cell_View addSubview:btnCheckMark];
            UILabel*user_lbl=[[UILabel alloc]initWithFrame:CGRectMake(btnCheckMark.frame.size.width+btnCheckMark.frame.origin.x+2, 15, 100,20)];
            user_lbl.text=[dictCalender objectForKey:@"cal_name"];
            [user_lbl setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            user_lbl.backgroundColor=[UIColor clearColor];
            user_lbl.textColor= [UIColor colorWithRed:138.0/255.0 green:157.0/255.0 blue:179.0/255.0 alpha:1];
            [cell_View addSubview:user_lbl];
            UIButton *btnDelete=[[UIButton alloc]initWithFrame:CGRectMake(user_lbl.frame.size.width+user_lbl.frame.origin.x+2, cell.frame.size.height/2-13, 35, 35)];
            [btnDelete setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [btnDelete setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateSelected];
            // [btnCheckMark setImage:[UIImage imageNamed:@"chatic.png"]];
            btnDelete.tag = indexPath.row;
            [btnDelete addTarget:self action:@selector(btnDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell_View addSubview:btnDelete];
        }
        else{

        
        if((int)indexPath.row <(int)[calAr count])
            {
                NSArray * data=[calAr objectAtIndex:indexPath.row];
                NSString *firstname=[data valueForKey:@"fname"] ;
                NSString *lastname=[data valueForKey:@"lname"] ;
                NSString *uname=[data valueForKey:@"uname"] ;
                int ntc=[[data valueForKey:@"ntc"] intValue];
                
                NSString * tit;
//                UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(10,5,50, 50)];
//                imgView.image = [UIImage imageNamed:@"chatic.png"];
//                
//                
//                [cell_View addSubview:imgView];
//                
//                
//                
//                UILabel *line_lbl=[[UILabel alloc]initWithFrame:CGRectMake(65,5,cell_View.frame.size.width-60, 20)];
//                line_lbl.backgroundColor=[UIColor clearColor];
//                line_lbl.textColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
//                line_lbl.text=tit;
//                
//                
//                [cell_View addSubview:line_lbl];
//                line_lbl.font=[UIFont boldSystemFontOfSize:12];

                UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.size.height/2-13, 35, 35)];
                [userpic setImage:[UIImage imageNamed:@"chatic.png"]];
                [cell_View addSubview:userpic];
                UILabel*user_lbl=[[UILabel alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10, 5, 50,20)];
                user_lbl.text=uname;
                [user_lbl setFont:[UIFont fontWithName:@"Helvetica" size:14]];
                user_lbl.backgroundColor=[UIColor clearColor];
                user_lbl.textColor= [UIColor colorWithRed:138.0/255.0 green:157.0/255.0 blue:179.0/255.0 alpha:1];
                [cell_View addSubview:user_lbl];
                UILabel *line_lbl=[[UILabel alloc]initWithFrame:CGRectMake(user_lbl.frame.origin.x+user_lbl.frame.size.width+5,5,cell_View.frame.size.width-60, 20)];
                [line_lbl setFont:[UIFont fontWithName:@"Helvetica" size:13]];
                line_lbl.backgroundColor=[UIColor clearColor];
                line_lbl.textAlignment = NSTextAlignmentLeft;
                                line_lbl.textColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
                                line_lbl.text=@"";
                
                
                                [cell_View addSubview:line_lbl];
                
                //here
              //[ff valueForKey:@"Scrollcolor"];
                // [cell_View addSubview:user_lbl];
                
                //here
                UILabel *timlb=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.view.frame.size.width-20,15)];
                timlb.text=@"";
                timlb.textColor=[UIColor blackColor];
                [timlb setFont:[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:10]];
                timlb.textAlignment=NSTextAlignmentRight;
                timlb.backgroundColor=[UIColor clearColor];
                [cell_View addSubview:timlb];
                
                
                
               
                
                UIButton  *btnChat=[[UIButton alloc]initWithFrame:CGRectMake((cell_View.frame.size.width-50),timlb.frame.size.height+timlb.frame.origin.y+15,20,20)];
                //acppt.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
                [btnChat setImage:[UIImage imageNamed:@"chatNew.png"] forState:UIControlStateNormal];
                [cell_View addSubview:btnChat];
                
                UIButton  *acppt=[[UIButton alloc]initWithFrame:CGRectMake((cell_View.frame.size.width/2)-105,line_lbl.frame.size.height+line_lbl.frame.origin.y+10,100,20)];
                //acppt.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
                [acppt setImage:[UIImage imageNamed:@"accept1.png"] forState:UIControlStateNormal];
                [acppt setTitle:@"Accept" forState:UIControlStateNormal];
                [acppt setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
                acppt.titleLabel.font=[UIFont systemFontOfSize:12];
                
                if(ntc==33)
                {
                    NSArray * jsonObject=[manag convertojson:data];
                    
                    NSString *brdid,*titled;
                    if([manag checkContaine:jsonObject])
                    {
                        brdid=[jsonObject valueForKey:@"calId"];
                        titled=[jsonObject valueForKey:@"title"];
                        tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc33] stringByAppendingString:titled];
                        tit = [NSString stringWithFormat:@"has shared a calender event \"%@\"",titled];
                            user_lbl.text=uname;
                     //   user_lbl.backgroundColor = [UIColor blackColor];
                    }
                    else
                    {
                        brdid=[jsonObject valueForKey:@"calId"];
                        tit=[SavePrefrences sharedInstance].ntc33 ;
                    }
                    acppt.hidden=false;
                    line_lbl.text= tit;
                    [acppt addTarget:self action:@selector(acceptcalInvitation:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
                else  if(ntc==34)
                {
                    NSArray * jsonObject=[manag convertojson:data];
                    
                    NSString *brdid,*titled;
                    if([manag checkContaine:jsonObject])
                    {
                        brdid=[jsonObject valueForKey:@"eventId"];
                        titled=[jsonObject valueForKey:@"title"];
                        tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc34] stringByAppendingString:titled];
                    }
                    else
                    {
                        brdid=[jsonObject valueForKey:@"eventId"];
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc34] ;
                    }
                    acppt.hidden=false;
                    line_lbl.text= tit;
                    [acppt addTarget:self action:@selector(acceptcalevent:) forControlEvents:UIControlEventTouchUpInside];
                }
                else if(ntc==35)
                {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc35 ];
                    acppt.hidden=true;
                    line_lbl.text=tit;
                }
                else if(ntc==36)
                {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc36];
                    acppt.hidden=true;
                    line_lbl.text=tit;
                }
                else if(ntc==37)
                {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc37];
                    acppt.hidden=true;
                    line_lbl.text=tit;
                }
                else if(ntc==38)
                {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc38];
                    acppt.hidden=true;
                    line_lbl.text=tit;
                }
                
                acppt.tag=indexPath.row;
                [cell_View addSubview:acppt];
                
                UIButton *decline=[[UIButton alloc]initWithFrame:CGRectMake((cell_View.frame.size.width/2)+5,line_lbl.frame.size.height+line_lbl.frame.origin.y+10,100,20)];
              //  decline.backgroundColor=[ff valueForKey:@"Declinecolor"];
                [decline setTitle:@"Decline" forState:UIControlStateNormal];
                [decline setImage:[UIImage imageNamed:@"deny.png"] forState:UIControlStateNormal];
                [decline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                if(ntc==35 || ntc==36 || ntc==37||ntc==38)
                {
                    decline.hidden=true;
                }
                else if(ntc==33)
                {
                    [decline addTarget:self action:@selector(acceptcalInvitation:) forControlEvents:UIControlEventTouchUpInside];
                    decline.hidden=false;
                }
                else if (ntc==34)
                {
                    decline.hidden=false;
                    [decline addTarget:self action:@selector(acceptcalevent:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                [decline setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
                decline.titleLabel.font=[UIFont systemFontOfSize:12];
                
                [cell_View addSubview:decline];
                decline.tag=indexPath.row;
                
                
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




-(IBAction)acceptcalInvitation:(id)sender
{
    iscallback=33;
    
    UIButton * btn=(UIButton *)sender;
    
    NSLog(@"sender======%@",btn.titleLabel.text);
    
    UIButton * act=[showMessageAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UIButton * dec=[declineAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UILabel * lil=[lineLabAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    dec.hidden=true;
    act.hidden=true;
    
    
    int tagId=(int)btn.tag;
    int cnt=(int)[calAr count];
    if(cnt<=tagId)
    {
        tagId=cnt-1;
    }
    
    NSArray * data=[calAr objectAtIndex:tagId];
    NSArray * jsonObject=[manag convertojson:data];
    NSString *brdid=[jsonObject valueForKey:@"calId"];
    NSString *frid=[data valueForKey:@"uid"];
    
    if([btn.titleLabel.text isEqual:@"Accept"])
    {
    lil.text=@"you have accepted Calendar Invitation";
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setObject:@"1" forKey:@"ar"];
    [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"calId"];
    [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
    cnt  = (int)[[(NSMutableArray *)[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] count];
    if(cnt<=tagId)
    {
        tagId=cnt-1;
    }
    
    [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] removeObjectAtIndex:tagId];
    [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"calAR" :@"" :@"" :dic :self];
    }
    else
    {
        lil.text=@"you have Rejected Calendar Invitation";
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic setObject:@"2" forKey:@"ar"];
        [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"calId"];
        [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
        cnt  = (int)[[(NSMutableArray *)[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] count];
        if(cnt<=tagId)
        {
            tagId=cnt-1;
        }
        
        [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] removeObjectAtIndex:tagId];
        [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"calAR" :@"" :@"" :dic :self];

    }


    
    for(int x=0;x<[[SavePrefrences sharedInstance].notiYolkingAr count];x++)
    {
        NSArray *data=[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:x];
        NSString * ntc = [data valueForKey:@"ntc"];
        NSString * frid1 = [data valueForKey:@"uid"];
        
        if([ntc intValue]==33)
        {
            
            NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
            NSArray * jsonObject=[manag convertojson:data];
            NSString * brdID = [jsonObject valueForKey:@"calId"];
            if([brdID intValue]==[brdid intValue])
            {
                if([frid intValue]==[frid1 intValue])
                {
                    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
                    [dic setValue:date forKey:@"time"];
                    [dic setValue:@" You have Accepted The Calendar Invitation " forKey:@"mes"];
                    [[[SavePrefrences sharedInstance].notiYolkingAr  objectAtIndex:x] setValue:dic forKey:@"brdStstus"];
                    break;
                }
            }
        }
        
    }
    [mynotification reloadData];
    
    
    
}
-(IBAction)acceptcalevent:(id)sender
   {
    iscallback=34;
    
    UIButton *btn=(UIButton*)sender;
    UIButton * act=[showMessageAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UIButton * dec=[declineAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UILabel * lil=[lineLabAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    dec.hidden=true;
    act.hidden=true;
    
    
    int tagId=(int)btn.tag;
    int cnt=(int)[calAr count];
    if(cnt<=tagId)
    {
        tagId=cnt-1;
    }
    
    NSArray * data=[calAr objectAtIndex:tagId];
    NSArray * jsonObject=[manag convertojson:data];
    
    
    NSString *brdid=[jsonObject valueForKey:@"eventId"];
    NSString *frid=[data valueForKey:@"uid"];
    
    NSLog(@"uidd====%@",frid);
       
    if([btn.titleLabel.text isEqual:@"Accept"])
    {
    
    lil.text=@"you have accepted the Calendar event";
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setObject:@"1" forKey:@"ar"];
    [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"eventId"];
    [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
    cnt  = (int)[[(NSMutableArray *)[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] count];
    if(cnt<=tagId)
    {
        tagId=cnt-1;
    }
    
    [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] removeObjectAtIndex:tagId];
    [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"calEAR" :@"" :@"" :dic :self];
    }
    else
    {
        lil.text=@"you have Rejected  the Calendar event";
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic setObject:@"2" forKey:@"ar"];
        [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"eventId"];
        [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
        cnt  = (int)[[(NSMutableArray *)[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] count];
        if(cnt<=tagId)
        {
            tagId=cnt-1;
        }
        
        [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] removeObjectAtIndex:tagId];
        [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"calEAR" :@"" :@"" :dic :self];
    }
  
    for(int x=0;x<[[SavePrefrences sharedInstance].notiYolkingAr count];x++)
    {
        NSArray *data=[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:x];
        NSString * ntc = [data valueForKey:@"ntc"];
        NSString * frid1 = [data valueForKey:@"uid"];
        
        if([ntc intValue]==34)
        {
            
            NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
            NSArray * jsonObject=[manag convertojson:data];
            NSString * brdID = [jsonObject valueForKey:@"eventId"];
            
              NSLog(@"brdId=====%@",brdID);
              NSLog(@"brdid=====%@",brdid);
              NSLog(@"frid=====%@",frid);
              NSLog(@"frid1=====%@",frid1);
            
            if([brdID intValue]==[brdid intValue])
               {
                if([frid intValue]==[frid1 intValue])
                {
                    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
                    [dic setValue:date forKey:@"time"];
                    [dic setValue:@" You have Accepted The Calendar event " forKey:@"mes"];
                    [[[SavePrefrences sharedInstance].notiYolkingAr  objectAtIndex:x] setValue:dic forKey:@"brdStstus"];
                    break;
                }
            }
        }
        
    }
    [mynotification reloadData];
    
    
}




-(void) callBack:(NSArray *)META  :(NSArray *)DATA
{
    
    if (iscallback==501) {
        
//        NSLog(@"meta is %@",META);
//        NSLog(@"data is %@",DATA);
//        arrCalender =(NSMutableArray *) DATA;
//        tblCalenderView.dataSource = self;
//        tblCalenderView.delegate = self;
//        [tblCalenderView reloadData];
    }

    
    //frndlist
    if (iscallback==101) {
        NSLog(@"meta is %@",META);
        NSLog(@"data is %@",DATA);
        arrCalender =(NSMutableArray *) DATA;
        tblCalenderView.dataSource = self;
        tblCalenderView.delegate = self;
        [tblCalenderView reloadData];
        [UIView animateWithDuration:0.5
                         animations:^{
                             [tblCalenderView setFrame:CGRectMake(self.view.frame.size.width/2, prfvwscr.frame.origin.y,self.view.frame.size.width/2,prfvwscr.frame.size.height)];
                             
                         }
                         completion:^(BOOL finished){
                             [tblCalenderView reloadData];
                             // [view1.view removeFromSuperview];
                         }];
    }
    
    
    
   else if(iscallback==0)
    {
        
        NSLog(@"meta is %@",META);
        NSLog(@"data is %@",DATA);
        
        NSArray *data=[META valueForKey:@"data"];
        EventAr= [data valueForKey:@"event"];
        [self showCalendar:1];
        
        [self caltoCalendar :ret:daystartfrm:days:nextmonth:year];
    }
    
    else if (iscallback==1)
    {
        //NSLog(@"back event meta  %@",META);
        // NSLog(@"back data  %@",DATA);
        
        // [self initCal];
    }
    else if(iscallback==3)
    {
        NSLog(@"back meta save calendar meta  %@",META);
        NSLog(@"back data save calendar %@",DATA);
    }
    
    else if(iscallback==4)
    {
        
        dayEventDataAr=[[META valueForKey:@"data"] valueForKey:@"event"] ;
        
        
        [self showDay];
        
        NSLog(@"day event meta save calendar meta  %@",META);
        NSLog(@"day event data save calendar %@",DATA);
    }
    
    else if (iscallback==5)
    {
        dayEventDataAr=[[META valueForKey:@"data"] valueForKey:@"event"] ;
        
        [self shownextDay];
        
        NSLog(@"inside 5day event meta save calendar meta  %@",META);
        NSLog(@"day 5 event data save calendar %@",DATA);
    }
    else if(iscallback==6)
    {
        
        weekeventAr=[[META valueForKey:@"data"] valueForKey:@"event"];
        
        [self showWeekCall1];
    }
    
}

-(IBAction)btnCheckMarkAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSMutableDictionary *dictCalender = [arrCalender objectAtIndex:btn.tag];
    currentCalendar = dictCalender;
   
    strCalenderName =  [dictCalender objectForKey:@"cal_name"];;
    
    if(btn.selected){
            [btn setSelected:NO];
        
    }
    else{
            [btn setSelected:YES];
    }
    [[imgBtnAr objectAtIndex:0] setBackgroundColor:[UIColor colorWithRed:0/255 green:35.0/255 blue:80.0/255 alpha:1.0]];
    
    [prfvwscr removeFromSuperview];
    [self clearHeaderview];
    [self showHeaderForMonth];
    [self showCalendar:1];
    [self initCal];
   //   [self showWeekCal];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [tblCalenderView setFrame:CGRectMake(self.view.frame.size.width, prfvwscr.frame.origin.y,self.view.frame.size.width/2,prfvwscr.frame.size.height)];
                         
                     }
                     completion:^(BOOL finished){
                         // [view1.view removeFromSuperview];
                     }];
    
}
-(IBAction)btnDeleteAction:(id)sender{
    UIButton *btnDelete = (UIButton *)sender;
    iscallback = 501;
    NSMutableDictionary *dictCalende = [arrCalender objectAtIndex:btnDelete.tag];
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    
    [dictParam setObject:[dictCalende objectForKey:@"cal_id"] forKey:@"calId"];
    arrCalender = arrCalender.mutableCopy;
    [arrCalender removeObject:dictCalende];
    [tblCalenderView reloadData];
    [[SavePrefrences sharedInstance].skthand emitData:@"CalenderEvent" :@"DelCal":@"":@"":dictParam :self];
    
}



-(void) callMethod:(NSArray *)meta
{
    NSString * chk=[meta objectAtIndex:0];
    NSLog(@"calender meta an %@",meta);
    
    NSLog(@"Valuuuuuuuuuu===%@",meta);
    NSLog(@"COUNT IS %lu",[meta count]);
    if([meta count]>1)
    {
        
        NSMutableArray * ar=[meta objectAtIndex:1];
        
        if([ar count]>0)
        {
            if([chk isEqual:@"frndlist"])
            {
                
                [cpop privatefrndAr:ar];
            }
            else  if([chk isEqual:@"eventlist"])
            {
                [self getEventsFrServ:prefmonth :prefyear];
            }
            
            
            
        }
    }
    
}


@end
