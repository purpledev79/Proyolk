


#import "CalendarPopup.h"
#import "SavePrefrences.h"
#import "AllValidationsViewController.h"
#import "invitePeople.h"
#import "ManageArray.h"
#import "AddCalendar.h"
#import "AddEvent.h"
#import "SelectCountry.h"
#import "BoardPopUp.h"

@interface CalendarPopup ()

{
    
    id sender1,sender2,sender3,sender4,sender5;;
    UIButton *onebtnpubpri,*onebtntrepeat,*onbtnnttype,*onebtncbnt,*never;
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIView *headercalendar,*prMainView,*datePickerView,*selView,*frndview,*publicview;
    UITextField *name,*location,*title;
    UIImageView *image1,*image2,*image3;
    UILabel *Select_Country_Zone,*Select_Zone,*Select_Time_Zone,*country,*sate,*city,*My_Calender,*Select_color,*color2,*color3,*color4,*color5,*color6,*color7,*color8,*color9,*visibility,  *Repeat,*public;
    int relation,iscallpub,idd;
    UIViewController *vc1;
    UILabel *lbl_once;
    NSMutableArray *weekAr,*serverweekAr;
    UIScrollView *scrollbar;
    UILabel *NameLabel,*promptLabel,*date_btn,*todate_btn,*frnds;
    AllValidationsViewController *av;
    NSMutableArray *countryAr,*stateAr,*cityAr;
    NSString * isCallBack;
    NSString * stid ,*cid,*cal_id,*czsid,*cztid,*czid;
    UIDatePicker *datepicker;
    int isdate,seletedcol,frnd,repeat,nttype,pubpri ,deletetagid,eventId,evid,calcolor,chkdesc;
    NSMutableArray *colorAr;
    UIButton *frnd_btn;
    NSArray *mycalAr,*zonecountAr,*zonetimeAr,*zoneAr;
    UITextView *description;
    NSMutableArray * popUpAr,*EventArDat,*publicAr,*colorAA,*weekselAr,*weekdayvwAr,*FrndAr,*notiVwAr;
    NSArray * evntArUpdate ,*calmemAr;
    UIButton *close;
    UIView *vw,*wekendview;
    UITextField*txtcl,*txtcl1;
    UILabel *lbl1;
    UIButton *btn1;
    BoardPopUp *bpop;
    UIView *closeView;
    NSMutableArray *emailIntervalAr,*smsIntervalAr,*popupIntervalAr,*arweek,*backData;
    
    
}
@end

@implementation CalendarPopup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{
    av=[[AllValidationsViewController alloc]init];
    
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:224.0/255.0f green:224.0/255.0f blue:224.0/255.0f alpha:1.0];
    
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-80, 40)];
    NameLabel.text=title;
    NameLabel.textColor=[UIColor colorWithRed:16.0/255 green:38.0/255 blue:87.0/255 alpha:1.0];
    NameLabel.font=[UIFont systemFontOfSize:14];
    NameLabel.backgroundColor=[UIColor clearColor];
    NameLabel.layer.cornerRadius=5;
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [prMainView addSubview:NameLabel];
    
    //    close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    close.frame=CGRectMake(NameLabel.frame.size.width+NameLabel.frame.origin.x,[SavePrefrences sharedInstance ].naviHght+15, 20, 40);
    //    [close setTitle:@"X" forState:UIControlStateNormal];
    //    [close setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    //    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    //    [close setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    //    close.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
    //
    //    [prMainView addSubview:close];
    //
    //
    
//    closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel.frame.size.width+NameLabel.frame.origin.x,[SavePrefrences sharedInstance ].naviHght+15, 40, 40)];
//    closeView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    [prMainView addSubview:closeView];
//    
//    UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 25, 25)];
//    [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
//    cross.userInteractionEnabled=YES;
//    [closeView addSubview:cross];
//    
//    
//    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel1)];
//    [communityeg setNumberOfTouchesRequired:1];
//    [communityeg setDelegate:self];
//    closeView.userInteractionEnabled = YES;
//    [closeView addGestureRecognizer:communityeg];
//    
    
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    scrollbar.backgroundColor=[UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    [prMainView addSubview:scrollbar];
    
    return prMainView;
}


-(void)cancel1
{
    [self dissmisspop];
    
}

-(IBAction)cancel:(id)sender
{
    [self dissmisspop];
}

-(void)dissmisspop
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


-(IBAction)cancelfrnd:(id)sender
{
    [datePickerView removeFromSuperview];
}


-(void) didPressSelectCountry:(id)obj{
    event = (AddEvent *)obj;
    
    [self countrySel:event.txtCountry];
}


-(void) didPressSelectState:(id)obj{
     event = (AddEvent *)obj;
    [self stateSel:event.txtState];
}
-(void) didPressSelectCity:(id)obj{
    event = (AddEvent *)obj;
    [self citySel:event.txtCity];
}

-(void) addCalendar:(UIViewController *)Vc
{
    AddCalend *containerView = [[[NSBundle mainBundle] loadNibNamed:@"AddCalend" owner:self options:nil] lastObject];
    containerView.delegationListener = self;
    //  containerView.strFlag = @"0";
    CGRect frame = containerView.frame;
    frame.size.width = self.view.frame.size.width-40;
    frame.size.height = self.view.frame.size.height - 150;
    containerView.frame = frame;
    containerView.layer.cornerRadius = 5.0;
    containerView.center = self.view.center;
    [Vc.view addSubview:containerView];
    [Vc.view bringSubviewToFront:containerView];

}

-(void) didPressSelectCountrie:(id)obj{
    
    addCalend = (AddCalend *)obj;
    [self countrySel:addCalend.txtSelectCountry];

}

