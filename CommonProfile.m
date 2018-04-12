#import "CommonProfile.h"
#import "FriendProfile.h"
#import "SavePrefrences.h"
#import "ManageArray.h"
#import "AllValidationsViewController.h"
#import "LeftRightDrawer.h"
#import "BoardListController.h"
#import "PodcastListController.h"
#import "AddCalendar.h"

@interface CommonProfile ()
{
    
    UIImageView *imggeter,*comment;
    UIViewController *vc1;
    UIView *mainView,*imageview,*actionView,*headerView,*prMainView,*cell_View;
    UIScrollView *mainScrollView1;
    ManageArray *mngAr;
    NSMutableArray *popUpAr;
    LeftRightDrawer *drawer;
    AllValidationsViewController *av;
    int frienduid,cellheight,chkmodule,iscallback;
    
}
@end

@implementation CommonProfile
@synthesize jobtableView,boardtableView,podcasttableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    mngAr=[[ManageArray alloc]init];
   // if(self.flag != 101){
        drawer=[[LeftRightDrawer alloc]init];
//        drawer.flag = self.flag;
//    if (drawer.popArr.count<=0) {
//        drawer.popArr = [ NSMutableArray array];
//    }
//    [drawer.popArr addObject:mainView];
        //    [self MainViewwithouttitle:vc1];
//        [drawer initArs:vc1];
    //}
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIView *) MainViewwithouttitle:(UIViewController *)Vc
{
    av=[[AllValidationsViewController alloc]init];
    
    NSLog(@"pop ar count in mainview2   %lu",[popUpAr count]);
    
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];;
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
        
    }
    
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 56)];
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];;
    headerView.layer.cornerRadius=5;
    [prMainView addSubview:headerView];
    
    return prMainView;
}

-(void )addProfileimage:(NSArray *) profileAr:(int)frnid:(UIViewController *)vc
{
    
    vc1=vc;
    if (self.flag==101) {
        headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 70)];
        headerView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        [prMainView addSubview:headerView];
        ////////////
        
        UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 50, 25)];
        [bckarrow setImage:[UIImage imageNamed:@"back1.png"]];
        bckarrow.userInteractionEnabled=YES;
        bckarrow.backgroundColor=[UIColor clearColor];
        [headerView addSubview:bckarrow];
        
        UITapGestureRecognizer *astreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
        [astreg setNumberOfTouchesRequired:1];
        [astreg setDelegate:self];
        bckarrow.userInteractionEnabled = YES;
        [bckarrow addGestureRecognizer:astreg];
        
        UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake((headerView.frame.size.width-112)/2,5,112, 40)];
        
        // UIImageView *logo=[[UIImageView alloc]initWithFrame:CGRectMake(bckarrow.frame.size.width+bckarrow.frame.origin.x+15,5,150,50)];
        [logo setImage:[UIImage imageNamed:@"logo_new.png"]];
        [headerView addSubview:logo];
        
        //130:197:246
        UILabel *gap=[[UILabel alloc] initWithFrame:CGRectMake(0,53, headerView.frame.size.width, 2)];
        gap.backgroundColor=[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
        [headerView addSubview:gap];
    }
    
    frienduid=[[[profileAr valueForKey:@"u_id"] objectAtIndex:0]integerValue];;
    mainView= [[UIView alloc] initWithFrame:CGRectMake(0,actionView.frame.size.height+70,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight-(actionView.frame.size.height))];
    mainView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[bd valueForKey:@"backcolor"];
    [vc1.view addSubview:mainView];
    
    mainScrollView1=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,[SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    mainScrollView1.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];;
    mainScrollView1.scrollEnabled = YES;
    mainScrollView1.contentSize = CGSizeMake([SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight);
    
    [mainView addSubview:mainScrollView1];
    
    
    imageview=[[UIView alloc] initWithFrame:CGRectMake(10, 60, mainScrollView1.frame.size.width-20, 100)];
    imageview.backgroundColor=[UIColor clearColor];//colorWithRed:70/255.0f green:130/255.0f  blue:180/255.0f alpha:1.0f];
    imageview.layer.cornerRadius=30;
    imageview.clipsToBounds=YES;

    [mainScrollView1 addSubview:imageview];
    
    imggeter=[[UIImageView alloc]initWithFrame:CGRectMake((imageview.frame.size.width-80)/2, 10, 100, 100)];
    imggeter.layer.backgroundColor=[[UIColor clearColor] CGColor];
    imggeter.layer.cornerRadius=50;
    imggeter.layer.masksToBounds = YES;
    imggeter.clipsToBounds=YES;

    [mainScrollView1 addSubview:imggeter];
       mngAr=[[ManageArray alloc]init];
    NSString *img=[[profileAr valueForKey:@"img"] objectAtIndex:0];
    NSString * url=[mngAr concatUrl:img];
    videoResume =[[profileAr valueForKey:@"videoResume"] objectAtIndex:0];
    
    NSLog(@"imag vw ==========%lu",(unsigned long)url.length);
    if(url.length<12)
    {
       /// imggeter.image = [UIImage imageNamed:@"username.png"];
    }
    else
    {
          [imggeter sd_setImageWithURL:[NSURL URLWithString:url]];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//        
//        if (imageData.length<=0)
//        {
//           // imggeter.image = [UIImage imageNamed:@"username.png"];
//            
//        }
//        else
//        {
//            imggeter.image = [UIImage imageWithData:imageData];
//        }
    }
    imggeter.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOption)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    imggeter.userInteractionEnabled = YES;
    [imggeter addGestureRecognizer:tapRecognizer];
    
    
    UILabel *NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,  imggeter.frame.origin.y+imggeter.frame.size.height, mainScrollView1.frame.size.width, 22)];

   // if([mngAr checkStringNull:[[profileAr valueForKey:@"fname"] objectAtIndex:0]])
  //  {
        NameLabel.text=[NSString stringWithFormat:@"%@", [[profileAr valueForKey:@"fname"] objectAtIndex:0]];
        NSLog(@"NameLabel.text....%@",NameLabel.text);
 //   }
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    NameLabel.textAlignment=NSTextAlignmentCenter;
    
    
    
    [mainScrollView1 addSubview:NameLabel];
    
    //here line below name
    int w =self.view.frame.size.width;
    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(w/2-w/4, NameLabel.frame.size.height+NameLabel.frame.origin.y+3, w/8, 1.25)];
    lblLine.backgroundColor=[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    //[mainScrollView1 addSubview:lblLine];

    UILabel *location=[[UILabel alloc]initWithFrame:CGRectMake(0,lblLine.frame.size.height+lblLine.frame.origin.y+3, mainScrollView1.frame.size.width, 22)];
    if([mngAr checkStringNull:[[profileAr valueForKey:@"city"]objectAtIndex:0]])
    {
        location.text=[[[[[[profileAr valueForKey:@"city"]objectAtIndex:0] stringByAppendingString:@","]stringByAppendingString:[[profileAr valueForKey:@"state"]objectAtIndex:0]]stringByAppendingString:@","]stringByAppendingString:[[profileAr valueForKey:@"country"]objectAtIndex:0]];
        NSLog(@"location.text....%@",location.text);

    }
    
    location.font=[UIFont systemFontOfSize:10];
    location.textColor=[UIColor colorWithRed:156.0f/255.0f green:156.0f/255.0f blue:156.0f/255.0f alpha:1.0f];
    location.textAlignment=NSTextAlignmentCenter;
    [mainScrollView1 addSubview:location];
    
    [self addButtons];
    
}
-(void)chooseOption
{
    
    ProfileView *vc=[[ProfileView alloc]init];
    vc.istab=@"0";
    vc.strUserId =frienduid;
    [[vc1 navigationController ]pushViewController:vc animated:YES];
    
}

