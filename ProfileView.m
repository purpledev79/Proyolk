
#import "ProfileView.h"
#import "ManageArray.h"
#import "SavePrefrences.h"
#import "AllValidationsViewController.h"
#import "SelectCountry.h"
#import "AllPopUp.h"
#import "LeftRightDrawer.h"

@interface ProfileView ()
{
    NSString *imgBuffer,*cid,*stid,*cityid;
    NSString *randomImgName;
    UIImageView *imggeter;
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIScrollView *scrollView;
    NSMutableArray *selLabAr;
    ManageArray *mang;
    UIScrollView *mainScrollView1,*prfvwscr;
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
    int selectedTab,awardId,EmployId,EducId,CertID,height;
    NSMutableArray *coloAr;
    UILabel *NameLabel;
}

@end

@implementation ProfileView
@synthesize ProfileAr,scrollCtSt,countryAr,isCallBack,istab;

- (void)viewDidLoad {
    [super viewDidLoad];
    limit = 0;
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
    
    
   /* UILabel *Toplbl = [[UILabel alloc]initWithFrame:CGRectMake(120,0,200,40)];
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
    
    UIImageView *logo =[[UIImageView alloc]initWithFrame:CGRectMake(120,-2,150,50)];
    logo.image = [UIImage imageNamed:@"logo_new.png"];
    logo.backgroundColor=[UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:182.0/255 green:182.0/255 blue:182.0/255 alpha:1];
    [self.navigationController.navigationBar addSubview:logo];
    self.navigationController.navigationBar.barTintColor =[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    self.navigationController.navigationBar.backgroundColor =[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    
    //here navigation color
    UIView *navBarLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.frame), CGRectGetWidth(self.navigationController.navigationBar.frame), 1.5)];
    navBarLineView.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:255.0/255 alpha:1];
    [self.navigationController.navigationBar addSubview:navBarLineView];

    self.view.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];

    
    [self showTabs];
    
    if([istab isEqualToString:@"0"])
    {
        [self updateTabForIndex:0];
        [self showProfile];
    }
    if([istab isEqualToString:@"1"])
    {
        [self updateTabForIndex:1];
        //            [self educationDetail];
    }
    if([istab isEqualToString:@"2"])
    {
        [self updateTabForIndex:2];
        [self calForEmployement];
    }
    
    if([istab isEqualToString:@"3"])
    {
        [self updateTabForIndex:3];
        [self calForCertification];
    }
    if([istab isEqualToString:@"4"])
    {
        [self updateTabForIndex:4];
        [self calForAward];
    }
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
}


- (void)keyboardWasShown:(NSNotification *)notification
{
    
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    height = MIN(keyboardSize.height,keyboardSize.width);
    int width = MAX(keyboardSize.height,keyboardSize.width);
    
    prfvwscr.frame = CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70+height));
    
  NSLog(@"keyboard height is %d",height);
    
}




-(void)viewWillDisappear:(BOOL)animated
{
    if([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        [[self navigationController]setNavigationBarHidden:YES];
        
        
    }
     prfvwscr.frame = CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70));
    
    [super viewWillDisappear:animated];
    
}
-(void) showTabs
{
    NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
    
    selLabAr=[[NSMutableArray alloc]init];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, naviHght+stbarHght, screenWidth, 50)];
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[cc valueForKey:@"bodycolor"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    int scrollWidth = 120;
    [self.view addSubview:scrollView];
    
    NSMutableArray *tabAr=[[NSMutableArray alloc]init];
    [tabAr addObject:@"  Profile"];
    [tabAr addObject:@" Education"];
    [tabAr addObject:@"Employment"];
    [tabAr addObject:@"Certificates"];
    [tabAr addObject:@"  Awards"];
    
    
    
    coloAr=[[NSMutableArray alloc]init];
    /*[coloAr addObject:[cc valueForKey:@"Profcolor"]];
    [coloAr addObject:[cc valueForKey:@"Educolor"]];
    [coloAr addObject:[cc valueForKey:@"Emplcolor"]];
    [coloAr addObject:[cc valueForKey:@"Certcolor"]];
    [coloAr addObject:[cc valueForKey:@"Awardscolor"]];*/
    
    [coloAr addObject:[UIColor colorWithRed:112.0f/255.0f green:185.0f/255.0f blue:164.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:143.0f/255.0f green:151.0f/255.0f blue:93.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:189.0f/255.0f green:162.0f/255.0f blue:226.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:131.0f/255.0f green:168.0f/255.0f blue:210.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:233.0f/255.0f green:181.0f/255.0f blue:175.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f]];

    int xOffset = 0;
    
    
    
    linebarAr=[[NSMutableArray alloc]init];
    
    
    UILabel *linelab;
    for(int x=0;x<[tabAr count];x++)
    {
        
        UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(xOffset, 0, 130, 45)];
        view.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[coloAr objectAtIndex:x];
       // view.layer.borderColor = [UIColor grayColor].CGColor;
        [scrollView addSubview:view];
        view.tag=x;
        
        
        UILabel *labname=[[UILabel alloc]initWithFrame:CGRectMake(25, 13, view.frame.size.width, 20)];
        labname.textColor=[coloAr objectAtIndex:x];//[UIColor whiteColor];
        labname.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
        labname.text=[tabAr objectAtIndex:x];
        labname.textAlignment=NSTextAlignmentLeft;
        labname.tag=x;
        [view addSubview:labname];
        [selLabAr addObject:labname];
        
        
        linelab=[[UILabel alloc]initWithFrame:CGRectMake(xOffset, view.frame.size.height+view.frame.origin.y, view.frame.size.width,5)];
        linelab.backgroundColor=[UIColor redColor];//[coloAr objectAtIndex:x];
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
    int scpos= [istab intValue];
    NSLog(@"scroll position====%@",istab);
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
    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
}

-(void)changeBar:(int)x1
{
    
    NSLog(@"change bar===%d",x1);
    
    for(int x=0;x<[linebarAr count];x++)
    {
        UILabel *lab=[linebarAr objectAtIndex:x];
        if(x1==x)
        {
            lab.backgroundColor =[coloAr objectAtIndex:x];

        }
        else
        {
            lab.backgroundColor =[UIColor clearColor];
        }
    }
    
}

-(void)selectedTab:(id) sender
{
    limit = 0;
    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
    long idd =  ges.view.tag;
    [self updateTabForIndex:idd];
    
    
    
}