-(void) addEvent:(UIViewController *)Vc
{
    AddEvent *containerView = [[[NSBundle mainBundle] loadNibNamed:@"AddEvent" owner:self options:nil] lastObject];
    
    containerView.delegationListener = self;
    //  containerView.strFlag = @"0";
    CGRect frame = containerView.frame;
    frame.size.width = self.view.frame.size.width-40;
    frame.size.height = self.view.frame.size.height - 150;
    containerView.frame = frame;
    containerView.layer.cornerRadius = 5.0;
  
    containerView.center = self.view.center;
    [Vc.view addSubview:containerView];
    [Vc.view bringSubviewToFront:containerView];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(chkdesc==0)
    {
        [scrollbar setContentOffset:CGPointMake(0,1000) animated:YES];
    }
    if (chkdesc==1)
    {
        [scrollbar setContentOffset:CGPointMake(0,300) animated:YES];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [scrollbar setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)editEvent:(UIViewController*)Vc
{
    chkdesc=0;
    float screenWidth=[SavePrefrences sharedInstance].screenWidth;
    float screenHeight=[SavePrefrences sharedInstance].screenHeight;
    [self MainView:Vc:@"Update Event"];
    nttype=0;
    
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    scrollbar.backgroundColor=[ff valueForKey:@"popupcolor"];
    
    smsIntervalAr=[[NSMutableArray alloc]init];
    popupIntervalAr=[[NSMutableArray alloc]init];
    emailIntervalAr=[[NSMutableArray alloc]init];
    
    notiVwAr=[[NSMutableArray alloc]init];
    
    
    [emailIntervalAr addObject:@"Never"];
    [emailIntervalAr addObject:@"5 Min"];
    [emailIntervalAr addObject:@"10 Min"];
    [emailIntervalAr addObject:@"15 Min"];
    [emailIntervalAr addObject:@"30 Min"];
    
    for(int x=1;x<12;x++)
    {
        [emailIntervalAr addObject:[NSString stringWithFormat:@"%d Hours",x]];
    }
    [emailIntervalAr addObject:@"1 Week"];
    [emailIntervalAr addObject:@"2 Week"];
    
    NSString *ititle,*idate_btn,*itodate_btn,*icountry,*isate,*icity,*ilocation,*iMy_Calender,*iSelect_color,*evntDec,*itilldate,*notiperiod,*weekendday;
    
    NSLog(@"pubpri value before ========%d",pubpri);
    NSLog(@"pubpri value rec_type ========%d",repeat);
    
    iMy_Calender=@" My Calender";
    NSString *evntid=[[evntArUpdate objectAtIndex:0]valueForKey:@"event_id"];
    eventId=[evntid intValue];
    cal_id=[[evntArUpdate objectAtIndex:0] valueForKey:@"cal_id"];
    ititle= [[evntArUpdate objectAtIndex:0] valueForKey:@"event_name"];
    iSelect_color= [[evntArUpdate objectAtIndex:0] valueForKey:@"color"];
    icountry= [[evntArUpdate objectAtIndex:0] valueForKey:@"country"];
    isate= [[evntArUpdate objectAtIndex:0] valueForKey:@"state"];
    icity=  [[evntArUpdate objectAtIndex:0] valueForKey:@"city"];
    itilldate=[[evntArUpdate objectAtIndex:0]valueForKey:@"till_date"];
    evntDec=[[evntArUpdate objectAtIndex:0] valueForKey:@"event_desc"];
    notiperiod=[[evntArUpdate objectAtIndex:0]valueForKey:@"noti_period"];
    NSString *frdate=[[evntArUpdate objectAtIndex:0] valueForKey:@"from_date"];
    NSString *todate=[[evntArUpdate objectAtIndex:0] valueForKey:@"to_date"];
    NSDate *cdate = [NSDate dateWithTimeIntervalSince1970:([frdate floatValue] / 1000.0)];
    NSDate *edate = [NSDate dateWithTimeIntervalSince1970:([todate floatValue] / 1000.0)];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    idate_btn = [dateFormatter1 stringFromDate:cdate];
    
    
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    itodate_btn = [dateFormatter2 stringFromDate:edate];
    
    ilocation=  [[evntArUpdate objectAtIndex:0] valueForKey:@"location"];
    nttype= [[[evntArUpdate objectAtIndex:0] valueForKey:@"noti_type"] intValue];
    pubpri= [[[evntArUpdate objectAtIndex:0] valueForKey:@"visibility"]intValue ];
    repeat=[[[evntArUpdate objectAtIndex:0] valueForKey:@"rec_type"] intValue ];
    
    
    title=[[UITextField alloc]initWithFrame:CGRectMake(5, promptLabel.frame.size.height+promptLabel.frame.origin.y+10, scrollbar.frame.size.width-15, 45)];
    title.layer.borderWidth=2;
    title.backgroundColor=[UIColor whiteColor];
    title.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    title.text=ititle;
    title.layer.cornerRadius=6;
    title.delegate=self;
    title.textColor=[ff valueForKey:@"Scrollcolor"];
    [scrollbar addSubview:title];
    int div=scrollbar.frame.size.width;
    
    date_btn =[[UILabel alloc]initWithFrame:CGRectMake(5, title.frame.size.height+title.frame.origin.y+10, div-15, 45)];
    date_btn.layer.borderWidth=1.5;
    date_btn.layer.cornerRadius=5;
    date_btn.backgroundColor=[UIColor whiteColor];
    date_btn.textColor=[ff valueForKey:@"Scrollcolor"];
    date_btn.clipsToBounds=YES;
    date_btn.text=[NSString stringWithFormat:@"%@",idate_btn];
    
    
    UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [prev setNumberOfTouchesRequired:1];
    [prev setDelegate:self];
    date_btn.userInteractionEnabled = YES;
    [date_btn addGestureRecognizer:prev];
    date_btn.tag=0;
    [scrollbar addSubview:date_btn];
    
    todate_btn =[[UILabel alloc]initWithFrame:CGRectMake(5, date_btn.frame.size.height+date_btn.frame.origin.y+10,div-15, 45)];
    todate_btn.layer.borderWidth=1.5;
    todate_btn.layer.cornerRadius=5;
    todate_btn.backgroundColor=[UIColor whiteColor];
    todate_btn.tag=1;
    todate_btn.clipsToBounds=YES;
    todate_btn.textColor=[ff valueForKey:@"Scrollcolor"];
    todate_btn.text=[NSString stringWithFormat:@"%@",itodate_btn];
    
    
    UITapGestureRecognizer *prev1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [prev1 setNumberOfTouchesRequired:1];
    [prev1 setDelegate:self];
    todate_btn.userInteractionEnabled = YES;
    [todate_btn addGestureRecognizer:prev1];
    [scrollbar addSubview:todate_btn];
    
    country=[[UILabel alloc]initWithFrame:CGRectMake(5, todate_btn.frame.size.height+todate_btn.frame.origin.y+10, scrollbar.frame.size.width-15, 45)];
    country.backgroundColor=[UIColor whiteColor];
    country.layer.borderWidth=2;
    country.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    country.text=[NSString stringWithFormat:@"%@",icountry];
    country.textColor=[ff valueForKey:@"Scrollcolor"];
    country.layer.cornerRadius=6;
    country.clipsToBounds=YES;
    
    [scrollbar addSubview:country];
    
    sate=[[UILabel alloc]initWithFrame:CGRectMake(5, country.frame.size.height+country.frame.origin.y+10 ,scrollbar.frame.size.width-15, 45)];
    sate.backgroundColor=[UIColor whiteColor];
    sate.layer.borderWidth=2;
    sate.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    sate.text=[NSString stringWithFormat:@"%@",isate ];
    sate.textColor=[ff valueForKey:@"Scrollcolor"];
    sate.layer.cornerRadius=6;
    sate.clipsToBounds=YES;
    
    [scrollbar addSubview:sate];
    
    
    city=[[UILabel alloc]initWithFrame:CGRectMake(5, sate.frame.size.height+sate.frame.origin.y+10,scrollbar.frame.size.width-15, 45)];
    city.backgroundColor=[UIColor whiteColor];
    city.layer.borderWidth=2;
    city.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    city.text=[NSString stringWithFormat:@"%@",icity];
    city.textColor=[ff valueForKey:@"Scrollcolor"];
    city.layer.cornerRadius=6;
    city.clipsToBounds=YES;
    [scrollbar addSubview:city];
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    
    
    location=[[UITextField alloc]initWithFrame:CGRectMake(5, city.frame.size.height+city.frame.origin.y+10, scrollbar.frame.size.width-15, 45)];
    location.backgroundColor=[UIColor whiteColor];
    location.layer.borderWidth=2;
    location.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    location.text=[NSString stringWithFormat: @"%@",ilocation];
    location.textColor=[ff valueForKey:@"Scrollcolor"];
    location.layer.cornerRadius=6;
    location.delegate=self;
    
    [scrollbar addSubview:location];
    
    My_Calender=[[UILabel alloc]initWithFrame:CGRectMake(5, location.frame.size.height+location.frame.origin.y+10,scrollbar.frame.size.width-15, 45)];
    My_Calender.backgroundColor=[UIColor whiteColor];
    My_Calender.layer.borderWidth=2;
    My_Calender.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    My_Calender.layer.cornerRadius=6;
    My_Calender.text=[NSString stringWithFormat:@"%@",iMy_Calender];
    My_Calender.textColor=[ff valueForKey:@"Scrollcolor"];
    My_Calender.clipsToBounds=-YES;
    [scrollbar addSubview:My_Calender];
    
    UITapGestureRecognizer *calreg= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showwMyCalSel)];
    [calreg setNumberOfTouchesRequired:1];
    [calreg setDelegate:self];
    My_Calender.userInteractionEnabled = YES;
    [My_Calender addGestureRecognizer:calreg];
    
    Select_color=[[UILabel alloc]initWithFrame:CGRectMake(5, My_Calender.frame.size.height+My_Calender.frame.origin.y+5, scrollbar.frame.size.width-11, 45)];
    Select_color.text=@"Select Color";
    [Select_color setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    Select_color.textColor=[UIColor blackColor];
    [scrollbar addSubview:Select_color];
    
    int sw=scrollbar.frame.size.width/9;
    int inc=5;
    
    
    colorAr=[[NSMutableArray alloc]init];
    
    NSMutableArray * color=[[NSMutableArray alloc]init];
    [color addObject:[UIColor colorWithRed:164.0/255 green:189.0/255 blue:252.0/255 alpha:1]];
    [color addObject:[UIColor colorWithRed:70.0/255 green:214.0/255 blue:219.0/255 alpha:1]];
    [color addObject:[UIColor colorWithRed:122.0/255 green:231.0/255 blue:191.0/255 alpha:1]];
    [color addObject:[UIColor colorWithRed:81.0/255 green:183.0/255 blue:73.0/255 alpha:1]];
    [color addObject:[UIColor colorWithRed:251.0/255 green:215.0/255 blue:91.0/255 alpha:1]];
    [color addObject:[UIColor colorWithRed:220.0/255 green:135.0/255 blue:132.0/255 alpha:1]];
    [color addObject:[UIColor colorWithRed:220.0/255 green:33.0/255 blue:39.0/255 alpha:1]];
    [color addObject:[UIColor colorWithRed:219.0/255 green:173.0/255 blue:255.0/255 alpha:1]];
    
    
    NSLog(@"isselec cole =====%@",iSelect_color);
    
    for(int x=0;x<8;x++)
    {
        
        UILabel *color1=[[UILabel alloc]initWithFrame:CGRectMake(inc, Select_color.frame.size.height+Select_color.frame.origin.y+2, sw-10, 30)];
        color1.backgroundColor=[color objectAtIndex:x];
        color1.tag=x;
        [scrollbar addSubview:color1];
        inc=inc+sw;
        
        [colorAr addObject:color1];
        
        
        if([iSelect_color intValue]==x)
        {
            color1.layer.borderColor=[[UIColor blackColor]CGColor];
            color1.layer.borderWidth=1;
            seletedcol=[iSelect_color intValue];
        }
        
        
        UITapGestureRecognizer *colorreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorsel:)];
        [colorreg setNumberOfTouchesRequired:1];
        [colorreg setDelegate:self];
        color1.userInteractionEnabled = YES;
        [color1 addGestureRecognizer:colorreg];
    }
    
    visibility=[[UILabel alloc]initWithFrame:CGRectMake(5,Select_color.frame.size.height+Select_color.frame.origin.y+40, div-11, 30)];
    visibility.text=@"Visibility";
    [visibility setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    visibility.textColor=[UIColor blackColor];
    [scrollbar addSubview:visibility];
    
    
    int wid=scrollbar.frame.size.width/3;
    NSMutableArray * frndAr=[[NSMutableArray alloc]init];
    [frndAr addObject:@"Friends"];
    [frndAr addObject:@"Public"];
    [frndAr addObject:@"Private"];
    int incf=5;
    int setTagsid=0;
    NSLog(@"pubpri value is =-======== %d" ,pubpri);
    for(int i=0;i<[frndAr count];i++)
    {
        frnd_btn =[[UIButton alloc]initWithFrame:CGRectMake(incf, visibility.frame.size.height+visibility.frame.origin.y+10, 18, 18)];
        frnd_btn.layer.cornerRadius=9;
        frnd_btn.backgroundColor=[UIColor whiteColor];
        [frnd_btn addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
        [frnd_btn setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        frnd_btn.tag=setTagsid;
        [scrollbar addSubview:frnd_btn];
        
        if(pubpri==0 && setTagsid==1)
        {
            onebtnpubpri=frnd_btn;
            [frnd_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        if(pubpri==1 && setTagsid==2)
        {
            onebtnpubpri=frnd_btn;
            [frnd_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        if((pubpri==2 || pubpri==3) && setTagsid==0)
        {
            onebtnpubpri=frnd_btn;
            [frnd_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
            NSLog(@"inside prive ");
        }
        frnds=[[UILabel alloc]initWithFrame:CGRectMake(frnd_btn.frame.size.width+frnd_btn.frame.origin.x+5, visibility.frame.size.height+visibility.frame.origin.y+2 ,wid-10, 35)];
        frnds.text=[frndAr objectAtIndex:i];
        frnds.textColor=[UIColor blackColor];
        [frnds setFont:[UIFont fontWithName:@"Times New Roman" size:20]];
        [scrollbar addSubview:frnds];
        
        incf=wid+incf;
        setTagsid++;
        
    }
    
    frndview = [[UIView alloc] initWithFrame:CGRectMake(0,visibility.frame.size.height+visibility.frame.origin.y+35,[SavePrefrences sharedInstance ].screenWidth,20)];
    [scrollbar addSubview:frndview];
    frndview.hidden=true;
    frndview.backgroundColor=[UIColor clearColor];
    NSMutableArray * memberAr=[[NSMutableArray alloc]init];
    [memberAr addObject:@"Cabinet Members"];
    [memberAr addObject:@"Network Members"];
    int incfx=5,widx=(scrollbar.frame.size.width/2);
    for(int i=0;i<[memberAr count];i++)
    {
        UIButton *cb_btn =[[UIButton alloc]initWithFrame:CGRectMake(incfx, 2, 18, 18)];
        cb_btn.layer.cornerRadius=9;
        cb_btn.backgroundColor=[UIColor whiteColor];
        [cb_btn addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
        [cb_btn setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        cb_btn.tag=(101+i);
        [frndview addSubview:cb_btn];
        
        
        if(pubpri==2 && i==0)
        {
            onebtncbnt=cb_btn;
            [cb_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        if(pubpri==3 && i==1)
        {
            onebtncbnt=cb_btn;
            [cb_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        UILabel *cabinet=[[UILabel alloc]initWithFrame:CGRectMake(cb_btn.frame.size.width+cb_btn.frame.origin.x+5, 0 ,widx-18, 20)];
        cabinet.text=[memberAr objectAtIndex:i];
        cabinet.textColor=[UIColor blackColor];
        [cabinet setFont:[UIFont fontWithName:@"Times New Roman" size:15]];
        cabinet.backgroundColor=[UIColor clearColor ];
        
        [frndview addSubview:cabinet];
        
        incfx=widx+incfx;
        
    }
    
    Repeat=[[UILabel alloc]initWithFrame:CGRectMake(5, frndview.frame.size.height+frndview.frame.origin.y-8, screenWidth-11, 45)];
    Repeat.text=@"Repeat";
    [Repeat setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    Repeat.textColor=[UIColor blackColor];
    [scrollbar addSubview:Repeat];
    
    
    
    
    int incy=Repeat.frame.size.height+Repeat.frame.origin.y+10;
    
    NSMutableArray *RepeatAr=[[NSMutableArray alloc]init];
    [RepeatAr addObject:@"Once"];
    [RepeatAr addObject:@"Daily"];
    [RepeatAr addObject:@"Weekly"];
    [RepeatAr addObject:@"Monthly"];
    [RepeatAr addObject:@"Yearly"];
    [RepeatAr addObject:@"Weekend"];
    
    for(int j=0; j<[RepeatAr count];j++)
    {
        
        UIButton *one_btn =[[UIButton alloc]initWithFrame:CGRectMake(5, incy, 18, 18)];
        one_btn.layer.cornerRadius=9;
        one_btn.backgroundColor=[UIColor whiteColor];
        [one_btn addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
        [one_btn setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        one_btn.tag=setTagsid;
        [scrollbar addSubview:one_btn];
        
        if(repeat==0 && setTagsid==3)
        {
            onebtntrepeat=one_btn;
            [one_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        else if(repeat==1 && setTagsid==4)
        {
            
            onebtntrepeat=one_btn;
            [one_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
            NSLog(@"daily options");
            
        }
        else if(repeat==2 && setTagsid==5)
        {   onebtntrepeat=one_btn;
            
            [one_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        else if(repeat==3 && setTagsid==6)
        { onebtntrepeat=one_btn;
            [one_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        
        else if(repeat==4 && setTagsid==7)
        {   onebtntrepeat=one_btn;
            [one_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        
        else if(repeat==5 && setTagsid==8)
        {    onebtntrepeat=one_btn;
            [one_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        
        
        
        
        lbl_once=[[UILabel alloc]initWithFrame:CGRectMake(one_btn.frame.size.width+one_btn.frame.origin.x+5, incy-5, 150, 35)];
        lbl_once.text=[RepeatAr objectAtIndex:j];
        [lbl_once setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
        lbl_once.textColor=[UIColor blackColor];
        
        [scrollbar addSubview:lbl_once];
        
        incy=incy+35;
        setTagsid++;
        
    }
    
    
    vw=[[UIView alloc]initWithFrame:CGRectMake(lbl_once.frame.size.width+lbl_once.frame.origin.x,Repeat.frame.size.height+Repeat.frame.origin.y+60,150,150)];
    vw.backgroundColor=[UIColor clearColor];
    vw.hidden=true;
    [scrollbar addSubview:vw];
    
    NSMutableArray *ardaily=[[NSMutableArray alloc]init];
    [ardaily addObject:@"Till Date"];
    [ardaily addObject:@"No. of Days"];
    [ardaily addObject:@"Enter Days"];
    [ardaily addObject:@"Enter No.of Days"];
    int dy=10;
    int k=0;
    for(int i=0;i<=1;i++)
    {
        
        btn1=[[UIButton alloc] initWithFrame:CGRectMake(5,dy,18,18)];
        btn1.layer.cornerRadius=9;
        btn1.backgroundColor=[UIColor whiteColor];
        [btn1 addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
        [btn1 setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        btn1.tag=setTagsid;
        btn1.tag=40+i;
        [vw addSubview:btn1];
        
        
        lbl1=[[UILabel alloc]initWithFrame:CGRectMake(btn1.frame.size.width+btn1.frame.origin.x+1, dy, 100, 18)];
        lbl1.text=[ardaily objectAtIndex:i];
        [lbl1 setFont:[UIFont fontWithName:@"Times New Roman" size:18]];
        lbl1.textColor=[UIColor blackColor];
        [vw addSubview:lbl1];
        k=i+2;
        
        if(dy==10)
        {
            txtcl=[[UITextField alloc]initWithFrame:CGRectMake(5, lbl1.frame.size.height+lbl1.frame.origin.y+1, 120, 30)];
            txtcl.placeholder=[ardaily objectAtIndex:k];
            txtcl.backgroundColor=[UIColor whiteColor];
            txtcl.hidden=true;
            [txtcl setFont:[UIFont fontWithName:@"Times New Roman" size:14]];
            txtcl.tag=3;
            txtcl.layer.cornerRadius=3;
            [vw addSubview:txtcl];
            
            UITapGestureRecognizer *calreg= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
            [calreg setNumberOfTouchesRequired:1];
            [calreg setDelegate:self];
            txtcl.userInteractionEnabled = YES;
            [txtcl addGestureRecognizer:calreg];
        }
        else
        {
            
            txtcl1=[[UITextField alloc]initWithFrame:CGRectMake(5, lbl1.frame.size.height+lbl1.frame.origin.y+1, 120, 30)];
            txtcl1.placeholder=[ardaily objectAtIndex:k];
            txtcl1.backgroundColor=[UIColor whiteColor];
            txtcl1.hidden=true;
            [txtcl1 setFont:[UIFont fontWithName:@"Times New Roman" size:14]];
            txtcl1.tag=24+i;
            txtcl1.layer.cornerRadius=3;
            [vw addSubview:txtcl1];
            
        }
        dy=dy+55;
    }
    
    wekendview=[[UIView alloc]initWithFrame:CGRectMake(0, incy, scrollbar.frame.size.width, 20)];
    wekendview.backgroundColor=[UIColor clearColor];
    wekendview.hidden=true;
    [scrollbar addSubview:wekendview];
    
    weekselAr=[[NSMutableArray alloc]init];
    weekdayvwAr=[[NSMutableArray alloc]init];
    
    arweek=[[NSMutableArray alloc]init];
    [arweek addObject:@"Mon"];
    [arweek addObject:@"Tue"];
    [arweek addObject:@"Wed"];
    [arweek addObject:@"Thu"];
    [arweek addObject:@"Fri"];
    [arweek addObject:@"Sat"];
    [arweek addObject:@"Sun"];
    int wdth=(scrollbar.frame.size.width-7)/7;
    int xwidth=5;
    
    for(int i=0;i<[arweek count];i++)
    {
        UILabel *weekdaylbl=[[UILabel alloc]initWithFrame:CGRectMake(xwidth, 0, wdth, 20)];
        weekdaylbl.text=[arweek objectAtIndex:i];
        [weekdaylbl setFont:[UIFont fontWithName:@"Times New Roman" size:12]];
        weekdaylbl.textAlignment=NSTextAlignmentCenter;
        weekdaylbl.backgroundColor=[UIColor whiteColor];
        weekdaylbl.layer.cornerRadius=6;
        weekdaylbl.tag=i;
        [wekendview addSubview:weekdaylbl];
        xwidth=xwidth+wdth+1;
        
        [weekdayvwAr addObject:weekdaylbl];
        
        UITapGestureRecognizer *calreg= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setselectedweek:)];
        [calreg setNumberOfTouchesRequired:1];
        [calreg setDelegate:self];
        weekdaylbl.userInteractionEnabled = YES;
        [weekdaylbl addGestureRecognizer:calreg];
        
    }
    if(repeat==5)
    {
        //        wekendview=[[UIView alloc]initWithFrame:CGRectMake(0, incy, scrollbar.frame.size.width, 20)];
        //        wekendview.backgroundColor=[UIColor clearColor];
        wekendview.hidden=false;
        //        [scrollbar addSubview:wekendview];
        //
        weekselAr=[[NSMutableArray alloc]init];
        //
        weekdayvwAr=[[NSMutableArray alloc]init];
        //
        serverweekAr=[[NSMutableArray alloc]init];
        //
        
        
        NSString * mon=[[evntArUpdate objectAtIndex:0] valueForKey:@"mon"];
        NSString * tue=[[evntArUpdate objectAtIndex:0] valueForKey:@"tue"];
        NSString * wed=[[evntArUpdate objectAtIndex:0] valueForKey:@"wed"];
        NSString * thu=[[evntArUpdate objectAtIndex:0] valueForKey:@"thu"];
        NSString * fri=[[evntArUpdate objectAtIndex:0] valueForKey:@"fri"];
        NSString * sat=[[evntArUpdate objectAtIndex:0] valueForKey:@"sat"];
        NSString * sun=[[evntArUpdate objectAtIndex:0] valueForKey:@"sun"];
        
        
        NSLog(@"sun=========%@",sun);
        NSLog(@"mon=========%@",mon);
        NSLog(@"tue=========%@",tue);
        NSLog(@"wed=========%@",wed);
        NSLog(@"thu=========%@",thu);
        NSLog(@"fri=========%@",fri);
        NSLog(@"sat=========%@",sat);
        
        if([mon intValue]==0)
        {
            NSLog(@"inside1");
            [serverweekAr addObject:@"0"];
        }
        else{
            [serverweekAr addObject:@"1"];
        }
        if([tue intValue]==0)
        {
            NSLog(@"inside2");
            [serverweekAr addObject:@"0"];
        }
        else{
            [serverweekAr addObject:@"1"];
        }
        if([wed intValue]==0)
        {
            NSLog(@"inside3");
            [serverweekAr addObject:@"0"];
        }
        else{
            [serverweekAr addObject:@"1"];
        }
        if([thu intValue]==0)
        {
            NSLog(@"inside4");
            [serverweekAr addObject:@"0"];
        }
        else{
            [serverweekAr addObject:@"1"];
        }
        if([fri intValue]==0)
        {
            NSLog(@"inside5");
            [serverweekAr addObject:@"0"];
        }
        else{
            [serverweekAr addObject:@"1"];
        }
        if([sat intValue]==0)
        {
            NSLog(@"inside6");
            [serverweekAr addObject:@"0"];
        }
        else{
            [serverweekAr addObject:@"1"];
        }
        if([sun intValue]==0)
        {
            NSLog(@"inside7");
            [serverweekAr addObject:@"0"];
        }
        else{
            [serverweekAr addObject:@"1"];
        }
        
        arweek=[[NSMutableArray alloc]init];
        [arweek addObject:@"Mon"];
        [arweek addObject:@"Tue"];
        [arweek addObject:@"Wed"];
        [arweek addObject:@"Thu"];
        [arweek addObject:@"Fri"];
        [arweek addObject:@"Sat"];
        [arweek addObject:@"Sun"];
        int wdth=(scrollbar.frame.size.width-7)/7;
        int xwidth=5;
        
        for(int i=0;i<[arweek count];i++)
        {
            UILabel *weekdaylbl=[[UILabel alloc]initWithFrame:CGRectMake(xwidth, 0, wdth, 20)];
            if([av checkNullStr:[NSString stringWithFormat:@"%@",[arweek objectAtIndex:i]]])
            {
                weekdaylbl.text=[NSString stringWithFormat:@"%@",[arweek objectAtIndex:i]];
            }
            else{
                NSLog(@"hello");
            }
            if([serverweekAr count]>0)
            {
                int yip=[[serverweekAr objectAtIndex:i]intValue];
                NSLog(@"value of yip %d",yip);
                if(yip==1)
                {
                    weekdaylbl.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
                }
                else{
                    weekdaylbl.backgroundColor=[UIColor whiteColor];
                }
                [weekdaylbl setFont:[UIFont fontWithName:@"Times New Roman" size:12]];
                weekdaylbl.textAlignment=NSTextAlignmentCenter;
                
                weekdaylbl.layer.cornerRadius=6;
                weekdaylbl.tag=i;
                [wekendview addSubview:weekdaylbl];
                xwidth=xwidth+wdth+1;
                [weekdayvwAr addObject:weekdaylbl];
            }
            UITapGestureRecognizer *calreg= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setselectedweek:)];
            [calreg setNumberOfTouchesRequired:1];
            [calreg setDelegate:self];
            weekdaylbl.userInteractionEnabled = YES;
            [weekdaylbl addGestureRecognizer:calreg];
            
        }
    }
    UILabel *Notification_type=[[UILabel alloc]initWithFrame:CGRectMake(5,incy+40,200 , 35)];
    Notification_type.text=@"Notification Type";
    [Notification_type setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    Notification_type.textColor=[UIColor blackColor];
    [scrollbar addSubview:Notification_type];
    
    NSMutableArray *notifyAr=[[NSMutableArray alloc]init];
    [notifyAr addObject:@"E-mail"];
    [notifyAr addObject:@"SMS"];
    [notifyAr addObject:@"PopUp"];
    //NSMutableArray * lablAr=[[NSMutableArray alloc]init];
    
    int hx=Notification_type.frame.size.height+Notification_type.frame.origin.y+10;
    for(int k=0;k<[notifyAr count];k++)
    {
        UIButton *email_btn =[[UIButton alloc]initWithFrame:CGRectMake(5,hx, 18, 18)];
        email_btn.layer.cornerRadius=9;
        email_btn.backgroundColor=[UIColor whiteColor];
        [email_btn addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
        [email_btn setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        email_btn.tag=setTagsid;
        
        [scrollbar addSubview:email_btn];
        if(nttype==1 && setTagsid==9)
        {
            onbtnnttype=email_btn;
            [email_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        else if(nttype==2 && setTagsid==10)
        {
            onbtnnttype=email_btn;
            [email_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        else if(nttype==3 && setTagsid==11)
        {  onbtnnttype=email_btn;
            [email_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        
        UILabel *lbl_email=[[UILabel alloc]initWithFrame:CGRectMake(email_btn.frame.size.width+email_btn.frame.origin.x+5,hx-14,scrollbar.frame.size.width/2-10, 35)];
        lbl_email.text=[notifyAr objectAtIndex:k];
        [lbl_email setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
        lbl_email.textColor=[UIColor blackColor];
        [scrollbar addSubview:lbl_email];
        
        //[lablAr addObject:lbl_email];
        never=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        never.frame=CGRectMake(lbl_email.frame.size.width+lbl_email.frame.origin.x+10,hx-5,80, 30);
        
        if(nttype==1 && k==0)
        {
            [never setTitle:notiperiod forState:UIControlStateNormal];
        }
        else if(nttype==2 && k==1)
        {
            NSLog(@"sms");
            [never setTitle:notiperiod forState:UIControlStateNormal];
        }
        else if(nttype==3 && k==2)
        {
            NSLog(@"popup");
            [never setTitle:notiperiod forState:UIControlStateNormal];
        }
        else
        {
            [never setTitle:@"Never" forState:UIControlStateNormal];
        }
        
        never.backgroundColor=[UIColor whiteColor ];
        [never setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
        [never setTitleColor:[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0]forState:UIControlStateNormal];
        never.layer.cornerRadius=6;
        never.tag=k;
        [never addTarget:self action:@selector(never:) forControlEvents:UIControlEventTouchUpInside];
        [notiVwAr addObject:never];
        
        [scrollbar addSubview:never];
        hx=hx+35;
        setTagsid++;
    }
    UILabel *desc=[[UILabel alloc]initWithFrame:CGRectMake(5, never.frame.size.height+never.frame.origin.y+10, screenWidth-10, 30)];
    desc.text=@"Description";
    [ desc setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    desc.textColor=[UIColor blackColor];
    [scrollbar addSubview:desc];
    
    description=[[UITextView alloc]initWithFrame:CGRectMake(5, desc.frame.size.height+desc.frame.origin.y+5,scrollbar.frame.size.width-10,150)];
    description.backgroundColor=[UIColor whiteColor];
    description.layer.borderWidth=2;
    description.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    description.layer.cornerRadius=6;
    description.textColor=[ff valueForKey:@"Scrollcolor"];
    description.text=[NSString stringWithFormat:@"%@",evntDec];
    description.delegate=self;
    
    
    [scrollbar addSubview:description];
    int btnx=scrollbar.frame.size.width/2;
    
    UIButton *save=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    save.frame=CGRectMake(20,description.frame.size.height+description.frame.origin.y+10 , btnx-20, 40);
    [save setTitle:@"Save" forState:UIControlStateNormal];
    [save setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    [save setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    save.layer.cornerRadius=6;
    save.tag=1;
    [save addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    
    
    save.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [scrollbar addSubview:save];
    
    UIButton *discard_btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    discard_btn.frame=CGRectMake(save.frame.size.width+save.frame.origin.x+10,description.frame.size.height+description.frame.origin.y+10 ,btnx-20, 40);
    [discard_btn setTitle:@"Discard" forState:UIControlStateNormal];
    [discard_btn setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    [discard_btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    discard_btn.layer.cornerRadius=6;
    discard_btn.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [discard_btn addTarget:self action:@selector(dissmisspop) forControlEvents:UIControlEventTouchUpInside];
    [scrollbar addSubview:discard_btn];
    
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, discard_btn.frame.origin.y+60);
}

-(void)setselectedweek:(id)sender
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    UITapGestureRecognizer * ges=(UITapGestureRecognizer *)sender;
    idd=(int)ges.view.tag;
    
    
    UILabel * lb=[weekdayvwAr objectAtIndex:idd];
    if(([weekselAr containsObject:[NSString stringWithFormat:@"%d",idd]]))
    {
        [weekselAr removeObject:[NSString stringWithFormat:@"%d",idd]];
        lb.backgroundColor=[UIColor whiteColor];
    }
    else
    {
        [weekselAr addObject:[NSString stringWithFormat:@"%d",idd]];
        lb.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
        
    }
    
    NSLog(@"week arra====%@",weekselAr);
    
}


-(void) ViewEventList:(UIViewController *)Vc:(NSMutableArray *) eventAr
{
    [self MainView:Vc :@"Events List"];
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    scrollbar.backgroundColor=[ff valueForKey:@"popupcolor"];
    EventArDat= eventAr;
    
    NSMutableArray * colorAr=[[NSMutableArray alloc]init];
   // colorAr =[[NSMutableArray alloc]init];
    
    [colorAr addObject:[UIColor colorWithRed:164.0/255 green:189.0/255 blue:252.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:70.0/255 green:214.0/255 blue:219.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:122.0/255 green:231.0/255 blue:191.0/255 alpha:1]];
    
    [colorAr addObject:[UIColor colorWithRed:251.0/255 green:215.0/255 blue:91.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:68.0/255 green:173.0/255 blue:57.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:220.0/255 green:135.0/255 blue:132.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:220.0/255 green:33.0/255 blue:39.0/255 alpha:1]];
    [colorAr addObject:[UIColor colorWithRed:219.0/255 green:173.0/255 blue:255.0/255 alpha:1]];
    
    int yinc=5;
    for(int x=0;x<[eventAr count];x++)
    {
        NSString *color= [[eventAr objectAtIndex:x] valueForKey:@"color"];
        NSString *cur= [[eventAr objectAtIndex:x] valueForKey:@"cur"];
        NSString *dt= [[eventAr objectAtIndex:x] valueForKey:@"dt"];
        NSString *event_id= [[eventAr objectAtIndex:x] valueForKey:@"event_id"];
        NSString *event_name= [[eventAr objectAtIndex:x] valueForKey:@"event_name"];
        NSString *rec_type= [[eventAr objectAtIndex:x] valueForKey:@"rec_type"];
        NSString *time= [[eventAr objectAtIndex:x] valueForKey:@"time"];
        NSString *to_date= [[eventAr objectAtIndex:x] valueForKey:@"to_date"];
        NSDate *cdate = [NSDate dateWithTimeIntervalSince1970:([cur floatValue] / 1000.0)];
        NSDate *edate = [NSDate dateWithTimeIntervalSince1970:([to_date floatValue] / 1000.0)];
        
        UILabel *bday=[[UILabel alloc]initWithFrame:CGRectMake(5, yinc,scrollbar.frame.size.width-10, 25)];
        bday.backgroundColor=[colorAr objectAtIndex:[color integerValue]-1];
        bday.text=event_name;
        [bday setFont:[UIFont fontWithName:@"Times New Roman" size:18]];
        bday.textAlignment=NSTextAlignmentCenter;
        [scrollbar addSubview:bday];
        UILabel *when=[[UILabel alloc]initWithFrame:CGRectMake(10,
                                                               bday.frame.size.height+bday.frame.origin.y+10, 60, 20)];
        when.text=@"When";
        [when setFont:[UIFont fontWithName:@"Times New Roman" size:18]];
        [scrollbar addSubview:when];
        
        UILabel *dateformat=[[UILabel alloc]initWithFrame:CGRectMake(when.frame.size.width+when.frame.origin.x+10,  bday.frame.size.height+bday.frame.origin.y+10, scrollbar.frame.size.width-130, 20)];
        [dateformat setFont:[UIFont fontWithName:@"Times New Roman" size:18]];
        dateformat.text=[NSString stringWithFormat: @"%@",cdate];
        [scrollbar addSubview:dateformat];
        
        UIImageView *attach=[[UIImageView alloc]initWithFrame:CGRectMake(dateformat.frame.size.width+dateformat.frame.origin.x+3, bday.frame.size.height+bday.frame.origin.y+10, 20, 20)];
        attach.image=[UIImage imageNamed:@"educationprofileedit.png"];
        attach.tag=[event_id intValue];
        [scrollbar addSubview:attach];
        
        UIImageView *del=[[UIImageView alloc]initWithFrame:CGRectMake(attach.frame.size.width+attach.frame.origin.x+3,bday.frame.size.height+bday.frame.origin.y+10, 20, 20)];
        del.image=[UIImage imageNamed:@"educationprofiledelete.png"];
        del.tag=[event_id intValue];
        [scrollbar addSubview:del];
        
        UITapGestureRecognizer *editreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editevent:)];
        [editreg setNumberOfTouchesRequired:1];
        [editreg setDelegate:self];
        attach.userInteractionEnabled = YES;
        [attach addGestureRecognizer:editreg];
        
        
        UITapGestureRecognizer *delreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deletecal:)];
        [delreg setNumberOfTouchesRequired:1];
        [delreg setDelegate:self];
        
        
        del.userInteractionEnabled = YES;
        [del addGestureRecognizer:delreg];
        yinc=yinc+100;
        
        
    }
    
    
    scrollbar.frame=CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y, scrollbar.frame.size.width, prMainView.frame.size.height-200) ;
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, yinc);
    
    UIView *buttonview = [[UIView alloc] initWithFrame:CGRectMake(scrollbar.frame.origin.x,scrollbar.frame.size.height+scrollbar.frame.origin.y,scrollbar.frame.size.width,50)];
    [prMainView  addSubview:buttonview];
    buttonview.backgroundColor=[ff valueForKey:@"popupcolor"];
    
    
    UIButton *new_event=[[UIButton alloc]initWithFrame:CGRectMake(10,5, buttonview.frame.size.width/2-15, 40)];
    [new_event setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    new_event.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [new_event setTitle:@"New Event" forState:UIControlStateNormal];
    [new_event setFont:[UIFont fontWithName:@"Times New Roman" size:18]];
    [new_event addTarget:self action:@selector(addnewEvent)forControlEvents:UIControlEventTouchUpInside];
    new_event.layer.cornerRadius=6;
    [new_event setClipsToBounds:YES];
    [buttonview addSubview:new_event];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake((new_event.frame.size.width+new_event.frame.origin.x)+10,5, buttonview.frame.size.width/2-15, 40)];
    [close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    close.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"Times New Roman" size:18]];
    close.layer.cornerRadius=6;
    [close setClipsToBounds:YES];
    [buttonview addSubview:close];
    
}

-(void)retrieveCalmem
{
    
    isCallBack=@"15";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic1 setObject:@"" forKey:@"bId"];
    [dic1 setObject:@"" forKey:@"mem"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"getbdInviteMem" :@"":@"":dic1 :self];
}

-(IBAction)toggle:(id)sender
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
            [self retrieveCalmem];
            
        }
        if (tappedButton.tag==2)
        {
            publicview.hidden=false;
        }
        
    }
    else if((int)tappedButton.tag==10 ||(int)tappedButton.tag==11)
    {
        NSLog(@"frnd is tapped");
        [sender   setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        [sender2  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        sender2=sender;
        
    }
    
}
-(IBAction)addnewEvent
{
    [self addEvent :vc1];
    
}

-(void)editevent:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer *)sender;
    eventId=(int)tg.view.tag;
    
    [self sendcall:eventId];
    
}
-(IBAction)editevent1:(id)sender
{
    UIButton *bt=(UIButton *)sender;
    NSLog(@"uton ytag  ==%d",(int)bt.tag);
    
    [self sendcall:(int)bt.tag];
}

-(void)sendcall:(int)eventId
{
    
    @try {
        isCallBack=@"12";
        
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",eventId] forKey:@"id"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"EventEdit" :@"":@"":dic1 :self];
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception is====%@",exception);
    }
    @finally {
        
    }
    
}

-(IBAction)deleteWeekEvent:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [self delEvent:(int)btn.tag];
}
-(void) deletecal:(id) sender
{
    
    UITapGestureRecognizer *tg=(UITapGestureRecognizer *)sender;
    deletetagid=(int)tg.view.tag;
    [self delEvent:deletetagid];
}

-(void)delEvent:(int)evd
{
    isCallBack=@"11";
    evid=evd;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",evid] forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getdelEvent" :@"":@"":dic1 :self];
}

-(IBAction)next:(id)sender
{
    av=[[AllValidationsViewController alloc]init];
    UIButton * btn=(UIButton*)sender;
    
    NSLog(@" pubpri == %d",pubpri);
    NSLog(@"repeat %d",repeat);
    NSLog(@"ntttype  %d",nttype);
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    if(pubpri==101)
    {
        pubpri=2;
    }else if (pubpri==102)
    {
        pubpri=3;
    }
    
    else if(pubpri==1)
    {
        pubpri=0;
    }else if (pubpri==2)
    {
        pubpri=1;
    }
    
    
    if(repeat==3)
    {
        repeat=0;
    }
    else if (repeat==4)
    {
        repeat=1;
    }else if (repeat==5)
    {
        repeat=2;
    }
    else if (repeat==6)
    {
        repeat=3;
    }else if (repeat==7)
    {
        repeat=4;
    }else if (repeat==8)
    {
        repeat=5;
    }
    
    if(nttype==9)
    {
        nttype=1;
    }else if (nttype==10)
    {
        nttype=2;
    }else if (nttype==11)
    {
        nttype=3;
    }
    
    
    
    
    
    NSArray* sdate = [date_btn.text componentsSeparatedByString: @"+"];
    NSString* firstBit = [sdate objectAtIndex: 0];
    
    
    NSArray* todate = [todate_btn.text componentsSeparatedByString: @"+"];
    NSString* firstBit1 = [todate objectAtIndex: 0];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    
    dateFromString = [dateFormatter dateFromString:firstBit];
    long stms = [dateFromString timeIntervalSince1970]*1000;
    
    
    
    dateFromString = [dateFormatter dateFromString:firstBit1];
    long endtm = [dateFromString timeIntervalSince1970]*1000;
    
    
    NSLog(@"notiviewar count==%lu",[notiVwAr count]);
    NSLog(@"notiviewar count==%d",nttype);
    
    
    if(nttype<0)
    {
        nttype=0;
        
    }
    
    if((int)btn.tag==0)
    {
        
        if([av checkNull:title] )
        {
            if([av checkCombo:date_btn] )
            {
                
                if( [av checkCombo:todate_btn])
                {
                    if([av checkCombo:country]&&[av checkCombo:sate]&&[av checkCombo:city]&& [av checkNull:location])
                    {
                        
                        if([av checkCombo:My_Calender])
                        {
                            if([av checkColorSelection:seletedcol])
                            {
                                
                                {
                                    isCallBack=@"14";
                                    if(repeat==40)
                                    {
                                        [dic1 setObject:txtcl.text forKey:@"till"];
                                    }
                                    else if(repeat==41)
                                    {
                                        [dic1 setObject:txtcl1.text forKey:@"times"];
                                    }
                                    if([av EventDateCompare:date_btn.text :todate_btn.text])
                                    {
                                        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
                                        [dic1 setObject:title.text forKey:@"title"];
                                        [dic1 setObject:[NSString stringWithFormat:@"%lu",stms] forKey:@"frmdate"];
                                        [dic1 setObject:[NSString stringWithFormat:@"%lu",endtm] forKey:@"todate"];
                                        [dic1 setObject:location.text forKey:@"loc"];
                                        [dic1 setObject: [NSString stringWithFormat:@"%d",pubpri ] forKey:@"visibility"];
                                        [dic1 setObject:[NSString stringWithFormat:@"%d",nttype]  forKey:@"notitype"];
                                        [dic1 setObject:[NSString stringWithFormat:@"%d",seletedcol] forKey:@"color"];
                                        [dic1 setObject:description.text forKey:@"evntdisc"];
                                        [dic1 setObject:@"0" forKey:@"vd"];
                                        NSMutableDictionary * arrdata=[[NSMutableDictionary alloc]init];
                                        
                                        for(int x=0;x<[FrndAr count];x++)
                                        {
                                            NSMutableDictionary * userObj=[[NSMutableDictionary alloc]init];
                                            [userObj setValue:[FrndAr objectAtIndex:x] forKey:@"uid"];
                                            [arrdata setValue:userObj forKey:[NSString stringWithFormat:@"i%d",x]];
                                        }
                                        
                                        [dic1 setObject:arrdata forKey:@"arrDaa"];
                                        
                                        
                                        UIButton *btn=[notiVwAr objectAtIndex:nttype-1];
                                        NSLog(@"text issssssss=====%@",btn.titleLabel.text);
                                        [dic1 setObject:btn.titleLabel.text forKey:@"notiTime"];
                                        
                                        [dic1 setObject:city.text forKey:@"city"];
                                        [dic1 setObject:country.text forKey:@"cntry"];
                                        [dic1 setObject:sate.text forKey:@"state"];
                                        [dic1 setObject:[NSString stringWithFormat:@"%d",repeat] forKey:@"repeat"];
                                        [dic1 setObject:@"day" forKey:@"key"];
                                        [dic1 setObject:cal_id forKey:@"cal"];
                                        
                                        if(repeat==5)
                                        {
                                            
                                            weekAr=[[NSMutableArray alloc]init];
                                            [weekAr addObject:@"mon"];
                                            [weekAr addObject:@"tue"];
                                            [weekAr addObject:@"wed"];
                                            [weekAr addObject:@"thu"];
                                            [weekAr addObject:@"fri"];
                                            [weekAr addObject:@"sat"];
                                            [weekAr addObject:@"sun"];
                                            
                                            NSLog(@"week sel araaa=====%@",weekselAr);
                                            
                                            
                                            for(int x=0;x<[weekAr count];x++)
                                            {
                                                if([weekselAr containsObject:[NSString stringWithFormat:@"%d",x]])
                                                {
                                                    [dic1 setValue:@"1" forKey:[weekAr objectAtIndex:x]];
                                                    
                                                    NSLog(@"ditionar of weekday=====%@",[arweek objectAtIndex:x]);
                                                }
                                                else{
                                                    [dic1 setValue:@" " forKey:[weekAr objectAtIndex:x]];
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                        [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"saveEvent" :@"":@"":dic1 :self];
                                        [prMainView removeFromSuperview];
                                        [self dissmisspop];
                                        
                                    }    }  }
                        }
                    }
                }
            }
        }
    }
    else
    {
        
        isCallBack=@"13";
        NSLog(@"event is edited");
        
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic1 setObject:title.text forKey:@"title"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",eventId] forKey:@"Eventid"];
        [dic1 setObject:[NSString stringWithFormat:@"%lu",stms] forKey:@"frmdate"];
        [dic1 setObject:[NSString stringWithFormat:@"%lu",endtm] forKey:@"todate"];
        [dic1 setObject:location.text forKey:@"loc"];
        [dic1 setObject: [NSString stringWithFormat:@"%d",pubpri ] forKey:@"visibility"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",nttype]  forKey:@"notitype"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",seletedcol] forKey:@"color"];
        [dic1 setObject:description.text forKey:@"evntdisc"];
        [dic1 setObject:@"0" forKey:@"vd"];
        NSMutableDictionary * arrdata=[[NSMutableDictionary alloc]init];
        
        for(int x=0;x<[FrndAr count];x++)
        {
            NSMutableDictionary * userObj=[[NSMutableDictionary alloc]init];
            [userObj setValue:[FrndAr objectAtIndex:x] forKey:@"uid"];
            [arrdata setValue:userObj forKey:[NSString stringWithFormat:@"i%d",x]];
        }
        
        [dic1 setObject:arrdata forKey:@"arrDaa"];
        
        
        UIButton *btn=[notiVwAr objectAtIndex:nttype-1];
        NSLog(@"text is=====%@",btn.titleLabel.text);
        [dic1 setObject:btn.titleLabel.text forKey:@"notiTime"];
        [dic1 setObject:city.text forKey:@"city"];
        [dic1 setObject:country.text forKey:@"cntry"];
        [dic1 setObject:sate.text forKey:@"state"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",repeat] forKey:@"repeat"];
        [dic1 setObject:@"day" forKey:@"key"];
        [dic1 setObject:cal_id forKey:@"cal"];
        
        
        weekAr=[[NSMutableArray alloc]init];
        [weekAr addObject:@"mon"];
        [weekAr addObject:@"tue"];
        [weekAr addObject:@"wed"];
        [weekAr addObject:@"thu"];
        [weekAr addObject:@"fri"];
        [weekAr addObject:@"sat"];
        [weekAr addObject:@"sun"];
        
        if(repeat==5)
        {
            for(int x=0;x<[weekAr count];x++)
            {
                if([weekselAr containsObject:[NSString stringWithFormat:@"%d",x]])
                {
                    [dic1 setValue:@"1" forKey:[weekAr objectAtIndex:x]];
                    
                    NSLog(@"ditionar of weekday=====%@",[arweek objectAtIndex:x]);
                }
                else{
                    [dic1 setValue:@"" forKey:[weekAr objectAtIndex:x]];
                }
                
            }
            
        }
        [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"UpdateEvent" :@"":@"":dic1 :self];
        [prMainView removeFromSuperview];
    }
    
}

-(IBAction)saveNewCal:(id)sender
{
    
    if([av checkNull:name] && [av checkNull:location])
    {
        if([av checkCombo:Select_Country_Zone] && [av checkCombo: Select_Zone])
        {
            if([av checkNulltextview:description])
            {
                if([av validateAlphabetsonly:name.text])
                {
                    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
                    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
                    [dic1 setObject:name.text forKey:@"calname"];
                    [dic1 setObject:description.text forKey:@"desc"];
                    [dic1 setObject:location.text forKey:@"lo"];
                    [dic1 setObject:[NSString stringWithFormat:@"%d",frnd] forKey:@"pub"];
                    [dic1 setObject:[NSString stringWithFormat:@"%@",czid] forKey:@"timezone"];
                    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"saveCal" :@"":@"":dic1 :vc1];
                    
                    [prMainView removeFromSuperview];}
            }
        }
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}



- (void)toggleButton: (id) sender
{
    UIButton *tappedButton = (UIButton*)sender;
    
    NSLog(@"btn tag====%d",(int)tappedButton.tag);
    
    if((int)tappedButton.tag==0||(int)tappedButton.tag==1||(int)tappedButton.tag==2)
    {
        [onebtnpubpri  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        [sender1  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        sender1=sender;
        frnd=(int)tappedButton.tag;
        pubpri=(int)tappedButton.tag;
        NSLog(@"frnd is clickewd");
        if((int)tappedButton.tag==1||(int)tappedButton.tag==2)
        {
            frndview.hidden=true;
            if((int)tappedButton.tag==2)
            {
                BoardPopUp * bpope= [[BoardPopUp alloc]init];
                [bpope reterivefrndforcal:vc1:2];
            }
        }
    }
    else if((int)tappedButton.tag>=3 && (int)tappedButton.tag<=8)
     {
        if(tappedButton.tag==3)
        {
            vw.hidden=true;
            
        }
        else{
            vw.hidden=false ;
        }
        
        if(tappedButton.tag==8)
        {
            NSLog(@"wekend view ");
            wekendview.hidden=false;
        }
        else
        {
            wekendview.hidden=true;
            [weekselAr removeAllObjects];
            for(int x=0;x<[weekdayvwAr count];x++)
            {
                UILabel * l= [weekdayvwAr objectAtIndex:x];
                l.backgroundColor=[UIColor whiteColor];
            }
            
        }
        
        [onebtntrepeat  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        [sender2  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        sender2=sender;
        repeat=(int)tappedButton.tag;
        
    }
    else if((int)tappedButton.tag>8 && (int)tappedButton.tag<=11)
    {
        [onbtnnttype  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        [sender3  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        sender3=sender;
        nttype=(int)tappedButton.tag;
        
    }
    
    else if((int)tappedButton.tag>=101 && (int)tappedButton.tag<=102)
    {
        [onebtncbnt  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        [sender4  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        sender4=sender;
        pubpri=(int)tappedButton.tag;
    }
    else if((int)tappedButton.tag>=40 &&(int)tappedButton.tag<=41)
    {
        if(tappedButton.tag==40)
        {
            txtcl.hidden=false;
            txtcl1.hidden=true;
            repeat=(int)tappedButton.tag;
        }
        else if(tappedButton.tag==41){
            
            txtcl1.hidden=false;
            txtcl.hidden=true;
            repeat=(int)tappedButton.tag;
            
        }
      
        [onebtntrepeat  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        [sender5  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        sender5=sender;
        pubpri=(int)tappedButton.tag;
        
    }
    
    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"radiounselect.png"]])
    {
        [sender  setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        if(tappedButton.tag==0)
        {
            frndview.hidden=false;
            //pubpri=-1;
        }
    }
    else
    {
        [sender  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    }
    
    
}

-(void)countrySel:(id)sender
{
    if(countryAr !=nil&&[countryAr count]>0)
    {
        [self showCountry];
    }
    else
    {
        isCallBack=@"4";
        SelectCountry * sc=[[SelectCountry alloc]init];
        [sc getCountryList:self];
    }
}

-(void)stateSel:(id)sender
{
    
    isCallBack=@"5";
    if (event.txtCountry.text.length<=0) {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Country" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        
    }
    else
    {
        SelectCountry * sc=[[SelectCountry alloc]init];
        [sc getState:self:cid];
    }
}

-(void)citySele:(id)sender
{
    if(countryAr !=nil&&[countryAr count]>0)
    {
        [self showCountry];
    }
    else
    {
        isCallBack=@"4";
        SelectCountry * sc=[[SelectCountry alloc]init];
        [sc getCountryList:self];
    }
    
}

-(void)citySel:(id)sender
{
    isCallBack=@"6";
    
    
    if(event.txtState.text.length<=0)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Country" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
       
    }
    else{
        SelectCountry * sc=[[SelectCountry alloc]init];
        [sc getCity:self:stid];
    
    }
    
}


-(void) showCountry
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Country:"preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSDictionary* dict in countryAr) {
            UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:dict[@"countryName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                            {
                                                addCalend.txtSelectCountry.text = dict[@"countryName"];
                                                event.txtCountry.text=dict[@"countryName"];
                                                addCalend.strCountryWebCode = dict[@"webcode"];
                                                //   event.txtState.text=@"Select State";
                                                // event.txtCity.text=@"Select City";
                                                cid=[NSString stringWithFormat:@"%@", dict[@"countryID"]];
                                                addCalend.strCountryId = [NSString stringWithFormat:@"%@", dict[@"countryID"]];
                                                
                                            }];
            [alert addAction:drivingAction];
        }
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:defaultAction];
        AppDelegate *appDel = [[UIApplication sharedApplication]delegate];
        [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
    });
    
}


-(void) showState
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select State:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[stateAr count];x++)
    {
        NSString *stname=[[stateAr objectAtIndex:x] valueForKey:@"stateName"];
        NSString *sid1=[[stateAr objectAtIndex:x] valueForKey:@"stateID"];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            event.txtState.text=stname;
                                            stid=sid1;
                                            //event.txtCity.text=@"Select City";
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    AppDelegate *appDel = [[UIApplication sharedApplication]delegate];
    UIViewController *controller = [self.navigationController.viewControllers lastObject];
    [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}

-(void) showCity
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select city:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[cityAr count];x++)
    {
        
        NSString *cityName=[[cityAr objectAtIndex:x] valueForKey:@"cityName"];
        NSString *cityID=[[cityAr objectAtIndex:x] valueForKey:@"cityID"];
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:cityName style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            event.txtCity.text=cityName;
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    AppDelegate *appDel = [[UIApplication sharedApplication]delegate];
    UIViewController *controller = [self.navigationController.viewControllers lastObject];
    [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

-(void)showwMyCalSel
{
    NSLog(@"my calender");
    isCallBack=@"7";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"myCalEvent" :@"":@"":dic1 :self];
    
}


-(void) showMyCalendar
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"My Calendar:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[mycalAr count];x++)
    {
        NSLog(@"hetrererer");
        
        NSString *stname=[[mycalAr objectAtIndex:x] valueForKey:@"cal_name"];
        NSString *cid1=[[mycalAr objectAtIndex:x] valueForKey:@"cal_id"];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            
                                            My_Calender.text=stname;
                                            cal_id =cid1;
                                            
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}





-(void) selcountry
{
    isCallBack=@"8";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getCountry" :@"":@"":dic1 :self];
    
    
}

-(void) showCountyzone
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Country Zone:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[zonecountAr count];x++)
    {
        
        NSString *stname=[[zonecountAr objectAtIndex:x] valueForKey:@"c_name"];
        NSString *cid1=[[zonecountAr objectAtIndex:x] valueForKey:@"c_id"];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            
                                            Select_Country_Zone.text=stname;
                                            czsid =cid1;
                                            
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}



-(void) selgetZone
{
    isCallBack=@"9";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:addCalend.strCountryWebCode forKey:@"countryCode"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"getZone" :@"":@"":dic1 :self];
}


//-(void) showtimeZone
//{
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Country Zone:"preferredStyle:UIAlertControllerStyleActionSheet];
//    for(int x=0;x<[zonetimeAr count];x++)
//    {
//        NSString *stname=[[zonetimeAr objectAtIndex:x] valueForKey:@"abbreviation"];
//        NSString *cid1=[[zonetimeAr objectAtIndex:x] valueForKey:@"time_start"];
//        NSString * tiz=[stname stringByAppendingString:[NSString stringWithFormat:@"-%@",cid1]];
//        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:tiz style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                                        {
//
//                                            Select_Time_Zone.text=tiz;
//                                            cztid=cid1;
//
//                                        }];
//        [alert addAction:drivingAction];
//    }
//
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:defaultAction];
//    [vc1 presentViewController:alert animated:YES completion:nil];
//
//}
//

//-(void) seltgetTimeZone
//{
//    isCallBack=@"10";
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    NSLog(@"czid====%@",cztid);
//
//    [dic1 setObject:czsid forKey:@"countryCode"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"getTimeZone" :@"":@"":dic1 :self];
//    NSLog(@"helll");
//}

//
//
-(void) showZone
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Time Zone:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[zoneAr count];x++)
    {
        
        NSString *stname=[[zoneAr objectAtIndex:x] valueForKey:@"time"];
        NSString *cid1=[[zoneAr objectAtIndex:x] valueForKey:@"t_id"];
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            addCalend.txtTimeZone.text=stname;
                                            addCalend.strTimeZoneId = cid1;
                                            czid=cid1;
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    AppDelegate *appDel = [[UIApplication sharedApplication]delegate];
    UIViewController *controller = [self.navigationController.viewControllers lastObject];
    [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
   // [vc1 presentViewController:alert animated:YES completion:nil];
    
}


-(void)colorsel:(id) sender
{
    
    UITapGestureRecognizer *ges= (UITapGestureRecognizer *) sender;
    for(int x=0;x<[colorAr count];x++)
    {
        UILabel * colla=[colorAr objectAtIndex: x];
        colla.layer.borderColor=[[UIColor clearColor] CGColor];
    }
    UILabel * colla=[colorAr objectAtIndex:(int)ges.view.tag];
    colla.layer.borderColor=[[UIColor blackColor] CGColor];
    colla.layer.borderWidth=1;
    
    seletedcol=(int)ges.view.tag;
    
}


-(void)addAndDelete:(UIViewController *)Vc: (int) eventId:(NSArray *)eventAr
{
    [self ViewEventList:Vc :eventAr];
}



-(void) date:(id) sender
{
    
    UITapGestureRecognizer * tg=(UITapGestureRecognizer *)sender;
    isdate=(int)tg.view.tag;
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [vc1.view addSubview:datePickerView ];
    datePickerView .backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:.5f];
    
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance].screenHeight/3, [SavePrefrences sharedInstance].screenWidth-40, 300)];
    
    datepicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    
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
    save.backgroundColor=[UIColor grayColor];
    [save addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [datePickerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor grayColor];
    [cancel addTarget:self action:@selector(nook:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancel.layer.cornerRadius=5;
    [datePickerView addSubview:cancel];
    
}




-(IBAction)ok:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"];
    if(isdate==0)
    {
        date_btn.text = [NSString stringWithFormat:@"%@",datepicker.date];
        
    }
    else
    {
        todate_btn.text = [NSString stringWithFormat:@"%@",datepicker.date];
    }
    
    if(isdate==3)
    {
        txtcl.text=[NSString stringWithFormat:@"%@",datepicker.date];
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
    int   isCallBack1=[isCallBack intValue];
    
    if (isCallBack1==4)//select Counrt
    {
        
        NSLog(@"call back in allpop");
        
        NSArray * md=[META valueForKey:@"data"];
        countryAr=[md valueForKey:@"country"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showCountry];
        });
        
    }
    else  if (isCallBack1==101)//select Counrt
    {
        
        NSLog(@"call back in allpop");
        
        NSArray * md=[META valueForKey:@"data"];
        countryAr=[md valueForKey:@"country"];
        [self showCountry];
        
    }
    else if(isCallBack1==5)
    {
        NSArray * md=[META valueForKey:@"data"];
        stateAr=[md valueForKey:@"statesData"];
        [self showState];
    }
    
    else if(isCallBack1==6)
    {
        NSArray * md=[META valueForKey:@"data"];
        cityAr=[md valueForKey:@"statesData"];
        [self showCity];
    }
    else if (isCallBack1==7)
    {
        
        NSLog(@"meta of mycal  ==%@",META);
        NSLog(@"Data of mycal  ==%@",DATA);
        mycalAr=DATA;
        [self showMyCalendar];
        
    }
    
    else if (isCallBack1==8)
    {
        NSLog(@"meta of zone   ==%@",META);
        NSLog(@"Data  of zone  ==%@",DATA);
        zonecountAr= DATA;
        [self showCountyzone];
    }
    
    else if (isCallBack1==9)
    {
        NSLog(@"meta of time zone  ==%@",META);
        NSLog(@"Data of timezone  ==%@",DATA);
        zoneAr=[DATA valueForKey:@"getCalZone"];
        [self showZone];
    }
    else if (isCallBack1==11)
    {
        for(int x=0;x<[EventArDat count];x++)
        {
            if([[[EventArDat objectAtIndex:x] valueForKey:@"event_id"] intValue] ==evid)
            {
                [EventArDat removeObjectAtIndex: x];
                [self dissmisspop];
                //                [self ViewEventList:vc1:EventArDat];
                break;
            }
            
        }
        
    }
    
    else if (isCallBack1==12)
    {
        NSArray * data= [META valueForKey:@"data"];
        evntArUpdate= [data valueForKey:@"eventData"];
        [self editEvent:vc1];
    }
    else if(isCallBack1==13)
    {
        
        [self dissmisspop];
        [self dissmisspop];
        
        
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"eventlist"];
        [backData addObject:DATA];
        
        id<CallTo_Parent>  cb= vc1;
        [cb callMethod:backData];
        
        
        
    }
    
    else if(isCallBack1==14)
    {
        [self dissmisspop];
        
    }
    
    else if (isCallBack1==15)
    {
        calmemAr=DATA;
        bpop =[[BoardPopUp alloc]init];
        [bpop calMem :vc1:calmemAr];
        
    }
    
}


-(void) ViewweekEventList:(UIViewController *)Vc:(NSArray *)dataAr
{
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    NSLog(@"array is======%@",dataAr);
    
    //    color = 4;
    //    cur = 1459967400000;
    //    dt = "7-3-2016";
    //    "event_id" = 197;
    //    "event_name" = "new event";
    //    "from_date" = 1459971060000;
    //    "rec_type" = 0;
    //    time = "1:1:0";
    //    "to_date" = 1459978260000
    
    if(colorAA==nil)
    {
        colorAA=[[NSMutableArray alloc]init];
        
        [colorAA addObject:[UIColor colorWithRed:164.0/255 green:189.0/255
                                            blue:252.0/255 alpha:1]];
        [colorAA addObject:[UIColor colorWithRed:164.0/255 green:189.0/255
                                            blue:252.0/255 alpha:1]];
        [colorAA addObject:[UIColor colorWithRed:70.0/255 green:214.0/255
                                            blue:219.0/255 alpha:1]];
        [colorAA addObject:[UIColor colorWithRed:122.0/255 green:231.0/255
                                            blue:191.0/255 alpha:1]];
        [colorAA addObject:[UIColor colorWithRed:81.0/255 green:183.0/255
                                            blue:73.0/255 alpha:1]];
        [colorAA addObject:[UIColor colorWithRed:251.0/255 green:215.0/255
                                            blue:91.0/255 alpha:1]];
        [colorAA addObject:[UIColor colorWithRed:220.0/255 green:135.0/255
                                            blue:132.0/255 alpha:1]];
        [colorAA addObject:[UIColor colorWithRed:220.0/255 green:33.0/255
                                            blue:39.0/255 alpha:1]];
        [colorAA addObject:[UIColor colorWithRed:219.0/255 green:173.0/255
                                            blue:255.0/255 alpha:1]];
    }
    
    NSString *color= [[dataAr valueForKey:@"color"] objectAtIndex:0];
    NSString *cur= [[dataAr valueForKey:@"cur"] objectAtIndex:0];
    NSString *dt= [[dataAr valueForKey:@"dt"] objectAtIndex:0];
    NSString *event_id= [[dataAr valueForKey:@"event_id"] objectAtIndex:0];
    NSString *from_date= [[dataAr valueForKey:@"from_date"] objectAtIndex:0];
    NSString *rec_type= [[dataAr valueForKey:@"rec_type"] objectAtIndex:0];
    NSString *time= [[dataAr valueForKey:@"time"] objectAtIndex:0];
    NSString *to_date= [[dataAr valueForKey:@"to_date"] objectAtIndex:0];
    
    // NSDate   *cdate = [NSDate dateWithTimeIntervalSince1970:([cur
    //floatValue] / 1000.0)];
    //NSDate   *edate = [NSDate dateWithTimeIntervalSince1970:([to_date
    //floatValue] / 1000.0)];
    
    
    NSLog(@"event idddd during  ===%@",event_id);
    
    UIColor *uc=[UIColor redColor];
    if([color intValue] >=0)
    {
        UIColor *uc=[colorAA objectAtIndex:[color intValue]];
    }
    [self MainView:Vc :@"New Event"];
    
    UILabel *when=[[UILabel alloc]initWithFrame:CGRectMake(10,
                                                           NameLabel.frame.size.height, scrollbar.frame.size.width-20, 50)];
    [when setFont:[UIFont fontWithName:@"Times New Roman" size:18]];
    when.text=[[NSString stringWithFormat: @"When    %@",dt]
               stringByAppendingString:[NSString stringWithFormat:@" %@ ",time]];
    when.layer.cornerRadius=15;
    when.backgroundColor=[UIColor whiteColor];
    [scrollbar addSubview:when];
    scrollbar.backgroundColor=[ff valueForKey:@"popupcolor"];
    
    UIButton *save = [[UIButton
                       alloc]initWithFrame:CGRectMake(35,
                                                      when.frame.size.height+when.frame.origin.y+10, scrollbar.frame.size.width/2 -40, 30)];
    [save setTitle: @"Edit" forState: UIControlStateNormal];
    save.tag=[event_id intValue];
    save.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [save addTarget:self action:@selector(editevent1:)
   forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [scrollbar  addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10,
                                                                 when.frame.size.height+when.frame.origin.y+10, scrollbar.frame.size.width/2 -40, 30)];
    [cancel setTitle: @"Delete" forState: UIControlStateNormal];
    cancel.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [cancel addTarget:self action:@selector(deleteWeekEvent:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancel.layer.cornerRadius=5;
    cancel.tag=[event_id intValue];
    [scrollbar addSubview:cancel];
    
    NameLabel.backgroundColor=uc;
    closeView.backgroundColor=uc;
    close.backgroundColor=uc;
    scrollbar.frame=CGRectMake( 20,
                               NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences
                                                                                      sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance
                                                                                                                        ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences
                                                                                                                                                                                   sharedInstance ].stbarHght+450));
    [scrollbar setContentSize:CGSizeMake(scrollbar.frame.size.width,
                                         scrollbar.frame.size.height)];
    
}







-(IBAction) never:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Interval:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[emailIntervalAr count];x++)
    {
        
        NSString *timeinterval=[emailIntervalAr objectAtIndex:x];
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:timeinterval style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            [btn setTitle: timeinterval forState: UIControlStateNormal];
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
    
}


-(void) didPressSelectTimezone:(id)obj{
    addCalend = (AddCalend *)obj;
    if (addCalend.strCountryId ==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Country first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        [self selgetZone];  
    }
}


-(void)privatefrndAr:(NSMutableArray *)frAr
{
    FrndAr=frAr;
}






@end
