
#import "Yolking.h"
#import "SavePrefrences.h"
#import "AllValidationsViewController.h"
#import "LeftRightDrawer.h"
#import "ManageArray.h"
#import "AppDelegate.h"
#import "ChatViewController.h"
#import "ProfileViewController.h"

@interface Yolking ()<UIAlertViewDelegate>

{
    
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    AllValidationsViewController *allValidations;
    LeftRightDrawer *drawer;
    UIView *main,*cell_View;
    NSMutableArray *notiAr1;
    ManageArray *manag;
    int limit;
    NSMutableDictionary *acceptAr,*rejAr,*titleAr;
    int iscallback,isFound;
    float scrollpostion;
    NSString * noti_id;
    int ykcount;
    BOOL isAlertOnScreen;
    
}

@end

@implementation Yolking

@synthesize notiTableView;

- (void)viewDidLoad
  {
    
    [super viewDidLoad];
      float systemOffset = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]];
      
     notiAr1=[[NSMutableArray alloc]init];
     drawer=[[LeftRightDrawer alloc]init];
    
    
    screenHeight= [SavePrefrences sharedInstance].screenHeight;
    
    screenWidth= [SavePrefrences sharedInstance].screenWidth;
    
    naviHght= [SavePrefrences sharedInstance].naviHght;
    
    naviWidth=[SavePrefrences sharedInstance].naviWidth;
    
    stbarHght= [SavePrefrences sharedInstance].stbarHght;
    
    allValidations=[[AllValidationsViewController alloc]init];
    
    drawer=[[LeftRightDrawer alloc]init];
    
    manag=[[ManageArray alloc]init];
      
//    [self retreiveFriends];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self customizeActionBar];
    
}

- (void)viewDidAppear:(BOOL)animated{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self retreiveFriends];
    });
}

-(void) retreiveFriends{
    iscallback=88;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"genData":@"":@"":dic1 :self];
}


- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}

-(void)customizeActionBar

{
    
    [drawer initArs:self];
    
    main=[[UIView alloc]initWithFrame:CGRectMake(0,70, screenWidth, screenHeight)];
    
    NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
    
    main.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];//[UIColor colorWithRed:238.0f/255 green:239.0f/255 blue:255.0f/255 alpha:1.0f];//[brd valueForKey:@"backcolor"];
    
    [self.view addSubview:main];
    
    [self yolkingscreen:self];
    
}

-(void)getYokingData
{
    float offset = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]] / 3600.0;
    iscallback=1;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:[NSString stringWithFormat:@"%f",offset] forKey:@"offset"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"showMess" :@"" :@"" :dic :self ];
}

-(void)getYokingData1{
    float systemOffset = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]];
    float result = systemOffset * 1.1;

    float offset = result/ 3600.0;
    iscallback=101;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:[NSString stringWithFormat:@"%f",offset] forKey:@"offset"];
    [dic setValue:[NSString stringWithFormat:@"%d",limit] forKey:@"limit"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"showMess" :@"" :@"" :dic :self ];
}


-(void)yolkingscreen:(UIViewController *)Vc{
      
      [self getYokingData];
      
      vc1 = Vc;
  //  NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    UILabel *activity=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,screenWidth , 25)];
    
    activity.text=@"Notifications";
    [activity setFont:[UIFont fontWithName:@"HelveticaNeue-Semibold" size:14]];
    activity.textAlignment=NSTextAlignmentCenter;
    activity.textColor=[UIColor grayColor];
    activity.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];//[UIColor colorWithRed:238.0f/255 green:239.0f/255 blue:255.0f/255 alpha:1.0f];
    [main addSubview:activity];
    
    UILabel *actvty_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, activity.frame.size.height+activity.frame.origin.y,screenWidth , 5)];
    actvty_lbl.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];//[UIColor colorWithRed:238.0f/255 green:239.0f/255 blue:255.0f/255 alpha:1.0f];
    
    notiTableView=[[UITableView alloc]initWithFrame:CGRectMake(5, actvty_lbl.frame.size.height+actvty_lbl.frame.origin.y+2, main.frame.size.width-10, main.frame.size.height-(actvty_lbl.frame.size.height+actvty_lbl.frame.origin.y+85))];
    
    notiTableView.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];//[UIColor colorWithRed:238.0f/255 green:239.0f/255 blue:255.0f/255 alpha:1.0f];//[ff valueForKey:@"backcolor"];
    notiTableView.delegate = self;
    notiTableView.dataSource = self;
    notiTableView.scrollEnabled = YES;
    notiTableView.separatorColor=[UIColor clearColor];//[ff valueForKey:@"backcolor"];
    
    [main addSubview:notiTableView];
    
}

-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSArray *arrData  = [dictionaryByDate allKeys];
    
    
    
    NSMutableArray *arrKeys = [arrData sortedArrayUsingComparator:^NSComparisonResult(NSString *strDate1, NSString *strDate2) {
        NSDate *d1 =[formatter dateFromString:strDate1];
        NSDate *d2 =[formatter dateFromString:strDate2];
        //NSDate *d2 = obj2[@"date"];
        
       // return [d1 compare:d2]; // ascending order
        return [d2 compare:d1]; // descending order
    }];
    
    
   // NSArray *arrData  = [dictionaryByDate allKeys];
   NSString *strKey = [arrKeys objectAtIndex:section];
    NSMutableArray *arr = [dictionaryByDate objectForKey:strKey];
    acceptAr=[[NSMutableDictionary alloc]init];
    rejAr=[[NSMutableDictionary alloc]init];
    titleAr=[[NSMutableDictionary alloc]init];
    ykcount=0;
    return arr.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [dictionaryByDate allKeys].count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSArray *arrData  = [dictionaryByDate allKeys];

    
    
    NSMutableArray *arrKeys = [arrData sortedArrayUsingComparator:^NSComparisonResult(NSString *strDate1, NSString *strDate2) {
        NSDate *d1 =[formatter dateFromString:strDate1];
        NSDate *d2 =[formatter dateFromString:strDate2];
        //NSDate *d2 = obj2[@"date"];
        
       // return [d1 compare:d2]; // ascending order
        return [d2 compare:d1]; // descending order
    }];
    
    
    
    
    
    
    UILabel *lblHeader = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
   // NSArray *arrData  = [dictionaryByDate allKeys];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate *d1 =[formatter dateFromString: [arrKeys objectAtIndex:section]];
    if ([calendar isDateInToday:d1]) {
        lblHeader.text = @"Today";
    }
    else if ([calendar isDateInYesterday:d1]){
        lblHeader.text = @"Yesterday";
    }
    else{
    
        lblHeader.text = [arrKeys objectAtIndex:section];
    }
    lblHeader.textAlignment = NSTextAlignmentCenter;
    lblHeader.font = [UIFont fontWithName:@"helvetica" size:14.0];
    lblHeader.backgroundColor = [[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];;
    return lblHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
    
}





