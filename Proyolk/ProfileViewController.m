//
//  ProfileViewController.m
//  Proyolk
//
//  Created by Shiv ram on 03/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "ProfileViewController.h"
#import "SavePrefrences.h"
#import "ManageArray.h"
#import "UIImageView+WebCache.h"
#import "ProfileView.h"
#import <AVFoundation/AVFoundation.h>
#import "AllValidationsViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "LeftRightDrawer.h"

@interface ProfileViewController (){
    UIView* mainView;
    UIScrollView* mainScrollView1;
    UIView * imageview;
    UIImageView* imggeter;
    NSString *videoResume;
    ManageArray *mngAr;
    UILabel* NameLabel;
    UIView* videomainview;
    AVPlayer* player;
    UIView* mainouterView;
    UIImagePickerController* imagePicker;
    UITextField* mail;
    AllValidationsViewController *allValidVC;
    int iscallback;
    UIView* webviewView;
    UIView* actionView;
    UITableView* lefttableView;
    LeftRightDrawer *drawer;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mngAr = [[ManageArray alloc] init];
    allValidVC=[[AllValidationsViewController alloc]init];
    drawer = [[LeftRightDrawer alloc] init];
    [self customizeActionBar];
    [self fetchProfileData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchProfileData{
    iscallback=1;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:_userId forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile":@"showProfile" :@"":@"":dic1 :self];
}

-(void)customizeActionBar{
    [drawer initArs:self];
    NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
    self.view.backgroundColor=[brd valueForKey:@"backcolor"];
}
-(void)customizeActionBar1{
    
    self.view.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    
    actionView.backgroundColor =[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    
    actionView.layer.borderWidth=1;
    actionView.layer.borderColor=[[UIColor colorWithRed:126.0f/255 green:184.0f/255 blue:230.0f/255 alpha:1.0f] CGColor];
    
    [self.view addSubview:actionView];
    
    UIImageView *leftdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(5, 25, 40, 40)];
    leftdrawr.image = [UIImage imageNamed:@"drawerwhite.png"];
    leftdrawr.backgroundColor=[UIColor clearColor];
    [actionView addSubview:leftdrawr];
    
    UITapGestureRecognizer *addleftges = [[UITapGestureRecognizer
                                           alloc]initWithTarget:self action:@selector(openLeftDrawer)];
    [addleftges setNumberOfTouchesRequired:1];
    leftdrawr.userInteractionEnabled = YES;
    [leftdrawr addGestureRecognizer:addleftges];
    
    UIImageView *logo =[[UIImageView alloc]initWithFrame:CGRectMake(actionView.frame.size.width/2-75, 20, 150, 50)];
    logo.image = [UIImage imageNamed:@"logo_new.png"];
    logo.backgroundColor=[UIColor clearColor];
    [actionView addSubview:logo];
    
    
    
    UIImageView *rightdrawr =[[UIImageView alloc]initWithFrame:CGRectMake(actionView.frame.size.width-60, 20, 50, 50)];
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

- (void)setUpView:(NSArray*)profileAr{
    //here profile editing
    
    NSMutableDictionary *bd=[SavePrefrences sharedInstance].colorDictionry;
    actionView=[[UIView alloc]initWithFrame:CGRectMake(-2, -2,  [SavePrefrences
                                                                 sharedInstance].screenWidth+4,72)];
    
    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,actionView.frame.size.height,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight-(actionView.frame.size.height))];
    mainView.backgroundColor=[bd valueForKey:@"bodycolor"];
    [self.view addSubview:mainView];
    
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,[SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    mainScrollView1.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[UIColor colorWithRed:172/255.0f  green:172/255.0f blue:172/255.0f alpha:0.0f];
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake([SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight);
    
    [mainView addSubview:mainScrollView1];
    
    
    imageview=[[UIView alloc] initWithFrame:CGRectMake(10, 60, mainScrollView1.frame.size.width-20, 100)];
    imageview.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[UIColor colorWithRed:70/255.0f green:130/255.0f  blue:180/255.0f alpha:1.0f];
//    imageview.layer.cornerRadius=30;
    
    [mainScrollView1 addSubview:imageview];
    
    imggeter=[[UIImageView alloc]initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, 10, 100, 100)];
    imggeter.layer.backgroundColor=[[UIColor clearColor] CGColor];
    imggeter.layer.cornerRadius=50;
    imggeter.layer.borderWidth=1.0;
    imggeter.layer.masksToBounds = YES;
    imggeter.layer.borderColor=[[UIColor colorWithRed:217.0f/255.0f green:179.0f/255.0f blue:27.0f/255.0f alpha:1.0f]  CGColor];
    imggeter.layer.borderWidth=2.5;
    
    [mainScrollView1 addSubview:imggeter];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOption)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    imggeter.userInteractionEnabled = YES;
    [imggeter addGestureRecognizer:tapRecognizer];
    
    NSString *img=[[profileAr valueForKey:@"img"] objectAtIndex:0];
    videoResume=[[profileAr valueForKey:@"videoResume"] objectAtIndex:0];
    NSString * url=[mngAr concatUrl:img];
    
    NSLog(@"imag vw ============%@",url);
    if(url.length<12)
    {
        imggeter.image = [UIImage imageNamed:@"username.png"];
    }
    else
    {
        [imggeter sd_setImageWithURL:[NSURL URLWithString:url]];
        
        //        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        //
        //        if (imageData.length<=0)
        //            imggeter.image = [UIImage imageNamed:@"username.png"];
        //        else
        //            imggeter.image = [UIImage imageWithData:imageData];
    }
    imggeter.userInteractionEnabled = YES;
    
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,  imggeter.frame.origin.y+imggeter.frame.size.height, mainScrollView1.frame.size.width, 22)];
    if([mngAr checkStringNull:[[profileAr valueForKey:@"fname"] objectAtIndex:0]])
    {
        NameLabel.text=[[profileAr valueForKey:@"fname"] objectAtIndex:0];
    }
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];//[UIColor whiteColor];
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [mainScrollView1 addSubview:NameLabel];
    
    //here line below name
    int w =self.view.frame.size.width/2;
    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(w/2+w/4, NameLabel.frame.size.height+NameLabel.frame.origin.y+3, w/2, 1.25)];
    lblLine.backgroundColor=[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    [mainScrollView1 addSubview:lblLine];
    
    
    UILabel *location=[[UILabel alloc]initWithFrame:CGRectMake(0,lblLine.frame.size.height+lblLine.frame.origin.y+3, self.view.frame.size.width, 22)];
    if([mngAr checkStringNull:[[profileAr valueForKey:@"city"]objectAtIndex:0]])
    {
        location.text=[[[[[[profileAr valueForKey:@"city"]objectAtIndex:0] stringByAppendingString:@","]stringByAppendingString:[[profileAr valueForKey:@"state"]objectAtIndex:0]]stringByAppendingString:@","]stringByAppendingString:[[profileAr valueForKey:@"country"]objectAtIndex:0]];
    }
    
    location.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
    location.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    location.textAlignment=NSTextAlignmentCenter;
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
    [btnAr addObject:@"Video Resume"];
    
    NSMutableArray *coloAr=[[NSMutableArray alloc]init];
    /* NSMutableDictionary *cc=[SavePrefrences sharedInstance].colorDictionry;
     
     [coloAr addObject:[cc valueForKey:@"Profcolor"]];
     [coloAr addObject:[cc valueForKey:@"Educolor"]];
     [coloAr addObject:[cc valueForKey:@"Emplcolor"]];
     [coloAr addObject:[cc valueForKey:@"Certcolor"]];
     [coloAr addObject:[cc valueForKey:@"Awardscolor"]];
     [coloAr addObject:[cc valueForKey:@"Videocolor"]];*/
    
    
    [coloAr addObject:[UIColor colorWithRed:112.0f/255.0f green:185.0f/255.0f blue:164.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:143.0f/255.0f green:151.0f/255.0f blue:93.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:189.0f/255.0f green:162.0f/255.0f blue:226.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:131.0f/255.0f green:168.0f/255.0f blue:210.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:233.0f/255.0f green:181.0f/255.0f blue:175.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f]];
    
    
    int lineviewY=imageview.frame.size.height+imageview.frame.origin.y+10;
    UIView *lineView1;
    for(int x=0;x<[btnAr count];x++)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,lineviewY, [SavePrefrences sharedInstance].screenWidth, 40)];
        lineView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        lineView.tag=x;
        [mainScrollView1 addSubview:lineView];
        
        UILabel *btnArrowRoght =[[UILabel alloc]initWithFrame:CGRectMake(0,2,[SavePrefrences sharedInstance].screenWidth,lineView.frame.size.height-5)];
        btnArrowRoght.backgroundColor=[UIColor colorWithRed:172/255.0f green:172/255.0f blue:172/255.0f alpha:0.0f];
        btnArrowRoght.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        btnArrowRoght.userInteractionEnabled=YES;
        btnArrowRoght.text=[btnAr objectAtIndex:x];
        btnArrowRoght.textColor= [coloAr objectAtIndex:x];//[UIColor blackColor];
        btnArrowRoght.textAlignment=NSTextAlignmentCenter;
        [lineView addSubview:btnArrowRoght];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openProfile:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [lineView addGestureRecognizer:tapRecognizer];
        
        UIImageView *rightimgview = [[UIImageView alloc]initWithFrame:CGRectMake(btnArrowRoght.frame.size.width+5,20, 20, 20)];
        [rightimgview setImage:[UIImage imageNamed:@"arrow.png"]];
        rightimgview.userInteractionEnabled= YES;
        // [lineView addSubview:rightimgview];
        lineviewY= lineviewY+60;
        
        //here line
        int w =self.view.frame.size.width/2;
        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(w/2, btnArrowRoght.frame.size.height+btnArrowRoght.frame.origin.y+3, w, 1.25)];
        lblLine.backgroundColor=[coloAr objectAtIndex:x];//[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
        [lineView addSubview:lblLine];
        
    }
    
    int hsp=20;
    int div3=([SavePrefrences sharedInstance].screenWidth-30)/3;
    
    NSMutableArray *listar=[[NSMutableArray alloc]init];
    [listar addObject:@"resume_mail.png"];
    [listar addObject:@"resume_upload.png"];
    [listar addObject:@"resume_download.png"];
    
    for(int x=0;x<[listar count];x++)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(hsp,lineviewY+20, [SavePrefrences sharedInstance].screenWidth/3+30, 50)];
        lineView.backgroundColor=[UIColor clearColor];
        float wid=lineView.frame.size.width/2 -10;
        
        if (x==0) {
            UIImageView *rightimgview = [[UIImageView alloc]initWithFrame:CGRectMake(lineView.frame.size.width/2 -(wid/2),10,30, 25)];
            rightimgview.tag=x;
            [rightimgview setImage:[UIImage imageNamed:[listar objectAtIndex:x]]];
            rightimgview.userInteractionEnabled= YES;
            [mainScrollView1 addSubview:lineView];
            [lineView addSubview:rightimgview];
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(filUpload:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            [rightimgview addGestureRecognizer:tapRecognizer];
            
        }
        else
        {
            UIImageView *rightimgview = [[UIImageView alloc]initWithFrame:CGRectMake(lineView.frame.size.width/2 -(wid/2),5,30, 30)];
            rightimgview.tag=x;
            [rightimgview setImage:[UIImage imageNamed:[listar objectAtIndex:x]]];
            rightimgview.userInteractionEnabled= YES;
            [mainScrollView1 addSubview:lineView];
            [lineView addSubview:rightimgview];
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(filUpload:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            [rightimgview addGestureRecognizer:tapRecognizer];
            
        }
        
        hsp=hsp+div3;
    }
    
    lineviewY= lineviewY+10;
    mainScrollView1.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, lineView1.frame.size.height+lineviewY+70);
    
}

