//
//#import "mainProfilePop.h"
//#import "SavePrefrences.h"
//#import "ProfileView.h"
//#import "AllPopUp.h"
//#import "AllValidationsViewController.h"
//#import "ManageArray.h"
//#import "SelectCountry.h"
//
//
//@interface mainProfilePop ()
//{
//    
//    UIView *prMainView,*headerView,*prMaintitView;
//    ProfileView *vc1;
//    NSMutableArray *popUpAr,*selLabAr;
//    NSString *imgBuffer,*cid,*stid,*cityid;
//    NSString *randomImgName;
//    UIImageView *imggeter;
//    float screenWidth,screenHeight;
//    UIScrollView *scrollView;
//    ManageArray *mang;
//    UIScrollView *mainScrollView1,*scrollbar;
//    UIAlertView *alrt;
//    //int isCallBack;
//   // NSString * emplid,*eduid,*certid,*awrdid;
//    NSArray *eduAr,*employmntAr,*certificationAr,*awardAr,*stateAr,*cityAr;
//    UITextField *name,*address,*board,*marks,*stream,*subjects;
//    UILabel *country,*sate,*year,*city,*NameLabel;
//    AllValidationsViewController *av;
//    int selId;
//    AllPopUp *app;
//    int selectedTab,awardId,EmployId,EducId,CertID;
//}
//
//@end
//
//@implementation mainProfilePop
//@synthesize scrollCtSt,countryAr,isCallBack,ProfileAr;
//
//
//-(void)viewDidLoad {
//    [super viewDidLoad];
//   
//    mang=[[ManageArray alloc]init];
//    av=[[AllValidationsViewController alloc]init];
//    NSLog(@"im inside viewdidload");
//}
//
//-(void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//}
//
//-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
//{
//    NSMutableDictionary *colorset=[SavePrefrences sharedInstance].colorDictionry;
//    av=[[AllValidationsViewController alloc]init];
//    
//    UIColor *color = [UIColor blackColor];
//    prMaintitView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
//    [Vc.view addSubview:prMaintitView];
//    vc1=Vc;
//    prMaintitView.backgroundColor=[UIColor colorWithRed:132.0f/255.0f green:132.0f/255.0f blue:132.0f/255.0f alpha:.5f];
////    if([popUpAr count]>0)
////    {
////        [popUpAr addObject:prMaintitView];
////    }
////    else{
////        
////        popUpAr =[[NSMutableArray alloc]init];
////        [popUpAr addObject:prMaintitView];
////    }
//    
//    
//    NSLog(@"array of popup  %lu",[popUpAr count]);
//    
//    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMaintitView.frame.size.width-70, 50)];
//    NameLabel.text=title;
//    NameLabel.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    NameLabel.font=[UIFont systemFontOfSize:14];
//    NameLabel.textColor=[UIColor blackColor];
//    NameLabel.textAlignment=NSTextAlignmentCenter;
//    [prMaintitView addSubview:NameLabel];
//    
//    
//    UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel.frame.size.width+NameLabel.frame.origin.x, [SavePrefrences sharedInstance ].naviHght+15, 30, 50)];
//    closeView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    [prMaintitView addSubview:closeView];
//    
//    UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 25, 25)];
//    [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
//    cross.userInteractionEnabled=YES;
//    [closeView addSubview:cross];
//    
//    
//    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
//    [communityeg setNumberOfTouchesRequired:1];
//    [communityeg setDelegate:self];
//    cross.userInteractionEnabled = YES;
//    [cross addGestureRecognizer:communityeg];
//    
//    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
//    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
//    scrollbar.backgroundColor=[colorset valueForKey:@"Videocolor"];
//    [prMaintitView addSubview:scrollbar];
//    
//    return prMaintitView;
//}
//
//-(UIView *) MainViewwithouttitle:(UIViewController *)Vc
//{
//    //NSLog(@"pop ar count in mainview2   %lu",[popUpAr count]);
//    
//    UIColor *color = [UIColor blackColor];
//    NSMutableDictionary *prf=[SavePrefrences sharedInstance].colorDictionry;
//    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
//    [Vc.view addSubview:prMainView];
//    vc1=Vc;
//    
//    prMainView.backgroundColor=[prf valueForKey:@"backcolor"];
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
//    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 56)];
//    headerView.backgroundColor=[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0];
//    headerView.layer.cornerRadius=5;
//    [prMainView addSubview:headerView];
//    
//    return prMainView;
//}
//
//
//-(void) showProfilePop:(UIViewController *)vc
//{
//    [self MainViewwithouttitle:vc];
//    
//    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20, 20)];
//    [bckarrow setImage:[UIImage imageNamed:@"back.png"]];
//    bckarrow.userInteractionEnabled=YES;
//    [headerView addSubview:bckarrow];
//    
//    
//    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
//    [communityeg setNumberOfTouchesRequired:1];
//    [communityeg setDelegate:self];
//    bckarrow.userInteractionEnabled = YES;
//    [bckarrow addGestureRecognizer:communityeg];
//    
//    
//    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(bckarrow.frame.size.width+bckarrow.frame.origin.x+15,5,150, 40)];
//    [logo setImage:[UIImage imageNamed:@"logo.png"]];
//    [headerView addSubview:logo];
//
//    NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
//    NSLog(@"hello");
//    selLabAr=[[NSMutableArray alloc]init];
//    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y,[SavePrefrences sharedInstance].screenWidth, 50)];
//    scrollView.delegate = self;
//    scrollView.scrollEnabled = YES;
//    scrollView.backgroundColor=[cc valueForKey:@"bodycolor"];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    int scrollWidth = 120;
//    
//    [prMainView addSubview:scrollView];
//    
//    NSMutableArray *tabAr=[[NSMutableArray alloc]init];
//    [tabAr addObject:@"Profile"];
//    [tabAr addObject:@"Education"];
//    [tabAr addObject:@"Employment"];
//    [tabAr addObject:@"Certification"];
//    [tabAr addObject:@"Awards"];
//    NSMutableArray *coloAr=[[NSMutableArray alloc]init];
//    
//    
//    
//    [coloAr addObject:[cc valueForKey:@"Profcolor"]];
//    [coloAr addObject:[cc valueForKey:@"Educolor"]];
//    [coloAr addObject:[cc valueForKey:@"Emplcolor"]];
//    [coloAr addObject:[cc valueForKey:@"Certcolor"]];
//    [coloAr addObject:[cc valueForKey:@"Awardscolor"]];
//    
//    int xOffset = 0;
//    for(int x=0;x<[tabAr count];x++)
//    {
//        
//        UIView  *view=[[UIView alloc]initWithFrame:CGRectMake(xOffset, 0, 130, 50)];
//        view.backgroundColor=[coloAr objectAtIndex:x];
//        view.layer.borderColor = [UIColor grayColor].CGColor;
//        [scrollView addSubview:view];
//        view.tag=x;
//        
//        
//        UILabel *labname=[[UILabel alloc]initWithFrame:CGRectMake(25, 13, view.frame.size.width, 20)];
//        labname.textColor=[UIColor whiteColor];
//        labname.font=[UIFont boldSystemFontOfSize:16];
//        labname.text=[tabAr objectAtIndex:x];
//        labname.tag=x;
//        [view addSubview:labname];
//        [selLabAr addObject:labname];
//        
//        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedTab:)];
//        [tapRecognizer setNumberOfTouchesRequired:1];
//        [tapRecognizer setDelegate:self];
//        labname.userInteractionEnabled = YES;
//        [labname addGestureRecognizer:tapRecognizer];
//        
//        scrollView.contentSize = CGSizeMake(scrollWidth+xOffset,scrollView.frame.size.height);
//        xOffset += 130;
//    }
//    
//    [mainScrollView1 removeFromSuperview];
//    int scpos= [scrollCtSt intValue];
//    
//    UILabel *vw=[selLabAr objectAtIndex:scpos];
//    if(scpos==0)
//    {
//        [scrollView setContentOffset:CGPointMake(0, 0)];
//        [self showProfile];
//    }
//    
//    else  if(scpos==1)
//    {
//        [scrollView setContentOffset:CGPointMake(100, 0)];
//    
//        [self educationDetail];
//    }
//    else  if(scpos==2)
//    {
//        [scrollView setContentOffset:CGPointMake(200, 0)];
//        
//       [self calForEmployement];
//    }
//    else  if(scpos==3)
//    {
//        [scrollView setContentOffset:CGPointMake(250, 0)];
//        
//       [self calForCertification];
//    }
//    else if(scpos==4)
//    {
//        [scrollView setContentOffset:CGPointMake(280, 0)];
//      [self calForAward];
//    }
//    
//}
//
//-(void)selectedTab:(id) sender
//{
//    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
//    long idd =  ges.view.tag;
//    
//    for(int x=0;x<[selLabAr count];x++)
//    {
//        UILabel *vw=[selLabAr objectAtIndex:x];
//        //        vw.textColor=[UIColor whiteColor];
//        //      if(idd==x)
//        //        {
//        //        vw.textColor=[UIColor redColor];
//        //        }
//    }
//    
//    [mainScrollView1 removeFromSuperview];
//    if(idd==0)
//    {
//        [self showProfile];
//    }
//    
//    else  if(idd==1)
//    {
//        [self educationDetail];
//    }
//    else  if(idd==2)
//    {
//        [self calForEmployement];
//    }
//    else  if(idd==3)
//    {
//        [self calForCertification];
//    }
//    else if(idd==4)
//    {
//        [self calForAward];
//    }
//    
//    
//    
//}
//
//
//-(void) showProfile
//{
//    app=[[AllPopUp alloc]init];
//    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0,scrollView.frame.size.height+scrollView.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,prMainView.frame.size.height-(headerView.frame.size.height+scrollView.frame.size.height+20))];
//    NSMutableDictionary *bc=[SavePrefrences sharedInstance].colorDictionry;
//    mainScrollView1.backgroundColor=[bc valueForKey:@"bodycolor"];
//    mainScrollView1.scrollEnabled = YES;
//    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
//    [prMainView addSubview:mainScrollView1];
//    
//    isCallBack=@"19";
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"showProfile" :@"":@"":dic1 :self];
//    
//    
//}
//-(void )addProfileimage:(NSArray*)ProfileAr1
//{
//    
//    NSLog(@"profile arra dsataaaaa======%@",ProfileAr);
//    
//     mang=[[ManageArray alloc]init];
//     ProfileAr=ProfileAr1;
//    
//    UIView * imageview=[[UIView alloc] initWithFrame:CGRectMake(10, 40, mainScrollView1.frame.size.width-20, 100)];
//    imageview.backgroundColor=[UIColor colorWithRed:70/255.0f green:130/255.0f blue:180/255.0f alpha:1.0f];
//    imageview.layer.cornerRadius=30;
//    [mainScrollView1 addSubview:imageview];
//    
//    
//    imggeter=[[UIImageView alloc] initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, 10, 100, 100)];
//    imggeter.layer.backgroundColor=[[UIColor clearColor] CGColor];
//    imggeter.layer.cornerRadius=50;
//    imggeter.layer.borderWidth=1.0;
//    imggeter.layer.masksToBounds = YES;
//    
//    imggeter.layer.borderColor=[[UIColor blackColor] CGColor];
//    [mainScrollView1 addSubview:imggeter];
//    
//    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOption)];
//    [tapRecognizer setNumberOfTouchesRequired:1];
//    imggeter.userInteractionEnabled = YES;
//    [imggeter addGestureRecognizer:tapRecognizer];
//    
//    NSString *img=[[ProfileAr valueForKey:@"img"] objectAtIndex:0];
//    NSString * url=[mang concatUrl:img];
//    
//    NSLog(@"image length===%@",url);
//    
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
//    
//    imggeter.userInteractionEnabled = YES;
//    UILabel *NameLabel=[[UILabel alloc] initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, imggeter.frame.origin.y+imggeter.frame.size.height, 100, 20)];
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"fname"] objectAtIndex:0]])
//    {
//        NameLabel.text=[[ProfileAr valueForKey:@"fname"] objectAtIndex:0];
//    }
//    
//    
//    
//    NameLabel.font=[UIFont systemFontOfSize:10];
//    NameLabel.textColor=[UIColor whiteColor];
//    NameLabel.textAlignment=NSTextAlignmentCenter;
//    [mainScrollView1 addSubview:NameLabel];
//    
//    UILabel *location=[[UILabel alloc] initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, NameLabel.frame.origin.y+NameLabel.frame.size.height-8, 100, 20)];
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"country"] objectAtIndex:0]])
//    {
//        location.text=[[ProfileAr valueForKey:@"country"] objectAtIndex:0];
//    }
//    location.font=[UIFont systemFontOfSize:10];
//    location.textColor=[UIColor whiteColor];
//    location.textAlignment=NSTextAlignmentCenter;
//    [mainScrollView1 addSubview:location];
//    [self showProfileDetail:imageview];
//    
//}
//-(void)showProfileDetail:(UIView *)imgvw
//{
//    NSMutableDictionary *txt=[SavePrefrences sharedInstance].colorDictionry;
//    
//    UIView * demographic=[[UIView alloc] initWithFrame:CGRectMake(10, imgvw.frame.size.height+imgvw.frame.origin.y+10, mainScrollView1.frame.size.width-20, 180)];
//    demographic.backgroundColor=[txt valueForKey:@"backcolor"];
//    demographic.layer.borderColor=[[UIColor whiteColor]CGColor];
//    demographic.layer.cornerRadius=5;
//    demographic.layer.borderWidth=2;
//    [mainScrollView1 addSubview:demographic];
//    
//    
//    
//    UILabel *demolab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
//    demolab.text=@"Demographics";
//    demolab.font=[UIFont systemFontOfSize:20];
//    demolab.textColor=[txt valueForKey:@"Videocolor"];
//    demolab.textAlignment=NSTextAlignmentLeft;
//    [demographic addSubview:demolab];
//    
//    UILabel *name1=[[UILabel alloc] initWithFrame:CGRectMake(10, demolab.frame.size.height+demolab.frame.origin.y, 100, 20)];
//    NSString *fname=[[ProfileAr objectAtIndex:0] valueForKey:@"fname"];
//    NSString *lname=[[ProfileAr objectAtIndex:0] valueForKey:@"lname"];
//    if([mang checkStringNull:fname]&&[mang checkStringNull:lname])
//    {
//        name1.text=[fname stringByAppendingString:[@" " stringByAppendingString:lname]];
//        
//    }
//    name1.font=[UIFont systemFontOfSize:14];
//    name1.textColor=[txt valueForKey:@"Tabstextcolor"];
//    name1.textAlignment=NSTextAlignmentLeft;
//    [demographic addSubview:name1];
//    
//    UILabel *male=[[UILabel alloc] initWithFrame:CGRectMake(10, name1.frame.size.height+name1.frame.origin.y, 100, 20)];
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"gender"] objectAtIndex:0]])
//    {
//        
//        if([[[ProfileAr valueForKey:@"gender"]objectAtIndex:0] intValue]==0)
//        {
//            male.text=@"Male";
//        }
//        else{
//            male.text=@"Female";
//        }
//    }
//    male.font=[UIFont systemFontOfSize:14];
//    male.textColor=[txt valueForKey:@"Tabstextcolor"];
//    male.textAlignment=NSTextAlignmentLeft;
//    [demographic addSubview:male];
//    
//    UILabel *dob=[[UILabel alloc] initWithFrame:CGRectMake(10, male.frame.size.height+male.frame.origin.y, 100, 20)];
//    
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"dob"] objectAtIndex:0]])
//    {
//        dob.text=[[ProfileAr valueForKey:@"dob"] objectAtIndex:0];
//    }
//    
//    dob.font=[UIFont systemFontOfSize:14];
//    dob.textColor=[txt valueForKey:@"Tabstextcolor"];
//    dob.textAlignment=NSTextAlignmentLeft;
//    [demographic addSubview:dob];
//    
//    UILabel *stus=[[UILabel alloc] initWithFrame:CGRectMake(10, dob.frame.size.height+dob.frame.origin.y, 100, 20)];
//    stus.text=@"Married";//relationship  1
//    NSString *io = [[ProfileAr valueForKey:@"relationship"] objectAtIndex:0];
//    
//    if (![io isEqual:[NSNull null]])
//    {
//        int dd=[io intValue];
//        if(dd==0)
//        {
//            stus.text=@"Single";//relationship  0
//        }
//        
//    }
//    stus.font=[UIFont systemFontOfSize:14];
//    stus.textColor=[txt valueForKey:@"Tabstextcolor"];
//    stus.textAlignment=NSTextAlignmentLeft;
//    [demographic addSubview:stus];
//    
//    
//    //=====================
//    
//    UIView * about=[[UIView alloc] initWithFrame:CGRectMake(10, demographic.frame.size.height+demographic.frame.origin.y+10, mainScrollView1.frame.size.width-20, 180)];
//    NSMutableDictionary *abot=[SavePrefrences sharedInstance].colorDictionry;
//    about.backgroundColor=[abot valueForKey:@"backcolor"];
//    about.layer.borderColor=[[UIColor whiteColor]CGColor];
//    about.layer.cornerRadius=5;
//    about.layer.borderWidth=2;
//    [mainScrollView1 addSubview:about];
//    
//    UILabel *abt=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
//    abt.text=@"About";
//    abt.font=[UIFont systemFontOfSize:20];
//    abt.textColor=[txt valueForKey:@"Videocolor"];
//    abt.textAlignment=NSTextAlignmentLeft;
//    [about addSubview:abt];
//    
//    UILabel *address1=[[UILabel alloc] initWithFrame:CGRectMake(10, abt.frame.size.height+abt.frame.origin.y, 100, 20)];
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"address"] objectAtIndex:0]])
//    {
//        address1.text=[[ProfileAr valueForKey:@"address"] objectAtIndex:0];
//    }
//    
//    address1.font=[UIFont systemFontOfSize:14];
//    address1.textColor=[txt valueForKey:@"Tabstextcolor"];
//    address1.textAlignment=NSTextAlignmentLeft;
//    [about addSubview:address1];
//    
//    
//    UILabel *city1=[[UILabel alloc] initWithFrame:CGRectMake(10, address1.frame.size.height+address1.frame.origin.y, 100, 20)];
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"city"] objectAtIndex:0]])
//    {
//        city1.text=[[ProfileAr valueForKey:@"city"] objectAtIndex:0];
//    }
//    
//    city1.font=[UIFont systemFontOfSize:14];
//    city1.textColor=[txt valueForKey:@"Tabstextcolor"];
//    city1.textAlignment=NSTextAlignmentLeft;
//    [about addSubview:city1];
//    
//    UILabel *state=[[UILabel alloc] initWithFrame:CGRectMake(10, city1.frame.size.height+city1.frame.origin.y, 100, 20)];
//    
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"state"] objectAtIndex:0]])
//    {
//        state.text=[[ProfileAr valueForKey:@"state"] objectAtIndex:0];
//    }
//    state.font=[UIFont systemFontOfSize:14];
//    state.textColor=[txt valueForKey:@"Tabstextcolor"];
//    state.textAlignment=NSTextAlignmentLeft;
//    [about addSubview:state];
//    
//    UILabel *county=[[UILabel alloc] initWithFrame:CGRectMake(10, state.frame.size.height+state.frame.origin.y, 100, 20)];
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"country"] objectAtIndex:0]])
//    {
//        county.text=[[ProfileAr valueForKey:@"country"] objectAtIndex:0];
//    }
//    county.font=[UIFont systemFontOfSize:14];
//    county.textColor=[txt valueForKey:@"Tabstextcolor"];
//    county.textAlignment=NSTextAlignmentLeft;
//    [about addSubview:county];
//    
//    
//    //=======================
//    UIView * contact=[[UIView alloc] initWithFrame:CGRectMake(10, about.frame.size.height+about.frame.origin.y+10, mainScrollView1.frame.size.width-20, 180)];
//    NSMutableDictionary *cn=[SavePrefrences sharedInstance].colorDictionry;
//    contact.backgroundColor=[cn valueForKey:@"backcolor"];
//    contact.layer.borderColor=[[UIColor whiteColor]CGColor];
//    contact.layer.cornerRadius=5;
//    contact.layer.borderWidth=2;
//    [mainScrollView1 addSubview:contact];
//    
//    
//    
//    UILabel *ctc=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
//    abt.text=@"Contact";
//    abt.font=[UIFont systemFontOfSize:20];
//    abt.textColor=[txt valueForKey:@"Videocolor"];
//    abt.textAlignment=NSTextAlignmentLeft;
//    [contact addSubview:abt];
//    
//    UILabel *mob=[[UILabel alloc] initWithFrame:CGRectMake(10, ctc.frame.size.height+ctc.frame.origin.y, 150, 20)];
//    mob.text=[NSString stringWithFormat:@"%@",[[ProfileAr objectAtIndex:0] valueForKey:@"phone_no"]];
//    mob.font=[UIFont systemFontOfSize:14];
//    mob.textColor=[txt valueForKey:@"Tabstextcolor"];
//    mob.textAlignment=NSTextAlignmentLeft;
//    [contact addSubview:mob];
//    
//    
//    
//    
//    
//    UILabel *phno=[[UILabel alloc] initWithFrame:CGRectMake(10, mob.frame.size.height+mob.frame.origin.y, 150, 20)];
//    
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"mobile_no"] objectAtIndex:0]])
//    {
//        phno.text=[NSString stringWithFormat:@"%@",[[ProfileAr valueForKey:@"mobile_no"] objectAtIndex:0]];
//    }
//    
//    phno.font=[UIFont systemFontOfSize:14];
//    phno.textColor=[UIColor blackColor];
//    phno.textAlignment=NSTextAlignmentLeft;
//    [contact addSubview:phno];
//    
//    UILabel *email=[[UILabel alloc] initWithFrame:CGRectMake(10, phno.frame.size.height+phno.frame.origin.y, 150, 20)];
//    if([mang checkStringNull:[[ProfileAr valueForKey:@"email"] objectAtIndex:0]])
//    {
//        email.text=[[ProfileAr valueForKey:@"email"] objectAtIndex:0];
//    }
//    email.font=[UIFont systemFontOfSize:14];
//    email.textColor=[txt valueForKey:@"Tabstextcolor"];
//    email.textAlignment=NSTextAlignmentLeft;
//    [contact addSubview:email];
//    
//    
//    UIView * soicn=[[UIView alloc] initWithFrame:CGRectMake(10, contact.frame.size.height+contact.frame.origin.y+10, mainScrollView1.frame.size.width-20, 200)];
//    NSMutableDictionary *sc=[SavePrefrences sharedInstance].colorDictionry;
//    soicn.backgroundColor=[sc valueForKey:@"backcolor"];
//    soicn.layer.borderColor=[[UIColor whiteColor]CGColor];
//    soicn.layer.borderWidth=2;
//    soicn.layer.cornerRadius=5;
//    [mainScrollView1 addSubview:soicn];
//    
//    
//    
//    UILabel *smd=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
//    smd.text=@"Social Media";
//    smd.font=[UIFont systemFontOfSize:20];
//    smd.textColor=[txt valueForKey:@"Videocolor"];
//    smd.textAlignment=NSTextAlignmentLeft;
//    [soicn addSubview:smd];
//    
//    
//    
//    NSString *fb= [[ProfileAr objectAtIndex:0] valueForKey:@"fcbkid"] ;
//    NSString *tw= [[ProfileAr objectAtIndex:0] valueForKey:@"twitter_id"] ;
//    NSString *ln= [[ProfileAr objectAtIndex:0] valueForKey:@"linkedin_id"] ;
//    NSString *gog= [[ProfileAr objectAtIndex:0] valueForKey:@"google_id"] ;
//    NSString *vimo= [[ProfileAr objectAtIndex:0] valueForKey:@"vimeo_id"] ;
//    
//    int yinc=smd.frame.size.height+smd.frame.origin.y;
//    if(![fb isEqual:[NSNull null]])
//    {
//        
//        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
//        icon.backgroundColor=[UIColor blackColor] ;
//        icon.image = [UIImage imageNamed:@"fb.png"];
//        [soicn addSubview:icon];
//        
//        
//        UILabel *fb1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, 150, 20)];
//        fb1.text=fb;
//        fb1.font=[UIFont systemFontOfSize:14];
//        fb1.textColor=[txt valueForKey:@"Tabstextcolor"];
//        fb1.textAlignment=NSTextAlignmentLeft;
//        [soicn addSubview:fb1];
//        yinc=fb1.frame.size.height+fb1.frame.origin.y+5;
//        
//    }
//    
//    if(![tw isEqual:[NSNull null]])
//    {
//        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
//        icon.backgroundColor=[UIColor blackColor] ;
//        icon.image = [UIImage imageNamed:@"twitter.png"];
//        [soicn addSubview:icon];
//        
//        UILabel *tw1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, 150, 20)];
//        tw1.text=tw;
//        tw1.font=[UIFont systemFontOfSize:14];
//        tw1.textColor=[txt valueForKey:@"Tabstextcolor"];
//        tw1.textAlignment=NSTextAlignmentLeft;
//        [soicn addSubview:tw1];
//        yinc=tw1.frame.size.height+tw1.frame.origin.y+5;
//        
//    }
//    
//    if(![ln isEqual:[NSNull null]])
//    {
//        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
//        icon.backgroundColor=[UIColor blackColor] ;
//        icon.image = [UIImage imageNamed:@"in.png"];
//        [soicn addSubview:icon];
//        
//        UILabel *ln1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, 150, 20)];
//        ln1.text=ln;
//        ln1.font=[UIFont systemFontOfSize:14];
//        ln1.textColor=[txt valueForKey:@"Tabstextcolor"];
//        ln1.textAlignment=NSTextAlignmentLeft;
//        [soicn addSubview:ln1];
//        yinc=ln1.frame.size.height+ln1.frame.origin.y+5;
//    }
//    if(![gog isEqual:[NSNull null]])
//    {
//        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
//        icon.backgroundColor=[UIColor blackColor] ;
//        icon.image = [UIImage imageNamed:@"google.png"];
//        [soicn addSubview:icon];
//        
//        UILabel *gog1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, 150, 20)];
//        gog1.text=gog;
//        gog1.font=[UIFont systemFontOfSize:14];
//        gog1.textColor=[txt valueForKey:@"Tabstextcolor"];
//        gog1.textAlignment=NSTextAlignmentLeft;
//        [soicn addSubview:gog1];
//        yinc=gog1.frame.size.height+gog1 .frame.origin.y+5;
//    }
//    if(![vimo isEqual:[NSNull null]])
//    {
//        UIImageView   *icon=[[UIImageView alloc] initWithFrame:CGRectMake(10, yinc, 20, 20)];
//        icon.backgroundColor=[UIColor clearColor] ;
//        icon.image = [UIImage imageNamed:@"vimeo1.png"];
//        [soicn addSubview:icon];
//        
//        UILabel *vimo1=[[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+20, yinc, 150, 20)];
//        vimo1.text=vimo;
//        vimo1.font=[UIFont systemFontOfSize:14];
//        vimo1.textColor=[txt valueForKey:@"Tabstextcolor"];
//        vimo1.textAlignment=NSTextAlignmentLeft;
//        [soicn addSubview:vimo1];
//        
//        
//    }
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(15, soicn.frame.size.height+soicn.frame.origin.y+10, scrollView.frame.size.width-35, 45)];
//    [save setTitle: @"Edit" forState: UIControlStateNormal];
//    save.backgroundColor=[txt valueForKey:@"Videocolor"];
//    [save addTarget:self action:@selector(addProfile:) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    save.layer.cornerRadius=5;
//    [mainScrollView1 addSubview:save];
//    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,980);
//    
//}
//
//-(IBAction)addProfile:(id)sender
//{
//    isCallBack=@"18";
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"showProfilePop" :@"" :@"" :dic1 :self ];
//    //[app editMainProfile:self :ProfileAr];
//    
//    
//}
//
//-(void) educationDetail
//{
//    selectedTab=1;
//    
//    isCallBack=0;
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Education" :@"showEdu" :@"":@"":dic1 :self];
//}
//
//-(void) showEducation
//{
//    NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
//    
//    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height+scrollView.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,prMainView.frame.size.height-(headerView.frame.size.height+scrollView.frame.size.height))];
//    mainScrollView1.backgroundColor=[cc valueForKey:@"bodycolor"];
//    mainScrollView1.scrollEnabled = YES;
//    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
//    [prMainView addSubview:mainScrollView1];
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 45)];
//    [save setTitle: @"+ ADD EDUCATION DETAILS" forState: UIControlStateNormal];
//    save.backgroundColor=[cc valueForKey:@"Videocolor"];
//    [save addTarget:self action:@selector(addEduProfile:) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [save setFont: [UIFont boldSystemFontOfSize:18]];
//    save.layer.cornerRadius=5;
//    [mainScrollView1 addSubview:save];
//    
//    
//    int yinc=save.frame.size.height+save.frame.origin.y+20;
//    for(int x=0;x<[eduAr count];x++)
//    {
//        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(10, yinc, mainScrollView1.frame.size.width-20, 180)];
//        edu.backgroundColor=[cc valueForKey:@"backcolor"];
//        edu.layer.borderColor=[[UIColor whiteColor]CGColor];
//        edu.layer.borderWidth=2;
//        [mainScrollView1 addSubview:edu];
//        
//        
//        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(2, 0, edu.frame.size.width-2, 30)];
//        title.text=[[eduAr objectAtIndex:x] valueForKey:@"university"];
//        title.font=[UIFont systemFontOfSize:14];
//        title.backgroundColor=[cc valueForKey:@"Videocolor"];
//        title.textColor=[cc valueForKey:@"Headcolor"];
//        title.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:title];
//        
//        UILabel *inst=[[UILabel alloc] initWithFrame:CGRectMake(10, title.frame.size.height+title.frame.origin.y, mainScrollView1.frame.size.width-80, 20)];
//        inst.text=[NSString stringWithFormat:@"Institution :%@ ",[[eduAr objectAtIndex:x] valueForKey:@"college_name"]];
//        inst.font=[UIFont systemFontOfSize:14];
//        inst.textColor=[cc valueForKey:@"Tabstextcolor"];
//        inst.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:inst];
//        
//        
//        
//        UILabel *strm=[[UILabel alloc] initWithFrame:CGRectMake(10, inst.frame.size.height+inst.frame.origin.y, mainScrollView1.frame.size.width-80, 20)];
//        strm.text=[NSString stringWithFormat:@"Stream      :%@ ",[[eduAr objectAtIndex:x] valueForKey:@"stream"]];
//        strm.font=[UIFont systemFontOfSize:14];
//        strm.textColor=[cc valueForKey:@"Tabstextcolor"];
//        strm.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:strm];
//        
//        UILabel *Subjects=[[UILabel alloc] initWithFrame:CGRectMake(10, strm.frame.size.height+strm.frame.origin.y, mainScrollView1.frame.size.width-80, 20)];
//        Subjects.text=[NSString stringWithFormat:@"Subjects    :%@ ",[[eduAr objectAtIndex:x] valueForKey:@"subjects"]];
//        Subjects.font=[UIFont systemFontOfSize:14];
//        Subjects.textColor=[cc valueForKey:@"Tabstextcolor"];
//        Subjects.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:Subjects];
//        
//        
//        UILabel *marks1=[[UILabel alloc] initWithFrame:CGRectMake(10, Subjects.frame.size.height+Subjects.frame.origin.y, mainScrollView1.frame.size.width-80, 20)];
//        marks1.text=[NSString stringWithFormat:@"Marks        :%@ ",[[eduAr objectAtIndex:x] valueForKey:@"marks"]];
//        marks1.font=[UIFont systemFontOfSize:14];
//        marks1.textColor=[cc valueForKey:@"Tabstextcolor"];
//        marks1.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:marks1];
//        
//        UILabel *year1=[[UILabel alloc] initWithFrame:CGRectMake(10, marks1.frame.size.height+marks1.frame.origin.y, mainScrollView1.frame.size.width-80, 20)];
//        year1.text=[NSString stringWithFormat:@"Year           :%@ ",[[eduAr objectAtIndex:x] valueForKey:@"year"]];
//        year1.font=[UIFont systemFontOfSize:14];
//        year1.textColor=[cc valueForKey:@"Tabstextcolor"];
//        year1.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:year1];
//        
//        UITextView *add=[[UITextView alloc] initWithFrame:CGRectMake(10, year1.frame.size.height+year1.frame.origin.y, mainScrollView1.frame.size.width-80, 40)];
//        add.text=[NSString stringWithFormat:@"Address     : %@",[[[[[eduAr objectAtIndex:x] valueForKey:@"address"] stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[eduAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[eduAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[eduAr objectAtIndex:x] valueForKey:@"country"] ]]];
//        add.font=[UIFont systemFontOfSize:14];
//        add.textColor=[cc valueForKey:@"Tabstextcolor"];
//        add.userInteractionEnabled=NO;
//        add.backgroundColor=[cc valueForKey:@"backcolor"];
//        add.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:add];
//        
//        
//        
//        
//        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-60, 5, 20, 20)];
//        update.backgroundColor=[UIColor clearColor] ;
//        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
//        update.tag=[[[eduAr objectAtIndex:x] valueForKey:@"edu_id"] intValue];
//        [edu addSubview:update];
//        
//        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateEducation:)];
//        [updateges setNumberOfTouchesRequired:1];
//        [updateges setDelegate:self];
//        update.userInteractionEnabled = YES;
//        [update addGestureRecognizer:updateges];
//        
//       NSString * eduid=[[eduAr objectAtIndex:x] valueForKey:@"edu_id"];
//        
//        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
//        delete.backgroundColor=[UIColor clearColor] ;
//        delete.image = [UIImage imageNamed:@"educationprofiledelete.png"];
//        [edu addSubview:delete];
//        delete.tag=[eduid intValue];
//        
//        
//        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteEducation:)];
//        [deleteges setNumberOfTouchesRequired:1];
//        [deleteges setDelegate:self];
//        delete.userInteractionEnabled = YES;
//        [delete addGestureRecognizer:deleteges];
//        
//        
//        yinc=yinc+190;
//        
//    }
//    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
//}
//
//
//
//
//-(void) calForEmployement
//{
//    NSLog(@"call for imployement");
//    selectedTab=2;
//    isCallBack=@"1";
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Employment" :@"showEmp" :@"":@"":dic1 :self];
//}
//
//-(void) showEmployment:(NSArray *) employmntAr
//{
//    NSLog(@"show employement");
// 
//    NSMutableDictionary *bb=[SavePrefrences sharedInstance].colorDictionry;
//    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height+scrollView.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,prMainView.frame.size.height-(headerView.frame.size.height+scrollView.frame.size.height))];
//    mainScrollView1.backgroundColor=[bb valueForKey:@"bodycolor"];
//    mainScrollView1.scrollEnabled = YES;
//    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
//    [prMainView addSubview:mainScrollView1];
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 45)];
//    [save setTitle: @"+ ADD EMPLOYMENT DETAILS" forState: UIControlStateNormal];
//    save.backgroundColor=[bb valueForKey:@"Videocolor"];
//    [save setFont:[UIFont boldSystemFontOfSize:18]];
//    [save addTarget:self action:@selector(addEmployemnt) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    save.layer.cornerRadius=5;
//    [mainScrollView1 addSubview:save];
//    
//    
//    int yinc=save.frame.size.height+save.frame.origin.y+20;
//    for(int x=0;x<[employmntAr count];x++)
//    {
//        
//        
//        
//        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(10, yinc, mainScrollView1.frame.size.width-20, 140)];
//        edu.backgroundColor=[bb valueForKey:@"backcolor"];
//        edu.layer.borderColor=[[UIColor whiteColor]CGColor];
//        edu.layer.borderWidth=2;
//        
//        [mainScrollView1 addSubview:edu];
//        
//        
//        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(2,0, edu.frame.size.width-2, 30)];
//        title.text=[[employmntAr objectAtIndex:x] valueForKey:@"company_name"];
//        title.font=[UIFont systemFontOfSize:14];
//        title.backgroundColor=[bb valueForKey:@"Videocolor"];
//        title.textColor=[bb valueForKey:@"Headcolor"];
//        title.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:title];
//        
//        UILabel *stw=[[UILabel alloc] initWithFrame:CGRectMake(10, title.frame.size.height+title.frame.origin.y, mainScrollView1.frame.size.width-80, 14)];
//        
//        stw.text=[[[employmntAr objectAtIndex:x] valueForKey:@"started_working"] stringByAppendingString:[NSString stringWithFormat:@" to %@",[[employmntAr objectAtIndex:x] valueForKey:@"end_working"]]];
//        stw.font=[UIFont systemFontOfSize:12];
//        stw.textColor=[bb valueForKey:@"Tabstextcolor"];
//        stw.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:stw];
//        
//        UILabel *add=[[UILabel alloc] initWithFrame:CGRectMake(10, stw.frame.size.height+stw.frame.origin.y, mainScrollView1.frame.size.width-80, 50)];
//        add.font=[UIFont systemFontOfSize:12];
//        
//        add.text=[NSString stringWithFormat:@" %@",[[[[[employmntAr objectAtIndex:x] valueForKey:@"address"] stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[employmntAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[employmntAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[employmntAr objectAtIndex:x] valueForKey:@"country"] ]]];
//        add.textColor=[bb valueForKey:@"Tabstextcolor"];
//        add.userInteractionEnabled=NO;
//        add.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:add];
//        
//        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(10, add.frame.size.height+add.frame.origin.y, mainScrollView1.frame.size.width-80, 40)];
//        jd.text=[NSString stringWithFormat:@"%@ ",[[employmntAr objectAtIndex:x] valueForKey:@"job_desc"]];
//        jd.font=[UIFont systemFontOfSize:12];
//        jd.textColor=[bb valueForKey:@"Tabstextcolor"];
//        jd.userInteractionEnabled=NO;
//        jd.backgroundColor=[bb valueForKey:@"backcolor"];
//        jd.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:jd];
//        
//        
//        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-60, 5, 20, 20)];
//        update.backgroundColor=[UIColor clearColor];
//        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
//        update.tag=[[[employmntAr objectAtIndex:x] valueForKey:@"emp_id"] intValue];
//        [edu addSubview:update];
//        
//        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateEmployement:)];
//        [updateges setNumberOfTouchesRequired:1];
//        [updateges setDelegate:self];
//        update.userInteractionEnabled = YES;
//        [update addGestureRecognizer:updateges];
//        
//     NSString *emplid=[[employmntAr valueForKey:@"emp_id"]objectAtIndex:0];
//        
//        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
//        delete.backgroundColor=[UIColor clearColor] ;
//        delete.image = [UIImage imageNamed:@"educationprofiledelete.png"];
//        [edu addSubview:delete];
//        delete.tag=[emplid intValue];
//        
//        
//        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteEmployement:)];
//        [deleteges setNumberOfTouchesRequired:1];
//        [deleteges setDelegate:self];
//        delete.userInteractionEnabled = YES;
//        [delete addGestureRecognizer:deleteges];
//        
//        
//        yinc=yinc+145;
//        
//    }
//    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
//}
//
//
//
//
//
//-(void) calForCertification
//{
//    selectedTab=3;
//    
//    isCallBack=@"2";
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Certification" :@"showCert" :@"":@"":dic1 :self];
//    
//}
//
//-(void) showCertification
//{
//    
//    NSMutableDictionary *hh=[SavePrefrences sharedInstance].colorDictionry;
//    
//    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height+scrollView.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,prMainView.frame.size.height-(headerView.frame.size.height+scrollView.frame.size.height))];
//    mainScrollView1.backgroundColor=[hh valueForKey:@"bodycolor"];
//    mainScrollView1.scrollEnabled = YES;
//    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
//    [prMainView addSubview:mainScrollView1];
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 45)];
//    [save setTitle: @"+ ADD CERTIFICATION DETAILS" forState: UIControlStateNormal];
//    save.backgroundColor=[hh valueForKey:@"Videocolor"];
//    [save addTarget:self action:@selector(addCertification) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [save setFont:[UIFont boldSystemFontOfSize:18]];
//    save.layer.cornerRadius=5;
//    [mainScrollView1 addSubview:save];
//    
//    
//    int yinc=save.frame.size.height+save.frame.origin.y+20;
//    for(int x=0;x<[certificationAr count];x++)
//    {
//        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(10, yinc, mainScrollView1.frame.size.width-20, 160)];
//        edu.backgroundColor=[hh valueForKey:@"backcolor"];
//        edu.layer.borderColor=[[UIColor whiteColor]CGColor];
//        edu.layer.borderWidth=2;
//        [mainScrollView1 addSubview:edu];
//        
//        
//        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(2, 0, edu.frame.size.width-2, 30)];
//        title.text=[[certificationAr objectAtIndex:x] valueForKey:@"certificate_name"];
//        title.font=[UIFont systemFontOfSize:14];
//        title.backgroundColor=[hh valueForKey:@"Videocolor"];
//        title.textColor=[hh valueForKey:@"Headcolor"];
//        title.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:title];
//        
//        
//        
//        UIImageView *certimg =[[UIImageView alloc]initWithFrame:CGRectMake(edu.frame.size.width/2-15, title.frame.size.height+title.frame.origin.y+5,45,45)];
//        certimg.image = [UIImage imageNamed:@"username.png"];
//        certimg.backgroundColor=[UIColor clearColor];
//        [edu addSubview:certimg];
//        
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
//        
//        UILabel *add=[[UILabel alloc] initWithFrame:CGRectMake(10, certimg.frame.size.height+certimg.frame.origin.y, mainScrollView1.frame.size.width-80, 50)];
//        add.font=[UIFont systemFontOfSize:12];
//        
//        add.text=[NSString stringWithFormat:@" %@",[[[[[certificationAr objectAtIndex:x] valueForKey:@"address"] stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[certificationAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[certificationAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[certificationAr objectAtIndex:x] valueForKey:@"country"] ]]];
//        add.textColor=[hh valueForKey:@"Tabstextcolor"];
//        add.userInteractionEnabled=NO;
//        add.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:add];
//        
//        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(10, add.frame.size.height+add.frame.origin.y, mainScrollView1.frame.size.width-80, 30)];
//        jd.text=[NSString stringWithFormat:@"%@ ",[[certificationAr objectAtIndex:x] valueForKey:@"c_desc"]];
//        jd.font=[UIFont systemFontOfSize:12];
//        jd.textColor=[hh valueForKey:@"Tabstextcolor"];
//        jd.userInteractionEnabled=NO;
//        jd.backgroundColor=[hh valueForKey:@"backcolor"];
//        jd.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:jd];
//        
//        
//        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-60, 5, 20, 20)];
//        update.backgroundColor=[UIColor clearColor] ;
//        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
//        update.tag=[[[certificationAr objectAtIndex:x] valueForKey:@"c_id"] intValue];
//        [edu addSubview:update];
//        
//        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateCertification:)];
//        [updateges setNumberOfTouchesRequired:1];
//        [updateges setDelegate:self];
//        update.userInteractionEnabled = YES;
//        [update addGestureRecognizer:updateges];
//        
//       NSString *certid=[[certificationAr objectAtIndex:x] valueForKey:@"c_id"];
//        
//        UIImageView   *delete=[[UIImageView alloc] initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+10, 5, 20, 20)];
//        delete.backgroundColor=[UIColor clearColor] ;
//        delete.image = [UIImage imageNamed:@"educationprofiledelete.png"];
//        [edu addSubview:delete];
//        delete.tag=[certid intValue];
//        
//        
//        UITapGestureRecognizer *deleteges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteCertification:)];
//        [deleteges setNumberOfTouchesRequired:1];
//        [deleteges setDelegate:self];
//        delete.userInteractionEnabled = YES;
//        [delete addGestureRecognizer:deleteges];
//        
//        yinc=yinc+165;
//        
//    }
//    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
//    
//    
//}
//
//
//
//
//-(void) calForAward
//{
//    selectedTab=4;
//    isCallBack=@"3";
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Awards" :@"showAwards" :@"":@"":dic1 :self];
//    
//}
//
//-(void) showAward
//{
//    
//    NSMutableDictionary *jj=[SavePrefrences sharedInstance].colorDictionry;
//    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height+scrollView.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,prMainView.frame.size.height-(headerView.frame.size.height+scrollView.frame.size.height))];
//    mainScrollView1.backgroundColor=[jj valueForKey:@"bodycolor"];
//    mainScrollView1.scrollEnabled = YES;
//    mainScrollView1.contentSize = CGSizeMake(screenWidth,screenHeight);
//    [prMainView addSubview:mainScrollView1];
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(20,10, scrollView.frame.size.width-40, 45)];
//    [save setTitle: @"+ ADD AWARD DETAILS" forState: UIControlStateNormal];
//    save.backgroundColor=[jj valueForKey:@"Videocolor"];
//    [save setFont:[UIFont boldSystemFontOfSize:18]];
//    [save addTarget:self action:@selector(addAward) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    save.layer.cornerRadius=5;
//    [mainScrollView1 addSubview:save];
//    
//    
//    
//    
//    int yinc=save.frame.size.height+save.frame.origin.y+20;
//    for(int x=0;x<[awardAr count];x++)
//    {
//        UIView * edu=[[UIView alloc] initWithFrame:CGRectMake(10, yinc, mainScrollView1.frame.size.width-20, 160)];
//        edu.backgroundColor=[jj valueForKey:@"backcolor"];
//        edu.layer.borderColor=[[UIColor whiteColor]CGColor];
//        edu.layer.borderWidth=2;
//        [mainScrollView1 addSubview:edu];
//        
//        
//        
//        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(2, 0, edu.frame.size.width-2, 30)];
//        title.text=[[awardAr objectAtIndex:x] valueForKey:@"name_of_comp"];
//        title.font=[UIFont systemFontOfSize:14];
//        title.textColor=[jj valueForKey:@"Headcolor"];
//        title.backgroundColor=[jj valueForKey:@"Videocolor"];
//        title.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:title];
//        
//        UIImageView *certimg =[[UIImageView alloc]initWithFrame:CGRectMake(edu.frame.size.width/2-17.5, title.frame.size.height+title.frame.origin.y+5,45 , 45)];
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
//        UILabel *aww=[[UILabel alloc] initWithFrame:CGRectMake(10, certimg.frame.size.height+certimg.frame.origin.y+5, mainScrollView1.frame.size.width-80, 15)];
//        aww.text=[[awardAr objectAtIndex:x] valueForKey:@"award_when"];
//        aww.font=[UIFont systemFontOfSize:14];
//        aww.textColor=[jj valueForKey:@"Tabstextcolor"];
//        aww.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:aww];
//        
//        
//        UILabel *add=[[UILabel alloc] initWithFrame:CGRectMake(10, aww.frame.size.height+aww.frame.origin.y, mainScrollView1.frame.size.width-80, 30)];
//        add.font=[UIFont systemFontOfSize:12];
//        
//        add.text=[NSString stringWithFormat:@" %@",[[[[[awardAr objectAtIndex:x] valueForKey:@"address"] stringByAppendingString:[NSString stringWithFormat:@",%@ ,",[[awardAr objectAtIndex:x] valueForKey:@"city"]]] stringByAppendingString: [[awardAr objectAtIndex:x] valueForKey:@"state"]] stringByAppendingString:[NSString stringWithFormat:@",%@",[[awardAr objectAtIndex:x] valueForKey:@"country"] ]]];
//        add.textColor=[jj valueForKey:@"Tabstextcolor"];
//        add.userInteractionEnabled=NO;
//        add.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:add];
//        
//        UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(10, add.frame.size.height+add.frame.origin.y, mainScrollView1.frame.size.width-80, 20)];
//        jd.text=[NSString stringWithFormat:@"%@ ",[[awardAr objectAtIndex:x] valueForKey:@"award_desc"]];
//        jd.font=[UIFont systemFontOfSize:12];
//        jd.textColor=[jj valueForKey:@"Tabstextcolor"];
//        jd.backgroundColor=[jj valueForKey:@"backcolor"];
//        jd.userInteractionEnabled=NO;
//        jd.textAlignment=NSTextAlignmentLeft;
//        [edu addSubview:jd];
//        
//        
//        UIImageView   *update=[[UIImageView alloc] initWithFrame:CGRectMake(edu.frame.size.width-60, 5, 20, 20)];
//        update.backgroundColor=[UIColor clearColor] ;
//        update.image = [UIImage imageNamed:@"educationprofileedit.png"];
//        update.tag=[[[awardAr objectAtIndex:x] valueForKey:@"id"] intValue];
//        [edu addSubview:update];
//        
//        UITapGestureRecognizer *updateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateAward:)];
//        [updateges setNumberOfTouchesRequired:1];
//        [updateges setDelegate:self];
//        update.userInteractionEnabled = YES;
//        [update addGestureRecognizer:updateges];
//        
//      NSString *awrdid=[[awardAr objectAtIndex:x] valueForKey:@"id"];
//        
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
//        
//        yinc=yinc+165;
//        
//    }
//    mainScrollView1.contentSize = CGSizeMake(mainScrollView1.frame.size.width,yinc);
//    
//    
//}
//
//-(void) addEmployemnt
//{
//    
//    
//    isCallBack=@"9";
//    [app addProfile:vc1];
//    
//    
//}
//
//-(void) updateEmployement:(id)sender
//{
//    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
//    int idd=(int)ges.view.tag;
//    isCallBack=@"10";
//    [app editProfile:vc1 :employmntAr :idd];
//    
//    NSLog(@"id of Employement update %d",idd);
//}
//-(void) deleteEmployement:(id)sender
//{
//    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
//    EmployId=(int)tg.view.tag;
//    
//    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//    [alrt show];
//    [self alertView:alrt clickedButtonAtIndex:2];
//    
//}
//- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
//    
//    NSLog(@"value of selected tab %d",selectedTab);
//    
//    if (buttonIndex == 1)
//    {
//        NSLog(@"ok");
//        if(selectedTab==1)
//        {
//            isCallBack=@"20";
//            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//            [dic1 setValue:[NSString stringWithFormat:@"%d",EducId] forKey:@"eid"];
//            [[SavePrefrences sharedInstance].skthand emitData:@"Education" :@"delEdu" :@"":@"":dic1 :self];
//        }
//        if(selectedTab==2)
//        {
//            isCallBack=@"11";
//            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//            [dic1 setValue:[NSString stringWithFormat:@"%d",EmployId] forKey:@"emid"];
//            [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//            [[SavePrefrences sharedInstance].skthand emitData:@"Employment" :@"delEmp" :@"":@"":dic1 :self];
//        }
//        if(selectedTab==3)
//        {
//            isCallBack=@"14";
//            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//            [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//            [dic1 setValue:[NSString stringWithFormat:@"%d",CertID] forKey:@"cid"];
//            
//            [[SavePrefrences sharedInstance].skthand emitData:@"Certification" :@"delCert" :@"":@"":dic1 :self];
//        }
//        if(selectedTab==4)
//        {
//            
//            isCallBack=@"22";
//            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//            [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//            [dic1 setValue:[NSString stringWithFormat:@"%d",awardId] forKey:@"aid"];
//            
//            [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"delAward" :@"":@"":dic1 :self];
//        }
//    }
//    else if(buttonIndex==0)
//    {
//        NSLog(@"cancel");
//        [alrt dismissWithClickedButtonIndex:0 animated:YES];
//        
//    }
//}
//
//
//
//
//-(void) addCertification
//{
//    
//    isCallBack=@"12";
//    [app AddCertificateDetails:vc1 ];
//    
//    
//    NSLog(@"Certification add ");
//}
//-(void) updateCertification:(id)sender
//{
//    isCallBack=@"13";
//    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
//    int idd=ges.view.tag;
//    NSLog(@"id of Certification update %d",idd);
//    [app EditCertificateDetails:vc1 :idd:certificationAr];
//    
//}
//-(void) deleteCertification:(id)sender
//{
//    
//    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
//    CertID=(int)tg.view.tag;
//    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//    [alrt show];
//    [self alertView:alrt clickedButtonAtIndex:2];
//    
//}
//
//
//
//-(void) addAward
//{
//    isCallBack=@"15";
//    [app AddAward:vc1];
//}
//-(void) updateAward:(id)sender
//{
//    isCallBack=@"16";
//    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
//    int idd=ges.view.tag;
//    [app EditAward:vc1 :awardAr :idd];
//    
//    
//    NSLog(@"id of Award update %d",idd);
//}
//-(void) deleteAward:(id)sender
//{
//    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
//    awardId=(int)tg.view.tag;
//    NSLog(@"value od awrdid is %d",awardId);
//    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//    [alrt show];
//    [self alertView:alrt clickedButtonAtIndex:2];
//    
//}
//
//
//
//-(IBAction)addEduProfile:(id)sender
//{
//    [self addEducationDetails :vc1:0];
//    NSLog(@"doneee Edit education profile");
//}
//
//-(void) updateEducation:(id)sender
//{
//    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
//    selId=ges.view.tag;
//    
//    [self addEducationDetails:vc1:(int) 1];
//    
//    NSLog(@"id of eduction update %d",selId);
//}
//-(void) deleteEducation:(id)sender
//{
//    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
//    EducId=(int)tg.view.tag;
//    
//    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//    [alrt show];
//    [self alertView:alrt clickedButtonAtIndex:2];
//    
//}
//
//-(IBAction)editProfile:(id)sender
//{
//    NSLog(@"doneee Edit Profile");
//}
//
//-(void)chooseOption
//{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Mode:"preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    UIAlertAction* drivingAction = [UIAlertAction actionWithTitle:@"Use Camera" style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction * action){
//                                                              [self openGallary];
//                                                              
//                                                          }];
//    
//    UIAlertAction *walkingAction = [UIAlertAction actionWithTitle:@"Use Gallary" style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction * action){
//                                                              [self openCamera];
//                                                              
//                                                          }];
//    
//    
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:drivingAction];
//    [alert addAction:walkingAction];
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
//    
//}
//
//-(void) openCamera
//{
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePickerController.delegate = self;
//    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
//    {
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            
//            [self presentViewController:imagePickerController animated:YES completion:nil];
//        }];
//    }
//    else{
//        
//        [self presentViewController:imagePickerController animated:YES completion:nil];
//    }
//}
//
//-(void) openGallary
//{
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
//        imagePicker.delegate = self;
//        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        imagePicker.allowsEditing = YES;
//        [self presentModalViewController:imagePicker animated:YES];
//        randomImgName = [self randomImagName];
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Camera Unavailable"  message:@"Unable to find a camera on your device."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        alert = nil;
//    }
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//    UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
//    NSData* data = UIImageJPEGRepresentation(outputImage, 1.0f);
//    imgBuffer= [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    randomImgName = [self randomImagName];
//    
//    imggeter.image = outputImage;
//    
//    
//}
//
//
//-(NSString *) randomImagName
//{
//    
//    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//    NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
//    for (int i=0; i<12; i++)
//    {
//        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
//    }
//    NSString *rnd=[randomString stringByAppendingString:@".png"];
//    
//    return rnd;
//}
//
//
//
//
//
//
//-(void) addEducationDetails:(UIViewController*)Vc:(int) isup
//{
//    NSString *iname,*iadd,*icoun, *isate,*icity, *iboard,*imarks,*istream,*isub,*iyear,*istitle;
//    
//    if(isup==0)
//    {
//        iname=@"Enter Institute/College Name";
//        iadd=@"Enter Address";
//        icoun= @"Select Country";
//        isate=@"Select State";
//        icity=@"Select City";
//        iboard=@"Enter Board";
//        imarks=@"Enter Marks";
//        istream=@"Enter Stream";
//        isub=@"Enter subject";
//        iyear=@"Select Year";
//        istitle=@"ADD Education Details";
//    }
//    
//    else if(isup==1)
//    {
//        for(int x=0;x<[eduAr count];x++)
//        {
//            int pre=[[[eduAr objectAtIndex:x] valueForKey:@"edu_id"] intValue];
//            if(selId==pre)
//            {
//                iname=[[eduAr objectAtIndex:x] valueForKey:@"college_name"];
//                iadd=[[eduAr objectAtIndex:x] valueForKey:@"address"];;
//                icoun= [[eduAr objectAtIndex:x] valueForKey:@"country"];
//                isate=[[eduAr objectAtIndex:x] valueForKey:@"state"];
//                icity=[[eduAr objectAtIndex:x] valueForKey:@"city"];
//                iboard=[[eduAr objectAtIndex:x] valueForKey:@"university"];
//                imarks=[NSString stringWithFormat:@"%@",[[eduAr objectAtIndex:x] valueForKey:@"marks"]];
//                istream=[[eduAr objectAtIndex:x] valueForKey:@"stream"];
//                isub=[[eduAr objectAtIndex:x] valueForKey:@"subjects"];
//                iyear=[NSString stringWithFormat:@"%@",[[eduAr objectAtIndex:x] valueForKey:@"year"]];
//                istitle=@"Update Education Details";
//                break;
//            }
//        }
//    }
//    
//    NSMutableDictionary *educlr=[SavePrefrences sharedInstance].colorDictionry;
//    UIColor *color = [UIColor blackColor];
//    
//    [self MainView:vc1 :istitle];
//
//    name=[[UITextField alloc] initWithFrame:CGRectMake(10, 5, scrollbar.frame.size.width-20, 40)];
//    name.backgroundColor=[UIColor whiteColor];
//    name.textColor=[educlr valueForKey:@"Scrollcolor"];
//    [name setFont:[UIFont fontWithName:@"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    
//    name.delegate=self;
//    name.layer.cornerRadius=6;
//    [scrollbar addSubview:name];
//    if(isup==0)
//        name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:iname attributes:@{NSForegroundColorAttributeName: color}];
//    else if(isup==1)
//        name.text = iname;
//    
//    
//    
//    
//    address=[[UITextField alloc] initWithFrame:CGRectMake(10, name.frame.size.height+name.frame.origin.y+10, scrollbar.frame.size.width-20, 40)];
//    address.backgroundColor=[UIColor whiteColor];
//    address.textColor=[educlr valueForKey:@"Scrollcolor"];
//    [address setFont:[UIFont fontWithName:@"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    
//    
//    address.delegate=self;
//    address.layer.cornerRadius=6;
//    [scrollbar addSubview:address];
//    
//    if(isup==0)
//        address.attributedPlaceholder=[[NSAttributedString alloc] initWithString:iadd attributes:@{NSForegroundColorAttributeName: color}];
//    else if(isup==1)
//        address.text = iadd;
//    
//    
//    
//    country=[[UILabel alloc] initWithFrame:CGRectMake(10, address.frame.size.height+address.frame.origin.y+10, scrollbar.frame.size.width-20, 40)];
//    country.text=icoun;
//    country.backgroundColor=[UIColor whiteColor];
//    
//    [country setFont:[UIFont fontWithName:@"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    country.textColor=[educlr valueForKey:@"Scrollcolor"];
//    country.layer.cornerRadius=6;
//    country.clipsToBounds=YES;
//    [scrollbar addSubview:country];
//    
//    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
//    [cityreg setNumberOfTouchesRequired:1];
//    [cityreg setDelegate:self];
//    country.userInteractionEnabled = YES;
//    [country addGestureRecognizer:cityreg];
//    
//    
//    
//    
//    
//    sate=[[UILabel alloc] initWithFrame:CGRectMake(10, country.frame.size.height+country.frame.origin.y+10, scrollbar.frame.size.width-20, 40)];
//    sate.text=isate;
//    sate.backgroundColor=[UIColor whiteColor];
//    [sate setFont:[UIFont fontWithName:@"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    
//    sate.textColor=[educlr valueForKey:@"Scrollcolor"];
//    sate.layer.cornerRadius=6;
//    sate.clipsToBounds=YES;
//    [scrollbar addSubview:sate];
//    
//    UITapGestureRecognizer *stateges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
//    [stateges setNumberOfTouchesRequired:1];
//    [stateges setDelegate:self];
//    sate.userInteractionEnabled = YES;
//    [sate addGestureRecognizer:stateges];
//    
//    
//    city=[[UILabel alloc] initWithFrame:CGRectMake(10, sate.frame.size.height+sate.frame.origin.y+10, scrollbar.frame.size.width-20, 40)];
//    city.text=icity;
//    city.backgroundColor=[UIColor whiteColor];
//    
//    [city setFont:[UIFont fontWithName:@"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    city.textColor=[educlr valueForKey:@"Scrollcolor"];
//    city.layer.cornerRadius=6;
//    city.clipsToBounds=YES;
//    [scrollbar addSubview:city];
//    
//    
//    UITapGestureRecognizer *cityges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
//    [cityges setNumberOfTouchesRequired:1];
//    [cityges setDelegate:self];
//    city.userInteractionEnabled = YES;
//    [city addGestureRecognizer:cityges];
//    
//    
//    board=[[UITextField alloc] initWithFrame:CGRectMake(10, city.frame.size.height+city.frame.origin.y+10, scrollbar.frame.size.width-20, 40)];
//    board.backgroundColor=[UIColor whiteColor];
//    board.textColor=[educlr valueForKey:@"Scrollcolor"];
//    [board setFont:[UIFont fontWithName:@"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    
//    board.delegate=self;
//    board.layer.cornerRadius=6;
//    [scrollbar addSubview:board];
//    if(isup==0)
//        board.attributedPlaceholder=[[NSAttributedString alloc] initWithString:iboard attributes:@{NSForegroundColorAttributeName: color}];
//    else if(isup==1)
//        board.text = iboard;
//    
//    
//    
//    
//    marks=[[UITextField alloc] initWithFrame:CGRectMake(10, board.frame.size.height+board.frame.origin.y+10, scrollbar.frame.size.width-20, 40)];
//    marks.backgroundColor=[UIColor whiteColor];
//    marks.textColor=[educlr valueForKey:@"Scrollcolor"];
//    [marks setFont:[UIFont fontWithName: @"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    
//    marks.delegate=self;
//    marks.layer.cornerRadius=6;
//    [scrollbar addSubview:marks];
//    if(isup==0)
//        marks.attributedPlaceholder=[[NSAttributedString alloc] initWithString:imarks attributes:@{NSForegroundColorAttributeName: color}];
//    else if(isup==1)
//        marks.text = imarks;
//    
//    
//    
//    stream=[[UITextField alloc] initWithFrame:CGRectMake(10, marks.frame.size.height+marks.frame.origin.y+10, scrollbar.frame.size.width-20, 40)];
//    stream.backgroundColor=[UIColor whiteColor];
//    stream.textColor=[educlr valueForKey:@"Scrollcolor"];
//    [stream setFont:[UIFont fontWithName:@"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    stream.delegate=self;
//    stream.layer.cornerRadius=6;
//    [scrollbar addSubview:stream];
//    if(isup==0)
//        stream.attributedPlaceholder=[[NSAttributedString alloc] initWithString:istream attributes:@{NSForegroundColorAttributeName: color}];
//    else if(isup==1)
//        stream.text = istream;
//    
//    
//    subjects=[[UITextField alloc] initWithFrame:CGRectMake(10, stream.frame.size.height+stream.frame.origin.y+10, scrollbar.frame.size.width-20, 40)];
//    subjects.backgroundColor=[UIColor whiteColor];
//    [subjects setFont:[UIFont fontWithName:@"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    subjects.textColor=[educlr valueForKey:@"Scrollcolor"];
//    subjects.delegate=self;
//    subjects.layer.cornerRadius=6;
//    [scrollbar addSubview:subjects];
//    
//    if(isup==0)
//        subjects.attributedPlaceholder=[[NSAttributedString alloc] initWithString:isub attributes:@{NSForegroundColorAttributeName: color}];
//    else if(isup==1)
//        subjects.text = isub;
//    
//    
//    year=[[UILabel alloc] initWithFrame:CGRectMake(10, subjects.frame.size.height+subjects.frame.origin.y+10, scrollbar.frame.size.width-20, 40)];
//    year.text=iyear;
//    year.backgroundColor=[UIColor whiteColor];
//    [year setFont:[UIFont fontWithName:@"Times New Roman" size:[SavePrefrences sharedInstance].textsize]];
//    year.textColor=[educlr valueForKey:@"Scrollcolor"];
//    
//    year.layer.cornerRadius=6;
//    year.clipsToBounds=YES;
//    [scrollbar addSubview:year];
//    
//    UITapGestureRecognizer *yearges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yearSel:)];
//    [yearges setNumberOfTouchesRequired:1];
//    [yearges setDelegate:self];
//    year.userInteractionEnabled = YES;
//    [year addGestureRecognizer:yearges];
//    
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(40, year.frame.size.height+year.frame.origin.y+10, scrollbar.frame.size.width/2-40, 45)];
//    [save setTitle: @"Add" forState: UIControlStateNormal];
//    save.tag=isup;
//    save.backgroundColor=[educlr valueForKey:@"Yellowbtncolor"];
//    [save addTarget:self action:@selector(saveEducationProfile:) forControlEvents:UIControlEventTouchUpInside];
//    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    save.layer.cornerRadius=5;
//    [scrollbar addSubview:save];
//    
//    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, year.frame.size.height+year.frame.origin.y+10, scrollbar.frame.size.width/2-40, 45)];
//    [cancel setTitle: @"Close" forState: UIControlStateNormal];
//    cancel.backgroundColor=[educlr valueForKey:@"Yellowbtncolor"];
//    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
//    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    cancel.layer.cornerRadius=5;
//    [scrollbar addSubview:cancel];
//    
//    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, 600);
//    
//}
//
//-(IBAction)cancel:(id)sender
//{
//   [prMaintitView removeFromSuperview];
//}
//
//
//
//-(IBAction)saveEducationProfile:(id)sender
//{
//    UIButton *bt=sender;
//    if([av checkNull:name])
//    {
//        if([av checkNull:address])
//        {
//            if([av checkCombo:country] &&[av checkCombo:sate] &&[av checkCombo:city])
//            {
//                if([av checkNull:board])
//                {
//                    if([av checkNull:marks]&&[av validateStringContainsNumbersOnly:marks.text])
//                    {
//                        if([av checkNull:stream]&&[av checkNull:subjects]){
//                            if([av checkCombo:year])
//                            {
//                                if([av validateAlphabetsonly:name.text]&&[av validateAlphabetsonly:board.text] && [av validateAlphabetsonly:stream.text] && [av validateAlphabetsonly:subjects.text])
//                                {
//                                    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//                                    [dic1 setValue:@"1" forKey:@"k"];
//                                    [dic1 setValue: country.text forKey:@"cont"];
//                                    [dic1 setValue:sate.text forKey:@"state"];
//                                    [dic1 setValue:city.text forKey:@"city"];
//                                    [dic1 setValue :name.text  forKey:@"org"];
//                                    [dic1 setValue:board.text forKey:@"board"];
//                                    [dic1 setValue:marks.text forKey:@"marks"];
//                                    [dic1 setValue:stream.text forKey:@"stream"];
//                                    [dic1 setValue:subjects.text forKey:@"sub"];
//                                    [dic1 setValue:year.text forKey:@"yr"];
//                                    [dic1 setValue:[NSString stringWithFormat:@"%d",selId]forKey:@"eid"];
//                                    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//                                    [dic1 setValue:address.text forKey:@"add"];
//                                    
//                                    if(bt.tag==0)
//                                    {
//                                        isCallBack=@"7";
//                                        [[SavePrefrences sharedInstance].skthand emitData:@"Education" :@"SaveEdu" :@"":@"":dic1 :self];
//                                    }
//                                    else if (bt.tag==1)
//                                    {
//                                        isCallBack=@"8";
//                                        [[SavePrefrences sharedInstance].skthand emitData:@"Education" :@"updateEdu" :@"":@"":dic1 :self];
//                                    }
//                                    NSLog(@"Send to server");
//                                    
//                                    
//                                    
//                                    
//                                    [prMaintitView removeFromSuperview];
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            
//        }     }
//    
//    
//}
//-(void)dissmisspop
//{
//    int cnt=(int)[popUpAr count]-1;
//    NSLog(@"pop ar count===%d",cnt);
//    
//    if([popUpAr count]>0)
//    {
//        
//        UIView *ppv=[popUpAr objectAtIndex:cnt] ;
//        [ppv removeFromSuperview];
//        [popUpAr removeObjectAtIndex:cnt];
//    }
//    
//    if([popUpAr count]==0)
//    {
//        id<CallTo_Parent>  cb= vc1;
//        [cb callMethod:nil];
//    }
//    
//
//}
//-(void)countrySel:(id)sender
//{
//    if(countryAr !=nil&&[countryAr count]>0)
//    {
//        [self showCountry];
//    }
//    else
//    {
//        NSLog(@"pop up array cun tids %lu",[popUpAr count]);
//        isCallBack=@"4";
//        SelectCountry * sc=[[SelectCountry alloc]init];
//        [sc getCountryList:self];
//    }
//    
//}
//-(void)stateSel:(id)sender
//{
//    
//    isCallBack=@"5";
//    SelectCountry * sc=[[SelectCountry alloc]init];
//    [sc getState:self:cid];
//    
//}
//
//
//-(void)citySel:(id)sender
//{
//    isCallBack=@"6";
//    SelectCountry * sc=[[SelectCountry alloc]init];
//    [sc getCity:self:stid];
//}
//
//-(void) showCountry
//{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Country:"preferredStyle:UIAlertControllerStyleActionSheet];
//    for(int x=0;x<[countryAr count];x++)
//    {
//        NSString *stname=[[countryAr objectAtIndex:x] valueForKey:@"countryName"];
//        NSString *cid1=[[countryAr objectAtIndex:x] valueForKey:@"countryID"];
//        
//        
//        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                                        {
//                                            country.text=stname;
//                                            sate.text=@"Select State";
//                                            city.text=@"Select City";
//                                            cid=cid1;
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
//
//
//-(void) showState
//{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select State:"preferredStyle:UIAlertControllerStyleActionSheet];
//    for(int x=0;x<[stateAr count];x++)
//    {
//        NSString *stname=[[stateAr objectAtIndex:x] valueForKey:@"stateName"];
//        NSString *sid1=[[stateAr objectAtIndex:x] valueForKey:@"stateID"];
//        
//        
//        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                                        {
//                                            NSString * tile= [action title];
//                                            sate.text=stname;
//                                            stid=sid1;
//                                            city.text=@"Select City";
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
//-(void) showCity
//{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select city:"preferredStyle:UIAlertControllerStyleActionSheet];
//    for(int x=0;x<[cityAr count];x++)
//    {
//        
//        NSString *cityName=[[cityAr objectAtIndex:x] valueForKey:@"cityName"];
//        NSString *cityID=[[cityAr objectAtIndex:x] valueForKey:@"cityID"];
//        
//        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:cityName style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                                        {
//                                            NSString * tile= [action title];
//                                            city.text=cityName;
//                                        }];
//        [alert addAction:drivingAction];
//    }
//    
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:defaultAction];
//    [vc1 presentViewController:alert animated:YES completion:nil];
//    
//    
//}
//
//
//
//
//-(void)yearSel:(id)sender
//{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select city:"preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    NSMutableArray *cityAr=[[NSMutableArray alloc]init];
//    [cityAr addObject:@"abc"];
//    
//    for(int x=1965;x<2050;x++)
//    {
//        NSString *stname=[NSString stringWithFormat:@"%d",x];
//        
//        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                                        {
//                                            NSString * tile= [action title];
//                                            NSLog(@"title value %@",tile);
//                                            year.text=stname;
//                                        }];
//        [alert addAction:drivingAction];
//    }
//    
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:defaultAction];
//    [vc1 presentViewController:alert animated:YES completion:nil];
//}
//
//
//
//
//
//
//-(void) callBack:(NSArray *)META  :(NSArray *)DATA
//{
//    int   isCallBack1=[isCallBack intValue];
//    if(isCallBack1==0)
//    {
//        NSLog(@"profile meta %@",META);
//        NSLog(@"profile Deta %@",DATA);
//        
//        NSArray * md=[META valueForKey:@"data"];
//        eduAr=[md valueForKey:@"userEdu"];
//        [self showEducation];
//    }
//    else if (isCallBack1==1)
//    {
//        NSLog(@"employement meta %@",META);
//        NSLog(@"employement Deta %@",DATA);
//        NSArray * md=[META valueForKey:@"data"];
//        employmntAr=[md valueForKey:@"userEmp"];
//        NSLog(@"data in employement array is %@",employmntAr);
//        [self showEmployment:employmntAr];
//    }
//    
//    else if (isCallBack1==2)
//    {
//        
//        NSArray * md=[META valueForKey:@"data"];
//        certificationAr=[md valueForKey:@"userEmp"];
//        [self showCertification];
//        
//        NSLog(@"certification meta %@",META);
//        NSLog(@"certification Deta %@",DATA);
//        
//    }
//    
//    else if (isCallBack1==3)
//    {
//        NSArray * md=[META valueForKey:@"data"];
//        awardAr=[md valueForKey:@"userAward"];
//        
//        [self showAward];
//    }
//    
//    else if (isCallBack1==4)//select Counrt
//    {
//        NSArray * md=[META valueForKey:@"data"];
//        countryAr=[md valueForKey:@"country"];
//        [self showCountry];
//        
//    }
//    else if(isCallBack1==5)
//    {
//        NSArray * md=[META valueForKey:@"data"];
//        stateAr=[md valueForKey:@"statesData"];
//        [self showState];
//    }
//    
//    else if(isCallBack1==6)
//    {
//        NSArray * md=[META valueForKey:@"data"];
//        cityAr=[md valueForKey:@"statesData"];
//        [self showCity];
//    }
//    
//    else if(isCallBack1==7)
//    {
//        
//        NSLog(@"profile sacved  meta  %@",META);
//        NSLog(@"profile sacved  data  %@",DATA);
//        eduAr=DATA;
//        [self showEducation];
//        [prMainView removeFromSuperview];
//    }
//    else if(isCallBack1==8)
//    {
//        NSLog(@"delete edu  meta  %@",META);
//        NSLog(@"delete edu  data  %@",DATA);
//        [self educationDetail];
//    }
//    else if (isCallBack1==9)
//    {
//        NSLog(@"employement9 meta %@",META);
//        NSLog(@"employement9 Deta %@",DATA);
//        employmntAr=DATA;
//        [self showEmployment:employmntAr];
//    }
//    
//    else if (isCallBack1==10)
//    {
//        NSLog(@"update employement meta %@",META);
//        NSLog(@"update employe,e Deta %@",DATA);
//        //employmntAr=DATA;
//        [self showEmployment:DATA];
//    }
//    else if (isCallBack1==11)
//    {
//        alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted  Successfully!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        [alrt show];
//        [alrt dismissWithClickedButtonIndex:0 animated:YES];
//        employmntAr=[DATA valueForKey:@"employment"];
//        [self showEmployment:employmntAr];
//    }
//    else if (isCallBack1==12)
//    {
//        certificationAr=DATA;
//        [self showCertification];
//    }
//    else if (isCallBack1==13)
//    {
//        NSLog(@"edit certificate meta %@",META);
//        NSLog(@"edit certificate,e Deta %@",DATA);
//        certificationAr=[DATA valueForKey:@"certificate"];
//        [self showCertification];
//    }
//    else if (isCallBack1==14)
//    {
//        NSLog(@"delete certificate meta %@",META);
//        NSLog(@"delete certificate,e Deta %@",DATA);
//        certificationAr=[DATA valueForKey:@"certificate"];
//        [self showCertification];
//    }
//    
//    else if (isCallBack1==15)
//    {
//        NSLog(@"add award  meta %@",META);
//        NSLog(@"addawtd ,e Deta %@",DATA);
//        awardAr=DATA;
//        [self showAward];
//        
//    }
//    else if (isCallBack1==16)
//    {
//        NSLog(@"update award  meta %@",META);
//        NSLog(@"update award ,e Deta %@",DATA);
//        
//        awardAr=[DATA valueForKey:@"awards"];
//        [self showAward];
//        
//        
//    }
//    else if (isCallBack1==18)
//    {
//        NSLog(@"profile updatedeee meta  %@",META);
//        NSLog(@"profile updated data  %@",DATA);
//        
//        NSArray *pf=[META valueForKey:@"data"];
//        NSArray *data=[pf valueForKey:@"details"];
//        ProfileAr=data;
//        NSArray *inddta=[pf valueForKey:@"usrPro"];
//        [app editMainProfile :vc1 :ProfileAr:inddta];
//    }
//    else if (isCallBack1==19)
//    {
//        [self addProfileimage:DATA];
//    }
//    else if (isCallBack1==20)
//    {
//        NSString *affectedrows= [DATA valueForKey:@"affectedRows"];
//        
//        if([affectedrows intValue]>0)
//        {
//            alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted  Successfully!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            [alrt show];
//            [alrt dismissWithClickedButtonIndex:0 animated:YES];
//            eduAr=DATA;
//            [self educationDetail];
//        }
//    }
//    else if (isCallBack1==22)
//    {
//        NSString *affectedrows= [DATA valueForKey:@"affectedRows"];
//        
//        if([affectedrows intValue]>0)
//        {
//            alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted  Successfully!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            [alrt show];
//            [alrt dismissWithClickedButtonIndex:0 animated:YES];
//            eduAr=DATA;
//            [self calForAward];
//        }
//    }
//    
//    
//}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//
//@end
//