-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
   {
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    
    UITableViewCell *cell = [self.notiTableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    @try
    
    {
        isFound=0;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
      //  cell.layer.cornerRadius=8;
       // cell.clipsToBounds=YES;
        cell.backgroundColor=[UIColor clearColor];
       // cell.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0);
        if (indexPath.row==0)
        {
            
        }
        else{
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1];
            [cell.contentView addSubview:separator];
        }
        cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,93)];
        cell_View.backgroundColor=[UIColor clearColor];
       // cell_View.layer.borderWidth=1;
        //cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
       // cell_View.layer.cornerRadius=6;
        [cell addSubview: cell_View];
        
        UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, cell.frame.size.height/2-13, 35, 35)];
        userpic.layer.cornerRadius=17;
        userpic.clipsToBounds=YES;
        //[userpic setImage:[UIImage imageNamed:@"user.png"]];
        [cell_View addSubview:userpic];
        UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewProfile:)];
        userpic.tag = indexPath.row;
        [communityeg setNumberOfTouchesRequired:1];
        [communityeg setDelegate:self];
        userpic.userInteractionEnabled = YES;
        [userpic addGestureRecognizer:communityeg];
        //here
        UILabel*user_lbl=[[UILabel alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10, 20, 110,15)];
        user_lbl.text=@"";
        [user_lbl setFont:[UIFont fontWithName:@"HelveticaNeue-bold" size:14]];
        user_lbl.backgroundColor=[UIColor clearColor];
        user_lbl.textColor= [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];//[ff valueForKey:@"Scrollcolor"];
       // [cell_View addSubview:user_lbl];

        //here
        UILabel *timlb=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.view.frame.size.width-20,15)];
        timlb.text=@"";
        timlb.textColor=[UIColor blackColor];
        [timlb setFont:[UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:10]];
        timlb.textAlignment=NSTextAlignmentRight;
        timlb.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:timlb];
        
        //here
      //  UITextView *request=[[UITextView alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+8, user_lbl.frame.size.height+user_lbl.frame.origin.y,cell.frame.size.width-10, 30)];
        UITextView *request=[[UITextView alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+8, 15,cell.frame.size.width-10, 42)];
        request.text=@"";
        [request setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        request.backgroundColor=[UIColor clearColor];
        request.userInteractionEnabled=NO;
        request.textColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
        [cell_View addSubview:request];
        

       
        UIButton *accept = [[UIButton alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+20,request.frame.size.height+request.frame.origin.y+2, 70,20)];
        [accept setTitle: @"Accept" forState: UIControlStateNormal];
        accept.backgroundColor= [UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];
        [accept setTitleColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] forState:UIControlStateNormal];
        accept.layer.cornerRadius=5;
        accept.tag=indexPath.row;
        accept.titleLabel.textAlignment=NSTextAlignmentLeft;
        [accept setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
        [cell_View addSubview:accept];
        
        UIImageView *acceptImg = [[UIImageView alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+15+60,request.frame.size.height+request.frame.origin.y+4, 20,20)];
        acceptImg.image=[UIImage imageNamed:@"accept1.png"];
        [cell_View addSubview:acceptImg];


        UIButton *decline = [[UIButton alloc]initWithFrame:CGRectMake(accept.frame.size.width+accept.frame.origin.x+20,request.frame.size.height+request.frame.origin.y+2, 70,20)];
        [decline setTitle: @"Decline" forState: UIControlStateNormal];
        decline.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Declinecolor"];
        [decline setTitleColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] forState:UIControlStateNormal];
        [decline setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
        decline.titleLabel.textAlignment=NSTextAlignmentLeft;
        decline.layer.cornerRadius=5;
        decline.tag=0;
        [cell_View addSubview:decline];
        
        UIImageView *declineImage = [[UIImageView alloc]initWithFrame:CGRectMake(accept.frame.size.width+accept.frame.origin.x+15+60,request.frame.size.height+request.frame.origin.y+4, 23,23)];
        declineImage.image=[UIImage imageNamed:@"deny.png"];
        [cell_View addSubview:declineImage];

        UIButton *btnChat = [[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-50,request.frame.size.height+request.frame.origin.y-4, 20,20)];
        btnChat.backgroundColor= [UIColor clearColor];
        [btnChat setBackgroundImage:[UIImage imageNamed:@"chatNew.png"] forState:UIControlStateNormal];
        [btnChat addTarget:self action:@selector(btnChatAction:) forControlEvents:UIControlEventTouchUpInside];
        
        btnChat.tag = indexPath.row;
        btnChat.layer.cornerRadius=5;
        //btnChat.tag=0;

        
        
        
      /*  UIButton *accept = [[UIButton alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10,request.frame.size.height+request.frame.origin.y+10, 60,20)];
        [accept setTitle: @"Accept" forState: UIControlStateNormal];
        accept.backgroundColor= [ff valueForKey:@"Yellowbtncolor"];
        [accept setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        accept.layer.cornerRadius=5;
        accept.tag=0;
        [cell_View addSubview:accept];
        
        UIButton *decline = [[UIButton alloc]initWithFrame:CGRectMake(accept.frame.size.width+accept.frame.origin.x+10,request.frame.size.height+request.frame.origin.y+10, 60, 20)];
        [decline setTitle: @"Decline" forState: UIControlStateNormal];
        decline.backgroundColor=[ff valueForKey:@"Declinecolor"];
        [decline setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        decline.layer.cornerRadius=5;
        decline.tag=0;
        [cell_View addSubview:decline];*/
        

        
        
        [acceptAr setValue:accept forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        [rejAr setValue:decline forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        [titleAr setValue:request forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd,yyyy"];
        NSArray *arrData  = [dictionaryByDate allKeys];
        
        
        
        NSMutableArray *arrKeys = [arrData sortedArrayUsingComparator:^NSComparisonResult(NSString *strDate1, NSString *strDate2) {
            NSDate *d1 =[formatter dateFromString:strDate1];
            NSDate *d2 =[formatter dateFromString:strDate2];
            //NSDate *d2 = obj2[@"date"];
            
          //  return [d1 compare:d2]; // ascending order
            return [d2 compare:d1]; // descending order
        }];
        
        NSString *strKey = [arrKeys objectAtIndex:indexPath.section];
        NSMutableArray *arr = [dictionaryByDate objectForKey:strKey];
        NSArray *ar = [arr objectAtIndex:indexPath.row];
       //NSLog(@"arrrr====ddd====%@",ar);
        NSDictionary* item = (NSDictionary*)ar;

        int ntc= [[ar valueForKey:@"ntc"] intValue];
        NSString *uname=[ar valueForKey:@"uname"];
        NSString *fruid=[ar valueForKey:@"fruid"];
        NSString *img=[ar valueForKey:@"img"];
        NSString *uid=[ar valueForKey:@"uid"];
        NSString *time=[ar valueForKey:@"time"];
        NSString *status=[ar valueForKey:@"status"];
        NSString *fname=[ar valueForKey:@"fname"];
        NSString *lname=[ar valueForKey:@"lname"];
        
        NSDictionary* contact = [self contactFromId:[NSString stringWithFormat:@"%@", uid]];
        if (contact) {
            [cell_View addSubview:btnChat];
        }
        
        uname=[fname stringByAppendingString:[NSString stringWithFormat:@" %@ ",lname]];
       
        
        if(status==nil||status==NULL||[status isEqual:[NSNull null]]||status == (id)[NSNull null])
        {
            status=@"0";
        }
        else if([status isEqual:@"Undefined"])
        {
            status=@"0";
        }
        else if([status intValue]==0)
        {
            status=@"0";
        }
        NSString * tit;
        //if(uid !=[SavePrefrences sharedInstance].uid)
            {
            accept.hidden=true;
            decline.hidden=true;
            acceptImg.hidden=true;
            declineImage.hidden=true;

            NSString * url=[manag concatUrl:img];
            if(ntc!=3)
            {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                    //set your image on main thread.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(url.length<12)
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
             }
            
            userpic.layer.borderWidth=0.0;
            userpic.layer.borderColor=[[UIColor clearColor]CGColor];

            switch (ntc)
            {
               case 9://board invite
                 {
                     
                     
                    NSArray * jsonObject=[manag convertojson:ar];
                    NSString *brdID=[jsonObject valueForKey:@"brdID"];
                    NSString *title1=[jsonObject valueForKey:@"title"];
                    BOOL isSentInvite = NO;
                    if ([item[@"mess"] rangeOfString:@"You invited to comment on"].location == NSNotFound) {
                        isSentInvite = NO;
                    }else isSentInvite = YES;
                     if ([uid intValue] == [[SavePrefrences sharedInstance].uid intValue] && isSentInvite) {
                         tit = [NSString stringWithFormat:@"You invited users to comment on your board %@", title1];
                         NSString *time=item[@"time"];
                         time = time;
                         isFound=1;
                         accept.hidden=true;
                         decline.hidden=true;
                         
                         acceptImg.hidden=true;
                         declineImage.hidden=true;
                         break;
                     }
                   if([uid intValue] ==[[SavePrefrences sharedInstance].uid intValue] && !isSentInvite)
                    {
                        accept.hidden=false;
                        decline.hidden=false;
                        
                        acceptImg.hidden=false;
                        declineImage.hidden=false;

                        tit= [@"You invited to comment on " stringByAppendingString:[NSString stringWithFormat:@" %@  Board ",title1]];
                    }
                   else
                   {
                    NSArray * ff= [ar valueForKey:@"brdStstus"];
                    if(ff){
                        
                        tit = [NSString stringWithFormat:@"%@ %@", [ff valueForKey:@"mes"], title1];
                        time= [ff valueForKey:@"time"] ;
                        isFound=1;
                        accept.hidden=true;
                        decline.hidden=true;
                        
                        acceptImg.hidden=true;
                        declineImage.hidden=true;
                    }else{
                    
                        if([jsonObject containsObject:jsonObject])
                        {
                            tit= [[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc9] stringByAppendingString:title1];
                        }
                        else
                        {
                            NSString *brdID=[jsonObject valueForKey:@"brdID"];
                            tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc9];
                            tit = [NSString stringWithFormat:@"%@ %@", tit, title1];
                        }
                        
                        if([status intValue]==0){
                            accept.hidden=false;
                            decline.hidden=false;
                            acceptImg.hidden=false;
                            declineImage.hidden=false;
                        }
                    }
                   }
                    
                    break;
                    
                }
                    
                case 10:
                {
                    
                    // Board Application
                    NSArray * jsonObject=[manag convertojson:ar];
                    NSString *brdID=[jsonObject valueForKey:@"brdID"];
                    NSString *title1=[jsonObject valueForKey:@"title"];
                    
                    if([uid intValue]==[[SavePrefrences sharedInstance].uid intValue]){
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;

                        tit= [@"You requested to join " stringByAppendingString:[NSString stringWithFormat:@" %@ Board ",title1]];
                    }else{
                    NSArray * ff= [ar valueForKey:@"brdStstus"];
                    if(ff!=nil){
                        tit=[ff valueForKey:@"mes"];
                        time= [ff valueForKey:@"time"] ;
                        isFound=1;
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;
                    }else{
                        if([jsonObject containsObject:jsonObject]){
                            tit= [[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc10] stringByAppendingString:title1];
                        }else{
                            NSString *brdID=[jsonObject valueForKey:@"brdID"];
                            tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc10] ;
                        }
                        if([status intValue]==0)
                        {
                            accept.hidden=false;
                            decline.hidden=false;
                            acceptImg.hidden=false;
                            declineImage.hidden=false;
                        }
                    }
                    }
                    if ([item[@"mess"] rangeOfString:@"has requested to join your"].location != NSNotFound) {
                        tit = [NSString stringWithFormat:@"%@ has requested to join your board %@", uname, title1];
                    }
                    break;
                    
                }
                    
                case 11:
                {
                    // Board Invitation accepted
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You" stringByAppendingString:[SavePrefrences sharedInstance].ntc11];
                    }
                    else{
                       tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc11];
                    }
                    
                    
                    break;
                    
                }
                case 12:
                {
                    // Board Invitation rejected
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You" stringByAppendingString:[SavePrefrences sharedInstance].ntc12];
                    }
                    else{
                       tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc12];
                    }
                    
                    break;
                    
                }
                    
                case 13:
                {
                    //NSLog(@"Board Application accepted");
                    if([uid intValue] ==[[SavePrefrences sharedInstance].uid intValue])
                    {
                        tit=[@" You " stringByAppendingString:[SavePrefrences sharedInstance].ntc13];
                    }
                    else{
                     tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc13 ];
                    }
                    
            
                    break;
                    
                }
                    
                case 14:
                {
                    //NSLog(@"Board Application Rejected");
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You" stringByAppendingString:[SavePrefrences sharedInstance].ntc14];
                    }
                    else{
                        tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc14];
                    }
                    
                    break;
                    
                }
                    
                case 15:
                {
                    
                    // New Comment Posted
                      NSArray * jsonObject=[manag convertojson:ar];
                    NSString*title1=[jsonObject valueForKey:@"title"];
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[[@"You" stringByAppendingString:@" Posted A comment On "] stringByAppendingString:[NSString stringWithFormat:@" Board %@",title1]];
                    }
                    else
                    {
                  
                    if([manag checkContaine:jsonObject])
                    {
                        
                        tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc15] stringByAppendingString:title1];
                    }
                    else{
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc15];
                    }
                    }
                    break;
                    
                }
                    
                case 16:
                {
                    
                    
                    NSArray * jsonObject=[manag convertojson:ar];
                    NSString *brdID=[jsonObject valueForKey:@"podId"];
                    NSString *title1=[jsonObject valueForKey:@"title"];
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;

                        tit= [@"You Shared The " stringByAppendingString:[NSString stringWithFormat:@" %@  Podcast ",title1]];
                    }
                    
                    else{
                    
                    NSArray * ff= [ar valueForKey:@"brdStstus"];
                    if(ff!=nil)
                    {
                        
                        tit=[ff valueForKey:@"mes"];
                        time= [ff valueForKey:@"time"] ;
                        isFound=1;
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;

                    }
                    else
                    {
                      
                        if([jsonObject containsObject:jsonObject])
                        {
                            NSString *brdID=[jsonObject valueForKey:@"podId"];
                            NSString *title1=[jsonObject valueForKey:@"title"];
                            tit= [[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc16] stringByAppendingString:title1];
                        }
                        else
                        {
                            NSString *brdID=[jsonObject valueForKey:@"podId"];
                            tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc16];
                        }
                        if([status intValue]==0)
                        {
                            accept.hidden=false;
                            decline.hidden=false;
                            acceptImg.hidden=false;
                            declineImage.hidden=false;

                        }
                        
                    }
                    }
                    
                    break;
                    
                }
                    
                case 17:
                {
                    
                    //Podcast Application
                    NSArray * jsonObject=[manag convertojson:ar];
                    NSString *brdID=[jsonObject valueForKey:@"podId"];
                    NSString *title1=[jsonObject valueForKey:@"title"];
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        accept.hidden=false;
                        decline.hidden=false;
                        
                        acceptImg.hidden=false;
                        declineImage.hidden=false;

                       tit= [@"You Invite To comment On " stringByAppendingString:[NSString stringWithFormat:@" %@  Podcast Application",title1]];
                    }
                    else{
                    
                    NSArray * ff= [ar valueForKey:@"brdStstus"];
                    if(ff!=nil)
                    {
                        
                        tit=[ff valueForKey:@"mes"];
                        time= [ff valueForKey:@"time"] ;
                        isFound=1;
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;

                    }
                    else
                    {
                     
                        
                        if([jsonObject containsObject:jsonObject])
                        {
                          
                            tit= [[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc17] stringByAppendingString:title1];
                        }
                        else{
                            NSString *brdID=[jsonObject valueForKey:@"podId"];
                            tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc17] ;
                        }
                        if([status intValue]==0)
                        {
                            accept.hidden=false;
                            decline.hidden=false;
                            acceptImg.hidden=false;
                            declineImage.hidden=false;

                        }
                        
                    }
                    }
                    break;
                    
                }
                    
                case 18:
                    
                {
                    
                    //Podcast Invitation accepted
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You" stringByAppendingString:[SavePrefrences sharedInstance].ntc18];
                    }
                    else{
                      tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc18];
                    }
                   
                    break;
                    
                }
                    
                case 19:
                {
                    
                    //NSLog(@"Podcast rejected");
                    NSArray * jsonObject=[manag convertojson:ar];
                    if([manag checkContaine:jsonObject])
                    {
                        
                        NSString*title1=[jsonObject valueForKey:@"title"];
                        tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc19] stringByAppendingString:title1];
                    }
                    else
                    {
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc19] ;
                    }
                    break;
                    
                }
                    
                case 20:
                {
                    //Podcast Application accepted
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You" stringByAppendingString:[SavePrefrences sharedInstance].ntc20];
                    }
                    else{
                          tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc20] ;
                    }
                    
                    break;
                    
                }
                    
                case 21:
                {
                    //Podcast Application rejected
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You" stringByAppendingString:[SavePrefrences sharedInstance].ntc21];
                    }
                    else{
                          tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc21] ;
                    }
                    
                    break;
                    
                }
                    
                case 22:
                {
                    //Podcast Postponed
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You" stringByAppendingString:[SavePrefrences sharedInstance].ntc23];
                    }
                    else{
                      tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc23] ;
                    }
                    
         
                    break;
                    
                }
                    
                case 24://file share
                {
                    
                    NSArray * jsonObject=[manag convertojson:ar];
                    
                    if([manag checkContaine:jsonObject])
                    {
                        NSString*title1=[jsonObject valueForKey:@"title"];
                        tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc24] stringByAppendingString:title1];
                    }
                    else
                    {
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc24];
                    }
                    break;
                    
                }
                    
                case 25:
                {
                    if([uid intValue]==[[SavePrefrences sharedInstance].uid intValue])
                    {
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;

                        tit= [@"You sent A friend Request " stringByAppendingString:[NSString stringWithFormat:@"%@",@""]];
                    }
                    else{
                    
                    NSArray * ff= [ar valueForKey:@"brdStstus"];
                    if(ff!=nil)
                    {
                        tit=[ff valueForKey:@"mes"];
                        time= [ff valueForKey:@"time"] ;
                        isFound=1;
                        accept.hidden=false;
                        decline.hidden=false;
                        acceptImg.hidden=false;
                        declineImage.hidden=false;

                        
                    }
                    else
                    {
                        tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc25] ;
                        if([status intValue]==0)
                        {
                            accept.hidden=false;
                            decline.hidden=false;
                            acceptImg.hidden=false;
                            declineImage.hidden=false;
                        }
                        else{
                            accept.hidden=true;
                            decline.hidden=true;
                            acceptImg.hidden=true;
                            declineImage.hidden=true;
                        }
                    }
                    }
                    
                    break;
                    
                }
                    
                case 26:
                {
                    //Friend Request Accepted
                    //fruid
                    
                    
                    if([uid intValue] ==[[SavePrefrences sharedInstance].uid intValue])
                    {
                              tit=[@"You " stringByAppendingString:[SavePrefrences sharedInstance].ntc26];
                    }
                    else{
                              tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc26];
                    }
              
                    break;
                    
                }
                    
                case 27:
                {
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You " stringByAppendingString:[SavePrefrences sharedInstance].ntc27];
                    }
                    else
                    {
                       tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc27];
                    }
                    
                    
                    //Friend Request Rejected
                    break;
                }
                case 28:
                {
                    //Jobs
                    break;
                }
                case 29:
                {
                    NSArray * jsonObject=[manag convertojson:ar];
                    NSString*title1=[jsonObject valueForKey:@"title"];
                    if([uid intValue]==[[SavePrefrences sharedInstance].uid intValue])
                    {
                        tit=[@"You applied for a " stringByAppendingString:[NSString stringWithFormat:@"%@ Project ",title1]];
                    }
                  else
                    {
                  // if([manag checkContaine:jsonObject])
                   // {
                        tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc29] stringByAppendingString:[NSString stringWithFormat:@"%@ Project ",title1] ];
                    //}
