//
//  AddCalender.m
//  Proyolk
//
//  Created by Padam on 11/19/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "AddCalend.h"

@interface AddCalend ()
{
    NSString *update_ta_name;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVisibility;
@property (weak, nonatomic) IBOutlet UIButton *btnCabinateMembersVisibility;
@property (weak, nonatomic) IBOutlet UIButton *btnNetworkMembersVisibility;

@end

@implementation AddCalend

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews{
    [super layoutSubviews];
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    self.txtCalenderName.leftView = leftView;
    self.txtCalenderName.leftViewMode = UITextFieldViewModeAlways;
    self.txtCalenderName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView1.backgroundColor = [UIColor clearColor];
    self.txtLocation.leftView = leftView1;
    self.txtLocation.leftViewMode = UITextFieldViewModeAlways;
    self.txtLocation.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView2.backgroundColor = [UIColor clearColor];
    self.txtSelectCountry.leftView = leftView2;
    self.txtSelectCountry.leftViewMode = UITextFieldViewModeAlways;
    self.txtSelectCountry.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView3 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView3.backgroundColor = [UIColor clearColor];
    self.txtTimeZone.leftView = leftView3;
    self.txtTimeZone.leftViewMode = UITextFieldViewModeAlways;
    self.txtTimeZone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    
        //    arrPriority = [NSMutableArray arrayWithObjects:@"High",@"Low",@"Medium",nil];
//    UIPickerView *picker = [[UIPickerView alloc]init];
//    picker.delegate = self;
//    picker.dataSource = self;
//    self.txtPriority.inputView = picker;
//    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, 320, 44)];
//    toolBar.barStyle = UIBarStyleBlack;
//    toolBar.translucent = YES;
//    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWriting:)];
//    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
//    
//    self.txtPriority.inputAccessoryView = toolBar;
    // init your parameters here, like set up fonts, colors, etc...
}

-(IBAction)btnSendAction:(id)sender{
    if (!_txtCalenderName.text.length) {
        [self showAlertView:@"Please enter a name for your calendar"];
        return;
    }else if (!_txtLocation.text.length) {
        [self showAlertView:@"Please enter your location"];
        return;
    }else if (!_txtSelectCountry.text.length) {
        [self showAlertView:@"Please enter your country"];
        return;
    }else if (!_txtTimeZone.text.length) {
        [self showAlertView:@"Please enter your timezone"];
        return;
    }else if (!_txtDescription.text.length) {
        [self showAlertView:@"Please enter a description for this calendar"];
        return;
    }
    NSString* pubId;
    if (_btnPublic.isSelected) {
        pubId = @"1";
    }else if (_btnPrivate.isSelected){
        pubId = @"0";
    }else if (_btnFrined.isSelected){
        if (_btnCabinet.isSelected && _btnNetwork.isSelected) {
            pubId = @"4";
        }else if (_btnCabinet.isSelected){
            pubId = @"2";
        }else if (_btnNetwork.isSelected){
            pubId = @"3";
        }
    }
    NSArray* netUids = @[];
    if (inviteAr.count) netUids = inviteAr;
    NSArray* cabUids = @[];
    NSDictionary *params = @{
                               @"id" : [SavePrefrences sharedInstance].uid,
                               @"calname" : _txtCalenderName.text,
                               @"desc" : _txtDescription.text,
                               @"lo" : _txtLocation.text,
                               @"pub" : pubId,
                               @"netuids" : netUids,
                               @"cabuids" : cabUids,
                               @"timezone" : _strTimeZoneId,
                               };
    
    iscallback = 103;
    [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"saveCal" :@"" :@"" :params :self];
}

- (void)showAlertView:(NSString*)message{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Proyolk" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(IBAction)btnCancelAction:(id)sender{
    [self removeFromSuperview];
}

- (IBAction)btnSharedAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn==self.btnCabinet) {
        [self.btnCabinet setSelected:YES];
        [self addPopUP:@"Cabinet"];
    }
    else{
        [self addPopUP:@"Network"];
        [self.btnNetwork setSelected:YES];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.txtSelectCountry){
        [self.delegationListener didPressSelectCountrie:self];
    }
    if (textField== self.txtTimeZone) {
 
        [self.delegationListener didPressSelectTimezone:self];
        // [self.delegationListener didPressSelectTimezone:self];

    }
    return YES;
}