-(void)dissmisspop{
    [prMainView removeFromSuperview];
}

-(IBAction)dissmissVideo:(id)sender{
    [player pause];
    [videomainview removeFromSuperview];
}

-(void)playVideoResunme{
    [videomainview removeFromSuperview];
    if(player!=nil)
        [player pause];
    
    videomainview = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    videomainview.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];
    [vc1.view addSubview:videomainview];
    
    UIView *innerVideopop = [[UIView alloc] initWithFrame:CGRectMake(20,100,[SavePrefrences sharedInstance].screenWidth-40,[SavePrefrences sharedInstance].screenHeight-350)];
    innerVideopop.backgroundColor=[UIColor blackColor];
    [videomainview addSubview:innerVideopop];
    
    
    
    
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
        NSString *toplay=[url stringByAppendingString:videoResume];
        
        

        NSURL *videoURL = [NSURL URLWithString:toplay];
        player = [AVPlayer playerWithURL:videoURL];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];

        playerLayer.frame = CGRectMake(0, 10, innerVideopop.frame.size.width, innerVideopop.frame.size.height);
        [innerVideopop.layer addSublayer:playerLayer];
        [player play];
        UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(videomainview.frame.size.width/2-50, innerVideopop.frame.size.height+innerVideopop.frame.origin.y+50, 100, 40)];
        [save setTitle: @"Close" forState: UIControlStateNormal];
        save.backgroundColor=[UIColor blackColor];
