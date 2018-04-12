//
//  AddEvent.m
//  Proyolk
//
//  Created by Padam on 11/18/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "AddEvent.h"

@interface AddEvent ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIButton *selectAll;
    NSString *update_ta_name;
    BOOL isCalenderPicker;
    NSDictionary *selectedCal;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *pickerContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVisibility;
@property (weak, nonatomic) IBOutlet UIButton *btnCabinateMembersVisibility;
@property (weak, nonatomic) IBOutlet UIButton *btnNetworkMembersVisibility;

@end

@implementation AddEvent

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)initialSetup{
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    self.arrData = [NSMutableArray arrayWithObjects:@"Never",@"5 Minutes",@"10 Minutes",@"15 Minutes",@"20 Minutes",@"25 Minutes",@"30 Minutes",@"1 Hour",@"2 Hour",@"3 Hour",@"4 Hour",@"5 Hour",@"6 Hour",@"7 Hour",@"8 Hour",@"9 Hour",@"10 Hour",@"11 Hour",@"12 Hour",@"13 Hour",@"14 Hour",@"15 Hour",@"16 Hour",@"17 Hour",@"18 Hour",@"1 Day",@"2 Days",@"3 Days", nil];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, 320, 44)];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.translucent = YES;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWriting:)];
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    self.txtInterval.inputAccessoryView = toolBar;
    self.txtInterval.inputView  = pickerView;
    [pickerView reloadAllComponents];
    
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    self.txtTItle.leftView = leftView;
    self.txtTItle.leftViewMode = UITextFieldViewModeAlways;
    self.txtTItle.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView1.backgroundColor = [UIColor clearColor];
    self.txtStartDate.leftView = leftView1;
    self.txtStartDate.leftViewMode = UITextFieldViewModeAlways;
    self.txtStartDate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //
    UILabel * leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView2.backgroundColor = [UIColor clearColor];
    self.txtStartTime.leftView = leftView2;
    self.txtStartTime.leftViewMode = UITextFieldViewModeAlways;
    self.txtStartTime.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView3 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView3.backgroundColor = [UIColor clearColor];
    self.txtEndDate.leftView = leftView3;
    self.txtEndDate.leftViewMode = UITextFieldViewModeAlways;
    self.txtEndDate.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView4 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView4.backgroundColor = [UIColor clearColor];
    self.txtEndTIme.leftView = leftView4;
    self.txtEndTIme.leftViewMode = UITextFieldViewModeAlways;
    self.txtEndTIme.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView5 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView5.backgroundColor = [UIColor clearColor];
    self.txtField.leftView = leftView5;
    self.txtField.leftViewMode = UITextFieldViewModeAlways;
    self.txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView6 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView6.backgroundColor = [UIColor clearColor];
    self.txtInterval.leftView = leftView6;
    self.txtInterval.leftViewMode = UITextFieldViewModeAlways;
    self.txtInterval.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView7 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView7.backgroundColor = [UIColor clearColor];
    self.txtLocation.leftView = leftView7;
    self.txtLocation.leftViewMode = UITextFieldViewModeAlways;
    self.txtLocation.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView8 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView8.backgroundColor = [UIColor clearColor];
    self.txtState.leftView = leftView8;
    self.txtState.leftViewMode = UITextFieldViewModeAlways;
    _txtState.delegate=self;
    self.txtState.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView9 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView9.backgroundColor = [UIColor clearColor];
    self.txtCountry.leftView = leftView9;
    self.txtCountry.leftViewMode = UITextFieldViewModeAlways;
    _txtCountry.delegate=self;
    self.txtCountry.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel * leftView10 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView10.backgroundColor = [UIColor clearColor];
    self.txtCity.leftView = leftView10;
    self.txtCity.leftViewMode = UITextFieldViewModeAlways;
    _txtCity.delegate=self;
    self.txtCity.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [_repeatTillDateTF setDelegate:self];
    
    NSDictionary* currentCal = [[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENT_CAL"];
    _calendarSelectTF.text = currentCal[@"cal_name"];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initialSetup];
    [self getCalendars];
}
-(void)layoutSubviews{
    [super layoutSubviews];
}

