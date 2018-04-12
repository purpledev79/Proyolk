//
#import "Support.h"
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
#import "TechSupportController.h"


@interface Support ()
{
    
    id sender1;
//    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
//    UIView *actionView,*middle_label,*option,*main,*podcast_details,*main1,*base,*prMainView;
    UIScrollView *scrollbar;
    NSMutableArray *popUpAr;
    UITextField *search_lbl;
    UIImageView *searchbutton;
    UIAlertView *alrt;
    UILabel *Inbox_bar1,*Inbox_bar2,*Myfiles_bar1, *Myfiles_bar2,*NameLabel1;
    //AllValidationsViewController *av;
    ManageArray *mang;
 //   int iscallback;
//    NSArray *upcomAr,*rcntAr,*inboxAr;
    int limit,cellheight,fileindex;
    LeftRightDrawer *drawer;
    StoragePopUp *stpop;
    //MainController *vc1;
    NSMutableArray *strAr;
    int isnoti;
    NSMutableArray *barAr;
    NSMutableArray * colorAr;
    NSMutableArray *arrSection;
    
}


@end

@implementation Support

@synthesize InboxtableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
          arrSection = [NSMutableArray array];
          NSMutableArray *arrData = [NSMutableArray arrayWithArray:@[@"Contact Us",@"Tech & Support",@"Feedback"]];
          NSMutableDictionary *dictData = [NSMutableDictionary dictionaryWithObject:arrData forKey:@"Support Center"];
          [arrSection addObject:dictData];
          NSMutableArray *arrData1 = [NSMutableArray arrayWithArray:@[@"Tutorials",@"FAQ's",@"Case Studies"]];
          NSMutableDictionary *dictData1 = [NSMutableDictionary dictionaryWithObject:arrData1 forKey:@"Proyolk 101"];
          [arrSection addObject:dictData1];
          NSMutableArray *arrData2 = [NSMutableArray arrayWithArray:@[@"Terms & Conditions",@"Legal Disclaimer"]];
          NSMutableDictionary *dictData2 = [NSMutableDictionary dictionaryWithObject:arrData2 forKey:@"Our Policy"];
          [arrSection addObject:dictData2];
    
          NSMutableArray *arrData3 = [NSMutableArray arrayWithArray:@[@"Advertisement",@"Business Partners",@"Recruiters",@"Investors"]];
          NSMutableDictionary *dictData3 = [NSMutableDictionary dictionaryWithObject:arrData3 forKey:@"@Proyolk"];
          [arrSection addObject:dictData3];
          NSMutableArray *arrData4 = [NSMutableArray arrayWithArray:@[@"Change Password"]];
          NSMutableDictionary *dictData4 = [NSMutableDictionary dictionaryWithObject:arrData4 forKey:@"Change Password"];
          [arrSection addObject:dictData4];
    drawer=[[LeftRightDrawer alloc]init];
    av=[[AllValidationsViewController alloc]init];
    screenHeight= [SavePrefrences sharedInstance].screenHeight;
    screenWidth= [SavePrefrences sharedInstance].screenWidth;
    naviHght= [SavePrefrences sharedInstance].naviHght;
    naviWidth=[SavePrefrences sharedInstance].naviWidth;
    stbarHght= [SavePrefrences sharedInstance].stbarHght;
    
    opop=[[openChat alloc]init];
    av=[[AllValidationsViewController alloc]init];
    drawer=[[LeftRightDrawer alloc]init];
    mngAr=[[ManageArray alloc]init];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self customizeActionBar];
    self.ft_tableView.foldingDelegate = self;
   // [self.ft_tableView reloadData];
    [self.ft_tableView reloadData];
    [self.view updateConstraintsIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)customizeActionBar
{
    
    [drawer initArs:self];
    // main=[[UIView alloc]initWithFrame:CGRectMake(0,70, screenWidth, screenHeight)];
    NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
    self.view.backgroundColor=[brd valueForKey:@"backcolor"];
    //[self.view addSubview:main];
    //[self reteriveFriends];
    //[self ChatList];
}


