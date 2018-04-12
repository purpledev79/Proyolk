
#import "Storage.h"
#import "SavePrefrences.h"
#import "LeftRightDrawer.h"
#import "BoardPopUp.h"
#import "Podcast.h"
#import "popups.h"
#import "PodcastPopUp.h"
#import "StoragePopUp.h"
#import "AllValidationsViewController.h"
#import "MainController.h"
#import "ManageArray.h"
#import "UIImageView+WebCache.h"


@interface Storage ()
{
    
    id sender1;
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIView *actionView,*middle_label,*option,*main,*podcast_details,*main1,*base,*prMainView;
    UIScrollView *scrollbar;
    NSMutableArray *popUpAr;
    UITextField *search_lbl;
    UIImageView *searchbutton;
    UIAlertView *alrt;
    UILabel *Inbox_bar1,*Inbox_bar2,*Myfiles_bar1, *Myfiles_bar2,*NameLabel1;
    AllValidationsViewController *av;
    ManageArray *mang;
    int iscallback;
    NSArray *upcomAr,*rcntAr,*inboxAr;
    int limit,cellheight,fileindex;
    LeftRightDrawer *drawer;
    StoragePopUp *stpop;
    MainController *vc1;
    NSMutableArray *strAr;
    int isnoti;
    NSMutableArray *barAr;
    NSMutableArray * colorAr;
    
    
}

@end

@implementation Storage

@synthesize InboxtableView,notificationTable;

- (void)viewDidLoad
  {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    naviWidth = self.navigationController.navigationBar.frame.size.width;
    naviHght =  self.navigationController.navigationBar.frame.size.height;
    stbarHght= (float)[[UIApplication sharedApplication] statusBarFrame].size.height;
    
      dictFilter = [NSMutableDictionary dictionary];
    [SavePrefrences sharedInstance].screenHeight=screenHeight;
    [SavePrefrences sharedInstance].screenWidth=screenWidth;
    [SavePrefrences sharedInstance].naviHght=naviHght;
    [SavePrefrences sharedInstance].naviWidth=naviWidth;
    [SavePrefrences sharedInstance].stbarHght=stbarHght;
    [SavePrefrences sharedInstance].textsize=18;
    
      mang=[[ManageArray alloc]init];
      
    drawer=[[LeftRightDrawer alloc]init];
    stpop=[[StoragePopUp alloc]init];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self customizeActionBar];
    
     
}



-(void)customizeActionBar
{
    
   [drawer initArs:self];
    main=[[UIView alloc]initWithFrame:CGRectMake(0,70, screenWidth, screenHeight)];
    main.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    [self.view addSubview:main];
    [self setTabBar];

}
-(void)retrieveInbox
{
    
    iscallback=1;
     NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"getInbox" :@"":@"":dic1 :self];
    
}


