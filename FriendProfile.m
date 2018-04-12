

#import "FriendProfile.h"
#import "ManageArray.h"
#import "SavePrefrences.h"
#import "AllValidationsViewController.h"
#import "SelectCountry.h"
#import "AllPopUp.h"
#import "LeftRightDrawer.h"

@interface FriendProfile ()
{
    NSString *imgBuffer,*cid,*stid,*cityid;
    NSString *randomImgName;
    UIImageView *imggeter;
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIScrollView *scrollView;
    NSMutableArray *selLabAr;
    ManageArray *mang;
    UIScrollView *mainScrollView1;
    UIAlertView *alrt;
    UIView *prMainView;
    NSMutableArray *eduAr,*employmntAr,*certificationAr,*awardAr,*stateAr,*cityAr;
    UITextField *name,*address,*board,*marks,*stream,*subjects;
    UILabel *country,*sate,*year,*city;
    AllValidationsViewController *av;
    int selId;
    LeftRightDrawer *drw;
    AllPopUp *app;
    NSMutableArray * linebarAr;
    int selectedTab,awardId,EmployId,EducId,CertID;
    NSMutableArray *coloAr;
}

@end

@implementation FriendProfile
 @synthesize ProfileAr,scrollCtSt,countryAr,isCallBack,isFrndtab,frnduid;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [self.
     navigationController setNavigationBarHidden:NO animated:NO];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    naviWidth = self.navigationController.navigationBar.frame.size.width;
    naviHght =  self.navigationController.navigationBar.frame.size.height;
    stbarHght= (float)[[UIApplication sharedApplication] statusBarFrame].size.height;
    
    mang=[[ManageArray alloc]init];
    av=[[AllValidationsViewController alloc]init];
//    drw=[[LeftRightDrawer alloc]init];
    
    
  /*  UILabel *Toplbl = [[UILabel alloc]initWithFrame:CGRectMake(120,0,200,40)];
    Toplbl.font = [UIFont systemFontOfSize:25];
    Toplbl.numberOfLines = 1;
    Toplbl.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    Toplbl.adjustsFontSizeToFitWidth = YES;
    Toplbl.minimumScaleFactor = 10.0f/12.0f;
    Toplbl.clipsToBounds = YES;
    Toplbl.backgroundColor = [UIColor clearColor];
    Toplbl.textColor = [UIColor whiteColor];
    Toplbl.textAlignment = NSTextAlignmentLeft;
    Toplbl.text = @"Proyolk";*/
    
    UIImageView *logo =[[UIImageView alloc]initWithFrame:CGRectMake(120,0,150,50)];
    logo.image = [UIImage imageNamed:@"logo_new.png"];
    logo.backgroundColor=[UIColor clearColor];

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:182.0/255 green:182.0/255 blue:182.0/255 alpha:1];
    [self.navigationController.navigationBar addSubview:logo];
    self.navigationController.navigationBar.barTintColor =[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    self.navigationController.navigationBar.backgroundColor =[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];

    UIView *navBarLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.frame), CGRectGetWidth(self.navigationController.navigationBar.frame), 2)];
    navBarLineView.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:255.0/255 alpha:1];
    [self.navigationController.navigationBar addSubview:navBarLineView];

    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    
    [self showTabs];
    
    if([isFrndtab isEqualToString:@"0"])
    {
        [self showProfile];
    }
    if([isFrndtab isEqualToString:@"1"])
    {
        [self educationDetail];
    }
    if([isFrndtab isEqualToString:@"2"])
    {
        [self calForEmployement];
    }
    
    if([isFrndtab isEqualToString:@"3"])
    {
        [self calForCertification];
    }
    if([isFrndtab isEqualToString:@"4"])
    {
        [self calForAward];
    }
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}
-(void)viewWillDisappear:(BOOL)animated
{
    if([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        [[self navigationController]setNavigationBarHidden:YES];
    }
    [super viewWillDisappear:animated];
    
}

#pragma mark showTabs

-(void) showTabs
{
    NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
    
    selLabAr=[[NSMutableArray alloc]init];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, naviHght+stbarHght, screenWidth, 50)];
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.backgroundColor=[cc valueForKey:@"bodycolor"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    int scrollWidth = 120;
    [self.view addSubview:scrollView];
    
    NSMutableArray *tabAr=[[NSMutableArray alloc]init];
    [tabAr addObject:@"  Profile"];
    [tabAr addObject:@" Education"];
    [tabAr addObject:@"Employment "];
    [tabAr addObject:@"Certificates"];
    [tabAr addObject:@"  Awards"];
    
    
   /* Profile Color:- 121:185:164 [UIColor colorWithRed:121.0/255.0 green:185.0/255.0 blue:164.0/255.0 alpha:1]
    Education Color:- 143:151:93 [UIColor colorWithRed:143.0/255.0 green:151.0/255.0 blue:93.0/255.0 alpha:1]
    Employment Color:- 189:162:226 [UIColor colorWithRed:189.0/255.0 green:162.0/255.0 blue:226.0/255.0 alpha:1]
    Certificate Color:- 131:168:210 [UIColor colorWithRed:131.0/255.0 green:168.0/255.0 blue:210.0/255.0 alpha:1]
    Award Color:- 233:181:175 [UIColor colorWithRed:233.0/255.0 green:181.0/255.0 blue:175.0/255.0 alpha:1]
    
    */
    
    
    coloAr=[[NSMutableArray alloc]init];
    
  /*  [coloAr addObject:[cc valueForKey:@"Profcolor"]];
    [coloAr addObject:[cc valueForKey:@"Educolor"]];
    [coloAr addObject:[cc valueForKey:@"Emplcolor"]];
    [coloAr addObject:[cc valueForKey:@"Certcolor"]];
    [coloAr addObject:[cc valueForKey:@"Awardscolor"]];*/
    
    [coloAr addObject:[UIColor colorWithRed:121.0/255.0 green:185.0/255.0 blue:164.0/255.0 alpha:1]];
    [coloAr addObject:[UIColor colorWithRed:143.0/255.0 green:151.0/255.0 blue:93.0/255.0 alpha:1]];
    [coloAr addObject:[UIColor colorWithRed:189.0/255.0 green:162.0/255.0 blue:226.0/255.0 alpha:1]];
    [coloAr addObject:[UIColor colorWithRed:131.0/255.0 green:168.0/255.0 blue:210.0/255.0 alpha:1]];
    [coloAr addObject:[UIColor colorWithRed:233.0/255.0 green:181.0/255.0 blue:175.0/255.0 alpha:1]];

    int xOffset = 0;
    
    
    
    linebarAr=[[NSMutableArray alloc]init];
    
    
    
    for(int x=0;x<[tabAr count];x++)
    {
        
        UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(xOffset, 0, 130, 45)];
        view.backgroundColor=[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:255.0/255.0 alpha:1];
        view.layer.borderColor = [UIColor grayColor].CGColor;
        [scrollView addSubview:view];
        view.tag=x;
        
        
        UILabel *labname=[[UILabel alloc]initWithFrame:CGRectMake(25, 13, view.frame.size.width, 20)];
        labname.textColor=[coloAr objectAtIndex:x];
        labname.font=[UIFont boldSystemFontOfSize:16];
        labname.text=[tabAr objectAtIndex:x];
        labname.textAlignment=NSTextAlignmentLeft;
        labname.tag=x;
        [view addSubview:labname];
        [selLabAr addObject:labname];
        
        
        UILabel *linelab=[[UILabel alloc]initWithFrame:CGRectMake(xOffset, view.frame.size.height+view.frame.origin.y, view.frame.size.width,3)];
        linelab.backgroundColor=[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:255.0/255.0 alpha:1];//[coloAr objectAtIndex:x];
        linelab.font=[UIFont boldSystemFontOfSize:16];
        linelab.tag=x;
        [scrollView addSubview:linelab];
        [linebarAr addObject:linelab];
        
        
        
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedTab:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [tapRecognizer setDelegate:self];
        labname.userInteractionEnabled = YES;
        [labname addGestureRecognizer:tapRecognizer];
        
        scrollView.contentSize = CGSizeMake(scrollWidth+xOffset,scrollView.frame.size.height);
        xOffset += 130;
    }
    
    [mainScrollView1 removeFromSuperview];
    int scpos= [isFrndtab intValue];
    UILabel *vw=[selLabAr objectAtIndex:scpos];
    
    if(scpos==0)
    {
        [scrollView setContentOffset:CGPointMake(0, 0)];
        
        [self changeBar:0];
        [self showProfile];
    }
    
    else  if(scpos==1)
    {
        [scrollView setContentOffset:CGPointMake(100, 0)];
        [self changeBar:1];
        [self educationDetail];
    }
    else  if(scpos==2)
    {
        [scrollView setContentOffset:CGPointMake(200, 0)];
        [self changeBar:2];
        [self calForEmployement];
    }
    else  if(scpos==3)
    {
        [scrollView setContentOffset:CGPointMake(250, 0)];
        [self changeBar:3];
        [self calForCertification];
    }
    else if(scpos==4)
    {
        [scrollView setContentOffset:CGPointMake(260, 0)];
        [self changeBar:4];
        
        [self calForAward];
    }
    
//
}



-(void)changeBar:(int)x1
{
    
    NSLog(@"change bar===%d",x1);
    
    for(int x=0;x<[linebarAr count];x++)
    {
        UILabel *lab=[linebarAr objectAtIndex:x];
        if(x1==x)
        {
           // lab.backgroundColor =[UIColor whiteColor];
            lab.backgroundColor =[coloAr objectAtIndex:x];
        }
        else
        {
           // lab.backgroundColor =[coloAr objectAtIndex:x];
            lab.backgroundColor =[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];

        }
    }
    
}

