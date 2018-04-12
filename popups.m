//
//  popups.m
//  Proyolk
//
//  Created by Purple Intellect on 25/03/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "popups.h"
#import "AllValidationsViewController.h"
#import "SavePrefrences.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>




@interface popups ()
{
    id sender1;
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UILabel *NameLabel,*title_label,*duration_lbl;
    UIView *prMainView,*datePickerView;
    NSMutableArray *popUpAr;
    UIViewController *vc1;
    AllValidationsViewController *av;
    UIScrollView *scrollbar;
    UIImageView *imggeter;
    UITextField * TitleEvent,*StartTime,*TitleContant,*TitleEvent1;
    UITextView *Descrpt;
    int psort,iscallback,isdate,istime,selday,selmnth,selhr;
    UILabel *mode,*Live,*CurrentDate;
    NSMutableArray *modeAr;
    UILabel *Select_Industry,*Select_Sub_Industry;
    NSMutableArray *backdata;
    NSString *imgBuffer,*randomImgName;
    NSString *indid,*subid;
    NSArray *dataind,*subdataind;
    UILabel *time,*detail;
    
    UILabel *mnth,*day,*hours;
    UIView *durview;
    UIDatePicker *datepicker,*timepicker;
}
@end

@implementation popups

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark mainView for popup BG
-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{
    
    if ([title isEqualToString:@"Add New Library"]||[title isEqualToString:@"Sort By"]||[title isEqualToString:@"Update Date and Time of Podcast"]) {
        av=[[AllValidationsViewController alloc]init];
        prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
        [Vc.view addSubview:prMainView];
        vc1=Vc;
        prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
        if([popUpAr count]>0)
        {
            [popUpAr addObject:prMainView];
        }
        else
        {
            popUpAr =[[NSMutableArray alloc]init];
            [popUpAr addObject:prMainView];
        }
        NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15+80, prMainView.frame.size.width-40, 50+20)];
        NameLabel.text=title;//220:129:135
        NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        NameLabel.textColor=[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        NameLabel.textAlignment=NSTextAlignmentCenter;
        NameLabel.layer.cornerRadius=10;
        NameLabel.clipsToBounds = YES;
        [prMainView addSubview:NameLabel];
        
        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, 300)];
        [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
        scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        scrollbar.layer.cornerRadius=10;
        scrollbar.clipsToBounds = YES;
        [prMainView addSubview:scrollbar];

    }
    else
    {
        av=[[AllValidationsViewController alloc]init];
        prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
        [Vc.view addSubview:prMainView];
        vc1=Vc;
        prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
        if([popUpAr count]>0)
        {
            [popUpAr addObject:prMainView];
        }
        else
        {
            popUpAr =[[NSMutableArray alloc]init];
            [popUpAr addObject:prMainView];
        }
        NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-40, 50+20)];
        NameLabel.text=title;//220:129:135
        NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        NameLabel.textColor=[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        NameLabel.textAlignment=NSTextAlignmentCenter;
        NameLabel.layer.cornerRadius=10;
        NameLabel.clipsToBounds = YES;
        [prMainView addSubview:NameLabel];
        
        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+90))];
        [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
        scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        scrollbar.layer.cornerRadius=10;
        scrollbar.clipsToBounds = YES;

        [prMainView addSubview:scrollbar];

    }
    
    return prMainView;
}