- (FTFoldingSectionHeaderArrowPosition)perferedArrowPositionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return self.arrowPosition;
}
- (NSInteger )numberOfSectionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return arrSection.count;
}
- (NSInteger )ftFoldingTableView:(FTFoldingTableView *)ftTableView numberOfRowsInSection:(NSInteger )section
{
   /// return  NSString *strKey = [[[arrSection objectAtIndex:section]allKeys]objectAtIndex:0];;
    NSString *strKey = [[[arrSection objectAtIndex:section]allKeys]objectAtIndex:0];;
    NSMutableArray *arrdata =[[arrSection objectAtIndex:section]objectForKey:strKey];
            return arrdata.count;//[inboxAr count];
;
}	
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView titleForHeaderInSection:(NSInteger)section
{
    return  [[[arrSection objectAtIndex:section]allKeys]objectAtIndex:0];;
}
- (UITableViewCell *)ftFoldingTableView:(FTFoldingTableView *)ftTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SupportCell *cell = [ftTableView dequeueReusableCellWithIdentifier:@"SupportCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *strKey = [[[arrSection objectAtIndex:indexPath.section]allKeys]objectAtIndex:0];;
    NSMutableArray *arrdata =[[arrSection objectAtIndex:indexPath.section]objectForKey:strKey];
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            cell.imgView.image = [UIImage imageNamed:@"phone.png"];
        }
        else if (indexPath.row==1)
        {
            cell.imgView.image = [UIImage imageNamed:@"headphone.png"];
        }
        else if (indexPath.row==2)
        {
            cell.imgView.image = [UIImage imageNamed:@"chat_1.png"];
        }
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            cell.imgView.image = [UIImage imageNamed:@"video_123.png"];
        }
        else if (indexPath.row==1)
        {
            cell.imgView.image = [UIImage imageNamed:@"faq.png"];
        }
        else if (indexPath.row==2)
        {
             cell.imgView.image = [UIImage imageNamed:@"lines.png"];
        }
    }
    else if (indexPath.section==2)
    {
        if (indexPath.row==0)
        {
            cell.imgView.image = [UIImage imageNamed:@"new.png"];
        }
        else if (indexPath.row==1)
        {
            cell.imgView.image = [UIImage imageNamed:@"legal.png"];
        }
    }
    else if (indexPath.section==3)
    {
        if (indexPath.row==0)
        {
            cell.imgView.image = [UIImage imageNamed:@"new.png"];
        }
        else if (indexPath.row==1)
        {
            cell.imgView.image = [UIImage imageNamed:@"business.png"];
        }
    }

    cell.backgroundColor = [UIColor clearColor];
    cell.lblTitle.text = [arrdata objectAtIndex:indexPath.row];
    return cell;
    
}
- (UIImage *)ftFoldingTableView:(FTFoldingTableView *)ftTableView arrowImageForSection:(NSInteger )section
{
    return nil;
}
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView backgroundColorForHeaderInSection:(NSInteger )section
{
    NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
    return [brd valueForKey:@"backcolor"];
   // return [UIColor clearColor];
}
- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForTitleInSection:(NSInteger )section
{
    return [UIFont boldSystemFontOfSize:15];
}
//- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForDescriptionInSection:(NSInteger )section
//{
//    return [UIFont systemFontOfSize:13];
//}
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForTitleInSection:(NSInteger )section
{
    return [UIColor colorWithRed:37.0/255 green:106.0/255 blue:136.0/255 alpha:1.0];
}
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForDescriptionInSection:(NSInteger )section
{
    return [UIColor whiteColor];
}

