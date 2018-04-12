//
//  ViewController.m
//  pro22
//
//  Created by iFlame on 12/11/16.
//  Copyright © 2016 iFlame. All rights reserved.
//

#import "TutorialViewController.h"
#import "Tutorialcell.h"
#import "SavePrefrences.h"
@interface TutorialViewController ()
{
    int isCallback;
    NSMutableArray *ArrName;
}
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [self customizeActionBar];
    [super viewDidLoad];
    self.segmentControl.delegate = self;
    self.btn1.hidden = true;
    self.btn2.hidden = true;
    self.btn3.hidden = true;
    self.btn4.hidden = true;
    isCallback=0;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Tutorial":@"GetTutFront" :@"":@"":dic1 :self];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)customizeActionBar
{
    
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [self.view addSubview:headerView];
    ////////////
    
    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 30, 50, 25)];
    [bckarrow setImage:[UIImage imageNamed:@"back1.png"]];
    bckarrow.userInteractionEnabled=YES;
    bckarrow.backgroundColor=[UIColor clearColor];
    [headerView addSubview:bckarrow];
    
    UITapGestureRecognizer *astreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [astreg setNumberOfTouchesRequired:1];
    [astreg setDelegate:self];
    bckarrow.userInteractionEnabled = YES;
    [bckarrow addGestureRecognizer:astreg];
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake((headerView.frame.size.width-112)/2,25,112, 40)];
    
    // UIImageView *logo=[[UIImageView alloc]initWithFrame:CGRectMake(bckarrow.frame.size.width+bckarrow.frame.origin.x+15,5,150,50)];
    [logo setImage:[UIImage imageNamed:@"logo_new.png"]];
    [headerView addSubview:logo];
    
    //130:197:246
    UILabel *gap=[[UILabel alloc] initWithFrame:CGRectMake(0,68, headerView.frame.size.width, 2)];
    gap.backgroundColor=[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    [headerView addSubview:gap];
    
    ////////////
    
    
    //    UIView *ViewTitle=[[UIView alloc] initWithFrame:CGRectMake(0, gap.frame.size.height+gap.frame.origin.y, prMainView.frame.size.width, 45)];
    //    ViewTitle.backgroundColor=[UIColor colorWithRed:225.0f/255.0f green:232.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
    //    [headerView addSubview:ViewTitle];
}
-(void)dissmisspop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ArrName.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [NSString stringWithFormat:@"https://proyolk.com/upload/admin/tutorial/%@",[[ArrName objectAtIndex:indexPath.row] objectForKey:@"t_video"]];
    [self playVideoResunme:str];
    
    
}


-(void)playVideoResunme:(NSString *)videoResume
{
    
    
    
    [videomainview removeFromSuperview];
    
    videomainview = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    videomainview.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];
    [self.view addSubview:videomainview];
    
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
//        save.layer.borderColor=[[UIColor redColor] CGColor];
        save.layer.borderWidth=1;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictData = [ArrName objectAtIndex:indexPath.row];
    Tutorialcell *cell = [tableView dequeueReusableCellWithIdentifier:@"Tutorialcell" forIndexPath:indexPath];
    cell.lblName.text = [dictData objectForKey:@"t_name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(IBAction)btnselectTab:(id)sender{
    NSMutableArray *arrView = self.container.subviews;
    for (UIButton *btn in arrView) {
        [btn setSelected:NO];
    }
    UIButton *btnSelected = (UIButton *)sender;
    [btnSelected setSelected:YES];
    [self getTutorialData:(int)btnSelected.tag];
    
}

-(void)callBack:(NSArray *)meta :(NSArray *)data{
    ArrName = (NSMutableArray *)data;
//    ArrName = [NSMutableArray arrayWithArray:Array1];
    [_tview reloadData];
    //   [self removeFromSuperview];
    if (isCallback==0) {
        NSMutableDictionary *dictData = (NSMutableDictionary *)meta;
       arrData = [[dictData objectForKey:@"data"]objectForKey:@"tut"];
        NSMutableArray *arrButtons = [NSMutableArray array];
        for (int i = 0; i<arrData.count; i++)
        {
            NSMutableDictionary *dictData = [arrData objectAtIndex:i];
            [arrButtons addObject:[dictData objectForKey:@"t_title"]];
            
//
//            if (i==0) {
//                [self.btn1 setTitle:[dictData objectForKey:@"t_title"] forState:UIControlStateSelected];
//                [self.btn1 setTitle:[dictData objectForKey:@"t_title"] forState:UIControlStateNormal];
//                self.btn1.tag = [[dictData objectForKey:@"t_id"]integerValue];
//            }
//            if (i==1) {
//                [self.btn2 setTitle:[dictData objectForKey:@"t_title"] forState:UIControlStateSelected];
//                [self.btn2 setTitle:[dictData objectForKey:@"t_title"] forState:UIControlStateNormal];
//                self.btn2.tag = [[dictData objectForKey:@"t_id"]integerValue];
//            }
//            if (i==2) {
//                [self.btn3 setTitle:[dictData objectForKey:@"t_title"] forState:UIControlStateSelected];
//                [self.btn3 setTitle:[dictData objectForKey:@"t_title"] forState:UIControlStateNormal];
//                self.btn3.tag = [[dictData objectForKey:@"t_id"]integerValue];
//            }
//            if (i==3) {
//                [self.btn4 setTitle:[dictData objectForKey:@"t_title"] forState:UIControlStateSelected];
//                [self.btn4 setTitle:[dictData objectForKey:@"t_title"] forState:UIControlStateNormal];
//                self.btn4.tag = [[dictData objectForKey:@"t_id"]integerValue];
//            }
        }
        self.segmentControl.buttons  = arrButtons;
        [self getTutorialData:[[[arrData objectAtIndex:0] objectForKey:@"t_id"]integerValue]];
        
        
        
    }
    
}

-(void)getTutorialData:(int)ID{
    isCallback=1;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",ID] forKey:@"tut"];
    //[dic1 setObject:@"true" forKey:@"lt"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Tutorial":@"GetTutSearch" :@"":@"":dic1 :self];
}

- (void)didSelectItemAtIndex:(NSInteger)index{
    
    [self getTutorialData:[[[arrData objectAtIndex:index] objectForKey:@"t_id"]integerValue]];

}

-(IBAction)dissmissVideo:(id)sender
{
    [player pause];
    [videomainview removeFromSuperview];
}
@end