-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{
    av=[[AllValidationsViewController alloc]init];
    
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:132.0f/255.0f green:132.0f/255.0f blue:132.0f/255.0f alpha:.5f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    NameLabel1=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-40, 50)];
    NameLabel1.text=title;
    NameLabel1.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
    NameLabel1.font=[UIFont systemFontOfSize:14];
    NameLabel1.textColor=[UIColor blackColor];
    NameLabel1.layer.cornerRadius=5;
    NameLabel1.textAlignment=NSTextAlignmentCenter;
    [prMainView addSubview:NameLabel1];
    
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    scrollbar.backgroundColor=[UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    [prMainView addSubview:scrollbar];
    
    
    return prMainView;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)retrieveInbox1:(UIGestureRecognizer *)ges
{
    
    int idd=(int)ges.view.tag;
    if(idd==0)
    {
        [self showNotification];
    }
    else if(idd==1)
    {
        
      if(isnoti==3)
      {
      iscallback=1;
      NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
      [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
      [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"getInbox" :@"":@"":dic1 :self];
      }
        else if(isnoti==2)
        {
            [self openMyFiles];
        }
        
    }
    else if(idd==2)
    {
        [self openMyFiles];
    }
    if(idd==0 ||idd==1)
    {
        for(int x=0;x<[barAr count];x++)
        {
            UILabel * lbl=[barAr objectAtIndex:x];
            if(x==(int)idd)
            {
                //  lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
                lbl.backgroundColor=[colorAr objectAtIndex:x];
            }
            else
            {
                //  lbl.backgroundColor=[colorAr objectAtIndex:x];
                lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
            }
        }
    }
    
    if (barAr.count == 2 )
    {
        NSLog(@"[barAr count]....%lu",(unsigned long)[barAr count]);
        if(idd==0 ||idd==1)
        {
            for(int x=0;x<[barAr count];x++)
            {
                UILabel * lbl=[barAr objectAtIndex:x];
                if(x==(int)idd)
                {
                      lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
                   // lbl.backgroundColor=[colorAr objectAtIndex:x];
                }
                else
                {
                    lbl.backgroundColor=[colorAr objectAtIndex:x];
                   // lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
                }
            }
        }
        
    }

    NSLog(@"[barAr count]....%lu",(unsigned long)[barAr count]);
    NSLog(@"idd....%lu",(unsigned long)idd);

    if(idd==2)
    {
            NSLog(@"[barAr count]-----%lu",(unsigned long)[barAr count]);

            for(int x=0;x<[barAr count];x++)
            {
                //here
                UILabel * lbl=[barAr objectAtIndex:1];
                if(x==(int)idd)
                {
                    lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
                    // lbl.backgroundColor=[colorAr objectAtIndex:1];
                }
                else
                {
                    lbl.backgroundColor=[colorAr objectAtIndex:1];
                    // lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
                }
                
                
                UILabel * lbl1=[barAr objectAtIndex:0];
                if(x==(int)idd)
                {
                    //  lbl1.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
                    lbl1.backgroundColor=[colorAr objectAtIndex:0];
                }
                else
                {
                    //   lbl1.backgroundColor=[colorAr objectAtIndex:0];
                    lbl1.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
                }
        }
    }
}




-(void) setTabBar
{
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    option=[[UIView alloc]initWithFrame:CGRectMake(0,0, screenWidth, 45)];
    option.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [main addSubview:option];
    
    UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(0, option.frame.size.height-2, option.frame.size.width, 2)];
    lblline.backgroundColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
    [option addSubview:lblline];

    
    colorAr=[[NSMutableArray alloc]init];
    NSMutableArray * notiAR=[[NSMutableArray alloc]init];
    
    barAr=[[NSMutableArray alloc]init];
    strAr=[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"24"];
   
   
    for(NSInteger i = (int)strAr.count - 1; i >= 0 ; i--)
      {
        NSString * time=[[strAr valueForKey:@"time"] objectAtIndex:i];
        NSString * ntc= [[strAr valueForKey:@"ntc"] objectAtIndex:i];
        
        //if(([ntc intValue]==11)||([ntc intValue]==12)||([ntc intValue]==13)||([ntc intValue]==14)||([ntc intValue]==15))
        {
            if([[[SavePrefrences sharedInstance].notiWithoutADR allKeys] containsObject:time])
            {
                [strAr removeObjectAtIndex:i];
            }
            else
            {
                [[SavePrefrences sharedInstance].notiWithoutADR setValue:time forKey:time];
            }
        }
    }

    isnoti=2;
    int wid=option.frame.size.width/2;
    if([strAr count]>0)
    {
        isnoti=3;
        wid=option.frame.size.width/3;
        /*[colorAr addObject:[UIColor blackColor]];
        [colorAr addObject:[ff valueForKey:@"Profcolor"]];
        [colorAr addObject:[ff valueForKey:@"Educolor"]];*/
        [colorAr addObject:[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f]];
        [colorAr addObject:[UIColor colorWithRed:52.0f/255.0f green:127.0f/255.0f blue:103.0f/255.0f alpha:1.0f]];
        [colorAr addObject:[UIColor colorWithRed:108.0f/255.0f green:114.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];

        [notiAR addObject:@"Notifiction"];
        [notiAR addObject:@"Inbox"];
        [notiAR addObject:@"My Files"];
        
    }
    else
    {
       /* [colorAr addObject:[ff valueForKey:@"Profcolor"]];
        [colorAr addObject:[ff valueForKey:@"Educolor"]];*/
        
        [colorAr addObject:[UIColor colorWithRed:52.0f/255.0f green:127.0f/255.0f blue:103.0f/255.0f alpha:1.0f]];
        [colorAr addObject:[UIColor colorWithRed:108.0f/255.0f green:114.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];

        [notiAR addObject:@"Inbox"];
        [notiAR addObject:@"My Files"];
        isnoti=2;
    }
    
    int spx=0;
    for(int x=0;x<isnoti;x++)
    {
        
        UILabel *Inbox=[[UILabel alloc]initWithFrame:CGRectMake(spx, 0, wid, 40)];
        Inbox.text=[notiAR objectAtIndex:x];
        NSLog(@"text is====%@",[notiAR objectAtIndex:x]);
        Inbox.textAlignment=NSTextAlignmentCenter;
        [Inbox setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        Inbox.backgroundColor=[ff valueForKey:@"backcolor"];
        Inbox.textColor=[colorAr objectAtIndex:x];//[ff valueForKey:@"Videocolor"];
        [option addSubview:Inbox];
        
        UITapGestureRecognizer *Myinbox = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retrieveInbox1:)];
        [Myinbox setNumberOfTouchesRequired:1];
        [Myinbox setDelegate:self];
        Inbox.userInteractionEnabled = YES;
        Inbox.tag=x;
        [Inbox addGestureRecognizer:Myinbox];
        
        Inbox_bar1=[[UILabel alloc]initWithFrame:CGRectMake(spx, Inbox.frame.size.height+Inbox.frame.origin.y, wid, 4)];
        [option addSubview:Inbox_bar1];
        [barAr addObject:Inbox_bar1];
     
        if(x==0)
        {
            Inbox_bar1.backgroundColor=[colorAr objectAtIndex:x];
        }
        else{
            Inbox_bar1.backgroundColor=[ff valueForKey:@"backcolor"];
        }
        spx=wid+spx;
        
    }
    
  if(isnoti==2)
    {
        [self retrieveInbox];
     }
    else if(isnoti==3)
    {
        [self showNotification];
    }
    
}
-(void)searchInbox
{
    
    iscallback=3;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setObject:search_lbl.text forKey:@"fileName"];
    [dic1 setObject:@"all" forKey:@"type"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"searchFiles" :@"" :@"" :dic1 :self ];
}