//        save.layer.borderColor=[[UIColor redColor] CGColor];
//        save.layer.borderWidth=1;
        [save addTarget:self action:@selector(dissmissVideo:) forControlEvents:UIControlEventTouchUpInside];
        [save setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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


//here on click of friend profile
-(void) addButtons
{
    NSMutableArray *btnAr=[[NSMutableArray alloc]init];
    [btnAr addObject:@"Profile"];
    [btnAr addObject:@"Education"];
    [btnAr addObject:@"Employment"];
    [btnAr addObject:@"Certificate"];
    [btnAr addObject:@"Award"];
    [btnAr addObject:@"Video Resume"];
    
    [btnAr addObject:@"Jobs"];
    [btnAr addObject:@"Board"];
    [btnAr addObject:@"Podcast"];
    [btnAr addObject:@"Calendar"];
    [btnAr addObject:@"Download Resume"];

    NSMutableArray *coloAr=[[NSMutableArray alloc]init];
    [coloAr addObject:[UIColor colorWithRed:112.0f/255.0f green:185.0f/255.0f blue:164.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:143.0f/255.0f green:151.0f/255.0f blue:93.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:189.0f/255.0f green:162.0f/255.0f blue:226.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:131.0f/255.0f green:168.0f/255.0f blue:210.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:233.0f/255.0f green:181.0f/255.0f blue:175.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f]];

    [coloAr addObject:[UIColor colorWithRed:112.0f/255.0f green:185.0f/255.0f blue:164.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:143.0f/255.0f green:151.0f/255.0f blue:93.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:189.0f/255.0f green:162.0f/255.0f blue:226.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:131.0f/255.0f green:168.0f/255.0f blue:210.0f/255.0f alpha:1.0f]];
    [coloAr addObject:[UIColor colorWithRed:233.0f/255.0f green:181.0f/255.0f blue:175.0f/255.0f alpha:1.0f]];

    
    int lineviewY=imageview.frame.size.height+imageview.frame.origin.y+5;
    UIView *lineView1;
    for(int x=0;x<[btnAr count];x++)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,lineviewY, [SavePrefrences sharedInstance].screenWidth, 35)];
        lineView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        lineView.tag=x;
        [mainScrollView1 addSubview:lineView];

        UILabel *btnArrowRoght =[[UILabel alloc]initWithFrame:CGRectMake(0,2,[SavePrefrences sharedInstance].screenWidth,lineView.frame.size.height-5)];
        btnArrowRoght.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        btnArrowRoght.font = [UIFont boldSystemFontOfSize: 15];
        btnArrowRoght.userInteractionEnabled=YES;
        btnArrowRoght.text=[btnAr objectAtIndex:x];
        btnArrowRoght.textColor=[coloAr objectAtIndex:x];//[UIColor redColor];
        btnArrowRoght.backgroundColor=[UIColor clearColor];
        btnArrowRoght.textAlignment=NSTextAlignmentCenter;
        [lineView addSubview:btnArrowRoght];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openFriend:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [lineView addGestureRecognizer:tapRecognizer];
        
        UIImageView *rightimgview = [[UIImageView alloc]initWithFrame:CGRectMake(btnArrowRoght.frame.size.width+5,20, 20, 20)];
        [rightimgview setImage:[UIImage imageNamed:@"arrow.png"]];
        rightimgview.userInteractionEnabled= YES;
        lineviewY= lineviewY+50;
        
        //here line
        int w =self.view.frame.size.width;
        UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(w/2-w/3, btnArrowRoght.frame.size.height+btnArrowRoght.frame.origin.y+3, w/3.4, 1.25)];
        lblLine.backgroundColor=[coloAr objectAtIndex:x];
        [lineView addSubview:lblLine];

    }
    


  /*  int hsp=15;
    int div3=[SavePrefrences sharedInstance].screenWidth/5;
    
    NSMutableArray *listar=[[NSMutableArray alloc]init];
    [listar addObject:@"jobsicn.png"];
    [listar addObject:@"boardicn.png"];
    [listar addObject:@"podcasticn.png"];
    [listar addObject:@"calendaricn.png"];
    [listar addObject:@"resume_download.png"];
    
    for(int x=0;x<[listar count];x++)
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(hsp,lineviewY, [SavePrefrences sharedInstance].screenWidth/5-20, 50)];
        NSMutableDictionary *vd=[SavePrefrences sharedInstance].colorDictionry;
        lineView.backgroundColor=[vd valueForKey:@"Profcolor"];
        lineView.layer.borderWidth=1.0f;
        lineView.layer.cornerRadius=8.0f;
        lineView.layer.borderColor = [[vd valueForKey:@"Profcolor"]CGColor];
        
        UIImageView *rightimgview =[[UIImageView alloc]initWithFrame:CGRectMake((lineView.frame.size.width/2)-(lineView.frame.size.width/4),lineView.frame.size.height/4,lineView.frame.size.width/2, lineView.frame.size.height/2)];
        rightimgview.tag=x;
        [rightimgview setImage:[UIImage imageNamed:[listar objectAtIndex:x]]];
        rightimgview.userInteractionEnabled= YES;
        [mainScrollView1 addSubview:lineView];
        [lineView addSubview:rightimgview];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openOptions:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [rightimgview addGestureRecognizer:tapRecognizer];
        
        hsp=hsp+div3;
    }*/
    
    lineviewY= lineviewY+70;
    mainScrollView1.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, lineView1.frame.size.height+lineviewY+70);
    
    
}