-(void)selectedTab:(id) sender
   {
     
    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
    long idd =  ges.view.tag;
    
    for(int x=0;x<[selLabAr count];x++)
    {
        UILabel *vw=[selLabAr objectAtIndex:x];
    }
    
    [mainScrollView1 removeFromSuperview];
    if(idd==0)
    {
        [self changeBar:0];
        [self showProfile];
    }
    
    else  if(idd==1)
    {
        [self changeBar:1];
        [self educationDetail];
    }
    else  if(idd==2)
    {
        
        [self changeBar:2];
        [self calForEmployement];
    }
    else  if(idd==3)
    {
        [self changeBar:3];
        [self calForCertification];
    }
    else if(idd==4)
    {
        [self changeBar:4];
        [self calForAward];
    }
    
    
    
}
#pragma mark showProfile

-(void) showProfile
{
    app=[[AllPopUp alloc]init];
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
    NSMutableDictionary *bc=[SavePrefrences sharedInstance].colorDictionry;
    mainScrollView1.backgroundColor=[bc valueForKey:@"bodycolor"];
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
    [self.view addSubview:mainScrollView1];
    
    isCallBack=@"19";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%@",frnduid] forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"showProfile" :@"":@"":dic1 :self];
    
    
}
-(void )addProfileimage:(NSArray*)ProfileAr1
{
    ProfileAr=ProfileAr1;
    self.navigationController.navigationBar.backgroundColor =[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    
    UIView * imageview=[[UIView alloc] initWithFrame:CGRectMake(10, 50, mainScrollView1.frame.size.width-20, 100)];
    imageview.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    //imageview.layer.cornerRadius=30;
    [mainScrollView1 addSubview:imageview];
    
    
    imggeter=[[UIImageView alloc] initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, 20, 100, 100)];
    imggeter.layer.backgroundColor=[[UIColor clearColor] CGColor];
    imggeter.layer.cornerRadius=50;
    imggeter.layer.borderWidth=2.5;
    imggeter.layer.masksToBounds = YES;
    imggeter.layer.borderColor=[[UIColor colorWithRed:217.0f/255.0f green:179.0f/255.0f blue:27.0f/255.0f alpha:1.0f]  CGColor];
    [mainScrollView1 addSubview:imggeter];
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOption)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    imggeter.userInteractionEnabled = YES;
    [imggeter addGestureRecognizer:tapRecognizer];
    
    NSString *img=[[ProfileAr valueForKey:@"img"] objectAtIndex:0];
    NSString * url=[mang concatUrl:img];
     [imggeter sd_setImageWithURL:[NSURL URLWithString:url]];
    
//    if(url.length<12)
//    {
//        imggeter.image = [UIImage imageNamed:@"username.png"];
//    }
//    else
//    {
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//        
//        if (imageData.length<=0)
//            imggeter.image = [UIImage imageNamed:@"username.png"];
//        else
//            imggeter.image = [UIImage imageWithData:imageData];
//    }
    
    imggeter.userInteractionEnabled = YES;
    UILabel *NameLabel=[[UILabel alloc] initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, imggeter.frame.origin.y+imggeter.frame.size.height+8, 100, 22)];

    if([mang checkStringNull:[[ProfileAr valueForKey:@"fname"] objectAtIndex:0]])
    {
        NameLabel.text=[[ProfileAr valueForKey:@"fname"] objectAtIndex:0];
    }
    
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
    NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];;
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [mainScrollView1 addSubview:NameLabel];
    
    //here line below name
    int w =self.view.frame.size.width/2;
    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(w/2+w/4+5, NameLabel.frame.size.height+NameLabel.frame.origin.y+4, w/2-10, 1.25)];
    lblLine.backgroundColor=[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    [mainScrollView1 addSubview:lblLine];

    UILabel *location=[[UILabel alloc] initWithFrame:CGRectMake(0,lblLine.frame.size.height+lblLine.frame.origin.y+4, self.view.frame.size.width, 22)];//imageview.frame.size.width-100)/2, NameLabel.frame.origin.y+NameLabel.frame.size.height, 140, 15)];
    if([mang checkStringNull:[[ProfileAr valueForKey:@"email"] objectAtIndex:0]])
    {
        location.text=[[ProfileAr valueForKey:@"email"] objectAtIndex:0];
    }
    location.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
    location.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    location.textAlignment=NSTextAlignmentCenter;
    [mainScrollView1 addSubview:location];
    
    [self showProfileDetail:imageview];
    
}
-(void)showProfileDetail:(UIView *)imgvw
{
    UIView * abouview=[[UIView alloc] initWithFrame:CGRectMake(0,imgvw.frame.size.height+imgvw.frame.origin.y+40, mainScrollView1.frame.size.width, 130)];
    abouview.backgroundColor=[UIColor colorWithRed:233.0f/255 green:234.0f/255 blue:245.0f/255 alpha:1.0f];//
    [mainScrollView1 addSubview:abouview];
    
    UILabel *lineGray=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScrollView1.frame.size.width,2)];
    lineGray.backgroundColor=[UIColor colorWithRed:126.0f/255 green:184.0f/255 blue:230.0f/255 alpha:0.50f];
    //[mainScrollView1 addSubview:lineGray];
    
    UITextView *aboutme=[[UITextView alloc] initWithFrame:CGRectMake(10, 10, abouview.frame.size.width-20, 110)];
    if([mang checkStringNull:[[ProfileAr valueForKey:@"about"] objectAtIndex:0]])
    {
        aboutme.text=[[ProfileAr valueForKey:@"about"] objectAtIndex:0];
    }
    aboutme.placeholder = @"about";
    aboutme.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    aboutme.textColor=[UIColor colorWithRed:128.0f/255 green:128.0f/255 blue:128.0f/255 alpha:1.0f];//[UIColor whiteColor];
    aboutme.textAlignment=NSTextAlignmentLeft;
    aboutme.backgroundColor=[UIColor clearColor];
    aboutme.editable=NO;
    
    [abouview addSubview:aboutme];
    
    UILabel *lineBelowDemo2=[[UILabel alloc]initWithFrame:CGRectMake(0, abouview.frame.size.height+abouview.frame.origin.y+40, mainScrollView1.frame.size.height+3, 1)];
    lineBelowDemo2.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:0.50f];
    [mainScrollView1 addSubview:lineBelowDemo2];
    

    
    NSMutableDictionary *txt=[SavePrefrences sharedInstance].colorDictionry;

    UIView * demographic=[[UIView alloc] initWithFrame:CGRectMake(10, abouview.frame.size.height+abouview.frame.origin.y+10, mainScrollView1.frame.size.width/3.33, 145)];
    demographic.backgroundColor=[UIColor clearColor];
    demographic.clipsToBounds=YES;
    [mainScrollView1 addSubview:demographic];
    
    
    UILabel *demolab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, demographic.frame.size.width, 30)];
    demolab.text=@"Demographics";
    demolab.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    demolab.textColor=[UIColor colorWithRed:128.0f/255 green:128.0f/255 blue:128.0f/255 alpha:1.0f];//[UIColor whiteColor];
    demolab.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"Videocolor"];
    demolab.layer.cornerRadius=10;
    demolab.textAlignment=NSTextAlignmentLeft;
    [demographic addSubview:demolab];
    
    
    UILabel *name1=[[UILabel alloc] initWithFrame:CGRectMake(0, demolab.frame.size.height+demolab.frame.origin.y+5, demographic.frame.size.width, 20)];
    NSString *fname=[[ProfileAr objectAtIndex:0] valueForKey:@"fname"];
    NSString *lname=[[ProfileAr objectAtIndex:0] valueForKey:@"lname"];
    if([mang checkStringNull:fname]&&[mang checkStringNull:lname])
    {
        name1.text=[fname stringByAppendingString:[@" " stringByAppendingString:lname]];
        
    }
    name1.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    name1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    name1.textAlignment=NSTextAlignmentLeft;
    [demographic addSubview:name1];
    
    UILabel *male=[[UILabel alloc] initWithFrame:CGRectMake(0, name1.frame.size.height+name1.frame.origin.y, demographic.frame.size.width, 20)];
    if([mang checkStringNull:[[ProfileAr valueForKey:@"gender"] objectAtIndex:0]])
    {
        
        if([[[ProfileAr valueForKey:@"gender"]objectAtIndex:0] intValue]==0)
        {
            male.text=@"Male";
        }
        else{
            male.text=@"Female";
        }
    }
    male.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    male.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    male.textAlignment=NSTextAlignmentLeft;
    [demographic addSubview:male];
    
    UILabel *dob=[[UILabel alloc] initWithFrame:CGRectMake( 0, male.frame.size.height+male.frame.origin.y, demographic.frame.size.width, 20)];
    
    if([mang checkStringNull:[[ProfileAr valueForKey:@"dob"] objectAtIndex:0]])
    {
        dob.text=[[ProfileAr valueForKey:@"dob"] objectAtIndex:0];
    }
    
    dob.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    dob.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    dob.textAlignment=NSTextAlignmentLeft;
//    [demographic addSubview:dob];
    
    UILabel *stus=[[UILabel alloc] initWithFrame:CGRectMake( 0, dob.frame.size.height+dob.frame.origin.y, demographic.frame.size.width, 20)];
    stus.text=@"Married";//relationship  1
    NSString *io = [[ProfileAr valueForKey:@"relationship"] objectAtIndex:0];
    
    if (![io isEqual:[NSNull null]])
    {
        int dd=[io intValue];
        if(dd==0)
        {
            stus.text=@"Single";//relationship  1
        }
        
    }
    stus.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    stus.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    stus.textAlignment=NSTextAlignmentLeft;
