//
//  TechSupportController.m
//  Proyolk
//
//  Created by Padam on 10/19/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "TechSupportController.h"
#import "ManageArray.h"
#import "SavePrefrences.h"
#import "LeftRightDrawer.h"
@interface TechSupportController ()
{
    UIView *main;
    int isCallback;
    LeftRightDrawer *drawer;
    UILabel  *job_lbl1,*notification_bar2;
    UITableView *tblTicketView;
}
@end

@implementation TechSupportController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag=0;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
   float screenWidth = screenRect.size.width;
   float screenHeight = screenRect.size.height;
  float  naviWidth = self.navigationController.navigationBar.frame.size.width;
   float naviHght =  self.navigationController.navigationBar.frame.size.height;
   float stbarHght= (float)[[UIApplication sharedApplication] statusBarFrame].size.height;
    ManageArray *mang=[[ManageArray alloc]init];
    
    [self setTabBarWithNotifications];
    [self.navigationController setNavigationBarHidden:YES];
    isCallback=1;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Support":@"getTickets" :@"":@"":dic1 :self];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) setTabBarWithNotifications
{
   // tag=0;
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;
    
    main=[[UIView alloc]initWithFrame:CGRectMake(0, 70,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    main.backgroundColor=[stack valueForKey:@"backcolor"];
    [self.view addSubview:main];
    
    int hght=(main.frame.size.height-100)/4;
    float lty=(hght)/4;
    NSLog(@"hght===== %d",hght);
    NSLog(@"lty========= %f",lty);
    
    UILabel *Notification=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [SavePrefrences sharedInstance].screenWidth/2 , lty)];
    Notification.text=@"Open Tickets";
    Notification.userInteractionEnabled=false;
    Notification.textAlignment=NSTextAlignmentCenter;
    [Notification setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Notification.backgroundColor=[UIColor clearColor];
    Notification.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
    [main addSubview:Notification];
    
   notification_bar2=[[UILabel alloc]initWithFrame:CGRectMake(0,Notification.frame.size.height+Notification.frame.origin.y,[SavePrefrences sharedInstance].screenWidth/2, 3)];
    notification_bar2.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    [main addSubview:notification_bar2];
    
    UITapGestureRecognizer *notificationReg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openticketsView)];
    [notificationReg setNumberOfTouchesRequired:1];
    [notificationReg setDelegate:self];
    Notification.userInteractionEnabled = YES;
    Notification.tag=0;
    [Notification addGestureRecognizer:notificationReg];
    
    
   UILabel *job_lbl=[[UILabel alloc]initWithFrame:CGRectMake(Notification.frame.size.width+Notification.frame.origin.x, 0, [SavePrefrences sharedInstance].screenWidth/2,lty)];
    job_lbl.text=@"Closed Tickets";
    job_lbl.textAlignment=NSTextAlignmentCenter;
    [job_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    job_lbl.backgroundColor=[stack valueForKey:@"backcolor"];
    job_lbl.textColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    [main addSubview:job_lbl];
    
  job_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(Notification.frame.size.width+Notification.frame.origin.x, job_lbl.frame.size.height+job_lbl.frame.origin.y, [SavePrefrences sharedInstance].screenWidth/2, 3)];
    //job_lbl1.backgroundColor=[stack valueForKey:@"Profcolor"];
    job_lbl1.backgroundColor=[UIColor clearColor];
    
    [main addSubview:job_lbl1];
    
    
    
    UITapGestureRecognizer *Myjobreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closedticketsView)];
    [Myjobreg setNumberOfTouchesRequired:1];
    [Myjobreg setDelegate:self];
    job_lbl.userInteractionEnabled = YES;
    [job_lbl addGestureRecognizer:Myjobreg];
    