-(void) openProfile:(id)sender{
    UITapGestureRecognizer *ges=(UITapGestureRecognizer*) sender;
    int idd=(int)[ges.view tag];
    if(idd==0)
    {
        
        NSLog(@"Profile is clicked");
        
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"0";
        [self showViewController:vc2 sender:nil];
        
    }
    if(idd==1)
    {
        
        NSLog(@"Education is clicked");
        
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"1";
        [self showViewController:vc2 sender:nil];
        
    }if(idd==2)
    {
         NSLog(@"Employment is clicked");
        
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"2";
        [self showViewController:vc2 sender:nil];
        
    }
    if(idd==3)
    {
         NSLog(@"Certificate is clicked");
        
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"3";
        [self showViewController:vc2 sender:nil];
        
    }
    if(idd==4)
    {
        
        NSLog(@"Award is clicked");
        
        ProfileView *vc2=[[ProfileView alloc]init];
        vc2.istab=@"4";
        [self showViewController:vc2 sender:nil];
        
    }
    
    else if(idd==5)
    {
         NSLog(@"Video Resume is clicked");
        
        [self playVideoResunme];
    }
    
}

-(void)chooseOption{
    ProfileView *vc2=[[ProfileView alloc]init];
    vc2.istab=@"0";
    [self showViewController:vc2 sender:nil];
}

