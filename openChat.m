#import "openChat.h"
#import "SavePrefrences.h"
#import "Chat.h"
#import "NotificationHandler.h"
#import "ManageArray.h"
#import "ChatStorageEngine.h"
#import "AppDelegate.h"

@interface openChat ()
{
    UIView *prMainView;
    UIScrollView *scrollbar;
    NSMutableArray *popUpAr;
    Chat *vc1;
    UILabel *NameLabel1;
    NSArray * chatkeys;
    NSArray *chatdata ;
    NSMutableDictionary * finalDic;
    NSString *messageId;
    int iscallback,incy;
    UITextView *entrmsg;
    NSMutableArray *curmsg;
    NotificationHandler *nobj;
    //NSMutableArray *chatAr;
    NSMutableDictionary * notdic;
    ManageArray *mang;
    NSString *imgpath,*username;
    UILabel *username_lbl,*typing;
    NSMutableDictionary *dic1;
    UIImageView *send;
    float keybordheigh;
    UIView  *footerView, *headerView;
    int isopend;
    UIImageView *userpic;
    NSDictionary* friendDict;
}
@end

@implementation openChat

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadLocalMessages{
//    NSArray* messages = [[ChatStorageEngine sharedManager] loadLastWeight:[SavePrefrences sharedInstance].chatId];
//    [self showChat:messages.mutableCopy];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(UIView *) MainViewwithouttitle:(UIViewController *)Vc
{
    [self dissmisspop];
    vc1=Vc;
    
    mang=[[ManageArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    prMainView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [vc1.view addSubview:prMainView];
   
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
    
    ////////////
    
    if(self.flag == 101){
        
        
            iscallback=20;
            NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
            [dict1 setObject:self.strTicketId forKey:@"t_id"];
            [dict1 setObject:self.strUserid forKey:@"uid"];
            //[dict1 setObject:entrmsg.text forKey:@"msg"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"getChat" :@"" :@"d" :dict1 :self ];
       
        
    }
    else{
        UIView *ViewTitle=[[UIView alloc] initWithFrame:CGRectMake(0, gap.frame.size.height+gap.frame.origin.y, prMainView.frame.size.width, 45)];
        ViewTitle.backgroundColor=[UIColor colorWithRed:225.0f/255.0f green:232.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
        [headerView addSubview:ViewTitle];
        userpic=[[UIImageView alloc] initWithFrame:CGRectMake(15, ViewTitle.frame.size.height/2-20, 40, 40)];
        // [userpic setImage:[UIImage imageNamed:@"user.png"]];
        userpic.userInteractionEnabled=YES;
//      userpic.layer.borderColor=[[UIColor grayColor]CGColor];
//        userpic.layer.borderWidth=1;
        userpic.layer.cornerRadius=20;
        userpic.clipsToBounds=YES;
        [ViewTitle addSubview:userpic];
        
        //username_lbl=[[UILabel alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 10, headerView.frame.size.width-150,40)];
        username_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width,40)];
        username_lbl.numberOfLines = 2.0;
        username_lbl.textAlignment=NSTextAlignmentCenter;
        username_lbl.backgroundColor=[UIColor clearColor];
        username_lbl.textColor= [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        [username_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [ViewTitle addSubview:username_lbl];
        
        typing=[[UILabel alloc]initWithFrame:CGRectMake(username_lbl.frame.size.width+username_lbl.frame.origin.x+5, 10, 70,40)];
        [typing setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        typing.backgroundColor=[UIColor clearColor];
        typing.text=@"";
        typing.textColor= [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        [ViewTitle addSubview:typing];
    
    }
    
  /*  UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 50, 25)];
    [bckarrow setImage:[UIImage imageNamed:@"back1.png"]];
    bckarrow.userInteractionEnabled=YES;
    [headerView addSubview:bckarrow];
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    bckarrow.userInteractionEnabled = YES;
    [bckarrow addGestureRecognizer:communityeg];*/
    
   
    
    footerView=[[UIView alloc] initWithFrame:CGRectMake(0, prMainView.frame.size.height-70, prMainView.frame.size.width, 56)];
    footerView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [prMainView addSubview:footerView];
    
   UIView *seperatorView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 1)];
    seperatorView.backgroundColor=[UIColor colorWithRed:183.0/255.0f green:190.0/255.0f blue:207.0/255.0f alpha:1.0f];
    [footerView addSubview:seperatorView];
    
    
    entrmsg=[[UITextView alloc]initWithFrame:CGRectMake(10,5, [SavePrefrences sharedInstance].screenWidth-70, 35)];
    //  entrmsg.layer.borderColor=[[UIColor grayColor] CGColor];
    //  entrmsg.layer.borderWidth=2;
    //  entrmsg.layer.cornerRadius=5; 225:232:239
    entrmsg.backgroundColor=[UIColor colorWithRed:225.0f/255.0f green:232.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
    entrmsg.textColor=[UIColor blackColor];
    entrmsg.delegate=self;
    [entrmsg setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [footerView addSubview:entrmsg];
    
    UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerView.frame.size.width, 1)];
    lblline.backgroundColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    [footerView addSubview:lblline];
    
    UILabel *acppt=[[UILabel alloc]initWithFrame:CGRectMake(entrmsg.frame.size.width+entrmsg.frame.origin.x+5, 5,[SavePrefrences sharedInstance].screenWidth -(entrmsg.frame.size.width+entrmsg.frame.origin.x+10), 35)];
    acppt.text=@"Send";
    acppt.textAlignment=NSTextAlignmentCenter;
    acppt.layer.cornerRadius=5;//78:119:145
    acppt.backgroundColor=[UIColor clearColor];
    acppt.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
   // acppt.font=[UIFont systemFontOfSize:12];
    [acppt setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *fname,*lname,*uname,*img;
    
    for(int x=0;x<[[SavePrefrences sharedInstance].frndAr count];x++)
    {
        
        int idd=[[[[SavePrefrences sharedInstance].frndAr objectAtIndex:x] valueForKey:@"u_id"] intValue];
        if(idd==[[SavePrefrences sharedInstance].chatId intValue])
        {
            img=[[[SavePrefrences sharedInstance].frndAr objectAtIndex:x] valueForKey:@"img"];
            uname=[[[SavePrefrences sharedInstance].frndAr objectAtIndex:x] valueForKey:@"uname"];
            
            dict = [[SavePrefrences sharedInstance].frndAr objectAtIndex:x];
            fname= [[[SavePrefrences sharedInstance].frndAr objectAtIndex:x] valueForKey:@"fname"];
            lname= [[[SavePrefrences sharedInstance].frndAr objectAtIndex:x] valueForKey:@"lname"];
            break;
        }
    }
    
    
    NSString * url=[mang concatUrl:img];
    if(url.length<12)
    {
     //   userpic.image = [UIImage imageNamed:@"user.png"];
    }
    else
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if (imageData.length>0){
            userpic.layer.cornerRadius=25;
            userpic.clipsToBounds=YES;
            userpic.image = [UIImage imageWithData:imageData];
        }
    }
    
    //NSMutableDictionary *dictData = [[[SavePrefrences sharedInstance].frndAr objectAtIndex:x];
    
    if ([[dict objectForKey:@"isonline"]integerValue] == 1) {
        lname = [lname stringByAppendingString:@"\nOnline"];
    }
    else{
        lname = [lname stringByAppendingString:@"\nOffline"];
    }
    username_lbl.text= [NSString stringWithFormat: @"%@ %@", fname, lname];
    
    [footerView addSubview:acppt];
    UITapGestureRecognizer *sendreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendMsg)];
    [sendreg setNumberOfTouchesRequired:1];
    [sendreg setDelegate:self];
    acppt.userInteractionEnabled = YES;
    [acppt addGestureRecognizer:sendreg];
    
    [self removePrevNoti];
    
    return prMainView;
    
}

-(void) removePrevNoti
{
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setObject:[SavePrefrences sharedInstance].chatRemovekey forKey:@"notiIds"];
    [dic setObject:[SavePrefrences sharedInstance].chatId forKey:@"fruid"];
    [dic setObject:[SavePrefrences sharedInstance].messageremovekey forKey:@"message"];
    [dic setObject:@"2" forKey:@"messS"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :dic :self];
    //[[SavePrefrences sharedInstance].chatRemovekey removeAllObjects];
    [[SavePrefrences sharedInstance].messageremovekey removeAllObjects];
}


-(void)chatView
{
    [scrollbar removeFromSuperview];
    NSLog(@"Inside Chat ============%@",@"===========");

    //        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y+10, [SavePrefrences sharedInstance ].screenWidth, prMainView.frame.size.height+prMainView.frame.origin.y-footerView.frame.size.height-150)];

    //here
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y+30, [SavePrefrences sharedInstance ].screenWidth, [SavePrefrences sharedInstance ].screenHeight-150-50)];
    scrollbar.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [prMainView addSubview:scrollbar];
    
}