//   UILabel *project_lbl=[[UILabel alloc]initWithFrame:CGRectMake(job_lbl.frame.size.width+job_lbl.frame.origin.x,0, [SavePrefrences sharedInstance].screenWidth/3,lty)];
//    project_lbl.text=@"Projects";
//    project_lbl.textAlignment=NSTextAlignmentCenter;
//    [project_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
//    project_lbl.backgroundColor=[stack valueForKey:@"backcolor"];
//    project_lbl.textColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
//    [main addSubview:project_lbl];
//    
//    UILabel *project_lbl1=[[UILabel alloc]initWithFrame:CGRectMake(job_lbl.frame.size.width+job_lbl.frame.origin.x,project_lbl.frame.size.height+project_lbl.frame.origin.y , [SavePrefrences sharedInstance].screenWidth/3,3)];
//    project_lbl1.backgroundColor=[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f];
//    [main addSubview:project_lbl1];
//    
//    
//    UILabel *lblLine=[[UILabel alloc] initWithFrame:CGRectMake(0, job_lbl.frame.size.height+job_lbl.frame.origin.y, main.frame.size.height, 1)];
//    lblLine.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
//    [main addSubview:lblLine];
//    
//    
//    UITapGestureRecognizer *MyProjectreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ProjectBar)];
//    [MyProjectreg setNumberOfTouchesRequired:1];
//    [MyProjectreg setDelegate:self];
//    project_lbl.userInteractionEnabled = YES;
//    [project_lbl addGestureRecognizer:MyProjectreg];
//    
    [self customizeActionBar];
   UIView *JobBarView=[[UIView alloc]initWithFrame:CGRectMake(0, job_lbl1.frame.size.height+job_lbl1.frame.origin.y, [SavePrefrences sharedInstance].screenWidth, lty)];
    JobBarView.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    JobBarView.hidden=true;
    [main addSubview:JobBarView];
    
   UIView *middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, JobBarView.frame.size.height+JobBarView.frame.origin.y, [SavePrefrences sharedInstance].screenWidth,lty)];
    middle_label.hidden=true;
    middle_label.backgroundColor=[stack valueForKey:@"clearColor"];
    [main addSubview:middle_label];
    
    btnAdd=[[UIButton alloc]initWithFrame:CGRectMake(0, lty, [SavePrefrences sharedInstance].screenWidth,50)];
    [btnAdd setTitle:@"Add New Ticket" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
    [main addSubview:btnAdd];
    tblTicketView =[[UITableView alloc]initWithFrame:CGRectMake(0, lty+50, [SavePrefrences sharedInstance].screenWidth,([SavePrefrences sharedInstance].screenHeight-(lty+50)))];
    [main addSubview:tblTicketView];
    tblTicketView.backgroundColor = [UIColor clearColor];
    tblTicketView.dataSource = self;
    tblTicketView.delegate = self;
    [tblTicketView reloadData];
    
    tblTicketView.separatorColor = [UIColor clearColor];
    //[self jobNotiView];
    
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
-(IBAction)btnAddClick:(id)sender{
    AddTicket *containerView = [[[NSBundle mainBundle] loadNibNamed:@"AddTicket" owner:self options:nil] lastObject];
    containerView.delegate = self;
  //  containerView.strFlag = @"0";
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
    
   
    UILabel * leftView3= [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView3.backgroundColor = [UIColor clearColor];
    containerView.txtPriority.leftView = leftView3;
    
    containerView.txtPriority.leftViewMode = UITextFieldViewModeAlways;
    containerView.txtPriority.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    
    
    
    UILabel * leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView2.backgroundColor = [UIColor clearColor];
    
    
    containerView.txtTitle.leftView = leftView2;
    
    containerView.txtTitle.leftViewMode = UITextFieldViewModeAlways;
    containerView.txtTitle.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[rootView addSubview:containerView];
    containerView.center = self.view.center;
    [self.view addSubview:containerView];


}

-(void)getOpenTicket{
    flag=0;
    btnAdd.hidden = false;
    job_lbl1.backgroundColor = [UIColor clearColor];
    notification_bar2.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    isCallback=1;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Support":@"getTickets" :@"":@"":dic1 :self];
}
-(void)closedticketsView{
    flag = 1;
    notification_bar2.backgroundColor = [UIColor clearColor];
    job_lbl1.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    isCallback=1;
    btnAdd.hidden = true;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"CloseTicket":@"getcloseTickets" :@"":@"":dic1 :self];

}
-(void)openticketsView{
    
    flag=0;
    btnAdd.hidden = false;
    job_lbl1.backgroundColor = [UIColor clearColor];
    notification_bar2.backgroundColor=[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f];
    isCallback=1;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Support":@"getTickets" :@"":@"":dic1 :self];
}


#pragma mark - UITableView Data source Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrTickets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    NSMutableDictionary *dictTicket = [arrTickets objectAtIndex:indexPath.row];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
    UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width-10, 150)];
    cell_View.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0f];