-(void)playVideoResunme{
    [videomainview removeFromSuperview];
    if(player!=nil)
        [player pause];
    
    videomainview = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    videomainview.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];
    [self.view addSubview:videomainview];
    
    UIView *innerVideopop = [[UIView alloc] initWithFrame:CGRectMake(20,100,[SavePrefrences sharedInstance].screenWidth-40,[SavePrefrences sharedInstance].screenHeight-350)];
    innerVideopop.backgroundColor=[UIColor blackColor];
    [videomainview addSubview:innerVideopop];
    
    // pach by kalpesh remove below one line
    
   // videoResume = @"introVideo.mp4";
    
    if(videoResume==nil||videoResume==NULL||[videoResume isEqual:[NSNull null]]||videoResume == (id)[NSNull null])
    {
        [videomainview removeFromSuperview];
        
        UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Video Resume Not Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        //       UIImageView *imgMultiples1 =[[UIImageView
        //                                     alloc]initWithFrame:CGRectMake(0,0, alert.frame.size.width,
        //                                                                    alert.frame.size.height)]; imgMultiples1.image = [UIImage imageNamed:@"noimg.png"];
        //       [alert addSubview:imgMultiples1];
        [alert show];
    }
    else
    {
        // https://proyolk.com/upload/515/videoResume/CrazyFrog-AxelF.3gp
     
        NSString  *url=@"https://www.proyolk.com";
        
        // Pach by kalpesh add comment and below code
        
        NSString *toplay=[url stringByAppendingString:videoResume];
     //   NSString *toplay=@"https://proyolk.com/upload/515/videoResume/CrazyFrog-AxelF.3gp";
        NSLog(@"fffffff=========%@",toplay);
        
        
        
        NSURL *videoURL = [NSURL URLWithString:toplay];
        player = [AVPlayer playerWithURL:videoURL];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        
        playerLayer.frame = CGRectMake(0, 10, innerVideopop.frame.size.width, innerVideopop.frame.size.height);
        [innerVideopop.layer addSublayer:playerLayer];
        [player play];
        
        UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(videomainview.frame.size.width/2-50, innerVideopop.frame.size.height+innerVideopop.frame.origin.y+50, 100, 40)];
        [save setTitle: @"Close" forState: UIControlStateNormal];
        save.backgroundColor=[UIColor blackColor];
        save.layer.borderColor=[[UIColor whiteColor] CGColor];
        save.layer.borderWidth=1;
        [save addTarget:self action:@selector(dissmissVideo:) forControlEvents:UIControlEventTouchUpInside];
        [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        save.layer.cornerRadius=5;
        [videomainview addSubview:save];
        
        
        
        
        //    //AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        //
        //    //videoURL = [NSURL URLWithString:@"http://techslides.com/demos/sample-videos/small.mp4"];
        //
        //    videoURL = [NSURL URLWithString:toplay];
        //
        //
        //    AVURLAsset *asset = [AVURLAsset assetWithURL: videoURL];
        //    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
        //
        //    AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
        //
        //    playerViewController.player = player;
        //
        //    [playerViewController.view setFrame:CGRectMake(0, 10, innerVideopop.frame.size.width, innerVideopop.frame.size.height)];
        //    
        //    playerViewController.showsPlaybackControls = YES;
        //    
        //    [innerVideopop addSubview:playerViewController.view];
        //    
        //    
        [player play];
    }
    
    //NSLog(@"urls====%@",videoURL);
}