-(void)showNotification
{
    [SavePrefrences sharedInstance].ischkstor=@"1";
    
    [middle_label removeFromSuperview];
    [InboxtableView removeFromSuperview];
    notificationTable = [[UITableView alloc] initWithFrame:CGRectMake(0,option.frame.origin.y+option.frame.size.height,main.frame.size.width,main.frame.size.height-(option.frame.origin.y+option.frame.size.height+75))];
   notificationTable.delegate = self;
   notificationTable.dataSource = self;
   notificationTable.scrollEnabled = YES;
   notificationTable.separatorColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey: @"backcolor"];
   notificationTable.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey: @"backcolor"];
   [main addSubview:notificationTable];

}


-(void)showInbox
{
    
    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, option.frame.size.height+option.frame.origin.y, screenWidth, 40)];
    middle_label.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [main addSubview:middle_label];

    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, -3, screenWidth, 1)];
    line1.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
   // [middle_label addSubview:line1];
    
    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(5, 3.5, middle_label.frame.size.width-130, middle_label.frame.size.height-7)];
    search_lbl.backgroundColor=[UIColor colorWithRed:225.0f/255.0f green:232.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
    search_lbl.placeholder=@"File name or size";
    search_lbl.delegate=self;
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = paddingView;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
     [search_lbl addTarget:self action:@selector(searchInbox) forControlEvents:UIControlEventEditingChanged];
    ////////////

    [middle_label addSubview:search_lbl];
    
    
    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(middle_label.frame.size.width-108, 3.5, 30,30)];
    searchbutton.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    searchbutton.tag=3;
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *sworkingreg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchInbox)];
    [sworkingreg1 setNumberOfTouchesRequired:1];
    [sworkingreg1 setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:sworkingreg1];
    
    UIImageView *Filter=[[UIImageView alloc]initWithFrame:CGRectMake(middle_label.frame.size.width-70, 3.5, 28, 28)];
    Filter.image=[UIImage imageNamed:@"filtericon1.png"];
    [middle_label addSubview:Filter];
    
    UIImageView *up_dwn_arrow=[[UIImageView alloc]initWithFrame:CGRectMake(middle_label.frame.size.width-35, 3.5, 28, 28)];
    up_dwn_arrow.image=[UIImage imageNamed:@"newsortby1.png"];
    [middle_label addSubview:up_dwn_arrow];
    
    
    UITapGestureRecognizer *myfiltergesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openfilterpop)];
    [myfiltergesture1 setNumberOfTouchesRequired:1];
    [myfiltergesture1 setDelegate:self];
    Filter.userInteractionEnabled = YES;
    [Filter addGestureRecognizer:myfiltergesture1];
    
    UITapGestureRecognizer *updwngesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(up_dwn_pop)];
    [updwngesture setNumberOfTouchesRequired:1];
    [updwngesture setDelegate:self];
    up_dwn_arrow.userInteractionEnabled = YES;
    [up_dwn_arrow addGestureRecognizer:updwngesture];

    
    float hight= middle_label.frame.size.height+middle_label.frame.origin.y;
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
  
    if(hight==0)
     {
      InboxtableView = [[UITableView alloc] initWithFrame:CGRectMake(0,hight,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height+40)];
     }
    else
     {
      InboxtableView = [[UITableView alloc] initWithFrame:CGRectMake(0,hight,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height)];
     }
    InboxtableView.delegate = self;
    InboxtableView.dataSource = self;
    InboxtableView.scrollEnabled = YES;
    InboxtableView.separatorColor=[ff valueForKey:@"backcolor"];
    InboxtableView.backgroundColor=[ff valueForKey:@"backcolor"];
    [main addSubview:InboxtableView];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return cellheight;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if(theTableView==InboxtableView)
    {
        cellheight=100;
        return [inboxAr count];
    }
    if(theTableView==notificationTable)
    {
         cellheight=95;
         return [strAr count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
   {
       NSLog(@"Inbox File Check===========%@",@"File Check===========%@");

    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.InboxtableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
       @try
         {
        NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry ;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor=[ff valueForKey:@"backcolor"];
             if(theTableView==notificationTable)
             {
                 UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(10, 2, self.view.frame.size.width, cellheight)];
                 cell_View.backgroundColor=[UIColor clearColor];
                 [cell addSubview: cell_View];
                 
                 
                 NSString * uname=[[strAr objectAtIndex:indexPath.row] valueForKey:@"uname"];
                 NSString * noti_id=[[strAr objectAtIndex:indexPath.row] valueForKey:@"noti_id"];
                 NSString * time=[[strAr objectAtIndex:indexPath.row] valueForKey:@"time"];
                 NSString * img=[[strAr objectAtIndex:indexPath.row] valueForKey:@"img"];

                 [[SavePrefrences sharedInstance].isAlViedDic setValue:noti_id forKey:noti_id];
                 
                 NSArray * jsonObject=[mang convertojson:[strAr objectAtIndex:indexPath.row]];
                 
                 
                 UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(3, cell_View.frame.size.height/2-20, 40, 40)];
              //   [userpic setImage:[UIImage imageNamed:@"user.png"]];
                 userpic.layer.cornerRadius=20;
                 userpic.clipsToBounds=YES;
                 [cell_View addSubview:userpic];

               //  NSString * url=[manag concatUrl:img];
                     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
                         //set your image on main thread.
                         dispatch_async(dispatch_get_main_queue(), ^{
                             if(img.length<12)
                             {
                                 userpic.image = [UIImage imageNamed:@"username.png"];
                             }
                             else
                             {
                                 if(imageData.length<=0)
                                     userpic.image =[UIImage imageNamed:@"username.png"];
                                 else
                                     userpic.image = [UIImage imageWithData:imageData];
                                 
                             }
                         });
                     });
                 
                 UILabel *time1=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, cell_View.frame.size.width-20,15)];
                 time1.text=[mang timeConverter:time];
                 time1.textColor=[UIColor blackColor];
                 [time1 setFont:[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:12]];
                 time1.textAlignment=NSTextAlignmentRight;
                 time1.backgroundColor=[UIColor clearColor];
                 [cell_View addSubview:time1];
                 

                 UITextView *line_lbl=[[UITextView alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, time1.frame.size.height+time1.frame.origin.y+5, cell_View.frame.size.width-userpic.frame.size.width+userpic.frame.origin.x+5-10, 36)];
                 line_lbl.backgroundColor=[UIColor clearColor];
                 line_lbl.font=[UIFont systemFontOfSize:13];
                 line_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
                 line_lbl.userInteractionEnabled=NO;
                 line_lbl.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
                 [cell_View addSubview:line_lbl];
                 
                 if([mang checkContaine:jsonObject])
                 {
                     NSString *tit= [jsonObject valueForKey:@"title"];
                     line_lbl.text= [[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc24] stringByAppendingString:tit];;
                 }
                 else
                 {
                     line_lbl.text= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc24];
                 }
                 
                 if(mang==nil)
                     mang=[[ManageArray alloc]init];
                 
                 
                 
                 //here
                 NSString *yourString = line_lbl.text;//@"This is to be bold. This is normal string.";
                 NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
                 NSString *boldString = uname;//@"This is to be bold";
                 NSRange boldRange = [yourString rangeOfString:boldString];
                 [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:boldRange];
                 [line_lbl setAttributedText: yourAttributedString];
                 
                 if ([yourString hasPrefix:@"You"])
                 {
                     NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:line_lbl.text];
                     [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] range:NSMakeRange(0, [line_lbl.text length])];
                     line_lbl.attributedText = string;
                     
                 }
                 else
                 {
                     NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:line_lbl.text];
                     [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f] range:NSMakeRange(0,[boldString length])];
                     [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] range:NSMakeRange([boldString length],[line_lbl.text length]-[boldString length])];
                     line_lbl.attributedText = string;
                     
                     
                 }

                 
                 
                 
                 
                 
                 UIButton *btnChat = [[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-50,line_lbl.frame.size.height+line_lbl.frame.origin.y+3, 22,22)];
                 btnChat.backgroundColor= [UIColor clearColor];
                 [btnChat setBackgroundImage:[UIImage imageNamed:@"chatNew.png"] forState:UIControlStateNormal];
                 btnChat.layer.cornerRadius=5;
                 btnChat.tag=0;
                 [cell_View addSubview:btnChat];
                 
                 NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                 [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
                 [dic setObject:@"bd" forKey:@"aid"];
                 NSMutableArray * ar=[[NSMutableArray alloc]init];
                 [ar addObject:noti_id];
                 [dic setObject:ar forKey:@"notiIds"];
                 [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
                 
                 UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(40,cell_View.bounds.size.height-2,cell_View.bounds.size.width,1)];
                 separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
                 [cell addSubview:separator];

                 return cell;
                 
             }
             else if(theTableView==InboxtableView)
             {
                 UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(1, 5, self.view.frame.size.width+20, 100)];
                 cell_View.backgroundColor=[UIColor clearColor];
                 [cell addSubview: cell_View];
                 {
                     
                     NSString *file_name=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"file_name"];
                     NSString *file_ext=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"file_ext"];
                     NSString *file_id=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"file_id"];
                     NSString *file_name1=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"file_name1"];
                     
                     NSString *folder_id=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"folder_id"];
                     NSString *imge=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"imge"];
                     NSString *logtime=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"timelog"];
                     NSString *size=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"size"];
                     NSString *u_id=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"u_id"];
                     NSString *uname=[[inboxAr objectAtIndex:indexPath.row] valueForKey:@"uname"];

                     UIImageView *pic=[[UIImageView alloc] initWithFrame:CGRectMake(10, (cell_View.frame.size.height/2)-30, 30, 34)];
                     [cell_View addSubview: pic];
                     if ([file_ext containsString:@"mp4"] || [file_ext containsString:@"fav"]) {
                         pic.image = [UIImage imageNamed:@"videoicon.png"];
                     }
                     else if ([file_ext containsString:@"jpg"] || [file_ext containsString:@"jpeg"]|| [file_ext containsString:@"png"]|| [file_ext containsString:@"gif"]) {
                         pic.image = [UIImage imageNamed:@"pictureicn.png"];
                     }
                     else  {
                         pic.image = [UIImage imageNamed:@"docicon.png"];
                     }
                     UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(pic.frame.size.width+pic.frame.origin.x+6, (cell_View.frame.size.height/2)-30, cell_View.frame.size.width-pic.frame.size.width+pic.frame.origin.x+2-120, 20)];
                     title.backgroundColor=[UIColor clearColor];
                     title.text=file_name;
                     [title setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13.5]];
                     [cell_View addSubview:title];
                     UILabel *bytes=[[UILabel alloc] initWithFrame:CGRectMake(pic.frame.size.width+pic.frame.origin.x+6, title.frame.size.height+title.frame.origin.y, 80, 15)];
                     bytes.text=[size stringByAppendingString:@" bytes"];
                     bytes.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
                     [bytes setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
                     [cell_View addSubview:bytes];
                     
                     UIButton *checkpoint=[[UIButton alloc] initWithFrame:CGRectMake(title.frame.size.width+40,(cell_View.frame.size.height/2)-35, 35, 35)];
                      [checkpoint setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
                       [checkpoint addTarget:self action:@selector(Tick:) forControlEvents:UIControlEventTouchUpInside];
                         checkpoint.tag=indexPath.row;
                        [cell_View addSubview:checkpoint];
                     
                     
                     base=[[UIView alloc]initWithFrame:CGRectMake(0, main.frame.size.height-115, main.frame.size.width, 60)];
                     base.backgroundColor=[ff valueForKey:@"backcolor"];
                     base.hidden=true;
                     [main addSubview: base];
                     
                     NSMutableArray *picAr=[[NSMutableArray alloc]init];
                     
                    
                     [picAr addObject:@"move11.png"];
                     [picAr addObject:@"resume_download.png"];
                     [picAr addObject:@"deleteblack.png"];

                     
                     int xinc=30;
                     int wid=(base.frame.size.width)/3;
                     for(int x=0;x<3;x++)
                     {
                         UIImageView *pic=[[UIImageView alloc] initWithFrame:CGRectMake(xinc, 0, 30, 30)];
                         pic.image=[UIImage imageNamed:[picAr objectAtIndex:x]];
                         pic.tag=x;
                         [base addSubview: pic];
                         
                         xinc=xinc+wid;
                         
                         UITapGestureRecognizer *myFldr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectOption:)];
                         [myFldr setNumberOfTouchesRequired:1];
                         [myFldr setDelegate:self];
                         pic.userInteractionEnabled = YES;
                         [pic addGestureRecognizer:myFldr];
                         
                     }
                     UILabel *lbldate=[[UILabel alloc] initWithFrame:CGRectMake(pic.frame.size.width+pic.frame.origin.x+6, (pic.frame.size.height)+20, (cell_View.frame.size.width/2)-10, 20)];
                     lbldate.text=[NSString stringWithFormat:@"%@",logtime];
                     lbldate.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
                     [lbldate setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
                     lbldate.textAlignment=NSTextAlignmentLeft;
                     [cell_View addSubview:lbldate];
                     
                     UILabel *bharedBy=[[UILabel alloc] initWithFrame:CGRectMake(0, (pic.frame.size.height)+20, cell_View.frame.size.width-30, 20)];
                     bharedBy.text=[NSString stringWithFormat:@"Shared By: %@",uname];
                     bharedBy.textColor=[UIColor blackColor];
                     [bharedBy setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
                     bharedBy.textAlignment=NSTextAlignmentRight;
                     [cell_View addSubview:bharedBy];

                     
                     return cell;}
             }

                 }
    @catch (NSException *exception)
    {
        NSLog(@"exception is===%@",exception);
    }
    @finally {
    }
    return  cell;
}