-(void)isTyping:(NSArray *)data
{
    NSString *uid=[data valueForKey:@"uid"];
    NSString *fruid=[data valueForKey:@"fruid"];
    NSString *ty=[data valueForKey:@"ty"];
    
    if([uid intValue]==[[SavePrefrences sharedInstance].chatId intValue])
    {
        if([ty intValue]==0)
        {
            typing.text=@"";
        }
        else{
            typing.text=@"Typing...";
        }
    }
}

-(void)openchat:(UIViewController*)Vc withImage:(UIImage *)image{
    
    NSLog(@"isopend----%d",isopend);
    if(isopend==0)
    {
        [self MainViewwithouttitle:Vc];
    }
    [self chatView];
    
    friendDict = [self contactFromId:[SavePrefrences sharedInstance].chatId];
    [self loadLocalMessages];
    
    if (self.flag==101) {
        iscallback=20;
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
        [dict1 setObject:self.strTicketId forKey:@"t_id"];
        [dict1 setObject:self.strUserid forKey:@"uid"];
        //[dict1 setObject:entrmsg.text forKey:@"msg"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"getChat" :@"" :@"d" :dict1 :self ];
        
    }
    else{
        NSArray *User_chat=  [[SavePrefrences sharedInstance].notificationDic valueForKey:[NSString stringWithFormat:@"%@",[SavePrefrences sharedInstance].uid]];
        NSArray *Frnd_chat=  [[SavePrefrences sharedInstance].notificationDic valueForKey:[NSString stringWithFormat:@"%@",[SavePrefrences sharedInstance].chatId]];
        
        
        finalDic=[[NSMutableDictionary alloc]init];
        NSMutableArray *combindAr=[[NSMutableArray alloc]init];
        
        for(int x=0;x<[User_chat count];x++)
        {
            if([[[User_chat objectAtIndex:x] valueForKey:@"fruid"] intValue] ==[[SavePrefrences sharedInstance].chatId intValue])
            {
                [finalDic setObject:[User_chat objectAtIndex:x] forKey:[[User_chat objectAtIndex:x] valueForKey:@"time"]];
            }
        }
        for(int x1=0;x1<[Frnd_chat count];x1++)
        {
            if([[[Frnd_chat objectAtIndex:x1] valueForKey:@"fruid"] intValue] ==[[SavePrefrences sharedInstance].uid intValue])
            {
                [finalDic setValue:[Frnd_chat objectAtIndex:x1] forKey:[[Frnd_chat objectAtIndex:x1] valueForKey:@"time"]];
            }
        }
        @try {
            
            
            NSArray *sfloats = [finalDic allKeys];
            chatkeys= [sfloats sortedArrayUsingDescriptors:
                       @[[NSSortDescriptor sortDescriptorWithKey:@"doubleValue"
                                                       ascending:YES]]];
            
            
            
        }
        @catch (NSException *exception) {
            NSLog(@"exception hehere---%@",exception);
        }
        //
        NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
        
        incy=20;
        int scy=scrollbar.frame.size.width/2+40;
        
        NSMutableDictionary *dictFinal = [NSMutableDictionary dictionary];
        for (NSString *Mainkey in chatkeys)
        {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[Mainkey doubleValue]];
            
            NSMutableArray *arrData = [NSMutableArray array];
            for (NSString *key in chatkeys)
            {
                
                NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
                NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
                
                if([today day] == [otherDay day] &&
                   [today month] == [otherDay month] &&
                   [today year] == [otherDay year] &&
                   [today era] == [otherDay era]) {
                    [arrData addObject:[finalDic objectForKey:@"key"]];
                    //do stuff
                }
            }
            [dictFinal setObject:arrData forKey:Mainkey];
        }
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd,yyyy"];
        NSArray *arrData  = [dictFinal allKeys];
        
        
        
        
      
        
        NSMutableArray *arrMsg = [NSMutableArray array];
        
        
        for (NSString *strDate in arrData) {
            NSMutableDictionary *dictMessage = [finalDic objectForKey:strDate];
                double ms = [strDate doubleValue];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:(ms / 1000.0)];
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                
                dateFormatter.dateFormat = @"MMM dd,yyyy";
                [dictMessage setObject:[dateFormatter stringFromDate:date] forKey:@"date"];
                [arrMsg addObject:dictMessage];
            }
        
        
        dictionaryByDate = [NSMutableDictionary new];
        for(NSDictionary *dictionary in arrMsg)
        {
            NSString *dateString = dictionary[@"date"];
            NSDate  *date = dictionary[@"date"];
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
            [dictionaryByDate setObject:reversedArray forKey:strData];
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        for (NSString *key in chatkeys)
        {
            chatdata = [finalDic objectForKey:key];
            
            NSArray * jsonObject=[mang convertojson:chatdata];
            
            //   NSLog(@"json objectsss=======%@",jsonObject);
            
            NSString *message=[jsonObject valueForKey:@"mess"];
            NSString *mesid=[jsonObject valueForKey:@"messId"];
            NSString *user_id=[chatdata valueForKey:@"uid"];
            NSString *status=[chatdata valueForKey:@"status"];
            NSString *frndid=[chatdata valueForKey:@"fruid"];
            NSString *uname=[chatdata valueForKey:@"uname"];
            
            messageId=mesid;
            
            NSString *time=[chatdata valueForKey:@"time"];
            NSString *tim=[mang timeConverter:time];
            
            int done=1;
            float hspec=75;
            
            
            if([message length]>=35)
            {
                done=(int)[message length]/35;
                done=done+1;
                
                if(done<=2)
                {
                    hspec=40;
                }
                else if(done >=3 &&done<7)
                {
                    hspec=28;
                }
                else if(done >7 &&done<=11)
                {
                    hspec=24;
                }
                
                else if(done >11 &&done<=16)
                {
                    hspec=22;
                }
                
                else if(done >16 &&done<=20)
                {
                    hspec=20;
                }
                
                else if(done >20 &&done<=24)
                {
                    hspec=18;
                }
                
                else
                {
                    hspec=17;
                }
            }
            float height=hspec*done;
            
            
            
            if([user_id intValue]==[[SavePrefrences sharedInstance].uid intValue])
            {
                
                // NSLog(@"MESSAGE IS==one==%@",message);
                
                
                UIView *chatrightview=[[UIView alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2 -45, incy, scy, height)];
                chatrightview.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];
                chatrightview.layer.cornerRadius=8;
                [scrollbar addSubview:chatrightview];
                
                
                /* UITextView *unamelbl=[[UITextView alloc]initWithFrame:CGRectMake(0,0, chatrightview.frame.size.width, 25)];
                 unamelbl.text=[NSString stringWithFormat:@"%@",@"ME"];
                 unamelbl.userInteractionEnabled=NO;
                 unamelbl.font=[UIFont italicSystemFontOfSize:10];
                 unamelbl.textAlignment=NSTextAlignmentLeft;
                 unamelbl.backgroundColor=[UIColor colorWithRed:157.0f/255.0f green:167.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
                 unamelbl.textColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
                 unamelbl.layer.cornerRadius=8;
                 unamelbl.clipsToBounds=YES;
                 [chatrightview addSubview:unamelbl];*/
                //157:167:184
                
                
                UITextView *rightmsg=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, chatrightview.frame.size.width, height-35)];
                rightmsg.text=[NSString stringWithFormat:@" %@  ",message];
                rightmsg.userInteractionEnabled=NO;
                rightmsg.textAlignment=NSTextAlignmentRight;
                rightmsg.backgroundColor=[UIColor colorWithRed:157.0f/255.0f green:167.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
                rightmsg.textColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
                rightmsg.layer.cornerRadius=8;
                rightmsg.clipsToBounds=YES;
                [rightmsg setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
                [rightmsg sizeToFit];
                [chatrightview addSubview:rightmsg];
                
                int ww=chatrightview.frame.size.width-10;   //rightmsg.frame.size.width-30;
                rightmsg.frame=CGRectMake(ww-rightmsg.frame.size.width,0, rightmsg.frame.size.width, height-35);
                
                
                /* int numLines = rightmsg.contentSize.height / rightmsg.font.lineHeight;
                 NSLog(@"numLines....%d",numLines);
                 
                 if (numLines ==2)
                 {
                 int ww=chatrightview.frame.size.width-50;   //rightmsg.frame.size.width-30;
                 rightmsg.frame=CGRectMake(50, 0, rightmsg.frame.size.width, height-45);
                 
                 }*/
                
                /* UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(5, rightmsg.frame.size.height+rightmsg.frame.origin.y, 15, 15)];
                 if([status intValue]==0)
                 {
                 [img1 setImage:[UIImage imageNamed:@"tick.png"]];
                 }
                 else if ([status intValue]==2)
                 {
                 [img1 setImage:[UIImage imageNamed:@"s.png"]];
                 }
                 else{
                 [img1 setImage:[UIImage imageNamed:@"p.png"]];
                 }
                 
                 [chatrightview addSubview:img1];*/
                
                UILabel *Rtime=[[UILabel alloc]initWithFrame:CGRectMake(0, rightmsg.frame.size.height+rightmsg.frame.origin.y, chatrightview.frame.size.width-30, 20)];
                Rtime.text=tim;
                Rtime.layer.cornerRadius=8;
                Rtime.clipsToBounds=YES;
                Rtime.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
                Rtime.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
                [Rtime setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
                Rtime.textAlignment=NSTextAlignmentRight;
                
                [chatrightview addSubview:Rtime];
                
                incy=incy+height+8;
            }
            else
            {
                imgpath=[chatdata valueForKey:@"img"];
                username=[chatdata valueForKey:@"uname"];
                
                //NSLog(@"MESSAGE IS==two==%@",message);
                UIView *chatleftview=[[UIView alloc] initWithFrame:CGRectMake(0,incy , scy, height)];
                chatleftview.backgroundColor=[ff valueForKey:@"Videocolor"];
                chatleftview.layer.cornerRadius=8;
                [scrollbar addSubview:chatleftview];
                
                
                UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(2,0, 40, 40)];
                //  [image setImage:[UIImage imageNamed:@"user.png"]];
                userpic.layer.cornerRadius=20;
                userpic.clipsToBounds=YES;
                [chatleftview addSubview: image];
                
                NSString * url=[mang concatUrl:imgpath];
                  [image sd_setImageWithURL:[NSURL URLWithString:url]];
//                if(url.length<12)
//                {
//                    image.image = [UIImage imageNamed:@"user.png"];
//                }
//                else
//                {
//                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//                    
//                    if (imageData.length<=0)
//                        image.image = [UIImage imageNamed:@"user.png"];
//                    else
//                        image.image = [UIImage imageWithData:imageData];
//                }
                
                
                
                UITextView *unamelbl=[[UITextView alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5,0, chatleftview.frame.size.width, 20)];
                unamelbl.text=[NSString stringWithFormat:@"%@",uname];
                unamelbl.userInteractionEnabled=NO;
                unamelbl.textAlignment=NSTextAlignmentLeft;
                unamelbl.backgroundColor=[UIColor clearColor];
                
                unamelbl.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
                [unamelbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
                unamelbl.backgroundColor=[UIColor clearColor];
                unamelbl.layer.cornerRadius=8;
                unamelbl.clipsToBounds=YES;
                [unamelbl sizeToFit];
                //  [chatleftview addSubview:unamelbl];
                UITextView *leftmsg=[[UITextView alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5,0 , chatleftview.frame.size.width-50,height-45)];
                leftmsg.backgroundColor=[UIColor whiteColor];
                leftmsg.text=[NSString stringWithFormat:@"%@",message];
                leftmsg.userInteractionEnabled=NO;
                leftmsg.layer.cornerRadius=8;
                leftmsg.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
                [leftmsg setFont:[UIFont fontWithName:@"HelveticaNeue" size:9]];
                [chatleftview addSubview:leftmsg];
                
                
                
                UILabel *Ltime=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5, leftmsg.frame.size.height+leftmsg.frame.origin.y, chatleftview.frame.size.width-30, 20)];
                Ltime.text=tim;
                Ltime.layer.cornerRadius=8;
                Ltime.clipsToBounds=YES;
                Ltime.backgroundColor=[ff valueForKey:@"Videocolor"];
                Ltime.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
                [Ltime setFont:[UIFont fontWithName:@"HelveticaNeue-italic" size:10]];
                
                [chatleftview addSubview:Ltime];
                
                incy=+incy+height+8;
                
            }
        }
        if(isopend==1)
        {
            //here
            scrollbar.frame=CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth, [SavePrefrences sharedInstance ].screenHeight-(keybordheigh+120)-50);
            footerView.frame=CGRectMake(0,scrollbar.frame.size.height+scrollbar.frame.origin.y+2, [SavePrefrences sharedInstance].screenWidth, footerView.frame.size.height);
        }
        scrollbar.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth,incy+20);
        CGPoint bottomOffset = CGPointMake(0, scrollbar.contentSize.height - scrollbar.bounds.size.height);
        [scrollbar setContentOffset:bottomOffset animated:NO];
        
        isopend=1;
    }
    
   
}