-(IBAction)btnSendAction:(id)sender{
    NSMutableDictionary* params = [NSMutableDictionary new];
    [params setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [params setValue:_txtTItle.text forKey:@"title"];
    if(_btnEmail.isSelected) [params setValue:@"1" forKey:@"notitype"];
    if(_btnSMS.isSelected) [params setValue:@"2" forKey:@"notitype"];
    if(_btnPopUP.isSelected) [params setValue:@"3" forKey:@"notitype"];
    
    for (UIButton* btn in _eventColours) {
        if (btn.isSelected) {
            [params setValue:[NSString stringWithFormat:@"%ld", (long)btn.tag] forKey:@"color"];
        }
    }
    
    NSString* fromDate = [NSString stringWithFormat:@"%@ %@", _txtStartDate.text, _txtStartTime.text];
    NSString* toDate = [NSString stringWithFormat:@"%@ %@", _txtEndDate.text, _txtEndTIme.text];
    fromDate = [fromDate substringToIndex:fromDate.length-3];
    toDate = [toDate substringToIndex:toDate.length-3];
    [params setValue:fromDate forKey:@"frmdate"];
    [params setValue:toDate forKey:@"todate"];
    
    [params setValue:_txtEventDesc.text forKey:@"evntdisc"];
    [params setValue:_txtInterval.text forKey:@"notiTime"];
    [params setValue:_txtCity.text forKey:@"city"];
    [params setValue:_txtCountry.text forKey:@"cntry"];
    [params setValue:_txtState.text forKey:@"state"];
    [params setValue:_txtLocation.text forKey:@"loc"];
    
    
    if(_btnPrivate.isSelected)[params setValue:@"0" forKey:@"visibility"];
    if(_btnPublic.isSelected)[params setValue:@"1" forKey:@"visibility"];
    if(_btnFriend.isSelected)[params setValue:@"2" forKey:@"visibility"];
    
    for (UIButton* day in _weekdaysBtns) {
        if ([day.titleLabel.text isEqualToString:@"Mon"]){
            if (day.isSelected) [params setValue:@"1" forKey:@"mon"];
            else [params setValue:@"0" forKey:@"mon"];
        }else if ([day.titleLabel.text isEqualToString:@"Tue"]){
            if (day.isSelected) [params setValue:@"1" forKey:@"tue"];
            else [params setValue:@"0" forKey:@"tue"];
        }else if ([day.titleLabel.text isEqualToString:@"Wed"]){
            if (day.isSelected) [params setValue:@"1" forKey:@"wed"];
            else [params setValue:@"0" forKey:@"wed"];
        }else if ([day.titleLabel.text isEqualToString:@"Thu"]){
            if (day.isSelected) [params setValue:@"1" forKey:@"thu"];
            else [params setValue:@"0" forKey:@"thu"];
        }else if ([day.titleLabel.text isEqualToString:@"Fri"]){
            if (day.isSelected) [params setValue:@"1" forKey:@"fri"];
            else [params setValue:@"0" forKey:@"fri"];
        }else if ([day.titleLabel.text isEqualToString:@"Sat"]){
            if (day.isSelected) [params setValue:@"1" forKey:@"sat"];
            else [params setValue:@"0" forKey:@"sat"];
        }else if ([day.titleLabel.text isEqualToString:@"Sun"]){
            if (day.isSelected) [params setValue:@"1" forKey:@"sun"];
            else [params setValue:@"0" forKey:@"sun"];
        }
        
    }
    
    [params setValue:(_btnisVideo.selected?@"true":@"false") forKey:@"video"];
    [params setValue:@"" forKey:@"tp"];
    [params setValue:@"" forKey:@"start"];
    [params setValue:_txtStartDate.text forKey:@"fm"];
    
    
    
    [params setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"CURRENT_EVENT_TYPE"] forKey:@"typeEvent"];
    [params setValue:[NSString stringWithFormat:@"%@ %@", _txtStartDate.text, _txtStartTime.text] forKey:@"single"];
    
    if (_btnOnce.selected) [params setValue:@"1" forKey:@"repeat"];
    if (_btnDaily.selected) [params setValue:@"2" forKey:@"repeat"];
    if (_btnWeekly.selected) [params setValue:@"3" forKey:@"repeat"];
    if (_btnMOnthly.selected) [params setValue:@"4" forKey:@"repeat"];
    if (_btnYearly.selected) [params setValue:@"5" forKey:@"repeat"];
    if (_btnWeekdays.selected) [params setValue:@"6" forKey:@"repeat"];
    
    [params setValue:@"day" forKey:@"key"];
    if(selectedCal){
        [params setValue:selectedCal[@"cal_id"] forKey:@"cal"];
    }else{
        return;
    }
    
    [params setValue:(tillDateValue.length?tillDateValue:@"Enter Date") forKey:@"till"];
    [params setValue:(numOfDaysRepeat.length?numOfDaysRepeat:@"") forKey:@"times"];
    [params setValue:@[] forKey:@"cabuids"];
    [params setValue:@[] forKey:@"netuids"];
    
    //    [params setValue:_txtEventDesc.text forKey:@"flnm"];
    //    [params setValue:_txtEventDesc.text forKey:@"buffer"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"saveEvent" :@"" :@"" :params :self];
    
    
    [self removeFromSuperview];
}
-(IBAction)btnCancelAction:(id)sender{
    [self removeFromSuperview];
}
- (IBAction)btnLocationAction:(id)sender {
    if (self.heightForLocation.constant==0) {
        self.heightForLocation.constant = 170.0;
        self.heightScrollVContstant.constant = 1139;
        
        self.containerView.hidden = false;
        [self updateConstraintsIfNeeded];
        
    }
    else{
        self.heightForLocation.constant = 0.0;
        self.heightScrollVContstant.constant = 979;
        self.containerView.hidden = true;
        
        [self updateConstraintsIfNeeded];
    }
}