-(IBAction)Tick:(id)sender
{
    
    NSLog(@"File Check===========%@",@"File Check===========%@");

    UIButton *resultButton = (UIButton *)sender;
    fileindex=(int)resultButton.tag;
    
    //radioselect.png
    //radiounselect.png
    if([[resultButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"radiounselect.png"]])
    {
        [sender1 setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"radioselect.png"] forState:UIControlStateNormal];
        base.hidden=false;
        InboxtableView.frame =CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height-200);
        sender1=sender;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
        base.hidden=true;
        InboxtableView.frame =CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height);
        
        
    }
}

-(void)SelectOption:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    if((int)tg.view.tag==0)
    {
        NSLog(@"moving");
        stpop.fileid=[[inboxAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        stpop.filename=[[inboxAr objectAtIndex:fileindex] valueForKey:@"file_name"];
         stpop.uid_from= [[inboxAr objectAtIndex:fileindex] valueForKey:@"imge"];
        [stpop moveto:self];
    }
    else if((int)tg.view.tag==1)
    {
        NSLog(@"Downloadingrrr");
        NSString *strId = [NSString stringWithFormat:@"%ld",[[[inboxAr objectAtIndex:fileindex]valueForKey:@"u_id_from"]integerValue]];
        NSString *path= [[inboxAr objectAtIndex:fileindex]valueForKey:@"file_name"];
        [self downloadImg:path user:strId];
    }
    else if((int)tg.view.tag==2)
    {
        NSLog(@"delete file");
        alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete ? " delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alrt show];
        [self alertView:alrt clickedButtonAtIndex:2];
    }
}

-(void)downloadImg:(NSString *)path1 user:(NSString *)strId
{
    NSLog(@"path isssss====%@",path1);
    NSString *path=@"";
    if(![path1 containsString:@"/"])
    {
        NSString *upload= [[[SavePrefrences sharedInstance].skthand btkurl] stringByAppendingString:[NSString stringWithFormat:@"%@/",@"upload"]];
        NSString *upload1= [upload stringByAppendingString:strId];
        NSString *upload2= [upload1 stringByAppendingString:[NSString stringWithFormat:@"/%@/",@"storage"]];
        path= [upload2 stringByAppendingString:path1];
        NSLog(@"final pathdd=======%@",path);
        //SplashScreen.url + “/upload/”+ storage.get(position).u_id_from + “/storage/”+ storage.get(position).file_name
    }
    else
    {
        ManageArray  *marr=[[ManageArray alloc]init];
        path=[marr concatUrl:path1];
    }
    
    
    
    
    NSURL  *url=[NSURL URLWithString:path];
    NSData *urldta=[NSData dataWithContentsOfURL:url];
    if(urldta)
    {
        NSArray *pathAr=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docdirectory=[pathAr objectAtIndex:0];
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", docdirectory,@"filename.png"];
        [urldta writeToFile:filePath atomically:YES];
        NSLog(@"filepath is === %@",filePath);
        NSData *pdfData = [NSData dataWithContentsOfFile:filePath];
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[ pdfData] applicationActivities:nil];
        [self presentViewController:activityViewController animated:YES completion:nil];
        
        
    }
    else
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Download Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        
    }
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1)
    {
        NSLog(@"ok");
        iscallback=2;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        
        NSString * fileid1= [[inboxAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        
        [dic1 setObject:fileid1 forKey:@"flId"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyFiles" :@"delSharedFile" :@"" :@"" :dic1 :self ];
    }
    else if(buttonIndex==0)
    {
        NSLog(@"cancel");
        [alrt dismissWithClickedButtonIndex:0 animated:YES];
        
    }
}

-(void)openMyFiles
{
    iscallback=0;
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:@"0" forKey:@"cs"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyFiles" :@"getAllFiles" :@"":@"":dic :self];
    
}
-(void)openfilterpop
{
    
    [stpop filterpopup:self dictFilter:dictFilter];
    
}
-(void)up_dwn_pop
{
    [stpop sortedfilter:self dictFilter:dictFilter];
    
}

-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    NSLog(@"Storage_data=========%@",data);
    NSLog(@"Storage_meta=========%@",meta);
    
    
    if(iscallback==0)
    {
        [stpop showMyfileView:self:data];
    }
    else if (iscallback==1)
    {
        
        inboxAr=data;
        [self showInbox];
    }
    else if (iscallback==2)
    {
        //
        if([data valueForKey:@"affectedRows"]>0)
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted Successfully!!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
            
            [self retrieveInbox];
        }
    }
    else if (iscallback==3)
    {
        inboxAr=data;
        if([inboxAr count]>0)
        {
            [InboxtableView reloadData];
        }
        else{
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Oops!No New Result Found  " delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alrt show];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) callMethod:(NSArray *)meta
{
    NSString * chk=[meta objectAtIndex:0];
    
    NSLog(@"Valuuuuuuuuuu===%@",meta);
    NSLog(@"COUNT IS %lu",[meta count]);
    if([meta count]>1)
    {
        
        NSMutableArray * ar=[meta objectAtIndex:1];
        
        if([ar count]>0)
        {
            if([chk isEqual:@"FilteredData"])
            {
                 dictFilter = [meta lastObject];
                inboxAr=ar;
                [InboxtableView reloadData];
            }
            else  if([chk isEqual:@"Sorteddata"])
            {
                inboxAr=ar;
                [InboxtableView reloadData];
            }
            
            else  if([chk isEqual:@"reteriveInbox"])
            {
                [self retrieveInbox];
            }
            
            
            
        }
        else{
            if([chk isEqual:@"FilteredData"])
            {
                dictFilter = [meta lastObject];

                inboxAr=[NSMutableArray array];
                [InboxtableView reloadData];
            }
            else  if([chk isEqual:@"Sorteddata"])
            {
                inboxAr=[NSMutableArray array];;
                [InboxtableView reloadData];
            }
            
            else  if([chk isEqual:@"reteriveInbox"])
            {
                [self retrieveInbox];
            }
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Oops! No New Result Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alrt show];
        }
    }
}
@end