-(void)updateTabForIndex:(NSInteger)idd{
    eduAr = [NSMutableArray array];
    certificationAr = [NSMutableArray array];
    awardAr = [NSMutableArray array];
    employmntAr = [NSMutableArray array];
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

// /var/mobile/Containers/Data/Application/37CE7F31-9AB2-48F7-9230-53A1841BC2D8/Documents/resume.pdf
-(void) showProfile
{
    app=[[AllPopUp alloc]init];
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];

    mainScrollView1.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[bc valueForKey:@"bodycolor"];
    mainScrollView1.scrollEnabled = NO;
    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
    [self.view addSubview:mainScrollView1];
    
    isCallBack=@"19";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    if (self.strUserId) {
        [dic1 setObject:[NSString stringWithFormat:@"%d",self.strUserId] forKey:@"id"];
    }
    else{
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    }
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"showProfile" :@"":@"":dic1 :self];
    
    
}



-(void )addProfileimage:(NSArray*)ProfileAr1
{
    ProfileAr=ProfileAr1;
    self.navigationController.navigationBar.backgroundColor =[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    
    UIView * imageview=[[UIView alloc] initWithFrame:CGRectMake(10, 50, mainScrollView1.frame.size.width-20, 100)];
    imageview.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[UIColor colorWithRed:70/255.0f green:130/255.0f blue:180/255.0f alpha:1.0f];
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
    
    NSLog(@"image length===%@",ProfileAr1);
    
    if(url.length<12)
    {
        imggeter.image = [UIImage imageNamed:@"username.png"];
    }
    else
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if (imageData.length<=60)
            imggeter.image = [UIImage imageNamed:@"username.png"];
        else
            imggeter.image = [UIImage imageWithData:imageData];
    }
    
    imggeter.userInteractionEnabled = YES;
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, imggeter.frame.origin.y+imggeter.frame.size.height+8, 100, 22)];
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
#pragma mark here tab1
//here tab1
-(void)showProfileDetail:(UIView *)imgvw{
    //==========
    //about view gray
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
    aboutme.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    aboutme.textColor=[UIColor colorWithRed:128.0f/255 green:128.0f/255 blue:128.0f/255 alpha:1.0f];//[UIColor whiteColor];
    aboutme.textAlignment=NSTextAlignmentLeft;
    aboutme.backgroundColor=[UIColor clearColor];
    aboutme.editable=NO;

    [abouview addSubview:aboutme];
    
    UILabel *lineBelowDemo2=[[UILabel alloc]initWithFrame:CGRectMake(0, abouview.frame.size.height+abouview.frame.origin.y+40, mainScrollView1.frame.size.height+3, 1)];
    lineBelowDemo2.backgroundColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:0.50f];
    [mainScrollView1 addSubview:lineBelowDemo2];

    //=============
    //here added sub view
    
    UIView * demographic=[[UIView alloc] initWithFrame:CGRectMake(10, abouview.frame.size.height+abouview.frame.origin.y+10, mainScrollView1.frame.size.width/3.33, 145)];
    demographic.backgroundColor=[UIColor clearColor];
    demographic.clipsToBounds=YES;
    [mainScrollView1 addSubview:demographic];
    
    /*
     Detail Heading:- 128:128:128
     User Detail Text Color:- 183:182:182
     */
    
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
    male.text=@"Male";
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
        
        NSString *strDate =[[ProfileAr valueForKey:@"dob"] objectAtIndex:0];
        strDate = [strDate stringByReplacingOccurrencesOfString:@"undefined/undefined/" withString:@""];
        dob.text=strDate;
    }
    
    dob.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    dob.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    dob.textAlignment=NSTextAlignmentLeft;
    [demographic addSubview:dob];
    
    UILabel *stus=[[UILabel alloc] initWithFrame:CGRectMake( 0, dob.frame.size.height+dob.frame.origin.y, demographic.frame.size.width, 20)];
    stus.text=@"Single";//relationship  1
    
    NSString *io = [[ProfileAr valueForKey:@"relationship"] objectAtIndex:0];
    
    if (![io isEqual:[NSNull null]])
    {
        int dd=[io intValue];
        if(dd==0)
        {
            stus.text=@"Single";//relationship  1
        }
        else{
            stus.text=@"Married";//relationship  1
        }
        
    }
    stus.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    stus.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    stus.textAlignment=NSTextAlignmentLeft;
    [demographic addSubview:stus];
    
    
    //=====================
    
    UIView * about=[[UIView alloc] initWithFrame:CGRectMake(demographic.frame.size.width+demographic.frame.origin.x+10, abouview.frame.size.height+abouview.frame.origin.y+10, mainScrollView1.frame.size.width/3.33+5, 145)];
    about.backgroundColor=[UIColor clearColor];//[abot valueForKey:@"backcolor"];
    [mainScrollView1 addSubview:about];
    
    UILabel *abt=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, about.frame.size.width, 30)];
    abt.text=@"Address";
    abt.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    abt.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"Videocolor"];
    
    abt.textColor=[UIColor colorWithRed:128.0f/255 green:128.0f/255 blue:128.0f/255 alpha:1.0f];//[UIColor whiteColor];
    abt.textAlignment=NSTextAlignmentLeft;
    [about addSubview:abt];
    
    UILabel *address1=[[UILabel alloc] initWithFrame:CGRectMake( 0, abt.frame.size.height+abt.frame.origin.y+5, about.frame.size.width, 20)];
    if([mang checkStringNull:[[ProfileAr valueForKey:@"address"] objectAtIndex:0]])
    {
        NSString* result = [[[ProfileAr valueForKey:@"address"] objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        address1.text=result;
    }
    
    address1.font=[UIFont fontWithName:@"HelveticaNeue" size:11];
    address1.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[txt valueForKey:@"Tabstextcolor"];
    address1.textAlignment=NSTextAlignmentLeft;
    [about addSubview:address1];
    
    
    UILabel *city1=[[UILabel alloc] initWithFrame:CGRectMake( 0, address1.frame.size.height+address1.frame.origin.y, about.frame.size.width, 20)];
    if([mang checkStringNull:[[ProfileAr valueForKey:@"city"] objectAtIndex:0]])
    {
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
    if([mang checkStringNull:[[ProfileAr valueForKey:@"phone_no"] objectAtIndex:0]])
    {
        mob.text=[NSString stringWithFormat:@"%@",[[ProfileAr objectAtIndex:0] valueForKey:@"phone_no"]];
    }
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
    
    

    
    
    
    //=======

    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(0, contact.frame.size.height+contact.frame.origin.y+20, scrollView.frame.size.width, 45)];
    [save setTitle: @"Edit" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[txt valueForKey:@"Videocolor"];
    [save addTarget:self action:@selector(addProfile:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mainScrollView1 addSubview:save];
    
    
    //===========
    
    //initally 200 was 650
 //   mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,400);
    mainScrollView1.scrollEnabled=YES;
    
   // save= save+70;
    mainScrollView1.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, save.frame.size.height+save.frame.origin.y+20);

}

-(IBAction)addProfile:(id)sender
{
    isCallBack=@"18";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"showProfilePop" :@"" :@"" :dic1 :self ];
    
    
    
}

-(void) educationDetail
{
    selectedTab=1;
    
    isCallBack=0;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    
   // NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    
    if (self.strUserId) {
        [dic1 setObject:[NSString stringWithFormat:@"%d",self.strUserId] forKey:@"id"];
    }
    else{
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    }

     [dic1 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Education" :@"showEdu" :@"":@"":dic1 :self];
}
#pragma mark here tab2

//here tab2
-(void) showEducation
{
    if (limit>0) {
        [mainScrollView1 removeFromSuperview];
    }
    NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
    
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
    mainScrollView1.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[cc valueForKey:@"bodycolor"];
    mainScrollView1.delegate = self;
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight-20);
    [self.view addSubview:mainScrollView1];
    

    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 45)];
    [save setTitle: @"Add Education" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor clearColor];//[cc valueForKey:@"popupcolor"];
    [save addTarget:self action:@selector(addEduProfile:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:182.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [save setFont: [UIFont fontWithName:@"HelveticaNeue" size:15]];
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
        inst.text=[NSString stringWithFormat:@"%@",[[eduAr objectAtIndex:x] valueForKey:@"college_name"]];
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
        strm.text=[NSString stringWithFormat:@"%@",[[eduAr objectAtIndex:x] valueForKey:@"stream"]];
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
        Subjects.text=[NSString stringWithFormat:@"%@",[[eduAr objectAtIndex:x] valueForKey:@"subjects"]];
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
        marks1.text=[NSString stringWithFormat:@"%@",[[eduAr objectAtIndex:x] valueForKey:@"marks"]];
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
        add.text=[NSString stringWithFormat:@"%@",[[[[[eduAr objectAtIndex:x] valueForKey:@"address"] stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[eduAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[eduAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[eduAr objectAtIndex:x] valueForKey:@"country"] ]]];
        add.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        add.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        add.editable=NO;
        add.backgroundColor=[cc valueForKey:@"backcolor"];
        add.textAlignment=NSTextAlignmentLeft;
        add.editable=NO;
        [viewDetails addSubview:add];

        
        ///////////////////////

        
        
        
        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-80, 5, 20, 20)];
        update.backgroundColor=[UIColor clearColor] ;
        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
        update.tag=[[[eduAr objectAtIndex:x] valueForKey:@"edu_id"] intValue];
        [edu addSubview:update];
        
        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateEducation:)];
        [updateges setNumberOfTouchesRequired:1];
        [updateges setDelegate:self];
        update.userInteractionEnabled = YES;
        [update addGestureRecognizer:updateges];
        
        NSString * eduid=[[eduAr objectAtIndex:x] valueForKey:@"edu_id"];
        
        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
        delete.backgroundColor=[UIColor clearColor] ;
        delete.image = [UIImage imageNamed:@"deleteblack"];
        [edu addSubview:delete];
        delete.tag=[eduid intValue];
        
        
        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteEducation:)];
        [deleteges setNumberOfTouchesRequired:1];
        [deleteges setDelegate:self];
        delete.userInteractionEnabled = YES;
        [delete addGestureRecognizer:deleteges];
        
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
     [dic1 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    if (self.strUserId) {
        [dic1 setObject:[NSString stringWithFormat:@"%d",self.strUserId] forKey:@"id"];
    }
    else{
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    }
    [[SavePrefrences sharedInstance].skthand emitData:@"Employment" :@"showEmp" :@"":@"":dic1 :self];
}
#pragma mark here tab3