- (IBAction)btnisVideoCall:(id)sender {
    if (self.btnisVideo.selected) {
        [self.btnisVideo setSelected:NO];
        
    }
    else{
        [self.btnisVideo setSelected:YES];
    }
}

- (IBAction)btnColourChangeAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    for (UIButton* clr in _eventColours) {
        [clr setSelected:NO];
    }
    if (btn.isSelected) [btn setSelected:NO];
    else [btn setSelected:YES];
}

- (IBAction)btnVisibilityAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn==self.btnPrivate) {
        [self.btnPrivate setSelected:YES];
        [self.btnPublic setSelected:NO];
        [self.btnFriend setSelected:NO];
    }
    else if (btn == self.btnPublic){
        [self.btnPrivate setSelected:NO];
        [self.btnPublic setSelected:YES];
        [self.btnFriend setSelected:NO];
    }
    else if (btn== self.btnCabinateMembersVisibility || btn== self.btnNetworkMembersVisibility){
        btn.selected = !btn.isSelected;
    }
    else{
        [self.btnPrivate setSelected:NO];
        [self.btnPublic setSelected:NO];
        [self.btnFriend setSelected:YES];
    }
    
    if(self.btnFriend.isSelected){
        _heightVisibility.constant = 70.0;
        [self layoutIfNeeded];
    }else{
        _heightVisibility.constant = 35;
        [self layoutIfNeeded];
    }
    
}
- (IBAction)btnRepeatAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    _eventRepeatTimeView.hidden = YES;
    [_weeklyView setHidden:YES];
    
    if (btn == self.btnOnce) {
        [self.btnOnce setSelected:YES];
        [self.btnDaily setSelected:NO];
        [self.btnWeekly setSelected:NO];
        [self.btnMOnthly setSelected:NO];
        [self.btnYearly setSelected:NO];
        [self.btnWeekdays setSelected:NO];
        
    }
    else if (btn == self.btnDaily) {
        [self.btnOnce setSelected:NO];
        [self.btnDaily setSelected:YES];
        [self.btnWeekly setSelected:NO];
        [self.btnMOnthly setSelected:NO];
        [self.btnYearly setSelected:NO];
        [self.btnWeekdays setSelected:NO];
        [_eventRepeatTimeView setHidden:NO];
    }
    else if (btn == self.btnWeekly) {
        [self.btnOnce setSelected:NO];
        [self.btnDaily setSelected:NO];
        [self.btnWeekly setSelected:YES];
        [self.btnMOnthly setSelected:NO];
        [self.btnYearly setSelected:NO];
        [self.btnWeekdays setSelected:NO];
        [_eventRepeatTimeView setHidden:NO];
    }
    else if (btn == self.btnMOnthly) {
        [self.btnOnce setSelected:NO];
        [self.btnDaily setSelected:NO];
        [self.btnWeekly setSelected:NO];
        [self.btnMOnthly setSelected:YES];
        [self.btnYearly setSelected:NO];
        [self.btnWeekdays setSelected:NO];
        [_eventRepeatTimeView setHidden:NO];
    }
    else if(btn == self.btnWeekdays){
        [self.btnOnce setSelected:NO];
        [self.btnDaily setSelected:NO];
        [self.btnWeekly setSelected:NO];
        [self.btnMOnthly setSelected:NO];
        [self.btnYearly setSelected:NO];
        [self.btnWeekdays setSelected:YES];
        [_weeklyView setHidden:NO];
    }
    else  {
        [self.btnOnce setSelected:NO];
        [self.btnDaily setSelected:NO];
        [self.btnWeekly setSelected:NO];
        [self.btnMOnthly setSelected:NO];
        [self.btnWeekdays setSelected:NO];
        [self.btnYearly setSelected:YES];
        [_eventRepeatTimeView setHidden:NO];
    }
    
}
- (IBAction)btnNotificationAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn==self.btnEmail) {
        [self.btnEmail setSelected:YES];
        [self.btnSMS setSelected:NO];
        [self.btnPopUP setSelected:NO];
    }
    else if (btn == self.btnSMS){
        [self.btnEmail setSelected:NO];
        [self.btnSMS setSelected:YES];
        [self.btnPopUP setSelected:NO];
    }
    else{
        [self.btnEmail setSelected:NO];
        [self.btnSMS setSelected:NO];
        [self.btnPopUP setSelected:YES];
    }
    
}