//                      else{
//                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc29];
//                    }
                    }
                    break;
                }
                    
                case 30:
                {
                    // jobs invitation accepted
                    if([uid intValue]==[[SavePrefrences sharedInstance].uid intValue])
                    {
                        tit=@"You accepted a project";
                    }
                    else
                      {
                         tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc30];
                    }
                    
                   
                    break;
                }
                case 31:
                {
                    //profile pic updated
                    if([uid intValue] ==[[SavePrefrences sharedInstance].uid intValue])
                    {
                        tit=[@"You " stringByAppendingString:[SavePrefrences sharedInstance].ntc31];
                    }
                    else{
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc31];
                    }
  
                    break;
                }
                case 32:
                 {
                    //profile pic updated
                 if([uid intValue] ==[[SavePrefrences sharedInstance].uid intValue])
                    {
                        tit=[@"You " stringByAppendingString:[SavePrefrences sharedInstance].ntc32];
                    }
                    else{
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc32];
                    }
                    
                    break;
                 }
                    
                    
                    
                    
                case 33://Calender Invitaion
                  {
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;

                        tit= [@"You shared a " stringByAppendingString:[NSString stringWithFormat:@"%@",@"calendar"]];
                    }
                    else
                    {
                    NSArray * ff= [ar valueForKey:@"brdStstus"];
                    if(ff!=nil)
                    {
                        tit=[ff valueForKey:@"mes"];
                        time= [ff valueForKey:@"time"] ;
                        isFound=1;
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;

                    }
                    
                    else
                    {
                        tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc33] ;
                        if([status intValue]==0)
                        {
                         //   accept.hidden=false;
                           // decline.hidden=false;
                        }
                        
                    }
                    }
                    break;
                    
                    
                }
                    
                case 34:  //Calender Event Invitaion
                {
                    
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;

                        tit= [@"You shared a " stringByAppendingString:[NSString stringWithFormat:@"%@",@"calendar Event"]];
                    }
                    else
                    {
                    NSArray * ff= [ar valueForKey:@"brdStstus"];
                    if(ff!=nil)
                    {
                        tit=[ff valueForKey:@"mes"];
                        time= [ff valueForKey:@"time"] ;
                        isFound=1;
                        accept.hidden=true;
                        decline.hidden=true;
                        acceptImg.hidden=true;
                        declineImage.hidden=true;

                    }
                    else
                    {
                        tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc33] ;
                        if([status intValue]==0)
                        {
                            //accept.hidden=false;
                            //decline.hidden=false;
                        }
                    }
                    }
                    break;
                }
                case 35: // CalenderInvitation accepted
                {
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You " stringByAppendingString:[SavePrefrences sharedInstance].ntc35];
                    }
                    else{
                         tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc35];
                    }
                   
                    break;
                }
                case 36:// calender Invitation Rejected
                {
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You " stringByAppendingString:[SavePrefrences sharedInstance].ntc36];
                    }
                    else
                    {
                    tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc36];
                    }
                    
                    break;
                }
                case 37: // Calender EventInvitation accepted
                {
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You " stringByAppendingString:[SavePrefrences sharedInstance].ntc37];
                    }
                    else{
                             tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc37];
                    }
               
                    break;
                }
                case 38: // Calender Event Invitation Rejected
                {
                    
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You " stringByAppendingString:[SavePrefrences sharedInstance].ntc38];
                    }
                    else{
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc38];
                    }
                   
                    break;
                }
               case 1001: // Calender Event Invitation Rejected
                {
                    
                    accept.hidden=true;
                    decline.hidden=true;
                    acceptImg.hidden=true;
                    declineImage.hidden=true;
                    if(uid ==[SavePrefrences sharedInstance].uid)
                    {
                        tit=[@"You " stringByAppendingString:[SavePrefrences sharedInstance].ntc1001];
                    }
                    else{
                        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc1001];
                    }
                    
                    break;
                }
            }
                //78:119:145 //153:153:153
                
                //here
                NSString *yourString = SAFESTRING(tit);//@"This is to be bold. This is normal string.";
                NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
                NSString *boldString = uname;//@"This is to be bold";
                NSRange boldRange = [yourString rangeOfString:boldString];
                [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:boldRange];
                [request setAttributedText: yourAttributedString];
                
                if ([yourString hasPrefix:@"You"])
                {
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:request.text];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] range:NSMakeRange(0, [tit length])];
                    request.attributedText = string;

                }
                else
                {
                    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:SAFESTRING(request.text)];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f] range:NSMakeRange(0,[boldString length])];
                    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] range:NSMakeRange([boldString length],[request.text length]-[boldString length])];
                    request.attributedText = string;
                    
                    
                }
                
                //[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            //request.text=tit;
            user_lbl.text=uname;
            accept.tag=indexPath.row;
            decline.tag=indexPath.row;
            
            [accept addTarget:self action:@selector(accept:) forControlEvents:UIControlEventTouchUpInside];
            [decline addTarget:self action:@selector(decline:) forControlEvents:UIControlEventTouchUpInside];
            
            NSLog(@"timmm===%@",time);
            
            if(isFound==1)
            {
                timlb.text=[NSString stringWithFormat:@"%@",time];
            }
            else
            {
                timlb.text=[NSString stringWithFormat:@"%@",time];
            }
            
        }
          scrollpostion= notiTableView.contentOffset.y+600;
        if([[ar  valueForKey:@"uid"] integerValue]!=[[SavePrefrences sharedInstance].uid intValue])
        {
            btnChat.hidden = NO;
            
        }
        else{
          btnChat.hidden = YES;
        }
        
       return cell;
        
    }
    
    @catch (NSException *exception)
       {
        NSLog(@"exception is===%@",exception);
       }
    
    @finally {
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
   {
    return 85;
   }

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
   {
    
   }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
   {
      NSLog(@"row selected=======%d",(int)indexPath.row);
   }

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
  {
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    if (maximumOffset - currentOffset <= -30)
    {
        limit=limit+1;
        [self getYokingData];
        
    }
}

-(IBAction)accept:(id)sender
{
    
    UIButton * btn=(UIButton *)sender;
    
    UITableViewCell *cell =(UITableViewCell *) [[btn superview]superview];
    NSIndexPath *seletedIndex = [notiTableView indexPathForCell:cell];
    UIButton *accpt=[acceptAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UIButton *rejct=[rejAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UILabel *title=[titleAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    //NSArray *arrData  = [dictionaryByDate allKeys];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSArray *arrData  = [dictionaryByDate allKeys];
    
    
    
    NSMutableArray *arrKeys = [arrData sortedArrayUsingComparator:^NSComparisonResult(NSString *strDate1, NSString *strDate2) {
        NSDate *d1 =[formatter dateFromString:strDate1];
        NSDate *d2 =[formatter dateFromString:strDate2];
        //NSDate *d2 = obj2[@"date"];
        
       // return [d1 compare:d2]; // ascending order
        return [d2 compare:d1]; // descending order
    }];
    
    NSString *strKey = [arrKeys objectAtIndex:seletedIndex.section];
    NSMutableArray *arr = [dictionaryByDate objectForKey:strKey];
    NSArray *ar = [arr objectAtIndex:seletedIndex.row];

   // NSArray * ar=[notiAr1 objectAtIndex:(int)btn.tag];
    NSString *frid=[ar valueForKey:@"uid"];
    int ntc= [[ar valueForKey:@"ntc"] intValue];
    noti_id=[ar valueForKey:@"noti_id"];
    NSLog(@"ntc====%d",ntc);
    
    if(ntc==9 )//board
    {
//        accpt.hidden=true;
//        rejct.hidden=true;
        NSArray * jsonObject=[manag convertojson:ar];
        
        NSString *brdid;
        NSString *titled;
        
        if([manag checkContaine:jsonObject])
        {
            brdid=[jsonObject valueForKey:@"brdID"];
            titled=[jsonObject valueForKey:@"title"];
            //title.text=[@"You have Accept The Board Invitation "stringByAppendingString:titled];
        }
        else
        {
            brdid=[jsonObject valueForKey:@"brdID"];
          //  title.text=@"You have Accept The Board Invitation";
        }
        
   
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic setObject:@"1" forKey:@"ar"];
        [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"b_id"];
        [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
        iscallback=9;
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"brdAR" :@"" :@"" :dic :self];
        
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] count];x++)
//        {
//            
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            NSString *prevbrdid=[jsonObject valueForKey:@"brdID"];
//            if([brdid intValue]==[prevbrdid intValue])
//             {
//                
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] removeObjectAtIndex:x];
//            }
//        }
//      
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        [dic2 setValue:@" You have Accepted The Board Invitation " forKey:@"mes"];
//        [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
        
       }
    
    else if(ntc==10){
//        accpt.hidden=true;
//        rejct.hidden=true;
        
        
        NSArray * jsonObject=[manag convertojson:ar];
        NSString *brdid,*titled;
        if([manag checkContaine:jsonObject]){
            brdid=[jsonObject valueForKey:@"brdID"];
            titled=[jsonObject valueForKey:@"title"];
           // title.text=[@"You have Accept The Board Application "stringByAppendingString:titled];
        }
        else{
            brdid=[jsonObject valueForKey:@"brdID"];
          //  title.text=@"You have Accept The Board Application ";
        }
        
       // NSString *frid=[ar valueForKey:@"uid"];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic setObject:@"1" forKey:@"ar"];
        [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"b_id"];
        [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
        iscallback=10;
        
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"brdJAR" :@"" :@"" :dic :self];
        
        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] count];x++)
        {
            
            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] objectAtIndex:x];
            NSArray * jsonObject=[manag convertojson:data];
            NSString *prevbrdid=[jsonObject valueForKey:@"brdID"];
            if([brdid intValue]==[prevbrdid intValue])
            {
                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] removeObjectAtIndex:x];
            }
            
        }