- (void )ftFoldingTableView:(FTFoldingTableView *)ftTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1 && indexPath.row == 0) {
                UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                TutorialViewController *techSupport = [main instantiateViewControllerWithIdentifier:@"TutorialViewController"];
                [self.navigationController pushViewController:techSupport animated:YES];
                
            }
   else if (indexPath.section==0 && indexPath.row == 1) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TechSupportController *techSupport = [main instantiateViewControllerWithIdentifier:@"TechSupportController"];
        [self.navigationController pushViewController:techSupport animated:YES];
        
    }
   else if (indexPath.section==1 && indexPath.row == 1) {
       UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       FAQViewController *techSupport = [main instantiateViewControllerWithIdentifier:@"FAQViewController"];
       [self.navigationController pushViewController:techSupport animated:YES];
       
   }
   else if ((indexPath.section==2 && indexPath.row == 0) || (indexPath.section==2 && indexPath.row == 1) || (indexPath.section==3)) {
       UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       TermsViewController *techSupport = [main instantiateViewControllerWithIdentifier:@"TermsViewController"];
       if (indexPath.section==2 && indexPath.row==0) {
           techSupport.strTitle = @"Terms & Conditions";
       }
       else if (indexPath.section==2 && indexPath.row==1) {
           techSupport.strTitle = @"Legal Disclaimer";
       }
       else if (indexPath.section==3 && indexPath.row==0) {
           techSupport.strTitle = @"Advertisement";
       }
       else if (indexPath.section==3 && indexPath.row==1) {
           techSupport.strTitle = @"Business Partners";
       }
       else if (indexPath.section==3 && indexPath.row==2) {
           techSupport.strTitle = @"Recruiters";
       }
       else if (indexPath.section==3 && indexPath.row==3) {
           techSupport.strTitle = @"Investors";
       }
       [self.navigationController pushViewController:techSupport animated:YES];
       
   }

    else if (indexPath.section==0 && indexPath.row == 0) {
      
        ContactUs *containerView = [[[NSBundle mainBundle] loadNibNamed:@"ContactUS" owner:self options:nil] lastObject];
        containerView.strFlag = @"0";
        CGRect frame = containerView.frame;
        frame.size.width = self.view.frame.size.width-40;
        
        containerView.frame = frame;
        containerView.layer.cornerRadius = 5.0;
        UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView.backgroundColor = [UIColor clearColor];
        
        
        containerView.txtEmail.leftView = leftView;
        
        containerView.txtEmail.leftViewMode = UITextFieldViewModeAlways;
        containerView.txtEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView1.backgroundColor = [UIColor clearColor];
        
        
        containerView.txtName.leftView = leftView1;
        
        containerView.txtName.leftViewMode = UITextFieldViewModeAlways;
        containerView.txtName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //[rootView addSubview:containerView];
        containerView.center = self.view.center;
        [self.view addSubview:containerView];
        
    }
    
  else  if (indexPath.section==0 && indexPath.row == 2) {
        
        ContactUs *containerView = [[[NSBundle mainBundle] loadNibNamed:@"ContactUS" owner:self options:nil] lastObject];
      containerView.strFlag = @"1";
      CGRect frame = containerView.frame;
        frame.size.width = self.view.frame.size.width-40;
        
        containerView.frame = frame;
        containerView.layer.cornerRadius = 5.0;
        UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView.backgroundColor = [UIColor clearColor];
        
        
        containerView.txtEmail.leftView = leftView;
        
        containerView.txtEmail.leftViewMode = UITextFieldViewModeAlways;
        containerView.txtEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView1.backgroundColor = [UIColor clearColor];
        containerView.lblTitle.text = @"Feedback";
        
        containerView.txtName.leftView = leftView1;
        
        containerView.txtName.leftViewMode = UITextFieldViewModeAlways;
        containerView.txtName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //[rootView addSubview:containerView];
        containerView.center = self.view.center;
        [self.view addSubview:containerView];
        
    }
   else if (indexPath.section==arrSection.count-1 && indexPath.row == 0) {
        
        ChangePassword *containerView = [[[NSBundle mainBundle] loadNibNamed:@"ChangePassword" owner:self options:nil] lastObject];
        CGRect frame = containerView.frame;
        frame.size.width = self.view.frame.size.width-40;
        
        containerView.frame = frame;
        containerView.layer.cornerRadius = 5.0;
        UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView.backgroundColor = [UIColor clearColor];
        
        
        containerView.txtOldPassword.leftView = leftView;
        
        containerView.txtOldPassword.leftViewMode = UITextFieldViewModeAlways;
        containerView.txtOldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
        leftView1.backgroundColor = [UIColor clearColor];
        //containerView.txtPassword.text = @"Feedback";
        
        containerView.txtPassword.leftView = leftView1;
        
        containerView.txtPassword.leftViewMode = UITextFieldViewModeAlways;
        containerView.txtPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
       
       UILabel * leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
       leftView2.backgroundColor = [UIColor clearColor];
       //containerView.txtConfirmPassword.text = @"Feedback";
       
       containerView.txtConfirmPassword.leftView = leftView2;
       
       containerView.txtConfirmPassword.leftViewMode = UITextFieldViewModeAlways;
       containerView.txtConfirmPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //[rootView addSubview:containerView];
        containerView.center = self.view.center;
        [self.view addSubview:containerView];
        
    }


   
}





