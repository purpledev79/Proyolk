//
//  PodcastPopUp.m
//  Proyolk
//
//  Created by Purple Intellect on 22/03/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "PodcastPopUp.h"
#import "AllValidationsViewController.h"
#import "SavePrefrences.h"
#import "BoardPopUp.h"
#import "popups.h"
#import "ManageArray.h"



@interface PodcastPopUp ()
{
    
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UILabel *NameLabel,*uname_lbl,*proyolk,*graybarPrylk,*yellowPrylk,*yellowcbnt,*yellownet,*NameLabel1,*duration_lbl;
    UIButton *invite,*Search;
    UILabel *Select_Industry,*Select_Sub_Industry;
    int iscallback,istime,isdate;
    UITextField *search,*search_lbl;
    UIImageView *userpic;
    UIAlertView *alrt;
    NSString *indid,*subid,*podid,*libid;
    UIView *prMainView,*headerView,*viewfortable,*durview;
    NSMutableArray *popUpAr;
    UIViewController *vc1;
    AllValidationsViewController *av;
    UIButton *apply;
    UILabel *mnth,*day,*hours;
    UIScrollView *scrollbar;
    PodcastPopUp *pdpop;
    UIView *main,*datePickerView,*podcast_details,*option,*middle_label;
    UILabel *Podcast_bar1,*Podcast_bar2,*Shared_bar1,*Shared_bar2,*Libraries_bar1,*Libraries_bar2;
    UITextField *keyword,*postedBy,*StartTime,*PostedOn;
    NSArray *dataind,*subindAr,*podAr,*podcstAr,*shareAr,*libAr,*cbntAr,*netwrkAr,*proylkAr,*inviteAr;
    NSMutableArray * backData;
    BoardPopUp *bpop;
    UITextView *Message;
    NSString *dur,*st,*job_desc;
    popups *obj;
    NSString *podcastid,*isuid;
    UIDatePicker *timepicker,*datepicker;
    UITextField *searchlib;
    int podIdforinvite;
    NSString *chksel;
    int tablecellHeight,whicto,podId,libId,selday,selmnth,selhr;
    ManageArray *mang;

    
  

    
}
@end

@implementation PodcastPopUp
@synthesize PodcastTableView,sharedPodTable,libTableView,ProyolkFrndTableView,ProyolkTableView,networkTableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    pdpop=[[PodcastPopUp alloc]init];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(UIView *) MainViewfortable:(UIViewController *)Vc:(NSString *) title
{
    av=[[AllValidationsViewController alloc]init];
    
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    NameLabel1=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-70, 50+20)];
    NameLabel1.text=title;
    NameLabel1.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];;
    NameLabel1.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    NameLabel1.textColor=[UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    NameLabel1.textAlignment=NSTextAlignmentCenter;
    NameLabel1.layer.cornerRadius=10;
    NameLabel1.clipsToBounds=YES;
    [prMainView addSubview:NameLabel1];
    
    
    UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel1.frame.size.width+NameLabel1.frame.origin.x-20, [SavePrefrences sharedInstance ].naviHght+15, 30+20, 50+20)];
    closeView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    closeView.layer.cornerRadius=10;
    closeView.clipsToBounds=YES;
    [prMainView addSubview:closeView];
    
    UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(closeView.frame.size.width-28, 3, 25, 25)];
    [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
    cross.userInteractionEnabled=YES;
    [closeView addSubview:cross];
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    cross.userInteractionEnabled = YES;
    [cross addGestureRecognizer:communityeg];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    viewfortable=[[UIView alloc]initWithFrame:CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+100))];
    viewfortable.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    viewfortable.layer.cornerRadius=10;
    viewfortable.clipsToBounds=YES;
    [prMainView addSubview:viewfortable];
    
    
    return prMainView;
}
//220:229:235
-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{

    av=[[AllValidationsViewController alloc]init];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    //220:129:135
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-40, 50+20)];
    NameLabel.text=title;
    NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    NameLabel.textAlignment=NSTextAlignmentCenter;
    NameLabel.layer.cornerRadius=10;
    NameLabel.clipsToBounds=YES;
    [prMainView addSubview:NameLabel];
    
    
   /* UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel.frame.size.width+NameLabel.frame.origin.x, [SavePrefrences sharedInstance ].naviHght+15, 30, 50)];
    closeView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [prMainView addSubview:closeView];
    
    UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 25, 25)];
    [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
    cross.userInteractionEnabled=YES;
   // [closeView addSubview:cross];
    
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    closeView.userInteractionEnabled = YES;
    [closeView addGestureRecognizer:communityeg];*/
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    scrollbar.layer.cornerRadius=10;
    scrollbar.clipsToBounds=YES;
    [prMainView addSubview:scrollbar];
    
    
    return prMainView;
}

-(UIView *) MainViewwithouttitle:(UIViewController *)Vc
{
    av=[[AllValidationsViewController alloc]init];
    NSLog(@"pop ar count in mainview2   %lu",[popUpAr count]);
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 56)];
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    [prMainView addSubview:headerView];
    
    return prMainView;
}


/*Podcast Text and Indicator Color :- 52:127:103
Shared Text Color :- 108:114:41
Libraries Text Color :- 189:164:226
 
 // tab1  [UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f]
 // tab2  [UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f]
 // tab3  [UIColor colorWithRed:189.0f/255 green:164.0f/255 blue:226.0f/255 alpha:1.0f]

 */

-(void) setTabBar:(UIViewController*)Vc
{
    [self MainViewwithouttitle:Vc];
    if(mang==nil)
        mang=[[ManageArray alloc]init];
    
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
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
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.size.width/2-75,5,headerView.frame.size.width/2-20, 50)];
    [logo setImage:[UIImage imageNamed:@"logo_new.png"]];
    [headerView addSubview:logo];
    
    NSMutableDictionary *pdp=[SavePrefrences sharedInstance].colorDictionry;
    
    float wid=(headerView.frame.size.width)/3;
    
    UIView *option=[[UIView alloc]initWithFrame:CGRectMake(0,headerView.frame.size.height+headerView.frame.origin.y, prMainView.frame.size.width, 40)];
    option.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    [prMainView addSubview: option];
    
    UILabel *podcast=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, wid, 35)];
    podcast.text=@"Podcast";
    podcast.textAlignment=NSTextAlignmentCenter;
    [podcast setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    podcast.backgroundColor=[pdp valueForKey:@"clearColor"];
    podcast.textColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    [option addSubview:podcast];
    
    Podcast_bar1=[[UILabel alloc]initWithFrame:CGRectMake(0, podcast.frame.size.height+podcast.frame.origin.y, wid, 3)];
    Podcast_bar1.backgroundColor=[pdp valueForKey:@"clearColor"];
    [option addSubview:Podcast_bar1];
    
    Podcast_bar2 =[[UILabel alloc]initWithFrame:CGRectMake(0, podcast.frame.size.height+podcast.frame.origin.y, wid, 3)];
    Podcast_bar2.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    Podcast_bar2.hidden=false;
    [option addSubview:Podcast_bar2];
    
    UITapGestureRecognizer *podcastreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retrievePodcast)];
    [podcastreg setNumberOfTouchesRequired:1];
    [podcastreg setDelegate:self];
    podcast.userInteractionEnabled = YES;
    [podcast addGestureRecognizer:podcastreg];
    
    UILabel *Shared=[[UILabel alloc]initWithFrame:CGRectMake(podcast.frame.size.width+podcast.frame.origin.x, 0, wid+0.5, 35)];
    Shared.text=@"Shared";
    Shared.textAlignment=NSTextAlignmentCenter;
    [Shared setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Shared.backgroundColor=[pdp valueForKey:@"clearColor"];
    Shared.textColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    [option addSubview:Shared];
    //
    Shared_bar1=[[UILabel alloc]initWithFrame:CGRectMake(podcast.frame.size.width+podcast.frame.origin.x, Shared.frame.size.height+Shared.frame.origin.y, wid+0.4, 3)];
    Shared_bar1.backgroundColor=[pdp valueForKey:@"clearColor"];
    [option addSubview:Shared_bar1];
    
    
    Shared_bar2 =[[UILabel alloc]initWithFrame:CGRectMake(podcast.frame.size.width+podcast.frame.origin.x, podcast.frame.size.height+podcast.frame.origin.y, wid+0.4, 3)];
    Shared_bar2.backgroundColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
    Shared_bar2.hidden=true;
    [option addSubview:Shared_bar2];
    
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retrieveSharedPostCast)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    Shared.userInteractionEnabled = YES;
    [Shared addGestureRecognizer:sworkingreg];
    
    UILabel *Libraries=[[UILabel alloc]initWithFrame:CGRectMake(Shared.frame.size.width+Shared.frame.origin.x, 0, wid, 35)];
    Libraries.text=@"Libraries";
    Libraries.textAlignment=NSTextAlignmentCenter;
    [Libraries setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Libraries.backgroundColor=[pdp valueForKey:@"clearColor"];
    Libraries.textColor= [UIColor colorWithRed:189.0f/255 green:164.0f/255 blue:226.0f/255 alpha:1.0f];
    [option addSubview:Libraries];
    
    
    Libraries_bar1=[[UILabel alloc]initWithFrame:CGRectMake(Shared.frame.size.width+Shared.frame.origin.x, Libraries.frame.size.height+Libraries.frame.origin.y, wid, 3)];
    Libraries_bar1.backgroundColor=[pdp valueForKey:@"clearColor"];
    [option addSubview:Libraries_bar1];
    
    Libraries_bar2=[[UILabel alloc]initWithFrame:CGRectMake(Shared.frame.size.width+Shared.frame.origin.x, Libraries.frame.size.height+Libraries.frame.origin.y, wid, 3)];
    Libraries_bar2.backgroundColor= [UIColor colorWithRed:189.0f/255 green:164.0f/255 blue:226.0f/255 alpha:1.0f];
    Libraries_bar2.hidden=true;
    [option addSubview:Libraries_bar2];
    
    UITapGestureRecognizer *Librariesreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retrieveLibrary)];
    [Librariesreg setNumberOfTouchesRequired:1];
    [Librariesreg setDelegate:self];
    Libraries.userInteractionEnabled = YES;
    [Libraries addGestureRecognizer:Librariesreg];
    
    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, option.frame.size.height+option.frame.origin.y, headerView.frame.size.width, 30)];
    middle_label.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    [prMainView addSubview:middle_label];
    [self retrievePodcast];
    
}

-(void)retrievePodcast
{
    whicto=0;
    iscallback=5;
  
     search.text=@"";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"getPodcast" :@"":@"":dic1 :self];
    
}

-(void) PodcastView
{
    
    [self clearSharedview];
    [self clearLibraryView];
    
    Podcast_bar2.hidden=false;
    Shared_bar2.hidden=true;
    Libraries_bar2.hidden=true;
   NSString *searchString = search.text;
    NSMutableDictionary *pdp=[SavePrefrences sharedInstance].colorDictionry;
    
    int div = middle_label.frame.size.width/2;
    search=[[UITextField alloc]initWithFrame:CGRectMake(5, 3.5, div+45, middle_label.frame.size.height-7)];
    search.backgroundColor=[UIColor colorWithRed:225.0f/255 green:232.0f/255 blue:239.0f/255 alpha:1.0f];
   // search.placeholder=@"Search...";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    if (searchString.length>0) {
        search.text=[NSString stringWithFormat:@"%@", searchString];
    }else{
    search.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: color}];
    }
    search.delegate=self;
    ///////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search.leftView = paddingView;
    search.leftViewMode = UITextFieldViewModeAlways;
     [search addTarget:self action:@selector(simplesearchPodcast) forControlEvents:UIControlEventEditingChanged];
    ///////////

    [middle_label addSubview:search];
    
    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(search.frame.size.width+search.frame.origin.x+5.7, 4,25,25)];
    searchbutton.backgroundColor=[UIColor clearColor];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *MyPeg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(simplesearchPodcast)];
    [MyPeg1 setNumberOfTouchesRequired:1];
    [MyPeg1 setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:MyPeg1];
    
    
   /* UIButton *Industry=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 3.5, div/3-30, middle_label.frame.size.height-6)];
    Industry.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
    [Industry setImage:[UIImage imageNamed:@"industry.png"] forState:UIControlStateNormal];
    Industry.tag=13;
    [Industry addTarget:self action:@selector(reteriveIndustry:) forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:Industry];*/

    
    UIView *addit=[[UIView alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 0, middle_label.frame.size.height, middle_label.frame.size.height)];
    addit.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:addit];
    
    UIImageView *add=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, addit.frame.size.height, addit.frame.size.height)];
    add.image=[UIImage imageNamed:@"addfolderwhite.png"];
    [addit addSubview:add];
    
    UITapGestureRecognizer *sworkingreg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddnewPodcastView)];
    [sworkingreg1 setNumberOfTouchesRequired:1];
    [sworkingreg1 setDelegate:self];
    addit.userInteractionEnabled = YES;
    [addit addGestureRecognizer:sworkingreg1];

  
    UIView *imgset=[[UIView alloc]initWithFrame:CGRectMake(addit.frame.size.width+addit.frame.origin.x+5, 0, middle_label.frame.size.height, middle_label.frame.size.height)];
    imgset.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:imgset];
    
    UIImageView *three_dots=[[UIImageView  alloc]initWithFrame:CGRectMake(0, 3.5, 25, middle_label.frame.size.height-7)];
    three_dots.image=[UIImage imageNamed:@"more.png"];
    [imgset addSubview:three_dots];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sortbypop:)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    imgset.userInteractionEnabled = YES;
    imgset.tag=1;
    [imgset addGestureRecognizer:sworkingreg2];
    
    
    main=[[UIView alloc]initWithFrame:CGRectMake(0, middle_label.frame.size.height+middle_label.frame.origin.y, prMainView.frame.size.width,(prMainView.frame.size.height-middle_label.frame.size.height))];
    main.backgroundColor=[pdp valueForKey:@"backcolor"];
    [prMainView addSubview:main];
    
    PodcastTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,5,prMainView.frame.size.width,prMainView.frame.size.height-(middle_label.frame.size.height+middle_label.frame.origin.y+30))];
    PodcastTableView.delegate = self;
    PodcastTableView.dataSource = self;
    PodcastTableView.scrollEnabled = YES;
    PodcastTableView.backgroundColor=[pdp valueForKey:@"backcolor"];
    PodcastTableView.separatorColor=[pdp valueForKey:@"backcolor"];
    [main addSubview:PodcastTableView];
    
}