//here tab3
-(void) showEmployment:(NSArray *) employmntAr
{
    if (limit>0) {
        [mainScrollView1 removeFromSuperview];
    }
    NSMutableDictionary *bb=[SavePrefrences sharedInstance].colorDictionry;
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
    
     mainScrollView1.delegate = self;
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
    [mainScrollView1 addSubview:save];
    
    
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
        add.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        add.text=[NSString stringWithFormat:@" %@",[[[[[employmntAr objectAtIndex:x] valueForKey:@"address"] stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[employmntAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[employmntAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[employmntAr objectAtIndex:x] valueForKey:@"country"] ]]];
        add.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[bb valueForKey:@"Tabstextcolor"];
        add.userInteractionEnabled=NO;
        add.textAlignment=NSTextAlignmentLeft;
        [edu addSubview:add];
        
        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(0, add.frame.size.height+add.frame.origin.y,edu.frame.size.width, 40)];
        jd.text=[NSString stringWithFormat:@"%@ ",[[employmntAr objectAtIndex:x] valueForKey:@"job_desc"]];
        jd.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        jd.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[bb valueForKey:@"Tabstextcolor"];
        jd.editable=NO;
        jd.backgroundColor=[bb valueForKey:@"backcolor"];
        jd.textAlignment=NSTextAlignmentLeft;
        jd.editable=NO;

        [edu addSubview:jd];
        
        
        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-80, 5, 20, 20)];
        update.backgroundColor=[UIColor clearColor];
        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
        update.tag=[[[employmntAr objectAtIndex:x] valueForKey:@"emp_id"] intValue];
        [edu addSubview:update];
        
        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateEmployement:)];
        [updateges setNumberOfTouchesRequired:1];
        [updateges setDelegate:self];
        update.userInteractionEnabled = YES;
        [update addGestureRecognizer:updateges];
        
        NSString *emplid=[[employmntAr valueForKey:@"emp_id"]objectAtIndex:x];
        
        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
        delete.backgroundColor=[UIColor clearColor] ;
        delete.image = [UIImage imageNamed:@"deleteblack"];
        [edu addSubview:delete];
        delete.tag=[emplid intValue];
        
        
        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteEmployement:)];
        [deleteges setNumberOfTouchesRequired:1];
        [deleteges setDelegate:self];
        delete.userInteractionEnabled = YES;
        [delete addGestureRecognizer:deleteges];
        
         yinc=yinc+155;
        
    }
    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
}