-(void)openViews:(UIViewController*)Vc
{
    [self MainViewwithouttitle:vc1];
        
    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 25, 25)];
    [bckarrow setImage:[UIImage imageNamed:@"back.png"]];
    bckarrow.userInteractionEnabled=YES;
    [headerView addSubview:bckarrow];
    
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoBack)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    bckarrow.userInteractionEnabled = YES;
    [bckarrow addGestureRecognizer:communityeg];
    
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(bckarrow.frame.size.width+bckarrow.frame.origin.x+15,5,150, 50)];
    [logo setImage:[UIImage imageNamed:@"logo.png"]];
    //[headerView addSubview:logo];

    
    comment=[[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.size.width-35, 10, 25, 25)];
    [comment setImage:[UIImage imageNamed:@"comment.png"]];
    [headerView addSubview:comment];
    
//    UITapGestureRecognizer *cmntreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Comment)];
//    [cmntreg setNumberOfTouchesRequired:1];
//    [cmntreg setDelegate:self];
//    comment.userInteractionEnabled = YES;
//    [comment addGestureRecognizer:cmntreg];

    
    if(chkmodule==0)
    {
        //job table

        jobtableView = [[UITableView alloc] initWithFrame:CGRectMake(0,headerView.frame.size.height+headerView.frame.origin.y+10,[SavePrefrences sharedInstance].screenWidth,([SavePrefrences sharedInstance].screenHeight)-(headerView.frame.size.height+headerView.frame.origin.y+90))];
        jobtableView.delegate = self;
        jobtableView.dataSource = self;
        jobtableView.scrollEnabled = YES;
        jobtableView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
        jobtableView.separatorColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
        
        [self.view addSubview:jobtableView];
        [jobtableView reloadData];
        
    }
    if(chkmodule==1)
    {
        
        //board
        boardtableView = [[UITableView alloc] initWithFrame:CGRectMake(0,headerView.frame.size.height+headerView.frame.origin.y+10,headerView.frame.size.width,headerView.frame.size.height-(headerView.frame.size.height+headerView.frame.size.height+90))];
        boardtableView.delegate = self;
        boardtableView.dataSource = self;
        boardtableView.scrollEnabled = YES;
        boardtableView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
        boardtableView.separatorColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
        [self.view addSubview:boardtableView];
         [boardtableView reloadData];
        
        
    }
    if(chkmodule==2)
    {
        //podcast
        podcasttableView = [[UITableView alloc] initWithFrame:CGRectMake(0,5,headerView.frame.size.width,headerView.frame.size.height-(headerView.frame.size.height+headerView.frame.origin.y+30))];
        podcasttableView.delegate = self;
        podcasttableView.dataSource = self;
        podcasttableView.scrollEnabled = YES;
        podcasttableView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
        podcasttableView.separatorColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];
        [self.view addSubview:podcasttableView];
        [podcasttableView reloadData];

    }
}

-(void)GoBack{
    [prMainView removeFromSuperview];
  //  [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)openFriend:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    
    int isbtn=(int)tg.view.tag;
    if(isbtn==0)
    {
        
        NSLog(@"Profile is clicked");
        
        FriendProfile *vc2=[[FriendProfile alloc]init];
        vc2.isFrndtab=@"0";
        vc2.frnduid=[NSString stringWithFormat:@"%d",frienduid];
        [[vc1 navigationController ]pushViewController:vc2 animated:YES];
        
    }
    if(isbtn==1)
    {
        
        NSLog(@"Profile is clicked");
        
        FriendProfile *vc2=[[FriendProfile alloc]init];
        vc2.isFrndtab=@"1";
        vc2.frnduid=[NSString stringWithFormat:@"%d",frienduid];
        [[vc1 navigationController]pushViewController:vc2 animated:YES];
        
    }if(isbtn==2)
    {
        
        FriendProfile *vc2=[[FriendProfile alloc]init];
        vc2.isFrndtab=@"2";
        vc2.frnduid=[NSString stringWithFormat:@"%d",frienduid];
        [[vc1 navigationController]pushViewController:vc2 animated:YES];
        
    }
    if(isbtn==3)
    {
        FriendProfile *vc2=[[FriendProfile alloc]init];
        vc2.isFrndtab=@"3";
        vc2.frnduid=[NSString stringWithFormat:@"%d",frienduid];
        [[vc1 navigationController]pushViewController:vc2 animated:YES];
        
    }
    if(isbtn==4)
    {
        
        NSLog(@"Profile is clicked");
        
        FriendProfile *vc2=[[FriendProfile alloc]init];
        vc2.isFrndtab=@"4";
        vc2.frnduid=[NSString stringWithFormat:@"%d",frienduid];
        [[vc1 navigationController]pushViewController:vc2 animated:YES];
        
    }
    
    else if(isbtn==5)
    {
      [self playVideoResunme];
    }
  

    //UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    
   // chkmodule=(int)tg.view.tag;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%d",frienduid] forKey:@"id"];
    if(isbtn==6)
    {
        // job
        AppDelegate *appDel = [[UIApplication sharedApplication]delegate];
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        JobListVIewController *jobVC = [storyBoard instantiateViewControllerWithIdentifier:@"JobListVIewController"];
        jobVC.frienduid = frienduid;
        UINavigationController *navVC = (UINavigationController *)appDel.window.rootViewController;
        [navVC pushViewController:jobVC animated:YES];
        
    }
    if(isbtn==7)
    {
        //board
        iscallback=1;
        [[SavePrefrences sharedInstance].skthand  emitData:@"MyBoard" :@"getBoard" :@"" :@"" :dic :self];
    }
    if(isbtn==8)
    {
        //podcast
        iscallback=2;
        [[SavePrefrences sharedInstance].skthand  emitData:@"MyPodcast" :@"getPodcast" :@"" :@"" :dic :self];
    }
    if(isbtn==9)
    {
        // calender
        iscallback=3;
        [[SavePrefrences sharedInstance].skthand  emitData:@"" :@"" :@"" :@"" :dic :self];
    }
    if(isbtn==10)
    {
        NSLog(@"path is========================== %@",@"path is %@");

        NSString *upload= [[[SavePrefrences sharedInstance].skthand btkurl] stringByAppendingString:[NSString stringWithFormat:@"%@/",@"upload"]];
        NSString *rsume=[upload stringByAppendingString:[NSString stringWithFormat:@"%d/",frienduid]];
        NSString *path=[rsume stringByAppendingString:[NSString stringWithFormat:@"%@/",@"Resume"]];
        NSString *pathis=[path stringByAppendingString:@"resume.pdf"];
        
        NSLog(@"path is %@",pathis);
        
        //https://proyolk.com/upload/10/Resume/resume.pdf
        [self downloadResume:pathis];
        // download resume
        
//        iscallback=4;
//        [[SavePrefrences sharedInstance].skthand  emitData:@"" :@"" :@"" :@"" :dic :self];
    }

}