//    cell_View.layer.borderWidth=1;
//    cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
//    cell_View.layer.cornerRadius=6;
    [cell addSubview: cell_View];
    
    
    UILabel *lblTicketName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, cell_View.frame.size.width-60, 30)];
    lblTicketName.text = [dictTicket objectForKey:@"title"];
    lblTicketName.textColor = [UIColor lightGrayColor];
    lblTicketName.font  = [UIFont systemFontOfSize:14];
    lblTicketName.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblTicketName];
    
    UIButton *btnView = [[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-130, 5, 30, 30)];
    btnView.tag = indexPath.row;
    [btnView setImage:[UIImage imageNamed:@"viewblack.png"] forState:UIControlStateNormal];
    [btnView addTarget:self action:@selector(btnViewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell_View addSubview:btnView];
    
    UIButton *btnChat = [[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-80, 5, 30, 30)];
    btnChat.tag = indexPath.row;
    [btnChat setImage:[UIImage imageNamed:@"feedback.png"] forState:UIControlStateNormal];
    [btnChat addTarget:self action:@selector(btnChatAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell_View addSubview:btnChat];
    
    
    
    
    if (flag==0) {
        UIButton *btnDelete = [[UIButton alloc]initWithFrame:CGRectMake(cell_View.frame.size.width-40, 5, 30, 30)];
        btnDelete.tag = indexPath.row;
        [btnDelete setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
        [btnDelete addTarget:self action:@selector(btnDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell_View addSubview:btnDelete];
    }
    
    
    
    UILabel *lblSeperator = [[UILabel alloc]initWithFrame:CGRectMake(0, 36, cell_View.frame.size.width, 1)];
    lblSeperator.backgroundColor = [UIColor lightGrayColor];
    //lblSeperator.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblSeperator];
    
    UILabel *lblTicketId = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 130, 20)];
    lblTicketId.text = @"Ticket Id :";
    lblTicketId.font = [UIFont boldSystemFontOfSize:13];
    lblTicketId.textColor = [UIColor blackColor];
    lblTicketId.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblTicketId];
    
    UILabel *lblTicId = [[UILabel alloc]initWithFrame:CGRectMake(130, 40, self.view.frame.size.width-100, 20)];
    lblTicId.text = [NSString stringWithFormat:@"  %@",[dictTicket objectForKey:@"t_id"]];
    lblTicId.font = [UIFont systemFontOfSize:13];
    lblTicId.textColor = [UIColor blackColor];
    lblTicId.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblTicId];
    
    
    UILabel *lblTicketStatus = [[UILabel alloc]initWithFrame:CGRectMake(20, 62, 130, 20)];
    lblTicketStatus.text = @"Status :";
    lblTicketStatus.font = [UIFont boldSystemFontOfSize:13];
    lblTicketStatus.textColor = [UIColor blackColor];
    lblTicketStatus.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblTicketStatus];
    
    UILabel *lblTicStatus = [[UILabel alloc]initWithFrame:CGRectMake(130, 62, self.view.frame.size.width-100, 20)];
    lblTicStatus.text = [NSString stringWithFormat:@"  %@",[dictTicket objectForKey:@"status"]];    lblTicStatus.font =[UIFont systemFontOfSize:13];
    lblTicStatus.textColor = [UIColor blackColor];
    lblTicStatus.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblTicStatus];
   
    
    UILabel *lblTickettPririty = [[UILabel alloc]initWithFrame:CGRectMake(20, 84, 130, 20)];
    lblTickettPririty.text = @"Priority :";
    lblTickettPririty.font = [UIFont boldSystemFontOfSize:13];
    lblTickettPririty.textColor = [UIColor blackColor];
    lblTickettPririty.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblTickettPririty];
    
    UILabel *lblTicPriority = [[UILabel alloc]initWithFrame:CGRectMake(130, 84, self.view.frame.size.width-100, 20)];
    lblTicPriority.text = [NSString stringWithFormat:@"  %@",[dictTicket objectForKey:@"priority"]];
    lblTicPriority.font = [UIFont systemFontOfSize:13];
    lblTicPriority.textColor = [UIColor blackColor];
    lblTicPriority.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblTicPriority];
    
    
    UILabel *lblTickettPostedBy = [[UILabel alloc]initWithFrame:CGRectMake(20, 106, 130, 20)];
    lblTickettPostedBy.text = @"Last Activity On :";
    lblTickettPostedBy.font = [UIFont boldSystemFontOfSize:13];
    lblTickettPostedBy.textColor = [UIColor blackColor];
    lblTickettPostedBy.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblTickettPostedBy];
    
    UILabel *lblTicPostedBY = [[UILabel alloc]initWithFrame:CGRectMake(130, 106, self.view.frame.size.width-100, 20)];
    double timestamp = [[dictTicket objectForKey:@"lastact"]doubleValue]/1000;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd MMMM yyyy";
  
    lblTicPostedBY.text =[NSString stringWithFormat:@"  %@",[dateFormatter stringFromDate:date]];
    lblTicPostedBY.font = [UIFont systemFontOfSize:13];
    lblTicPostedBY.textColor = [UIColor blackColor];
    lblTicPostedBY.textAlignment = NSTextAlignmentLeft;
    [cell_View addSubview:lblTicPostedBY];
    return cell;
}
-(IBAction)btnChatAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSMutableDictionary *dictTicket = [arrTickets objectAtIndex:btn.tag];
    openChat *oppChat = [[openChat alloc]init];
    oppChat.flag = 101;
    oppChat.strTicketId =[NSString stringWithFormat:@"%d",[[dictTicket objectForKey:@"t_id"] integerValue]];
    oppChat.strUserid =[NSString stringWithFormat:@"%d",[[dictTicket objectForKey:@"u_id"] integerValue]];