-(void) calForCertification
{
    selectedTab=3;
    
    isCallBack=@"2";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    if (self.strUserId) {
        [dic1 setObject:[NSString stringWithFormat:@"%d",self.strUserId] forKey:@"id"];
    }
    else{
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    }
     [dic1 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Certification" :@"showCert" :@"":@"":dic1 :self];
    
}
#pragma mark here tab4

//here tab4
-(void) showCertification
{
    if (limit>0) {
        [mainScrollView1 removeFromSuperview];
    }
    
    NSMutableDictionary *hh=[SavePrefrences sharedInstance].colorDictionry;
    
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
     mainScrollView1.delegate = self;
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
    [mainScrollView1 addSubview:save];
    
    
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
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
        if(Img.length<12)
        {
            certimg.image = [UIImage imageNamed:Img];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
            if (imageData.length<=0)
                certimg.image = [UIImage imageNamed:@"username.png"];
            else
                certimg.image = [UIImage imageWithData:imageData];
            
        }

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
        
        
        dateView1.text= [NSString stringWithFormat:@" %@",[[certificationAr objectAtIndex:x] valueForKey:@"cert_when"]];
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
        jd.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        jd.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[hh valueForKey:@"Tabstextcolor"];
        jd.editable=NO;
        jd.scrollEnabled=YES;
        jd.backgroundColor=[hh valueForKey:@"backcolor"];
        jd.textAlignment=NSTextAlignmentLeft;
        jd.editable=NO;
        [edu addSubview:jd];
        
        
        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-80, 5, 20, 20)];
        update.backgroundColor=[UIColor clearColor] ;
        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
        update.tag=[[[certificationAr objectAtIndex:x] valueForKey:@"c_id"] intValue];
        [edu addSubview:update];
        
        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateCertification:)];
        [updateges setNumberOfTouchesRequired:1];
        [updateges setDelegate:self];
        update.userInteractionEnabled = YES;
        [update addGestureRecognizer:updateges];
        
        NSString *certid=[[certificationAr objectAtIndex:x] valueForKey:@"c_id"];
        
        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
        delete.backgroundColor=[UIColor clearColor] ;
        delete.image = [UIImage imageNamed:@"deleteblack"];
        [edu addSubview:delete];
        delete.tag=[certid intValue];
        
        
        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteCertification:)];
        [deleteges setNumberOfTouchesRequired:1];
        [deleteges setDelegate:self];
        delete.userInteractionEnabled = YES;
        [delete addGestureRecognizer:deleteges];
        
         yinc=yinc+230;
        
    }
    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
    
    
}
-(void) showcertifulldetail:(id)sender
{
    
    UITapGestureRecognizer * tg=(UITapGestureRecognizer *)sender;
    int tag=(int)tg.view.tag;
    
      NSString * certificate_name= [[certificationAr objectAtIndex:tag] valueForKey:@"certificate_name"];
      NSString * image= [[certificationAr objectAtIndex:tag] valueForKey:@"image"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    
    
    NSDate *dte = [dateFormat dateFromString:[[certificationAr objectAtIndex:tag] valueForKey:@"cert_when"]];
    
    NSDateFormatter *dt = [[NSDateFormatter alloc] init];
    [dt setDateFormat:@"MM/dd/yyyy"];
    
    
    
    NSString * cert_when=[NSString stringWithFormat:@" %@",[[certificationAr objectAtIndex:tag] valueForKey:@"cert_when"]];;;
      NSString * name_org= [[certificationAr objectAtIndex:tag] valueForKey:@"name_org"];
      NSString * subject= [[certificationAr objectAtIndex:tag] valueForKey:@"subject"];
      NSString * descrip= [[certificationAr objectAtIndex:tag] valueForKey:@"c_desc"];
    

    if(app==nil)
    {
        app=[[AllPopUp alloc]init];
    }
    
    [app showFullDetail:@"Certificate Detail" :@"" :descrip :cert_when :name_org :certificate_name :image :self];
    
    
  
    
    
//    "c_id" = 117;
//    "cert_when" = "6-23-2016";
//    "certificate_name" = "Hi value";
//    city = Eshkashem;
//    country = Afghanistan;
//    image = "/upload/268/certificateimg/undefined";
//    "name_org" = Pi;
//    state = Badakhshan;
//    subject = Math;
//    "u_id" = 268;
//    descrip
    
    
    
}



-(void) calForAward
{
    selectedTab=4;
    isCallBack=@"3";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    if (self.strUserId) {
        [dic1 setObject:[NSString stringWithFormat:@"%d",self.strUserId] forKey:@"id"];
    }
    else{
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    }
     [dic1 setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Awards" :@"showAwards" :@"":@"":dic1 :self];
    
}
#pragma mark here tab5

//here tab5
-(void) showAward
{
    if (limit>0) {
        [mainScrollView1 removeFromSuperview];
    }
    
    NSMutableDictionary *jj=[SavePrefrences sharedInstance].colorDictionry;
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, naviHght+stbarHght+50, screenWidth, screenHeight-(naviHght+stbarHght+50))];
     mainScrollView1.delegate = self;
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
    [mainScrollView1 addSubview:save];
    
    
    int yinc=save.frame.size.height+save.frame.origin.y+20;
    for(int x=0;x<[awardAr count];x++)
    {
        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(10, yinc, mainScrollView1.frame.size.width-20, 180)];
        edu.backgroundColor=[UIColor clearColor];//[jj valueForKey:@"backcolor"];
        [mainScrollView1 addSubview:edu];
        
        
        UITapGestureRecognizer *shofulldetail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFullDetail:)];
        [shofulldetail setNumberOfTouchesRequired:1];
        edu.tag=x;
        [shofulldetail setDelegate:self];
        edu.userInteractionEnabled = YES;
        [edu addGestureRecognizer:shofulldetail];
        
        
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
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
        if(Img.length<12)
        {
            certimg.image = [UIImage imageNamed:Img];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
            if (imageData.length<=0)
                certimg.image = [UIImage imageNamed:@"username.png"];
            else
                certimg.image = [UIImage imageWithData:imageData];
            
        }
        
        

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
        
        
        aww.text= [NSString stringWithFormat:@" %@",[[awardAr objectAtIndex:x] valueForKey:@"award_when"]];
        
       // aww.text=[[awardAr objectAtIndex:x] valueForKey:@"award_when"];
        aww.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        aww.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];//[jj valueForKey:@"Tabstextcolor"];
        aww.textAlignment=NSTextAlignmentLeft;
        [viewDetails addSubview:aww];
        
        
        
        UITextView *add=[[UITextView alloc] initWithFrame:CGRectMake(addressView.frame.size.width, dateView.frame.size.height+dateView.frame.origin.y-3,viewDetails.frame.size.width-addressView.frame.size.width-10, 60)];
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

        
        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-80, 5, 20, 20)];
        update.backgroundColor=[UIColor clearColor] ;
        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
        update.tag=[[[awardAr objectAtIndex:x] valueForKey:@"id"] intValue];
        [edu addSubview:update];
        
        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateAward:)];
        [updateges setNumberOfTouchesRequired:1];
        [updateges setDelegate:self];
        update.userInteractionEnabled = YES;
        [update addGestureRecognizer:updateges];
        
        NSString *awrdid=[[awardAr objectAtIndex:x] valueForKey:@"id"];
        
        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
        delete.backgroundColor=[UIColor clearColor] ;
        delete.image = [UIImage imageNamed:@"deleteblack"];
        [edu addSubview:delete];
        delete.tag=[awrdid intValue];
        
        
        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAward:)];
        [deleteges setNumberOfTouchesRequired:1];
        [deleteges setDelegate:self];
        delete.userInteractionEnabled = YES;
        [delete addGestureRecognizer:deleteges];
        
 
        
        
        yinc=yinc+220;
        
    }
    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
    
    
}