-(void)downloadResume:(NSString*)Path1
{
    
    webviewView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    
    [vc1.view addSubview:webviewView];
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

-(void)openOptions:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
   
    chkmodule=(int)tg.view.tag;
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%d",frienduid] forKey:@"uid"];
    if(chkmodule==0)
    {
        // job
        iscallback=0;
        [[SavePrefrences sharedInstance].skthand  emitData:@"PostedProject" :@"getJobsPosted" :@"" :@"" :dic :self];
    
    }
    if(chkmodule==1)
    {
    //board
        iscallback=1;
           [[SavePrefrences sharedInstance].skthand  emitData:@"MyBoard" :@"getBoard" :@"" :@"" :dic :self];
    }
   if(chkmodule==2)
    {
     //podcast
        iscallback=2;
           [[SavePrefrences sharedInstance].skthand  emitData:@"MyPodcast" :@"getPodcast" :@"" :@"" :dic :self];
    }
    if(chkmodule==3)
    {
     // calender
        iscallback=3;
           [[SavePrefrences sharedInstance].skthand  emitData:@"" :@"" :@"" :@"" :dic :self];
    }
    if(chkmodule==4)
    {
        // download resume
        iscallback=4;
           [[SavePrefrences sharedInstance].skthand  emitData:@"" :@"" :@"" :@"" :dic :self];
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    if(tableView==jobtableView)
    {
        cellheight=150;
        return arrJobs.count;
    }
   else if(tableView==boardtableView)
    {
        cellheight=85;
        return arrJobs.count;
    }
  else  if(tableView==boardtableView)
    {
        cellheight=180;
        return arrJobs.count;
    }
    else{
    
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.jobtableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[stack valueForKey:@"backcolor"];
    
    
    if(tableView==jobtableView)
    {
 
        NSMutableDictionary *dictData = [arrJobs objectAtIndex:indexPath.row];
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 0, jobtableView.frame.size.width-10, cellheight)];
        cell_View.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];;
        cell_View.layer.borderWidth=1;
        cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
        cell_View.layer.cornerRadius=6;
        [cell addSubview: cell_View];
        
        UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openApplidJobdetail :)];
        [prev setNumberOfTouchesRequired:1];
        [prev setDelegate:self];
        cell_View.tag=indexPath.row;
        cell_View.userInteractionEnabled = YES;
        [cell_View addGestureRecognizer:prev];
        
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        img.image=[UIImage imageNamed:@"pictureicn.png"];
        [cell_View addSubview:img];
        
        
    //    NSString * url=[mngAr concatUrl:imge1];
//        if(url.length<12)
//        {
//            img.image = [UIImage imageNamed:@"username.png"];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//            
//            if (imageData.length<=0)
//                img.image = [UIImage imageNamed:@"username.png"];
//            else
//                img.image = [UIImage imageWithData:imageData];
//        }
//        
        
//        UIImageView *imgdel=[[UIImageView alloc]initWithFrame:CGRectMake(podcast_details.frame.size.width-20, 5, 20, 20)];
//        imgdel.image=[UIImage imageNamed:@"delete.png"];
//        [cell_View addSubview:imgdel];
        
        
        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+3, 0, cell_View.frame.size.width, 25) ];