-(UIView *) addPopUP:(NSString *) title
{
   // av=[[AllValidationsViewController alloc]init];
    
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [self.superview addSubview:prMainView];
  //  vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];
    
    NameLabel1=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-70, 50+30)];
    NameLabel1.text=@"User Search";
    NameLabel1.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    NameLabel1.font=[UIFont systemFontOfSize:14];
    NameLabel1.textColor=[UIColor blackColor];
    NameLabel1.layer.cornerRadius=12;
    NameLabel1.clipsToBounds=YES;
    NameLabel1.textAlignment=NSTextAlignmentCenter;
    [NameLabel1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [prMainView addSubview:NameLabel1];
    
    
    UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel1.frame.size.width+NameLabel1.frame.origin.x-30, [SavePrefrences sharedInstance ].naviHght+15, 30+30, 50+30)];
    closeView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    closeView.layer.cornerRadius=12;
    closeView.clipsToBounds=YES;
    [prMainView addSubview:closeView];
    
    UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(2+30, 2, 25, 25)];
    [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
    cross.userInteractionEnabled=YES;
    [closeView addSubview:cross];
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    cross.userInteractionEnabled = YES;
    [cross addGestureRecognizer:communityeg];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    viewfortable=[[UIView alloc]initWithFrame:CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-30, prMainView.frame.size.width-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+100))];
    viewfortable.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    viewfortable.layer.cornerRadius=12;
    viewfortable.clipsToBounds=YES;
    
    [prMainView addSubview:viewfortable];
    
 //   NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    
    float div= (viewfortable.frame.size.width)/3;
    /*float incx=0;
     for(int x=0; x< [shareAr count];x++)
     {
     Community=[[UILabel alloc]initWithFrame:CGRectMake(incx, 0,div+ 0.4, 40)];
     Community.text=[shareAr objectAtIndex:x];
     Community.textAlignment=NSTextAlignmentCenter;
     [Community setFont:[UIFont systemFontOfSize:12]];
     Community.textColor=[UIColor whiteColor];
     Community.backgroundColor=[ff valueForKey:@"Scrollcolor"];
     [viewfortable addSubview:Community];
     
     UITapGestureRecognizer *gradereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShareBar:)];
     [gradereg setNumberOfTouchesRequired:1];
     [gradereg setDelegate:self];
     Community.userInteractionEnabled = YES;
     Community.tag=x;
     [Community addGestureRecognizer:gradereg];
     
     commbar=[[UILabel alloc]initWithFrame:CGRectMake(incx, Community.frame.size.height+Community.frame.origin.y, div+0.4, 5)];
     commbar.backgroundColor=[ff valueForKey:@"Videocolor"];
     [viewfortable addSubview:commbar];
     incx=incx+div;
     NSLog(@"value of incx... %f",incx);
     }*/
    
    
    
   UIButton *proyolkBtn1=[[UIButton alloc]initWithFrame:CGRectMake(10, 4,100, 50)];
    [proyolkBtn1 setTitle: [NSString stringWithFormat:@"%@ Members",title] forState: UIControlStateNormal];
    [proyolkBtn1 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
   // proyolkBtn1.center = CGPointMake(10, 0.0);;
    [proyolkBtn1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn1 setBackgroundColor:[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];//[ff valueForKey:@"backcolor"];
    proyolkBtn1.tag=111;
   // [proyolkBtn1 addTarget:self action:@selector(tapBar1:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn1];

    
    selectAll=[[UIButton alloc]initWithFrame:CGRectMake(viewfortable.frame.size.width-100, 4,80, 50)];
    [selectAll setTitle:@"Select All" forState: UIControlStateNormal];
    [selectAll setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    [selectAll setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
    // proyolkBtn1.center = CGPointMake(10, 0.0);;
    [selectAll setBackgroundColor:[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];//[ff valueForKey:@"backcolor"];
    selectAll.tag=211;
    [selectAll addTarget:self action:@selector(selectAllAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:selectAll];

    
    
    
    /*  yellowcomm=[[UILabel alloc]initWithFrame:CGRectMake(0, Community.frame.size.height+Community.frame.origin.y, div, 5)];
     yellowcomm.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
     yellowcomm.hidden=false;
     [viewfortable addSubview:yellowcomm];
     
     yellowcbnt=[[UILabel alloc]initWithFrame:CGRectMake(yellowcomm.frame.size.width+yellowcomm.frame.origin.x, Community.frame.size.height+Community.frame.origin.y, div, 5)];
     yellowcbnt.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
     yellowcbnt.hidden=true;
     [viewfortable addSubview:yellowcbnt];
     
     yellownet=[[UILabel alloc]initWithFrame:CGRectMake(yellowcbnt.frame.size.width+yellowcbnt.frame.origin.x, Community.frame.size.height+Community.frame.origin.y, div, 5)];
     yellownet.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
     yellownet.hidden=true;
     [viewfortable addSubview:yellownet];*/
    
UILabel    *yellowcomm=[[UILabel alloc]initWithFrame:CGRectMake(10, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y-10, div, 5)];
    yellowcomm.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellowcomm.hidden=false;
    [viewfortable addSubview:yellowcomm];
    
//    yellowcbnt=[[UILabel alloc]initWithFrame:CGRectMake(yellowcomm.frame.size.width+yellowcomm.frame.origin.x, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
//    yellowcbnt.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
//    yellowcbnt.hidden=true;
//    [viewfortable addSubview:yellowcbnt];
//    
//    yellownet=[[UILabel alloc]initWithFrame:CGRectMake(yellowcbnt.frame.size.width+yellowcbnt.frame.origin.x, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
//    yellownet.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
//    yellownet.hidden=true;
//    [viewfortable addSubview:yellownet];
    
    
    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(10, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y+2, viewfortable.frame.size.width-55, 30)];
    search_lbl.placeholder=@"Search";
    search_lbl.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    search_lbl.clipsToBounds=YES;
    search_lbl.delegate=self;
    search_lbl.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = paddingView;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
    [search_lbl addTarget:self action:@selector(searchShare:) forControlEvents: UIControlEventEditingDidEnd];

 [search_lbl addTarget:self action:@selector(searchShare:) forControlEvents:UIControlEventEditingChanged];
    ////////////
    

    
    [viewfortable addSubview:search_lbl];
    
    
   UIButton *Search=[[UIButton alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+7, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y+5, 25, 25)];
    [Search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Search.backgroundColor=[ff valueForKey:@"clearColor"];
    [Search setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [Search addTarget:self action:@selector(searchShare:) forControlEvents:UIControlEventTouchUpInside];
    Search.layer.cornerRadius=6;
    [Search setClipsToBounds:YES];
    [viewfortable addSubview:Search];
   
    if ([title  isEqualToString:@"Cabinet"]) {
        Search.tag=0;
        search_lbl.tag=0;
        iscallback=0;
        // NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        //  [dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"CabSearch" :@"CabSearch" :@"" :@"" :dic1 :self];
    }
    else{
        Search.tag =1;
        search_lbl.tag=1;
        iscallback=1;
        // NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        //  [dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"NetSearch" :@"NetSearch" :@"" :@"" :dic1 :self];
    
    }
    
     return prMainView;
//    [proyolkBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [proyolkBtn2 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
//    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]
    
}

-(IBAction)selectAllAction:(id)sender{
    if ([selectAll.titleLabel.text isEqualToString:@"Select All"]) {
        [selectAll setTitle:@"Remove All" forState:UIControlStateNormal];
        [inviteAr removeAllObjects];
        
        
        if(update_ta_name == @"cabinettable")
        {
            
            for (NSDictionary *dict in shareAr) {
                NSString *u_id=[dict valueForKey:@"u_id"];
                [inviteAr addObject:u_id];
                [sharedtable reloadData];
            }
            
            
        } else {
            
            for (NSDictionary *dict in netAr) {
                NSString *idd=[dict valueForKey:@"u_id"];
                [inviteAr addObject:idd];
            }
            
            [networktable reloadData];
            
        }
        
        
    }else{
        [selectAll setTitle:@"Select All" forState:UIControlStateNormal];
        [inviteAr removeAllObjects];
        [networktable reloadData];
        [sharedtable reloadData];
    }
}

-(IBAction)searchShare:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if((int)btn.tag==0)
    {
        iscallback=2;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
       // NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        //[ dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
        [ dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:search_lbl.text forKey:@"str"];
         [dic1 setObject:@"" forKey:@"loc"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"srchCabSrch" :@"" :@"" :dic1 :self];
        
    }
    else if ((int)btn.tag==1)
    {
        // cabinet simple seasrch
        iscallback=3;
       // NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        //[ dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
        [ dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:search_lbl.text forKey:@"str"];
        [dic1 setObject:@"" forKey:@"loc"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Yolking" :@"srchNetSrch" :@"" :@"" :dic1 :self];
        
        
    }
   
}



-(void)dissmisspop
{
    [prMainView removeFromSuperview];
}

-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    NSLog(@"Storage_data=========%@",data);
    NSLog(@"Storage_meta=========%@",meta);
    
    NSLog(@"iscallback=e======%d",iscallback);
    
    if(iscallback==0)
    {
        //NSArray *newdata=[meta valueForKey:@"data"];
        shareAr= data;
        [self SharedtableView];
    }
    if(iscallback==1)
    {
        //NSArray *newdata=[meta valueForKey:@"data"];
        netAr= data;
        [self NetworktableView];
    }
    if(iscallback==2)
    {
        //NSArray *newdata=[meta valueForKey:@"data"];
        shareAr= data;
        [self SharedtableView];
    }
    if(iscallback==3)
    {
        //NSArray *newdata=[meta valueForKey:@"data"];
        netAr= data;
        [self NetworktableView];
    }
    if (iscallback==103) {
        [self removeFromSuperview];
    }
    
}


-(void)SharedtableView
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    inviteAr=[[NSMutableArray alloc]init];
    sharedtable = [[UITableView alloc] initWithFrame:CGRectMake(0, search_lbl.frame.size.height+search_lbl.frame.origin.y+5,viewfortable.frame.size.width,viewfortable.frame.size.height-search_lbl.frame.size.height-search_lbl.frame.origin.y)];
    sharedtable.delegate = self;
    sharedtable.dataSource = self;
    sharedtable.scrollEnabled = YES;
    sharedtable.backgroundColor=[UIColor  colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    sharedtable.separatorColor=[UIColor  colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [viewfortable addSubview:sharedtable];
}

-(void)NetworktableView
{
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    inviteAr=[[NSMutableArray alloc]init];
    networktable = [[UITableView alloc] initWithFrame:CGRectMake(0, search_lbl.frame.size.height+search_lbl.frame.origin.y+5,viewfortable.frame.size.width,viewfortable.frame.size.height-search_lbl.frame.size.height-search_lbl.frame.origin.y)];
    
    networktable.delegate = self;
    networktable.dataSource = self;
    networktable.scrollEnabled = YES;
    //220:129:135
    networktable.backgroundColor=[UIColor  colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    networktable.separatorColor=[UIColor  colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    
    [viewfortable addSubview:networktable];
}





- (IBAction)btnVisibilityAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn==self.btnPrivate) {
        [self.btnPrivate setSelected:YES];
        [self.btnPublic setSelected:NO];
        [self.btnFrined setSelected:NO];
    }
    else if (btn == self.btnPublic){
        [self.btnPrivate setSelected:NO];
        [self.btnPublic setSelected:YES];
        [self.btnFrined setSelected:NO];
    }else if (btn== self.btnCabinateMembersVisibility || btn== self.btnNetworkMembersVisibility){
        btn.selected = !btn.isSelected;
    }
    else{
        [self.btnPrivate setSelected:NO];
        [self.btnPublic setSelected:NO];
        [self.btnFrined setSelected:YES];
    }
    
    if(self.btnFrined.isSelected){
        _heightVisibility.constant = 70.0;
        [self layoutIfNeeded];
    }else{
        _heightVisibility.constant = 35;
        [self layoutIfNeeded];
    }
}




-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if(theTableView==sharedtable)
    {
        cellheight=80;
        return [shareAr count];
    }
    if(theTableView==networktable)
    {
        cellheight=80;
        return [netAr count];
    }
    
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    @try {
        NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor=[ff valueForKey:@"clearcolor"];
        
        if(theTableView==sharedtable)
        {
            
            update_ta_name = @"cabinettable";
            
           UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 70)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,cell_View.bounds.size.height-1,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            [cell_View addSubview:separator];
            
            NSString *uname=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            NSString *u_id=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            NSString *strUrl = @"https://proyolk.com";
            strUrl = [strUrl stringByAppendingString:[[shareAr objectAtIndex:indexPath.row]valueForKey:@"img"]];
            
            UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
            userpic.backgroundColor=[UIColor redColor];
            [userpic sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"user.png"]];
            userpic.layer.cornerRadius=22;
            userpic.clipsToBounds=YES;
            [cell_View addSubview:userpic];
            
           UILabel *uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
             uname_lbl.text=uname;
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell_View addSubview: uname_lbl];
            
            
            
            
            //pach by kalpesh
            
            UIButton *invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
            [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            if ([inviteAr containsObject:u_id]) {
                [invite setTitle:@"Invited" forState:UIControlStateNormal];
            }else [invite setTitle:@"Invite" forState:UIControlStateNormal];
            invite.tag=[u_id intValue];
            invite.titleLabel.font=[UIFont systemFontOfSize:10];
            [invite addTarget:self action:@selector(inviteto:) forControlEvents:UIControlEventTouchUpInside];
            invite.layer.cornerRadius=4;
            [invite setClipsToBounds:YES];
            [cell_View addSubview:invite];
            
            UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
            isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
            isonimg.backgroundColor=[UIColor clearColor];
            [cell_View addSubview:isonimg];
            
            return cell;

            
        }
        else if(theTableView==networktable)
        {
            
            update_ta_name = @" ";
            
           UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width-5, 70)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
            
            
            //            blockedUid = 7;
            //            email = "veena@oneinfonet.com";
            //            fname = veena;
            //            img = "/images/dummy.png";
            //            isonline = 0;
            //            lname = thakur;
            //            "middle_name" = thakur;
            //            "role_id" = 1;
            //            status = "<null>";
            //            "u_id" = 7;
            //            uname = veena;
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,cell_View.bounds.size.height-1,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            [cell_View addSubview:separator];
            
            NSString *uname=[[netAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            NSString *idd=[[netAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            
            NSLog(@"log iddd====%@",idd);
            NSString *strUrl = @"https://proyolk.com";
            strUrl = [strUrl stringByAppendingString:[[netAr objectAtIndex:indexPath.row]valueForKey:@"img"]];
            
            UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
            userpic.backgroundColor=[UIColor lightGrayColor];
           // [userpic setImage:[UIImage imageNamed:@"user.png"]];
            [userpic sd_setImageWithURL:[NSURL URLWithString:strUrl]];
            userpic.layer.cornerRadius=22;
            userpic.clipsToBounds=YES;
            [cell_View addSubview:userpic];
            
            UILabel  *uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textAlignment=NSTextAlignmentLeft;
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            
                uname_lbl.text=uname;
            
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell_View addSubview: uname_lbl];
            
            
            
            
            
            UIButton *invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
            [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            if ([inviteAr containsObject:idd]) {
                [invite setTitle:@"Invited" forState:UIControlStateNormal];
            }else [invite setTitle:@"Invite" forState:UIControlStateNormal];
            invite.tag=[idd intValue];
            invite.titleLabel.font=[UIFont systemFontOfSize:10];
            [invite addTarget:self action:@selector(inviteto:) forControlEvents:UIControlEventTouchUpInside];
            invite.layer.cornerRadius=4;
            [invite setClipsToBounds:YES];
            [cell_View addSubview:invite];
            
            UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
            isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
            isonimg.backgroundColor=[UIColor clearColor];
            [cell_View addSubview:isonimg];
            
            return cell;
            
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception is===%@",exception);
    }
    @finally {
    }
    return cell;
}



-(IBAction)inviteto:(id)sender{
    UIButton *btn=(UIButton *)sender;
    
    if([btn.titleLabel.text isEqual:@"Invite"]){
        [inviteAr addObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
        [btn setTitle:@"Invited" forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor clearColor];
        
        
//        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//      //  [dic setValue:[NSString stringWithFormat:@"%d",fileIdis] forKey:@"fId"];
//        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"u_from"];
//        [dic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"u_to"];
//        iscallback=16;
//        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"StInviteMem" :@"" :@"" :dic :self ];
    }
    
    
}


@end