//    [demographic addSubview:stus];
    
    
    //=====================
    
    UIView * about=[[UIView alloc] initWithFrame:CGRectMake(demographic.frame.size.width+demographic.frame.origin.x+10, abouview.frame.size.height+abouview.frame.origin.y+10, mainScrollView1.frame.size.width/3.33+5, 145)];
    about.backgroundColor=[UIColor clearColor];//[abot valueForKey:@"backcolor"];
    [mainScrollView1 addSubview:about];
    
    UILabel *abt=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, about.frame.size.width, 30)];
    abt.text=@"Address";
    abt.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    abt.backgroundColor=[UIColor clearColor];
    abt.textColor=[UIColor colorWithRed:128.0f/255 green:128.0f/255 blue:128.0f/255 alpha:1.0f];//[UIColor whiteColor];
    abt.textAlignment=NSTextAlignmentLeft;
    [about addSubview:abt];
    
    
    UILabel *address1=[[UILabel alloc] initWithFrame:CGRectMake( 0, abt.frame.size.height+abt.frame.origin.y+5, about.frame.size.width, 20)];
    if([mang checkStringNull:[[ProfileAr valueForKey:@"address"] objectAtIndex:0]])
    {
        address1.text=[[ProfileAr valueForKey:@"address"] objectAtIndex:0];
    }
    
    address1.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    address1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    address1.textAlignment=NSTextAlignmentLeft;
    [about addSubview:address1];
    
    
    UILabel *city1=[[UILabel alloc] initWithFrame:CGRectMake( 0, address1.frame.size.height+address1.frame.origin.y, about.frame.size.width, 20)];
    if([mang checkStringNull:[[ProfileAr valueForKey:@"city"] objectAtIndex:0]])
    {
       // city1.text=[[ProfileAr valueForKey:@"city"] objectAtIndex:0];
        
        NSString* result = [[[ProfileAr valueForKey:@"city"] objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        city1.text=result;

    }
    
    city1.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    city1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    city1.textAlignment=NSTextAlignmentLeft;
    [about addSubview:city1];
    
    UILabel *state=[[UILabel alloc] initWithFrame:CGRectMake( 0, city1.frame.size.height+city1.frame.origin.y, about.frame.size.width, 20)];
    
    if([mang checkStringNull:[[ProfileAr valueForKey:@"state"] objectAtIndex:0]])
    {
        //state.text=[[ProfileAr valueForKey:@"state"] objectAtIndex:0];
        NSString* result = [[[ProfileAr valueForKey:@"state"] objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        state.text=result;

    }
    state.font=[UIFont systemFontOfSize:11];
    state.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    state.textAlignment=NSTextAlignmentLeft;
    [about addSubview:state];
    
    UILabel *county=[[UILabel alloc] initWithFrame:CGRectMake( 0, state.frame.size.height+state.frame.origin.y, about.frame.size.width, 20)];
    if([mang checkStringNull:[[ProfileAr valueForKey:@"country"] objectAtIndex:0]])
    {
      //  county.text=[[ProfileAr valueForKey:@"country"] objectAtIndex:0];
        
        NSString* result = [[[ProfileAr valueForKey:@"country"] objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        county.text=result;

    }
    county.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    county.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    county.textAlignment=NSTextAlignmentLeft;
    [about addSubview:county];
    
    
    //=======================
    UIView * contact=[[UIView alloc] initWithFrame:CGRectMake(demographic.frame.size.width+demographic.frame.origin.x+10+demographic.frame.size.width+demographic.frame.origin.x-4, abouview.frame.size.height+abouview.frame.origin.y+10, mainScrollView1.frame.size.width/3.33, 145)];
    contact.backgroundColor=[UIColor clearColor];
    contact.clipsToBounds=YES;
    [mainScrollView1 addSubview:contact];
    
    UILabel *ctc=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, contact.frame.size.width, 30)];
    ctc.text=@"Contact";
    ctc.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    ctc.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"Videocolor"];
    ctc.textColor=[UIColor colorWithRed:128.0f/255 green:128.0f/255 blue:128.0f/255 alpha:1.0f];//[UIColor whiteColor];
    ctc.textAlignment=NSTextAlignmentCenter;
    [contact addSubview:ctc];
    
    UILabel *mob=[[UILabel alloc] initWithFrame:CGRectMake( 0, ctc.frame.size.height+ctc.frame.origin.y+5, contact.frame.size.width, 20)];
    mob.text=[NSString stringWithFormat:@"%@",[[ProfileAr objectAtIndex:0] valueForKey:@"phone_no"]];
    mob.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    mob.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    mob.textAlignment=NSTextAlignmentRight;
    [contact addSubview:mob];
    
    UILabel *phno=[[UILabel alloc] initWithFrame:CGRectMake( 0, mob.frame.size.height+mob.frame.origin.y+5, contact.frame.size.width, 20)];
    
    if([mang checkStringNull:[[ProfileAr valueForKey:@"mobile_no"] objectAtIndex:0]])
    {
        phno.text=[NSString stringWithFormat:@"%@",[[ProfileAr valueForKey:@"mobile_no"] objectAtIndex:0]];
    }
    
    phno.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    phno.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    phno.textAlignment=NSTextAlignmentRight;
    [contact addSubview:phno];
    
    UILabel *email=[[UILabel alloc] initWithFrame:CGRectMake( 0, phno.frame.size.height+phno.frame.origin.y, contact.frame.size.width, 20)];
    if([mang checkStringNull:[[ProfileAr valueForKey:@"email"] objectAtIndex:0]])
    {
        email.text=[[ProfileAr valueForKey:@"email"] objectAtIndex:0];
    }
    email.font=[UIFont fontWithName:@"HelveticaNeue" size:9];
    email.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    email.textAlignment=NSTextAlignmentRight;
    [contact addSubview:email];
    
    
    
    
    
   /* UIView * soicn=[[UIView alloc] initWithFrame:CGRectMake(10, contact.frame.size.height+contact.frame.origin.y+10, mainScrollView1.frame.size.width-20, 200)];
    NSMutableDictionary *sc=[SavePrefrences sharedInstance].colorDictionry;
    soicn.backgroundColor=[sc valueForKey:@"backcolor"];
    soicn.layer.borderColor=[[UIColor whiteColor]CGColor];
    soicn.layer.borderWidth=2;
    soicn.clipsToBounds=YES;
    soicn.layer.cornerRadius=5;
    [mainScrollView1 addSubview:soicn];
    
    
    
    UILabel *smd=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, soicn.frame.size.width, 30)];
    smd.text=@" Social Media";
    smd.font=[UIFont systemFontOfSize:18];
    smd.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"Videocolor"];
    smd.layer.cornerRadius=10;
    smd.textColor=[UIColor whiteColor];
    smd.textAlignment=NSTextAlignmentLeft;
    [soicn addSubview:smd];
    
    
    
    NSString *fb= [[ProfileAr objectAtIndex:0] valueForKey:@"fcbkid"] ;
    NSString *tw= [[ProfileAr objectAtIndex:0] valueForKey:@"twitter_id"] ;
    NSString *ln= [[ProfileAr objectAtIndex:0] valueForKey:@"linkedin_id"] ;
    NSString *gog= [[ProfileAr objectAtIndex:0] valueForKey:@"google_id"] ;
    NSString *vimo= [[ProfileAr objectAtIndex:0] valueForKey:@"vimeo_id"] ;
    
    int yinc=smd.frame.size.height+smd.frame.origin.y+6;
    if(![fb isEqual:[NSNull null]])
    {
        
        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
        icon.backgroundColor=[UIColor blackColor] ;
        icon.image = [UIImage imageNamed:@"fb.png"];
        [soicn addSubview:icon];
        
        
        UILabel *fb1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, soicn.frame.size.width, 20)];
        fb1.text=fb;
        fb1.font=[UIFont systemFontOfSize:14];
        fb1.textColor=[txt valueForKey:@"Tabstextcolor"];
        fb1.textAlignment=NSTextAlignmentLeft;
        [soicn addSubview:fb1];
        yinc=fb1.frame.size.height+fb1.frame.origin.y+5;
        
    }
    
    if(![tw isEqual:[NSNull null]])
    {
        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
        icon.backgroundColor=[UIColor blackColor] ;
        icon.image = [UIImage imageNamed:@"twitter.png"];
        [soicn addSubview:icon];
        
        UILabel *tw1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, 150, 20)];
        tw1.text=tw;
        tw1.font=[UIFont systemFontOfSize:14];
        tw1.textColor=[txt valueForKey:@"Tabstextcolor"];
        tw1.textAlignment=NSTextAlignmentLeft;
        [soicn addSubview:tw1];
        yinc=tw1.frame.size.height+tw1.frame.origin.y+5;
        
    }
    
    if(![ln isEqual:[NSNull null]])
    {
        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
        icon.backgroundColor=[UIColor blackColor] ;
        icon.image = [UIImage imageNamed:@"in.png"];
        [soicn addSubview:icon];
        
        UILabel *ln1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, 150, 20)];
        ln1.text=ln;
        ln1.font=[UIFont systemFontOfSize:14];
        ln1.textColor=[txt valueForKey:@"Tabstextcolor"];
        ln1.textAlignment=NSTextAlignmentLeft;
        [soicn addSubview:ln1];
        yinc=ln1.frame.size.height+ln1.frame.origin.y+5;
    }
    if(![gog isEqual:[NSNull null]])
    {
        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
        icon.backgroundColor=[UIColor blackColor] ;
        icon.image = [UIImage imageNamed:@"google.png"];
        [soicn addSubview:icon];
        
        UILabel *gog1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, 150, 20)];
        gog1.text=gog;
        gog1.font=[UIFont systemFontOfSize:14];
        gog1.textColor=[txt valueForKey:@"Tabstextcolor"];
        gog1.textAlignment=NSTextAlignmentLeft;
        [soicn addSubview:gog1];
        yinc=gog1.frame.size.height+gog1 .frame.origin.y+5;
    }
    if(![vimo isEqual:[NSNull null]])
    {
        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
        icon.backgroundColor=[UIColor clearColor] ;
        icon.image = [UIImage imageNamed:@"vimeo1.png"];
        [soicn addSubview:icon];
        
        UILabel *vimo1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, 150, 20)];
        vimo1.text=vimo;
        vimo1.font=[UIFont systemFontOfSize:14];
        vimo1.textColor=[txt valueForKey:@"Tabstextcolor"];
        vimo1.textAlignment=NSTextAlignmentLeft;
        [soicn addSubview:vimo1];
        
        
    }*/
   // mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,980);
    mainScrollView1.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, contact.frame.size.height+contact.frame.origin.y+20);

}

-(IBAction)addProfile:(id)sender
{
    isCallBack=@"18";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%@",frnduid]forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"showProfilePop" :@"" :@"" :dic1 :self ];
    
    
    
}

-(void) educationDetail
{
    selectedTab=1;
    
    isCallBack=0;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[NSString stringWithFormat:@"%@",frnduid]forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Education" :@"showEdu" :@"":@"":dic1 :self];
}

#pragma mark showEducation
-(void) showEducation
{
    NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
    
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
    mainScrollView1.backgroundColor=[cc valueForKey:@"bodycolor"];
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight-20);
    [self.view addSubview:mainScrollView1];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 1)];
    [mainScrollView1 addSubview:save];

    
    int yinc=save.frame.size.height+save.frame.origin.y+20;
    for(int x=0;x<[eduAr count];x++)
    {
        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(0, yinc, mainScrollView1.frame.size.width, 180)];
        edu.backgroundColor=[cc valueForKey:@"backcolor"];
        [mainScrollView1 addSubview:edu];
        
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, edu.frame.size.width-50, 30)];
        title.text=[[eduAr objectAtIndex:x] valueForKey:@"university"];
        title.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        title.backgroundColor=[UIColor clearColor];//[cc valueForKey:@"Videocolor"];
        title.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        title.textAlignment=NSTextAlignmentLeft;
        [edu addSubview:title];
        
        ////////////////////////
        
        int w =edu.frame.size.width;
        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, title.frame.size.height+title.frame.origin.y+5, w, 1)];
        lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        [edu addSubview:lblLine];
        
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(0, lblLine.frame.size.height+lblLine.frame.origin.y+5, edu.frame.size.width, 200)];
        viewDetails.backgroundColor=[UIColor clearColor];//colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
        viewDetails.clipsToBounds=YES;
        [edu addSubview:viewDetails];

        
        UILabel *lblInstitution=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 80, 25)];
        lblInstitution.text=[NSString stringWithFormat:@"Institution  :  %@",@""];
        lblInstitution.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        lblInstitution.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        lblInstitution.textAlignment=NSTextAlignmentRight;
        lblInstitution.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:lblInstitution];

        
        UILabel *inst=[[UILabel alloc] initWithFrame:CGRectMake( lblInstitution.frame.size.width+2, 0,200, 25)];
        inst.text=[NSString stringWithFormat:@" %@ ",[[eduAr objectAtIndex:x] valueForKey:@"college_name"]];
        inst.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        inst.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        inst.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:inst];
        
        UILabel *lblStream=[[UILabel alloc] initWithFrame:CGRectMake( 0, lblInstitution.frame.size.height+lblInstitution.frame.origin.y,80, 25)];
        lblStream.text=[NSString stringWithFormat:@"Stream  :  %@",@""];
        lblStream.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        lblStream.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        lblStream.textAlignment=NSTextAlignmentRight;
        lblStream.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:lblStream];

        
        UILabel *strm=[[UILabel alloc] initWithFrame:CGRectMake( lblStream.frame.size.width+2, lblInstitution.frame.size.height+lblInstitution.frame.origin.y , 200 , 25)];
        strm.text=[NSString stringWithFormat:@" %@",[[eduAr objectAtIndex:x] valueForKey:@"stream"]];
        strm.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        strm.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        strm.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:strm];
        
        UILabel *lblSubjects=[[UILabel alloc] initWithFrame:CGRectMake( 0, lblStream.frame.size.height+lblStream.frame.origin.y, 80, 25)];
        lblSubjects.text=[NSString stringWithFormat:@"Subjects  :  %@",@""];
        lblSubjects.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        lblSubjects.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        lblSubjects.textAlignment=NSTextAlignmentRight;
        lblSubjects.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:lblSubjects];
        
        
        UILabel *Subjects=[[UILabel alloc] initWithFrame:CGRectMake( lblSubjects.frame.size.width+2, lblStream.frame.size.height+lblStream.frame.origin.y,200, 25)];
        Subjects.text=[NSString stringWithFormat:@" %@",[[eduAr objectAtIndex:x] valueForKey:@"subjects"]];
        Subjects.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        Subjects.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Subjects.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:Subjects];
        
        
        UILabel *lblMarks=[[UILabel alloc] initWithFrame:CGRectMake( 0, lblSubjects.frame.size.height+lblSubjects.frame.origin.y, 80, 25)];
        lblMarks.text=[NSString stringWithFormat:@"Marks  :  %@",@""];
        lblMarks.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        lblMarks.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        lblMarks.textAlignment=NSTextAlignmentRight;
        lblMarks.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:lblMarks];
        
        UILabel *marks1=[[UILabel alloc] initWithFrame:CGRectMake( lblMarks.frame.size.width+2, lblSubjects.frame.size.height+lblSubjects.frame.origin.y,200, 25)];
        marks1.text=[NSString stringWithFormat:@" %@",[[eduAr objectAtIndex:x] valueForKey:@"marks"]];
        marks1.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        marks1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        marks1.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:marks1];
        
        UILabel *lblYear=[[UILabel alloc] initWithFrame:CGRectMake( 0, lblMarks.frame.size.height+lblMarks.frame.origin.y, 80, 25)];
        lblYear.text=[NSString stringWithFormat:@"Year  :  %@",@""];
        lblYear.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        lblYear.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        lblYear.textAlignment=NSTextAlignmentRight;
        lblYear.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:lblYear];
        
        UILabel *year1=[[UILabel alloc] initWithFrame:CGRectMake(lblYear.frame.size.width+2, lblMarks.frame.size.height+lblMarks.frame.origin.y,200, 25)];
        NSString* result = [[NSString stringWithFormat:@"%@",[[eduAr objectAtIndex:x] valueForKey:@"year"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        year1.text=result;
        year1.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        year1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        year1.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:year1];

        UILabel *lblAddress=[[UILabel alloc] initWithFrame:CGRectMake( 0, lblYear.frame.size.height+lblYear.frame.origin.y, 80, 25)];
        lblAddress.text=[NSString stringWithFormat:@"Address  :  %@",@""];
        lblAddress.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        lblAddress.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        lblAddress.textAlignment=NSTextAlignmentRight;
        lblAddress.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:lblAddress];

        
        UITextView *add=[[UITextView alloc] initWithFrame:CGRectMake( lblAddress.frame.size.width, lblYear.frame.size.height+lblYear.frame.origin.y-2,200, 60)];
        add.placeholder = @"Address";
        add.text=[NSString stringWithFormat:@"%@",[[[[[eduAr objectAtIndex:x] valueForKey:@"address"] stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[eduAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[eduAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[eduAr objectAtIndex:x] valueForKey:@"country"] ]]];
        add.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        add.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        add.editable=NO;
        add.backgroundColor=[cc valueForKey:@"backcolor"];
        add.textAlignment=NSTextAlignmentLeft;
        add.editable=NO;
        [viewDetails addSubview:add];
        
        yinc=yinc+230;

    }
    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
}




-(void) calForEmployement
{
    NSLog(@"call for imployement");
    selectedTab=2;
    isCallBack=@"1";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[NSString stringWithFormat:@"%@",frnduid] forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Employment" :@"showEmp" :@"":@"":dic1 :self];
}
#pragma mark showEmployment
//-(void) showEmployment:(NSArray *) employmntAr
//{
//    NSMutableDictionary *bb=[SavePrefrences sharedInstance].colorDictionry;
//    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
//    mainScrollView1.backgroundColor=[bb valueForKey:@"bodycolor"];
//    mainScrollView1.scrollEnabled = YES;
//    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
//    [self.view addSubview:mainScrollView1];
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-10, 1)];
//    [mainScrollView1 addSubview:save];
//
//    
//    int yinc=save.frame.size.height+save.frame.origin.y+20;
//    
//    for(int x=0;x<[employmntAr count];x++)
//    {
//        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(10, yinc, mainScrollView1.frame.size.width-20, 150)];
//        edu.backgroundColor=[UIColor clearColor];
//        [mainScrollView1 addSubview:edu];
//        
//        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0,0, edu.frame.size.width-2, 30)];
//        title.text=[[employmntAr objectAtIndex:x] valueForKey:@"company_name"];
//        title.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
//        title.backgroundColor=[UIColor clearColor];//[bb valueForKey:@"Videocolor"];
//        title.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
//        title.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:title];
//        
//        int w =edu.frame.size.width;
//        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, title.frame.size.height+title.frame.origin.y+5, w, 1)];
//        lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
//        [edu addSubview:lblLine];
//        
//        UILabel *deg=[[UILabel alloc] initWithFrame:CGRectMake(0, lblLine.frame.size.height+lblLine.frame.origin.y+5,self.view.frame.size.width-20, 20)];
//        deg.text=[NSString stringWithFormat:@"%@",[[employmntAr objectAtIndex:x] valueForKey:@"designation"] ];
//        deg.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
//        deg.textColor=[UIColor colorWithRed:130/255.0f green:197/255.0f blue:246/255.0f alpha:1.0f];
//        deg.textAlignment=NSTextAlignmentRight;
//        [edu addSubview:deg];
//
//        
//        UILabel *stw=[[UILabel alloc] initWithFrame:CGRectMake(0, lblLine.frame.size.height+lblLine.frame.origin.y+5, self.view.frame.size.width, 20)];
//        stw.text=[[[employmntAr objectAtIndex:x] valueForKey:@"started_working"] stringByAppendingString:[NSString stringWithFormat:@" -- %@",[[employmntAr objectAtIndex:x] valueForKey:@"end_working"]]];
//        stw.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
//        stw.textColor=[UIColor colorWithRed:130/255.0f green:197/255.0f blue:246/255.0f alpha:1.0f];//[bb valueForKey:@"Tabstextcolor"];
//        stw.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:stw];
//        
//        
//        UILabel *add=[[UILabel alloc] initWithFrame:CGRectMake(0, stw.frame.size.height+stw.frame.origin.y, edu.frame.size.width, 30)];
//        add.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
//        add.text=[NSString stringWithFormat:@"%@",[[[[[employmntAr objectAtIndex:x] valueForKey:@"address"] stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[employmntAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[employmntAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[employmntAr objectAtIndex:x] valueForKey:@"country"] ]]];
//        add.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[bb valueForKey:@"Tabstextcolor"];
//        add.userInteractionEnabled=NO;
//        add.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:add];
//        
//        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(0, add.frame.size.height+add.frame.origin.y,edu.frame.size.width, 40)];
//        jd.text=[NSString stringWithFormat:@"%@ ",[[employmntAr objectAtIndex:x] valueForKey:@"job_desc"]];
//        jd.font=[UIFont fontWithName:@"HelveticaNeue" size:10];
//        jd.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[bb valueForKey:@"Tabstextcolor"];
//        jd.editable=NO;
//        jd.backgroundColor=[bb valueForKey:@"backcolor"];
//        jd.textAlignment=NSTextAlignmentLeft;
//        jd.editable=NO;
//        
//        [edu addSubview:jd];
//        
//        
//        yinc=yinc+155;
//        
//    }
//    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
//}