//        if([av checkNullStr:title])
//        {
//            title_lbl.text=[NSString stringWithFormat:@"%@",title];
//        }
        title_lbl.text=@"title";
        title_lbl.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
        title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
        title_lbl.font=[UIFont boldSystemFontOfSize:16.0f];
        [cell_View addSubview:title_lbl];
        
        UILabel *subName=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+3, title_lbl.frame.size.height+title_lbl.frame.origin.y,cell_View.frame.size.width-60 , 25) ];
//        if([av checkNullStr:status])
//        {
//            subName.text=[NSString stringWithFormat:@"Status:    %@",status];
//        }
        subName.text=@"subname";
        subName.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
        subName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [cell_View addSubview:subName];
        
        
        
        
        
        UILabel *Start_time=[[UILabel alloc]initWithFrame:CGRectMake(0, img.frame.size.height+img.frame.origin.y, 100, 20)];
        Start_time.text=@" Time:";
        Start_time.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
        Start_time.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        [cell_View addSubview:Start_time];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Start_time.frame.size.width+Start_time.frame.origin.x, img.frame.size.height+img.frame.origin.y, cell.frame.size.width-50, 20)];
//        if([av checkNullStr:timelog])
//        {
//            time.text=[NSString stringWithFormat:@"%@",timelog];
//        }
        time.textAlignment=NSTextAlignmentLeft;
        time.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        time.textColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
        [cell_View addSubview:time];
        
        
        
        UILabel *Duration=[[UILabel alloc]initWithFrame:CGRectMake(0, Start_time.frame.size.height+Start_time.frame.origin.y, 100, 20)];
        Duration.text=@" Duration:";
        Duration.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
        Duration.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        [cell_View addSubview:Duration];
        
        UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration.frame.size.width+Duration.frame.origin.x, time.frame.size.height+time.frame.origin.y, cell.frame.size.width-110, 20)];
//        if([av checkNullStr:durationa])
//        {
//            duration_time.text=[NSString stringWithFormat:@"%@",durationa];
//        }
        duration_time.textAlignment=NSTextAlignmentLeft;
        duration_time.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
        duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        [cell_View addSubview:duration_time];
        
        
        UILabel *desc=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+3, duration_time.frame.size.height+duration_time.frame.origin.y,cell_View.frame.size.width-60 , 25) ];
//        if([av checkNullStr:job_desc])
//        {
//            desc.text=[NSString stringWithFormat:@"%@",job_desc];
//        }
        desc.textColor=[UIColor grayColor];
        desc.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [cell_View addSubview:desc];
        
        
        
        
        
        UILabel *postedby=[[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width-200, desc.frame.size.height+desc.frame.origin.y+5, 180, 20)];
//        if([av checkNullStr:uname])
//        {
//            postedby.text=[NSString stringWithFormat:@"Posted By :-%@",uname];
//        }
        postedby.textAlignment=NSTextAlignmentLeft;
        postedby.textColor=[UIColor blackColor];
        postedby.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        [cell_View addSubview:postedby];
        
        return cell;
    }
    if(tableView==boardtableView)
    {
        
        
        
       // int x=((int)[myBordAr count]-1)-(int)indexPath.row;
        
//        NSString *title= [[myBordAr objectAtIndex:x]valueForKey:@"title"];
//        NSString *cmnt_content=[[myBordAr objectAtIndex:x]valueForKey:@"cmnt_content"];
//        NSString *cmnt_time=[[myBordAr objectAtIndex:x]valueForKey:@"cmnt_time"];
//        NSString *b_id=[[myBordAr objectAtIndex:x]valueForKey:@"b_id"];
//        NSString *timelog=[[myBordAr objectAtIndex:x]valueForKey:@"timelog"];
//        NSString *uname=[[myBordAr objectAtIndex:x]valueForKey:@"uname"];
//        NSString *img1=[[myBordAr objectAtIndex:x]valueForKey:@"img"];
//        NSString *frid=[[myBordAr objectAtIndex:x]valueForKey:@"u_id"];
//        
//        
        
        
        UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openComments:)];
        [sworkingreg2 setNumberOfTouchesRequired:1];
        [sworkingreg2 setDelegate:self];
        cell.userInteractionEnabled = YES;
      //  cell.tag=[b_id intValue];
        
        [cell addGestureRecognizer:sworkingreg2];
        
        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5,5,cell_View.frame.size.width/2, 20)];
        title_lbl.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];;
        title_lbl.textColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