//         NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//         [dic2 setValue:[NSDate date] forKey:@"time"];
//         [dic2 setValue:@" You have Accepted The Board Application " forKey:@"mes"];
//        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
      }
    
    else if(ntc==16)
      {
        
//        accpt.hidden=true;
//        rejct.hidden=true;
        NSArray * jsonObject=[manag convertojson:ar];
        NSString *brdid,*titled;
        if([manag checkContaine:jsonObject])
        {
            brdid=[jsonObject valueForKey:@"podId"];
            titled=[jsonObject valueForKey:@"title"];
           // title.text=[@"You have Accepted The Podcast "stringByAppendingString:titled];
        }
        else
        {
            brdid=[jsonObject valueForKey:@"podId"];
           // title.text=@"You have Accepted The Podcast";
        }
        
        
      //  NSString *frid=[ar valueForKey:@"uid"];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:brdid forKey:@"podId"];
        [dic setObject:frid forKey:@"uidFrom"];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic setObject:@"1" forKey:@"affectedRows"];
        
          iscallback=16;
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podAR" :@"" :@"" :dic :self];
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] count];x++)
//        {
//            
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            NSString *prevbrdid=[jsonObject valueForKey:@"podId"];
//            if([brdid intValue]==[prevbrdid intValue])
//            {
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] removeObjectAtIndex:x];
//            }
//            
//        }
//        
//        //NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        
//        [dic2 setValue:@" You have Accept Pod Invitation " forKey:@"mes"];
//        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
      }
    
    else if(ntc==17)
        
    {
        
//        accpt.hidden=true;
//        rejct.hidden=true;
        
        
        NSArray * jsonObject=[manag convertojson:ar];
        
        NSString *brdid,*titled;
        if([manag checkContaine:jsonObject])
        {
            brdid=[jsonObject valueForKey:@"podId"];
            titled=[jsonObject valueForKey:@"title"];
           // title.text=[@"You have Accepted Podcast Join Request "stringByAppendingString:titled];
        }
        else
        {
            brdid=[jsonObject valueForKey:@"brdID"];
            //title.text=@"You have Accepted Podcast Join Request ";
        }
      //  NSString *frid=[ar valueForKey:@"uid"];
        
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:brdid forKey:@"podId"];
        
        [dic setObject:frid forKey:@"uidFrom"];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        
        [dic setObject:@"1" forKey:@"affectedRows"];
        
        iscallback=17;
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podAR1" :@"" :@"" :dic :self];
        
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] count];x++)
//        {
//            
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            
//            NSString *prevbrdid=[jsonObject valueForKey:@"podId"];
//            if([brdid intValue]==[prevbrdid intValue])
//            {
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] removeObjectAtIndex:x];
//                
//            }
//            
//        }
//        
//        //NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//        
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        
//        [dic2 setValue:[@" You have Accepted Podcast Join Request" stringByAppendingString:titled] forKey:@"mes"];
//        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
        
    }
    
    else if(ntc==25)
    {
        
//        title.text=@"You have Accepted the friend Request ";
//        
//        accpt.hidden=true;
//        
//        rejct.hidden=true;
        

        
     //   NSString *fruid=[ar valueForKey:@"uid"];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        
        
        [dic setObject:frid forKey:@"fruid"];
        
        [dic setObject:@"1" forKey:@"ar"];
        
        [dic setObject:noti_id forKey:@"notiId"];
        iscallback=25;
        
        [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"frAccept" :@"" :@"" :dic :self];
        NSString* notiCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"YOLKING_COUNT"];
        int unreadMsg = notiCount.intValue;
        unreadMsg = unreadMsg-1;
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", unreadMsg] forKey:@"YOLKING_COUNT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        int newcount= [[SavePrefrences sharedInstance].yokingcount intValue]-1;
//        NSLog(@"countar====%d",newcount);
//        [SavePrefrences sharedInstance].yokingcount=[NSString stringWithFormat:@"%d",newcount];
//       
//        
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        
//        [dic2 setValue:@" You have Accepted the friend Request " forKey:@"mes"];
//        
//       // [[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//        
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
        
    }
    
    else if(ntc==33)//calendar created
    {
        
//        title.text=@"You have Accepted the Calander Invitation ";
//        accpt.hidden=true;
//        rejct.hidden=true;
        NSArray * jsonObject=[manag convertojson:ar];
        NSString *eventId;
        NSString *titled;
        
        if([manag checkContaine:jsonObject])
        {
            eventId=[jsonObject valueForKey:@"calId"];
            titled=[jsonObject valueForKey:@"title"];
           // title.text=[@"You have Accepted The calendar Invitation "stringByAppendingString:titled];
        }
        else
        {
            eventId=[jsonObject valueForKey:@"calId"];
           // title.text=@"You have Accepted The calendar Invitation ";
        }
      //  NSString *fruid=[ar valueForKey:@"uid"];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic setObject:frid forKey:@"uidFrom"];
        [dic setObject:@"1" forKey:@"ar"];
        [dic setObject:eventId forKey:@"calId"];
        iscallback=33;
        [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"calAR" :@"" :@"" :dic :self];
        
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] count];x++)
//          {
//            
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            
//            NSString *prevbrdid=[jsonObject valueForKey:@"calId"];
//            if([eventId intValue]==[prevbrdid intValue])
//            {
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] removeObjectAtIndex:x];
//                
//            }
//            
//          }
//        
//       // NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        [dic2 setValue:@" You have Accepted the Calendar Invitation " forKey:@"mes"];
//        
//       // [[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//        
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
        
    }
    else if(ntc==34)//calendar event share
    {
//        title.text=@"You have Accepted the Calander Event ";
//        accpt.hidden=true;
//        rejct.hidden=true;
        iscallback=34;
        
        NSArray * jsonObject=[manag convertojson:ar];
        
        NSString *eventId;
        NSString *titled;
        
        if([manag checkContaine:jsonObject])
        {
            eventId=[jsonObject valueForKey:@"eventId"];
            titled=[jsonObject valueForKey:@"title"];
            //title.text=[@"You have Accepted The calendar Event "stringByAppendingString:titled];
        }
        else
        {
            eventId=[jsonObject valueForKey:@"eventId"];
           // title.text=@"You have Accepted The calendar Event";
        }
       // NSString *fruid=[ar valueForKey:@"uid"];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic setObject:frid forKey:@"uidFrom"];
        [dic setObject:@"1" forKey:@"ar"];
        [dic setObject:eventId forKey:@"eventId"];
        iscallback=34;
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"calEAR" :@"" :@"" :dic :self];
        
        
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] count];x++)
//        {
//            
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            
//            NSString *prevbrdid=[jsonObject valueForKey:@"eventId"];
//            if([eventId intValue]==[prevbrdid intValue])
//            {
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] removeObjectAtIndex:x];
//                
//            }
//            
//        }
//        
//        
//        //NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        [dic2 setValue:@" You have Accepted the Calendar Invitation " forKey:@"mes"];
//        
//        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//       
        
        
    }
}

