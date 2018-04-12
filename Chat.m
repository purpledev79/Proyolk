

#import "Chat.h"
#import "AllValidationsViewController.h"
#import "LeftRightDrawer.h"
#import "SavePrefrences.h"
#import "openChat.h"
#import "MainController.h"
#import "ChatViewController.h"
#import "ManageArray.h"
#import "ChatStorageEngine.h"


@interface Chat ()
{
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIView *main,*cell_View;
    AllValidationsViewController *av;
    LeftRightDrawer *drawer;
    MainController *vc1;
    openChat *opop;
    NSMutableDictionary * frChatAr;
    int iscallback;
    NSArray * keyAr;
    ManageArray * mngAr;
    NSArray *Frnd_chat;
    int cnt;
    
}
@end

@implementation Chat
@synthesize chattableView;
- (void)viewDidLoad{
    [super viewDidLoad];
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
}

- (void)viewDidAppear:(BOOL)animated{
//    conversations = [[ChatStorageEngine sharedManager] loadConversations];
//    datedConversations = [self conversationsByDate];
//    [chattableView reloadData];
}

- (NSDictionary*)conversationsByDate{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    for (Messages* msg in conversations.allValues) {
        long long timestamp = [msg.time longLongValue]/1000;
        NSDateFormatter *dtf = [[NSDateFormatter alloc] init];
        [dtf setDateFormat:@"MMM dd,yyyy"];
        NSString *dateStr = [dtf stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
        if (dict[dateStr]) {
            NSMutableArray* arr = [dict[dateStr] mutableCopy];
            [arr addObject:msg];
            [dict setValue:arr.copy forKey:dateStr];
        }else{
            [dict setValue:@[msg] forKey:dateStr];
        }
    }
    return dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)customizeActionBar
{
    [drawer initArs:self];
    main=[[UIView alloc]initWithFrame:CGRectMake(0,70, screenWidth, screenHeight)];
    NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
    main.backgroundColor=[brd valueForKey:@"backcolor"];
    [self.view addSubview:main];
    [self reteriveFriends];
    //[self ChatList];
}
-(void) reteriveFriends{
    iscallback=3;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"genData":@"":@"":dic1 :self];
}