//        if([av checkNullStr:title])
//        {
//            title_lbl.text=title;
//        }
        title_lbl.text=@"title";
        [cell_View addSubview:title_lbl];
        
        UILabel *date_log=[[UILabel
                            alloc]initWithFrame:CGRectMake(title_lbl.frame.size.width+title_lbl.frame.origin.x+5,
                                                           5,(cell_View.frame.size.width/2)-15, 20)];
        //        date_log.backgroundColor=[UIColor yellowColor];
        date_log.textColor=[UIColor colorWithRed:229.0f/255 green:229.0f/255
                                            blue:229.0f/255 alpha:1.0f];
        date_log.textAlignment=NSTextAlignmentRight;
        [date_log setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
//        if([av checkNullStr:timelog])
//        {
//            date_log.text=timelog;
//        }
        
        [cell_View addSubview:date_log];
        
        UILabel *gap=[[UILabel alloc]initWithFrame:CGRectMake(5,
                                                              title_lbl.frame.size.height+title_lbl.frame.origin.y+5,
                                                              cell_View.frame.size.width-10, 1)];
        gap.backgroundColor=[UIColor grayColor];
        gap.textColor=[UIColor yellowColor];
        [cell_View addSubview:gap];
        
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(5,    gap.frame.size.height+gap.frame.origin.y+2, 40, 38)];
        [image setImage:[UIImage imageNamed:@"username.png"]];
        [ cell_View addSubview: image];
        
        
//        NSString * url=[mngAr concatUrl:img1];
//        if(url.length<12)
//        {
//            image.image = [UIImage imageNamed:@"username.png"];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//            
//            if (imageData.length<=0)
//                image.image = [UIImage imageNamed:@"username.png"];
//            else
//                image.image = [UIImage imageWithData:imageData];
//        }

        
        UILabel *uname_lbl=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x,gap.frame.size.height+gap.frame.origin.y+5, (cell_View.frame.size.width-image.frame.size.width)/2-10, 15)];
      ///  uname_lbl.text=uname;
        uname_lbl.textColor=[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0];
        [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
        [cell_View addSubview:uname_lbl];
        
        UILabel *comment=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x,uname_lbl.frame.size.height+uname_lbl.frame.origin.y+2, (cell_View.frame.size.width-image.frame.size.width)/2-10, 20)];
//        if([av checkNullStr:cmnt_content])
//        {
//            NSString * htmlString = cmnt_content;
//            NSAttributedString * attrStr = [[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil
//                                                                             error:nil];
//            
//            comment.attributedText=attrStr;
//        }
        [comment setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
        comment.backgroundColor=[UIColor whiteColor];
        comment.textColor=[UIColor grayColor];
        [cell_View addSubview:comment];
        
        UILabel *date2=[[UILabel
                         alloc]initWithFrame:CGRectMake(comment.frame.size.width+comment.frame.origin.x,gap.frame.size.height+gap.frame.origin.y+5,cell_View.frame.size.width-(image.frame.size.width+comment.frame.size.width)-10,
                                                        20)];
        date2.textAlignment=NSTextAlignmentRight;
        //        date2.backgroundColor=[UIColor whiteColor];
//        if([av checkNullStr:cmnt_time])
//        {
//            date2.text=cmnt_time;
//        }
        date2.textColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255
                                         blue:48.0f/255 alpha:1.0f];
        [date2 setFont:[UIFont fontWithName:@"HelveticaNeue"
                                       size:15]];
        [cell_View addSubview:date2];
        
        return cell;
    }
    if(tableView==podcasttableView)
    {
        
               NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
        cell.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];//[ff valueForKey:@"backcolor"];

        

        UIView *headerlbl=[[UIView alloc]initWithFrame:CGRectMake(0, 0, cell_View.frame.size.width, 30)];
        headerlbl.backgroundColor=[ff valueForKey:@"Videocolor"];
        headerlbl.clipsToBounds=YES;
        [cell_View addSubview: headerlbl];
        
        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5,5 , cell_View.frame.size.width, 25) ];
//        if([av checkNullStr:title])
//        {
//            title_lbl.text=[NSString stringWithFormat:@"%@",title];
//        }
        title_lbl.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
        title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
        title_lbl.font=[UIFont boldSystemFontOfSize:16.0f];
        [headerlbl addSubview:title_lbl];
        
        UIImageView *imgdel=[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-25, 5, 20, 20)];
        imgdel.image=[UIImage imageNamed:@"delete.png"];
       // imgdel.tag=[podid intValue];
        [headerlbl addSubview:imgdel];
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, headerlbl.frame.size.height+headerlbl.frame.origin.y+5, 40, 40)];
        img.image=[UIImage imageNamed:@"pictureicn.png"];
        [cell_View addSubview:img];
        

        
        
        
        
        UITapGestureRecognizer *opt=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteit:)];
        opt.numberOfTapsRequired=1;
        [imgdel setUserInteractionEnabled:YES];
        [imgdel addGestureRecognizer:opt];
        
        
        UILabel *subName=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+3, headerlbl.frame.size.height+headerlbl.frame.origin.y+2,cell_View.frame.size.width/2, 25) ];