-(void)AddnewPodcast:(UIViewController*)Vc
{
    NSMutableDictionary *pdcst=[SavePrefrences sharedInstance].colorDictionry;
    [self MainView:Vc :@"Add New Podcast"];
    
    imggeter = [[UIImageView alloc] initWithFrame:CGRectMake(scrollbar.frame.size.width/2-50, 5, 100, 100)];
    imggeter.backgroundColor=[UIColor lightGrayColor];
    [imggeter setImage:[UIImage imageNamed:@"username.png"]];
   // imggeter.image=[UIImage imageNamed:@""];
    [scrollbar addSubview:imggeter];
    
    //130:197:246
    UIButton *btnGo= [[UIButton alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2-50,imggeter.frame.size.height+imggeter.frame.origin.y+10, 100, 36)];
    [btnGo setTitle: @"Browse" forState: UIControlStateNormal];
    [btnGo setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    btnGo.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    [btnGo addTarget:self action:@selector(chooseOption:) forControlEvents:UIControlEventTouchUpInside];
    [btnGo setTitleColor:[UIColor colorWithRed:0.0f/255 green:0.0f/255 blue:0.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    btnGo.tag=1;
    btnGo.layer.cornerRadius=5;
    [scrollbar addSubview:btnGo];
    
    
    TitleEvent=[[UITextField alloc]initWithFrame:CGRectMake(20, btnGo.frame.size.height+btnGo.frame.origin.y+10, scrollbar.frame.size.width-40, 35)];
    TitleEvent.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
   // TitleEvent.placeholder=@" Title of The Event ";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    TitleEvent.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Title of The Event " attributes:@{NSForegroundColorAttributeName: color}];

    TitleEvent.delegate=self;
    TitleEvent.textColor=[pdcst valueForKey:@"Scrollcolor"];
    [TitleEvent setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    TitleEvent.leftView = paddingView;
    TitleEvent.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    [scrollbar addSubview:TitleEvent];
    
    
    StartTime=[[UITextField alloc]initWithFrame:CGRectMake(20, TitleEvent.frame.size.height+TitleEvent.frame.origin.y+10, scrollbar.frame.size.width-40, 35)];
    StartTime.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    StartTime.textColor=[pdcst valueForKey:@"Scrollcolor"];
   // StartTime.placeholder=@"Start Time : ";
    StartTime.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Start Time : " attributes:@{NSForegroundColorAttributeName: color}];

    StartTime.delegate=self;
    StartTime.tag=1;
    StartTime.userInteractionEnabled=NO;
    ///////////////
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    StartTime.leftView = paddingView1;
    StartTime.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    [StartTime setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    
    [scrollbar addSubview:StartTime];
    
    UITapGestureRecognizer *prev1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(time:)];
    [prev1 setNumberOfTouchesRequired:1];
    [prev1 setDelegate:self];
    StartTime.userInteractionEnabled = YES;
    [StartTime addGestureRecognizer:prev1];
    
    
    duration_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, StartTime.frame.size.height+StartTime.frame.origin.y+10, scrollbar.frame.size.width-40, 35)];
    duration_lbl.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    duration_lbl.textColor=[pdcst valueForKey:@"Scrollcolor"];
    duration_lbl.text=@"  Select Duration";
    [duration_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    duration_lbl.clipsToBounds=YES;
    [scrollbar addSubview:duration_lbl];
    
    
    UITapGestureRecognizer *rer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDuration)];
    [rer setNumberOfTouchesRequired:1];
    [rer setDelegate:self];
    duration_lbl.userInteractionEnabled = YES;
    [duration_lbl addGestureRecognizer:rer];
    
    CurrentDate=[[UILabel alloc]initWithFrame:CGRectMake(20, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-40, 35)];
    CurrentDate.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    CurrentDate.textColor=[pdcst valueForKey:@"Scrollcolor"];
    CurrentDate.text=@"  Current Date";
    CurrentDate.tag=0;
    CurrentDate.clipsToBounds=YES;
    [CurrentDate setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    
    UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [prev setNumberOfTouchesRequired:1];
    [prev setDelegate:self];
    CurrentDate.userInteractionEnabled = YES;
    [CurrentDate addGestureRecognizer:prev];
    [scrollbar addSubview:CurrentDate];
    
    
    UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(20, CurrentDate.frame.size.height+CurrentDate.frame.origin.y+10,  scrollbar.frame.size.width-40, 55)];
    descriptionView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    [scrollbar addSubview:descriptionView];
    
    desc=[[UILabel alloc]initWithFrame:CGRectMake(8, 3,  descriptionView.frame.size.width-10, 20)];
    desc.text=@"Description:";
    desc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    desc.backgroundColor=[UIColor clearColor];
    [desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [descriptionView addSubview:desc];
    
    Descrpt=[[UITextView alloc]initWithFrame:CGRectMake(11, 0,  descriptionView.frame.size.width-10,descriptionView.frame.size.height)];
    Descrpt.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    Descrpt.backgroundColor=[UIColor clearColor];
    Descrpt.delegate=self;
    [Descrpt setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Descrpt.tag=222;
    [descriptionView addSubview:Descrpt];

    
    UIView *descriptionViewMode=[[UIView alloc]initWithFrame:CGRectMake(20, descriptionView.frame.size.height+descriptionView.frame.origin.y+10,  scrollbar.frame.size.width-40, 35)];
    descriptionViewMode.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    [scrollbar addSubview:descriptionViewMode];

    modeAr=[[NSMutableArray alloc]init];
    [modeAr addObject:@"Live"];
    [modeAr addObject:@"Recording"];
    
    int widx=scrollbar.frame.size.width/3 ;
    int settag=0;
    
    mode=[[UILabel alloc] initWithFrame:CGRectMake(0, 7, widx-20, 20)];
    mode.text=@"  Mode :";
    mode.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    mode.textAlignment=NSTextAlignmentLeft;
    [mode setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [descriptionViewMode addSubview:mode];
    
    int lx=mode.frame.size.width+mode.frame.origin.x;
    
    for(int x=0; x<[modeAr count];x++)
    {
        UIButton *live_btn =[[UIButton alloc]initWithFrame:CGRectMake(lx-20, 7, 20, 20)];
        live_btn.layer.cornerRadius=10;
        live_btn.backgroundColor=[UIColor clearColor];
        [live_btn addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
        [live_btn setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        if(x==0)
        {     sender1=live_btn;
            [live_btn setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        live_btn.tag=settag;
        [descriptionViewMode addSubview:live_btn];
        
        Live=[[UILabel alloc]initWithFrame:CGRectMake(live_btn.frame.origin.x+live_btn.frame.size.width+5, 7,widx-10, 25)];
        Live.text=[modeAr objectAtIndex:x];
        Live.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
        [Live setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        [descriptionViewMode addSubview:Live];
        
        lx=lx+widx;
        settag++;
    }
    
  /*  Select_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20, Live.frame.size.height+Live.frame.origin.y+10, scrollbar.frame.size.width-40, 35)];
    Select_Industry.text=@" Search Industry";
    Select_Industry.backgroundColor=[UIColor whiteColor];
    Select_Industry.textColor=[pdcst valueForKey:@"Scrollcolor"];
    Select_Industry.clipsToBounds=YES;
    [Select_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [scrollbar addSubview:Select_Industry];
   
    UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectInduct)];
    [ind setNumberOfTouchesRequired:1];
    [ind setDelegate:self];
    Select_Industry.userInteractionEnabled = YES;
    [Select_Industry addGestureRecognizer:ind];
   
    Select_Sub_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20, Select_Industry.frame.size.height+Select_Industry.frame.origin.y+10, scrollbar.frame.size.width-40, 35)];
    Select_Sub_Industry.text=@" Select Sub Industry";
    Select_Sub_Industry.textColor=[pdcst valueForKey:@"Scrollcolor"];
    [Select_Sub_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Sub_Industry.clipsToBounds=YES;
    Select_Sub_Industry.backgroundColor=[UIColor whiteColor];
    [scrollbar addSubview:Select_Sub_Industry];
    
    UITapGestureRecognizer *ind2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selecSubInd)];
    [ind2 setNumberOfTouchesRequired:1];
    [ind2 setDelegate:self];
    Select_Sub_Industry.userInteractionEnabled = YES;
    Select_Sub_Industry.tag=[indid intValue];
    [Select_Sub_Industry addGestureRecognizer:ind2];*/
    
    
    UIButton *Save=[[UIButton alloc]initWithFrame:CGRectMake(35, descriptionViewMode.frame.size.height+descriptionViewMode.frame.origin.y+10, scrollbar.frame.size.width/2 -40, 35)];
    Save.backgroundColor=[pdcst valueForKey:@"Yellowbtncolor"];
    [Save setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [Save setTitle:@"Save" forState:UIControlStateNormal];
    [Save setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [Save addTarget:self action:@selector(savePodCast:) forControlEvents:UIControlEventTouchUpInside];
    [Save setClipsToBounds:YES];
    [scrollbar addSubview:Save];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(Save.frame.size.width+Save.frame.origin.x+5, descriptionViewMode.frame.size.height+descriptionViewMode.frame.origin.y+10,  scrollbar.frame.size.width/2 -40, 35)];
    close.backgroundColor=[pdcst valueForKey:@"Yellowbtncolor"];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [close setClipsToBounds:YES];
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, scrollbar.frame.size.height+60);
    
    
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if(textView.tag==222)
    {
        [desc setHidden:YES];
    }
    
}

-(void)selectDuration
{
    duration_lbl.userInteractionEnabled=NO;
    
    [self DurationView];
    CurrentDate.frame=CGRectMake(5, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-11, 35);
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"predddd");
    [textField resignFirstResponder];
    return YES;
}


-(IBAction)savePodCast:(id)sender
{
    
    
    NSLog(@"p sort valoue====%d",psort);
    if([av checkNull:TitleEvent])
    {
        if([av checkNulltextview:Descrpt])
        {
            if([av checkCombo:Select_Industry]&&[av checkCombo:Select_Sub_Industry])
            {
                if([av checkNull:StartTime]&&[av checkCombo:duration_lbl])
                {
                    iscallback=8;
                    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
                    [dic1 setObject:TitleEvent.text forKey:@"title"];
                    [dic1 setObject:Descrpt.text forKey:@"des"];
                    [dic1 setObject:StartTime.text forKey:@"strt"];
                    [dic1 setObject:duration_lbl.text forKey:@"dur"];
                    [dic1 setObject:CurrentDate.text forKey:@"date"];
                    [dic1 setObject:subid forKey:@"dep"];
                    [dic1 setObject:indid forKey:@"ind"];
                    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
                    [dic1 setObject:[NSString stringWithFormat:@"%d",psort] forKey:@"mode"];
                    
                    [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"savePodcast" :@"":@"":dic1 :vc1];
                    [prMainView removeFromSuperview];
                }
            }
        }
    }
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
            duration_lbl.text=[day.text stringByAppendingString:hours.text];
            durview.hidden=true;
            CurrentDate.frame=CGRectMake(5,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-11,35);
        }
        else{
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Hours" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alrt show];
            
        }
    }
    else if ([mnth.text isEqual:@" Month"] &&[day.text isEqual:@" Days"]&& ![hours.text isEqual:@" Hour"])
    {
        duration_lbl.text=hours.text;
        durview.hidden=true;
        CurrentDate.frame=CGRectMake(5,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-11,35);
    }
    else if (![mnth.text isEqual:@" Month"] &&[day.text isEqual:@" Days"]&& ![hours.text isEqual:@" Hour"])
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Days" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alrt show];
    }
    else{
        duration_lbl.text=[[mnth.text stringByAppendingString:day.text]stringByAppendingString:hours.text];
        durview.hidden=true;
        CurrentDate.frame=CGRectMake(5,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-11,35);
    }
}

-(void)DurationView
{
    
    NSMutableDictionary *advnce=[SavePrefrences sharedInstance].colorDictionry;
    
    durview=[[UIView alloc]initWithFrame:CGRectMake(5, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+5, scrollbar.frame.size.width-10,45)];
    durview.backgroundColor=[advnce valueForKey:@"popupcolor"];
    durview.hidden=false;
    [scrollbar addSubview:durview];
    
    mnth=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, durview.frame.size.width/3 -10, 20)];
    mnth.text=@" Month";
    mnth.textColor=[advnce valueForKey:@"popupcolor"];
    mnth.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [mnth setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    mnth.clipsToBounds=YES;
    [durview addSubview:mnth];
    
    day=[[UILabel alloc]initWithFrame:CGRectMake(mnth.frame.size.width+mnth.frame.origin.x+5, 0, durview.frame.size.width/3 -10, 20)];
    day.text=@" Days";
    day.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    day.textColor=[advnce valueForKey:@"popupcolor"];
    [day setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    day.clipsToBounds=YES;
    [durview addSubview:day];
    
    hours=[[UILabel alloc]initWithFrame:CGRectMake(day.frame.size.width+day.frame.origin.x+5,0, durview.frame.size.width/3 -10, 20)];
    hours.text=@" Hour";
    hours.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    hours.textColor=[advnce valueForKey:@"popupcolor"];
    [hours setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    hours.clipsToBounds=YES;
    [durview addSubview:hours];
    
    UIButton *set = [[UIButton alloc]initWithFrame:CGRectMake(durview.frame.size.width/2-60, mnth.frame.size.height+mnth.frame.origin.y+2, durview.frame.size.width/4-20, 20)];
    [set setTitle: @"set" forState: UIControlStateNormal];
    set.backgroundColor=[advnce valueForKey:@"Yellowbtncolor"];
    [set setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [set addTarget:self action:@selector(setduration:) forControlEvents:UIControlEventTouchUpInside];
    [set setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    set.tag=0;
    [durview addSubview:set];
    
    UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(set.frame.size.width+set.frame.origin.x+5, mnth.frame.size.height+mnth.frame.origin.y+2, durview.frame.size.width/4-20, 20)];
    [close setTitle: @"close" forState: UIControlStateNormal];
    close.backgroundColor=[advnce valueForKey:@"Yellowbtncolor"];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close addTarget:self action:@selector(closeduration:) forControlEvents:UIControlEventTouchUpInside];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
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
    CurrentDate.frame=CGRectMake(10, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-20, 35);
    
}
-(void)sortbypop:(UIViewController*)Vc:(int)SortID
{
    NSMutableDictionary *srt=[SavePrefrences sharedInstance].colorDictionry;
    [self MainView:Vc :@"Sort By"];
    
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y, scrollbar.frame.size.width, 150 );
    
    UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(30, 30, 20,  20)];
    img.layer.cornerRadius=7.5;
    [img addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
    [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    img.tag=0;
    [scrollbar addSubview:img];
    
    UILabel *title_lbl=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+8, 30, 80, 20)];
    [title_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    title_lbl.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];
    title_lbl.text=@" Title";
    [scrollbar addSubview:title_lbl];
    
    UIButton *img1 =[[UIButton alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2, 30, 20, 20)];
    img1.layer.cornerRadius=7.5;
    [img1 addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
    [img1 setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    img1.tag=1;
    [scrollbar addSubview:img1];
    
    UILabel *Up_lbl=[[UILabel alloc]initWithFrame:CGRectMake(img1.frame.size.width+img1.frame.origin.x+8, 30, 100, 20)];
    Up_lbl.text=@"Upcoming";
    [Up_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    Up_lbl.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];
    [scrollbar addSubview:Up_lbl];
    
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake(35, Up_lbl.frame.size.height+Up_lbl.frame.origin.y+25,  scrollbar.frame.size.width/2 -40, 35)];
    submit.backgroundColor=[srt valueForKey:@"Yellowbtncolor"];
    [submit setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f]forState:UIControlStateNormal];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(SaveSortby:) forControlEvents:UIControlEventTouchUpInside];
    if(SortID==10)
    {
        submit.tag=0;
    }
    else if (SortID==11)
    {
        submit.tag=1;
    }
    else if (SortID==0)//podcast sort
    {
        submit.tag=2;
    }
    else if (SortID==1)//podcast shared sort
    {
        submit.tag=3;
    }
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [submit setClipsToBounds:YES];
    [scrollbar addSubview:submit];
    
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake(submit.frame.size.width+submit.frame.origin.x+5,Up_lbl.frame.size.height+Up_lbl.frame.origin.y+25,  scrollbar.frame.size.width/2 -40, 35);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    close.backgroundColor=[srt valueForKey:@"Yellowbtncolor"];
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, close.frame.size.height+close.frame.origin.y);

    
}
-(IBAction)toggleButton:(id)sender
{
    
    UIButton * btn=(UIButton*)sender;
    psort=(int)btn.tag;
    if(psort==0||psort==1)
    {
        [sender1 setImage:[UIImage imageNamed:@"radiounselect.png"]forState:UIControlStateNormal];
        sender1=sender;
        [sender setImage:[UIImage imageNamed:@"radioselect.png"]forState:UIControlStateNormal];
        
    }
    
}
-(IBAction)SaveSortby:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if(psort==0)
    {
        psort=1;
    }
    else if (psort==1)
    {
        psort=2;
    }
    
    iscallback=0;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setObject:[NSString stringWithFormat:@"%d",psort] forKey:@"val"];
    if ((int)btn.tag==0)
    {
        
        [[SavePrefrences sharedInstance].skthand emitData:@"SearchPod" :@"getPodSrch" :@"":@"":dic1 :self];
    }
    else if ((int)btn.tag==1)
    {
        [[SavePrefrences sharedInstance].skthand emitData:@"RecentPod" :@"getPodRecent" :@"":@"":dic1 :self];
    }
    
    else if ((int)btn.tag==2)//podcast sort
    {
        iscallback=6;
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"getPodcast" :@"":@"":dic1 :self];
    }
    
    else if ((int)btn.tag==3)//shared sort
    {
        iscallback=7;
        [[SavePrefrences sharedInstance].skthand emitData:@"SharedPod" :@"getSharedPod" :@"":@"":dic1 :self];
    }
    
}
-(void)AddNewLibrary:(UIViewController*)Vc
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    [self MainView:Vc :@"Add New Library"];
    
    scrollbar.frame=CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-10, [SavePrefrences sharedInstance ].screenWidth-40, 280);
    
    TitleEvent1=[[UITextField alloc]initWithFrame:CGRectMake(20, 10, scrollbar.frame.size.width-40, 35)];
    TitleEvent1.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    TitleEvent1.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
   // TitleEvent1.placeholder=@"Podcast Title ";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    TitleEvent1.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Podcast Title " attributes:@{NSForegroundColorAttributeName: color}];

    TitleEvent1.delegate=self;
    [TitleEvent1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    TitleEvent1.leftView = paddingView;
    TitleEvent1.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    [scrollbar addSubview:TitleEvent1];
    
    TitleContant=[[UITextField alloc]initWithFrame:CGRectMake(20, TitleEvent1.frame.size.height+TitleEvent1.frame.origin.y+15, scrollbar.frame.size.width-40, 35)];
    TitleContant.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    TitleContant.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
  //  TitleContant.placeholder=@" Podcast Content ";
    TitleContant.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Podcast Content " attributes:@{NSForegroundColorAttributeName: color}];

    TitleContant.delegate=self;
    [TitleContant setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////////
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    TitleContant.leftView = paddingView1;
    TitleContant.leftViewMode = UITextFieldViewModeAlways;
    ////////////

    [scrollbar addSubview:TitleContant];
    
    
    
    UIButton *btnGo= [[UIButton alloc]initWithFrame:CGRectMake(20,TitleContant.frame.size.height+TitleContant.frame.origin.y+40, 100, 30)];
    [btnGo setTitle: @"Upload Video" forState: UIControlStateNormal];
    btnGo.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [btnGo setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [btnGo addTarget:self action:@selector(addVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnGo setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    btnGo.tag=1;
    [scrollbar addSubview:btnGo];

   /* imggeter = [[UIImageView alloc] initWithFrame:CGRectMake(scrollbar.frame.size.width-150, TitleContant.frame.size.height+TitleContant.frame.origin.y+30, 70, 70)];
    imggeter.backgroundColor=[UIColor grayColor];
    [imggeter setImage:[UIImage imageNamed:@"userimage.jpg"]];
    [scrollbar addSubview:imggeter];*/

    
    UIButton *Save=[[UIButton alloc]initWithFrame:CGRectMake(35, btnGo.frame.size.height+btnGo.frame.origin.y+30, scrollbar.frame.size.width/2-40, 35)];
    [Save setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    Save.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [Save setTitle:@"Save" forState:UIControlStateNormal];
    [Save setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [Save addTarget:self action:@selector(saveNewVideo:) forControlEvents:UIControlEventTouchUpInside];
    [Save setClipsToBounds:YES];
    [scrollbar addSubview:Save];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(Save.frame.size.width+Save.frame.origin.x+5, btnGo.frame.size.height+btnGo.frame.origin.y+30, scrollbar.frame.size.width/2-40, 35)];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    close.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [close setClipsToBounds:YES];
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, scrollbar.frame.size.height);

}

-(IBAction)saveNewVideo:(id)sender
{
    
    
    iscallback=4;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setValue: TitleEvent1.text forKey:@"title"];
    [dic1 setValue:TitleContant.text forKey:@"cont"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyLibrary" :@"saveLib" :@"":@"":dic1 :self];
    
}


-(void)sortbylibrary:(UIViewController*)Vc
{
    [self MainView:Vc :@"Sort By"];
    
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y, scrollbar.frame.size.width, 150 );
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    UIButton *Title_btn =[[UIButton alloc]initWithFrame:CGRectMake(25, 20, 20, 20)];
    Title_btn.layer.cornerRadius=10;
// textfld bg 248:250:251
    Title_btn.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    [Title_btn addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
    [Title_btn setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    
    [scrollbar addSubview:Title_btn];
    
    title_label=[[UILabel alloc]initWithFrame:CGRectMake(Title_btn.frame.origin.x+Title_btn.frame.size.width+6, 20,80, 25)];
    title_label.text=@"Title";
    [title_label setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    title_label.textColor=[UIColor colorWithRed:183.0f/255 green:182.0f/255 blue:182.0f/255 alpha:1.0f];
    [scrollbar addSubview:title_label];
    
    UIButton *Submit=[[UIButton alloc]initWithFrame:CGRectMake(35, title_label.frame.size.height+title_label.frame.origin.y+10,scrollbar.frame.size.width/2 - 40, 35)];
    [Submit setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    Submit.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [Submit setTitle:@"Submit" forState:UIControlStateNormal];
    [Submit addTarget:self action:@selector(applylibsort:) forControlEvents:UIControlEventTouchUpInside];
    [Submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [Submit setClipsToBounds:YES];
    [scrollbar addSubview:Submit];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(Submit.frame.size.width+Submit.frame.origin.x+5, title_label.frame.size.height+title_label.frame.origin.y+10, scrollbar.frame.size.width/2-40, 35)];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    close.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [close setClipsToBounds:YES];
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, close.frame.size.height+close.frame.origin.y);
    
    
}

-(IBAction)applylibsort:(id)sender
{
    iscallback=5;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:@"1" forKey:@"val"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"MyLibrary" :@"getLib" :@"":@"":dic :self];
    
    
}

-(void)postpone:(UIViewController*)Vc:(int)ispost
{
    
    [self MainView:Vc :@"Update Date and Time of Podcast"];
    
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y,scrollbar.frame.size.width, 220 );
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    time=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, [SavePrefrences sharedInstance].screenWidth-60-15, 40)];
    time.textColor=[UIColor colorWithRed: 183.0f/255.0f green:182.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
    time.text=@" Enter Time";
    time.clipsToBounds=YES;
    time.tag=4;
    [time setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    time.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [scrollbar addSubview:time];
    
    UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(time:)];
    [prev setNumberOfTouchesRequired:1];
    [prev setDelegate:self];
    time.userInteractionEnabled = YES;
    [time addGestureRecognizer:prev];
    
    
    
    detail=[[UILabel alloc]initWithFrame:CGRectMake(20, time.frame.size.height+time.frame.origin.y+20,[SavePrefrences sharedInstance].screenWidth-60-15, 45)];
    detail.text=@" Enter Date";
    detail.textColor=[UIColor colorWithRed: 183.0f/255.0f green:182.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
    detail.clipsToBounds=YES;
    [detail setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    detail.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [scrollbar addSubview:detail];
    
    UITapGestureRecognizer *prev1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [prev1 setNumberOfTouchesRequired:1];
    [prev1 setDelegate:self];
    detail.tag=3;
    detail.userInteractionEnabled = YES;
    [detail addGestureRecognizer:prev1];
    
    
    
    UIButton *update=[[UIButton alloc]initWithFrame:CGRectMake(35, detail.frame.size.height+detail.frame.origin.y+20, scrollbar.frame.size.width/2-40, 35)];
    update.titleLabel.textColor=[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    update.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [update setTitle:@"Update" forState:UIControlStateNormal];
    [update setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [update addTarget:self action:@selector(postupdate:) forControlEvents:UIControlEventTouchUpInside];
    update.tag=ispost;
    [update setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    [update setClipsToBounds:YES];
    [scrollbar addSubview:update];
    
    UIButton *cancel=[[UIButton alloc]initWithFrame:CGRectMake(update.frame.size.width+update.frame.origin.x+5, detail.frame.size.height+detail.frame.origin.y+20, scrollbar.frame.size.width/2-40, 35)];
    cancel.titleLabel.textColor=[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    cancel.backgroundColor=[ff valueForKey:@"clearColor"];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255 green:49.0f/255 blue:99.0f/255 alpha:1.0f] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [cancel setClipsToBounds:YES];
    [scrollbar addSubview:cancel];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, scrollbar.frame.size.height);
    
}
-(IBAction)postupdate:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    iscallback=8;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:time.text forKey:@"time"];
    [dic setValue:detail.text forKey:@"da"];
    [dic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"pId"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"updatePod" :@"" :@"" :dic :self];
}


-(IBAction)chooseOption:(id)sender
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
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}

-(void) openCamera
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [vc1 presentViewController:imagePickerController animated:YES completion:nil];
        }];
    }
    else{
        
        [vc1 presentViewController:imagePickerController animated:YES completion:nil];
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
        [vc1 presentModalViewController:imagePicker animated:YES];
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
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Loading...." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
    
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData* data = UIImageJPEGRepresentation(outputImage, 1.0f);
    imgBuffer= [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [picker dismissViewControllerAnimated:YES completion:nil];
    randomImgName = [self randomImagName];
    
    imggeter.image = outputImage;
    
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    
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


-(void) selectInduct
{
    iscallback=2;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getInd" :@"":@"":dic1 :self];
}

-(void) showInd

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
                                            Select_Industry.text=stname;
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}
-(void)selecSubInd
{
    iscallback=3;
    if([av checkCombo:Select_Industry])
    {
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[NSString stringWithFormat:@"%@",indid] forKey:@"inid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getDep" :@"":@"":dic1 :self];
    }
}
-(void) showSubInd

{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@"Select Sub Industry:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[subdataind count];x++)
    {
        
        NSString *subname=[[subdataind valueForKey:@"topic_name"] objectAtIndex:x];
        NSString *subindid=[[subdataind valueForKey:@"t_id"] objectAtIndex:x];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:subname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            subid=subindid;
                                            Select_Sub_Industry.text=subname;
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
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
    [datepicker setValue:[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forKey:@"textColor"];
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
    save.backgroundColor=[UIColor grayColor];
    [save addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [datePickerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor grayColor];
    [cancel addTarget:self action:@selector(nook:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
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
    [timepicker setValue:[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forKey:@"textColor"];
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
    [save setTitleColor:[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [datePickerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, timepicker.frame.size.height+timepicker.frame.origin.y, 70, 30)];
    [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor grayColor];
    [cancel addTarget:self action:@selector(nook:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
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
        
        CurrentDate.text = [NSString stringWithFormat:@"  %@", [df stringFromDate:datepicker.date]];
    }
    if(tid==1)
    {
        StartTime.text=[NSString stringWithFormat:@"%@",[tm stringFromDate:timepicker.date]];
    }
    if(tid==3)
    {
        detail.text = [NSString stringWithFormat:@"  %@", [df stringFromDate:datepicker.date]];
    }
    if(tid==4)
    {
        time.text=[NSString stringWithFormat:@"  %@",[tm stringFromDate:timepicker.date]];
    }
    else{
        
        
    }
    [timepicker removeFromSuperview];
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
    
}


-(IBAction)nook:(id)sender
{
    [timepicker removeFromSuperview];
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
}


//load video


-(IBAction)addVideo:(id)sender
{
    
    NSLog(@"select Video");
    
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    NSMutableArray *xy =[[NSMutableArray alloc]init];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    void (^assetEnumerator)
    (ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil)
        {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                NSLog(@"result is:%@",result);
                NSLog(@"asset URLDictionary is:%@",assetURLDictionaries);
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                
                [library assetForURL:url
                         resultBlock:^(ALAsset *asset)
                 {
                     [xy addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                     NSLog(@" xy is:%@",xy);
                     UIImageView  *image =[ [UIImageView alloc ] initWithImage:[xy objectAtIndex:0]];
                     NSLog(@"image is:%@",image);
                 }
                        failureBlock:^(NSError *error){ NSLog(@"test:Fail"); } ];
            }
        }
    };
    
    
    
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop){
                if (asset){
                    
                    NSDictionary *meta = [[asset defaultRepresentation] metadata];
                    
                }
            }];
        }
    }
                         failureBlock:^(NSError *error)
     {
         NSLog(@"error enumerating AssetLibrary groups %@\n", error);
     }];
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
        [cb callMethod:backdata];
        
    }
}
-(IBAction)cancel:(id)sender
{
    NSLog(@"hello world ");
    
    [self dissmisspop];
    
}
-(void) callBack:(NSArray *)META  :(NSArray *)DATA
{
    
    NSLog(@"meta=====%@",META);
    NSLog(@"data=====%@",DATA);
    
    
    if(iscallback==0)
    {
        backdata=[[NSMutableArray alloc]init];
        [backdata addObject:@"usortby"];
        [backdata addObject:DATA];
        [self dissmisspop];
    }
    else if(iscallback==2)
    {
        dataind=DATA;
        [self showInd];
    }
    else if(iscallback==3)
    {
        subdataind=DATA;
        [self showSubInd];
    }
    
    else if(iscallback==4)
    {
        NSLog(@"inside 4");
        
    }
    
    else if(iscallback==5)
    {
        NSLog(@"sort by lib data%@",DATA);
        backdata=[[NSMutableArray alloc]init];
        [backdata addObject:@"libsort"];
        [backdata addObject:DATA];
        [self dissmisspop];
    }
    
    else if(iscallback==6)
    {
        NSLog(@"podcast sort by  data%@",DATA);
        backdata=[[NSMutableArray alloc]init];
        [backdata addObject:@"podcastsort"];
        [backdata addObject:DATA];
        [self dissmisspop];
        
        
    }
    
    else if(iscallback==7)
    {
        NSLog(@" posd sort by  data%@",DATA);
        backdata=[[NSMutableArray alloc]init];
        [backdata addObject:@"podsharedsort"];
        [backdata addObject:DATA];
        [self dissmisspop];
        
    }
    else if (iscallback==8)
    {
        NSArray *dd=[META valueForKey:@"data"];
        NSArray *new= [dd valueForKey:@"pod"];
        NSString *val=[new valueForKey:@"affectedRows"];
        if([val intValue]>0)
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Successfully Updated" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
            backdata=[[NSMutableArray alloc]init];
            [backdata addObject:@"podcastpostpone"];
            [backdata addObject:dd];
            [self dissmisspop];
            
            
            
        }
        else{
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Not updated" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alrt show];
        }
    }
    
    
}

@end