-(void)ChatList
{
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    UILabel *msg=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, main.frame.size.width, 30)];
    msg.text=@"Messages";
    [msg setFont:[UIFont boldSystemFontOfSize:16]];
    msg.textAlignment=NSTextAlignmentCenter;
    msg.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    msg.textColor=[UIColor colorWithRed:183.0f/255.0f green:182.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
    msg.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [main addSubview:msg];
    
    frChatAr=[[NSMutableDictionary alloc]init];
    //  NSLog(@"data ========%@",[SavePrefrences sharedInstance].notificationDic);
    
    
    
    //if([[SavePrefrences sharedInstance].notificationDic count]>0)
    {
        //keyAr=  [[SavePrefrences sharedInstance].notificationDic  allKeys];
        
        keyAr=  [[SavePrefrences sharedInstance].allFrndChatKey  allKeys];
        
        
        
        for(int i=0;i<[[SavePrefrences sharedInstance].frndAr count];i++)
        {
            NSString *frndid=[[[SavePrefrences sharedInstance].frndAr valueForKey:@"u_id"]objectAtIndex:i] ;
            for(int x=0;x<[keyAr count];x++)
            {
                
                NSString * key=[keyAr objectAtIndex:x];
                
                if([key intValue]==[frndid intValue])
                {
                    [frChatAr setValue:[[SavePrefrences sharedInstance].frndAr objectAtIndex:i] forKey:[NSString stringWithFormat:@"%@",frndid]];
                    break;
                }
            }
        }
    }
    
    
    chattableView=[[UITableView alloc]initWithFrame:CGRectMake(5, msg.frame.size.height+msg.frame.origin.y+10, main.frame.size.width+20, main.frame.size.height-(msg.frame.size.height+msg.frame.origin.y+75))];
    chattableView.backgroundColor=[ff valueForKey:@"backcolor"];
    chattableView.delegate = self;
    chattableView.dataSource = self;
    chattableView.scrollEnabled = YES;
    chattableView.separatorColor=[ff valueForKey:@"backcolor"];
    [main addSubview:chattableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dictionaryByDate allKeys].count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSArray *arrData  = [self.dictionaryByDate allKeys];
    
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


-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSArray *arrData  = [self.dictionaryByDate allKeys];
    
    
    
    NSMutableArray *arrKeys = [arrData sortedArrayUsingComparator:^NSComparisonResult(NSString *strDate1, NSString *strDate2) {
        NSDate *d1 =[formatter dateFromString:strDate1];
        NSDate *d2 =[formatter dateFromString:strDate2];
        //NSDate *d2 = obj2[@"date"];
        
        // return [d1 compare:d2]; // ascending order
        return [d2 compare:d1]; // descending order
    }];
    
    arrKey = arrKeys;
    // NSArray *arrData  = [dictionaryByDate allKeys];
    NSString *strKey = [arrKeys objectAtIndex:section];
    NSMutableArray *arr = [self.dictionaryByDate objectForKey:strKey];
    
    return arr.count;

}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.chattableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    @try
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
      //  cell.layer.cornerRadius=8;
        cell.clipsToBounds=YES;
        cell.backgroundColor=[UIColor clearColor];
        if(theTableView==chattableView)
        {
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
            cell_View.backgroundColor=[UIColor clearColor];
           /* cell_View.layer.borderWidth=1;
            cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
            cell_View.layer.cornerRadius=6;*/
            
            //cell_View.tag=[[[frChatAr allKeys] objectAtIndex:indexPath.row] intValue];
            [cell addSubview: cell_View];
            
            UITapGestureRecognizer *prev = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openChat:)];
            [prev setNumberOfTouchesRequired:1];
            [prev setDelegate:self];
            cell_View.userInteractionEnabled = YES;
            [cell_View addGestureRecognizer:prev];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(5,cell_View.bounds.size.height-1,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
            [cell_View addSubview:separator];

            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, cell_View.bounds.size.height-55, 45, 45)];
        
            cell_View.layer.cornerRadius=22;
            cell_View.clipsToBounds=YES;
           // [img setImage:[UIImage imageNamed:@"user.png"]];
            // img.layer.borderWidth=1;
            img.layer.borderColor=[[UIColor grayColor]CGColor];
            [cell_View addSubview:img];
           
            
            // NSArray *arrData  = [dictionaryByDate allKeys];
            NSString *strKey = [arrKey objectAtIndex:indexPath.section];
            NSMutableArray *arr = [self.dictionaryByDate objectForKey:strKey];
            
            
            
            NSArray *dictFriend=[arr objectAtIndex:indexPath.row];
            NSMutableDictionary *chatdata = [NSMutableDictionary dictionary];
           
            for (NSMutableDictionary *dict in arrFriendList) {
                if ([[dictFriend valueForKey:@"fruid"]integerValue]==[[dict objectForKey:@"u_id"]integerValue]) {
                    chatdata = dict;
                    break;
                }
            }
             NSLog(@"chatdata is %@",chatdata);
            
            NSString *fname=[chatdata valueForKey:@"fname"];
            NSString *fruid=[chatdata valueForKey:@"u_id"];
            NSString *lname=[chatdata valueForKey:@"lname"];
            NSString *uname=[chatdata valueForKey:@"uname"];
            NSString *img1=[chatdata valueForKey:@"img1"];
            NSString *isonline=[chatdata valueForKey:@"isonline"];
             cell_View.tag=[fruid intValue];
            NSLog(@"frid====%@",fruid);
            
            cnt=0;
            
            NSString *url=[mngAr concatUrl:img1];
            [img sd_setImageWithURL:[NSURL URLWithString:url]];
            

            UILabel *userlbl=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+5, cell_View.bounds.size.height/2-10, cell_View.frame.size.width/2-30, 25)];
            //userlbl.text=uname;
            userlbl.text= [fname stringByAppendingString:[NSString stringWithFormat:@" %@ ",lname]];
            userlbl.textColor=[UIColor colorWithRed:183.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
            userlbl.backgroundColor=[UIColor clearColor];
            [userlbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [cell_View addSubview:userlbl];
            
            UIButton *btnChat = [[UIButton alloc]initWithFrame:CGRectMake(userlbl.frame.size.width+userlbl.frame.origin.x+1,cell_View.bounds.size.height/2-17, 40,40)];
            btnChat.backgroundColor= [UIColor clearColor];
            [btnChat setBackgroundImage:[UIImage imageNamed:@"chatcount1.png"] forState:UIControlStateNormal];
            btnChat.layer.cornerRadius=5;
            btnChat.tag=0;
            [cell_View addSubview:btnChat];
            

            
            UILabel *onlinelab=[[UILabel alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-85, cell_View.bounds.size.height/2-3, 13, 13)];
            onlinelab.backgroundColor=[UIColor grayColor];
            onlinelab.layer.cornerRadius=6.5;
            //onlinelab.layer.borderWidth=1;
            onlinelab.clipsToBounds=YES;
            [cell_View addSubview:onlinelab];

            //99:160:19
            UILabel *txtmsg=[[UILabel alloc]initWithFrame:CGRectMake(0, cell_View.bounds.size.height/2-10, cell_View.frame.size.width-20, 25)];
            txtmsg.text=@"Offline";
            txtmsg.backgroundColor=[UIColor clearColor];
            txtmsg.textColor=[UIColor colorWithRed:183.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
            [txtmsg setFont:[UIFont fontWithName:@"HelveticaNeue-italic" size:13]];
            txtmsg.textAlignment=NSTextAlignmentRight;
            [cell_View addSubview:txtmsg];
            
            if(isonline==nil||isonline==NULL||[isonline isEqual:[NSNull null]]||isonline == (id)[NSNull null])
            {
                onlinelab.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
                txtmsg.text=@"Offline";
                onlinelab.layer.borderColor=[[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] CGColor];
            }
            else if([isonline intValue]==0)
            {
                txtmsg.text=@"Offline";
                onlinelab.backgroundColor=[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
                onlinelab.layer.borderColor=[[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] CGColor];
            }
            else if([isonline intValue]==1)
            {
                txtmsg.text=@"Online";
                onlinelab.backgroundColor=[UIColor colorWithRed:99.0/255.0 green:160.0/255.0 blue:19.0/255.0 alpha:1];
                onlinelab.layer.borderColor=[[UIColor colorWithRed:99.0/255.0 green:160.0/255.0 blue:19.0/255.0 alpha:1] CGColor];
            }
            
            UILabel *txtmsgcnt=[[UILabel alloc]initWithFrame:CGRectMake(txtmsg.frame.size.width+txtmsg.frame.origin.x+35, txtmsg.frame.size.height+txtmsg.frame.origin.y, 20, 25)];
            txtmsgcnt.text=@"Offline";
            txtmsgcnt.backgroundColor=[UIColor yellowColor];
            txtmsgcnt.textColor=[UIColor colorWithRed:183.0/255.0 green:182.0/255.0 blue:182.0/255.0 alpha:1];
            txtmsgcnt.textAlignment=NSTextAlignmentCenter;
            [txtmsgcnt setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
            txtmsgcnt.layer.cornerRadius=10;
            txtmsgcnt.clipsToBounds=YES;
            txtmsgcnt.hidden=YES;
            [cell_View addSubview:txtmsgcnt];
            
            if(cnt>0)
            {
                txtmsgcnt.text=[NSString stringWithFormat:@"%d",cnt];
                txtmsgcnt.hidden=NO;
            }
            
            return cell;
        }
        return cell;
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception is===%@",exception);
    }
    @finally
    {
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 75;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)openChat:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    
    NSString* userId = [NSString stringWithFormat:@"%d",(int)tg.view.tag];
    UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChatViewController *vc2=[mainStoryboard instantiateViewControllerWithIdentifier:@"0CREEN"];
    vc2.userId = userId;
    [self showViewController:vc2 sender:nil];
    
    
//    [[SavePrefrences sharedInstance].chatWindowAr addObject:opop];
//    [SavePrefrences sharedInstance].chatId=[NSString stringWithFormat:@"%d",(int)tg.view.tag];
//    [opop openchat:self withImage:nil];
    
}

-(void) callBack:(NSArray *)META  :(NSArray *)DATA{
    if (iscallback==3) {
        
        NSMutableArray *arrData = [META valueForKey:@"notis"];
        NSMutableArray *arrFriend = [NSMutableArray array];
        NSMutableArray *arrFriendL  = [NSMutableArray array];
        arrFriendList  = [NSMutableArray array];
        
        NSSet* categories = [NSSet setWithArray: [arrData valueForKey: @"fruid"]];
        NSArray *arrCab = [META valueForKey:@"fr"];
        //NSArray *arrNet = [META valueForKey:@"netFr"];
        
        [arrFriendList addObjectsFromArray: arrCab];
        //[arrFriendList addObjectsFromArray:arrNet];
        
        NSMutableArray *arrF = (NSMutableArray *)[categories allObjects];
        arrFriend = [NSMutableArray array];
        for (NSString *str in arrF) {
            NSString *strId = [NSString stringWithFormat:@"%@",str];
            if (![arrFriend containsObject:strId]) {
                [arrFriend addObject:strId];
            }
        }
        
        NSMutableArray *arrFriendMSG = [NSMutableArray array];
        for (NSString *strNum in arrFriend) {
            NSMutableArray *arrMessages = [NSMutableArray array];
            for (NSMutableDictionary *dictFriend in arrData) {
                if ([strNum integerValue]==[[dictFriend objectForKey:@"fruid"]integerValue]) {
                    [arrMessages addObject:dictFriend];
                }
                
            }
            
            NSArray * sortedArray = [self sort:arrMessages];
            NSMutableDictionary *dictFriend = [NSMutableDictionary dictionary];
            [dictFriend setObject:strNum forKey:@"fruid"];
            [dictFriend setObject:sortedArray forKey:@"msg"];
            [arrFriendL addObject:[sortedArray objectAtIndex:0]];
            
            [arrFriendMSG addObject:dictFriend];
            
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSMutableDictionary *dictFriend in arrFriendL) {
            double ms = [[dictFriend objectForKey:@"time"]doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:(ms / 1000.0)];
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            
            dateFormatter.dateFormat = @"MMM dd,yyyy";
            [dictFriend setObject:[dateFormatter stringFromDate:date] forKey:@"date"];
            [arr addObject:dictFriend];
        }
        
        
        self.dictionaryByDate = [NSMutableDictionary new];
        
        for(NSDictionary *dictionary in arr)
        {
            NSString *dateString = dictionary[@"date"];
            NSDate  *date = dictionary[@"date"];
            NSMutableArray *arrayWithSameDate = self.dictionaryByDate[dateString];
            if(! arrayWithSameDate)
            {
                arrayWithSameDate = [NSMutableArray new];
                self.dictionaryByDate[dateString] = arrayWithSameDate;
            }
            [arrayWithSameDate addObject: dictionary];
            
        }
        
        
        [SavePrefrences sharedInstance].frndAr=[META valueForKey:@"fr"];
        
        [self ChatList];
        NotificationHandler  *nobj=[[NotificationHandler alloc]init];
        [nobj ManageNotification:[META valueForKey:@"notis"]];
    }
//    NSLog(@"chat meta %@",META);
//    NSLog(@"chat data %@",DATA);
//    
     [SavePrefrences sharedInstance].serverTimeRece=[DATA valueForKey:@"time"];
    
    
}

-(NSMutableArray *)sort:(NSMutableArray *)array{
    //This is the array of dictionaries, where each dictionary holds a record
    
    //allocate the memory to the mutable array and add the records to the arrat
    
    // I have used simple bubble sort you can use any other algorithm that suites you
    //bubble sort
    //
    for(int i = 0; i < [array count]; i++)
    {
        for(int j = i+1; j < [array count]; j++)
        {
            NSDictionary *recordOne = [array objectAtIndex:i];
            NSDictionary *recordTwo = [array objectAtIndex:j];
            
            if([[recordOne valueForKey:@"time"] floatValue] > [[recordTwo valueForKey:@"time"] floatValue])
            {
                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    return array;
    
    //Here you get the sorted array
}

-(void)callMethod:(NSArray *)meta{
    NSLog(@"ion cal back");
    [chattableView reloadData];
    
    
}

@end