-(void) showEmployment:(NSArray *) employmntAr
{
    NSMutableDictionary *bb=[SavePrefrences sharedInstance].colorDictionry;
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
    mainScrollView1.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];////[bb valueForKey:@"bodycolor"];
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
    [self.view addSubview:mainScrollView1];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-10, 45)];
    [save setTitle: @"Add Employment" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor clearColor];//[bb valueForKey:@"popupcolor"];
    [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
    [save addTarget:self action:@selector(addEmployemnt) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:182/255.0f green:182/255.0f blue:182/255.0f alpha:1.0f] forState:UIControlStateNormal];
   // [mainScrollView1 addSubview:save];
    
    
    int yinc=save.frame.size.height+save.frame.origin.y+20;
    
    for(int x=0;x<[employmntAr count];x++)
    {
        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(10, yinc, mainScrollView1.frame.size.width-20, 150)];
        edu.backgroundColor=[UIColor clearColor];//[bb valueForKey:@"backcolor"];
        // edu.layer.borderColor=[[UIColor whiteColor]CGColor];
        // edu.layer.borderWidth=2;
        [mainScrollView1 addSubview:edu];
        
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0,0, edu.frame.size.width-2, 30)];
        title.text=[[employmntAr objectAtIndex:x] valueForKey:@"company_name"];
        title.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
        title.backgroundColor=[UIColor clearColor];//[bb valueForKey:@"Videocolor"];
        title.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        title.textAlignment=NSTextAlignmentLeft;
        [edu addSubview:title];
        
        int w =edu.frame.size.width;
        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, title.frame.size.height+title.frame.origin.y+5, w, 1)];
        lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        [edu addSubview:lblLine];
        
        UILabel *deg=[[UILabel alloc] initWithFrame:CGRectMake(0, lblLine.frame.size.height+lblLine.frame.origin.y+5,self.view.frame.size.width-20, 20)];
        deg.text=[NSString stringWithFormat:@"%@",[[employmntAr objectAtIndex:x] valueForKey:@"designation"] ];
        deg.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        deg.textColor=[UIColor colorWithRed:130/255.0f green:197/255.0f blue:246/255.0f alpha:1.0f];
        deg.textAlignment=NSTextAlignmentRight;
        [edu addSubview:deg];
        
        
        UILabel *stw=[[UILabel alloc] initWithFrame:CGRectMake(0, lblLine.frame.size.height+lblLine.frame.origin.y+5, self.view.frame.size.width, 20)];
        stw.text=[[[employmntAr objectAtIndex:x] valueForKey:@"started_working"] stringByAppendingString:[NSString stringWithFormat:@" -- %@",[[employmntAr objectAtIndex:x] valueForKey:@"end_working"]]];
        stw.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        stw.textColor=[UIColor colorWithRed:130/255.0f green:197/255.0f blue:246/255.0f alpha:1.0f];//[bb valueForKey:@"Tabstextcolor"];
        stw.textAlignment=NSTextAlignmentLeft;
        [edu addSubview:stw];
        
        
        UILabel *add=[[UILabel alloc] initWithFrame:CGRectMake(0, stw.frame.size.height+stw.frame.origin.y, edu.frame.size.width, 30)];
        add.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        add.text=[NSString stringWithFormat:@" %@",[[[[[employmntAr objectAtIndex:x] valueForKey:@"address"] stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[employmntAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[employmntAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[employmntAr objectAtIndex:x] valueForKey:@"country"] ]]];
        add.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[bb valueForKey:@"Tabstextcolor"];
        add.userInteractionEnabled=NO;
        add.textAlignment=NSTextAlignmentLeft;
        [edu addSubview:add];
        
        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(0, add.frame.size.height+add.frame.origin.y,edu.frame.size.width, 40)];
        jd.placeholder = @"Job Description";
        jd.text=[NSString stringWithFormat:@"%@ ",[[employmntAr objectAtIndex:x] valueForKey:@"job_desc"]];
        jd.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        jd.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[bb valueForKey:@"Tabstextcolor"];
        jd.editable=NO;
        jd.backgroundColor=[bb valueForKey:@"backcolor"];
        jd.textAlignment=NSTextAlignmentLeft;
        jd.editable=NO;
        
        [edu addSubview:jd];
        
        
//        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-80, 5, 20, 20)];
//        update.backgroundColor=[UIColor clearColor];
//        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
//        update.tag=[[[employmntAr objectAtIndex:x] valueForKey:@"emp_id"] intValue];
//        [edu addSubview:update];
        
//        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateEmployement:)];
//        [updateges setNumberOfTouchesRequired:1];
//        [updateges setDelegate:self];
//        update.userInteractionEnabled = YES;
//        [update addGestureRecognizer:updateges];
        
        NSString *emplid=[[employmntAr valueForKey:@"emp_id"]objectAtIndex:x];
        
//        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
//        delete.backgroundColor=[UIColor clearColor] ;
//        delete.image = [UIImage imageNamed:@"educationprofiledelete.png"];
//        [edu addSubview:delete];
//        delete.tag=[emplid intValue];
        
        
//        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteEmployement:)];
//        [deleteges setNumberOfTouchesRequired:1];
//        [deleteges setDelegate:self];
//        delete.userInteractionEnabled = YES;
//        [delete addGestureRecognizer:deleteges];
        
        yinc=yinc+155;
        
    }
    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
}