-(void)showFullDetail:(id)sender
{
    UITapGestureRecognizer * gest=(UITapGestureRecognizer *)sender;
    int tag=(int)gest.view.tag;
     NSString * add=[[awardAr objectAtIndex:tag] valueForKey:@"address"];
     NSString * award_desc=[[awardAr objectAtIndex:tag] valueForKey:@"award_desc"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    
    
    NSDate *dte =[[awardAr objectAtIndex:tag] valueForKey:@"award_when"];
    
    NSDateFormatter *dt = [[NSDateFormatter alloc] init];
    [dt setDateFormat:@"MM/dd/yyyy"];
    
    

    
     NSString * award_when=[[awardAr objectAtIndex:tag] valueForKey:@"award_when"];
     NSString * name_of_comp=[[awardAr objectAtIndex:tag] valueForKey:@"name_of_comp"];
     NSString * presented_by=[[awardAr objectAtIndex:tag] valueForKey:@"presented_by"];
      NSString * image=[[awardAr objectAtIndex:tag] valueForKey:@"image"];
    
    if(app==nil)
        app=[[AllPopUp alloc]init];
 
    NSLog(@"image path====%@",image);
    
    
    [app showFullDetail:@"Award Detail":add:award_desc:award_when:name_of_comp:presented_by:image:self];
    
    
    
}


-(void) addEmployemnt
{
    
    
    isCallBack=@"9";
    app=[[AllPopUp alloc]init];
    [app addProfile:self];
    
    
}

-(void) updateEmployement:(id)sender
{
    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
    int idd=(int)ges.view.tag;
    isCallBack=@"10";
    app=[[AllPopUp alloc]init];
    
    [app editProfile:self :employmntAr :idd];
    
    NSLog(@"id of employment update %d",idd);
}
-(void) deleteEmployement:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    EmployId=(int)tg.view.tag;
    
    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alrt show];
    [self alertView:alrt clickedButtonAtIndex:2];
    
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    NSLog(@"value of selected tab %d",selectedTab);
    
    if (buttonIndex == 1)
    {
        NSLog(@"ok");
        if(selectedTab==1)
        {
            isCallBack=@"20";
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
            [dic1 setValue:[NSString stringWithFormat:@"%d",EducId] forKey:@"eid"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Education" :@"delEdu" :@"":@"":dic1 :self];
        }
        if(selectedTab==2)
        {
            isCallBack=@"11";
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
            [dic1 setValue:[NSString stringWithFormat:@"%d",EmployId] forKey:@"emid"];
            [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Employment" :@"delEmp" :@"":@"":dic1 :self];
        }
        if(selectedTab==3)
        {
            isCallBack=@"14";
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
            [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
            [dic1 setValue:[NSString stringWithFormat:@"%d",CertID] forKey:@"cid"];
            
            [[SavePrefrences sharedInstance].skthand emitData:@"Certification" :@"delCert" :@"":@"":dic1 :self];
        }
        if(selectedTab==4)
        {
            
            isCallBack=@"22";
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
            [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
            [dic1 setValue:[NSString stringWithFormat:@"%d",awardId] forKey:@"aid"];
            
            [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"delAward" :@"":@"":dic1 :self];
        }
    }
    else if(buttonIndex==0)
    {
        NSLog(@"cancel");
        [alrt dismissWithClickedButtonIndex:0 animated:YES];
        
    }
}




-(void) addCertification
{
    isCallBack=@"12";
    app=[[AllPopUp alloc]init];
    [app AddCertificateDetails:self ];
    NSLog(@"Certification add ");
}
-(void) updateCertification:(id)sender
{
    isCallBack=@"13";
    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
    int idd=(int)ges.view.tag;
    NSLog(@"id of Certification update %d",idd);
    
    
    if(app==nil)
        app=[[AllPopUp alloc]init];
    
    [app EditCertificateDetails :self :idd:certificationAr];
    
}
-(void) deleteCertification:(id)sender
{
    
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    CertID=(int)tg.view.tag;
    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alrt show];
    [self alertView:alrt clickedButtonAtIndex:2];
    
}



-(void) addAward
{
    isCallBack=@"15";
    app=[[AllPopUp alloc]init];
    [app AddAward:self];
}
-(void) updateAward:(id)sender
{
    isCallBack=@"16";
    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
    int idd=(int)ges.view.tag;
    app=[[AllPopUp alloc]init];
    [app EditAward:self :awardAr :idd];
    
    
    NSLog(@"id of Award update %d",idd);
}
-(void) deleteAward:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    awardId=(int)tg.view.tag;
    NSLog(@"value od awrdid is %d",awardId);
    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alrt show];
    [self alertView:alrt clickedButtonAtIndex:2];
    
}



-(IBAction)addEduProfile:(id)sender
{
    [self addEducationDetails:0];
    NSLog(@"doneee Edit education profile");
}

-(void) updateEducation:(id)sender
{
    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
    selId=ges.view.tag;
    
    [self addEducationDetails:(int) 1];
    
    NSLog(@"id of eduction update %d",selId);
}
-(void) deleteEducation:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    EducId=(int)tg.view.tag;
    
    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alrt show];
    [self alertView:alrt clickedButtonAtIndex:2];
    
}


-(IBAction)editProfile:(id)sender
{
    NSLog(@"doneee Edit Profile");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)chooseOption
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Mode:"preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    UIAlertAction* drivingAction = [UIAlertAction actionWithTitle:@"Use Camera" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action){
                                                              [self openGallary];
                                                              
                                                          }];
    
    UIAlertAction *walkingAction = [UIAlertAction actionWithTitle:@"Use Gallary" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action){
                                                              [self openCamera];
                                                              
                                                          }];
    
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:drivingAction];
    [alert addAction:walkingAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void) openCamera
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }];
    }
    else{
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

-(void) openGallary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [self presentModalViewController:imagePicker animated:YES];
        randomImgName = [self randomImagName];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Camera Unavailable"  message:@"Unable to find a camera on your device."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData* data = UIImageJPEGRepresentation(outputImage, 0.7f);
    imgBuffer= [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [picker dismissViewControllerAnimated:YES completion:nil];
    randomImgName = [self randomImagName];
    
    imggeter.image = outputImage;
    
    
    [self  changeImg];
    
    
}

-(void) changeImg
{
    isCallBack=@"-1";
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:imgBuffer forKey:@"buffer1"];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setObject:randomImgName forKey:@"pic"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"SaveProPic" :@"" :@"no" :dic :self ];
   [self performSelector:@selector(reloadHome) withObject:self afterDelay:1.0 ];
    
}