-(void)showChat:(NSMutableArray *)arrChat{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    incy=20;
    int scy=scrollbar.frame.size.width/2+40;
    for (Messages *msg in arrChat)
    {
        NSString *message=msg.messageText;
        NSString *mesid=msg.messageId;
        NSString *user_id;
        NSString *frndid;
        NSString *uname;
        if (msg.incoming) {
            user_id = msg.userId;
            frndid = [SavePrefrences sharedInstance].uid;
            uname = friendDict[@"fname"];
        }else{
            user_id = [SavePrefrences sharedInstance].uid;
            frndid=msg.userId;
            uname = [SavePrefrences sharedInstance].fname;
        }
//        NSString *status=msg.;
       
        
        messageId=mesid;
        
        long long timeInterval = msg.time.longLongValue/1000;
        NSDate* msgDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSDateFormatter* dtf = [[NSDateFormatter alloc] init];
        [dtf setDateFormat:@"MMM d, h:mm a"];
        NSString *time = [dtf stringFromDate:msgDate];
        
        int done=1;
        float hspec=75;
        
        
        if([message length]>=35)
        {
            done=(int)[message length]/35;
            done=done+1;
            
            if(done<=2)
            {
                hspec=40;
            }
            else if(done >=3 &&done<7)
            {
                hspec=28;
            }
            else if(done >7 &&done<=11)
            {
                hspec=24;
            }
            
            else if(done >11 &&done<=16)
            {
                hspec=22;
            }
            
            else if(done >16 &&done<=20)
            {
                hspec=20;
            }
            
            else if(done >20 &&done<=24)
            {
                hspec=18;
            }
            
            else
            {
                hspec=17;
            }
        }
        float height=hspec*done;
        
        
        
        if([user_id intValue]==[[SavePrefrences sharedInstance].uid intValue])
        {
            
            // NSLog(@"MESSAGE IS==one==%@",message);
            
            
            UIView *chatrightview=[[UIView alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2 -45, incy, scy, height)];
            chatrightview.backgroundColor=[UIColor clearColor];//[ff valueForKey:@"Yellowbtncolor"];
            chatrightview.layer.cornerRadius=8;
            [scrollbar addSubview:chatrightview];
            
            
             UITextView *unamelbl=[[UITextView alloc]initWithFrame:CGRectMake(0,0, chatrightview.frame.size.width, 25)];
             unamelbl.text=[NSString stringWithFormat:@"%@", uname];
             unamelbl.userInteractionEnabled=NO;
            
             unamelbl.font=[UIFont italicSystemFontOfSize:10];
             unamelbl.textAlignment=NSTextAlignmentRight;
            // unamelbl.backgroundColor=[UIColor colorWithRed:157.0f/255.0f green:167.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
             unamelbl.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];;
             unamelbl.layer.cornerRadius=8;
             unamelbl.clipsToBounds=YES;
            unamelbl.backgroundColor = [UIColor clearColor];
            [chatrightview addSubview:unamelbl];
            //157:167:184
            
            
            UITextView *rightmsg=[[UITextView alloc]initWithFrame:CGRectMake(0, 25, chatrightview.frame.size.width, 30)];
            rightmsg.text=[NSString stringWithFormat:@"%@\n",message];
            
           // rightmsg.text=[NSString stringWithFormat:@" %@  ",message];
            rightmsg.userInteractionEnabled=NO;
            rightmsg.textAlignment=NSTextAlignmentRight;
            rightmsg.backgroundColor=[UIColor colorWithRed:157.0f/255.0f green:167.0f/255.0f blue:184.0f/255.0f alpha:1.0f];
            rightmsg.textColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            rightmsg.layer.cornerRadius=8;
            rightmsg.clipsToBounds=YES;
            [rightmsg setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [rightmsg sizeToFit];
            [chatrightview addSubview:rightmsg];
            
            int ww=chatrightview.frame.size.width-10;   //rightmsg.frame.size.width-30;
            rightmsg.frame=CGRectMake(ww-rightmsg.frame.size.width,25, rightmsg.frame.size.width, height-35);
            
            
             int numLines = rightmsg.contentSize.height / rightmsg.font.lineHeight;
             NSLog(@"numLines....%d",numLines);
             
             if (numLines ==2)
             {
             int ww=chatrightview.frame.size.width-50;   rightmsg.frame.size.width-30;
             rightmsg.frame=CGRectMake(50, 25, rightmsg.frame.size.width, height-35);
             
             }
            
            /* UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(5, rightmsg.frame.size.height+rightmsg.frame.origin.y, 15, 15)];
             if([status intValue]==0)
             {
             [img1 setImage:[UIImage imageNamed:@"tick.png"]];
             }
             else if ([status intValue]==2)
             {
             [img1 setImage:[UIImage imageNamed:@"s.png"]];
             }
             else{
             [img1 setImage:[UIImage imageNamed:@"p.png"]];
             }
             
             [chatrightview addSubview:img1];*/
            
            UILabel *Rtime=[[UILabel alloc]initWithFrame:CGRectMake(0, rightmsg.frame.size.height+rightmsg.frame.origin.y, chatrightview.frame.size.width-20, 20)];
            Rtime.text=time;
            Rtime.layer.cornerRadius=8;
            Rtime.clipsToBounds=YES;
            Rtime.backgroundColor=[UIColor clearColor];
            Rtime.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
            [Rtime setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
            Rtime.textAlignment=NSTextAlignmentRight;
            [chatrightview addSubview:Rtime];
            incy=incy+height+8;
        }
        else
        {
            imgpath=[chatdata valueForKey:@"img"];
            username=uname;
            
            //NSLog(@"MESSAGE IS==two==%@",message);
            UIView *chatleftview=[[UIView alloc] initWithFrame:CGRectMake(0,incy , scy, height)];
            chatleftview.backgroundColor=[ff valueForKey:@"Videocolor"];
            chatleftview.layer.cornerRadius=8;
            [scrollbar addSubview:chatleftview];
            
            
            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(2,0, 0, 0)];
          
            [chatleftview addSubview: image];
            
            NSString * url=[mang concatUrl:imgpath];
            if(url.length<12)
            {
                image.image = [UIImage imageNamed:@"user.png"];
            }
            else
            {
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                
                if (imageData.length<=0)
                    image.image = [UIImage imageNamed:@"user.png"];
                else
                    image.image = [UIImage imageWithData:imageData];
            }
            
            UITextView *unamelbl=[[UITextView alloc]initWithFrame:CGRectMake(5,0, chatleftview.frame.size.width, 20)];
            unamelbl.text=uname;
            unamelbl.userInteractionEnabled=NO;
            unamelbl.textAlignment=NSTextAlignmentLeft;
            unamelbl.backgroundColor=[UIColor clearColor];
            
            unamelbl.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
            [unamelbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
            unamelbl.backgroundColor=[UIColor clearColor];
            unamelbl.layer.cornerRadius=8;
            unamelbl.clipsToBounds=YES;
            [unamelbl sizeToFit];
              [chatleftview addSubview:unamelbl];
            UITextView *leftmsg=[[UITextView alloc]initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+5,20 , chatleftview.frame.size.width-50,height-20)];
            
            leftmsg.backgroundColor=[UIColor whiteColor];
            leftmsg.text=[NSString stringWithFormat:@"%@",message];
            leftmsg.userInteractionEnabled=NO;
            leftmsg.layer.cornerRadius=8;
            leftmsg.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
            [leftmsg setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [leftmsg sizeToFit];
            [chatleftview addSubview:leftmsg];
            
            int ww=chatleftview.frame.size.width-10;   //rightmsg.frame.size.width-30;
            leftmsg.frame=CGRectMake(leftmsg.frame.origin.x+5,25, leftmsg.frame.size.width, height-45);
            
            
            int numLines = leftmsg.contentSize.height / leftmsg.font.lineHeight;
            NSLog(@"numLines....%d",numLines);
            
            if (numLines ==2)
            {
                int ww=leftmsg.frame.origin.x-50;   leftmsg.frame.size.width-30;
                leftmsg.frame=CGRectMake(leftmsg.frame.origin.x, 25, leftmsg.frame.size.width, height-35);
                
            }
            
            
            
            
            UILabel *Ltime=[[UILabel alloc]initWithFrame:CGRectMake(5, leftmsg.frame.size.height+leftmsg.frame.origin.y, chatleftview.frame.size.width-30, 20)];
            Ltime.text=time;
            Ltime.layer.cornerRadius=8;
            Ltime.clipsToBounds=YES;
            Ltime.backgroundColor=[ff valueForKey:@"Videocolor"];
            Ltime.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
            [Ltime setFont:[UIFont fontWithName:@"HelveticaNeue-italic" size:10]];
            
            [chatleftview addSubview:Ltime];
            
            incy=+incy+height+8;
            
        }
    }
    if(isopend==1)
    {
        //here
        scrollbar.frame=CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth, [SavePrefrences sharedInstance ].screenHeight-(keybordheigh+120)-50);
        footerView.frame=CGRectMake(0,scrollbar.frame.size.height+scrollbar.frame.origin.y+2, [SavePrefrences sharedInstance].screenWidth, footerView.frame.size.height);
    }
    scrollbar.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth,incy+200);
    [scrollbar setScrollEnabled:YES];
    
    CGPoint bottomOffset = CGPointMake(0, scrollbar.contentSize.height - scrollbar.bounds.size.height);
    [scrollbar setContentOffset:bottomOffset animated:NO];
    
    isopend=1;

}