-(void) calForCertification
{
    selectedTab=3;
    
    isCallBack=@"2";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[NSString stringWithFormat:@"%@",frnduid] forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Certification" :@"showCert" :@"":@"":dic1 :self];
    
}
#pragma mark showCertification

-(void) showCertification
{
    
    NSMutableDictionary *hh=[SavePrefrences sharedInstance].colorDictionry;
    
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
    mainScrollView1.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[hh valueForKey:@"bodycolor"];
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
    [self.view addSubview:mainScrollView1];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 45)];
    [save setTitle: @"Add Certificates" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor clearColor];//[hh valueForKey:@"popupcolor"];
    [save addTarget:self action:@selector(addCertification) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:182.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
   // [mainScrollView1 addSubview:save];
    
    
    int yinc=save.frame.size.height+save.frame.origin.y+10;
    for(int x=0;x<[certificationAr count];x++)
    {
        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(-2, yinc, mainScrollView1.frame.size.width+3, 210)];
        edu.backgroundColor= [hh valueForKey:@"backcolor"];
        //  edu.layer.borderColor=[[UIColor colorWithRed:182.0f/255 green:182.0f/255 blue:182.0f/255 alpha:0.30f]CGColor];
        //  edu.layer.borderWidth=3;
        
        /* edu.layer.shadowColor = [UIColor blackColor].CGColor;
         edu.layer.shadowOffset = CGSizeMake(2, 2);
         edu.layer.shadowOpacity = 1.0;
         edu.layer.shadowRadius =3.0;*/
        
        
        edu.tag=x;
        [mainScrollView1 addSubview:edu];
        
        
        UITapGestureRecognizer *eduges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showcertifulldetail:)];
        [eduges setNumberOfTouchesRequired:1];
        [eduges setDelegate:self];
        edu.userInteractionEnabled = YES;
        [edu addGestureRecognizer:eduges];
        
        
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(12, 0, edu.frame.size.width, 30)];
        title.text=[[certificationAr objectAtIndex:x] valueForKey:@"certificate_name"];
        title.font=[UIFont fontWithName:@"HelveticaNeue" size:15];
        title.backgroundColor=[hh valueForKey:@"Videocolor"];
        title.textColor=[UIColor colorWithRed:0.0f/255 green:46.0f/255 blue:99.0f/255 alpha:1.0f];
        title.textAlignment=NSTextAlignmentLeft;
        [edu addSubview:title];
        
        int w =edu.frame.size.width;
        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, title.frame.size.height+title.frame.origin.y+5, w, 1)];
        lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        [edu addSubview:lblLine];
        
        
        UIImageView *certimg =[[UIImageView alloc]initWithFrame:CGRectMake(9, lblLine.frame.size.height+lblLine.frame.origin.y+5,65, 50)];
        certimg.image = [UIImage imageNamed:@"username.png"];
        certimg.backgroundColor=[UIColor clearColor];
        [edu addSubview:certimg];
        
        NSString *Img =  [[certificationAr valueForKey:@"image"] objectAtIndex:x];
        Img= [mang concatUrl:Img];
        NSLog(@"img is -======== %@",Img);
        
        //NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
        [certimg sd_setImageWithURL:[NSURL URLWithString:Img]];
        