//        if([av checkNullStr:description])
//        {
//            subName.text=[NSString stringWithFormat:@"%@",description];
//        }
        subName.textColor=[ff valueForKey:@"Videocolor"];
        subName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [cell_View addSubview:subName];
        
        
        UILabel *Start_time=[[UILabel alloc]initWithFrame:CGRectMake(0, img.frame.size.height+img.frame.origin.y, 100, 20)];
        Start_time.text=@" Start Time:";
        Start_time.textColor=[ff valueForKey:@"Yellowbtncolor"];
        Start_time.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        [cell_View addSubview:Start_time];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Start_time.frame.size.width+Start_time.frame.origin.x, img.frame.size.height+img.frame.origin.y, 100, 20)];
//        if([av checkNullStr:start_time])
//        {
//            time.text=[NSString stringWithFormat:@"%@",start_time];
//        }
        time.textAlignment=NSTextAlignmentLeft;
        time.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        time.textColor=[ff valueForKey:@"Yellowbtncolor"];
        
        [cell_View addSubview:time];
        

        UILabel *Duration=[[UILabel alloc]initWithFrame:CGRectMake(0, Start_time.frame.size.height+Start_time.frame.origin.y, 100, 20)];
        Duration.text=@" Duration:";
        Duration.textColor=[ff valueForKey:@"Yellowbtncolor"];
        Duration.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        [cell_View addSubview:Duration];
        
        UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration.frame.size.width+Duration.frame.origin.x, time.frame.size.height+time.frame.origin.y, 100, 20)];
//        if([av checkNullStr:duration])
//        {
//            duration_time.text=[NSString stringWithFormat:@"%@",duration];
//        }
        duration_time.textAlignment=NSTextAlignmentLeft;
        duration_time.textColor=[ff valueForKey:@"Yellowbtncolor"];
        duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        
        [cell_View addSubview:duration_time];
        
        UILabel *posted_on=[[UILabel alloc]initWithFrame:CGRectMake(0, Duration.frame.size.height+Duration.frame.origin.y, 100, 20)];
        posted_on.text=@" Posted On:";
        posted_on.textColor=[ff valueForKey:@"Yellowbtncolor"];
        posted_on.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        [cell_View addSubview:posted_on];
        
        UILabel *posted_on_details=[[UILabel alloc]initWithFrame:CGRectMake(posted_on.frame.size.width+posted_on.frame.origin.x, duration_time.frame.size.height+duration_time.frame.origin.y, 100, 20)];
        posted_on_details.text=@" No detail";
        posted_on_details.textAlignment=NSTextAlignmentLeft;
        posted_on_details.textColor=[ff valueForKey:@"Yellowbtncolor"];
        posted_on_details.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        
        [cell_View addSubview:posted_on_details];
        
        int hghx=cell_View.frame.size.width/4;
        
        UILabel *bar=[[UILabel alloc]initWithFrame:CGRectMake(5, posted_on_details.frame.size.height+posted_on_details.frame.origin.y+10, cell_View.frame.size.width-10, 1)];
        bar.backgroundColor=[UIColor grayColor];
        [cell_View addSubview:bar];
        
        UILabel *Recorded=[[UILabel alloc] initWithFrame:CGRectMake(5, bar.frame.size.height+bar.frame.origin.y+5,hghx-30, 20)];
       // Recorded.text=[NSString stringWithFormat:@"%@",mode];
        Recorded.textAlignment=NSTextAlignmentLeft;
        Recorded.textColor=[ff valueForKey:@"Videocolor"];
        Recorded.font=[UIFont fontWithName:@"HelveticaNeue" size:13.5];
        
        [cell_View addSubview:Recorded];
        
       
        
        
        
        return cell;
    }

    
    return cell;
}
    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
    {
        return cellheight;
    }
//    - (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//        
//    }
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
    }

-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    NSLog(@"meta======== %@",meta);
    NSLog(@"data========= %@",data);
   if(iscallback==0)
   {
       arrJobs = (NSMutableArray *)data;
       [self openViews:vc1];
   }
    else if (iscallback==1)
    {
        arrJobs = (NSMutableArray *)data;
//        [self openViews:vc1];
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BoardListController *boardVC = [storyBoard instantiateViewControllerWithIdentifier:@"BOARD_LISTING"];
        boardVC.boardArr = arrJobs;
        UINavigationController *navVC = (UINavigationController *)appDel.window.rootViewController;
        [navVC pushViewController:boardVC animated:YES];
    }
    else if (iscallback==2){
        arrJobs = (NSMutableArray *)data;
//        [self openViews:vc1];
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PodcastListController *podcastVC = [storyBoard instantiateViewControllerWithIdentifier:@"PODCAST_LISTING"];
        podcastVC.podcastsArr = arrJobs;
        UINavigationController *navVC = (UINavigationController *)appDel.window.rootViewController;
        [navVC pushViewController:podcastVC animated:YES];
    }else if (iscallback==6){
        AddCalendar *vc2 = [[AddCalendar alloc] initWithNibName:@"AddCalendar"
                                                         bundle:nil];
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDel.navigationController setViewControllers:@[vc2] animated:NO];
    }
    
}


@end