-(void)retrieveSharedPostCast
{
    
    iscallback=6;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"SharedPod" :@"getSharedPod" :@"":@"":dic1 :self];
    
}



-(void)showsharedPodcast
{
    whicto=1;
    [self clearPodcastview];
    [self clearLibraryView];
    NSMutableDictionary *pdp=[SavePrefrences sharedInstance].colorDictionry;
    
    Podcast_bar2.hidden=true;
    Shared_bar2.hidden=false;
    Libraries_bar2.hidden=true;
    
    int wid =middle_label.frame.size.width/2;
    int brd=wid/3;
    search=[[UITextField alloc]initWithFrame:CGRectMake(5, 3.5,wid+80, middle_label.frame.size.height-7)];
    search.backgroundColor=[UIColor colorWithRed:225.0f/255 green:232.0f/255 blue:239.0f/255 alpha:1.0f];
  //  search.placeholder=@"Search...";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    search.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search..." attributes:@{NSForegroundColorAttributeName: color}];

    ///////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search.leftView = paddingView;
    search.leftViewMode = UITextFieldViewModeAlways;
     [search addTarget:self action:@selector(simplesearchshared) forControlEvents:UIControlEventEditingChanged];
    ///////////

    [middle_label addSubview:search];
    
    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(search.frame.size.width+search.frame.origin.x+5.7, 4, 25,25)];
    searchbutton.backgroundColor=[UIColor clearColor];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    [middle_label addSubview:searchbutton];
    
    
    UITapGestureRecognizer *MyPeg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(simplesearchshared)];
    [MyPeg1 setNumberOfTouchesRequired:1];
    [MyPeg1 setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:MyPeg1];
    
    
   /* UIButton *Industry=[[UIButton alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 3.5,brd-30, middle_label.frame.size.height-6)];
    Industry.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
    [Industry setImage:[UIImage imageNamed:@"industry.png"] forState:UIControlStateNormal];
    Industry.tag=103;
    [Industry addTarget:self action:@selector(reteriveIndustry:) forControlEvents:UIControlEventTouchUpInside];
    [middle_label addSubview:Industry];*/

    
    UIView *imgset=[[UIView alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 0, 35, middle_label.frame.size.height)];
    imgset.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:imgset];
    
    
    UIImageView *three_dots=[[UIImageView  alloc]initWithFrame:CGRectMake(10, 3.5, 25, middle_label.frame.size.height-7)];
    three_dots.image=[UIImage imageNamed:@"more.png"];
    [imgset addSubview:three_dots];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(sortbypop:)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    imgset.userInteractionEnabled = YES;
    imgset.tag=1;
    [imgset addGestureRecognizer:sworkingreg2];
    
    
    sharedPodTable = [[UITableView alloc] initWithFrame:CGRectMake(0,5,prMainView.frame.size.width,prMainView.frame.size.height-(middle_label.frame.size.height+middle_label.frame.origin.y+30))];
    sharedPodTable.delegate = self;
    sharedPodTable.dataSource = self;
    sharedPodTable.scrollEnabled = YES;
    sharedPodTable.backgroundColor=[pdp valueForKey:@"backcolor"];
    
    sharedPodTable.separatorColor=[pdp valueForKey:@"backcolor"];
    
    [main addSubview:sharedPodTable];
    
    
    
}


-(void)retrieveLibrary
{
    iscallback=7;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyLibrary" :@"getLib" :@"":@"":dic1 :self];
    
}



-(void)showlibraryPodcast
{
    whicto=2;
    
    NSMutableDictionary *pdp=[SavePrefrences sharedInstance].colorDictionry;
    [self clearPodcastview];
    [self clearSharedview];
    
    Podcast_bar2.hidden=true;
    Shared_bar2.hidden=true;
    Libraries_bar2.hidden=false;
    
    int wid =middle_label.frame.size.width/2;
    int div=wid/3;
    
    searchlib=[[UITextField alloc]initWithFrame:CGRectMake(5, 3.5, wid+60, middle_label.frame.size.height-7)];
    searchlib.backgroundColor=[UIColor colorWithRed:225.0f/255 green:232.0f/255 blue:239.0f/255 alpha:1.0f];
 //   searchlib.placeholder=@"Search...";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    searchlib.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search..." attributes:@{NSForegroundColorAttributeName: color}];

    ///////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    searchlib.leftView = paddingView;
    searchlib.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [middle_label addSubview:searchlib];
    
    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(searchlib.frame.size.width+searchlib.frame.origin.x+5.7, 4,25,25)];
    searchbutton.backgroundColor=[UIColor clearColor];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *serchges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serchLibPod)];
    [serchges setNumberOfTouchesRequired:1];
    [serchges setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:serchges];
   
    UIView *addit=[[UIView alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 0, middle_label.frame.size.height, middle_label.frame.size.height)];
    addit.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:addit];
    
   UIImageView *add=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,addit.frame.size.height, addit.frame.size.height)];
    add.image=[UIImage imageNamed:@"addfolderwhite.png"];
    [addit addSubview:add];
    
    UITapGestureRecognizer *sworkingreg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddNewVideo)];
    [sworkingreg1 setNumberOfTouchesRequired:1];
    [sworkingreg1 setDelegate:self];
    addit.userInteractionEnabled = YES;
    [addit addGestureRecognizer:sworkingreg1];

    
    UIView *imgset=[[UIView alloc]initWithFrame:CGRectMake(addit.frame.size.width+addit.frame.origin.x, 0, middle_label.frame.size.height, middle_label.frame.size.height)];
    imgset.backgroundColor=[UIColor clearColor];
    [middle_label addSubview:imgset];
    
    
    UIImageView *three_dots=[[UIImageView  alloc]initWithFrame:CGRectMake(10, 3.5, 25, middle_label.frame.size.height-7)];
    three_dots.image=[UIImage imageNamed:@"more.png"];
    [imgset addSubview:three_dots];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sortbylibrary)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    imgset.userInteractionEnabled = YES;
    imgset.tag=1;
    [imgset addGestureRecognizer:sworkingreg2];
    
    libTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,5,prMainView.frame.size.width,prMainView.frame.size.height-(middle_label.frame.size.height+middle_label.frame.origin.y+30))];
    libTableView.delegate = self;
    libTableView.dataSource = self;
    libTableView.scrollEnabled = YES;
    libTableView.backgroundColor=[pdp valueForKey:@"backcolor"];
    
    libTableView.separatorColor=[pdp valueForKey:@"backcolor"];
    [main addSubview:libTableView];
    
}





-(void)simplesearchPodcast
{
    iscallback=8;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setObject:@"" forKey:@"ind"];
    [dic1 setObject:@"" forKey:@"dep"];
    [dic1 setObject:search.text forKey:@"key"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podsrch" :@"":@"":dic1 :self];
}


-(void) simplesearchshared
{
    iscallback=11;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setObject:@"" forKey:@"ind"];
    [dic1 setObject:@"" forKey:@"dep"];
    [dic1 setObject:search.text forKey:@"key"];
    [[SavePrefrences sharedInstance].skthand emitData:@"SharedPod" :@"shrdSrch" :@"":@"":dic1 :self];
    
}




-(void)serchLibPod
{
    iscallback=10;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setObject:searchlib.text forKey:@"key"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyLibrary" :@"GetLibSearch" :@"":@"":dic1 :self];
    
    
}
//
-(IBAction)pstpone:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSLog(@"postpone");
    obj=[[popups alloc]init];
    [obj postpone:vc1:(int)btn.tag];
    
}
-(IBAction)openPodcast:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    [self openMorePods:(int)btn.tag];
}


-(void)openUprcntEvent:(UIViewController*)Vc:(NSString*)podid:(NSString*)u_id:(int)chkevent
{
    vc1=Vc;
    whicto=chkevent;
    podcastid=podid;
    isuid=u_id;
    
    [self openMorePods:[podcastid intValue]];
    
}
-(void)openMorePods:(int)LabelId
{
    iscallback=2;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",LabelId] forKey:@"pId"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"PodReadMore" :@"":@"":dic1 :self];
}


-(void)showUprcntEvent:(NSArray*)arr
{
    [self MainViewwithouttitle:vc1];
    
    NSLog(@"isevent ====== %d",whicto);
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y,scrollbar.frame.size.width, 200 );
    
    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 50, 25)];
    [bckarrow setImage:[UIImage imageNamed:@"back1.png"]];
    [headerView addSubview:bckarrow];
    
    UITapGestureRecognizer *sworkingreg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [sworkingreg1 setNumberOfTouchesRequired:1];
    [sworkingreg1 setDelegate:self];
    bckarrow.userInteractionEnabled = YES;
    [bckarrow addGestureRecognizer:sworkingreg1];
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.size.width/2-75,5,headerView.frame.size.width/2-20, 50)];
    [logo setCenter:CGPointMake(headerView.center.x, logo.center.y)];
    [logo setContentMode:UIViewContentModeScaleAspectFit];
    [logo setImage:[UIImage imageNamed:@"logo_new.png"]];
    [headerView addSubview:logo];
    
    UIView * commentMain=[[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y, prMainView.frame.size.width, prMainView.frame.size.height)];
    commentMain.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [prMainView addSubview:commentMain];
    
    
    NSString *podTitle=[[podAr objectAtIndex:0]valueForKey:@"podTitle"];
    NSString *duration=[[podAr objectAtIndex:0]valueForKey:@"duration"];
    NSString *start_time=[[podAr objectAtIndex:0]valueForKey:@"start_time"];
    NSString *podDescrip=[[podAr objectAtIndex:0]valueForKey:@"podDescrip"];
    NSString *md=[[podAr objectAtIndex:0]valueForKey:@"mode"];
    NSString *image=[[podAr objectAtIndex:0]valueForKey:@"image"];
    
    
    
    
    UIImageView *imge=[[UIImageView alloc] initWithFrame:CGRectMake(commentMain.frame.size.width/2-50, 10, 100, 100)];
   // [imge setImage:[UIImage imageNamed:@"user.png"]];

    [commentMain addSubview:imge];
    
    
    if(mang==nil)
        mang=[[ManageArray alloc]init];
    
    NSString * url=[mang concatUrl:image];
    if(url.length<12)
    {
        imge.image = [UIImage imageNamed:@"username.png"];
    }
    else
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if (imageData.length<=0)
            imge.image = [UIImage imageNamed:@"username.png"];
        else
            imge.image = [UIImage imageWithData:imageData];
    }
    
    
    
    
    
    
    UILabel *gap=[[UILabel alloc] initWithFrame:CGRectMake(0, imge.frame.size.height+imge.frame.origin.y+10, prMainView.frame.size.width, 1)];
    gap.backgroundColor=[UIColor grayColor];
    [commentMain addSubview:gap];
   
    
    
    UILabel *title_lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, gap.frame.size.height+gap.frame.origin.y+5, commentMain.frame.size.width, 30)];
    title_lbl.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"Scrollcolor"];
    title_lbl.textColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    title_lbl.textAlignment=NSTextAlignmentCenter;
    if([av checkNullStr:podTitle])
    {
        title_lbl.text=podTitle;
        [commentMain addSubview:title_lbl];
    }
    
    
    
    UILabel *Duration=[[UILabel alloc]initWithFrame:CGRectMake(5, title_lbl.frame.size.height+title_lbl.frame.origin.y+5, 100, 20)];
    Duration.text=@" Duration:";
    Duration.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
    Duration.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [commentMain addSubview:Duration];
    
    UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration.frame.size.width+Duration.frame.origin.x, title_lbl.frame.size.height+title_lbl.frame.origin.y+5, 100, 20)];
    duration_time.text=duration;
    duration_time.textAlignment=NSTextAlignmentLeft;
    duration_time.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
    duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    
    [commentMain addSubview:duration_time];
    
    
    UILabel *current_date=[[UILabel alloc]initWithFrame:CGRectMake(5, Duration.frame.size.height+Duration.frame.origin.y+5, 100, 20)];
    current_date.text=@" Current Date:";
    current_date.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
    current_date.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [commentMain addSubview:current_date];
    
    UILabel *current_date_details=[[UILabel alloc]initWithFrame:CGRectMake(current_date.frame.size.width+current_date.frame.origin.x, duration_time.frame.size.height+duration_time.frame.origin.y+5, 100, 20)];
    current_date_details.text=@" No detail";
    current_date_details.textAlignment=NSTextAlignmentLeft;
    current_date_details.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
    current_date_details.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    
    [commentMain addSubview:current_date_details];
    
    
    
    UILabel *Start_time=[[UILabel alloc]initWithFrame:CGRectMake(5, current_date.frame.size.height+current_date.frame.origin.y+5, 100, 20)];
    Start_time.text=@" Start Time:";
    Start_time.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
    Start_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [commentMain addSubview:Start_time];
    
    UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Start_time.frame.size.width+Start_time.frame.origin.x, current_date_details.frame.size.height+current_date_details.frame.origin.y+5, 100, 20)];
    time.text=start_time;
    time.textAlignment=NSTextAlignmentLeft;
    time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    time.textColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
    [commentMain addSubview:time];
    
    
    UILabel *mode=[[UILabel alloc]initWithFrame:CGRectMake(5, Start_time.frame.size.height+Start_time.frame.origin.y+5, 100, 20)];
    mode.text=@" Mode :";
    mode.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
    mode.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [commentMain addSubview:mode];
    
    
    NSString *m= @"Recording";
    if([md intValue]==1)
    {
        m=@"Live";
    }
    
    
    UILabel *modetxt=[[UILabel alloc]initWithFrame:CGRectMake(Start_time.frame.size.width+Start_time.frame.origin.x, Start_time.frame.size.height+Start_time.frame.origin.y+5, 100, 20)];
    modetxt.text=m;
    modetxt.textAlignment=NSTextAlignmentLeft;
    modetxt.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    modetxt.textColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
    [commentMain addSubview:modetxt];
    
    
    
    
    
    UILabel *gap1=[[UILabel alloc] initWithFrame:CGRectMake(0, modetxt.frame.size.height+modetxt.frame.origin.y+10, prMainView.frame.size.width, 1)];
    gap1.backgroundColor=[UIColor grayColor];
    [commentMain addSubview:gap1];
    
    
    UITextView *descript=[[UITextView alloc] initWithFrame:CGRectMake(5, gap1.frame.size.height+gap1.frame.origin.y+5, commentMain.frame.size.width-10, 100)];
    descript.text=podDescrip;
    descript.textAlignment=NSTextAlignmentLeft;
    descript.backgroundColor=[UIColor clearColor];

    descript.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    descript.textColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
    [commentMain addSubview:descript];
    
    
    apply=[[UIButton alloc]initWithFrame:CGRectMake([SavePrefrences sharedInstance].screenWidth/2 -40, descript.frame.size.height+descript.frame.origin.y+10, 80, 25)];
    [apply setTitle: @" Apply" forState: UIControlStateNormal];
    apply.userInteractionEnabled=YES;
    [apply setTitleColor:[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0] forState:UIControlStateNormal];
    apply.backgroundColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
    if(whicto==11 || whicto==10)
    {
        if([[SavePrefrences sharedInstance].uid intValue]==[isuid intValue])
        {
            apply.hidden=true;
        }
         // apply.hidden=false;
    }
    if(whicto==0||whicto==1)
    {
        apply.hidden=true;
    }
    [apply setClipsToBounds:YES];
    [apply setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [apply addTarget:self action:@selector(applyPodcast:) forControlEvents:UIControlEventTouchUpInside];
    [commentMain addSubview:apply];
    
    
}