-(IBAction)decline:(id)sender{
    
    UIButton * btn=(UIButton *)sender;
    
    UIButton *accpt=[acceptAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    
    UIButton *rejct=[rejAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    
    UILabel *title=[titleAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
      [formatter setDateFormat:@"MMM dd,yyyy"];
      NSArray *arrData  = [dictionaryByDate allKeys];
      
      UITableViewCell *cell =(UITableViewCell *) [[btn superview]superview];
      NSIndexPath *seletedIndex = [notiTableView indexPathForCell:cell];
      
      NSMutableArray *arrKeys = [arrData sortedArrayUsingComparator:^NSComparisonResult(NSString *strDate1, NSString *strDate2) {
          NSDate *d1 =[formatter dateFromString:strDate1];
          NSDate *d2 =[formatter dateFromString:strDate2];
          //NSDate *d2 = obj2[@"date"];
          
          //return [d1 compare:d2]; // ascending order
          return [d2 compare:d1]; // descending order
      }];
      
      NSString *strKey = [arrKeys objectAtIndex:seletedIndex.section];
      NSMutableArray *arr = [dictionaryByDate objectForKey:strKey];
      NSArray *ar = [arr objectAtIndex:seletedIndex.row];

    
    int ntc= [[ar valueForKey:@"ntc"] intValue];
    noti_id=[ar valueForKey:@"noti_id"];
        NSString *frid=[ar valueForKey:@"uid"];
    
    
    if(ntc==9)//board
    {
        
//        accpt.hidden=true;
//        rejct.hidden=true;
        NSArray * jsonObject=[manag convertojson:ar];
        
        NSString *brdid,*titled;
        if([manag checkContaine:jsonObject])
        {
            brdid=[jsonObject valueForKey:@"brdID"];
            titled=[jsonObject valueForKey:@"title"];
        //    title.text=[@"You have Rejected The Board Invitation "stringByAppendingString:titled];
        }
        else
        {
            brdid=[jsonObject valueForKey:@"brdID"];
         //   title.text=@"You have Rejected The Board Invitation";
        }
        
        //NSString *frid=[ar valueForKey:@"uid"];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        
        [dic setObject:@"2" forKey:@"ar"];
        
        [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"b_id"];
        
        [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
        iscallback=9;
        
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"brdAR" :@"" :@"" :dic :self];
        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] count];x++)
        {
            
            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] objectAtIndex:x];
            NSArray * jsonObject=[manag convertojson:data];
            NSString *prevbrdid=[jsonObject valueForKey:@"brdID"];
            
            if([brdid intValue]==[prevbrdid intValue])
            {
                
                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] removeObjectAtIndex:x];
                
            }
            
        }
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        [dic2 setValue:@" You have Rejected The Board Invitation " forKey:@"mes"];
//        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
    }
    
    else if(ntc==10)
    {
        
//        accpt.hidden=true;
//        
//        rejct.hidden=true;
       
        NSArray * jsonObject=[manag convertojson:ar];
        
        NSString *brdid,*titled;
        if([manag checkContaine:jsonObject])
        {
            brdid=[jsonObject valueForKey:@"brdID"];
            titled=[jsonObject valueForKey:@"title"];
           // title.text=[@"You have Rejected The Board Application "stringByAppendingString:titled];
        }
        else
        {
            brdid=[jsonObject valueForKey:@"brdID"];
          //  title.text=@"You have Rejected The Board Application ";
        }
        
       // NSString *frid=[ar valueForKey:@"uid"];
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        
        [dic setObject:@"2" forKey:@"ar"];
        
        [dic setObject:[NSString stringWithFormat:@"%@",brdid] forKey:@"b_id"];
        
        [dic setObject:[NSString stringWithFormat:@"%@", frid] forKey:@"uidFrom"];
        iscallback=10;
        
        [[SavePrefrences sharedInstance].skthand emitData:@"MyBoard" :@"brdJAR" :@"" :@"" :dic :self];
        
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] count];x++)
//        {
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            NSString *prevbrdid=[jsonObject valueForKey:@"brdID"];
//            if([brdid intValue]==[prevbrdid intValue])
//            {
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"9"] removeObjectAtIndex:x];
//            }
//        }
//        
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        [dic2 setValue:@" You have Rejected The Board Application " forKey:@"mes"];
//        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
    }
    
    
    
    else if(ntc==16)
        
    {
//        
//        accpt.hidden=true;
//        rejct.hidden=true;
        NSArray * jsonObject=[manag convertojson:ar];
        
        NSLog(@"json back====%@",jsonObject);
        
        NSString *brdid,*titled;
        if([manag checkContaine:jsonObject])
        {
            brdid=[jsonObject valueForKey:@"podId"];
            titled=[jsonObject valueForKey:@"title"];
           // title.text=[@"You have Rjected The Podcast "stringByAppendingString:titled];
        }
        else
        {
            brdid=[jsonObject valueForKey:@"podId"];
          //  title.text=@"You have Rejected The Podcast ";
        }
        
        
       // NSString *frid=[ar valueForKey:@"uid"];
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:brdid forKey:@"podId"];
        
        [dic setObject:frid forKey:@"uidFrom"];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        
        [dic setObject:@"2" forKey:@"affectedRows"];
        iscallback=16;
        
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podAR" :@"" :@"" :dic :self];
        
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] count];x++)
//        {
//            
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            NSString *prevbrdid=[jsonObject valueForKey:@"podId"];
//            if([brdid intValue]==[prevbrdid intValue])
//            {
//                
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] removeObjectAtIndex:x];
//                
//            }
//            
//        }
//        
//       // NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        [dic2 setValue:@" You have Rejected Podcast Invitation " forKey:@"mes"];
//        
//       // [[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
    }
    
    else if(ntc==17)
    {
        
//        accpt.hidden=true;
//        rejct.hidden=true;
        NSArray * jsonObject=[manag convertojson:ar];
        NSString *brdid,*titled;
        if([manag checkContaine:jsonObject])
        {
            brdid=[jsonObject valueForKey:@"podId"];
            titled=[jsonObject valueForKey:@"title"];
           // title.text=[@" You have Rejected podcast Join request "stringByAppendingString:titled];
        }
        else
        {
            brdid=[jsonObject valueForKey:@"podId"];
          //  title.text=@" You have Rejected podcast Join request ";
        }
        
        //NSString *frid=[ar valueForKey:@"uid"];
        
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:brdid forKey:@"podId"];
        
        [dic setObject:frid forKey:@"uidFrom"];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        
        [dic setObject:@"2" forKey:@"affectedRows"];
        
        iscallback=17;
        [[SavePrefrences sharedInstance].skthand emitData:@"MyPodcast" :@"podAR1" :@"" :@"" :dic :self];
        
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] count];x++)
//        {
//            
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            
//            NSString *prevbrdid=[jsonObject valueForKey:@"podId"];
//            if([brdid intValue]==[prevbrdid intValue])
//            {
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"16"] removeObjectAtIndex:x];
//                
//            }
//        }
//        
//       // NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//        
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        [dic2 setValue:[@" You have Rejected podcast Join request" stringByAppendingString:titled] forKey:@"mes"];
//        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//        
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
    }
    
    else if(ntc==25)
    {
        
//        title.text=@"You have Rejected the friend Request ";
//        
//        accpt.hidden=true;
//        
//        rejct.hidden=true;
        
        //NSString *fruid=[ar valueForKey:@"uid"];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        
        [dic setObject:frid forKey:@"fruid"];
        
        [dic setObject:noti_id forKey:@"notiId"];
        iscallback=25;
        
        [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"frBlock" :@"" :@"" :dic :self];
        
        NSString* notiCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"YOLKING_COUNT"];
        int unreadMsg = notiCount.intValue;
        unreadMsg = unreadMsg-1;
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", unreadMsg] forKey:@"YOLKING_COUNT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        int newcount= [[SavePrefrences sharedInstance].yokingcount intValue]-1;
//        NSLog(@"countar====%d",newcount);
//        [SavePrefrences sharedInstance].yokingcount=[NSString stringWithFormat:@"%d",newcount];
//        
//        
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        
//        [dic2 setValue:@" You have Rejected the friend Request " forKey:@"mes"];
//        
//       //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//        [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
        
    }
    
    
    else if(ntc==33)
    {
        
//        title.text=@"You have Rejected the Calander Invitation ";
//        accpt.hidden=true;
//        rejct.hidden=true;
     
        NSArray * jsonObject=[manag convertojson:ar];
        NSString *eventId;
        NSString *titled;
        
        if([manag checkContaine:jsonObject])
        {
            eventId=[jsonObject valueForKey:@"calId"];
            titled=[jsonObject valueForKey:@"title"];
           // title.text=[@"You have Rejected The calendar Invitation "stringByAppendingString:titled];
        }
        else
        {
            eventId=[jsonObject valueForKey:@"calId"];
            //title.text=@"You have Rejected The calendar Invitation ";
        }
     //   NSString *fruid=[ar valueForKey:@"uid"];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic setObject:frid forKey:@"uidFrom"];
        [dic setObject:@"2" forKey:@"ar"];
        [dic setObject:eventId forKey:@"calId"];
        iscallback=33;
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"calAR" :@"" :@"" :dic :self];
        