//        if(Img.length<12)
//        {
//            certimg.image = [UIImage imageNamed:Img];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if (imageData.length<=0)
//                certimg.image = [UIImage imageNamed:@"username.png"];
//            else
//                certimg.image = [UIImage imageWithData:imageData];
//            
//        }
        
        ////////////////////////
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(certimg.frame.size.width+20, lblLine.frame.size.height+lblLine.frame.origin.y+5, edu.frame.size.width-certimg.frame.size.width-10, 130)];
        viewDetails.backgroundColor=[UIColor clearColor];//colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
        viewDetails.clipsToBounds=YES;
        [edu addSubview:viewDetails];
        
        
        UILabel *company=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 110, 20)];
        company.text=[NSString stringWithFormat:@"Company : %@",@""];
        company.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        company.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        company.textAlignment=NSTextAlignmentRight;
        company.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:company];
        
        UILabel *company1=[[UILabel alloc] initWithFrame:CGRectMake(company.frame.size.width+company.frame.origin.x+2, 0,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
        company1.text= [NSString stringWithFormat:@" %@",[[certificationAr objectAtIndex:x] valueForKey:@"name_org"]];
        company1.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        company1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
        company1.textAlignment=NSTextAlignmentLeft;
        company1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:company1];
        
        
        UILabel *presenteBy=[[UILabel alloc] initWithFrame:CGRectMake( 0, company.frame.size.height+company.frame.origin.y+3, 110, 20)];
        presenteBy.text=[NSString stringWithFormat:@"Presented By : %@",@""];
        presenteBy.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        presenteBy.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        presenteBy.textAlignment=NSTextAlignmentRight;
        presenteBy.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:presenteBy];
        
        UILabel *presenteBy1=[[UILabel alloc] initWithFrame:CGRectMake(presenteBy.frame.size.width+presenteBy.frame.origin.x+2, company.frame.size.height+company.frame.origin.y,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
        presenteBy1.text= [NSString stringWithFormat:@" %@",[[certificationAr objectAtIndex:x] valueForKey:@"subject"]];
        presenteBy1.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        presenteBy1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
        presenteBy1.textAlignment=NSTextAlignmentLeft;
        presenteBy1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:presenteBy1];
        
        
        UILabel *dateView=[[UILabel alloc] initWithFrame:CGRectMake( 0, presenteBy.frame.size.height+presenteBy.frame.origin.y+3, 110, 20)];
        dateView.text=[NSString stringWithFormat:@"Date : %@",@""];
        dateView.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        dateView.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        dateView.textAlignment=NSTextAlignmentRight;
        dateView.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:dateView];
        
        UILabel *dateView1=[[UILabel alloc] initWithFrame:CGRectMake(dateView.frame.size.width+dateView.frame.origin.x+2, presenteBy.frame.size.height+presenteBy.frame.origin.y+3,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        
        
        
        NSDate *dte = [dateFormat dateFromString:[[certificationAr objectAtIndex:x] valueForKey:@"cert_when"]];
        
        NSDateFormatter *dt = [[NSDateFormatter alloc] init];
        [dt setDateFormat:@"MM/dd/yyyy"];
        
        
        dateView1.text= [[certificationAr objectAtIndex:x] valueForKey:@"cert_when"];
        dateView1.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        dateView1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
        dateView1.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:dateView1];
        
        
        UILabel *addressView=[[UILabel alloc] initWithFrame:CGRectMake( 0, dateView.frame.size.height+dateView.frame.origin.y+3, 110, 20)];
        addressView.text=[NSString stringWithFormat:@"Address : %@",@""];
        addressView.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        addressView.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        addressView.textAlignment=NSTextAlignmentRight;
        addressView.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:addressView];
        
        
        ///////////////////////
        
        UITextView *add=[[UITextView alloc] initWithFrame:CGRectMake(addressView.frame.size.width, dateView.frame.size.height+dateView.frame.origin.y-3,viewDetails.frame.size.width-addressView.frame.size.width-10, 60)];
        add.placeholder = @"Address";
        add.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        add.backgroundColor=[UIColor clearColor];
        add.editable=NO;
        
        NSString* result = [[[certificationAr objectAtIndex:x] valueForKey:@"address"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        add.text=[NSString stringWithFormat:@" %@",[[[result stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[certificationAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[certificationAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[certificationAr objectAtIndex:x] valueForKey:@"country"] ]]];
        add.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];;//[hh valueForKey:@"Tabstextcolor"];
        add.editable=NO;
        add.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:add];
        
        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(5, viewDetails.frame.size.height+viewDetails.frame.origin.y,edu.frame.size.width, 60)];
        jd.text=[NSString stringWithFormat:@" %@ ",[[certificationAr objectAtIndex:x] valueForKey:@"c_desc"]];
        add.placeholder = @"Company Desciption";
        jd.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        jd.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[hh valueForKey:@"Tabstextcolor"];
        jd.editable=NO;
        jd.scrollEnabled=YES;
        jd.backgroundColor=[hh valueForKey:@"backcolor"];
        jd.textAlignment=NSTextAlignmentLeft;
        jd.editable=NO;
        [edu addSubview:jd];
        
        
//        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-80, 5, 20, 20)];
//        update.backgroundColor=[UIColor clearColor] ;
//        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
//        update.tag=[[[certificationAr objectAtIndex:x] valueForKey:@"c_id"] intValue];
//        [edu addSubview:update];
        
//        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateCertification:)];
//        [updateges setNumberOfTouchesRequired:1];
//        [updateges setDelegate:self];
//        update.userInteractionEnabled = YES;
//        [update addGestureRecognizer:updateges];
        
        NSString *certid=[[certificationAr objectAtIndex:x] valueForKey:@"c_id"];
        
//        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
//        delete.backgroundColor=[UIColor clearColor] ;
//        delete.image = [UIImage imageNamed:@"educationprofiledelete.png"];
//        [edu addSubview:delete];
//        delete.tag=[certid intValue];
        
        
//        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteCertification:)];
//        [deleteges setNumberOfTouchesRequired:1];
//        [deleteges setDelegate:self];
//        delete.userInteractionEnabled = YES;
//        [delete addGestureRecognizer:deleteges];
        
        yinc=yinc+230;
        
    }
    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
    
    
}

//-(void) showCertification
//{
//    
//    NSMutableDictionary *hh=[SavePrefrences sharedInstance].colorDictionry;
//    
//    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
//    mainScrollView1.backgroundColor=[hh valueForKey:@"bodycolor"];
//    mainScrollView1.scrollEnabled = YES;
//    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
//    [self.view addSubview:mainScrollView1];
//    
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 1)];
//    [mainScrollView1 addSubview:save];
//
//    int yinc=save.frame.size.height+save.frame.origin.y+10;
//    for(int x=0;x<[certificationAr count];x++)
//    {
//        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(-2, yinc, mainScrollView1.frame.size.width+3, 210)];
//        edu.backgroundColor=[hh valueForKey:@"backcolor"];
//        [mainScrollView1 addSubview:edu];
//        
//        
//        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(12, 0, edu.frame.size.width, 30)];
//        title.text=[[certificationAr objectAtIndex:x] valueForKey:@"certificate_name"];
//        title.font=[UIFont fontWithName:@"HelveticaNeue" size:15];
//        title.backgroundColor=[UIColor clearColor];//[hh valueForKey:@"popupcolor"];
//        title.textColor=[UIColor colorWithRed:0.0f/255 green:46.0f/255 blue:99.0f/255 alpha:1.0f];
//        title.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:title];
//        
//        int w =edu.frame.size.width;
//        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, title.frame.size.height+title.frame.origin.y+5, w, 1)];
//        lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
//        [edu addSubview:lblLine];
//
//        
//        UIImageView *certimg =[[UIImageView alloc]initWithFrame:CGRectMake(9, lblLine.frame.size.height+lblLine.frame.origin.y+5,65, 50)];
//        certimg.image = [UIImage imageNamed:@"username.png"];
//        certimg.backgroundColor=[UIColor clearColor];
//        [edu addSubview:certimg];
//        
//        
//        NSString *Img =  [[certificationAr valueForKey:@"image"] objectAtIndex:x];
//        Img= [mang concatUrl:Img];
//        
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//        if(Img.length<12)
//        {
//            certimg.image = [UIImage imageNamed:Img];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if (imageData.length<=0)
//                certimg.image = [UIImage imageNamed:@"username.png"];
//            else
//                certimg.image = [UIImage imageWithData:imageData];
//            
//        }
//       
//        ////////////////////////
//        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(certimg.frame.size.width+20, lblLine.frame.size.height+lblLine.frame.origin.y+5, edu.frame.size.width-certimg.frame.size.width-10, 130)];
//        viewDetails.backgroundColor=[UIColor clearColor];//colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
//        viewDetails.clipsToBounds=YES;
//        [edu addSubview:viewDetails];
//        
//        
//        UILabel *company=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 110, 20)];
//        company.text=[NSString stringWithFormat:@"Company : %@",@""];
//        company.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        company.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
//        company.textAlignment=NSTextAlignmentRight;
//        company.backgroundColor=[UIColor clearColor];
//        [viewDetails addSubview:company];
//        
//        UILabel *company1=[[UILabel alloc] initWithFrame:CGRectMake(company.frame.size.width+company.frame.origin.x+2, 0,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
//        company1.text= [NSString stringWithFormat:@" %@",[[certificationAr objectAtIndex:x] valueForKey:@"name_org"]];
//        company1.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        company1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
//        company1.textAlignment=NSTextAlignmentLeft;
//        company1.backgroundColor=[UIColor clearColor];
//        [viewDetails addSubview:company1];
//        
//        
//        UILabel *presenteBy=[[UILabel alloc] initWithFrame:CGRectMake( 0, company.frame.size.height+company.frame.origin.y+3, 110, 20)];
//        presenteBy.text=[NSString stringWithFormat:@"Presented By : %@",@""];
//        presenteBy.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        presenteBy.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
//        presenteBy.textAlignment=NSTextAlignmentRight;
//        presenteBy.backgroundColor=[UIColor clearColor];
//        [viewDetails addSubview:presenteBy];
//        
//        UILabel *presenteBy1=[[UILabel alloc] initWithFrame:CGRectMake(presenteBy.frame.size.width+presenteBy.frame.origin.x+2, company.frame.size.height+company.frame.origin.y,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
//        presenteBy1.text= [NSString stringWithFormat:@" %@",[[certificationAr objectAtIndex:x] valueForKey:@"subject"]];
//        presenteBy1.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        presenteBy1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
//        presenteBy1.textAlignment=NSTextAlignmentLeft;
//        presenteBy1.backgroundColor=[UIColor clearColor];
//        [viewDetails addSubview:presenteBy1];
//        
//        
//        UILabel *dateView=[[UILabel alloc] initWithFrame:CGRectMake( 0, presenteBy.frame.size.height+presenteBy.frame.origin.y+3, 110, 20)];
//        dateView.text=[NSString stringWithFormat:@"Date : %@",@""];
//        dateView.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        dateView.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
//        dateView.textAlignment=NSTextAlignmentRight;
//        dateView.backgroundColor=[UIColor clearColor];
//        [viewDetails addSubview:dateView];
//        
//        UILabel *dateView1=[[UILabel alloc] initWithFrame:CGRectMake(dateView.frame.size.width+dateView.frame.origin.x+2, presenteBy.frame.size.height+presenteBy.frame.origin.y+3,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
//        dateView1.text= [NSString stringWithFormat:@" %@",[[certificationAr objectAtIndex:x] valueForKey:@"cert_when"]];
//        dateView1.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        dateView1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
//        dateView1.textAlignment=NSTextAlignmentLeft;
//        [viewDetails addSubview:dateView1];
//        
//        
//        UILabel *addressView=[[UILabel alloc] initWithFrame:CGRectMake( 0, dateView.frame.size.height+dateView.frame.origin.y+3, 110, 20)];
//        addressView.text=[NSString stringWithFormat:@"Address : %@",@""];
//        addressView.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        addressView.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
//        addressView.textAlignment=NSTextAlignmentRight;
//        addressView.backgroundColor=[UIColor clearColor];
//        [viewDetails addSubview:addressView];
//        
//        
//        ///////////////////////
//        
//        UITextView *add=[[UITextView alloc] initWithFrame:CGRectMake(addressView.frame.size.width, dateView.frame.size.height+dateView.frame.origin.y-3,viewDetails.frame.size.width-addressView.frame.size.width-10, 60)];
//        add.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        add.backgroundColor=[UIColor clearColor];
//        add.editable=NO;
//        
//        NSString* result = [[[certificationAr objectAtIndex:x] valueForKey:@"address"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        add.text=[NSString stringWithFormat:@"%@",[[[result stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[certificationAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[certificationAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[certificationAr objectAtIndex:x] valueForKey:@"country"] ]]];
//        add.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];;//[hh valueForKey:@"Tabstextcolor"];
//        add.editable=NO;
//        add.textAlignment=NSTextAlignmentLeft;
//        [viewDetails addSubview:add];
//        
//        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(5, viewDetails.frame.size.height+viewDetails.frame.origin.y,edu.frame.size.width, 60)];
//        jd.text=[NSString stringWithFormat:@" %@ ",[[certificationAr objectAtIndex:x] valueForKey:@"c_desc"]];
//        jd.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        jd.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[hh valueForKey:@"Tabstextcolor"];
//        jd.editable=NO;
//        jd.scrollEnabled=YES;
//        jd.backgroundColor=[hh valueForKey:@"backcolor"];
//        jd.textAlignment=NSTextAlignmentLeft;
//        jd.editable=NO;
//        [edu addSubview:jd];
//        
//        
//        yinc=yinc+230;
//        
//    }
//    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
//    
//    
//}