-(IBAction)applyPodcast:(id)sender
{
    [self applytoPodcast:vc1];
}


-(void)applytoPodcast:(UIViewController*)Vc
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    [self MainView:Vc :@"Apply Podcast"];
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y,scrollbar.frame.size.width, 270 );
    UILabel *type_msg=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, scrollbar.frame.size.width-40, 35)];
    type_msg.text=@"Type Your Message Here";
    type_msg.textColor=[UIColor colorWithRed:183.0f/255.0f green:182.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
    [type_msg setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:type_msg];
    
    
    Message=[[UITextView alloc]initWithFrame:CGRectMake(20, type_msg.frame.size.height+type_msg.frame.origin.y+10, scrollbar.frame.size.width-40, 130)];
    Message.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [Message setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Message.delegate=self;
    [scrollbar addSubview:Message];
    
    
    
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake(35, Message.frame.size.height+Message.frame.origin.y+10, scrollbar.frame.size.width/2-40, 35)];
    submit.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor colorWithRed:0/255.0f green:49/255.0f blue:99/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitPodMessage:) forControlEvents:UIControlEventTouchUpInside];
    [submit setClipsToBounds:YES];
    [scrollbar addSubview:submit];
    
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake(submit.frame.size.width+submit.frame.origin.x+5,Message.frame.size.height+Message.frame.origin.y+10,  scrollbar.frame.size.width/2-40, 35);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0/255.0f green:49/255.0f blue:99/255.0f alpha:1.0f]forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    close.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [scrollbar addSubview:close];
    
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width,scrollbar.frame.size.height-500);
    
    
    
    
}
-(IBAction)submitPodMessage:(id)sender
{
    iscallback=18;
    
//    JSONObject obj = new JSONObject();
//    obj.put(“poid”, getIntent().getStringExtra(“pod_id”));
//    obj.put(“u_id”, prebk.get(0));
//    obj.put(“id”, getIntent().getStringExtra(“u_id”));
//    SplashScreen.hnd.emitData(“MyPodcast”, “applyPod”, "", "", obj, new PJSCallBack() {
//    
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
   [dic setValue:isuid forKey:@"id"];
    [dic setValue:[NSString stringWithFormat:@"%@",podcastid] forKey:@"poid"];
    [dic setValue:[NSString stringWithFormat:@"%@",[SavePrefrences sharedInstance].uid] forKey:@"u_id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"applyPod" :@"" :@"" :dic :self ];
    
    NSLog(@"diccc====%@",dic);
    
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}

#pragma mark tableView

-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if(theTableView==PodcastTableView)
    {
        tablecellHeight=250;
        return [podcstAr count];
    }
    /*if(theTableView==PodcastTableView)
    {
        return [shareAr count];
    }*/
    if(theTableView==libTableView)
    {
        tablecellHeight=100;
        return [libAr count];
    }
    
    if(theTableView==sharedPodTable)
    {
        tablecellHeight=220;
        return [shareAr count];
    }
    if(theTableView==ProyolkTableView)
    {    tablecellHeight=60;
         return [cbntAr count];
    }
    if (theTableView==networkTableview)
    {tablecellHeight=60;
        return [netwrkAr count];
    }
    if(theTableView==ProyolkFrndTableView)
    {tablecellHeight=60;
        return [proylkAr count];
    }
    
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return tablecellHeight;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==PodcastTableView)
    {
        NSString *po_id=[[podcstAr objectAtIndex:indexPath.row]valueForKey:@"po_id"];
        iscallback=2;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[NSString stringWithFormat:@"%@",po_id] forKey:@"pId"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"PodReadMore" :@"":@"":dic1 :self];

    }
    if(tableView==sharedPodTable)
    {
        NSString *po_id=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"po_id"];

        iscallback=2;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[NSString stringWithFormat:@"%@", po_id] forKey:@"pId"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"PodReadMore" :@"":@"":dic1 :self];

    }
    if(tableView==libTableView)
    {

    }

}




- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *pdp=[SavePrefrences sharedInstance].colorDictionry;
    
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.PodcastTableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.clipsToBounds=YES;
    
    UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 0, PodcastTableView.frame.size.width-10, tablecellHeight-3)];
    cell_View.backgroundColor=[pdp valueForKey:@"backcolor"];
    [cell addSubview: cell_View];
    
    if(theTableView==PodcastTableView)
    {
        
        cell.backgroundColor=[pdp valueForKey:@"backcolor"];
        NSMutableDictionary *clrpod=[SavePrefrences sharedInstance].colorDictionry;
        
        
        NSString *title=[[podcstAr objectAtIndex:indexPath.row]valueForKey:@"title"];
        NSString *duration=[[podcstAr objectAtIndex:indexPath.row]valueForKey:@"duration"];
        NSString *start_time=[[podcstAr objectAtIndex:indexPath.row]valueForKey:@"start_time"];
        NSString *description=[[podcstAr objectAtIndex:indexPath.row]valueForKey:@"description"];
        NSString *po_id=[[podcstAr objectAtIndex:indexPath.row]valueForKey:@"po_id"];
        NSString *mode=[[podcstAr objectAtIndex:indexPath.row]valueForKey:@"mode"];
        NSString *image=[[podcstAr objectAtIndex:indexPath.row]valueForKey:@"image"];
        NSString *timelog=[[podcstAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];

        if ([mode intValue]==1)
        {
            mode=@"Live";
        }
        else
        {
            mode=@"Recording";
            
        }
        podid=po_id;
       /* UIView *headerlbl=[[UIView alloc]initWithFrame:CGRectMake(0, 0, cell_View.frame.size.width, 30)];
        headerlbl.backgroundColor=[clrpod valueForKey:@"Videocolor"];
        headerlbl.clipsToBounds=YES;
        [cell_View addSubview: headerlbl];*/
        //78:119:145
        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell_View.frame.size.width, 25) ];
        if([av checkNullStr:title])
        {
            title_lbl.text=[NSString stringWithFormat:@"%@",title];
        }
        title_lbl.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
        title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [cell_View addSubview:title_lbl];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y+2,self.view.bounds.size.width-30,1)];
        separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
        [cell_View addSubview:separator];

        UIImageView *imgdel=[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-35, 5, 20, 20)];
        imgdel.image=[UIImage imageNamed:@"deleteblack.png"];
        imgdel.tag=[podid intValue];
        [cell_View addSubview:imgdel];
        
        int hight1=cell_View.frame.size.height/2-30;
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
            
            if (imageData.length<=0)
                img.image = [UIImage imageNamed:@"username.png"];
            else
                img.image = [UIImage imageWithData:imageData];
        }
        
        UITapGestureRecognizer *opt=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteit:)];
        opt.numberOfTapsRequired=1;
        [imgdel setUserInteractionEnabled:YES];
        [imgdel addGestureRecognizer:opt];
        
        
        ////////////////////////
        UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x, separator.frame.size.height+separator.frame.origin.y+10, cell_View.frame.size.width-45, cell_View.frame.size.height-100)];
        viewDetails.backgroundColor=[UIColor clearColor];
        viewDetails.clipsToBounds=YES;
        [cell_View addSubview:viewDetails];
        
        
        
        UILabel *Time1=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 100, 20)];
        Time1.text=@"Start Time :  ";
        Time1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Time1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Time1.textAlignment=NSTextAlignmentRight;
        Time1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Time1];
        
        UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Time1.frame.size.width+2,  0, 200, 20)];
        if([av checkNullStr:start_time])
        {
            time.text=[NSString stringWithFormat:@"%@",start_time];
        }
        time.textAlignment=NSTextAlignmentLeft;
        time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        time.textColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
        [viewDetails addSubview:time];

        
        
        
        UILabel *Duration1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Time1.frame.size.height+Time1.frame.origin.y+4, 100, 20)];
        Duration1.text=@"Duration :  ";
        Duration1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Duration1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Duration1.textAlignment=NSTextAlignmentRight;
        Duration1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Duration1];
        
        UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration1.frame.size.width+2+4, Time1.frame.size.height+Time1.frame.origin.y+2, 200, 20)];
        duration_time.textAlignment=NSTextAlignmentLeft;
        duration_time.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        if([av checkNullStr:duration])
        {
            duration_time.text=[NSString stringWithFormat:@"%@",duration];
        }
        [viewDetails addSubview:duration_time];
        
        
        UILabel *Scheduled1=[[UILabel alloc] initWithFrame:CGRectMake(  0, Duration1.frame.size.height+Duration1.frame.origin.y+4,100, 20)];
        Scheduled1.text=@"Posted On :  ";
        Scheduled1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        Scheduled1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
        Scheduled1.textAlignment=NSTextAlignmentRight;
        Scheduled1.backgroundColor=[UIColor clearColor];
        [viewDetails addSubview:Scheduled1];
        
        UILabel *Scheduled=[[UILabel alloc]initWithFrame:CGRectMake(Scheduled1.frame.size.width+2+4,  Duration1.frame.size.height+Duration1.frame.origin.y+2, 200, 20) ];
        Scheduled.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        Scheduled.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        Scheduled.text= timelog;
        [viewDetails addSubview:Scheduled];

        
        
        ///////////////////////
        
        UITextView *subName=[[UITextView alloc]initWithFrame:CGRectMake(10, img.frame.size.height+img.frame.origin.y +5, cell_View.frame.size.width, 45) ];
        if([av checkNullStr:description])
        {
            subName.text=[NSString stringWithFormat:@"%@",description];
        }
        subName.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        subName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        subName.editable=NO;
        subName.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:subName];

        int hghx=cell_View.frame.size.width/4;
        
        UILabel *Recorded=[[UILabel alloc] initWithFrame:CGRectMake(15, subName.frame.size.height+subName.frame.origin.y+10,hghx-30, 20)];
        Recorded.text=[NSString stringWithFormat:@"%@",mode];
        Recorded.textAlignment=NSTextAlignmentLeft;
        Recorded.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
        Recorded.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
        [cell_View addSubview:Recorded];
        
        UIButton *postpone=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        postpone.frame=CGRectMake(Recorded.frame.size.width+Recorded.frame.origin.x+5, subName.frame.size.height+subName.frame.origin.y+10, hghx, 30);
        [postpone setTitle:@"Postpone" forState:UIControlStateNormal];
        [postpone setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [postpone setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        postpone.tag=[po_id intValue];
        [postpone addTarget:self action:@selector(pstpone:)forControlEvents:UIControlEventTouchUpInside];
        postpone.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
        postpone.layer.cornerRadius=5;
        postpone.clipsToBounds=YES;
        [cell_View addSubview:postpone];
        
        UIButton *start_Stream=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        start_Stream.frame=CGRectMake(postpone.frame.size.width+postpone.frame.origin.x+2, subName.frame.size.height+subName.frame.origin.y+10, hghx+15, 30);
        [start_Stream setTitle:@"Start Streaming" forState:UIControlStateNormal];
        [start_Stream setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [start_Stream setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [start_Stream addTarget:self action:@selector(startStreaminig:)forControlEvents:UIControlEventTouchUpInside];
        start_Stream.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
        start_Stream.tag=indexPath.row;
        start_Stream.layer.cornerRadius=5;
        start_Stream.clipsToBounds=YES;

        [cell_View addSubview:start_Stream];
        
        
        UIButton *inivite=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        inivite.frame=CGRectMake(start_Stream.frame.size.width+start_Stream.frame.origin.x+2, subName.frame.size.height+subName.frame.origin.y+10, hghx-20, 30);
        [inivite setTitle:@"Invite" forState:UIControlStateNormal];
        [inivite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [inivite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        inivite.tag=[podid intValue];
        [inivite addTarget:self action:@selector(InvitePodcast:)forControlEvents:UIControlEventTouchUpInside];
        inivite.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
        inivite.layer.cornerRadius=5;
        inivite.clipsToBounds=YES;

        [cell_View addSubview:inivite];

     /*   UIButton *more=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        more.frame=CGRectMake(cell_View.frame.size.width-90, imgdel.frame.size.height+imgdel.frame.origin.y+20, 80, 20);
        [more setTitle:@"More" forState:UIControlStateNormal];
        [more setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        [more setTitleColor:[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0]forState:UIControlStateNormal];
        more.layer.cornerRadius=6;
        more.tag=[po_id intValue];
        [more addTarget:self action:@selector(openPodcast:)forControlEvents:UIControlEventTouchUpInside];
        more.backgroundColor=[UIColor colorWithRed:139.0/255 green:204.0/255 blue:249.0/255 alpha:1.0];
        [cell_View addSubview:more];*/

        return cell;
    }
    if(theTableView==sharedPodTable)
    {
        
        cell.backgroundColor=[pdp valueForKey:@"backcolor"];
        NSMutableDictionary *shrdclr=[SavePrefrences sharedInstance].colorDictionry;
        if([shareAr count]>0)
        {
            NSString *title=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"title"];
            NSString *duration=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"duration"];
            NSString *image=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"image"];
            NSString *po_id=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"po_id"];
            NSString *i_id=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"i_id"];
            NSString *mode=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"mode"];
            NSString *start_time=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"start_time"];
            NSString *t_id=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"t_id"];
            NSString *timelog=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"timelog"];
            NSString *description=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"description"];
            NSString *u_id=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            NSString *mode1=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"mode"];
            if (mode1==1) {
                mode1=@"Live";
            }
            else{
                mode1=@"Recording";
                
            }

            UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell_View.frame.size.width, 25) ];
            if([av checkNullStr:title])
            {
                title_lbl.text=[NSString stringWithFormat:@"%@",title];
            }
            title_lbl.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
            title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
            [cell_View addSubview:title_lbl];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,title_lbl.frame.size.height+title_lbl.frame.origin.y+2,self.view.bounds.size.width-30,1)];
            separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
            [cell_View addSubview:separator];
            
            UIImageView *imgdel=[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-35, 5, 20, 20)];
            imgdel.image=[UIImage imageNamed:@"deleteblack.png"];
            imgdel.tag=[podid intValue];
            [cell_View addSubview:imgdel];
            
            
            int hight1=cell_View.frame.size.height/2-30;
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
                if (imageData.length<=0)
                    img.image = [UIImage imageNamed:@"username.png"];
                else
                    img.image = [UIImage imageWithData:imageData];
            }
            
          /*  UITapGestureRecognizer *opt=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteLibpod:)];
            opt.numberOfTapsRequired=1;
            [img setUserInteractionEnabled:YES];
            [img addGestureRecognizer:opt];*/
            
            
            
            ////////////////////////
            UIView * viewDetails=[[UIView alloc] initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x, separator.frame.size.height+separator.frame.origin.y+10, cell_View.frame.size.width-45, cell_View.frame.size.height-100)];
            viewDetails.backgroundColor=[UIColor clearColor];
            viewDetails.clipsToBounds=YES;
            [cell_View addSubview:viewDetails];
            
            UILabel *Time1=[[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 100, 20)];
            Time1.text=@"Start Time : ";
            Time1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
            Time1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
            Time1.textAlignment=NSTextAlignmentRight;
            Time1.backgroundColor=[UIColor clearColor];
            [viewDetails addSubview:Time1];
            
            UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(Time1.frame.size.width+2,  0, 200, 20)];
            if([av checkNullStr:start_time])
            {
                time.text=[NSString stringWithFormat:@"%@",start_time];
            }
            time.textAlignment=NSTextAlignmentLeft;
            time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
            time.textColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
            [viewDetails addSubview:time];

            
            UILabel *Duration1=[[UILabel alloc] initWithFrame:CGRectMake( 0, Time1.frame.size.height+Time1.frame.origin.y+2, 100, 20)];
            Duration1.text=@"Duration : ";
            Duration1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
            Duration1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
            Duration1.textAlignment=NSTextAlignmentRight;
            Duration1.backgroundColor=[UIColor clearColor];
            [viewDetails addSubview:Duration1];
            
            UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration1.frame.size.width+2+2, Time1.frame.size.height+Time1.frame.origin.y+2, 200, 20)];
            duration_time.textAlignment=NSTextAlignmentLeft;
            duration_time.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
            duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
            if([av checkNullStr:duration])
            {
                duration_time.text=[NSString stringWithFormat:@"%@",duration];
            }

            [viewDetails addSubview:duration_time];
            
            
            UILabel *Scheduled1=[[UILabel alloc] initWithFrame:CGRectMake(  0, Duration1.frame.size.height+Duration1.frame.origin.y+2,100, 20)];
            Scheduled1.text=@"Posted On :  ";
            Scheduled1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
            Scheduled1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[cc valueForKey:@"Tabstextcolor"];
            Scheduled1.textAlignment=NSTextAlignmentRight;
            Scheduled1.backgroundColor=[UIColor clearColor];
            [viewDetails addSubview:Scheduled1];
            
            UILabel *Scheduled=[[UILabel alloc]initWithFrame:CGRectMake(Scheduled1.frame.size.width+2+2,  Duration1.frame.size.height+Duration1.frame.origin.y+2, 200, 20) ];
            Scheduled.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
            Scheduled.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
            if([av checkNullStr:timelog])
            {
                Scheduled.text=[NSString stringWithFormat:@"%@",timelog];
            }

            [viewDetails addSubview:Scheduled];
            
            ///////////////////////
            
            UITextView *desc=[[UITextView alloc]initWithFrame:CGRectMake(10, img.frame.size.height+img.frame.origin.y +5, cell_View.frame.size.width, 45) ];
            if([av checkNullStr:description])
            {
                desc.text=[NSString stringWithFormat:@"%@",description];
            }
            desc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
            desc.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
            desc.editable=NO;
            desc.backgroundColor=[UIColor clearColor];

            [cell_View addSubview:desc];
            
           /* UIButton *more=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            more.frame=CGRectMake(cell_View.frame.size.width-90, desc.frame.size.height+desc.frame.origin.y+20, 80, 20);
            [more setTitle:@"More" forState:UIControlStateNormal];
            [more setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [more setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
            more.layer.cornerRadius=6;
            more.tag=[po_id intValue];
            [more addTarget:self action:@selector(openPodcast:)forControlEvents:UIControlEventTouchUpInside];
            more.backgroundColor=[shrdclr valueForKey: @"Videocolor"];
            [cell_View addSubview:more];*/
 
            UILabel *rec=[[UILabel alloc]initWithFrame:CGRectMake(5, desc.frame.origin.y+desc.frame.size.height, 150, 25) ];
            if([mode intValue]==1)
            {
                rec.text=[NSString stringWithFormat:@"  %@",@"Recording"];
            }
            else
            {
                rec.text=[NSString stringWithFormat:@"  %@",@"Live"];
            }
            rec.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
            rec.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
            [cell_View addSubview:rec];
            

            
            UIButton *join=[[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-130, desc.frame.size.height+desc.frame.origin.y+2,120,30)];
            [join setTitle:@"Join Podcast" forState:UIControlStateNormal];
            [join setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            join.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
            [join addTarget:self action:@selector(startStreaminig:) forControlEvents:UIControlEventTouchUpInside];
            join.tag=indexPath.row;
            [join setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
            join.userInteractionEnabled=YES;
            join.layer.cornerRadius=5;
            join.clipsToBounds=YES;

            [cell_View addSubview:join];
            
            
            return cell;
        }
        else
        {
            alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"No Data Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alrt show];
            
        }
    }
    else if(theTableView==libTableView)
    {
        
        cell.backgroundColor=[pdp valueForKey:@"backcolor"];
        NSString *title=[[libAr objectAtIndex:indexPath.row]valueForKey:@"title"];
        NSString *video_name=[[libAr objectAtIndex:indexPath.row]valueForKey:@"video_name"];
        NSString *video_path=[[libAr objectAtIndex:indexPath.row]valueForKey:@"video_path"];
        NSString *video_size=[[libAr objectAtIndex:indexPath.row]valueForKey:@"video_size"];
        NSString *l_id=[[libAr objectAtIndex:indexPath.row]valueForKey:@"l_id"];
        NSString *description=[[libAr objectAtIndex:indexPath.row]valueForKey:@"description"];
        
        libid=l_id;
        int hight1=cell_View.frame.size.height/2;
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, hight1, hight1)];
        // img.image=[UIImage imageNamed:@"pictureicn.png"];
        img.backgroundColor=[UIColor lightGrayColor];
        [cell_View addSubview:img];
        
        UIImageView *imgdel=[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-40, 5, 20, 20)];
        imgdel.image=[UIImage imageNamed:@"deleteblack.png"];
        [cell_View addSubview:imgdel];
        imgdel.tag=[libid intValue];
        
        
        UITapGestureRecognizer *opt=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteLibpod:)];
        opt.numberOfTapsRequired=1;
        [imgdel setUserInteractionEnabled:YES];
        [imgdel addGestureRecognizer:opt];
        
        UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+8, 0, cell_View.frame.size.width, 25) ];
        if([av checkNullStr:title])
        {
            title_lbl.text=[NSString stringWithFormat:@"%@",title];
        }
        title_lbl.textColor=[UIColor colorWithRed:78.0f/255 green: 119.0f/255 blue:145.0f/255 alpha:1.0];
        title_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        [cell_View addSubview:title_lbl];
        
        
        UITextView *desc=[[UITextView alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+5, title_lbl.frame.origin.y+title_lbl.frame.size.height, cell_View.frame.size.width-85, 50) ];
        if([av checkNullStr:description])
        {
            desc.text=[NSString stringWithFormat:@"%@",description];
        }
        desc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        desc.backgroundColor=[UIColor clearColor];
        desc.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        desc.font=[UIFont boldSystemFontOfSize:14.0f];
        desc.editable=NO;
        [cell_View addSubview:desc];
        return cell;
    }
    else if(theTableView==networkTableview)
    {
        //220:129:135
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width+5, 60)];
        cell_View.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [cell addSubview: cell_View];
        cell.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        
        NSString *uname=[[netwrkAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
        NSString *image=[[netwrkAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        
        userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
        userpic.backgroundColor=[UIColor grayColor];
      //  [userpic setImage:[UIImage imageNamed:@"user.png"]];
        userpic.layer.cornerRadius=22;
        userpic.clipsToBounds=YES;
        [cell_View addSubview:userpic];
        
        
        NSString * url=[mang concatUrl:image];
        if(url.length<12)
        {
            userpic.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            
            if (imageData.length<=0)
                userpic.image = [UIImage imageNamed:@"username.png"];
            else
                userpic.image = [UIImage imageWithData:imageData];
        }
        
        
        
        uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
        uname_lbl.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        if([av checkNullStr:uname])
        {
            uname_lbl.text=uname;
        }
        uname_lbl.backgroundColor=[UIColor clearColor];
        [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [cell_View addSubview: uname_lbl];
        
        
        
          NSString *u_id=[[netwrkAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
          NSString *status=[[netwrkAr objectAtIndex:indexPath.row]valueForKey:@"status"];

        invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-10-40,20)];
        [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
        [invite setBackgroundColor:[UIColor clearColor]];
        invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        invite.tag=[u_id intValue];
        [invite addTarget:self action:@selector(invitepro:) forControlEvents:UIControlEventTouchUpInside];
        [invite setClipsToBounds:YES];
        [cell_View addSubview:invite];
        
        NSString *msg=@"Invite";
        if(status==nil||status==NULL||[status isEqual:[NSNull null]]||[status isEqual:@""]||status == (id)[NSNull null])
        {
        }
        else
        {
            if([status intValue] ==1)
            {
                msg=@"Invite sent";
                invite.backgroundColor=[UIColor clearColor];
            }
        }
        [invite setTitle:msg forState:UIControlStateNormal];
     
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,cell_View.bounds.size.height-1,self.view.bounds.size.width-15,1)];
        separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0f];
        [cell_View addSubview:separator];

        UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
        isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
        isonimg.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:isonimg];

        return cell;
    }
    else if(theTableView==ProyolkTableView )
    {
        cell.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ProyolkTableView.frame.size.width, 60)];
        cell_View.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        cell_View.clipsToBounds=YES;
        [cell addSubview: cell_View];
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,cell_View.bounds.size.height-1,self.view.bounds.size.width-15,1)];
        separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0f];
        [cell_View addSubview:separator];

        NSString *uname=[[cbntAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
         NSString *image=[[cbntAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        
        userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
        userpic.backgroundColor=[UIColor redColor];
       // [userpic setImage:[UIImage imageNamed:@"user.png"]];
        userpic.layer.cornerRadius=22;
        userpic.clipsToBounds=YES;
        [cell_View addSubview:userpic];
        
        
        
        NSString * url=[mang concatUrl:image];
        if(url.length<12)
        {
            userpic.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            
            if (imageData.length<=0)
                userpic.image = [UIImage imageNamed:@"username.png"];
            else
                userpic.image = [UIImage imageWithData:imageData];
        }
        
        
        
        uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
        uname_lbl.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        if([av checkNullStr:uname])
        {
            uname_lbl.text=uname;
        }
        uname_lbl.backgroundColor=[UIColor clearColor];
        [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [cell_View addSubview: uname_lbl];
        
        
        NSString *u_id=[[cbntAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *status=[[cbntAr objectAtIndex:indexPath.row]valueForKey:@"status"];
        
        invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
        [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
        invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [invite setBackgroundColor:[UIColor clearColor]];
        [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        invite.tag=[u_id intValue];
        [invite addTarget:self action:@selector(invitepro:) forControlEvents:UIControlEventTouchUpInside];
        [invite setClipsToBounds:YES];
        [cell_View addSubview:invite];
        
        NSString *msg=@"Invite";
        if(status==nil||status==NULL||[status isEqual:[NSNull null]]||[status isEqual:@""]||status == (id)[NSNull null])
        {
        }
        else
        {
            if([status intValue] ==1)
            {
                msg=@"Invite sent";
                invite.backgroundColor=[UIColor clearColor];
            }
        }
        [invite setTitle:msg forState:UIControlStateNormal];
        
        UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
        isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
        isonimg.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:isonimg];

        return cell;
    }
    else if(theTableView==ProyolkFrndTableView )
    {
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ProyolkFrndTableView.frame.size.width, 60)];
        cell_View.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        cell_View.clipsToBounds=YES;
        [cell addSubview: cell_View];
        cell.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];

        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,cell_View.bounds.size.height-1,self.view.bounds.size.width-15,1)];
        separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0f];
        [cell_View addSubview:separator];
        

        
        NSString *uname=[[proylkAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
         NSString *image=[[cbntAr objectAtIndex:indexPath.row]valueForKey:@"img"];
        
        userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
        userpic.backgroundColor=[UIColor redColor];
     //   [userpic setImage:[UIImage imageNamed:@"user.png"]];
        userpic.layer.cornerRadius=22;
        userpic.clipsToBounds=YES;
        [cell_View addSubview:userpic];
        
        NSString * url=[mang concatUrl:image];
        if(url.length<12)
        {
            userpic.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            
            if (imageData.length<=0)
                userpic.image = [UIImage imageNamed:@"username.png"];
            else
                userpic.image = [UIImage imageWithData:imageData];
        }
        
        
        uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
        uname_lbl.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        if([av checkNullStr:uname])
        {
            uname_lbl.text=uname;
        }
        uname_lbl.backgroundColor=[UIColor clearColor];
        [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [cell_View addSubview: uname_lbl];
        
        
        NSString *u_id=[[proylkAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
        NSString *status=[[proylkAr objectAtIndex:indexPath.row]valueForKey:@"status"];
        
        invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
        [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
        invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        invite.tag=[u_id intValue];
        [invite addTarget:self action:@selector(invitepro:) forControlEvents:UIControlEventTouchUpInside];
        [invite setClipsToBounds:YES];
        [cell_View addSubview:invite];
        
        NSString *msg=@"Invite";
        if(status==nil||status==NULL||[status isEqual:[NSNull null]]||[status isEqual:@""]||status == (id)[NSNull null])
        {
        }
        else
        {
            if([status intValue] ==1)
            {
                msg=@"Invite sent";
                invite.backgroundColor=[UIColor clearColor];
            }
        }
        [invite setTitle:msg forState:UIControlStateNormal];
        
        UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
        isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
        isonimg.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:isonimg];

        return cell;
    }
    return cell;
    
}
-(IBAction)invitepro:(id)sender
{
    UIButton *btn= (UIButton *)sender;
    NSString * text=btn.titleLabel.text;
    
    
    if([text isEqual:@"Invite"])
     {
     [btn setTitle:@"Invitation Sent" forState:UIControlStateNormal];
     btn.backgroundColor=[UIColor clearColor];
         
 
         NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
         
         [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"u_from"];
         [dic setValue:[NSString stringWithFormat:@"%d",podIdforinvite] forKey:@"fId"];
         [dic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"u_to"];
         iscallback=21;
         [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"PodInviteMem" :@"" :@"" :dic :self ];
         

     }
    

    
    
    
}
-(void)deleteit:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    podId=(int)tg.view.tag;
    
    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete ? " delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alrt show];
    [self alertView:alrt clickedButtonAtIndex:2];
    
    
    
    
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSLog(@"ok");
        
        if(whicto==0)
        {
            iscallback=17;
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
            [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
            [dic1 setObject:[NSString stringWithFormat:@"%d",podId] forKey:@"pod_id"];
            [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"delPod" :@"" :@"" :dic1 :self];
        }
        if(whicto==2)
        {
            iscallback=9;
            NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
            [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
            [dic setValue:[NSString stringWithFormat:@"%d",libId]forKey:@"lid"];
            [[SavePrefrences sharedInstance].skthand emitData:@"MyLibrary" :@"DelLib" :@"":@"":dic :self];
        }
    }
    else if(buttonIndex==0)
    {
        NSLog(@"cancel");
        [alrt dismissWithClickedButtonIndex:0 animated:YES];
        
    }
}


-(IBAction)InvitePodcast:(id)sender
{
    
    
   UIButton * btn= (UIButton *) sender;
    podIdforinvite=(int)btn.tag;
    
    [self showInviters];
    
}
-(void)showInviters
{
    NSMutableDictionary *usrserch=[SavePrefrences sharedInstance].colorDictionry;
    [self MainViewfortable:vc1 :@"User Search"];
    
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    int div= viewfortable.frame.size.width/3;
    NSMutableArray *shareAr=[[NSMutableArray alloc]init];
    [shareAr addObject:@"Proyolk Friends"];
    [shareAr addObject:@"Cabinet"];
    [shareAr addObject:@"Network"];
 /*   float incx=0;
    for(int x=0; x< [shareAr count];x++)
    {
        proyolk=[[UILabel alloc]initWithFrame:CGRectMake(incx, 0,div+0.4, 50)];
        proyolk.text=[shareAr objectAtIndex:x];
        proyolk.textAlignment=NSTextAlignmentCenter;
        [proyolk setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        proyolk.textColor=[UIColor blackColor];
        proyolk.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [viewfortable addSubview:proyolk];
        
        UITapGestureRecognizer *gradereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapLabel:)];
        [gradereg setNumberOfTouchesRequired:1];
        [gradereg setDelegate:self];
        proyolk.userInteractionEnabled = YES;
        proyolk.tag=x;
        [proyolk addGestureRecognizer:gradereg];
        
        graybarPrylk=[[UILabel alloc]initWithFrame:CGRectMake(incx, proyolk.frame.size.height+proyolk.frame.origin.y, div+0.4, 5)];
        graybarPrylk.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [viewfortable addSubview:graybarPrylk];
        
        incx=incx+div;
        
    }
    
    yellowPrylk=[[UILabel alloc]initWithFrame:CGRectMake(0, proyolk.frame.size.height+proyolk.frame.origin.y, div, 5)];
    yellowPrylk.backgroundColor=[usrserch valueForKey:@"Yellowbtncolor"];
    yellowPrylk.hidden=false;
    [viewfortable addSubview:yellowPrylk];
    
    yellowcbnt=[[UILabel alloc]initWithFrame:CGRectMake(yellowPrylk.frame.size.width+yellowPrylk.frame.origin.x, proyolk.frame.size.height+proyolk.frame.origin.y, div, 5)];
    yellowcbnt.backgroundColor=[usrserch valueForKey:@"Yellowbtncolor"];
    yellowcbnt.hidden=true;
    [viewfortable addSubview:yellowcbnt];
    
    yellownet=[[UILabel alloc]initWithFrame:CGRectMake(yellowcbnt.frame.size.width+yellowcbnt.frame.origin.x, proyolk.frame.size.height+proyolk.frame.origin.y, div, 5)];
    yellownet.backgroundColor=[usrserch valueForKey:@"Yellowbtncolor"];
    yellownet.hidden=true;
    [viewfortable addSubview:yellownet];*/
    
    
    
    proyolkBtn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 4,div+0.4, 50)];
    [proyolkBtn1 setTitle: @"Proyolk Friends" forState: UIControlStateNormal];
    [proyolkBtn1 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    //proyolkBtn1.textAlignment=NSTextAlignmentCenter;
    [proyolkBtn1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn1 setBackgroundColor:[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];//[ff valueForKey:@"backcolor"];
    proyolkBtn1.tag=111;
    [proyolkBtn1 addTarget:self action:@selector(tapBar1:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn1];
    
    proyolkBtn2=[[UIButton alloc]initWithFrame:CGRectMake(proyolkBtn1.frame.size.width+proyolkBtn1.frame.origin.x, 4,div+0.4, 50)];
    [proyolkBtn2 setTitle: @"Cabinet" forState: UIControlStateNormal];
    //proyolkBtn2.textAlignment=NSTextAlignmentCenter;
    [proyolkBtn2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn2 setBackgroundColor:[UIColor  colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];
    [proyolkBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    proyolkBtn2.tag=222;
    [proyolkBtn2 addTarget:self action:@selector(tapBar2:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn2];
    
    proyolkBtn3=[[UIButton alloc]initWithFrame:CGRectMake(proyolkBtn2.frame.size.width+proyolkBtn2.frame.origin.x, 4,div+0.4, 50)];
    [proyolkBtn3 setTitle: @"Network" forState: UIControlStateNormal];
    //proyolkBtn1.textAlignment=NSTextAlignmentCenter;
    [proyolkBtn3 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn3 setBackgroundColor:[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];//[ff valueForKey:@"backcolor"];
    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    proyolkBtn3.tag=333;
    [proyolkBtn3 addTarget:self action:@selector(tapBar3:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn3];
    
    //130:197:246
    yellowPrylk=[[UILabel alloc]initWithFrame:CGRectMake(0, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
    yellowPrylk.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellowPrylk.hidden=false;
    [viewfortable addSubview:yellowPrylk];
    
    yellowcbnt=[[UILabel alloc]initWithFrame:CGRectMake(yellowPrylk.frame.size.width+yellowPrylk.frame.origin.x, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
    yellowcbnt.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellowcbnt.hidden=true;
    [viewfortable addSubview:yellowcbnt];
    
    yellownet=[[UILabel alloc]initWithFrame:CGRectMake(yellowcbnt.frame.size.width+yellowcbnt.frame.origin.x, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
    yellownet.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellownet.hidden=true;
    [viewfortable addSubview:yellownet];
    

    
   /* search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(10, yellowPrylk.frame.size.height+yellowPrylk.frame.origin.y+5, viewfortable.frame.size.width/2 +40, 30)];
    search_lbl.placeholder=@"Name";
    search_lbl.backgroundColor=[UIColor whiteColor];
    search_lbl.clipsToBounds=YES;
    ///////////
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = paddingView1;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [viewfortable addSubview:search_lbl];
    
    Search=[[UIButton alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+10, yellownet.frame.size.height+yellownet.frame.origin.y+5, viewfortable.frame.size.width/2 -80, 30)];
    [Search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Search.backgroundColor=[usrserch valueForKey:@"Yellowbtncolor"];
    [Search setTitle:@"Search" forState:UIControlStateNormal];
    [Search addTarget:self action:@selector(searchHere:) forControlEvents:UIControlEventTouchUpInside];
    [Search setClipsToBounds:YES];
    [viewfortable addSubview:Search];*/
    
    UIColor *color = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(10, yellowPrylk.frame.size.height+yellowPrylk.frame.origin.y+5, viewfortable.frame.size.width-55, 30)];
    search_lbl.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Search Name..." attributes:@{NSForegroundColorAttributeName: color}];
    [search_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    
    search_lbl.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    search_lbl.delegate=self;
    search_lbl.clipsToBounds=YES;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = paddingView;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
    [viewfortable addSubview:search_lbl];
    
    Search=[[UIButton alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+10, yellownet.frame.size.height+yellownet.frame.origin.y+1, 25, 25)];
    [Search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Search.backgroundColor=[UIColor clearColor];
    [Search setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [Search addTarget:self action:@selector(searchHere:) forControlEvents:UIControlEventTouchUpInside];
    [Search setClipsToBounds:YES];
    [viewfortable addSubview:Search];

}
-(void)proyolkTable
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    NSMutableDictionary *usrserch=[SavePrefrences sharedInstance].colorDictionry;
    ProyolkFrndTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, search_lbl.frame.size.height+search_lbl.frame.origin.y+5,viewfortable.frame.size.width-10,viewfortable.frame.size.height-search_lbl.frame.size.height-search_lbl.frame.origin.y-5)];
    ProyolkFrndTableView.delegate = self;
    ProyolkFrndTableView.dataSource = self;
    ProyolkFrndTableView.scrollEnabled = YES;
    ProyolkFrndTableView.backgroundColor= [ff valueForKey:@"clearColor"];
    ProyolkFrndTableView.separatorColor=[ff valueForKey:@"clearColor"];
    [viewfortable addSubview:ProyolkFrndTableView];
    

    
}
-(void)shareTable
{
    NSMutableDictionary *usrserch=[SavePrefrences sharedInstance].colorDictionry;
    ProyolkTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, search_lbl.frame.size.height+search_lbl.frame.origin.y+5,viewfortable.frame.size.width-10,viewfortable.frame.size.height-search_lbl.frame.size.height-search_lbl.frame.origin.y-5)];
    ProyolkTableView.delegate = self;
    ProyolkTableView.dataSource = self;
    ProyolkTableView.scrollEnabled = YES;
    ProyolkTableView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    ProyolkTableView.separatorColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [viewfortable addSubview:ProyolkTableView];
}
-(void)networkTable
{
    NSMutableDictionary *usrserch=[SavePrefrences sharedInstance].colorDictionry;
    networkTableview = [[UITableView alloc] initWithFrame:CGRectMake(5, search_lbl.frame.size.height+search_lbl.frame.origin.y+5,viewfortable.frame.size.width-10,viewfortable.frame.size.height-search_lbl.frame.size.height-search_lbl.frame.origin.y-5)];
    networkTableview.delegate = self;
    networkTableview.dataSource = self;
    networkTableview.scrollEnabled = YES;
    networkTableview.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    networkTableview.separatorColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [viewfortable addSubview:networkTableview];
}

-(IBAction)searchHere:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    
    if(btn.tag==0)
    {
        iscallback=14;
        NSLog(@"value is %d",iscallback);
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%@",podid] forKey:@"fId"];
        [dic1 setObject:search_lbl.text forKey:@"mem"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"getPodMem" :@"":@"":dic1 :self];
    }
    else if (btn.tag==1)
    {
        iscallback=12;
        NSLog(@"value is %d",iscallback);
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%@",podid] forKey:@"fId"];
        [dic1 setObject:search_lbl.text forKey:@"frnd"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"getProFrnd" :@"":@"":dic1 :self];
    }
    else if (btn.tag==2)
    {
        iscallback=13;
        NSLog(@"value is %d",iscallback);
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%@",podid] forKey:@"fId"];
        [dic1 setObject:search_lbl.text forKey:@"frnd"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"getProFrndz" :@"":@"":dic1 :self];
    }
}
/*-(void)TapLabel:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    if(tg.view.tag==0)
    {
        Search.tag=0;
        [ProyolkFrndTableView removeFromSuperview];
        [ProyolkTableView  removeFromSuperview];
        [networkTableview removeFromSuperview];
        yellownet.hidden=true;
        yellowcbnt.hidden=true;
        yellowPrylk.hidden=false;
    }
    else if(tg.view.tag==1)
    {
        Search.tag=1;
        yellowPrylk.hidden=true;
        yellowcbnt.hidden=false;
        yellownet.hidden=true;
        [networkTableview removeFromSuperview];
        [ProyolkFrndTableView removeFromSuperview];
        iscallback=15;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%@",podid] forKey:@"fId"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"PodFrndz" :@"":@"":dic1 :self];
        
    }
    else if (tg.view.tag==2)
    {
        Search.tag=2;
        [ProyolkTableView removeFromSuperview];
        [ProyolkFrndTableView removeFromSuperview];
        yellownet.hidden=false;
        yellowPrylk.hidden=true;
        yellowcbnt.hidden=true;
        iscallback=16;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:[NSString stringWithFormat:@"%@",podid] forKey:@"bId"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"PodFrndzz" :@"":@"":dic1 :self];
    }
}*/


-(IBAction)tapBar1:(id)sender
//-(void)tapBar:(id)sender
{
    Search.tag=0;
    [ProyolkFrndTableView removeFromSuperview];
    [ProyolkTableView  removeFromSuperview];
    [networkTableview removeFromSuperview];
    yellownet.hidden=true;
    yellowcbnt.hidden=true;
    yellowPrylk.hidden=false;
    [proyolkBtn1 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    [proyolkBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

-(IBAction)tapBar2:(id)sender
//-(void)tapBar:(id)sender
{
    Search.tag=1;
    yellowPrylk.hidden=true;
    yellowcbnt.hidden=false;
    yellownet.hidden=true;
    [networkTableview removeFromSuperview];
    [ProyolkFrndTableView removeFromSuperview];
    iscallback=15;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic1 setObject:[NSString stringWithFormat:@"%@",podid] forKey:@"fId"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"PodFrndz" :@"":@"":dic1 :self];
    [proyolkBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn2 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    
}
-(IBAction)tapBar3:(id)sender
//-(void)tapBar:(id)sender
{
    Search.tag=2;
    [ProyolkTableView removeFromSuperview];
    [ProyolkFrndTableView removeFromSuperview];
    yellownet.hidden=false;
    yellowPrylk.hidden=true;
    yellowcbnt.hidden=true;
    iscallback=16;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic1 setObject:[NSString stringWithFormat:@"%@",podid] forKey:@"bId"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"PodFrndzz" :@"":@"":dic1 :self];
    [proyolkBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn3 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];

}


-(IBAction)startStreaminig:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    if(whicto==0)
    {
        iscallback=19;
        NSString *podsid=[[podcstAr objectAtIndex:(int)btn.tag]valueForKey:@"po_id"];
        st=[[podcstAr objectAtIndex:(int)btn.tag]valueForKey:@"start_time"];
        dur=[[podcstAr objectAtIndex:(int)btn.tag]valueForKey:@"duration"];
        job_desc=[[podcstAr objectAtIndex:(int)btn.tag]valueForKey:@"description"];
        
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setValue:[NSString stringWithFormat:@"%@",podsid] forKey:@"podId"];
        [dic setValue:@"1" forKey:@"ar"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"SharedPod" :@"podJoin" :@"" :@"" :dic :self ];
        
    }
    if(whicto==1)
    {
        iscallback=20;
        
        NSString *podsid=[[shareAr objectAtIndex:(int)btn.tag]valueForKey:@"po_id"];
        st=[[shareAr objectAtIndex:(int)btn.tag]valueForKey:@"start_time"];
        dur=[[shareAr objectAtIndex:(int)btn.tag]valueForKey:@"duration"];
        job_desc=[[shareAr objectAtIndex:(int)btn.tag]valueForKey:@"description"];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setValue:[NSString stringWithFormat:@"%@",podsid] forKey:@"podId"];
        [dic setValue:@"1" forKey:@"ar"];
        [[SavePrefrences sharedInstance].skthand emitData:@"SharedPod" :@"updateJPod" :@"" :@"" :dic :self ];
    }
}
-(void)startStream:(UIViewController*)Vc
{
    
    [self MainViewwithouttitle:Vc];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 50, 25)];
    [bckarrow setImage:[UIImage imageNamed:@"back1.png"]];
    bckarrow.userInteractionEnabled=YES;
    [headerView addSubview:bckarrow];
    
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    bckarrow.userInteractionEnabled = YES;
    [bckarrow addGestureRecognizer:communityeg];
    
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.size.width/2-75,5,headerView.frame.size.width/2-20, 50)];
    [logo setImage:[UIImage imageNamed:@"logo_new.png"]];
    [headerView addSubview:logo];
    
    
    
    UIImageView *share=[[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.size.width-45, 10, 30, 30)];
    [share setImage:[UIImage imageNamed:@"cabineticon.png"]];
    [headerView addSubview:share];
    
//    UITapGestureRecognizer *sharereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openFriendList:)];
//    [sharereg setNumberOfTouchesRequired:1];
//    [sharereg setDelegate:self];
//    share.userInteractionEnabled = YES;
//    [share addGestureRecognizer:sharereg];
    
    
    UIView *video=[[UIView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y, prMainView.frame.size.width, 450)];
    video.backgroundColor=[UIColor blackColor];
    [prMainView addSubview:video];
    
    UIScrollView *bottom=[[UIScrollView alloc]initWithFrame:CGRectMake(0,video.frame.size.height+video.frame.origin.y, prMainView.frame.size.width,[SavePrefrences sharedInstance].screenHeight-video.frame.size.height)];
    bottom.backgroundColor=[ff valueForKey:@"popupcolor"];
    [prMainView addSubview:bottom];
    
    UILabel *dura=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, bottom.frame.size.width/2-20, 30)];
    dura.text=@"Duration";
    dura.textColor=[UIColor blackColor];
    [dura setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    dura.textAlignment=NSTextAlignmentCenter;
    dura.clipsToBounds=YES;
    dura.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [bottom addSubview:dura];
    
    UILabel *durval=[[UILabel alloc]initWithFrame:CGRectMake(dura.frame.size.width+dura.frame.origin.x+10, 10, bottom.frame.size.width/2, 30)];
    durval.text=[NSString stringWithFormat:@"%@",dur];
    durval.textAlignment=NSTextAlignmentCenter;
    durval.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [durval setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    durval.clipsToBounds=YES;
    [bottom addSubview:durval];
    
    UILabel *sttime=[[UILabel alloc]initWithFrame:CGRectMake(5, dura.frame.size.height+dura.frame.origin.y+10, bottom.frame.size.width/2-20, 30)];
    sttime.text=@"Start Time";
    sttime.textColor=[UIColor blackColor];
    sttime.textAlignment=NSTextAlignmentCenter;
    sttime.clipsToBounds=YES;
    [sttime setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    sttime.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [bottom addSubview:sttime];
    
    UILabel *sttimeval=[[UILabel alloc]initWithFrame:CGRectMake(sttime.frame.size.width+sttime.frame.origin.x+10,  dura.frame.size.height+dura.frame.origin.y+10, bottom.frame.size.width/2, 30)];
    sttimeval.text=[NSString stringWithFormat:@"%@",st];
    sttimeval.textAlignment=NSTextAlignmentCenter;
    sttimeval.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [sttimeval setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    sttimeval.clipsToBounds=YES;
    [bottom addSubview:sttimeval];
    
    UITextView *jobdescrpt=[[UITextView alloc]initWithFrame:CGRectMake(5,sttime.frame.size.height+sttime.frame.origin.y+10, bottom.frame.size.width-10,100)];
    jobdescrpt.backgroundColor=[UIColor whiteColor];
    jobdescrpt.text=job_desc;
    [jobdescrpt setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    jobdescrpt.clipsToBounds=YES;
    jobdescrpt.userInteractionEnabled=NO;
    [bottom addSubview:jobdescrpt];
    
    bottom.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth,jobdescrpt.frame.size.height+jobdescrpt.frame.origin.y+80);
}










-(void)openFriendList
{
    NSLog(@"hello open friend list");
    
    
}

-(void)deleteLibpod:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    
    libId=(int)tg.view.tag;
    
    alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete ? " delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alrt show];
    [self alertView:alrt clickedButtonAtIndex:2];
    
}


-(IBAction)showMore:(id)sender
{
    
}


-(void)clearSharedview
{
    NSArray *board1 = ([main subviews]);
    NSArray *middle1=([middle_label subviews]);
    
    for (UIView *v in board1)
    {
        [v removeFromSuperview];
        
    }
    for(UIView *vm in middle1)
    {
        [vm removeFromSuperview];
        
    }
}

-(void)PodcastAdvance:(UIViewController*)Vc:(int)advnceID
{
    NSMutableDictionary *advcepst=[SavePrefrences sharedInstance].colorDictionry;
    
    [self MainView:Vc :@"Advance Search"];
    scrollbar.frame=CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, 400);
    
    
    keyword=[[UITextField alloc]initWithFrame:CGRectMake(20, 20, scrollbar.frame.size.width-40, 35)];
    keyword.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    keyword.textColor=[advcepst valueForKey:@"Scrollcolor"];
   // keyword.placeholder=@"Keywork ";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    keyword.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Keywork" attributes:@{NSForegroundColorAttributeName: color}];

    keyword.delegate=self;
    keyword.clipsToBounds=YES;
    [keyword setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    ///////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    keyword.leftView = paddingView;
    keyword.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [scrollbar addSubview:keyword];
    
    postedBy=[[UITextField alloc]initWithFrame:CGRectMake(20, keyword.frame.size.height+keyword.frame.origin.y+13, scrollbar.frame.size.width-40, 35)];
    postedBy.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    postedBy.textColor=[advcepst valueForKey:@"Scrollcolor"];
   // postedBy.placeholder=@"Posted By";
    postedBy.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Posted By" attributes:@{NSForegroundColorAttributeName: color}];

    postedBy.delegate=self;
    postedBy.clipsToBounds=YES;
    [postedBy setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    ///////////
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    postedBy.leftView = paddingView1;
    postedBy.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [scrollbar addSubview:postedBy];
    
    StartTime=[[UITextField alloc]initWithFrame:CGRectMake(20, postedBy.frame.size.height+postedBy.frame.origin.y+13, scrollbar.frame.size.width-40, 35)];
    StartTime.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    StartTime.textColor=[advcepst valueForKey:@"Scrollcolor"];
  //  StartTime.placeholder=@"Start Time : ";
  //  UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    StartTime.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Start Time : " attributes:@{NSForegroundColorAttributeName: color}];

    StartTime.delegate=self;
    StartTime.tag=1;
    StartTime.clipsToBounds=YES;
    StartTime.userInteractionEnabled=NO;
    [StartTime setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    ///////////
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    StartTime.leftView = paddingView2;
    StartTime.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [scrollbar addSubview:StartTime];
    
    UITapGestureRecognizer *tworking = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(time:)];
    [tworking setNumberOfTouchesRequired:1];
    [tworking setDelegate:self];
    StartTime.userInteractionEnabled = YES;
    [StartTime addGestureRecognizer:tworking];
    
    PostedOn=[[UITextField alloc]initWithFrame:CGRectMake(20, StartTime.frame.size.height+StartTime.frame.origin.y+13, scrollbar.frame.size.width-40, 35)];
    PostedOn.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    PostedOn.textColor=[advcepst valueForKey:@"Scrollcolor"];
   // PostedOn.placeholder=@"Posted On";
    PostedOn.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Posted On" attributes:@{NSForegroundColorAttributeName: color}];

    PostedOn.delegate=self;
    PostedOn.clipsToBounds=YES;
    PostedOn.tag=0;
    [PostedOn setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    ///////////
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    PostedOn.leftView = paddingView3;
    PostedOn.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [scrollbar addSubview:PostedOn];
    
    UITapGestureRecognizer *dworking = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [dworking setNumberOfTouchesRequired:1];
    [dworking setDelegate:self];
    PostedOn.userInteractionEnabled = YES;
    [PostedOn addGestureRecognizer:dworking];
    
    
    
    duration_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, PostedOn.frame.size.height+PostedOn.frame.origin.y+13, scrollbar.frame.size.width-40, 35)];
    duration_lbl.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    duration_lbl.textColor=[advcepst valueForKey:@"Scrollcolor"];
    duration_lbl.text=@"  Duration :";
    duration_lbl.clipsToBounds=YES;
    [duration_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    [scrollbar addSubview:duration_lbl];
    
    UITapGestureRecognizer *ser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDuration)];
    [ser setNumberOfTouchesRequired:1];
    [ser setDelegate:self];
    duration_lbl.userInteractionEnabled = YES;
    [duration_lbl addGestureRecognizer:ser];
    //[NSString stringWithFormat:@"  %@",
    
    Select_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-40, 35)];
    Select_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Select_Industry.textColor=[advcepst valueForKey:@"Scrollcolor"];
    Select_Industry.text=@"  Select Industry";
    Select_Industry.clipsToBounds=YES;
    [Select_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
 
    
    [scrollbar addSubview:Select_Industry];
    
    UITapGestureRecognizer *sworkingreg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Indselect)];
    [sworkingreg1 setNumberOfTouchesRequired:1];
    [sworkingreg1 setDelegate:self];
    Select_Industry.userInteractionEnabled = YES;
    [Select_Industry addGestureRecognizer:sworkingreg1];
    
    Select_Sub_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20, Select_Industry.frame.size.height+Select_Industry.frame.origin.y+13, scrollbar.frame.size.width-40, 35)];
    Select_Sub_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Select_Sub_Industry.textColor=[advcepst valueForKey:@"Scrollcolor"];
    Select_Sub_Industry.text=@"  Select Sub Industry";
    Select_Sub_Industry.clipsToBounds=YES;
    [Select_Sub_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
   
    
    [scrollbar addSubview:Select_Sub_Industry];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SubIndSelection)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    Select_Sub_Industry.userInteractionEnabled = YES;
    [Select_Sub_Industry addGestureRecognizer:sworkingreg2];
    
    
    UIButton *Save=[[UIButton alloc]initWithFrame:CGRectMake((scrollbar.frame.size.width/2)-105, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+13, 100, 35)];
    [Save setTitleColor:[UIColor colorWithRed:0/255.0f green:49/255.0f blue:99/255.0f alpha:1.0f] forState:UIControlStateNormal];
    Save.backgroundColor=[advcepst valueForKey:@"Yellowbtncolor"];
    [Save setTitle:@"Save" forState:UIControlStateNormal];
    [Save addTarget:self action:@selector(savePodcastAdvance:) forControlEvents:UIControlEventTouchUpInside];
    if(advnceID==10)
    {
        Save.tag=0;
    }
    else if (advnceID==11)
    {
        Save.tag=1;
    }
    [Save setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [Save setClipsToBounds:YES];
    [scrollbar addSubview:Save];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake((scrollbar.frame.size.width/2)+5, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+13, 100, 35)];
    [close setTitleColor:[UIColor colorWithRed:0/255.0f green:49/255.0f blue:99/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    close.backgroundColor=[advcepst valueForKey:@"Yellowbtncolor"];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [close setClipsToBounds:YES];
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, close.frame.size.height+close.frame.origin.y+10);
  //  mainScrollView1.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, save.frame.size.height+save.frame.origin.y+20);

}

-(void)selectDuration
{
     duration_lbl.userInteractionEnabled=NO;
    [self DurationView];
    Select_Industry.frame=CGRectMake(5, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-11, 35);
    
}
-(IBAction)setduration:(id)sender
{
     duration_lbl.userInteractionEnabled=YES;
    if([mnth.text isEqual:@" Month"] &&[day.text isEqual:@" Days"]&& [hours.text isEqual:@" Hour"] )
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Duration" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alrt show];
        
    }
    else if(![mnth.text isEqual:@" Month"]&&[day.text isEqual:@" Days"]&& [hours.text isEqual:@" Hour"])
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Days & Hours" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alrt show];
    }
    else if(![mnth.text isEqual:@" Month"]&& ![day.text isEqual:@" Days"]&& [hours.text isEqual:@" Hour"])
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select  Hours" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alrt show];
    }
    
    else if ([mnth.text isEqual:@" Month"] && ![day.text isEqual:@" Days"])
    {
        if( ![hours.text isEqual:@" Hour"])
        {
            duration_lbl.text=[NSString stringWithFormat:@"  %@", [day.text stringByAppendingString:hours.text]];
            durview.hidden=true;
            Select_Industry.frame=CGRectMake(5,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-11,35);
        }
        else{
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Hours" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alrt show];
            
        }
    }
    else if ([mnth.text isEqual:@" Month"] &&[day.text isEqual:@" Days"]&& ![hours.text isEqual:@" Hour"])
    {
        duration_lbl.text=[NSString stringWithFormat:@"  %@",hours.text];
        durview.hidden=true;
        Select_Industry.frame=CGRectMake(5,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-11,35);
    }
    else if (![mnth.text isEqual:@" Month"] &&[day.text isEqual:@" Days"]&& ![hours.text isEqual:@" Hour"])
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Days" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alrt show];
    }
    else{
        duration_lbl.text=[NSString stringWithFormat:@"  %@",[[mnth.text stringByAppendingString:day.text]stringByAppendingString:hours.text]];
        durview.hidden=true;
        Select_Industry.frame=CGRectMake(5,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-11,35);
    }
}
-(void)DurationView
{
    
    NSMutableDictionary *advnce=[SavePrefrences sharedInstance].colorDictionry;
    
    durview=[[UIView alloc]initWithFrame:CGRectMake(5, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+5, scrollbar.frame.size.width-10,45)];
    durview.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    durview.hidden=false;
    [scrollbar addSubview:durview];
    
    mnth=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, durview.frame.size.width/3 -10, 20)];
    mnth.text=@" Month";
    mnth.textColor=[advnce valueForKey:@"Scrollcolor"];
    mnth.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [mnth setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    mnth.clipsToBounds=YES;
    [durview addSubview:mnth];
    
    day=[[UILabel alloc]initWithFrame:CGRectMake(mnth.frame.size.width+mnth.frame.origin.x+5, 0, durview.frame.size.width/3 -10, 20)];
    day.text=@" Days";
    day.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    day.textColor=[advnce valueForKey:@"Scrollcolor"];
    [day setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    day.clipsToBounds=YES;
    [durview addSubview:day];
    
    hours=[[UILabel alloc]initWithFrame:CGRectMake(day.frame.size.width+day.frame.origin.x+5,0, durview.frame.size.width/3 -10, 20)];
    hours.text=@" Hour";
    hours.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    hours.textColor=[advnce valueForKey:@"Scrollcolor"];
    [hours setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    hours.clipsToBounds=YES;
    [durview addSubview:hours];
    
    UIButton *set = [[UIButton alloc]initWithFrame:CGRectMake(durview.frame.size.width/2-60, mnth.frame.size.height+mnth.frame.origin.y+2, durview.frame.size.width/4-20, 20)];
    [set setTitle: @"set" forState: UIControlStateNormal];
    set.backgroundColor=[advnce valueForKey:@"Yellowbtncolor"];
    [set setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [set addTarget:self action:@selector(setduration:) forControlEvents:UIControlEventTouchUpInside];
    [set setTitleColor:[UIColor colorWithRed:0/255.0f green:49/255.0f blue:99/255.0f alpha:1.0f] forState:UIControlStateNormal];
    set.tag=0;
    [durview addSubview:set];
    
    UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(set.frame.size.width+set.frame.origin.x+5, mnth.frame.size.height+mnth.frame.origin.y+2, durview.frame.size.width/4-20, 20)];
    [close setTitle: @"close" forState: UIControlStateNormal];
    close.backgroundColor=[advnce valueForKey:@"Yellowbtncolor"];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close addTarget:self action:@selector(closeduration:) forControlEvents:UIControlEventTouchUpInside];
    [close setTitleColor:[UIColor colorWithRed:0/255.0f green:49/255.0f blue:99/255.0f alpha:1.0f] forState:UIControlStateNormal];
    close.tag=0;
    [durview addSubview:close];
    
    UITapGestureRecognizer *ind4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMonth)];
    [ind4 setNumberOfTouchesRequired:1];
    [ind4 setDelegate:self];
    mnth.userInteractionEnabled = YES;
    [mnth addGestureRecognizer:ind4];
    
    UITapGestureRecognizer *ind3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDay)];
    [ind3 setNumberOfTouchesRequired:1];
    [ind3 setDelegate:self];
    day.userInteractionEnabled = YES;
    [day addGestureRecognizer:ind3];
    
    UITapGestureRecognizer *ind12 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectHour)];
    [ind12 setNumberOfTouchesRequired:1];
    [ind12 setDelegate:self];
    hours.userInteractionEnabled = YES;
    [hours addGestureRecognizer:ind12];
    
    
}