- (IBAction)btnInviteAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn==self.btnCabinet) {
        [self addPopUP:@"Cabinet"];
        [self.btnCabinet setSelected:YES];
        [self.btnNetwork setSelected:NO];
        
    }
    else{
        [self addPopUP:@"Network"];
        [self.btnCabinet setSelected:NO];
        [self.btnNetwork setSelected:YES];
    }
}
- (IBAction)btnAttachFileAction:(id)sender {
}



-(void) date:(id) sender
{
    
    UITextField *txtField = (UITextField *)sender;
    isdate=(int)txtField.tag;
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [self.superview addSubview:datePickerView ];
    datePickerView .backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:.5f];
    
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance].screenHeight/3, [SavePrefrences sharedInstance].screenWidth-40, 300)];
    if (txtField.tag==201 || txtField.tag == 203 || txtField == _repeatTillDateTF) {
        datepicker.datePickerMode = UIDatePickerModeDate;
    }
    else{
        datepicker.datePickerMode = UIDatePickerModeTime;
    }
    
    
    
    datepicker.hidden = NO;
    [datepicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    datepicker.backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f];
    datepicker.layer.cornerRadius=60;
    datepicker.layer.masksToBounds=YES;
    datepicker.date = [NSDate date];
    
    [datePickerView addSubview:datepicker];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd"];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(datepicker.frame.size.width/2-55, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [save setTitle: @"OK" forState: UIControlStateNormal];
    save.tag=isdate;
    save.backgroundColor=[UIColor grayColor];
    [save addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    save.layer.cornerRadius=5;
    [datePickerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor grayColor];
    [cancel addTarget:self action:@selector(nook:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancel.layer.cornerRadius=5;
    [datePickerView addSubview:cancel];
    
}

-(IBAction)btnDoncPickerAction:(UIButton*)sender{
    self.calendarSelectTF.text = _myCalendars[[_pickerView selectedRowInComponent:0]][@"cal_name"];
    selectedCal = _myCalendars[[_pickerView selectedRowInComponent:0]];
    _pickerContainer.hidden = YES;
    [_calendarSelectTF resignFirstResponder];
}
-(IBAction)btnCancelPickerAction:(UIButton*)sender{
    _pickerContainer.hidden = YES;
    [_calendarSelectTF resignFirstResponder];
}


-(IBAction)ok:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if(!_eventRepeatTimeView.isHidden){
        [df setDateFormat:@"yyyy/MM/dd"];
        _repeatTillDateTF.text = [NSString stringWithFormat:@"%@",[df stringFromDate:datepicker.date]];
    }
    else if(isdate==201){
        [df setDateFormat:@"yyyy/MM/dd"];
        self.txtStartDate.text = [NSString stringWithFormat:@"%@",[df stringFromDate:datepicker.date]];
    }
    else if (isdate == 202){
        [df setDateFormat:@"HH:MM a"];
        self.txtStartTime.text =[NSString stringWithFormat:@"%@",[df stringFromDate:datepicker.date]];
    }
    else  if(isdate==203){
        [df setDateFormat:@"yyyy/MM/dd"];
        self.txtEndDate.text=[NSString stringWithFormat:@"%@",[df stringFromDate:datepicker.date]];
    }
    else{
        [df setDateFormat:@"HH:MM a"];
        self.txtEndTIme.text=[NSString stringWithFormat:@"%@",[df stringFromDate:datepicker.date]];
    }
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
    
}






-(IBAction)nook:(id)sender
{
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _pickerContainer.hidden = YES;
    if (textField.tag == 201 || textField.tag == 202 || textField.tag == 203 || textField.tag == 204) {
        [self date:textField];
    }
    else if(textField == self.txtCountry){
        [self.delegationListener didPressSelectCountry:self];
    }
    else if(textField == self.txtState){
        [self.delegationListener didPressSelectState:self];
        
    }
    else if(textField == self.txtCity){
        [self.delegationListener didPressSelectCity:self];
    }
    else if(textField == _repeatTillDateTF){
        [self date:textField];
    }else if (textField == _calendarSelectTF){
        if(_myCalendars && _myCalendars.count >0){
            [_pickerView reloadComponent:0];
            _pickerContainer.hidden = NO;
        }
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == _calendarSelectTF){
        return NO;
    }
    if(textField == self.txtCountry){
        return NO;
    }
    else if(textField == self.txtState){
       return NO;
    }
    else if(textField == self.txtCity){
        return NO;
    }
    return YES;
}

-(void)countrySel:(id)sender
{
    if(countryAr !=nil&&[countryAr count]>0)
    {
        [self showCountry];
    }
    else
    {
        isCallBack=@"4";
        SelectCountry * sc=[[SelectCountry alloc]init];
        UIViewController *vc = UIViewParentController(self);
        [sc getCountryList:vc];
    }
}

-(void)stateSel:(id)sender
{
    
    isCallBack=@"5";
    if([av checkCombo1:self.txtCountry])
    {
        SelectCountry * sc=[[SelectCountry alloc]init];
        [sc getState:UIViewParentController(self):cid];
    }
}


-(void)citySel:(id)sender
{
    isCallBack=@"6";
    if([av checkCombo1:self.txtState])
    {
        SelectCountry * sc=[[SelectCountry alloc]init];
        [sc getCity:UIViewParentController(self):stid];
    }
    
    
}

-(void)getCalendars{
    iscallback = 4;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Calender" :@"getCalender" :@"":@"":dic1 :self];
}

-(void) showCountry
{
    
    
    
    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Country:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[countryAr count];x++)
    {
        NSString *stname=[[countryAr objectAtIndex:x] valueForKey:@"countryName"];
        NSString *cid1=[[countryAr objectAtIndex:x] valueForKey:@"countryID"];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            //NSString * tile= [action title];
                                            self.txtCountry.text=stname;
                                            self.txtState.text=@"Select State";
                                            self.txtCity.text=@"Select City";
                                            cid=cid1;
                                            
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    AppDelegate *appDel = [[UIApplication sharedApplication]delegate];
    
    [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}



-(void) showState
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select State:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[stateAr count];x++)
    {
        NSString *stname=[[stateAr objectAtIndex:x] valueForKey:@"stateName"];
        NSString *sid1=[[stateAr objectAtIndex:x] valueForKey:@"stateID"];
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            self.txtState.text=stname;
                                            stid=sid1;
                                            self.txtCity.text=@"Select City";
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    AppDelegate *appDel = [[UIApplication sharedApplication]delegate];
    
    [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag== 109){
        
    }else{
        self.txtInterval.text = [self.arrData objectAtIndex:row];
    }
    
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag== 109){
        return self.myCalendars[row][@"cal_name"];
    }else{
        return  [self.arrData objectAtIndex:row];
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag== 109){
        return self.myCalendars.count;
    }else{
        return self.arrData.count;
    }
}