-(void) calForAward
{
    selectedTab=4;
    isCallBack=@"3";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[NSString stringWithFormat:@"%@",frnduid] forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Awards" :@"showAwards" :@"":@"":dic1 :self];
    
}
#pragma mark showAward

//-(void) showAward
//{
//    
//    NSMutableDictionary *jj=[SavePrefrences sharedInstance].colorDictionry;
//    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
//    mainScrollView1.backgroundColor=[jj valueForKey:@"bodycolor"];
//    mainScrollView1.scrollEnabled = YES;
//    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
//    [self.view addSubview:mainScrollView1];
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 1)];
//    [mainScrollView1 addSubview:save];
//
//    int yinc=save.frame.size.height+save.frame.origin.y+20;
//    for(int x=0;x<[awardAr count];x++)
//    {
//        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(10, yinc, mainScrollView1.frame.size.width-20, 180)];
//        edu.backgroundColor=[UIColor clearColor];//[jj valueForKey:@"backcolor"];
//        [mainScrollView1 addSubview:edu];
//        
//        
//        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(2, 0, edu.frame.size.width-2, 30)];
//        title.text=[[awardAr objectAtIndex:x] valueForKey:@"name_of_comp"];
//        title.font=[UIFont fontWithName:@"HelveticaNeue" size:15];
//        title.textColor=[UIColor colorWithRed:0.0f/255 green:46.0f/255 blue:99.0f/255 alpha:1.0f];
//        title.backgroundColor=[jj valueForKey:@"Videocolor"];
//        title.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:title];
//        
//        int w =edu.frame.size.width;
//        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, title.frame.size.height+title.frame.origin.y+5, w, 1)];
//        lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
//        [edu addSubview:lblLine];
//
//        UIImageView *certimg =[[UIImageView alloc]initWithFrame:CGRectMake(9, lblLine.frame.size.height+lblLine.frame.origin.y+5, 65, 50)];
//        certimg.image = [UIImage imageNamed:@"username.png"];
//        certimg.backgroundColor=[UIColor clearColor];
//        [edu addSubview:certimg];
//        
//        
//        
//        NSString *Img =  [[awardAr valueForKey:@"image"] objectAtIndex:x];
//        Img= [mang concatUrl:Img];
//        
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//        if(Img.length<12)
//        {
//            certimg.image = [UIImage imageNamed:Img];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if (imageData.length<=0)
//                certimg.image = [UIImage imageNamed:@"username.png"];
//            else
//                certimg.image = [UIImage imageWithData:imageData];
//            
//        }
//        
//        
//        ////////////////////////
//        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(certimg.frame.size.width+20, lblLine.frame.size.height+lblLine.frame.origin.y+5, edu.frame.size.width-certimg.frame.size.width-20, 130)];
//        viewDetails.backgroundColor=[UIColor clearColor];//colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
//        
//        viewDetails.clipsToBounds=YES;
//        [edu addSubview:viewDetails];
//        
//        
//        UILabel *presenteBy=[[UILabel alloc] initWithFrame:CGRectMake(  0, 0, 110, 20)];
//        presenteBy.text=[NSString stringWithFormat:@"Presented By : %@",@""];
//        presenteBy.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        presenteBy.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
//        presenteBy.textAlignment=NSTextAlignmentRight;
//        presenteBy.backgroundColor=[UIColor clearColor];
//        [viewDetails addSubview:presenteBy];
//        
//        UILabel *presenteBy1=[[UILabel alloc] initWithFrame:CGRectMake(presenteBy.frame.size.width+2, 0,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
//        presenteBy1.text= [NSString stringWithFormat:@"%@",[[awardAr objectAtIndex:x] valueForKey:@"presented_by"]];
//        presenteBy1.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
//        presenteBy1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
//        presenteBy1.textAlignment=NSTextAlignmentLeft;
//        [viewDetails addSubview:presenteBy1];
//        
//        
//        
//        UILabel *dateView=[[UILabel alloc] initWithFrame:CGRectMake( 0, presenteBy.frame.size.height+presenteBy.frame.origin.y+3, 110, 20)];
//        dateView.text=[NSString stringWithFormat:@"Date : %@  ",@""];
//        dateView.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        dateView.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
//        dateView.textAlignment=NSTextAlignmentRight;
//        dateView.backgroundColor=[UIColor clearColor];
//        [viewDetails addSubview:dateView];
//        
//        
//        UILabel *addressView=[[UILabel alloc] initWithFrame:CGRectMake( 0, dateView.frame.size.height+dateView.frame.origin.y+3, 110, 20)];
//        addressView.text=[NSString stringWithFormat:@"Address : %@",@""];
//        addressView.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        addressView.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
//        addressView.textAlignment=NSTextAlignmentRight;
//        addressView.backgroundColor=[UIColor clearColor];
//        
//        [viewDetails addSubview:addressView];
//        
//        
//        ///////////////////////
//        
//        
//        UILabel *aww=[[UILabel alloc] initWithFrame:CGRectMake(dateView.frame.size.width+2, presenteBy.frame.size.height+presenteBy.frame.origin.y+3,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
//        aww.text=[[awardAr objectAtIndex:x] valueForKey:@"award_when"];
//        aww.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
//        aww.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
//        aww.textAlignment=NSTextAlignmentLeft;
//        [viewDetails addSubview:aww];
//        
//        
//        UITextView *add=[[UITextView alloc] initWithFrame:CGRectMake(addressView.frame.size.width, dateView.frame.size.height+dateView.frame.origin.y-3,viewDetails.frame.size.width-addressView.frame.size.width-10, 60)];
//        add.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        add.backgroundColor=[UIColor clearColor];
//        NSString* result = [[[awardAr objectAtIndex:x] valueForKey:@"address"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//        add.text=[NSString stringWithFormat:@"%@",[[[result stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[awardAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[awardAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[awardAr objectAtIndex:x] valueForKey:@"country"] ]]];
//        add.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
//        add.editable=NO;
//        add.textAlignment=NSTextAlignmentLeft;
//        add.editable=NO;
//        [viewDetails addSubview:add];
//        
//        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(10, viewDetails.frame.size.height+viewDetails.frame.origin.y, edu.frame.size.width, 60)];
//        jd.text=[NSString stringWithFormat:@"%@ ",[[awardAr objectAtIndex:x] valueForKey:@"award_desc"]];
//        jd.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
//        jd.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
//        jd.backgroundColor=[UIColor clearColor];//[jj valueForKey:@"backcolor"];
//        jd.textAlignment=NSTextAlignmentLeft;
//        jd.editable=NO;
//        [edu addSubview:jd];
//
//        yinc=yinc+220;
//        
//    }
//    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
//    
//    
//}

-(void) showAward
{
    NSMutableDictionary *jj=[SavePrefrences sharedInstance].colorDictionry;
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
    mainScrollView1.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[jj valueForKey:@"bodycolor"];
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
    [self.view addSubview:mainScrollView1];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 45)];
    [save setTitle: @"Add Awards" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor clearColor];//[jj valueForKey:@"popupcolor"];
    [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [save addTarget:self action:@selector(addAward) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:182.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f] forState:UIControlStateNormal];
  //  [mainScrollView1 addSubview:save];
    
    
    int yinc=save.frame.size.height+save.frame.origin.y+20;
    for(int x=0;x<[awardAr count];x++)
    {
        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(10, yinc, mainScrollView1.frame.size.width-20, 180)];
        edu.backgroundColor=[UIColor clearColor];//[jj valueForKey:@"backcolor"];
        [mainScrollView1 addSubview:edu];
        
        