//        
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] count];x++)
//        {
//            
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            
//            NSString *prevbrdid=[jsonObject valueForKey:@"calId"];
//            if([eventId intValue]==[prevbrdid intValue])
//            {
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] removeObjectAtIndex:x];
//                
//            }
//            
//        }
//
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        [dic2 setValue:@" You have Rejected the Calendar Invitation " forKey:@"mes"];
//        
//        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//         [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
        
    }
    else if(ntc==34)
    {
       // title.text=@"You have Accepted the Calander Event ";
//        accpt.hidden=true;
//        rejct.hidden=true;

        
        NSArray * jsonObject=[manag convertojson:ar];
        
        NSString *eventId;
        NSString *titled;
        
        if([manag checkContaine:jsonObject])
        {
            eventId=[jsonObject valueForKey:@"eventId"];
            titled=[jsonObject valueForKey:@"title"];
           // title.text=[@"You have Rejected The calendar Event "stringByAppendingString:titled];
        }
        else
        {
            eventId=[jsonObject valueForKey:@"eventId"];
          //  title.text=@"You have Rejected The calendar Event ";
        }
        
      //  NSString *fruid=[ar valueForKey:@"uid"];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic setObject:frid forKey:@"uidFrom"];
        [dic setObject:@"2" forKey:@"ar"];
        [dic setObject:eventId forKey:@"eventId"];
        
        iscallback=34;
        [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"calEAR" :@"" :@"" :dic :self];
        
        
//        for(int x=0;x<[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] count];x++)
//        {
//            
//            NSArray *data =[[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] objectAtIndex:x];
//            NSArray * jsonObject=[manag convertojson:data];
//            NSString *prevbrdid=[jsonObject valueForKey:@"eventId"];
//            if([eventId intValue]==[prevbrdid intValue])
//            {
//                [(NSMutableArray *)[[SavePrefrences sharedInstance].allNotifictionDic valueForKey:@"33"] removeObjectAtIndex:x];
//                
//            }
//        }
//        //NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//        NSMutableDictionary * dic2=[[NSMutableDictionary alloc]init];
//        [dic2 setValue:[NSDate date] forKey:@"time"];
//        [dic2 setValue:@" You have Rejected the Calendar Invitation " forKey:@"mes"];
//        //[[[SavePrefrences sharedInstance].notiYolkingAr objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
//        [[notiAr1 objectAtIndex:(int)btn.tag] setValue:dic2 forKey:@"brdStstus"];
        
    }
    
}