-(IBAction)dissmissVideo:(id)sender{
    [player pause];
    [videomainview removeFromSuperview];
}

-(void) filUpload:(id)sender
{
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    int idd=(int)tapRecognizer.view.tag;
    
    if(idd==0)
    {
        NSLog(@"send email");
        [self sendEmail:nil];
    }
    else if (idd==1)
    {
        //        NSLog(@"upload");
        //        [mngAr showMessageToUser];
        
        [self video];
    }
    else if (idd==2)
    {
        NSLog(@"download====================");
        @try {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        
//            [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"getProfile" :@"" :@"":dic :self];
            
        NSString *upload= [[[SavePrefrences sharedInstance].skthand btkurl] stringByAppendingString:[NSString stringWithFormat:@"%@",@"upload"]];
        
        NSString *rsume=[[upload stringByAppendingPathComponent:_userId] stringByAppendingPathComponent:@"Resume"];
        NSString *pathis=[rsume stringByAppendingPathComponent:@"resume.pdf"];
        
        NSLog(@"path is %@",pathis);
        // https://proyolk.com/upload/515/Resume/resume.pdf
        //https://proyolk.com/upload/10/Resume/resume.pdf
        [self downloadResume:pathis];
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
        }
    }
}

-(void)sendEmail:(UIViewController*)Vc
{
    //    [self MainView:Vc :@"Mail"];
    //
    //    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    //
    //    scrollbar.frame=CGRectMake(20,NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, 200);
    //    scrollbar.backgroundColor=[ff valueForKey:@"Videocolor"];
    //
    //
    //
    //    UILabel *sendresume=[[UILabel alloc]initWithFrame:CGRectMake(30, 10,scrollbar.frame.size.width-20, 30)];
    //    sendresume.text=@"Send Resume";
    //    sendresume.textColor=[UIColor blackColor];
    //    [scrollbar addSubview:sendresume];
    //
    //    mail=[[UITextField alloc]initWithFrame:CGRectMake(20,sendresume.frame.size.height+sendresume.frame.origin.y+10,scrollbar.frame.size.width-40, 35)];
    //    mail.backgroundColor=[UIColor whiteColor];
    //    mail.layer.cornerRadius=5;
    //    mail.clipsToBounds=YES;
    //    mail.placeholder=@" Enter Email";
    //    mail.delegate=self;
    //    [scrollbar addSubview:mail];
    //
    //    UIButton *submit = [[UIButton
    //                         alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2-70,
    //                                                        mail.frame.size.height+mail.frame.origin.y+10, scrollbar.frame.size.width/2-30,
    //                                                        35)];
    //    [submit setTitle: @"Submit" forState: UIControlStateNormal];
    //    submit.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    //    [submit addTarget:self action:@selector(submitMail:)
    //     forControlEvents:UIControlEventTouchUpInside];
    //    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    submit.layer.cornerRadius=6;
    //    submit.tag=0;
    //    [scrollbar addSubview:submit];
    //
    //    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width,
    //                                     scrollbar.frame.size.height);
    
    
    
    
    NSMutableDictionary *edtprf=[SavePrefrences sharedInstance].colorDictionry;
    
    mainouterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    mainouterView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    mainouterView.layer.cornerRadius=10;
    [self.view addSubview:mainouterView];
    
    
    UIView *outerView = [[UIView alloc] initWithFrame:CGRectMake(10,([SavePrefrences sharedInstance].screenHeight/2)-100,mainouterView.frame.size.width-20,150)];
    outerView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    outerView.layer.cornerRadius=10;
    [mainouterView addSubview:outerView];
    
    
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,outerView.frame.size.width,150)];
    innerView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    innerView.layer.cornerRadius=10;
    [outerView addSubview:innerView];
    
    //233:243:253
    
    UILabel *titlab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, innerView.frame.size.width, 40)];
    titlab.text=@"Send E-mail";
    titlab.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    titlab.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
    titlab.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    titlab.layer.cornerRadius=10;
    titlab.clipsToBounds=YES;
    titlab.textAlignment=NSTextAlignmentCenter;
    [innerView addSubview:titlab];
    
    
    /* UILabel *coverLowerpart=[[UILabel alloc] initWithFrame:CGRectMake(0, titlab.frame.size.height+titlab.frame.origin.y-10, innerView.frame.size.width, 10)];
     coverLowerpart.backgroundColor=[UIColor colorWithRed:50.0f/255.0f green:98.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
     [innerView addSubview:coverLowerpart];*/
    
    mail=[[UITextField alloc]initWithFrame:CGRectMake(10, titlab.frame.size.height+titlab.frame.origin.y+15, innerView.frame.size.width-25, 30)];
    // mail.placeholder=@"Enter Email";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    mail.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Enter Email" attributes:@{NSForegroundColorAttributeName: color}];
    
    mail.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    mail.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    mail.leftView = paddingView2;
    mail.leftViewMode = UITextFieldViewModeAlways;
    
    mail.layer.cornerRadius=4;
    mail.delegate=self;
    [mail setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [innerView addSubview:mail];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35, mail.frame.size.height+mail.frame.origin.y+10, innerView.frame.size.width/2-40, 35)];
    [save setTitle: @"Send" forState: UIControlStateNormal];
    save.backgroundColor=[edtprf valueForKey:@"Yellowbtncolor"];
    [save.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [save addTarget:self action:@selector(submitMail:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //  save.layer.cornerRadius=5;
    [innerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+5, mail.frame.size.height+mail.frame.origin.y+10, innerView.frame.size.width/2-40, 35)];
    [cancel setTitle: @"Discard" forState: UIControlStateNormal];
    cancel.backgroundColor=[edtprf valueForKey:@"Yellowbtncolor"];
    [cancel.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [cancel addTarget:self action:@selector(discard1:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // cancel.layer.cornerRadius=5;
    [innerView addSubview:cancel];
    
    
}

-(IBAction)discard1:(id)sender{
    [mainouterView removeFromSuperview];
}

- (void)video {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    //    [vc1 presentModalViewController:imagePicker animated:YES];
}

-(IBAction)submitMail:(id)sender
{
    if([allValidVC NSStringIsValidEmail:mail.text]){
        [self.view endEditing:YES];
        [mainouterView removeFromSuperview];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:mail.text forKey:@"to"];
        [dic setObject:@"7" forKey:@"tp"];
        iscallback=3;
        [[SavePrefrences sharedInstance].skthand emitData:@"ProyolkMails" :@"getEmailData" :@"" :@"":dic :self];
    }
}

-(void)downloadResume:(NSString*)Path1{
    webviewView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [self.view addSubview:webviewView];
    webviewView.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.6f];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, webviewView.frame.size.width, webviewView.frame.size.height-100)];
    //[webView setDelegate:self];
    NSURL *url1 = [NSURL URLWithString:Path1];
    
    NSLog(@"url of resume===%@",url1);
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url1];
    [webView loadRequest:requestObj];
    webView.scalesPageToFit=YES;
    
    [webviewView addSubview:webView];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(webviewView.frame.size.width/2-50, webView.frame.size.height+webView.frame.origin.y+30, 100, 40)];
    [save setTitle: @"Close" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor blackColor];
    save.layer.borderColor=[[UIColor clearColor] CGColor];
    save.layer.borderWidth=1;
    [save addTarget:self action:@selector(dissmissWebView:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [webviewView addSubview:save];
    
    [self.view bringSubviewToFront:webviewView];
}

-(IBAction)dissmissWebView:(id)sender{
    [webviewView removeFromSuperview];
}

-(UIView *)openLeftDrawer
{
    //here left menu
    mainView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight+[SavePrefrences sharedInstance].stbarHght+5)];
    [self.view addSubview:mainView];
    mainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.1f];
    
    UIView *uiPostCmnt = [[UIView alloc]initWithFrame:CGRectMake(0,[SavePrefrences sharedInstance].naviHght+[SavePrefrences sharedInstance].stbarHght+6,mainView.frame.size.width/2-115,mainView.frame.size.height-(actionView.frame.size.height-5))];
    
    uiPostCmnt.backgroundColor=[UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:242.0f/255.0f alpha:1.0f];//[bd valueForKey:@"bodycolor"];
    [mainView addSubview:uiPostCmnt];
    
    UITapGestureRecognizer *addrightges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [addrightges setNumberOfTouchesRequired:1];
    [addrightges setDelegate:self];
    mainView.userInteractionEnabled = YES;
    [mainView addGestureRecognizer:addrightges];
    
    lefttableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,uiPostCmnt.frame.size.width, uiPostCmnt.frame.size.height-([SavePrefrences sharedInstance].stbarHght+5))];
    lefttableView.delegate = self;
    lefttableView.dataSource = self;
    lefttableView.scrollEnabled = YES;
    lefttableView.backgroundColor=[UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:242.0f/255.0f alpha:1.0f];//[bd valueForKey:@"bodycolor"];
    lefttableView.separatorColor=[UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:242.0f/255.0f alpha:1.0f];//[bd valueForKey:@"bodycolor"];
    [uiPostCmnt addSubview:lefttableView];
    return uiPostCmnt;
}

-(void) dismiss{
    [mainView removeFromSuperview];
}

-(UIView *) openRightDrawer{
    LeftRightDrawer* lrd = [[LeftRightDrawer alloc] init];
    [lrd showRightDrawer];
    return nil;
}

- (void)reteriveFriends{
    iscallback=2;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"genData":@"":@"":dic1 :self];
}

-(void)callBack:(NSArray *)meta :(NSArray *)data{
    switch (iscallback) {
        case 1:
            [self setUpView:data];
            break;
        case 2:
            break;
        case 3:{
            [mainouterView removeFromSuperview];
            UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Your Resume Has been Sent" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            break;
        }
        default:
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) callMethod:(NSArray *)meta{
}
@end