//- (void)viewDidLoad
//  {
//    [super viewDidLoad];
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//      arrSection = [NSMutableArray array];
//      NSMutableArray *arrData = [NSMutableArray arrayWithArray:@[@"Contact Us",@"Tech & Support",@"Feedback"]];
//      NSMutableDictionary *dictData = [NSMutableDictionary dictionaryWithObject:arrData forKey:@"Support Center"];
//      [arrSection addObject:dictData];
//      NSMutableArray *arrData1 = [NSMutableArray arrayWithArray:@[@"Tutorials",@"FAQ's",@"Case Studies"]];
//      NSMutableDictionary *dictData1 = [NSMutableDictionary dictionaryWithObject:arrData1 forKey:@"Proyolk 101"];
//      [arrSection addObject:dictData1];
//      NSMutableArray *arrData2 = [NSMutableArray arrayWithArray:@[@"Terms & Conditions",@"Legal Disclaimer"]];
//      NSMutableDictionary *dictData2 = [NSMutableDictionary dictionaryWithObject:arrData2 forKey:@"Our Policy"];
//      [arrSection addObject:dictData2];
//      
//      NSMutableArray *arrData3 = [NSMutableArray arrayWithArray:@[@"Advertisement",@"Business Partners",@"Recruiters",@"Investors"]];
//      NSMutableDictionary *dictData3 = [NSMutableDictionary dictionaryWithObject:arrData3 forKey:@"@Proyolk"];
//      [arrSection addObject:dictData3];
//      NSMutableArray *arrData4 = [NSMutableArray arrayWithArray:@[@"Change Password"]];
//      NSMutableDictionary *dictData4 = [NSMutableDictionary dictionaryWithObject:arrData4 forKey:@"Change Password"];
//      [arrSection addObject:dictData4];
//      
//      
//    screenWidth = screenRect.size.width;
//    screenHeight = screenRect.size.height;
//    naviWidth = self.navigationController.navigationBar.frame.size.width;
//    naviHght =  self.navigationController.navigationBar.frame.size.height;
//    stbarHght= (float)[[UIApplication sharedApplication] statusBarFrame].size.height;
//    
//    
//    [SavePrefrences sharedInstance].screenHeight=screenHeight;
//    [SavePrefrences sharedInstance].screenWidth=screenWidth;
//    [SavePrefrences sharedInstance].naviHght=naviHght;
//    [SavePrefrences sharedInstance].naviWidth=naviWidth;
//    [SavePrefrences sharedInstance].stbarHght=stbarHght;
//    [SavePrefrences sharedInstance].textsize=18;
//    
//      mang=[[ManageArray alloc]init];
//      
//    drawer=[[LeftRightDrawer alloc]init];
//    stpop=[[StoragePopUp alloc]init];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [self customizeActionBar];
//    
//     
//}
//
//
//
//-(void)customizeActionBar
//{
//    
//   [drawer initArs:self];
//    main=[[UIView alloc]initWithFrame:CGRectMake(0,70, screenWidth, screenHeight)];
//    main.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
//    [self.view addSubview:main];
//   // [self setTabBar];
//   // [self showInbox];
//
//    InboxtableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
//    InboxtableView.delegate = self;
//    InboxtableView.dataSource = self;
//    InboxtableView.scrollEnabled = YES;
//    InboxtableView.separatorColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//    InboxtableView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//    [main addSubview:InboxtableView];
//    
//
//}
//-(void)retrieveInbox
//{
//    
//  //  iscallback=1;
//     NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"getInbox" :@"":@"":dic1 :self];
//    
//}
//
//
///*-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
//{
//    av=[[AllValidationsViewController alloc]init];
//    
//    UIColor *color = [UIColor blackColor];
//    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
//    [Vc.view addSubview:prMainView];
//    vc1=Vc;
//    prMainView.backgroundColor=[UIColor colorWithRed:132.0f/255.0f green:132.0f/255.0f blue:132.0f/255.0f alpha:.5f];
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
//    NameLabel1=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-40, 50)];
//    NameLabel1.text=title;
//    NameLabel1.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
//    NameLabel1.font=[UIFont systemFontOfSize:14];
//    NameLabel1.textColor=[UIColor blackColor];
//    NameLabel1.layer.cornerRadius=5;
//    NameLabel1.textAlignment=NSTextAlignmentCenter;
//    [prMainView addSubview:NameLabel1];
//    
//    
//    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
//    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
//    scrollbar.backgroundColor=[UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
//    [prMainView addSubview:scrollbar];
//    
//    
//    return prMainView;
//}*/
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    
//    return YES;
//}
//
///*-(void)retrieveInbox1:(UIGestureRecognizer *)ges
//{
//    [self showInbox];
//
//   /* int idd=(int)ges.view.tag;
//    if(idd==0)
//    {
//       // [self showNotification];
//    }
//    else if(idd==1)
//    {
//        
//      if(isnoti==3)
//      {
//      iscallback=1;
//      NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//      [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//      [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"getInbox" :@"":@"":dic1 :self];
//      }
//        else if(isnoti==2)
//        {
//            [self openMyFiles];
//        }
//        
//    }
//    else if(idd==2)
//    {
//        [self openMyFiles];
//    }
//    if(idd==0 ||idd==1)
//    {
//        for(int x=0;x<[barAr count];x++)
//        {
//            UILabel * lbl=[barAr objectAtIndex:x];
//            if(x==(int)idd)
//            {
//                //  lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
//                lbl.backgroundColor=[colorAr objectAtIndex:x];
//            }
//            else
//            {
//                //  lbl.backgroundColor=[colorAr objectAtIndex:x];
//                lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
//            }
//        }
//    }
//    
//    if (barAr.count == 2 )
//    {
//        NSLog(@"[barAr count]....%lu",(unsigned long)[barAr count]);
//        if(idd==0 ||idd==1)
//        {
//            for(int x=0;x<[barAr count];x++)
//            {
//                UILabel * lbl=[barAr objectAtIndex:x];
//                if(x==(int)idd)
//                {
//                      lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
//                   // lbl.backgroundColor=[colorAr objectAtIndex:x];
//                }
//                else
//                {
//                    lbl.backgroundColor=[colorAr objectAtIndex:x];
//                   // lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
//                }
//            }
//        }
//        
//    }
//
//    NSLog(@"[barAr count]....%lu",(unsigned long)[barAr count]);
//    NSLog(@"idd....%lu",(unsigned long)idd);
//
//    if(idd==2)
//    {
//            NSLog(@"[barAr count]-----%lu",(unsigned long)[barAr count]);
//
//            for(int x=0;x<[barAr count];x++)
//            {
//                //here
//                UILabel * lbl=[barAr objectAtIndex:1];
//                if(x==(int)idd)
//                {
//                    lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
//                    // lbl.backgroundColor=[colorAr objectAtIndex:1];
//                }
//                else
//                {
//                    lbl.backgroundColor=[colorAr objectAtIndex:1];
//                    // lbl.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
//                }
//                
//                
//                UILabel * lbl1=[barAr objectAtIndex:0];
//                if(x==(int)idd)
//                {
//                    //  lbl1.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
//                    lbl1.backgroundColor=[colorAr objectAtIndex:0];
//                }
//                else
//                {
//                    //   lbl1.backgroundColor=[colorAr objectAtIndex:0];
//                    lbl1.backgroundColor=[UIColor clearColor];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
//                }
//        }
//    }
//}
//
//
//
//
//-(void) setTabBar
//{
//    [self retrieveInbox];
//
//  /*  NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
//    
//    option=[[UIView alloc]initWithFrame:CGRectMake(0,0, screenWidth, 45)];
//    option.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//    [main addSubview:option];
//    
//    UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(0, option.frame.size.height-2, option.frame.size.width, 2)];
//    lblline.backgroundColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
//    [option addSubview:lblline];
//
//    
//    colorAr=[[NSMutableArray alloc]init];
//    NSMutableArray * notiAR=[[NSMutableArray alloc]init];
//    
//    barAr=[[NSMutableArray alloc]init];
//    strAr=[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"24"];
//   
//   
//    for(NSInteger i = (int)strAr.count - 1; i >= 0 ; i--)
//      {
//        NSString * time=[[strAr valueForKey:@"time"] objectAtIndex:i];
//        NSString * ntc= [[strAr valueForKey:@"ntc"] objectAtIndex:i];
//        
//        //if(([ntc intValue]==11)||([ntc intValue]==12)||([ntc intValue]==13)||([ntc intValue]==14)||([ntc intValue]==15))
//        {
//            if([[[SavePrefrences sharedInstance].notiWithoutADR allKeys] containsObject:time])
//            {
//                [strAr removeObjectAtIndex:i];
//            }
//            else
//            {
//                [[SavePrefrences sharedInstance].notiWithoutADR setValue:time forKey:time];
//            }
//        }
//    }
//
//    isnoti=2;
//    int wid=option.frame.size.width/2;
//    if([strAr count]>0)
//    {
//        isnoti=3;
//        wid=option.frame.size.width/3;
//        [colorAr addObject:[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f]];
//        [colorAr addObject:[UIColor colorWithRed:52.0f/255.0f green:127.0f/255.0f blue:103.0f/255.0f alpha:1.0f]];
//        [colorAr addObject:[UIColor colorWithRed:108.0f/255.0f green:114.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
//
//        [notiAR addObject:@"Notifiction"];
//        [notiAR addObject:@"Inbox"];
//        [notiAR addObject:@"My Files"];
//        
//    }
//    else
//    {
//        [colorAr addObject:[UIColor colorWithRed:52.0f/255.0f green:127.0f/255.0f blue:103.0f/255.0f alpha:1.0f]];
//         [colorAr addObject:[UIColor colorWithRed:108.0f/255.0f green:114.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
//
//        [notiAR addObject:@"Inbox"];
//        [notiAR addObject:@"My Files"];
//        isnoti=2;
//    }
//    
//    int spx=0;
//    for(int x=0;x<isnoti;x++)
//    {
//        
//        UILabel *Inbox=[[UILabel alloc]initWithFrame:CGRectMake(spx, 0, wid, 40)];
//        Inbox.text=[notiAR objectAtIndex:x];
//        NSLog(@"text is====%@",[notiAR objectAtIndex:x]);
//        Inbox.textAlignment=NSTextAlignmentCenter;
//        [Inbox setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
//        Inbox.backgroundColor=[UIColor greenColor];//[ff valueForKey:@"backcolor"];
//        Inbox.textColor=[colorAr objectAtIndex:x];
//        [option addSubview:Inbox];
//        
//        UITapGestureRecognizer *Myinbox = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retrieveInbox1:)];
//        [Myinbox setNumberOfTouchesRequired:1];
//        [Myinbox setDelegate:self];
//        Inbox.userInteractionEnabled = YES;
//        Inbox.tag=x;
//        [Inbox addGestureRecognizer:Myinbox];
//        
//        Inbox_bar1=[[UILabel alloc]initWithFrame:CGRectMake(spx, Inbox.frame.size.height+Inbox.frame.origin.y, wid, 4)];
//        [option addSubview:Inbox_bar1];
//        [barAr addObject:Inbox_bar1];
//     
//        if(x==0)
//        {
//            Inbox_bar1.backgroundColor=[colorAr objectAtIndex:x];
//        }
//        else{
//            Inbox_bar1.backgroundColor=[ff valueForKey:@"backcolor"];
//        }
//        spx=wid+spx;
//        
//    }
//    
//  if(isnoti==2)
//    {
//        [self retrieveInbox];
//     }
//    else if(isnoti==3)
//    {
//        [self showNotification];
//    }
// 
//}*/
///*-(void)searchInbox
//{
//    
//    iscallback=3;
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [dic1 setObject:search_lbl.text forKey:@"fileName"];
//    [dic1 setObject:@"all" forKey:@"type"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"searchFiles" :@"" :@"" :dic1 :self ];
//}
//
//
///*-(void)showNotification
//{
//    [SavePrefrences sharedInstance].ischkstor=@"1";
//    
//    [middle_label removeFromSuperview];
//    [InboxtableView removeFromSuperview];
//    notificationTable = [[UITableView alloc] initWithFrame:CGRectMake(0,option.frame.origin.y+option.frame.size.height,main.frame.size.width,main.frame.size.height-(option.frame.origin.y+option.frame.size.height+75))];
//   notificationTable.delegate = self;
//   notificationTable.dataSource = self;
//   notificationTable.scrollEnabled = YES;
//   notificationTable.separatorColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey: @"backcolor"];
//   notificationTable.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey: @"backcolor"];
//   [main addSubview:notificationTable];
//
//}
//*/
//
///*-(void)showInbox
//{
//    
//    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, option.frame.size.height+option.frame.origin.y, screenWidth, 40)];
//    middle_label.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//    [main addSubview:middle_label];
//
//    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, -3, screenWidth, 1)];
//    line1.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
//    [middle_label addSubview:line1];
//    
//    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(5, 3.5, (screenWidth/2)+40, middle_label.frame.size.height-7)];
//    search_lbl.backgroundColor=[UIColor colorWithRed:225.0f/255.0f green:232.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
//    search_lbl.placeholder=@"File name or size";
//    search_lbl.delegate=self;
//    ///////////////
//    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
//    search_lbl.leftView = paddingView;
//    search_lbl.leftViewMode = UITextFieldViewModeAlways;
//    ////////////
//
//    [middle_label addSubview:search_lbl];
//    
//    
//    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+1, 3.5, middle_label.frame.size.height-10, middle_label.frame.size.height-10)];
//    searchbutton.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//    searchbutton.image=[UIImage imageNamed:@"search.png"];
//    searchbutton.tag=3;
//    [middle_label addSubview:searchbutton];
//    
//    UITapGestureRecognizer *sworkingreg1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchInbox)];
//    [sworkingreg1 setNumberOfTouchesRequired:1];
//    [sworkingreg1 setDelegate:self];
//    searchbutton.userInteractionEnabled = YES;
//    [searchbutton addGestureRecognizer:sworkingreg1];
//    
//    UIImageView *Filter=[[UIImageView alloc]initWithFrame:CGRectMake(searchbutton.frame.size.width+searchbutton.frame.origin.x+5, 3.5, 28, 28)];
//    Filter.image=[UIImage imageNamed:@"filtericon1.png"];
//    [middle_label addSubview:Filter];
//    
//    UIImageView *up_dwn_arrow=[[UIImageView alloc]initWithFrame:CGRectMake(Filter.frame.size.width+Filter.frame.origin.x+5, 3.5, 28, 28)];
//    up_dwn_arrow.image=[UIImage imageNamed:@"newsortby1.png"];
//    [middle_label addSubview:up_dwn_arrow];
//    
//    
//    UITapGestureRecognizer *myfiltergesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openfilterpop)];
//    [myfiltergesture1 setNumberOfTouchesRequired:1];
//    [myfiltergesture1 setDelegate:self];
//    Filter.userInteractionEnabled = YES;
//    [Filter addGestureRecognizer:myfiltergesture1];
//    
//    UITapGestureRecognizer *updwngesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(up_dwn_pop)];
//    [updwngesture setNumberOfTouchesRequired:1];
//    [updwngesture setDelegate:self];
//    up_dwn_arrow.userInteractionEnabled = YES;
//    [up_dwn_arrow addGestureRecognizer:updwngesture];
//
//    
//    float hight= middle_label.frame.size.height+middle_label.frame.origin.y;
//    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
//  
//    if(hight==0)
//     {
//      InboxtableView = [[UITableView alloc] initWithFrame:CGRectMake(0,hight,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height+40)];
//     }
//    else
//     {
//      InboxtableView = [[UITableView alloc] initWithFrame:CGRectMake(0,hight,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height)];
//     }
//    InboxtableView.delegate = self;
//    InboxtableView.dataSource = self;
//    InboxtableView.scrollEnabled = YES;
//    InboxtableView.separatorColor=[ff valueForKey:@"backcolor"];
//    InboxtableView.backgroundColor=[ff valueForKey:@"backcolor"];
//    [main addSubview:InboxtableView];
//    
//}*/
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    return cellheight;
//}
//- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==0 && indexPath.row == 1) {
//        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        TechSupportController *techSupport = [main instantiateViewControllerWithIdentifier:@"TechSupportController"];
//        [self.navigationController pushViewController:techSupport animated:YES];
//        
//    }
//    
//    
//}
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return arrSection.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc]init];
//    headerView.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-20, 40)];
//    lblTitle.textColor = [UIColor colorWithRed:37.0/255 green:106.0/255 blue:136.0/255 alpha:1.0];
//    lblTitle.font = [UIFont fontWithName:@"Helvetica" size:15.0];
//    NSMutableDictionary *dictData = [arrSection objectAtIndex:section];
//    lblTitle.text = [[dictData allKeys]objectAtIndex:0];
//    
//    [headerView addSubview:lblTitle];
//    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, self.view.frame.size.width, 1)];
//    bottomView.backgroundColor = [UIColor colorWithRed:117.0/255 green:128.0/255 blue:0.0/255 alpha:1.0];
//    [headerView addSubview:bottomView];
//    headerView.backgroundColor = [UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];;;
//    
//    
//    return headerView;
//}
//
//
//
//-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
//{
//    if(theTableView==InboxtableView)
//    {
//        cellheight=50;
//        NSString *strKey = [[[arrSection objectAtIndex:section]allKeys]objectAtIndex:0];;
//        
//        NSMutableArray *arrdata =[[arrSection objectAtIndex:section]objectForKey:strKey];
//        return arrdata.count;//[inboxAr count];
//    }
//    
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//   {
//    NSString *MyCellIdentifier = @"MyCellIdentifier";
//    UITableViewCell *cell = [self.InboxtableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
//       @try
//         {
//        NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry ;
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
//        
//        cell.selectionStyle = UITableViewCellEditingStyleNone;
//        cell.backgroundColor=[ff valueForKey:@"backcolor"];
//            
//             if(theTableView==InboxtableView)
//             {
//                 UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+20, 50)];
//                 cell_View.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];;
//                 [cell addSubview: cell_View];
//                 {
//                     
//                   /*  UIButton *checkpoint=[[UIButton alloc] initWithFrame:CGRectMake(3, (cell_View.frame.size.height/2)-8, 16, 16)];
//                     [checkpoint setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
//                     [checkpoint addTarget:self action:@selector(Tick:) forControlEvents:UIControlEventTouchUpInside];
//                     checkpoint.tag=indexPath.row;
//                     [cell_View addSubview:checkpoint];*/
//                     NSString *strKey = [[[arrSection objectAtIndex:indexPath.section]allKeys]objectAtIndex:0];;
//                     NSMutableArray *arrdata =[[arrSection objectAtIndex:indexPath.section]objectForKey:strKey];
//                     UIImageView *pic=[[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 30, 30)];
//                     pic.image=[UIImage imageNamed:@"pictureicn1.png"];
//                     [cell_View addSubview: pic];
//                     
//                     UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(pic.frame.size.width+pic.frame.origin.x+12,15, cell_View.frame.size.width-pic.frame.size.width+pic.frame.origin.x+2-20, 20)];
//                     title.backgroundColor=[UIColor clearColor];
//                     title.text=[arrdata objectAtIndex:indexPath.row];
//                     title.font = [UIFont fontWithName:@"Helvetica" size:14.0];
//                  //   [title setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
//                     [title setFont:[UIFont boldSystemFontOfSize:15]];
//                     title.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
//                     [cell_View addSubview:title];
//
//                     
//                     return cell;}
//             }
//
//                 }
//    @catch (NSException *exception)
//    {
//        NSLog(@"exception is===%@",exception);
//    }
//    @finally {
//    }
//    return  cell;
//}
//
///*-(IBAction)Tick:(id)sender
//{
//    UIButton *resultButton = (UIButton *)sender;
//    fileindex=(int)resultButton.tag;
//    
//    //radioselect.png
//    //radiounselect.png
//    if([[resultButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"radiounselect.png"]])
//    {
//        [sender1 setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
//        [sender setImage:[UIImage imageNamed:@"radioselect.png"] forState:UIControlStateNormal];
//        base.hidden=false;
//        InboxtableView.frame =CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height-200);
//        
//        sender1=sender;
//        
//    }
//    else
//    {
//        [sender setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
//        base.hidden=true;
//        InboxtableView.frame =CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height);
//        
//        
//    }
//}
//
///*-(void)SelectOption:(id)sender
//{
//    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
//    if((int)tg.view.tag==0)
//    {
//        NSLog(@"moving");
//        
//        
//        stpop.fileid=[[inboxAr objectAtIndex:fileindex] valueForKey:@"file_id"];
//        stpop.filename=[[inboxAr objectAtIndex:fileindex] valueForKey:@"file_name"];
//
//       // stpop.uid_from=[[inboxAr objectAtIndex:fileindex] valueForKey:@"u_id_from"];
//         stpop.uid_from= [[inboxAr objectAtIndex:fileindex] valueForKey:@"imge"];
//        [stpop moveto:self];
//    }
//    else if((int)tg.view.tag==1)
//    {
//        NSLog(@"Downloadingrrr");
//        
//        NSString *path= [[inboxAr valueForKey:@"imge"]objectAtIndex:(int)tg.view.tag];
//        [stpop downloadImg:path];
//    }
//    else if((int)tg.view.tag==2)
//    {
//        NSLog(@"delete file");
//        alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete ? " delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//        [alrt show];
//        [self alertView:alrt clickedButtonAtIndex:2];
//    }
//}
//
///*- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 1)
//    {
//        NSLog(@"ok");
//        iscallback=2;
//        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//        
//        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//        
//        NSString * fileid1= [[inboxAr objectAtIndex:fileindex] valueForKey:@"file_id"];
//        
//        [dic1 setObject:fileid1 forKey:@"flId"];
//        [[SavePrefrences sharedInstance].skthand emitData:@"MyFiles" :@"delSharedFile" :@"" :@"" :dic1 :self ];
//    }
//    else if(buttonIndex==0)
//    {
//        NSLog(@"cancel");
//        [alrt dismissWithClickedButtonIndex:0 animated:YES];
//        
//    }
//}
//
///*-(void)openMyFiles
//{
//    iscallback=0;
//    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
//    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [dic setValue:@"0" forKey:@"cs"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"MyFiles" :@"getAllFiles" :@"":@"":dic :self];
//    
//}
//-(void)openfilterpop
//{
//    
//    [stpop filterpopup:self];
//    
//}
//-(void)up_dwn_pop
//{
//    [stpop sortedfilter:self];
//    
//}*/
//
///*-(void)callBack:(NSArray *)meta :(NSArray *)data
//{
//    NSLog(@"Storage_data=========%@",data);
//    NSLog(@"Storage_meta=========%@",meta);
//    
//    
//    if(iscallback==0)
//    {
//        [stpop showMyfileView:self:data];
//    }
//    else if (iscallback==1)
//    {
//        
//        inboxAr=data;
//        [self showInbox];
//    }
//    else if (iscallback==2)
//    {
//        //
//        if([data valueForKey:@"affectedRows"]>0)
//        {
//            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted Successfully!!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            [alrt show];
//            [alrt dismissWithClickedButtonIndex:0 animated:YES];
//            
//            [self retrieveInbox];
//        }
//    }
//    else if (iscallback==3)
//    {
//        inboxAr=data;
//        if([inboxAr count]>0)
//        {
//            [InboxtableView reloadData];
//        }
//        else{
//            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Oops!No New Result Found  " delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//            [alrt show];
//        }
//    }
//}*/
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
///*-(void) callMethod:(NSArray *)meta
//{
//    NSString * chk=[meta objectAtIndex:0];
//    
//    
//    NSLog(@"Valuuuuuuuuuu===%@",meta);
//    NSLog(@"COUNT IS %lu",[meta count]);
//    if([meta count]>1)
//    {
//        
//        NSMutableArray * ar=[meta objectAtIndex:1];
//        
//        if([ar count]>0)
//        {
//            if([chk isEqual:@"FilteredData"])
//            {
//                inboxAr=ar;
//                [InboxtableView reloadData];
//            }
//            else  if([chk isEqual:@"Sorteddata"])
//            {
//                inboxAr=ar;
//                [InboxtableView reloadData];
//            }
//            
//            else  if([chk isEqual:@"reteriveInbox"])
//            {
//                [self retrieveInbox];
//            }
//            
//            
//            
//        }
//        else{
//            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Oops! No New Result Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//            [alrt show];
//        }
//    }
//}*/
//@end
@end

