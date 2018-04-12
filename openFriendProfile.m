
#import "openFriendProfile.h"
#import "SavePrefrences.h"
#import "ManageArray.h"
#import "LeftRightDrawer.h"
#import "MainBord.h"

@interface openFriendProfile ()
{
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;

    NSArray *profilear1;
    UIView *mainView,*imageview,*actionView;
    UIScrollView *mainScrollView1;
    UIImageView *imggeter;
    ManageArray *mngAr;
    LeftRightDrawer *drawer;
       UIViewController *vc1;
    
}
@end

@implementation openFriendProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    mngAr=[[ManageArray alloc]init];
    drawer =[[LeftRightDrawer alloc]init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [self.
     navigationController setNavigationBarHidden:NO animated:NO];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    naviWidth = self.navigationController.navigationBar.frame.size.width;
    naviHght =  self.navigationController.navigationBar.frame.size.height;
    stbarHght= (float)[[UIApplication sharedApplication] statusBarFrame].size.height;
    
   
    
    
    UILabel *Toplbl = [[UILabel alloc]initWithFrame:CGRectMake(120,0,200,40)];
    Toplbl.font = [UIFont systemFontOfSize:25];
    Toplbl.numberOfLines = 1;
    Toplbl.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    Toplbl.adjustsFontSizeToFitWidth = YES;
    Toplbl.minimumScaleFactor = 10.0f/12.0f;
    Toplbl.clipsToBounds = YES;
    Toplbl.backgroundColor = [UIColor clearColor];
    Toplbl.textColor = [UIColor whiteColor];
    Toplbl.textAlignment = NSTextAlignmentLeft;
    Toplbl.text = @"Proyolk";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:Toplbl];
    self.navigationController.navigationBar.barTintColor =[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    self.navigationController.navigationBar.backgroundColor =[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0];
    

    
    [drawer initArs:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)customizeActionBar
{
    
    vc1.view.backgroundColor=[UIColor colorWithRed:49.0f/255.0f green:70.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
    actionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,  [SavePrefrences sharedInstance].screenWidth,70)];
    actionView.backgroundColor=[UIColor yellowColor];
    actionView.backgroundColor =[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    [vc1.view addSubview:actionView];
    
    UIImageView *leftdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(5, 25,
                                                                         25, 25)];
    leftdrawr.image = [UIImage imageNamed:@"drawerwhite.png"];
    leftdrawr.backgroundColor=[UIColor clearColor];
    [actionView addSubview:leftdrawr];
    
    UITapGestureRecognizer *addleftges = [[UITapGestureRecognizer
                                           alloc]initWithTarget:self action:@selector(openLeftDrawer)];
    [addleftges setNumberOfTouchesRequired:1];
    leftdrawr.userInteractionEnabled = YES;
    [leftdrawr addGestureRecognizer:addleftges];
    
    UIImageView *logo =[[UIImageView
                         alloc]initWithFrame:CGRectMake(leftdrawr.frame.size.width+20, 20, 125, 38)];
    logo.image = [UIImage imageNamed:@"logo.png"];
    logo.backgroundColor=[UIColor clearColor];
    [actionView addSubview:logo];
    
    UIImageView *rightdrawr =[[UIImageView
                               alloc]initWithFrame:CGRectMake(actionView.frame.size.width-30, 25, 28, 28)];
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

-(void )addProfileimage:(NSArray *) profileAr
{
    
    profilear1=profileAr;
    NSMutableDictionary *bd=[SavePrefrences sharedInstance].colorDictionry;
    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,actionView.frame.size.height,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight-(actionView.frame.size.height))];
    mainView.backgroundColor=[bd valueForKey:@"bodycolor"];
    [vc1.view addSubview:mainView];
    
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,[SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    mainScrollView1.backgroundColor=[UIColor colorWithRed:172/255.0f
                                                    green:172/255.0f blue:172/255.0f alpha:0.0f];
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake([SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight);
    
    [mainView addSubview:mainScrollView1];
    
    
    imageview=[[UIView alloc] initWithFrame:CGRectMake(10, 60, mainScrollView1.frame.size.width-20, 100)];
    imageview.backgroundColor=[UIColor colorWithRed:70/255.0f green:130/255.0f
                                               blue:180/255.0f alpha:1.0f];
    imageview.layer.cornerRadius=30;
    [mainScrollView1 addSubview:imageview];
    
    imggeter=[[UIImageView alloc]initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, 10, 100, 100)];
    imggeter.layer.backgroundColor=[[UIColor clearColor] CGColor];
    imggeter.layer.cornerRadius=50;
    imggeter.layer.borderWidth=1.0;
    imggeter.layer.masksToBounds = YES;
    
    [mainScrollView1 addSubview:imggeter];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOption)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    imggeter.userInteractionEnabled = YES;
    [imggeter addGestureRecognizer:tapRecognizer];
    
    NSString *img=[[profileAr valueForKey:@"img"] objectAtIndex:0];
    NSString * url=[mngAr concatUrl:img];
    
    NSLog(@"imag vw %lu",(unsigned long)url.length);
    if(url.length<12)
    {
        imggeter.image = [UIImage imageNamed:@"username.png"];
    }
    else
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL
                                                           URLWithString:url]];
        
        if (imageData.length<=0)
            imggeter.image = [UIImage imageNamed:@"username.png"];
        else
            imggeter.image = [UIImage imageWithData:imageData];
    }
    imggeter.userInteractionEnabled = YES;
    
    UILabel *NameLabel=[[UILabel alloc]
                        initWithFrame:CGRectMake((imageview.frame.size.width-80)/2,
                                                 imggeter.frame.origin.y+imggeter.frame.size.height, 100, 20)];
    if([mngAr checkStringNull:[[profileAr valueForKey:@"fname"]
                               objectAtIndex:0]])
    {
        NameLabel.text=[[profileAr valueForKey:@"fname"] objectAtIndex:0];
    }
    NameLabel.font=[UIFont systemFontOfSize:10];
    NameLabel.textColor=[UIColor whiteColor];
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [mainScrollView1 addSubview:NameLabel];
    
    UILabel *location=[[UILabel alloc]initWithFrame:CGRectMake((imageview.frame.size.width)/2-50,NameLabel.frame.origin.y+NameLabel.frame.size.height-8, imageview.frame.size.width, 20)];
    if([mngAr checkStringNull:[[profileAr valueForKey:@"city"]objectAtIndex:0]])
    {
        location.text=[[[[[[profileAr valueForKey:@"city"]objectAtIndex:0] stringByAppendingString:@","]stringByAppendingString:[[profileAr valueForKey:@"state"]objectAtIndex:0]]stringByAppendingString:@","]stringByAppendingString:[[profileAr valueForKey:@"country"]objectAtIndex:0]];
    }
    
    location.font=[UIFont systemFontOfSize:10];
    location.textColor=[UIColor whiteColor];
    location.textAlignment=NSTextAlignmentLeft;
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
    [btnAr addObject:@"View Video Resume"];
    
    NSMutableArray *coloAr=[[NSMutableArray alloc]init];
    NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
    
    [coloAr addObject:[cc valueForKey:@"Profcolor"]];
    [coloAr addObject:[cc valueForKey:@"Educolor"]];
    [coloAr addObject:[cc valueForKey:@"Emplcolor"]];
    [coloAr addObject:[cc valueForKey:@"Certcolor"]];
    [coloAr addObject:[cc valueForKey:@"Awardscolor"]];
    [coloAr addObject:[cc valueForKey:@"Videocolor"]];
    
    int lineviewY=imageview.frame.size.height+imageview.frame.origin.y+10;
    UIView *lineView1;
    for(int x=0;x<[btnAr count];x++)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10,lineviewY, [SavePrefrences sharedInstance].screenWidth-20, 60)];
        lineView.backgroundColor=[coloAr objectAtIndex:x];
        lineView.layer.borderWidth=1.0f;
        lineView.layer.cornerRadius=8.0f;
        lineView.layer.borderColor =[[coloAr objectAtIndex:x]CGColor];
        lineView.tag=x;
        
        [mainScrollView1 addSubview:lineView];
        
        UILabel *btnArrowRoght =[[UILabel
                                  alloc]initWithFrame:CGRectMake(30,2,[SavePrefrences sharedInstance].screenWidth-50,lineView.frame.size.height-5)];
        
        btnArrowRoght.backgroundColor=[UIColor colorWithRed:172/255.0f
                                                      green:172/255.0f blue:172/255.0f alpha:0.0f];
        btnArrowRoght.font = [UIFont boldSystemFontOfSize: 15];
        btnArrowRoght.userInteractionEnabled=YES;
        btnArrowRoght.text=[btnAr objectAtIndex:x];
        NSMutableDictionary *txt=[SavePrefrences sharedInstance].colorDictionry;
        btnArrowRoght.textColor=[txt valueForKey:@"Tabstextcolor"];
        btnArrowRoght.textAlignment=NSTextAlignmentLeft;
        
        [lineView addSubview:btnArrowRoght];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer
                                                  alloc]initWithTarget:self action:@selector(openProfile:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [lineView addGestureRecognizer:tapRecognizer];
        
        UIImageView *rightimgview = [[UIImageView
                                      alloc]initWithFrame:CGRectMake(btnArrowRoght.frame.size.width+5,20, 20, 20)];
        [rightimgview setImage:[UIImage imageNamed:@"arrow.png"]];
        rightimgview.userInteractionEnabled= YES;
        [lineView addSubview:rightimgview];
        lineviewY= lineviewY+70;
        
    }
    
    int hsp=15;
    int div3=[SavePrefrences sharedInstance].screenWidth/3;
    
    NSMutableArray *listar=[[NSMutableArray alloc]init];
    [listar addObject:@"resume_mail.png"];
    [listar addObject:@"resume_upload.png"];
    [listar addObject:@"resume_download.png"];
    
    for(int x=0;x<[listar count];x++)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(hsp,lineviewY, [SavePrefrences sharedInstance].screenWidth/3-35, 50)];
        NSMutableDictionary *vd=[SavePrefrences sharedInstance].colorDictionry;
        lineView.backgroundColor=[vd valueForKey:@"Profcolor"];
        lineView.layer.borderWidth=1.0f;
        lineView.layer.cornerRadius=8.0f;
        lineView.layer.borderColor = [[vd valueForKey:@"Profcolor"]CGColor];
        
        UIImageView *rightimgview = [[UIImageView alloc]initWithFrame:CGRectMake(lineView.frame.size.width/2 -((div3 -65)/2),10,div3-65, 40)];
        rightimgview.tag=x;
        [rightimgview setImage:[UIImage imageNamed:[listar objectAtIndex:x]]];
        rightimgview.userInteractionEnabled= YES;
        [mainScrollView1 addSubview:lineView];
        [lineView addSubview:rightimgview];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(filUpload:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [rightimgview addGestureRecognizer:tapRecognizer];
        
        hsp=hsp+div3;
    }
    
    lineviewY= lineviewY+70;
    mainScrollView1.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, lineView1.frame.size.height+lineviewY+70);
    
}


@end