-(IBAction)doneWriting:(id)sender
{
    
    [self.txtInterval resignFirstResponder];
}

-(void) showCity
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select city:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[cityAr count];x++)
    {
        
        NSString *cityName=[[cityAr objectAtIndex:x] valueForKey:@"cityName"];
        NSString *cityID=[[cityAr objectAtIndex:x] valueForKey:@"cityID"];
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:cityName style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            self.txtCity.text=cityName;
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    AppDelegate *appDel = [[UIApplication sharedApplication]delegate];
    
    [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
    
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
    
    [search_lbl addTarget:self action:@selector(searchShare:) forControlEvents:UIControlEventEditingChanged];
    //    textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    
    
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
        
        //        NSLog(@"Search Tag Value==========%@",Search.tag);
    }
    
    return prMainView;
    //    [proyolkBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [proyolkBtn2 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    //    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]
    
}

//pach by kalpesh

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
    NSLog(@"inside Search===========%id",(int)btn.tag);
    
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
    }if(iscallback==4){
        _myCalendars = data;
        [_pickerView reloadAllComponents];
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
            
            NSLog(@"log iddd====%@",u_id);
            
            NSString *strUrl = @"https://proyolk.com";
            strUrl = [strUrl stringByAppendingString:[[shareAr objectAtIndex:indexPath.row]valueForKey:@"img"]];
            
            UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
            userpic.backgroundColor=[UIColor redColor];
            [userpic sd_setImageWithURL:[NSURL URLWithString:strUrl] ];
            userpic.layer.cornerRadius=22;
            userpic.clipsToBounds=YES;
            [cell_View addSubview:userpic];
            
            UILabel *uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            uname_lbl.text=uname;
            
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell_View addSubview: uname_lbl];
            
          //  UIButton  *invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
          //  [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
         //   invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
          //  [invite setTitle:@"Invite" forState:UIControlStateNormal];
          //  [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
          //  invite.tag=[u_id intValue];
          //  [invite addTarget:self action:@selector(inviteto:) forControlEvents:UIControlEventTouchUpInside];
         //   invite.layer.cornerRadius=4;
         //   [invite setClipsToBounds:YES];
         //   [cell_View addSubview:invite];
            
        //    UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
        //    isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
        //    isonimg.backgroundColor=[UIColor clearColor];
        //    [cell_View addSubview:isonimg];
       //     return cell;
            
            
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
            //  [userpic setImage:[UIImage imageNamed:@"user.png"]];
            [userpic sd_setImageWithURL:[NSURL URLWithString:strUrl] ];
            userpic.layer.cornerRadius=22;
            userpic.clipsToBounds=YES;
            [cell_View addSubview:userpic];
            
            UILabel  *uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textAlignment=NSTextAlignmentLeft;
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            
            uname_lbl.text=uname;
            
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell_View addSubview: uname_lbl];
            
            
            //pach by kalpesh
            
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



-(IBAction)inviteto:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    if([btn.titleLabel.text isEqual:@"Invite"])
    {
        [inviteAr addObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
        [btn setTitle:@"Invited" forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor clearColor];
        
        //        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        //          [dic setValue:[NSString stringWithFormat:@"%d",fileIdis] forKey:@"fId"];
        //        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"u_from"];
        //        [dic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"u_to"];
        //        iscallback=16;
        //        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"StInviteMem" :@"" :@"" :dic :self ];
    }
}

- (IBAction)weekDaySelection:(id)sender {
    UIButton* btn = (UIButton*)sender;
    if (btn.isSelected) [btn setSelected:NO];
    else [btn setSelected:YES];
}
- (IBAction)weekDaySelectionDone:(id)sender {
    if (!_weeklyView.isHidden) {
        [_weeklyView setHidden:YES];
        [_eventRepeatTimeView setHidden:NO];
    }else {
        if (_repeatTillDateTF.text.length) {
            tillDateValue = _repeatTillDateTF.text;
        }
        if (_repeatForDays.text.length){
            numOfDaysRepeat = _repeatForDays.text;
        }
        [self endEditing:YES];
        [_eventRepeatTimeView setHidden:YES];
    }
}
@end