-(void) callBack:(NSArray *)meta :(NSArray *)data{
    //    NSLog(@"Yolking =====iscallback====%d",iscallback);
    //    NSLog(@"Yolking =====1====%@",meta);
    //    NSLog(@"Yolking data=====1====%@",data);
    NSMutableArray* boardNotifications = [NSMutableArray arrayWithCapacity:0];
    if (iscallback==88) {//GOT FRIENDS LIST
        NSDictionary* dict = (NSDictionary*)meta;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.allFriends = dict[@"fr"];
        [notiAr1 removeAllObjects];
        [self getYokingData1];
        return;
    }
    if(iscallback==1){
        for (NSMutableDictionary *dictData in data) {
            NSString *strDate = [dictData objectForKey:@"time"];
            __block NSDate *detectedDate;
            
            //Detect.
            NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingAllTypes error:nil];
            [detector enumerateMatchesInString:strDate
                                       options:kNilOptions
                                         range:NSMakeRange(0, [strDate length])
                                    usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop){
                 detectedDate = result.date;
                 NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                 dateFormatter.dateFormat = @"MMM dd,yyyy";
                 [dictData setObject:result.date forKey:@"date"];
                 [dictData setObject:[dateFormatter stringFromDate:result.date] forKey:@"CreatedDate"];
                 [notiAr1 addObject:dictData];
             }];
            
            if ([dictData[@"ntc"] intValue] == 9 || [dictData[@"ntc"] intValue] == 10) {
                if((!dictData[@"status"]) || ([dictData[@"status"] intValue]==0)){
                    if ([dictData[@"uid"] intValue]!=[[SavePrefrences sharedInstance].uid intValue]) {
                    [boardNotifications addObject:dictData];
                    }
                }
            }
        }
        if (boardNotifications.count) {
            [[NSUserDefaults standardUserDefaults] setValue:boardNotifications forKey:@"BOARD_NOTIF_COUNT"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        dictionaryByDate = [NSMutableDictionary new];
        for(NSDictionary *dictionary in notiAr1){
            NSString *dateString = dictionary[@"CreatedDate"];
            NSDate  *date = dictionary[@"CreatedDate"];
            NSMutableArray *arrayWithSameDate = dictionaryByDate[dateString];
            if(! arrayWithSameDate){
                arrayWithSameDate = [NSMutableArray new];
                dictionaryByDate[dateString] = arrayWithSameDate;
            }
            [arrayWithSameDate addObject: dictionary];
        }
        
        for (NSString *strData in [dictionaryByDate allKeys]) {
            NSMutableArray *arrData  = [dictionaryByDate objectForKey:strData];
            NSArray* reversedArray = [[arrData reverseObjectEnumerator] allObjects];
            
            NSMutableArray *aTempArr = [NSMutableArray array];
            [reversedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"ID:%@",obj[@"noti_id"]);
                NSInteger existingIndex = [aTempArr indexOfObjectPassingTest:^BOOL(id  _Nonnull objInternal, NSUInteger idx, BOOL * _Nonnull stop) {
                    return [objInternal[@"noti_id"] isEqualToString:obj[@"noti_id"]];
                }];
                if(existingIndex == NSNotFound){
                    [aTempArr addObject:obj];
                }
            }];
            [dictionaryByDate setObject:aTempArr forKey:strData];

        }

        if([data count]>0){
            for(int x=(int)[data count]-1; x>=0; x--){
                NSString *status=[[data valueForKey:@"status"] objectAtIndex:x];
                NSString *ntc=[[data valueForKey:@"ntc"] objectAtIndex:x];
                
                
                if([ntc intValue]==25){
                    if ([[[data valueForKey:@"uid"] objectAtIndex:x]integerValue]!=[[SavePrefrences sharedInstance].uid integerValue]) {
                        if(status==nil||status==NULL||[status isEqual:[NSNull null]]||status == (id)[NSNull null]){
                            ykcount++;
                            status=@"0";
                        }else if([status isEqual:@"Undefined"]){
                            ykcount++;
                            status=@"0";
                        }else if([status intValue]==0){
                            ykcount++;
                        }
                    }
                }
                
                [notiAr1 addObject:[data objectAtIndex:x]];
                
                if([ntc intValue]==9){
                    if ([[[data valueForKey:@"uid"] objectAtIndex:x]integerValue]!=[[SavePrefrences sharedInstance].uid integerValue]) {
                        if(status==nil||status==NULL||[status isEqual:[NSNull null]]||status == (id)[NSNull null]){
                            ykcount++;
                            status=@"0";
                        }else if([status isEqual:@"Undefined"]){
                            ykcount++;
                            status=@"0";
                        }else if([status intValue]==0){
                            ykcount++;
                        }
                    }
                }
            }
            
            
            
            NSLog(@"yoking count-====%d",ykcount);
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", ykcount] forKey:@"YOLKING_COUNT"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            [SavePrefrences sharedInstance].yokingcount=[NSString stringWithFormat:@"%d",ykcount];
            
            [notiTableView reloadData];
            //[notiTableView setContentOffset:CGPointMake(0,scrollpostion)];
        }else{
            [self showAlert:@"No More Data Found"];
            return;
        }
    }
    else if(iscallback==9)//board
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:@"bd" forKey:@"aid"];
        NSMutableArray * ar=[[NSMutableArray alloc]init];
        [ar addObject:noti_id];
        [dic setObject:ar forKey:@"notiIds"];
        
        NSArray* boardNotifs = [[NSUserDefaults standardUserDefaults] valueForKey:@"BOARD_NOTIF_COUNT"];
        NSMutableArray* boardNotifsChanged = boardNotifs.mutableCopy;
        NSDictionary* callMeta = (NSDictionary*)meta;
        for (NSDictionary* notif in boardNotifs) {
            NSString* boardID = [NSString stringWithFormat:@"%@", callMeta[@"data"][@"b_id"]];
            NSString* notifBoardID = [NSString stringWithFormat:@"%@", notif[@"message"][@"brdID"]];
            NSString* userID = [NSString stringWithFormat:@"%@", callMeta[@"data"][@"uidFrom"]];
            NSString* notifUserID = [NSString stringWithFormat:@"%@", notif[@"uid"]];
            if ([boardID isEqualToString:notifBoardID] && [userID isEqualToString:notifUserID]) {
                [boardNotifsChanged removeObject:notif];
                NSString* notiCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"YOLKING_COUNT"];
                int unreadMsg = notiCount.intValue;
                if (unreadMsg) unreadMsg = unreadMsg-1;
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", unreadMsg] forKey:@"YOLKING_COUNT"];
            }
        }
        [[NSUserDefaults standardUserDefaults] setValue:boardNotifsChanged forKey:@"BOARD_NOTIF_COUNT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
        
        [notiAr1 removeAllObjects];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self getYokingData1];
        });
        
    }
    else if(iscallback==10)//board app
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:@"bd" forKey:@"aid"];
        NSMutableArray * ar=[[NSMutableArray alloc]init];
        [ar addObject:noti_id];
        [dic setObject:ar forKey:@"notiIds"];
        
        NSArray* boardNotifs = [[NSUserDefaults standardUserDefaults] valueForKey:@"BOARD_NOTIF_COUNT"];
        NSMutableArray* boardNotifsChanged = boardNotifs.mutableCopy;
        NSDictionary* callMeta = (NSDictionary*)meta;
        for (NSDictionary* notif in boardNotifs) {
            NSString* boardID = [NSString stringWithFormat:@"%@", callMeta[@"data"][@"b_id"]];
            NSString* notifBoardID = [NSString stringWithFormat:@"%@", notif[@"message"][@"brdID"]];
            NSString* userID = [NSString stringWithFormat:@"%@", callMeta[@"data"][@"uidFrom"]];
            NSString* notifUserID = [NSString stringWithFormat:@"%@", notif[@"uid"]];
            if ([boardID isEqualToString:notifBoardID] && [userID isEqualToString:notifUserID]) {
                [boardNotifsChanged removeObject:notif];
                NSString* notiCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"YOLKING_COUNT"];
                int unreadMsg = notiCount.intValue;
                if (unreadMsg) unreadMsg = unreadMsg-1;
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", unreadMsg] forKey:@"YOLKING_COUNT"];
            }
        }
        [[NSUserDefaults standardUserDefaults] setValue:boardNotifsChanged forKey:@"BOARD_NOTIF_COUNT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
        
        [notiAr1 removeAllObjects];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self getYokingData1];
        });
        
    }
    else if(iscallback==16)//pod
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:@"bd" forKey:@"aid"];
        NSMutableArray * ar=[[NSMutableArray alloc]init];
        [ar addObject:noti_id];
        [dic setObject:ar forKey:@"notiIds"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
        
        
        [notiAr1 removeAllObjects];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self getYokingData1];
        });
    }
    else if(iscallback==17)//pod
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:@"bd" forKey:@"aid"];
        NSMutableArray * ar=[[NSMutableArray alloc]init];
        [ar addObject:noti_id];
        [dic setObject:ar forKey:@"notiIds"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
        
        
        [notiAr1 removeAllObjects];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self getYokingData1];
        });
    }
    else if(iscallback==25)//friend reuest
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:@"bd" forKey:@"aid"];
        NSMutableArray * ar=[[NSMutableArray alloc]init];
        [ar addObject:noti_id];
        [dic setObject:ar forKey:@"notiIds"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
        
        
        [notiAr1 removeAllObjects];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self getYokingData1];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self retreiveFriends];
        });
    }
    else if(iscallback==33)//calendar
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:@"bd" forKey:@"aid"];
        NSMutableArray * ar=[[NSMutableArray alloc]init];
        [ar addObject:noti_id];
        [dic setObject:ar forKey:@"notiIds"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
        
        [notiAr1 removeAllObjects];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self getYokingData1];
        });
        
    }
    
    else if(iscallback==34)//cal event
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic setObject:@"bd" forKey:@"aid"];
        NSMutableArray * ar=[[NSMutableArray alloc]init];
        [ar addObject:noti_id];
        [dic setObject:ar forKey:@"notiIds"];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
        
        
        [notiAr1 removeAllObjects];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self getYokingData1];
        });
        
        
        
        
    }
    else if(iscallback==13)//cal event
    {
        CommonProfile *cmpop=[[CommonProfile alloc]init];
        cmpop.flag  = 101;
        [ cmpop addProfileimage:data :[friendid intValue] :vc1] ;
        
    }
    
    else if(iscallback==101)
    {
        for (NSMutableDictionary *dictData in data) {
            NSString *strDate = [dictData objectForKey:@"time"];
            //NSString *dateString = @"Wed, 03 Jul 2013 02:16:02 -0700";
            __block NSDate *detectedDate;
            
            //Detect.
            NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingAllTypes error:nil];
            [detector enumerateMatchesInString:strDate
                                       options:kNilOptions
                                         range:NSMakeRange(0, [strDate length])
                                    usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
             {
                 detectedDate = result.date;
                 
                 
                 
                 
                 NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                 
                 dateFormatter.dateFormat = @"MMM dd,yyyy";
                 [dictData setObject:result.date forKey:@"date"];
                 [dictData setObject:[dateFormatter stringFromDate:result.date] forKey:@"CreatedDate"];
                 [notiAr1 addObject:dictData];
                 
                 
                 
             }
             
             ];
            
            
            
        }
        
        
        
        
        
        dictionaryByDate = [NSMutableDictionary new];
        
        for(NSDictionary *dictionary in notiAr1)
        {
            NSString *dateString = dictionary[@"CreatedDate"];
            NSDate  *date = dictionary[@"CreatedDate"];
            NSMutableArray *arrayWithSameDate = dictionaryByDate[dateString];
            if(! arrayWithSameDate)
            {
                arrayWithSameDate = [NSMutableArray new];
                dictionaryByDate[dateString] = arrayWithSameDate;
            }
            [arrayWithSameDate addObject: dictionary];
        }
        
        
        for (NSString *strData in [dictionaryByDate allKeys]) {
            NSMutableArray *arrData  = [dictionaryByDate objectForKey:strData];
            NSArray* reversedArray = [[arrData reverseObjectEnumerator] allObjects];
            
            NSMutableArray *aTempArr = [NSMutableArray array];
            [reversedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"ID:%@",obj[@"noti_id"]);
                NSInteger existingIndex = [aTempArr indexOfObjectPassingTest:^BOOL(id  _Nonnull objInternal, NSUInteger idx, BOOL * _Nonnull stop) {
                    return [objInternal[@"noti_id"] isEqualToString:obj[@"noti_id"]];
                }];
                if(existingIndex == NSNotFound){
                    [aTempArr addObject:obj];
                }
            }];
            [dictionaryByDate setObject:aTempArr forKey:strData];

        }
        
        
        if([data count]>0)
        {

            for(int x=(int)[data count]-1; x>=0; x--)
            {
                NSString *status=[[data valueForKey:@"status"] objectAtIndex:x];
                NSString *ntc=[[data valueForKey:@"ntc"] objectAtIndex:x];
                
                
                if([ntc intValue]==25)
                {
                    if(status==nil||status==NULL||[status isEqual:[NSNull null]]||status == (id)[NSNull null])
                    {
                        ykcount++;
                        status=@"0";
                    }
                    else if([status isEqual:@"Undefined"])
                    {
                        ykcount++;
                        status=@"0";
                    }
                    else if([status intValue]==0)
                    {
                        ykcount++;
                    }
                }
                [notiAr1 addObject:[data objectAtIndex:x]];
                
            }
            
            NSLog(@"yoking count-====%d",ykcount);
            
            [SavePrefrences sharedInstance].yokingcount=[NSString stringWithFormat:@"%d",ykcount];
            
            [notiTableView reloadData];
            //[notiTableView setContentOffset:CGPointMake(0,scrollpostion)];
        }