//        UITapGestureRecognizer *shofulldetail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFullDetail:)];
//        [shofulldetail setNumberOfTouchesRequired:1];
//        edu.tag=x;
//        [shofulldetail setDelegate:self];
//        edu.userInteractionEnabled = YES;
//        [edu addGestureRecognizer:shofulldetail];
        
        
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(2, 0, edu.frame.size.width-2, 30)];
        title.text=[[awardAr objectAtIndex:x] valueForKey:@"name_of_comp"];
        title.font=[UIFont fontWithName:@"HelveticaNeue" size:15];
        title.textColor=[UIColor colorWithRed:0.0f/255 green:46.0f/255 blue:99.0f/255 alpha:1.0f];
        title.backgroundColor=[jj valueForKey:@"Videocolor"];
        title.textAlignment=NSTextAlignmentLeft;
        [edu addSubview:title];
        
        int w =edu.frame.size.width;
        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, title.frame.size.height+title.frame.origin.y+5, w, 1)];
        lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        [edu addSubview:lblLine];
        
        UIImageView *certimg =[[UIImageView alloc]initWithFrame:CGRectMake(9, lblLine.frame.size.height+lblLine.frame.origin.y+5, 65, 50)];
        certimg.image = [UIImage imageNamed:@"username.png"];
        certimg.backgroundColor=[UIColor clearColor];
        [edu addSubview:certimg];
        
        
        
        NSString *Img =  [[awardAr valueForKey:@"image"] objectAtIndex:x];
        Img= [mang concatUrl:Img];
        
        NSLog(@"img is -======== for Award  %@",Img);
         [certimg sd_setImageWithURL:[NSURL URLWithString:Img]];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//        if(Img.length<12)
//        {
//            certimg.image = [UIImage imageNamed:Img];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
//            if (imageData.length<=0)
//                certimg.image = [UIImage imageNamed:@"username.png"];
//            else
//                certimg.image = [UIImage imageWithData:imageData];
//            
//        }
        
        
        
        ////////////////////////
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(certimg.frame.size.width+20, lblLine.frame.size.height+lblLine.frame.origin.y+5, edu.frame.size.width-certimg.frame.size.width-20, 130)];
        viewDetails.backgroundColor=[UIColor clearColor];//colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
        
        viewDetails.clipsToBounds=YES;
        [edu addSubview:viewDetails];
        
        
        UILabel *presenteBy=[[UILabel alloc] initWithFrame:CGRectMake(  0, 0, 110, 20)];
        presenteBy.text=[NSString stringWithFormat:@"Presented By : %@",@""];
        presenteBy.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        presenteBy.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        presenteBy.textAlignment=NSTextAlignmentRight;
        presenteBy.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:presenteBy];
        
        UILabel *presenteBy1=[[UILabel alloc] initWithFrame:CGRectMake(presenteBy.frame.size.width+2, 0,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
        presenteBy1.text= [NSString stringWithFormat:@"%@",[[awardAr objectAtIndex:x] valueForKey:@"presented_by"]];
        presenteBy1.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        presenteBy1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
        presenteBy1.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:presenteBy1];
        
        
        
        UILabel *dateView=[[UILabel alloc] initWithFrame:CGRectMake( 0, presenteBy.frame.size.height+presenteBy.frame.origin.y+3, 110, 20)];
        dateView.text=[NSString stringWithFormat:@"Date : %@  ",@""];
        dateView.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        dateView.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        dateView.textAlignment=NSTextAlignmentRight;
        dateView.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:dateView];
        
        
        UILabel *addressView=[[UILabel alloc] initWithFrame:CGRectMake( 0, dateView.frame.size.height+dateView.frame.origin.y+3, 110, 20)];
        addressView.text=[NSString stringWithFormat:@"Address : %@",@""];
        addressView.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        addressView.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        addressView.textAlignment=NSTextAlignmentRight;
        addressView.backgroundColor=[UIColor clearColor];
        
        [viewDetails addSubview:addressView];
        
        
        ///////////////////////
        
        
        UILabel *aww=[[UILabel alloc] initWithFrame:CGRectMake(dateView.frame.size.width+2, presenteBy.frame.size.height+presenteBy.frame.origin.y+3,150, 20)];//(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        
        
        
        NSDate *dte = [dateFormat dateFromString:[[awardAr objectAtIndex:x] valueForKey:@"award_when"]];
        
        NSDateFormatter *dt = [[NSDateFormatter alloc] init];
        [dt setDateFormat:@"MM/dd/yyyy"];
        
        
        aww.text= [[awardAr objectAtIndex:x] valueForKey:@"award_when"];
        
        // aww.text=[[awardAr objectAtIndex:x] valueForKey:@"award_when"];
        aww.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        aww.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
        aww.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:aww];
        
        
        
        UITextView *add=[[UITextView alloc] initWithFrame:CGRectMake(addressView.frame.size.width, dateView.frame.size.height+dateView.frame.origin.y-3,viewDetails.frame.size.width-addressView.frame.size.width-10, 60)];
        add.placeholder = @"Address";
        add.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        add.backgroundColor=[UIColor clearColor];
        NSString* result = [[[awardAr objectAtIndex:x] valueForKey:@"address"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        add.text=[NSString stringWithFormat:@"%@",[[[result stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[awardAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[awardAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[awardAr objectAtIndex:x] valueForKey:@"country"] ]]];
        add.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
        add.editable=NO;
        add.textAlignment=NSTextAlignmentLeft;
        add.editable=NO;
        [viewDetails addSubview:add];
        
        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(10, viewDetails.frame.size.height+viewDetails.frame.origin.y, edu.frame.size.width, 60)];
        jd.text=[NSString stringWithFormat:@"%@ ",[[awardAr objectAtIndex:x] valueForKey:@"award_desc"]];
        jd.placeholder = @"Award Description";
        jd.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        jd.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
        jd.backgroundColor=[UIColor clearColor];//[jj valueForKey:@"backcolor"];
        jd.editable=YES;
        jd.scrollEnabled=YES;
        jd.textAlignment=NSTextAlignmentLeft;
        jd.editable=NO;
        [edu addSubview:jd];
        
        NSLog(@"aww.text......%@",aww.text);
        NSLog(@"add.text......%@",add.text);
        
        
//        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-80, 5, 20, 20)];
//        update.backgroundColor=[UIColor clearColor] ;
//        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
//        update.tag=[[[awardAr objectAtIndex:x] valueForKey:@"id"] intValue];
//        [edu addSubview:update];
        
//        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateAward:)];
//        [updateges setNumberOfTouchesRequired:1];
//        [updateges setDelegate:self];
//        update.userInteractionEnabled = YES;
//        [update addGestureRecognizer:updateges];
        
        NSString *awrdid=[[awardAr objectAtIndex:x] valueForKey:@"id"];
        
//        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
//        delete.backgroundColor=[UIColor clearColor] ;
//        delete.image = [UIImage imageNamed:@"educationprofiledelete.png"];
//        [edu addSubview:delete];
//        delete.tag=[awrdid intValue];
//        
//        
//        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAward:)];
//        [deleteges setNumberOfTouchesRequired:1];
//        [deleteges setDelegate:self];
//        delete.userInteractionEnabled = YES;
//        [delete addGestureRecognizer:deleteges];
        
        
        
        
        yinc=yinc+220;
        
    }
    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
    
    
}

-(void) callBack:(NSArray *)META  :(NSArray *)DATA
{
    int isCallBack1=[isCallBack intValue];
    
    NSLog(@"callback======%d",isCallBack1);
    
    
    if(isCallBack1==0)
    {
        NSArray * md=[META valueForKey:@"data"];
        eduAr=[md valueForKey:@"userEdu"];
        [self showEducation];
    }
    else if (isCallBack1==1)
    {
        
        NSArray * md=[META valueForKey:@"data"];
        employmntAr=[md valueForKey:@"userEmp"];
        NSLog(@"data in Employment array is %@",employmntAr);
        [self showEmployment:employmntAr];
    }
    
    else if (isCallBack1==2)
    {
        
        NSArray * md=[META valueForKey:@"data"];
        certificationAr=[md valueForKey:@"userEmp"];
        [self showCertification];
        
    }
    
    else if (isCallBack1==3)
    {
        NSArray * md=[META valueForKey:@"data"];
        awardAr=[md valueForKey:@"userAward"];
        
        [self showAward];
    }
    
    else if(isCallBack1==7)
    {
        
        
        eduAr=DATA;
        [self showEducation];
        [prMainView removeFromSuperview];
    }
    else if(isCallBack1==8)
    {
        
        [self educationDetail];
    }
    else if (isCallBack1==9)
    {
        
        employmntAr=DATA;
        [self showEmployment:employmntAr];
    }
    
    else if (isCallBack1==10)
    {
        //employmntAr=DATA;
        [self showEmployment:DATA];
    }
    else if (isCallBack1==12)
    {
        certificationAr=DATA;
        [self showCertification];
    }
    else if (isCallBack1==13)
    {
        certificationAr=[DATA valueForKey:@"certificate"];
        [self showCertification];
    }
    else if (isCallBack1==14)
    {
        
        certificationAr=[DATA valueForKey:@"certificate"];
        [self showCertification];
    }
    
    else if (isCallBack1==15)
    {
        
        awardAr=DATA;
        [self showAward];
        
    }
    else if (isCallBack1==16)
    {
        awardAr=[DATA valueForKey:@"awards"];
        [self showAward];
        
        
    }

    else if (isCallBack1==19)
    {
        [self addProfileimage:DATA];
    }
}
    
    

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) callMethod:(NSArray *)meta
{
 
    [self showProfile];
    
    NSLog(@"Valuuuuuuuuuu===%@",meta);
    
}





@end