-(IBAction)closeduration:(id)sender
{
     duration_lbl.userInteractionEnabled=YES;
    durview.hidden=true;
    Select_Industry.frame=CGRectMake(10, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-20, 35);
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"predddd");
    [textField resignFirstResponder];
    return YES;
}
-(void) date:(id) sender
{
    
    NSLog(@"date clicked");
    
    UITapGestureRecognizer * tg=(UITapGestureRecognizer *)sender;
    isdate=(int)tg.view.tag;
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [vc1.view addSubview:datePickerView ];
    datePickerView .backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:.5f];
    
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance].screenHeight/3, [SavePrefrences sharedInstance].screenWidth-40, 300)];
    datepicker.hidden = NO;
    [datepicker setValue:[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forKey:@"textColor"];
    datepicker.backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f];
    datepicker.layer.cornerRadius=60;
    datepicker.layer.masksToBounds=YES;
    datepicker.date = [NSDate date];
    datepicker.datePickerMode=UIDatePickerModeDate;
    [datePickerView addSubview:datepicker];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(datepicker.frame.size.width/2-55, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [save setTitle: @"OK" forState: UIControlStateNormal];
    save.tag=isdate;
    save.backgroundColor=[UIColor clearColor];
    [save addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [datePickerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor clearColor];
    [cancel addTarget:self action:@selector(nook:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0/255.0f green:49/255.0f blue:99/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [datePickerView addSubview:cancel];
    
}

-(void) time:(id) sender
{
    
    NSLog(@"date clicked");
    
    UITapGestureRecognizer * tg=(UITapGestureRecognizer *)sender;
    istime=(int)tg.view.tag;
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [vc1.view addSubview:datePickerView ];
    datePickerView .backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:.5f];
    
    
    timepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance].screenHeight/3, [SavePrefrences sharedInstance].screenWidth-40, 300)];
    timepicker.hidden = NO;
    [timepicker setValue:[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forKey:@"textColor"];
    timepicker.backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f];
    timepicker.layer.cornerRadius=60;
    timepicker.layer.masksToBounds=YES;
    timepicker.date = [NSDate date];
    timepicker.datePickerMode=UIDatePickerModeTime;
    [datePickerView addSubview:timepicker];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"hh-mm-ss"];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(timepicker.frame.size.width/2-55, timepicker.frame.size.height+timepicker.frame.origin.y, 70, 30)];
    [save setTitle: @"OK" forState: UIControlStateNormal];
    save.tag=istime;
    save.backgroundColor=[UIColor grayColor];
    [save addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [datePickerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, timepicker.frame.size.height+timepicker.frame.origin.y, 70, 30)];
    [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor grayColor];
    [cancel addTarget:self action:@selector(nook:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [datePickerView addSubview:cancel];
    
}

-(IBAction)ok:(id)sender
{
    UIButton *ub=(UIButton *)sender;
    int tid =ub.tag;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"];
    NSDateFormatter *tm = [[NSDateFormatter alloc] init];
    [tm setDateFormat:@"hh:mm a"];
    if(tid==0)
    {
        
        PostedOn.text=[NSString stringWithFormat:@"%@",[df stringFromDate:datepicker.date]];
    }
    
    if(tid==1)
    {
        StartTime.text=[NSString stringWithFormat:@"%@",[tm stringFromDate:timepicker.date]];
    }
    else{
        
        
    }
    [timepicker removeFromSuperview];
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
    
}


-(IBAction)nook:(id)sender
{
    [datepicker removeFromSuperview];
    [timepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
}



-(void) Indselect
{
    
    @try {
        iscallback=0;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getInd" :@"":@"":dic1 :self];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception is====%@",exception);
    }
    @finally {
        
    }
    
}




-(void) showIndustries

{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@"Select Industry:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[dataind count];x++)
    {
        
        NSString *stname=[[dataind valueForKey:@"industry_name"] objectAtIndex:x];
        NSString *idd=[[dataind valueForKey:@"i_id"] objectAtIndex:x];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            indid=idd;
                                            Select_Industry.text=[NSString stringWithFormat:@"  %@",stname];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}
-(void)SubIndSelection
{
    @try {
        if([av checkCombo:Select_Industry])
        {
        iscallback=1;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:indid forKey:@"inid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getDep" :@"":@"":dic1 :self];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception is===%@",exception);
    }
    @finally {
        
    }
    
}
-(void) showSubIndustries

{
    
    chksel=@"selected";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@"Select Sub Industry:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[subindAr count];x++)
    {
        
        NSString *subname=[[subindAr valueForKey:@"topic_name"] objectAtIndex:x];
        NSString *subindid=[[subindAr valueForKey:@"t_id"] objectAtIndex:x];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:subname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            subid=subindid;
                                            Select_Sub_Industry.text=[NSString stringWithFormat:@"  %@",subname];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}
-(IBAction)savePodcastAdvance:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    
            [dic1 setObject:keyword.text forKey:@"key" ];
    
        [dic1 setObject:StartTime.text forKey:@"time" ];
        [dic1 setObject:PostedOn.text forKey:@"dat" ];
        [dic1 setObject:postedBy.text forKey:@"by" ];
    
    if([duration_lbl.text isEqual:@"  Select Duration"])
    {
        [dic1 setObject:@"" forKey:@"dur" ];
    }
    else{
         [dic1 setObject:duration_lbl.text forKey:@"dur" ];
    }
    
    if([chksel isEqual:@"selected"])
    {
        [dic1 setObject:@"" forKey:@"indus" ];
        [dic1 setObject:@"" forKey:@"topic" ];
    }
     else
     {
         [dic1 setObject:indid forKey:@"indus" ];
         [dic1 setObject:subid forKey:@"topic" ];
     }
    
    
    if((int)btn.tag==0)
    {
        iscallback=3;
        [[SavePrefrences sharedInstance].skthand emitData:@"SearchPod" :@"AdncsearchPod" :@"":@"":dic1 :self];
    }
    else if((int)btn.tag==1)
    {
        iscallback=4;
        [[SavePrefrences sharedInstance].skthand emitData:@"SearchPod" :@"srchPodrecAdvc" :@"":@"":dic1 :self];
    }
}


-(void) selectDay
{
    NSMutableArray *g=[[NSMutableArray alloc]init];
    [g addObject:@"1"];
    [g addObject:@"2"];
    [g addObject:@"3"];
    [g addObject:@"4"];
    [g addObject:@"5"];
    [g addObject:@"6"];
    [g addObject:@"7"];
    [g addObject:@"8"];
    [g addObject:@"9"];
    [g addObject:@"10"];
    [g addObject:@"11"];
    [g addObject:@"12"];
    [g addObject:@"13"];
    [g addObject:@"14"];
    [g addObject:@"15"];
    [g addObject:@"16"];
    [g addObject:@"17"];
    [g addObject:@"18"];
    [g addObject:@"19"];
    [g addObject:@"20"];
    [g addObject:@"21"];
    [g addObject:@"22"];
    [g addObject:@"23"];
    [g addObject:@"24"];
    [g addObject:@"25"];
    [g addObject:@"26"];
    [g addObject:@"27"];
    [g addObject:@"28"];
    [g addObject:@"29"];
    
    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@"Select Day:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[g count];x++)
    {
        
        NSString *daynm=[g objectAtIndex:x];
        
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:daynm style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            selday=x;
                                            day.text=[daynm stringByAppendingString:@" days "];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}
-(void) selectMonth
{
    NSMutableArray *g=[[NSMutableArray alloc]init];
    [g addObject:@"1"];
    [g addObject:@"2"];
    [g addObject:@"3"];
    [g addObject:@"4"];
    [g addObject:@"5"];
    [g addObject:@"6"];
    [g addObject:@"7"];
    [g addObject:@"8"];
    [g addObject:@"9"];
    [g addObject:@"10"];
    [g addObject:@"11"];
    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@" Select Month:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[g count];x++)
    {
        
        NSString *mnthname=[g objectAtIndex:x];
        
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:mnthname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            selmnth=x;
                                            mnth.text=[mnthname  stringByAppendingString:@" Months "];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}
-(void) selectHour
{
    NSMutableArray *g=[[NSMutableArray alloc]init];
    [g addObject:@"1"];
    [g addObject:@"2"];
    [g addObject:@"3"];
    [g addObject:@"4"];
    [g addObject:@"5"];
    [g addObject:@"6"];
    [g addObject:@"7"];
    [g addObject:@"8"];
    [g addObject:@"9"];
    [g addObject:@"10"];
    [g addObject:@"11"];
    [g addObject:@"12"];
    [g addObject:@"13"];
    [g addObject:@"14"];
    [g addObject:@"15"];
    [g addObject:@"16"];
    [g addObject:@"17"];
    [g addObject:@"18"];
    [g addObject:@"19"];
    [g addObject:@"20"];
    [g addObject:@"21"];
    [g addObject:@"22"];
    [g addObject:@"23"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@"Select Hours:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[g count];x++)
    {
        
        NSString *hournm=[g objectAtIndex:x];
        
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:hournm style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            selhr=x;
                                            hours.text=[hournm stringByAppendingString:@" hours "];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}




-(void)sortbypop:(id)sender
 {
    obj=[[popups alloc]init];
    [obj sortbypop :vc1: whicto];
 }


-(void)AddnewPodcastView
{
    
    obj=[[popups alloc]init];
    [obj AddnewPodcast:vc1];
}


-(IBAction)reteriveIndustry:(id)sender
{
    
    UIButton *btn=(UIButton*)sender;
    
    bpop=[[BoardPopUp alloc]init];
    [bpop IndustrySearch :vc1:(int)btn.tag:0];
}





-(void)clearPodcastview
{
    NSArray *board1 = ([main subviews]);
    NSArray *middle1=([middle_label subviews]);
    
    for (UIView *v in board1)
    {
        [v removeFromSuperview];
        
    }
    for(UIView *vm in middle1)
    {
        [vm removeFromSuperview];
        
    }
}

-(void)sortbylibrary
{
    obj=[[popups alloc]init];
    [obj sortbylibrary:vc1];
}
-(void)AddNewVideo
{
    obj=[[popups alloc]init];
    [obj AddNewLibrary:vc1];
}
-(void)clearLibraryView
{
    NSArray *board1 = ([main subviews]);
    NSArray *middle1=([middle_label subviews]);
    
    for (UIView *v in board1)
    {
        [v removeFromSuperview];
        
    }
    for(UIView *vm in middle1)
    {
        [vm removeFromSuperview];
        
    }
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
        
        if([popUpAr count]==1)
        {
              tablecellHeight=180;
        }
    
    }
    if([popUpAr count]==0)
    {
        NSLog(@"pop count innnn");
        id<CallTo_Parent> cb= vc1;
        NSLog(@"backkkkkkkkkkkkkk %@",backData);
        [cb callMethod:backData];
        
    }
}
-(IBAction)cancel:(id)sender
{
    
    [self dissmisspop];
}
-(void) callBack:(NSArray *)META  :(NSArray *)DATA
{
    
    NSLog(@"meta===dearch==%@",META);
    NSLog(@"data==search===%@",DATA);
    NSLog(@"data==iscallback===%d",iscallback);
    
    
    if(iscallback==0)
    {
        dataind=DATA;
        [self showIndustries];
    }
    else if (iscallback==1)
    {
        subindAr=DATA;
        [self showSubIndustries];
    }
    else if (iscallback==2)
    {
        
        podAr=DATA;
        NSLog(@"valuuuueeeee is %@",podAr);
        [self showUprcntEvent:podAr];
    }
    else if (iscallback==3)//advance search
    {
        
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"adSerch"];
        [backData addObject:DATA];
        
        [self dissmisspop];
        
        
    }
    else if (iscallback==4)
    {
        [backData addObject:@"adSerch"];
        [backData addObject:DATA];
        [self dissmisspop];
    }
    else if(iscallback==5)
    {//podcast view
        
        podcstAr=DATA;
        [self PodcastView];
        
    }
    
    else if(iscallback==6)
    {//podcast view
        
        NSLog(@"Meta of shared podcast====%@",META);
        NSLog(@"data of shared podcast====%@",DATA);
        shareAr=DATA;
        
        [self showsharedPodcast];
        
        
    }
    else if(iscallback==7)
    {//podcast view
        
        NSLog(@"Meta of library podcast====%@",META);
        NSLog(@"data of Library podcast====%@",DATA);
        libAr=DATA;
        [self showlibraryPodcast];
        
    }
    
    else if(iscallback==8)
    {//podcast view
        
        podcstAr=DATA;
        [self PodcastView];
    }
    else if(iscallback==9)
    {//delete lib
        
        alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted Successfully!!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alrt show];
        [alrt dismissWithClickedButtonIndex:0 animated:YES];
        libAr=DATA;
        [libTableView reloadData];
    }
    else if(iscallback==10)
    {//serch lib
        
        libAr=DATA;
        [libTableView reloadData];
    }
    
    else if(iscallback==11)
    {//serch lib
        shareAr=DATA;
        [sharedPodTable reloadData];
        
    }
    else if (iscallback==12)
    {
        cbntAr=DATA;
        [ProyolkTableView reloadData];
    }
    else if (iscallback==13)
    {
        netwrkAr=DATA;
        [networkTableview reloadData];
    }
    else if (iscallback==14)
    {
        proylkAr=DATA;
        if([proylkAr count]>0)
           [self proyolkTable];
    }
    else if(iscallback==15)
    {
        NSArray *newdata= [META valueForKey:@"data"];
        cbntAr=[newdata valueForKey:@"friend"];
        [self shareTable];
    }
    else if(iscallback==16)
    {
        NSArray *newdata= [META valueForKey:@"data"];
        netwrkAr=[newdata valueForKey:@"friend"];
        [self networkTable];
    }
    else if (iscallback==17)
    {
        
        alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted Successfully!!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alrt show];
        [alrt dismissWithClickedButtonIndex:0 animated:YES];
        [self retrievePodcast];
        
    }
    else if (iscallback==18)
    {
        apply.userInteractionEnabled=NO;
        apply.backgroundColor=[UIColor clearColor];
        [apply setTitle:@"Applied" forState:UIControlStateNormal];
        [self dissmisspop];
    }
    else if (iscallback==19)
    {
        [self startStream:vc1];
        
    }
    else if (iscallback==20)
    {
        [self startStream:vc1];
        
    }
    else if (iscallback==21)
    {
        NSLog(@"pod invited=====meta===%@",META);
        NSLog(@"pod invited=====data===%@",DATA);
        
    }
    
    
}
-(void) callMethod:(NSArray *)meta
{
    NSString * chk=[meta objectAtIndex:0];
    NSLog(@"Valuuuuuuuuuu bac in podcast===%@",meta);
    NSLog(@"COUNT IS %lu",[meta count]);
    if([meta count]>1)
    {
        NSMutableArray * ar=[meta objectAtIndex:1];
        if([ar count]>0)
        {
            if([chk isEqual:@"podindustry"])
            {
                
                podcstAr=ar;
                [self PodcastView];
            }
            
            if([chk isEqual:@"libsort"])
            {
                
                libAr=ar;
                NSLog(@"hererer lib data  ==%@",libAr);
                [self libTableView];
                
            }
            if([chk isEqual:@"podcastpostpone"])
            {
                [self retrievePodcast];
            }
            if([chk isEqual:@"sharedpodindustry"])
            {
                
                shareAr=ar;
                NSLog(@"hererer lib shareddata  ==%@",ar);
                [self sharedPodTable];
                
            }
            
            
            if([chk isEqual:@"podcastsort"])
            {
                NSLog(@"inside podcast simple sort");
                podcstAr=ar;
                [PodcastTableView reloadData];
                
            }
            
            
            if([chk isEqual:@"podsharedsort"])
            {
                shareAr=ar;
                NSLog(@"hererer lib shareddata  reloadeddddd ==%@",ar);
                [sharedPodTable reloadData];
                
            }
            if([chk isEqual:@"addpodcast"])
            {
                podcstAr=ar;
                [PodcastTableView reloadData];
            }
        }
        
        else
        {
            
        }
        
        
    }
}
-(IBAction)applyPod:(id)sender
{
    NSLog(@"apply pod");
}







@end