-(NSString *) randomImagName
{
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
    for (int i=0; i<12; i++)
    {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    NSString *rnd=[randomString stringByAppendingString:@".png"];
    
    return rnd;
}






-(void) addEducationDetails:(int) isup
{
    NSString *iname,*iadd,*icoun, *isate,*icity, *iboard,*imarks,*istream,*isub,*iyear,*istitle;
    
    if(isup==0)
    {
        iname=@"Institute/College Name";
        iadd=@"Address";
        icoun= @"Select Country";
        isate=@"Select State";
        icity=@"Select City";
        iboard=@"Board";
        imarks=@"Marks";
        istream=@"Stream";
        isub=@"Subject";
        iyear=@"Year";
        istitle=@"Education Details";
    }
    
    else if(isup==1)
    {
        for(int x=0;x<[eduAr count];x++)
        {
            int pre=[[[eduAr objectAtIndex:x] valueForKey:@"edu_id"] intValue];
            if(selId==pre)
            {
                iname=[[eduAr objectAtIndex:x] valueForKey:@"college_name"];
                iadd=[[eduAr objectAtIndex:x] valueForKey:@"address"];;
                icoun= [[eduAr objectAtIndex:x] valueForKey:@"country"];
                isate=[[eduAr objectAtIndex:x] valueForKey:@"state"];
                icity=[[eduAr objectAtIndex:x] valueForKey:@"city"];
                iboard=[[eduAr objectAtIndex:x] valueForKey:@"university"];
                imarks=[NSString stringWithFormat:@"%@",[[eduAr objectAtIndex:x] valueForKey:@"marks"]];
                istream=[[eduAr objectAtIndex:x] valueForKey:@"stream"];
                isub=[[eduAr objectAtIndex:x] valueForKey:@"subjects"];
                iyear=[NSString stringWithFormat:@"%@",[[eduAr objectAtIndex:x] valueForKey:@"year"]];
                istitle=@"Education Details";
                break;
            }
        }
    }
    
    NSMutableDictionary *educlr=[SavePrefrences sharedInstance].colorDictionry;
    UIColor *color = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,screenWidth,screenHeight)];
    [self.view addSubview:prMainView];
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    
    
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, naviHght+15, prMainView.frame.size.width-40, 40+20)];
    NameLabel.text=istitle;
    NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    NameLabel.layer.cornerRadius=10;
    NameLabel.clipsToBounds = YES;
    
    

    NameLabel.textAlignment=NSTextAlignmentCenter;
    [prMainView addSubview:NameLabel];
    
    
    prfvwscr = [[UIScrollView alloc]initWithFrame:CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
    prfvwscr.delegate = self;
    prfvwscr.scrollEnabled = YES;
    prfvwscr.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[educlr valueForKey:@"Scrollcolor"];
    prfvwscr.layer.cornerRadius=10;
    prfvwscr.clipsToBounds = YES;
    [prMainView addSubview:prfvwscr];
    
    name=[[UITextField alloc] initWithFrame:CGRectMake(20, 5, prfvwscr.frame.size.width-40, 40)];
    name.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    name.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [name setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    name.delegate=self;
    name.placeholder = @"Institute/College Name";
    
    UIView *padding1   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    name.leftView = padding1 ;
    name.leftViewMode = UITextFieldViewModeAlways;

    
    [prfvwscr addSubview:name];
    if(isup==0)
        name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:iname attributes:@{NSForegroundColorAttributeName: color}];
    else if(isup==1)
        name.text = iname;
    //[NSString stringWithFormat:@"  %@",
    country=[[UILabel alloc] initWithFrame:CGRectMake(20, name.frame.size.height+name.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    country.text=[NSString stringWithFormat:@"  %@",icoun];
   // country.backgroundColor=[UIColor whiteColor];
    country.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    country.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
   // country.textColor=[educlr valueForKey:@"Scrollcolor"];
    country.clipsToBounds=YES;
    [prfvwscr addSubview:country];
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:cityreg];
    
    
    sate=[[UILabel alloc] initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    sate.text=[NSString stringWithFormat:@"  %@",isate];
  //  sate.backgroundColor=[UIColor whiteColor];
    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    sate.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    sate.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

  //  sate.textColor=[educlr valueForKey:@"Scrollcolor"];
    sate.clipsToBounds=YES;
    [prfvwscr addSubview:sate];
    
    UITapGestureRecognizer *stateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [stateges setNumberOfTouchesRequired:1];
    [stateges setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:stateges];
    
    
    city=[[UILabel alloc] initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    city.text=[NSString stringWithFormat:@"  %@",icity];
   // city.backgroundColor=[UIColor whiteColor];
    city.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    city.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
   // city.textColor=[educlr valueForKey:@"Scrollcolor"];
    city.clipsToBounds=YES;
    [prfvwscr addSubview:city];
    
    
    UITapGestureRecognizer *cityges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityges setNumberOfTouchesRequired:1];
    [cityges setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityges];
    
    
    address=[[UITextField alloc] initWithFrame:CGRectMake(20, city.frame.size.height+city.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
      address.placeholder = @"Address";
   // address.backgroundColor=[UIColor whiteColor];
  //  address.textColor=[educlr valueForKey:@"Scrollcolor"];
    address.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    address.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    UIView *padding12   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    address.leftView = padding12 ;
    address.leftViewMode = UITextFieldViewModeAlways;

    [address setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    
    
    address.delegate=self;
    [prfvwscr addSubview:address];
    
    if(isup==0)
        address.attributedPlaceholder=[[NSAttributedString alloc] initWithString:iadd attributes:@{NSForegroundColorAttributeName: color}];
    else if(isup==1)
        address.text = iadd;
    
    
    
    
    board=[[UITextField alloc] initWithFrame:CGRectMake(20, address.frame.size.height+address.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
     board.placeholder = @"Board";
  //  board.backgroundColor=[UIColor whiteColor];
   // board.textColor=[educlr valueForKey:@"Scrollcolor"];
    [board setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    board.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    board.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    UIView *padding13   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    board.leftView = padding13 ;
    board.leftViewMode = UITextFieldViewModeAlways;

    board.delegate=self;
    [prfvwscr addSubview:board];
    if(isup==0)
        board.attributedPlaceholder=[[NSAttributedString alloc] initWithString:iboard attributes:@{NSForegroundColorAttributeName: color}];
    else if(isup==1)
        board.text = iboard;
    
    marks=[[UITextField alloc] initWithFrame:CGRectMake(20, board.frame.size.height+board.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    marks.placeholder = @"Marks";
   // marks.backgroundColor=[UIColor whiteColor];
   // marks.textColor=[educlr valueForKey:@"Scrollcolor"];
    [marks setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    
    UIView *padding14   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    marks.leftView = padding14 ;
    marks.leftViewMode = UITextFieldViewModeAlways;

    marks.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    marks.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    marks.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    marks.delegate=self;
    [prfvwscr addSubview:marks];
    if(isup==0)
        marks.attributedPlaceholder=[[NSAttributedString alloc] initWithString:imarks attributes:@{NSForegroundColorAttributeName: color}];
    else if(isup==1)
        marks.text = imarks;
    
    
    
    stream=[[UITextField alloc] initWithFrame:CGRectMake(20, marks.frame.size.height+marks.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
     stream.placeholder = @"Stream";
   // stream.backgroundColor=[UIColor whiteColor];
   // stream.textColor=[educlr valueForKey:@"Scrollcolor"];
    [stream setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    stream.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    stream.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    UIView *padding15   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    stream.leftView = padding15 ;
    stream.leftViewMode = UITextFieldViewModeAlways;

    stream.delegate=self;
    [prfvwscr addSubview:stream];
    if(isup==0)
        stream.attributedPlaceholder=[[NSAttributedString alloc] initWithString:istream attributes:@{NSForegroundColorAttributeName: color}];
    else if(isup==1)
        stream.text = istream;
    
    
    subjects=[[UITextField alloc] initWithFrame:CGRectMake(20, stream.frame.size.height+stream.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    subjects.placeholder = @"Subject";

  //  subjects.backgroundColor=[UIColor whiteColor];
    [subjects setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
   // subjects.textColor=[educlr valueForKey:@"Scrollcolor"];
    UIView *padding16   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    subjects.leftView = padding16 ;
    subjects.leftViewMode = UITextFieldViewModeAlways;

    subjects.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    subjects.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    subjects.delegate=self;
    subjects.tag=7;
    [prfvwscr addSubview:subjects];
    
    if(isup==0)
        subjects.attributedPlaceholder=[[NSAttributedString alloc] initWithString:isub attributes:@{NSForegroundColorAttributeName: color}];
    else if(isup==1)
        subjects.text = isub;
    
    
    year=[[UILabel alloc] initWithFrame:CGRectMake(20, subjects.frame.size.height+subjects.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    year.text=[NSString stringWithFormat:@"  %@",iyear];
    
  //  year.backgroundColor=[UIColor whiteColor];
    [year setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
 //   year.textColor=[educlr valueForKey:@"Scrollcolor"];
    
    year.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    year.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];

    year.clipsToBounds=YES;
    [prfvwscr addSubview:year];
    
    UITapGestureRecognizer *yearges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yearSel:)];
    [yearges setNumberOfTouchesRequired:1];
    [yearges setDelegate:self];
    year.userInteractionEnabled = YES;
    [year addGestureRecognizer:yearges];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(40, year.frame.size.height+year.frame.origin.y+10, prfvwscr.frame.size.width/2-40, 45)];
    [save setTitle: @"Add" forState: UIControlStateNormal];
    save.tag=isup;
    save.backgroundColor=[UIColor clearColor];//[educlr valueForKey:@"Yellowbtncolor"];
    [save addTarget:self action:@selector(saveEducationProfile:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [prfvwscr addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, year.frame.size.height+year.frame.origin.y+10, prfvwscr.frame.size.width/2-40, 45)];
    [cancel setTitle: @"Close" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor clearColor];//[educlr valueForKey:@"Yellowbtncolor"];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [prfvwscr addSubview:cancel];
    
    prfvwscr.contentSize=CGSizeMake(prfvwscr.frame.size.width, 600);
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if(textField==marks || textField==stream || textField==subjects)
    {
       [prfvwscr setContentOffset:CGPointMake(0,height) animated:YES];
    }
    
    
  
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if(textField==marks|| textField==stream || textField==subjects)
    {
        [prfvwscr setContentOffset:CGPointMake(0,0) animated:YES];
    }
    
  //  if (marks.text.intValue > 100) {
    //    UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Valid Percantage" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
     //   [alrt show];
   // }
    
}
-(IBAction)cancel:(id)sender
{

    
    
    [prMainView removeFromSuperview];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSLog(@"herreeeee");
    
    if(textField==name || textField==board  || textField==stream )
    {
        
        NSString *validnumbers=@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz";
        
        NSCharacterSet * notDigits = [NSCharacterSet characterSetWithCharactersInString:validnumbers];
        if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        {
            if(range.length == 1)
            {
                string=@" ";
            }
            else
            {
                UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Alphabets" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alrt show];
                return NO;//not correct return 0
                
            }
        }
        
        if([string length]>40)
        {
            
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter characters less than 40" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
            return NO;//not correct return 0
        }
        return YES;
    }
    
    if(textField==marks)
    {
    NSString *validnumbers=@"0123456789.";
    
    NSCharacterSet * ValidDigits = [NSCharacterSet characterSetWithCharactersInString:validnumbers];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:string];
    
    BOOL stringIsValid = [ValidDigits isSupersetOfSet:characterSetFromTextField];
    if(!stringIsValid)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter only numbers" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return NO;//not correct return 0
    }
//    if(![self validateStringContainsNumbersOnly:marks.text])
//    {
//        
//        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Valid Percantage" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alrt show];
//        marks.text=@" ";
//        return NO;
//    }
//    else
//    {
        return YES;
   // }
    return  stringIsValid;
    
    }
    return YES;
    
}

-(BOOL) validateStringContainsNumbersOnly:(NSString*)string
{
    
    NSString *validnumbers=@"0123456789.";
    
    NSCharacterSet * ValidDigits = [NSCharacterSet characterSetWithCharactersInString:validnumbers];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:string];
    
    BOOL stringIsValid = [ValidDigits isSupersetOfSet:characterSetFromTextField];
    if(!stringIsValid)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter only numbers" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return NO;//not correct return 0
    }
    if([string intValue]<=0  || [string intValue]>=100)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Valid Percantage" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return NO;
    }
    return  stringIsValid;
    
}


-(IBAction)saveEducationProfile:(id)sender
{
    UIButton *bt=sender;
    if([av checkNull:name])
    {
        if([av checkNull:address])
        {
            if([av checkCombo:country] &&[av checkCombo:sate] &&[av checkCombo:city])
            {
                if([av checkNull:board])
                {
                    if([av checkNull:marks])
                    {
                        if (marks.text.intValue > 100) {
                            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Valid Percantage" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                            [alrt show];
                            
                        } else if([av checkNull:stream]&&[av checkNull:subjects]){
                            if([av checkCombo:year])
                            {
                                   NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
                                    [dic1 setValue:@"1" forKey:@"k"];
                                    [dic1 setValue: country.text forKey:@"cont"];
                                    [dic1 setValue:sate.text forKey:@"state"];
                                    [dic1 setValue:city.text forKey:@"city"];
                                    [dic1 setValue :name.text  forKey:@"org"];
                                    [dic1 setValue:board.text forKey:@"board"];
                                    [dic1 setValue:marks.text forKey:@"marks"];
                                    [dic1 setValue:stream.text forKey:@"stream"];
                                    [dic1 setValue:subjects.text forKey:@"sub"];
                                    [dic1 setValue:year.text forKey:@"yr"];
                                    [dic1 setValue:[NSString stringWithFormat:@"%d",selId]forKey:@"eid"];
                                    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
                                    [dic1 setValue:address.text forKey:@"add"];
                                    
                                    if(bt.tag==0)
                                    {
                                        isCallBack=@"7";
                                        [[SavePrefrences sharedInstance].skthand emitData:@"Education" :@"SaveEdu" :@"":@"":dic1 :self];
                                        [prMainView removeFromSuperview];
                                    }
                                    else if (bt.tag==1)
                                    {
                                        isCallBack=@"8";
                                        [[SavePrefrences sharedInstance].skthand emitData:@"Education" :@"updateEdu" :@"":@"":dic1 :self];
                                        
                                        [prMainView removeFromSuperview];
                                        
                                    }
                                [self updateTabForIndex:1];
                                    NSLog(@"Send to server");
                                
                            }
                        }
                    }
                }
            }
            
        }     }
    
    
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
    SelectCountry * sc=[[SelectCountry alloc]init];
    [sc getState:self:cid];
    
}


-(void)citySel:(id)sender
{
    isCallBack=@"6";
    SelectCountry * sc=[[SelectCountry alloc]init];
    [sc getCity:self:stid];
}

-(void) showCountry
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Country:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[countryAr count];x++)
    {
        NSString *stname=[[countryAr objectAtIndex:x] valueForKey:@"countryName"];
        NSString *cid1=[[countryAr objectAtIndex:x] valueForKey:@"countryID"];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            country.text=[NSString stringWithFormat:@"%@",stname];
                                            sate.text=@"Select State";
                                            city.text=@"Select City";
                                            cid=cid1;
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
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
                                            sate.text=[NSString stringWithFormat:@"%@",stname];
                                            stid=sid1;
                                            city.text=@"Select City";
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
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
                                            city.text=[NSString stringWithFormat:@"%@",cityName];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}




-(void)yearSel:(id)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select city:"preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSMutableArray *cityAr=[[NSMutableArray alloc]init];
    [cityAr addObject:@"abc"];
    
   NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
   NSInteger yearvalue = [components year];
    
    for(int x=1965;x<yearvalue+1;x++)
    {
        NSString *stname=[NSString stringWithFormat:@"%d",x];
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            NSLog(@"title value %@",tile);
                                            year.text=[NSString stringWithFormat:@"  %@",stname];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)reloadHome{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:nil];
   
}
-(void) callBack:(NSArray *)META  :(NSArray *)DATA
{
    int isCallBack1=[isCallBack intValue];
    
    NSLog(@"callback======%d",isCallBack1);
    if (isCallBack1==-1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
    }
    
    else if(isCallBack1==0)
    {
        //MRUG
        NSArray * md=[META valueForKey:@"data"];
        NSArray *aUserEdu = [md valueForKey:@"userEdu"];
        [eduAr addObjectsFromArray:aUserEdu];
        [self showEducation];
    }
    else if (isCallBack1==1)
    {
        
        NSArray * md=[META valueForKey:@"data"];
        [employmntAr addObjectsFromArray:[md valueForKey:@"userEmp"]];
        //employmntAr=[md valueForKey:@"userEmp"];
        NSLog(@"data in employment array is %@",employmntAr);
        [self showEmployment:employmntAr];
    }
    
    else if (isCallBack1==2)
    {
        
        NSArray * md=[META valueForKey:@"data"];
            //[certificationAr addObjectsFromArray:[md valueForKey:@"userEmp"]];
         [certificationAr addObjectsFromArray:[md valueForKey:@"userEmp"]];
       // certificationAr=[md valueForKey:@"userEmp"];
        [self showCertification];
        
    }
    
    else if (isCallBack1==3)
    {
        NSArray * md=[META valueForKey:@"data"];
        [awardAr addObjectsFromArray:[md valueForKey:@"userAward"]];
        ;
        //awardAr=[md valueForKey:@"userAward"];
        
        [self showAward];
    }
    
    else if (isCallBack1==4)//select Country
    {
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
    else if (isCallBack1==11)
    {
        alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted  Successfully!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alrt show];
        [alrt dismissWithClickedButtonIndex:0 animated:YES];
        employmntAr=[DATA valueForKey:@"employment"];
        [self showEmployment:employmntAr];
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
    else if (isCallBack1==18)
    {
        NSArray *pf=[META valueForKey:@"data"];
        NSArray *data=[pf valueForKey:@"details"];
        ProfileAr=data;
        NSArray *inddta=[pf valueForKey:@"usrPro"];
        [app editMainProfile :self :ProfileAr:inddta];
    }
    else if (isCallBack1==19)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
        [self addProfileimage:DATA];
    }
    else if (isCallBack1==20)
    {
        NSString *affectedrows= [DATA valueForKey:@"affectedRows"];
        
        if([affectedrows intValue]>0)
        {
            alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted  Successfully!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
//            eduAr=DATA;
//            [self educationDetail];
            [self updateTabForIndex:1];
        }
    }
    else if (isCallBack1==22)
    {
        NSString *affectedrows= [DATA valueForKey:@"affectedRows"];
        
        if([affectedrows intValue]>0)
        {
            alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted  Successfully!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
            eduAr=DATA;
            [self calForAward];
        }
    }
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
        prfvwscr.frame = CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70));
    
    [textField resignFirstResponder];
    return YES;
}

-(void) callMethod:(NSArray *)meta
{
    [self showProfile];
    NSLog(@"Valuuuuuuuuuu===%@",meta);
    
}


-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    if (scrollView== mainScrollView1) {
        float scrollViewHeight = scrollView.frame.size.height;
        float scrollContentSizeHeight = scrollView.contentSize.height;
        float scrollOffset = scrollView.contentOffset.y;
        
        if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
        {
            
            if([istab isEqualToString:@"1"])
            {
                if (eduAr.count>0) {
                    limit += 20;
                    
                    
                }
                [self educationDetail];
                
            }
            if([istab isEqualToString:@"2"])
            {
                if (employmntAr.count>0) {
                    limit += 20;
                    
                    
                }
                [self calForEmployement];
                
            }
            
            if([istab isEqualToString:@"3"])
            {
                if (certificationAr.count>0) {
                    limit += 20;
                    
                    
                }
                [self calForCertification];
            }
            if([istab isEqualToString:@"4"])
            {
                if (awardAr.count>0) {
                    limit += 20;
                    
                    
                }
                [self calForAward];
            }
        }

    }
    
    }


@end