-(NSString*)GenerateRandom
{
    NSString *min =@"100"; //Get the current text from your minimum and maximum textfields.
    NSString *max =@"10000000";
    
    int randNum = rand() % ([max intValue] - [min intValue]) + [min intValue]; //create the random number.
    
    NSString *num = [NSString stringWithFormat:@"%d", randNum]; //Make the number into a string.
    
    
    return num;
    
    
}
-(void)sendMsg
{
    NSLog(@"send message");
    if (self.flag==101) {
        if([entrmsg.text length]>0)
        {
            
            iscallback=21;
            NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
            [dict1 setObject:self.strTicketId forKey:@"t_id"];
            [dict1 setObject:self.strUserid forKey:@"uid"];
            [dict1 setObject:entrmsg.text forKey:@"msg"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"InsertMessage" :@"" :@"d" :dict1 :self ];
            
            
//            [[[SavePrefrences sharedInstance].notificationDic valueForKey:[NSString stringWithFormat:@"%@",[SavePrefrences sharedInstance].uid]] addObject:notdic];
            
        }
    }
    else{
        iscallback=0;
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        NSString * messId=[self GenerateRandom];
        
        [dic setObject:messId forKey:@"messId"];
        [dic setObject:entrmsg.text forKey:@"mess"];
        
        
        dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[NSString stringWithFormat:@"%@", [SavePrefrences sharedInstance].chatId] forKey:@"fruid"];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:dic forKey:@"message"];
        notdic=[[NSMutableDictionary alloc]init];
        
        
        [notdic setValue:[SavePrefrences sharedInstance].fn forKey:@"fname"];
        [notdic setValue:[SavePrefrences sharedInstance].chatId forKey:@"fruid"];
        [notdic setValue:[SavePrefrences sharedInstance].lname forKey:@"lname"];
        
        
        
        [notdic setValue:@"" forKey:@"noti_id"];
        [notdic setValue:@"3" forKey:@"ntc"];
        
        [notdic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [notdic setValue:[SavePrefrences sharedInstance].un forKey:@"uname"];
        
        NSMutableDictionary * messdic=[[NSMutableDictionary alloc]init];
        [messdic setValue:entrmsg.text forKey:@"mess"];
        [messdic setValue:messId forKey:@"messId"];
        [notdic setValue:messdic forKey:@"message"];
        
        if([entrmsg.text length]>0)
        {
            iscallback=19;
            [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"getServerTime" :@"" :@"d" :[[NSMutableDictionary alloc]init] :self ];
            [[[SavePrefrences sharedInstance].notificationDic valueForKey:[NSString stringWithFormat:@"%@",[SavePrefrences sharedInstance].uid]] addObject:notdic];
            NSDictionary* sendMsg = @{
                                      @"uid" : notdic[@"uid"],
                                      @"fruid": notdic[@"fruid"],
                                      @"message" : notdic[@"message"]
                                      };
            [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"sIM" :@"" :@"d" :sendMsg :self];
            [[ChatStorageEngine sharedManager] saveMessage:notdic isIncoming:NO];
            
        }

    }
    
    
    
    
    
    
}