//        else
//        {
//            [self showAlert:@"No More Data Found"];
//        }
        
        //  ykcount--;
        
        //NSLog(@"yoking removed====%d",ykcount);
        //[SavePrefrences sharedInstance].yokingcount=[NSString stringWithFormat:@"%d",ykcount];
    }
    
}


-(void)showAlert:(NSString*)strMessage{
    if(isAlertOnScreen){
        return;
    }
    UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:strMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
    isAlertOnScreen = YES;

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    isAlertOnScreen = NO;
}


-(void)ViewProfile:(id)sender
{
    
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    int index=(int)tg.view.tag;
    iscallback=13;
    
    
    
    UIImageView * btn=(UIImageView *)tg.view;
    
    UITableViewCell *cell =(UITableViewCell *) [[btn superview]superview];
    NSIndexPath *seletedIndex = [notiTableView indexPathForCell:cell];
    UIButton *accpt=[acceptAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UIButton *rejct=[rejAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UILabel *title=[titleAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    //NSArray *arrData  = [dictionaryByDate allKeys];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSArray *arrData  = [dictionaryByDate allKeys];
    
    
    
    NSMutableArray *arrKeys = [arrData sortedArrayUsingComparator:^NSComparisonResult(NSString *strDate1, NSString *strDate2) {
        NSDate *d1 =[formatter dateFromString:strDate1];
        NSDate *d2 =[formatter dateFromString:strDate2];
        //NSDate *d2 = obj2[@"date"];
        
        // return [d1 compare:d2]; // ascending order
        return [d2 compare:d1]; // descending order
    }];
    
    NSString *strKey = [arrKeys objectAtIndex:seletedIndex.section];
    NSMutableArray *arr = [dictionaryByDate objectForKey:strKey];
    NSArray *ar = [arr objectAtIndex:seletedIndex.row];
    
    
    
    
    //NSArray * ar=[notiAr1 objectAtIndex:index];
    
    //NSLog(@"arrrr====ddd====%@",ar);
    
    
    int ntc= [[ar valueForKey:@"ntc"] intValue];
    NSString *uname=[ar valueForKey:@"uname"];
    friendid=[ar valueForKey:@"fruid"];
    NSString *img=[ar valueForKey:@"img"];
    friendid=[NSString stringWithFormat:@"%@", [ar valueForKey:@"uid"]];
    NSString *time=[ar valueForKey:@"time"];
    NSString *status=[ar valueForKey:@"status"];
    NSString *fname=[ar valueForKey:@"fname"];
    NSString *lname=[ar valueForKey:@"lname"];
    
    NSString* myId = [NSString stringWithFormat:@"%@", [SavePrefrences sharedInstance].uid];
    if ([friendid isEqualToString:myId]) {
        ProfileViewController *vc2 = [[ProfileViewController alloc] init];
        vc2.userId = [SavePrefrences sharedInstance].uid;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController setViewControllers:@[vc2] animated:NO];
    }else [drawer openfriendprofile:friendid];
    
//    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//    [dic1 setObject:friendid forKey:@"id"];
//    [[SavePrefrences sharedInstance].skthand emitData:@"Profile":@"showProfile" :@"":@"":dic1 :self];
}
-(IBAction)btnChatAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    
    UITableViewCell *cell =(UITableViewCell *) [[btn superview]superview];
    NSIndexPath *seletedIndex = [notiTableView indexPathForCell:cell];
    UIButton *accpt=[acceptAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UIButton *rejct=[rejAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    UILabel *title=[titleAr valueForKey:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    //NSArray *arrData  = [dictionaryByDate allKeys];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSArray *arrData  = [dictionaryByDate allKeys];
    
    
    
    NSMutableArray *arrKeys = [arrData sortedArrayUsingComparator:^NSComparisonResult(NSString *strDate1, NSString *strDate2) {
        NSDate *d1 =[formatter dateFromString:strDate1];
        NSDate *d2 =[formatter dateFromString:strDate2];
        //NSDate *d2 = obj2[@"date"];
        
        // return [d1 compare:d2]; // ascending order
        return [d2 compare:d1]; // descending order
    }];
    
    NSString *strKey = [arrKeys objectAtIndex:seletedIndex.section];
    NSMutableArray *arr = [dictionaryByDate objectForKey:strKey];
    NSArray *ar = [arr objectAtIndex:seletedIndex.row];
    NSMutableDictionary *dictTicket = (NSMutableDictionary *)ar;
    
    UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChatViewController *vc2=[mainStoryboard instantiateViewControllerWithIdentifier:@"CHAT_SCREEN"];
    vc2.userId = [NSString stringWithFormat:@"%ld",[[dictTicket objectForKey:@"uid"] integerValue]];
    [self showViewController:vc2 sender:nil];
}

- (NSDictionary*)contactFromId:(NSString*)userId{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for (NSDictionary* dict in appDelegate.allFriends) {
        if ([[NSString stringWithFormat:@"%@", dict[@"u_id"]] isEqualToString:userId]) {
            return dict;
        }
    }
    return nil;
}

-(void) callMethod:(NSArray *)meta
{
    
}




@end