//    [[[SavePrefrences sharedInstance].chatWindowAr addObject:oppChat];
    [SavePrefrences sharedInstance].chatId=[NSString stringWithFormat:@"%d",[[dictTicket objectForKey:@"u_id"] integerValue]];
    [oppChat openchat:self withImage:nil];

}

-(IBAction)btnViewAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
   
   
    ViewTicket *containerView = [[[NSBundle mainBundle] loadNibNamed:@"ViewTicket" owner:self options:nil] lastObject];
    //  containerView.strFlag = @"0";
    
    NSMutableDictionary *dictTicket = [arrTickets objectAtIndex:btn.tag];
    containerView.txtTitle.text = [NSString stringWithFormat:@"Title :-   %@",[dictTicket objectForKey:@"title"]];
    containerView.txtStatus.text =[NSString stringWithFormat:@"Status :-   %@",[dictTicket objectForKey:@"status"]];
    
    
    
    containerView.txtPriority.text =[NSString stringWithFormat:@"Priority :-   %@",[dictTicket objectForKey:@"priority"]];
    containerView.txtName.text = [NSString stringWithFormat:@"Name :-   %@",[dictTicket objectForKey:@"name"]];
    containerView.txtEmail.text = [NSString stringWithFormat:@"Email :-   %@",[dictTicket objectForKey:@"email"]];
    
    containerView.txtDescription.text =[NSString stringWithFormat:@"Description :-   %@",[dictTicket objectForKey:@"description"]];
    if ([[dictTicket objectForKey:@"image"]isKindOfClass:[NSNull class]]) {
        containerView.txtAttachment.text =[NSString stringWithFormat:@"Attachment :-   %@",@"No Attachment"];
    }
    else{
        containerView.txtAttachment.text =[NSString stringWithFormat:@"Attachment :-   %@",[dictTicket objectForKey:@"image"]];
    }
    
    double timestamp = [[dictTicket objectForKey:@"lastact"]doubleValue]/1000;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd MMMM yyyy";
    
    double timestamp1 = [[dictTicket objectForKey:@"createdon"]doubleValue]/1000;
    
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:timestamp1];
    
    
    
    

    
     containerView.txtlastActon.text =[NSString stringWithFormat:@"Last Activity On :-   %@",[dateFormatter stringFromDate:date]];
     containerView.txtCreated.text =[NSString stringWithFormat:@"Created on :-   %@",[dateFormatter stringFromDate:date1]];
    
    
    
    
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
    
    
    UILabel * leftView3= [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView3.backgroundColor = [UIColor clearColor];
    containerView.txtPriority.leftView = leftView3;
    
    containerView.txtPriority.leftViewMode = UITextFieldViewModeAlways;
    containerView.txtPriority.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    UILabel * leftView4= [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView4.backgroundColor = [UIColor clearColor];
//    containerView.txtDescription.leftView = leftView4;
//    
//    containerView.txtDescription.leftViewMode = UITextFieldViewModeAlways;
//    containerView.txtDescription.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView5= [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView5.backgroundColor = [UIColor clearColor];
    containerView.txtStatus.leftView = leftView5;
    
    containerView.txtStatus.leftViewMode = UITextFieldViewModeAlways;
    containerView.txtStatus.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    
    
    UILabel * leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView2.backgroundColor = [UIColor clearColor];
    
    
    containerView.txtTitle.leftView = leftView2;
    
    containerView.txtTitle.leftViewMode = UITextFieldViewModeAlways;
    containerView.txtTitle.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[rootView addSubview:containerView];
    containerView.center = self.view.center;
    [self.view addSubview:containerView];
}


-(IBAction)btnDeleteAction:(id)sender{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Proyolk"
                                 message:@"Are you sure to move the ticket?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    UIButton *btn = (UIButton *)sender;
                                    isCallback=2;
                                    NSMutableDictionary *dictData = [arrTickets objectAtIndex:btn.tag];
                                    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
                                    [dic1 setValue:[dictData objectForKey:@"t_id"] forKey:@"t_id"];
                                    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"u_id"];
                                    [[SavePrefrences sharedInstance].skthand emitData:@"Yolking":@"clstick" :@"":@"":dic1 :self];
                                    //Handle your yes please button action here
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}

-(void)getTicketData{
    isCallback=1;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Support":@"getTickets" :@"":@"":dic1 :self];
}

-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    
    if (isCallback==1) {
        NSMutableArray *arr  =(NSMutableArray *) data;
        arrTickets = [[arr reverseObjectEnumerator] allObjects];
        
        [tblTicketView reloadData];
       
    }
    if (isCallback==2) {
         [self getTicketData];
    }
   
    
   // [self removeFromSuperview];
}
@end