-(void)dissmisspop
{
    isopend=0;
    imgpath=@"";
    [prMainView removeFromSuperview];
    
    
    
    
//    id<CallTo_Parent>  cb= vc1;
//    [cb callMethod:nil];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    //    scrollbar.frame=CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth, [SavePrefrences sharedInstance ].screenHeight-(keybordheigh+120));
    //    footerView.frame=CGRectMake(0,scrollbar.frame.size.height+scrollbar.frame.origin.y+2, [SavePrefrences sharedInstance].screenWidth, footerView.frame.size.height);
    //send.frame=CGRectMake(entrmsg.frame.size.width+entrmsg.frame.origin.x+5, scrollbar.frame.size.height+scrollbar.frame.origin.y+2, 40, 40);
    
}

-(void)textViewdDidEndEditing:(UITextView *)textview
{
    
    NSLog(@"Editing end");
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        
        
        NSLog(@"rangggg===%lu",range.length);
        
        
        //here
        scrollbar.frame=CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y+20, [SavePrefrences sharedInstance ].screenWidth, [SavePrefrences sharedInstance ].screenHeight-150-50);
        footerView.frame=CGRectMake(0, prMainView.frame.size.height-70, prMainView.frame.size.width, 56);
        
        //entrmsg.frame=CGRectMake(10,prMainView.frame.size.height-70, [SavePrefrences sharedInstance].screenWidth-70, 40);
        // send.frame=CGRectMake(entrmsg.frame.size.width+entrmsg.frame.origin.x+5, prMainView.frame.size.height-70, 40, 40);
        [self sendMsg];
    }
    
    
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    //here
    keybordheigh=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    scrollbar.frame=CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth, [SavePrefrences sharedInstance ].screenHeight-(keybordheigh+120)-50);
    footerView.frame=CGRectMake(0,scrollbar.frame.size.height+scrollbar.frame.origin.y+2, [SavePrefrences sharedInstance].screenWidth, footerView.frame.size.height);
    
}


-(void) callBack:(NSArray *)META:(NSArray *)DATA
{
   /*
    if (iscallback==20) {
//        [self showChat:DATA];
        
    }
    if (iscallback==21) {
        [self showChat:DATA];
           entrmsg.text=@"";
    }
    
    if(iscallback==0)
    {
        [notdic setValue:[DATA valueForKey:@"time"] forKey:@"time"];
        NSMutableArray * ar=[[NSMutableArray alloc]init];
        [ar addObject:notdic];
        
        NotificationHandler  *nobj1=[[NotificationHandler alloc]init];
        [nobj1 ManageNotification:ar];
    }
    
    if(iscallback==19)
    {
        
        [SavePrefrences sharedInstance].serverTimeRece=[DATA valueForKey:@"time"];
        [notdic setValue:[SavePrefrences sharedInstance].serverTimeRece forKey:@"time"];
        
        // NSLog(@"noti dic after editing====%@",notdic);
        [self openchat:vc1 withImage:nil];
        
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"sIM" :@"" :@"d" :dic1 :self];
        entrmsg.text=@"";
        
    }*/
}



@end
