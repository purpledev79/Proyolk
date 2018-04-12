#import "AllPopUp.h"
#import "SavePrefrences.h"
#import "SelectCountry.h"
#import "AllValidationsViewController.h"
#import "ManageArray.h"
#import "ProfileView.h"

@interface AllPopUp ()
{
    UITextField *name,*degi;
    UITextField *fname,*mname,*lname,*email,*hobbies,*address,*ph_num,*mob_num,*fb_id,*twt_id,*ln_id,*go_id,*vim_id;
    UITextView *descrpt1,*desc1;
    UILabel *country1,*state1,*gender1,*imale,*ifemale,*info;
    UIViewController *vc1;
    NSString *isCallBack;
    NSString * stid ,*cid;
    NSArray *countryAr ,*stateAr,*cityAr;
    UIDatePicker *datepicker;
    UIView *selView,*mainouterView;
    ProfileView *prfv;
    AllValidationsViewController *av;
    int empID,iscalpub,isRelation,height,keybordheigh;
    UIScrollView * scrollbar,*prfvwscr;
    NSString *imgBuffer,*indid;
    UIImageView *imggeter;
    NSString *randomImgName;
    UILabel *NameLabel;
    ManageArray *mang;
    id sender1,sender2;
    UITextField *nameOfCertificateText,*nameOfOrganisationText,*subjectText,*PickdateText,*company_name,*presented_by;
}

@end
@implementation AllPopUp
@synthesize  countryAr;
@synthesize country,sate,year,city,eworking,sworking,prMainView,datePickerView,add,desc;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)keyboardWasShown:(NSNotification *)notification
{
    
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    height = MIN(keyboardSize.height,keyboardSize.width);
    int width = MAX(keyboardSize.height,keyboardSize.width);
    
    NSLog(@"keyboard height is %d",height);
    
}

#pragma mark addProfile

-(UIView *) addProfile:(UIViewController *)Vc
{
    av=[[AllValidationsViewController alloc]init];
    vc1=Vc;
    NSString *iname,*isdate,*edate,*idesgi,*icity,*icountry,*istate,*iadd,*ijdesc,*istitle;
    iname=@"Company Name";
    isdate=@"Select Started Working Date";
    edate= @"Select End Working Date";
    idesgi=@"Designation";
    icountry=@"Select Country";
    istate=@"Select State";
    icity=@"Select City";
    iadd=@"";
    ijdesc=@"";
    istitle=@"Add Employment";
    
    
    NSMutableDictionary *prf=[SavePrefrences sharedInstance].colorDictionry;
    
    // UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    prMainView.backgroundColor=[prf valueForKey:@"Popupbackcolor"];
    
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-40, 45+20)];
    NameLabel.text= [NSString stringWithFormat:@"  %@",istitle];
    NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    NameLabel.layer.cornerRadius=10;
    NameLabel.clipsToBounds = YES;
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [prMainView addSubview:NameLabel];
    
    
    prfvwscr = [[UIScrollView alloc]initWithFrame:CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+90))];
    prfvwscr.delegate = self;
    prfvwscr.scrollEnabled = YES;
    prfvwscr.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    prfvwscr.layer.cornerRadius=10;
    prfvwscr.clipsToBounds = YES;
    [prMainView addSubview:prfvwscr];
    
    
    name=[[UITextField alloc] initWithFrame:CGRectMake(20, 5, prfvwscr.frame.size.width-40, 40)];
    name.placeholder=iname;
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    name.attributedPlaceholder=[[NSAttributedString alloc] initWithString:iname attributes:@{NSForegroundColorAttributeName: color}];
    name.placeholder = @"Company Name";
    [name setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    name.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    name.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    ///////////
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    name.leftView = paddingView1;
    name.leftViewMode = UITextFieldViewModeAlways;
    ///////////
    name.delegate=self;
    name.clipsToBounds=YES;
    [prfvwscr addSubview:name];
    
    
    
    sworking=[[UILabel alloc] initWithFrame:CGRectMake(20,name.frame.origin.y+name.frame.size.height+15, prfvwscr.frame.size.width-40, 40)];
    //sworking.placeholder = @"Select Started Working Date";
    sworking.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    sworking.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    
    [sworking setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    sworking.clipsToBounds=YES;
    sworking.tag=0;
    //  sworking.layer.cornerRadius=6;
    [prfvwscr addSubview:sworking];
    sworking.text=[NSString stringWithFormat:@"  %@",isdate];
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    sworking.userInteractionEnabled = YES;
    [sworking addGestureRecognizer:sworkingreg];
    
    eworking=[[UILabel alloc] initWithFrame:CGRectMake(20, sworking.frame.size.height+sworking.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    eworking.text=[NSString stringWithFormat:@"  %@",edate];
    //eworking.placeholder = @"Select End Working Date";
    eworking.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    eworking.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    [eworking setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  eworking.layer.cornerRadius=6;
    eworking.clipsToBounds=YES;
    eworking.tag=1;
    [prfvwscr addSubview:eworking];
    
    UITapGestureRecognizer *eworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [eworkingreg setNumberOfTouchesRequired:1];
    [eworkingreg setDelegate:self];
    eworking.userInteractionEnabled = YES;
    [eworking addGestureRecognizer:eworkingreg];
    
    degi=[[UITextField alloc] initWithFrame:CGRectMake(20, eworking.frame.size.height+eworking.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    UIView *padding1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    degi.leftView = padding1;
    degi.placeholder = @"Designation";
    degi.leftViewMode = UITextFieldViewModeAlways;
    
    degi.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    degi.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    // degi.placeholder=idesgi;
    degi.attributedPlaceholder=[[NSAttributedString alloc] initWithString:idesgi attributes:@{NSForegroundColorAttributeName: color}];
    
    [degi setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  degi.layer.cornerRadius=6;
    
    [degi setDelegate:self];
    [prfvwscr addSubview:degi];
    
    
    country=[[UILabel alloc] initWithFrame:CGRectMake(20, degi.frame.size.height+degi.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    country.text=[NSString stringWithFormat:@"%@",icountry];
    
    country.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    country.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    country.clipsToBounds=YES;
    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //   country.layer.cornerRadius=6;
    [prfvwscr addSubview:country];
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    sate=[[UILabel alloc] initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    sate.text=[NSString stringWithFormat:@"%@",istate];
    
    sate.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    sate.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    sate.clipsToBounds=YES;
    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  sate.layer.cornerRadius=6;
    [prfvwscr addSubview:sate];
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    
    city=[[UILabel alloc] initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    city.text=[NSString stringWithFormat:@"%@",icity];
    
    city.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    city.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    city.clipsToBounds=YES;
    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  city.layer.cornerRadius=6;
    [prfvwscr addSubview:city];
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    
    
    //////////////////
    
    UIView *AddressView=[[UIView alloc]initWithFrame:CGRectMake(20, city.frame.size.height+city.frame.origin.y+15, prfvwscr.frame.size.width-40, 55)];
    AddressView.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];//
    [prfvwscr addSubview:AddressView];
    
    //    AddressLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 3, 120, 20)];
    //    AddressLabel.text=@"  Address";
    //    AddressLabel.textColor=[prf valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    //    [AddressLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //    AddressLabel.textAlignment=NSTextAlignmentLeft;
    //    AddressLabel.backgroundColor=[UIColor clearColor];
    //    [AddressView addSubview:AddressLabel];
    
    add=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, prfvwscr.frame.size.width-10, 55)];
    add.backgroundColor=[UIColor clearColor];
    add.placeholder = @"Address";
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    add.placeholderColor = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    add.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    add.tag=7;
    add.tag=1002;
    add.delegate=self;
    [AddressView addSubview:add];
    
    
    
    
    UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(20, AddressView.frame.size.height+AddressView.frame.origin.y+15,  prfvwscr.frame.size.width-40,100)];
    descriptionView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    [prfvwscr addSubview:descriptionView];
    
    //    descriptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 3,  120,20)];
    //    descriptionLabel.text=@"  Description";
    //    descriptionLabel.textColor=[prf valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    //    [descriptionLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //    descriptionLabel.textAlignment=NSTextAlignmentLeft;
    //    descriptionLabel.backgroundColor=[UIColor clearColor];
    //    [descriptionView addSubview:descriptionLabel];
    
    desc=[[UITextView alloc] initWithFrame:CGRectMake(0, 0,  prfvwscr.frame.size.width-10,100)];
    desc.placeholderColor = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    desc.placeholder =@"Description";
    desc.backgroundColor=[UIColor clearColor];
    desc.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    [desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    desc.tag=7;
    desc.tag=1003;
    desc.delegate=self;
    [descriptionView addSubview:desc];
    //desc.attributedPlaceholder=[[NSAttributedString alloc] initWithString:ijdesc attributes:@{NSForegroundColorAttributeName: color}];
    
    ///////////////////
    
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35, descriptionView.frame.size.height+descriptionView.frame.origin.y+10, prfvwscr.frame.size.width/2-40, 35)];
    [save setTitle: @"Add" forState: UIControlStateNormal];
    save.backgroundColor=[prf valueForKey:@"Yellowbtncolor"];
    [save addTarget:self action:@selector(saveEmployementProfile:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //  save.layer.cornerRadius=6;
    save.tag=0;
    [prfvwscr addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+15, descriptionView.frame.size.height+descriptionView.frame.origin.y+10, prfvwscr.frame.size.width/2-40, 35)];
    [cancel setTitle: @"Close" forState: UIControlStateNormal];
    cancel.backgroundColor=[prf valueForKey:@"Yellowbtncolor"];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // cancel.layer.cornerRadius=6;
    [prfvwscr addSubview:cancel];
    
    prfvwscr.contentSize=CGSizeMake(prfvwscr.frame.size.width, cancel.frame.size.height+cancel.frame.origin.y+20);
    
    return prMainView;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    NSLog(@"donnnnnnn");
    
    if(textField==fname|| textField==lname || textField==mname   ||textField==degi || textField==name || textField==nameOfCertificateText || textField==nameOfOrganisationText || textField==company_name || textField==presented_by || textField==hobbies)
    {
        NSString *validnumbers;
        
        if (textField == hobbies) {
            validnumbers=@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz,";
        }
        else{
            validnumbers=@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz";
        }
        
        
        NSCharacterSet * notDigits = [NSCharacterSet characterSetWithCharactersInString:validnumbers];
        if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        {
            
            if (range.length == 1)
            {
                string=@" ";
            }
            else
            {
                UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Alphabets only" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alrt show];
                return NO;//not correct return 0
                
            }
            
        }
        
        
    }
    
    
    if(textField==ph_num || textField==mob_num)
    {
        
        
        NSString *validnumbers=@"0123456789+";
        
        NSCharacterSet *valid=[NSCharacterSet characterSetWithCharactersInString:validnumbers];
        NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:string];
        
        BOOL stringIsValid = [valid isSupersetOfSet:characterSetFromTextField];
        if(!stringIsValid)
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter only number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alrt show];
            return NO;
            
        }
        NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if([searchStr length]>13 )
        {
            if(textField==ph_num)
            {
                ph_num.text=@" ";
            }
            if(textField==mob_num)
            {
                mob_num.text=@" ";
            }
            return NO;
            
            
        }
        else if([searchStr length]==13)
        {
            return YES;
        }
        
    }
    
    return  YES;
}
-(UIView *) editProfile:(UIViewController *)Vc:(NSArray *) employementAr:(int) selId
{
    NSString *iname,*isdate,*edate,*idesgi,*icity,*icountry,*istate,*iadd,*ijdesc,*istitle;
    
    istitle=@"Update Employment";
    
    for(int x=0;x<[employementAr count];x++)
    {
        int pre=[[[employementAr objectAtIndex:x] valueForKey:@"emp_id"] intValue];
        if(selId==pre)
        {
            
            iname=   [[employementAr objectAtIndex:x] valueForKey:@"company_name"];
            isdate=   [[employementAr objectAtIndex:x] valueForKey:@"started_working"];
            edate=[[employementAr objectAtIndex:x] valueForKey:@"end_working"];
            iadd=[[employementAr objectAtIndex:x] valueForKey:@"address"];
            icity=[[employementAr objectAtIndex:x] valueForKey:@"city"];
            istate=[[employementAr objectAtIndex:x] valueForKey:@"state"];
            icountry= [[employementAr objectAtIndex:x] valueForKey:@"country"];
            ijdesc=[[employementAr objectAtIndex:x] valueForKey:@"job_desc"];
            idesgi=[[employementAr objectAtIndex:x] valueForKey:@"designation"];
            empID=selId;
            break;
        }
    }
    
    av=[[AllValidationsViewController alloc]init];
    vc1=Vc;
    //  UIColor *color = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    
    [Vc.view addSubview:prMainView];
    
    
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-40, 40+20)];
    NameLabel.text=[NSString stringWithFormat:@"  %@",istitle];
    NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    NameLabel.layer.cornerRadius=10;
    NameLabel.clipsToBounds = YES;
    NameLabel.textAlignment=NSTextAlignmentCenter;
    [prMainView addSubview:NameLabel];
    
    
    prfvwscr = [[UIScrollView alloc]initWithFrame:CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+100))];
    prfvwscr.delegate = self;
    prfvwscr.scrollEnabled = YES;
    prfvwscr.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[edtprf valueForKey:@"Scrollcolor"];
    prfvwscr.layer.cornerRadius=10;
    prfvwscr.clipsToBounds = YES;
    
    [prMainView addSubview:prfvwscr];
    
    
    name=[[UITextField alloc] initWithFrame:CGRectMake(20, 5, prfvwscr.frame.size.width-40, 40)];
    name.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    name.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    name.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    name.delegate=self;
    
    UIView *padding1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    name.leftView = padding1;
    name.leftViewMode = UITextFieldViewModeAlways;
    
    name.text=iname;
    [prfvwscr addSubview:name];
    
    
    
    
    sworking=[[UITextField alloc] initWithFrame:CGRectMake(20,name.frame.origin.y+name.frame.size.height+15, prfvwscr.frame.size.width-40, 40)];
    sworking.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    sworking.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    UIView *padding2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    sworking.leftView = padding2;
    sworking.leftViewMode = UITextFieldViewModeAlways;
    
    
    sworking.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    sworking.tag=0;
    sworking.userInteractionEnabled=NO;
    //  sworking.layer.cornerRadius=5;
    sworking.clipsToBounds=YES;
    [prfvwscr addSubview:sworking];
    sworking.text=isdate;
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    sworking.userInteractionEnabled = YES;
    [sworking addGestureRecognizer:sworkingreg];
    
    eworking=[[UITextField alloc] initWithFrame:CGRectMake(20, sworking.frame.size.height+sworking.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    eworking.text=edate;
    eworking.userInteractionEnabled=NO;
    eworking.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    eworking.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    UIView *padding24 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    eworking.leftView = padding24;
    eworking.leftViewMode = UITextFieldViewModeAlways;
    
    
    eworking.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    eworking.tag=1;
    //  eworking.layer.cornerRadius=5;
    eworking.clipsToBounds=YES;
    [prfvwscr addSubview:eworking];
    
    UITapGestureRecognizer *eworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [eworkingreg setNumberOfTouchesRequired:1];
    [eworkingreg setDelegate:self];
    eworking.userInteractionEnabled = YES;
    [eworking addGestureRecognizer:eworkingreg];
    
    
    degi=[[UITextField alloc] initWithFrame:CGRectMake(20, eworking.frame.size.height+eworking.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    // degi.attributedPlaceholder=[[NSAttributedString alloc] initWithString:idesgi attributes:@{NSForegroundColorAttributeName: color}];
    degi.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    degi.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    UIView *padding23 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    degi.leftView = padding23;
    degi.leftViewMode = UITextFieldViewModeAlways;
    
    
    degi.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    degi.text=[NSString stringWithFormat:@"  %@",idesgi];
    [degi setDelegate:self];
    [prfvwscr addSubview:degi];
    
    country=[[UILabel alloc] initWithFrame:CGRectMake(20, degi.frame.size.height+degi.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    country.text=[NSString stringWithFormat:@"%@",icountry];
    country.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    country.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    country.clipsToBounds=YES;
    // country.textColor=[edtprf valueForKey:@"Scrollcolor"];
    //  country.layer.cornerRadius=5;
    country.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    
    [prfvwscr addSubview:country];
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    sate=[[UILabel alloc] initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    sate.text=[NSString stringWithFormat:@"%@",istate];
    sate.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    sate.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    sate.clipsToBounds=YES;
    sate.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [prfvwscr addSubview:sate];
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    city=[[UILabel alloc] initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15, prfvwscr.frame.size.width-40, 40)];
    city.text=[NSString stringWithFormat:@"%@",icity];;
    city.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    city.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    city.clipsToBounds=YES;
    city.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [prfvwscr addSubview:city];
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    
    
    
    
    
    //////////////////
    
    UIView *AddressView=[[UIView alloc]initWithFrame:CGRectMake(20, city.frame.size.height+city.frame.origin.y+15, prfvwscr.frame.size.width-40, 55)];
    AddressView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    [prfvwscr addSubview:AddressView];
    
    /* UILabel *addlab=[[UILabel alloc] initWithFrame:CGRectMake(0, 3, 120, 20)];
     addlab.text=@"Address";
     addlab.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
     addlab.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
     addlab.textAlignment=NSTextAlignmentLeft;
     addlab.backgroundColor=[UIColor clearColor];
     [AddressView addSubview:addlab];*/
    
    add=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, prfvwscr.frame.size.width-10, 55)];
    
    
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    add.placeholder =@"Address";
    add.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
    add.placeholderColor = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    add.delegate=self;
    add.tag=6;
    add.text=iadd;
    add.layer.cornerRadius=5;
    add.placeholderColor = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    [AddressView addSubview:add];
    
    
    UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(20, AddressView.frame.size.height+AddressView.frame.origin.y+15,  prfvwscr.frame.size.width-40,100)];
    descriptionView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    [prfvwscr addSubview:descriptionView];
    
    /* UILabel *desclab=[[UILabel alloc] initWithFrame:CGRectMake(0, 3,  120,20)];
     desclab.text=@"Description";
     desclab.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
     desclab.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
     desclab.textAlignment=NSTextAlignmentLeft;
     desclab.backgroundColor=[UIColor clearColor];
     [descriptionView addSubview:desclab];*/
    
    desc=[[UITextView alloc] initWithFrame:CGRectMake(0, 0,  prfvwscr.frame.size.width-10,100)];
    [desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    desc.placeholder =@"Description";
    desc.backgroundColor=[UIColor clearColor];
    desc.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    
    desc.backgroundColor=[UIColor clearColor];
    //desc.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    desc.tag=9;
    desc.placeholder = @"Description";
    desc.delegate=self;
    desc.text= ijdesc;
    desc.placeholderColor = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    [desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    desc.backgroundColor=[UIColor clearColor];
    desc.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    [descriptionView addSubview:desc];
    //desc.attributedPlaceholder=[[NSAttributedString alloc] initWithString:ijdesc attributes:@{NSForegroundColorAttributeName: color}];
    
    ///////////////////
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35, descriptionView.frame.size.height+descriptionView.frame.origin.y+10, prfvwscr.frame.size.width/2-40, 35)];
    [save setTitle: @"Update" forState: UIControlStateNormal];
    save.backgroundColor=[UIColor clearColor];//[edtprf valueForKey:@"Yellowbtncolor"];
    [save addTarget:self action:@selector(saveEmployementProfile:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    save.tag=1;
    [prfvwscr addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+5, descriptionView.frame.size.height+descriptionView.frame.origin.y+10, prfvwscr.frame.size.width/2-40, 35)];
    [cancel setTitle: @"Close" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor clearColor];//[edtprf valueForKey:@"Yellowbtncolor"];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    // cancel.layer.cornerRadius=5;
    [prfvwscr addSubview:cancel];
    
    prfvwscr.contentSize=CGSizeMake(prfvwscr.frame.size.width, cancel.frame.size.height+cancel.frame.origin.y+20);
    
    return prMainView;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    keybordheigh=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
}

#pragma mark textViewDidBeginEditing
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    
    NSLog(@"keyboard height===%d",keybordheigh);
    NSLog(@"keyboard textView===%lu",textView.tag);
    
    //    if(keybordheigh<=0)
    //    {
    //        keybordheigh=258;
    //    }
    
    scrollbar.frame=CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70+keybordheigh+220));
    
    if(textView.tag==1000)
    {
        [AddressLabel setHidden:YES];
    }
    if(textView.tag==1001)
    {
        [descriptionLabel setHidden:YES];
    }
    if(textView.tag==1002)
    {
        [AddressLabel setHidden:YES];
    }
    if(textView.tag==1003)
    {
        [descriptionLabel setHidden:YES];
    }
    
    if(textView.tag==descrpt1.tag)
    {
        
        
        [scrollbar setContentOffset:CGPointMake(0, 850) animated:YES];
        
    }
    if(textView==desc|| textView==add)
    {
        NSLog(@"in 2");
        [scrollbar setContentOffset:CGPointMake(0, 440) animated:YES];
    }
    if(textView==desc1||textView==add)
    {
        NSLog(@"in 3");
        
        [scrollbar setContentOffset:CGPointMake(0, 440) animated:YES];
    }
    if(textView==add|| textView==desc)
    {
        NSLog(@"in 4");
        [prfvwscr setContentOffset:CGPointMake(0, 340) animated:YES];
        
        prfvwscr.frame=CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70+keybordheigh+240));
    }
    if((int)textView.tag==7)
    {
        prfvwscr.frame =CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+keybordheigh+240+70));
    }
    
    NSLog(@"statut eddddd");
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"end edittttttt");
    if (textView == descrpt1) {
        if (textView.text.length<=0) {
            textView.text = @"description";
        }
    }
    //scrollbar.userInteractionEnabled=YES;
    
    //[scrollbar setContentOffset:CGPointMake(0, 200) animated:YES];
    //[prfvwscr setContentOffset:CGPointMake(0, 200) animated:YES];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSLog(@"herererereeeeee");
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        scrollbar.frame=CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70));
        
        
        prfvwscr.frame =CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+100));
        
        
        
        //scrollbar.frame=CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y+20, [SavePrefrences sharedInstance ].screenWidth, [SavePrefrences sharedInstance ].screenHeight-150);
        //footerView.frame=CGRectMake(0, prMainView.frame.size.height-70, prMainView.frame.size.width, 56);
        
        //entrmsg.frame=CGRectMake(10,prMainView.frame.size.height-70, [SavePrefrences sharedInstance].screenWidth-70, 40);
        // send.frame=CGRectMake(entrmsg.frame.size.width+entrmsg.frame.origin.x+5, prMainView.frame.size.height-70, 40, 40);
        // [self sendMsg];
    }
    
    
    return YES;
}


-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+5, prMainView.frame.size.width-40, 60)];
    NameLabel.text=title;
    NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];;
    NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    NameLabel.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    NameLabel.textAlignment=NSTextAlignmentCenter;
    NameLabel.layer.cornerRadius=10;
    NameLabel.clipsToBounds = YES;
    
    [prMainView addSubview:NameLabel];
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    
    scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[tt valueForKey:@"Scrollcolor"];
    scrollbar.layer.cornerRadius=10;
    
    [prMainView addSubview:scrollbar];
    return prMainView;
    
}


#pragma mark Certificate

-(void) AddCertificateDetails:(UIViewController *)Vc
{
    [self MainView :Vc:@"Certificate Details"];
    
    imggeter = [[UIImageView alloc] initWithFrame:CGRectMake( scrollbar.frame.size.width/2+20 , NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 60, 60)];//(scrollbar.frame.size.width/2-50, NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 100, 100)];
    imggeter.backgroundColor=[UIColor clearColor];
    [imggeter setImage:[UIImage imageNamed:@"username.png"]];
    [scrollbar addSubview:imggeter];
    
    
    NSMutableDictionary *crtadd=[SavePrefrences sharedInstance].colorDictionry;
    UIButton *btnGo= [[UIButton alloc]initWithFrame:CGRectMake(20,NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 160, 60)];
    //scrollbar.frame.size.width/2-80,imggeter.frame.size.height+imggeter.frame.origin.y+10, 160, 35)];
    [btnGo setTitle: @"Add Photo" forState: UIControlStateNormal];
    btnGo.backgroundColor=[crtadd valueForKey:@"Yellowbtncolor"];
    [btnGo addTarget:self action:@selector(chooseOption:) forControlEvents:UIControlEventTouchUpInside];
    [btnGo setTitleColor:[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    btnGo.tag=1;
    [scrollbar addSubview:btnGo];
    
    
    
    nameOfCertificateText=[[UITextField alloc]initWithFrame:CGRectMake(20, btnGo.frame.size.height+btnGo.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    nameOfCertificateText.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    nameOfCertificateText.textColor=[crtadd valueForKey:@"Scrollcolor"];
    nameOfCertificateText.delegate=self;
    [nameOfCertificateText setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  nameOfCertificateText.layer.cornerRadius=6;
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    nameOfCertificateText.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Name Of Certificate" attributes:@{NSForegroundColorAttributeName: color}];
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    nameOfCertificateText.leftView = paddingView1;
    nameOfCertificateText.leftViewMode = UITextFieldViewModeAlways;
    
    
    [scrollbar addSubview:nameOfCertificateText];
    
    nameOfOrganisationText=[[UITextField alloc]initWithFrame:CGRectMake(20, nameOfCertificateText.frame.size.height+nameOfCertificateText.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    nameOfOrganisationText.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    nameOfOrganisationText.textColor=[crtadd valueForKey:@"Scrollcolor"];
    //  nameOfOrganisationText.placeholder=@"Name Of Organisation";
    // UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    nameOfOrganisationText.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Name Of Organisation" attributes:@{NSForegroundColorAttributeName: color}];
    
    // nameOfOrganisationText.layer.cornerRadius=6;
    nameOfOrganisationText.delegate=self;
    [nameOfOrganisationText setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    UIView *padding1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    nameOfOrganisationText.leftView = padding1;
    nameOfOrganisationText.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:nameOfOrganisationText];
    
    subjectText=[[UITextField alloc]initWithFrame:CGRectMake(20, nameOfOrganisationText.frame.size.height+nameOfOrganisationText.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    subjectText.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    subjectText.textColor=[crtadd valueForKey:@"Scrollcolor"];
    subjectText.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Subject" attributes:@{NSForegroundColorAttributeName: color}];
    
    subjectText.delegate=self;
    [subjectText setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  subjectText.layer.cornerRadius=6;
    UIView *padding11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    subjectText.leftView = padding11;
    subjectText.leftViewMode = UITextFieldViewModeAlways;
    
    
    [scrollbar addSubview:subjectText];
    
    sworking=[[UITextField alloc]initWithFrame:CGRectMake(20, subjectText.frame.size.height+subjectText.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    sworking.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    sworking.textColor=[crtadd valueForKey:@"Scrollcolor"];
    sworking.delegate=self;
    
    UIView *padding12 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    sworking.leftView = padding12;
    sworking.leftViewMode = UITextFieldViewModeAlways;
    sworking.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Pick Date" attributes:@{NSForegroundColorAttributeName: color}];
    
    [sworking setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    // sworking.layer.cornerRadius=6;
    sworking.userInteractionEnabled=NO;
    [scrollbar addSubview:sworking];
    
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    sworking.userInteractionEnabled = YES;
    [sworking addGestureRecognizer:sworkingreg];
    
    
    
    
    country=[[UILabel alloc]initWithFrame:CGRectMake(20, sworking.frame.size.height+sworking.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    country.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    country.clipsToBounds=YES;
    country.text=@"  Select Country";
    country.textColor=[crtadd valueForKey:@"Scrollcolor"];
    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    // country.layer.cornerRadius=6;
    [scrollbar addSubview:country];
    
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    
    
    sate=[[UILabel alloc]initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15 ,scrollbar.frame.size.width-40, 40)];
    sate.backgroundColor=[UIColor whiteColor];
    sate.clipsToBounds=YES;
    sate.text=@"  Select State";
    // sate.layer.cornerRadius=6;
    sate.textColor=[crtadd valueForKey:@"Scrollcolor"];
    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:sate];
    
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    
    city=[[UILabel alloc]initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    city.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    city.clipsToBounds=YES;
    city.text=@"  Select City";
    city.textColor=[crtadd valueForKey:@"Scrollcolor"];
    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    // city.layer.cornerRadius=6;
    [scrollbar addSubview:city];
    
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    //////////////////
    
    UIView *AddressView=[[UIView alloc]initWithFrame:CGRectMake(20, city.frame.size.height+city.frame.origin.y+15, scrollbar.frame.size.width-40, 55)];
    AddressView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    [scrollbar addSubview:AddressView];
    
    //    AddressLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 3, 120, 20)];
    //    AddressLabel.text=@"  Address";
    //    [AddressLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //    AddressLabel.textColor=[crtadd valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    //    AddressLabel.textAlignment=NSTextAlignmentLeft;
    //    AddressLabel.backgroundColor=[UIColor clearColor];
    //    [AddressView addSubview:AddressLabel];
    //
    add=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, scrollbar.frame.size.width-10, 55)];
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[crtadd valueForKey:@"Scrollcolor"];
    add.delegate=self;
    add.placeholder = @"Address";
    add.tag=1;
    add.tag=1002;
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    // add.placeholder =@"Description";
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    [AddressView addSubview:add];
    
    UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(20, AddressView.frame.size.height+AddressView.frame.origin.y+15,  scrollbar.frame.size.width-40,100)];
    descriptionView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    [scrollbar addSubview:descriptionView];
    
    //    descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 3,  120,20)];
    //    descriptionLabel.text=@"  Description";
    //    [descriptionLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //    descriptionLabel.textColor=[crtadd valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    //    descriptionLabel.textAlignment=NSTextAlignmentLeft;
    //    descriptionLabel.backgroundColor=[UIColor clearColor];
    //    [descriptionView addSubview:descriptionLabel];
    
    desc1=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,  scrollbar.frame.size.width-10,100)];
    desc1.placeholder = @"Description";
    desc1.backgroundColor=[UIColor clearColor];
    [desc1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    desc1.textColor=[crtadd valueForKey:@"Scrollcolor"];
    desc1.delegate=self;
    desc1.tag=1003;
    desc.tag=1;
    [desc1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    desc1.placeholder =@"Description";
    desc1.backgroundColor=[UIColor clearColor];
    desc1.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    [descriptionView addSubview:desc1];
    
    
    ///////////////////
    
    
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35,descriptionView.frame.size.height+descriptionView.frame.origin.y+10 , scrollbar.frame.size.width/2 -40, 35)];
    [save setTitle: @"Add" forState: UIControlStateNormal];
    save.tag=1;
    save.backgroundColor=[crtadd valueForKey:@"Yellowbtncolor"];
    [save addTarget:self action:@selector(saveCertificate:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //  save.layer.cornerRadius=5;
    
    
    [scrollbar addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+5,descriptionView.frame.size.height+descriptionView.frame.origin.y+10 , scrollbar.frame.size.width/2 -40, 35)];
    [cancel setTitle: @"Close" forState: UIControlStateNormal];
    cancel.backgroundColor=[crtadd valueForKey:@"Yellowbtncolor"];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //  cancel.layer.cornerRadius=5;
    [scrollbar addSubview:cancel];
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, cancel.frame.size.height+cancel.frame.origin.y+10);
}

-(void) EditCertificateDetails:(UIViewController *)Vc:(int) cidw:(NSArray *) certAr
{
    
    
    NSString   *istitle=@"Update Certificate";
    NSString *inoc=@"Name Of Certificate",*inoo=@"Name Of Organisation",*ist=@"Subject",*ipd=@"Pick Date",*ic=@"Select Country",*is=@" Select State",*icty=@" Select City",*iadd=@"",*idesc=@"",*isav= @"Save",*icancl= @"Cancel",*image=@"Browse",*ieadd=@"",*iedesc=@"";
    [self MainView:Vc:@"Certificate Details"];
    
    
    
    for(int x=0;x<[certAr count];x++)
    {
        int pre=[[[certAr objectAtIndex:x] valueForKey:@"c_id"] intValue];
        if(cidw==pre)
        {
            
            ieadd=   [[certAr objectAtIndex:x] valueForKey:@"address"];
            iedesc=   [[certAr objectAtIndex:x] valueForKey:@"c_desc"];
            //edate=[[certAr objectAtIndex:x] valueForKey:@"c_id"];
            ipd=[[certAr objectAtIndex:x] valueForKey:@"cert_when"];
            inoc=[[certAr objectAtIndex:x] valueForKey:@"certificate_name"];
            icty=[[certAr objectAtIndex:x] valueForKey:@"city"];
            ic= [[certAr objectAtIndex:x] valueForKey:@"country"];
            image=[[certAr objectAtIndex:x] valueForKey:@"image"];
            inoo=[[certAr objectAtIndex:x] valueForKey:@"name_org"];
            is=[[certAr objectAtIndex:x] valueForKey:@"state"];
            ist=[[certAr objectAtIndex:x] valueForKey:@"subject"];
            empID=cidw;
            break;
        }
    }
    
    //  imggeter = [[UIImageView alloc] initWithFrame:CGRectMake( 20 , NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 60, 60)];
    
    imggeter = [[UIImageView alloc] initWithFrame:CGRectMake(scrollbar.frame.size.width/2+20, NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 60, 60)];
    imggeter.backgroundColor=[UIColor clearColor];
    [imggeter setImage:[UIImage imageNamed:@"username.png"]];
    [scrollbar addSubview:imggeter];
    
    mang=[[ManageArray alloc] init];
    NSString * url=[mang concatUrl:image];
    NSLog(@"imag vw %@",url);
    [imggeter sd_setImageWithURL:[NSURL URLWithString:url]];
    //    if(url.length<12)
    //    {
    //        imggeter.image = [UIImage imageNamed:@"username.png"];
    //    }
    //    else
    //    {
    //        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    //        if (imageData.length<=0)
    //            imggeter.image = [UIImage imageNamed:@"username.png"];
    //        else
    //            imggeter.image = [UIImage imageWithData:imageData];
    //    }
    imggeter.userInteractionEnabled = YES;
    
    
    NSMutableDictionary *crtclr=[SavePrefrences sharedInstance].colorDictionry;
    UIButton *btnGo= [[UIButton alloc]initWithFrame:CGRectMake(20,NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 100, 60)];//scrollbar.frame.size.width/2-80,imggeter.frame.size.height+imggeter.frame.origin.y+10, 160, 35)];
    [btnGo setTitle:@"Add Photo" forState: UIControlStateNormal];
    btnGo.backgroundColor=[crtclr valueForKey:@"Yellowbtncolor"];
    [btnGo addTarget:self action:@selector(chooseOption:) forControlEvents:UIControlEventTouchUpInside];
    [btnGo setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    btnGo.tag=1;
    [scrollbar addSubview:btnGo];
    
    
    
    nameOfCertificateText=[[UITextField alloc]initWithFrame:CGRectMake(20, btnGo.frame.size.height+btnGo.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    nameOfCertificateText.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    nameOfCertificateText.text=inoc;
    nameOfCertificateText.placeholder =@"Name Of Certificate";
    nameOfCertificateText.textColor=[crtclr valueForKey:@"Scrollcolor"];
    [nameOfCertificateText setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    UIView *padding13 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    nameOfCertificateText.leftView = padding13;
    nameOfCertificateText.leftViewMode = UITextFieldViewModeAlways;
    
    nameOfCertificateText.delegate=self;
    [scrollbar addSubview:nameOfCertificateText];
    
    nameOfOrganisationText=[[UITextField alloc]initWithFrame:CGRectMake(20, nameOfCertificateText.frame.size.height+nameOfCertificateText.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    nameOfOrganisationText.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    nameOfOrganisationText.textColor=[crtclr valueForKey:@"Scrollcolor"];
    nameOfOrganisationText.text=inoo;
    nameOfCertificateText.placeholder =@"Name Of Organisation";
    nameOfOrganisationText.delegate=self;
    UIView *padding11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    nameOfOrganisationText.leftView = padding11;
    nameOfOrganisationText.leftViewMode = UITextFieldViewModeAlways;
    
    [nameOfOrganisationText setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:nameOfOrganisationText];
    
    subjectText=[[UITextField alloc]initWithFrame:CGRectMake(20, nameOfOrganisationText.frame.size.height+nameOfOrganisationText.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    subjectText.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    subjectText.textColor=[crtclr valueForKey:@"Scrollcolor"];
    subjectText.text=ist;
    subjectText.delegate=self;
    subjectText.placeholder =@"Subject";
    [subjectText setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    UIView *padding14 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    subjectText.leftView = padding14;
    subjectText.leftViewMode = UITextFieldViewModeAlways;
    [scrollbar addSubview:subjectText];
    
    sworking=[[UITextField alloc]initWithFrame:CGRectMake(20, subjectText.frame.size.height+subjectText.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    sworking.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    sworking.textColor=[crtclr valueForKey:@"Scrollcolor"];
    sworking.text=ipd;
    sworking.placeholder =@"Pick Date";
    sworking.delegate=self;
    [sworking setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    UIView *padding15 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    sworking.leftView = padding15;
    sworking.leftViewMode = UITextFieldViewModeAlways;
    [scrollbar addSubview:sworking];
    
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    sworking.userInteractionEnabled = YES;
    [sworking addGestureRecognizer:sworkingreg];
    
    
    
    
    country=[[UILabel alloc]initWithFrame:CGRectMake(20, sworking.frame.size.height+sworking.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    country.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    country.text=[NSString stringWithFormat:@"%@",ic];
    //  country.placeholder =@"Select Country";
    country.textColor=[crtclr valueForKey:@"Scrollcolor"];
    country.clipsToBounds=YES;
    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  country.layer.cornerRadius=6;
    [scrollbar addSubview:country];
    
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    
    
    sate=[[UILabel alloc]initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15 ,scrollbar.frame.size.width-40, 40)];
    sate.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    sate.clipsToBounds=YES;
    sate.text=[NSString stringWithFormat:@"%@",is];
    sate.textColor=[crtclr valueForKey:@"Scrollcolor"];
    //  sate.layer.cornerRadius=6;
    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:sate];
    
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    
    city=[[UILabel alloc]initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    city.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    city.clipsToBounds=YES;
    city.textColor=[crtclr valueForKey:@"Scrollcolor"];
    city.text=[NSString stringWithFormat:@"%@",icty];
    
    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    // city.layer.cornerRadius=6;
    [scrollbar addSubview:city];
    
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    
    //////////////////////
    
    UIView *AddressView=[[UIView alloc]initWithFrame:CGRectMake(20, city.frame.size.height+city.frame.origin.y+15, scrollbar.frame.size.width-40, 55)];
    AddressView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    [scrollbar addSubview:AddressView];
    
    /* AddressLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 3, 120, 20)];
     AddressLabel.text=@"Address";
     [AddressLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
     AddressLabel.textColor=[dtl valueForKey:@"Scrollcolor"];//[UIColor blackColor];
     AddressLabel.textAlignment=NSTextAlignmentLeft;
     AddressLabel.backgroundColor=[UIColor clearColor];
     [AddressView addSubview:AddressLabel];*/
    
    add=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, scrollbar.frame.size.width-10, 55)];
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[crtclr valueForKey:@"Scrollcolor"];
    add.text=ieadd;
    add.placeholder = @"Address";
    add.delegate=self;
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  add.placeholder =@"Description";
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    [AddressView addSubview:add];
    
    UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(20, AddressView.frame.size.height+AddressView.frame.origin.y+15,  scrollbar.frame.size.width-40,100)];
    descriptionView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    [scrollbar addSubview:descriptionView];
    
    /* descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 3,  120,20)];
     descriptionLabel.text=@"Description";
     [descriptionLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
     descriptionLabel.textColor=[dtl valueForKey:@"Scrollcolor"];//[UIColor blackColor];
     descriptionLabel.textAlignment=NSTextAlignmentLeft;
     descriptionLabel.backgroundColor=[UIColor clearColor];
     [descriptionView addSubview:descriptionLabel];*/
    
    desc=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,  scrollbar.frame.size.width-10,100)];
    desc.placeholder = @"Description";
    desc.backgroundColor=[UIColor clearColor];
    desc.textColor=[crtclr valueForKey:@"Scrollcolor"];
    [desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    desc.delegate=self;
    desc.text=iedesc;
    [desc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    desc.placeholder =@"Description";
    desc.backgroundColor=[UIColor clearColor];
    desc.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    [descriptionView addSubview:desc];
    
    //////////////////////
    
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35,descriptionView.frame.size.height+descriptionView.frame.origin.y+10 , scrollbar.frame.size.width/2 -40, 35)];
    save.tag=2;
    [save setTitle:@"Update"forState: UIControlStateNormal];
    save.backgroundColor=[crtclr valueForKey:@"Yellowbtncolor"];
    [save addTarget:self action:@selector(saveCertificate:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    
    [scrollbar addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+5,descriptionView.frame.size.height+descriptionView.frame.origin.y+10 , scrollbar.frame.size.width/2-40, 35)];
    [cancel setTitle:@"Close"forState: UIControlStateNormal];
    cancel.backgroundColor=[crtclr valueForKey:@"Yellowbtncolor"];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [scrollbar addSubview:cancel];
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, 800);
}


#pragma mark AWARD


-(void) AddAward:(UIViewController *)Vc
{
    vc1=Vc;
    [self MainView:Vc:@"Award Details"];
    NSMutableDictionary *clr=[SavePrefrences sharedInstance].colorDictionry;
    
    NSString *ibrwse=@"Add Photo",*icn=@"Company Name",*iaw=@"Award when",*ipb=@"Presented By",*ic=@"Select Country",*is=@"Select State",*icty=@"Select City",*iadl=@"",*idscl=@"",*isav=@"Save",*iclse=@"Close" ;
    
    
    imggeter = [[UIImageView alloc] initWithFrame:CGRectMake(scrollbar.frame.size.width/2+20, NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 60, 60)];
    imggeter.backgroundColor=[UIColor clearColor];
    
    [imggeter setImage:[UIImage imageNamed:@"username.png"]];
    [scrollbar addSubview:imggeter];
    
    UIButton *browse=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //browse.frame=CGRectMake(scrollbar.frame.size.width/2-80,imggeter.frame.size.height+imggeter.frame.origin.y+10, 160, 35);
    browse.frame=CGRectMake(10,NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 160, 60);
    
    [browse setTitle:ibrwse forState:UIControlStateNormal];
    [browse setTitleColor:[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f]forState:UIControlStateNormal];
    //  browse.layer.cornerRadius=6;
    [browse addTarget:self action:@selector(chooseOption:) forControlEvents:UIControlEventTouchUpInside];
    browse.backgroundColor=[clr valueForKey:@"Yellowbtncolor"];
    [browse setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:browse];
    
    company_name=[[UITextField alloc]initWithFrame:CGRectMake(20, browse.frame.size.height+browse.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    company_name.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    company_name.textColor=[clr valueForKey:@"Scrollcolor"];
    company_name.delegate=self;
    company_name.placeholder=icn;
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    company_name.attributedPlaceholder=[[NSAttributedString alloc] initWithString:icn attributes:@{NSForegroundColorAttributeName: color}];
    
    [company_name setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    UIView *padding1  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    company_name.leftView = padding1 ;
    company_name.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:company_name];
    sworking=[[UITextField alloc]initWithFrame:CGRectMake(20, company_name.frame.size.height+company_name.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    sworking.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    sworking.textColor=[clr valueForKey:@"Scrollcolor"];
    sworking.placeholder=iaw;
    
    sworking.attributedPlaceholder=[[NSAttributedString alloc] initWithString:iaw attributes:@{NSForegroundColorAttributeName: color}];
    
    UIView *padding11  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    sworking.leftView = padding11 ;
    sworking.leftViewMode = UITextFieldViewModeAlways;
    sworking.delegate=self;
    [sworking setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:sworking];
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    sworking.userInteractionEnabled = YES;
    [sworking addGestureRecognizer:sworkingreg];
    
    
    presented_by=[[UITextField alloc]initWithFrame:CGRectMake(20, sworking.frame.size.height+sworking.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    presented_by.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    presented_by.placeholder=ipb;
    presented_by.attributedPlaceholder=[[NSAttributedString alloc] initWithString:ipb attributes:@{NSForegroundColorAttributeName: color}];
    
    presented_by.textColor=[clr valueForKey:@"Scrollcolor"];
    presented_by.delegate=self;
    [presented_by setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    UIView *padding12  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    presented_by.leftView = padding12 ;
    presented_by.leftViewMode = UITextFieldViewModeAlways;
    [scrollbar addSubview:presented_by];
    
    
    country=[[UILabel alloc]initWithFrame:CGRectMake(20, presented_by.frame.size.height+presented_by.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    country.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    country.text=[NSString stringWithFormat:@"  %@",ic];
    country.textColor=[clr valueForKey:@"Scrollcolor"];
    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  country.layer.cornerRadius=6;
    country.clipsToBounds=YES;
    [scrollbar addSubview:country];
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    sate=[[UILabel alloc]initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15 ,scrollbar.frame.size.width-40, 40)];
    sate.backgroundColor=[UIColor whiteColor];
    sate.text=[NSString stringWithFormat:@"  %@",is];
    sate.textColor=[clr valueForKey:@"Scrollcolor"];
    //  sate.layer.cornerRadius=6;
    sate.clipsToBounds=YES;
    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:sate];
    
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    
    city=[[UILabel alloc]initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    city.backgroundColor=[UIColor whiteColor];
    city.text=[NSString stringWithFormat:@"  %@",icty];
    city.textColor=[clr valueForKey:@"Scrollcolor"];
    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    // city.layer.cornerRadius=6;
    city.clipsToBounds=YES;
    [scrollbar addSubview:city];
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    //////////////////
    
    UIView *AddressView=[[UIView alloc]initWithFrame:CGRectMake(20, city.frame.size.height+city.frame.origin.y+15, scrollbar.frame.size.width-40, 55)];
    AddressView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    [scrollbar addSubview:AddressView];
    
    //    AddressLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 3, 120, 20)];
    //    AddressLabel.text=@"  Address";
    //    [AddressLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //    AddressLabel.textColor=[clr valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    //    AddressLabel.textAlignment=NSTextAlignmentLeft;
    //    AddressLabel.backgroundColor=[UIColor clearColor];
    //    [AddressView addSubview:AddressLabel];
    
    add=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, scrollbar.frame.size.width-10, 55)];
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[clr valueForKey:@"Scrollcolor"];
    add.delegate=self;
    add.tag=1000;
    add.placeholder = @"Address";
    
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //add.placeholder =@"Description";
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    [AddressView addSubview:add];
    
    
    UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(20, AddressView.frame.size.height+AddressView.frame.origin.y+15,  scrollbar.frame.size.width-40,100)];
    descriptionView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    [scrollbar addSubview:descriptionView];
    
    //    descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 3,  120,20)];
    //    descriptionLabel.text=@"  Description";
    //    [descriptionLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //    descriptionLabel.textColor=[clr valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    //    descriptionLabel.textAlignment=NSTextAlignmentLeft;
    //    descriptionLabel.backgroundColor=[UIColor clearColor];
    //    descriptionLabel.textColor=[clr valueForKey:@"Scrollcolor"];
    //    [descriptionView addSubview:descriptionLabel];
    
    desc1=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,  scrollbar.frame.size.width-10,100)];
    desc1.backgroundColor=[UIColor clearColor];
    [desc1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    desc1.textColor=[clr valueForKey:@"Scrollcolor"];
    desc1.delegate=self;
    desc1.tag=2;
    desc1.placeholder = @"Description";
    desc1.tag=1001;
    [desc1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    desc1.placeholder =@"Description";
    desc1.backgroundColor=[UIColor clearColor];
    desc1.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    [descriptionView addSubview:desc1];
    
    ///////////////////
    
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35,descriptionView.frame.size.height+descriptionView.frame.origin.y+10 , scrollbar.frame.size.width/2 -40, 35)];
    [save setTitle:@"Submit" forState: UIControlStateNormal];
    save.backgroundColor=[clr valueForKey:@"Yellowbtncolor"];
    [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    [save addTarget:self action:@selector(saveAward:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // save.layer.cornerRadius=5;
    save.tag=1;
    
    [scrollbar addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+5,descriptionView.frame.size.height+descriptionView.frame.origin.y+10 , scrollbar.frame.size.width/2 -40, 35)];
    [cancel setTitle:@"Close" forState: UIControlStateNormal];
    cancel.backgroundColor=[clr valueForKey:@"Yellowbtncolor"];
    [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //cancel.layer.cornerRadius=5;
    [scrollbar addSubview:cancel];
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, cancel.frame.size.height+cancel.frame.origin.y+20);
    
}

-(void) EditAward:(UIViewController *)Vc:(NSArray *) awdar:(int) idd
{
    
    
    [self MainView:Vc:@"Award Details"];
    NSString *ibrwse=@"Add Photo",*icn=@"Company Name",*iaw=@"Award when",*ipb=@"Presented By",*ic=@"Select Country",*is=@"Select State",*icty=@"Select City",*iadl=@"Address",*idscl=@"Award Description",*img ;
    
    
    
    
    for(int x=0;x<[awdar count];x++)
    {
        int pre=[[[awdar objectAtIndex:x] valueForKey:@"id"] intValue];
        if(idd==pre)
        {
            
            iadl=   [[awdar objectAtIndex:x] valueForKey:@"address"];
            idscl=   [[awdar objectAtIndex:x] valueForKey:@"award_desc"];
            iaw=[[awdar objectAtIndex:x] valueForKey:@"award_when"];
            icty=[[awdar objectAtIndex:x] valueForKey:@"city"];
            ic= [[awdar objectAtIndex:x] valueForKey:@"country"];
            img=[[awdar objectAtIndex:x] valueForKey:@"image"];
            icn=[[awdar objectAtIndex:x] valueForKey:@"name_of_comp"];
            is=[[awdar objectAtIndex:x] valueForKey:@"state"];
            ipb=[[awdar objectAtIndex:x] valueForKey:@"presented_by"];
            empID=idd;
            break;
        }
    }
    
    
    
    
    
    imggeter = [[UIImageView alloc] initWithFrame:CGRectMake( scrollbar.frame.size.width/2+20 , NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 60, 60)];
    imggeter.backgroundColor=[UIColor clearColor];
    [imggeter setImage:[UIImage imageNamed:@"username.png"]];
    [scrollbar addSubview:imggeter];
    
    
    mang=[[ManageArray alloc] init];
    
    
    
    NSString * url=[mang concatUrl:img];
    
    NSLog(@"imag vw %@",url);
    [imggeter sd_setImageWithURL:[NSURL URLWithString:url]];
    //    if(url.length<12)
    //    {
    //        imggeter.image = [UIImage imageNamed:@"username.png"];
    //    }
    //    else
    //    {
    //        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    //
    //        if (imageData.length<=0)
    //            imggeter.image = [UIImage imageNamed:@"username.png"];
    //        else
    //            imggeter.image = [UIImage imageWithData:imageData];
    //    }
    imggeter.userInteractionEnabled = YES;
    
    NSMutableDictionary *dtl=[SavePrefrences sharedInstance].colorDictionry;
    
    UIButton *browse=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    browse.frame=CGRectMake(20,NameLabel.frame.size.height+NameLabel.frame.origin.y-80, 160, 60);
    [browse setTitle:ibrwse forState:UIControlStateNormal];
    [browse setTitleColor:[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // browse.layer.cornerRadius=6;
    [browse addTarget:self action:@selector(chooseOption:) forControlEvents:UIControlEventTouchUpInside];
    browse.backgroundColor=[dtl valueForKey:@"Yellowbtncolor"];
    [browse setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:browse];
    
    company_name=[[UITextField alloc]initWithFrame:CGRectMake(20, browse.frame.size.height+browse.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    company_name.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    company_name.text=icn;
    company_name.placeholder = @"Company Name";
    company_name.textColor=[dtl valueForKey:@"Scrollcolor"];
    company_name.delegate=self;
    [company_name setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    UIView *padding1   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    company_name.leftView = padding1  ;
    company_name.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:company_name];
    
    sworking=[[UITextField alloc]initWithFrame:CGRectMake(20, company_name.frame.size.height+company_name.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    sworking.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    sworking.text=iaw;
    sworking.placeholder = @"Award When";
    sworking.textColor=[dtl valueForKey:@"Scrollcolor"];
    UIView *padding11   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    sworking.leftView = padding11  ;
    sworking.leftViewMode = UITextFieldViewModeAlways;
    
    sworking.delegate=self;
    //  sworking.layer.cornerRadius=6;
    [sworking setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:sworking];
    
    UITapGestureRecognizer *sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    sworking.userInteractionEnabled = YES;
    [sworking addGestureRecognizer:sworkingreg];
    
    
    
    presented_by=[[UITextField alloc]initWithFrame:CGRectMake(20, sworking.frame.size.height+sworking.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    presented_by.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    presented_by.text=ipb;
    presented_by.placeholder = @"Presented by";
    presented_by.delegate=self;
    presented_by.textColor=[dtl valueForKey:@"Scrollcolor"];
    UIView *padding12   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    presented_by.leftView = padding12  ;
    presented_by.leftViewMode = UITextFieldViewModeAlways;
    
    [presented_by setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  presented_by.layer.cornerRadius=6;
    [scrollbar addSubview:presented_by];
    
    
    //    country=[[UILabel alloc]initWithFrame:CGRectMake(20, presented_by.frame.size.height+presented_by.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    //    country.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    //    country.text=[NSString stringWithFormat:@"%@",ic];
    //    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //   // country.layer.cornerRadius=6;
    //    country.textAlignment = NSTextAlignmentLeft;
    //    country.textColor=[dtl valueForKey:@"Scrollcolor"];
    //    country.clipsToBounds=YES;
    //    [scrollbar addSubview:country];
    //
    //    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    //    [countryreg setNumberOfTouchesRequired:1];
    //    [countryreg setDelegate:self];
    //    country.userInteractionEnabled = YES;
    //    [country addGestureRecognizer:countryreg];
    //
    //    sate=[[UILabel alloc]initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15 ,scrollbar.frame.size.width-40, 40)];
    //    sate.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    //   // sate.layer.borderWidth=2;
    //   // sate.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    //    sate.textAlignment = NSTextAlignmentLeft;
    //    sate.text=[NSString stringWithFormat:@"%@",is];
    //    sate.textColor=[dtl valueForKey:@"Scrollcolor"];
    //    sate.clipsToBounds=YES;
    //  //  sate.layer.cornerRadius=6;
    //    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //    [scrollbar addSubview:sate];
    //
    //
    //    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    //    [satereg setNumberOfTouchesRequired:1];
    //    [satereg setDelegate:self];
    //    sate.userInteractionEnabled = YES;
    //    [sate addGestureRecognizer:satereg];
    //
    //
    //    city=[[UILabel alloc]initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    //    city.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    //    city.textAlignment = NSTextAlignmentLeft;
    //  //  city.layer.borderWidth=2;
    //  //  city.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    //    city.text=[NSString stringWithFormat:@"%@",icty];
    //    city.textColor=[dtl valueForKey:@"Scrollcolor"];
    //    city.clipsToBounds=YES;
    //    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  //  city.layer.cornerRadius=6;
    //    [scrollbar addSubview:city];
    //
    //    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    //    [cityreg setNumberOfTouchesRequired:1];
    //    [cityreg setDelegate:self];
    //    city.userInteractionEnabled = YES;
    //    [city addGestureRecognizer:cityreg];
    country=[[UILabel alloc]initWithFrame:CGRectMake(20, presented_by.frame.size.height+presented_by.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    country.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    country.text=[NSString stringWithFormat:@"%@",ic];
    country.textColor=[dtl valueForKey:@"Scrollcolor"];
    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  country.layer.cornerRadius=6;
    country.clipsToBounds=YES;
    [scrollbar addSubview:country];
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    sate=[[UILabel alloc]initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15 ,scrollbar.frame.size.width-40, 40)];
    sate.backgroundColor=[UIColor whiteColor];
    sate.text=[NSString stringWithFormat:@"%@",is];
    sate.textColor=[dtl valueForKey:@"Scrollcolor"];
    //  sate.layer.cornerRadius=6;
    sate.clipsToBounds=YES;
    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:sate];
    
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    
    city=[[UILabel alloc]initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    city.backgroundColor=[UIColor whiteColor];
    city.text=[NSString stringWithFormat:@"%@",icty];
    city.textColor=[dtl valueForKey:@"Scrollcolor"];
    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    // city.layer.cornerRadius=6;
    city.clipsToBounds=YES;
    [scrollbar addSubview:city];
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    //////////////////////
    
    UIView *AddressView=[[UIView alloc]initWithFrame:CGRectMake(20, city.frame.size.height+city.frame.origin.y+15, scrollbar.frame.size.width-40, 55)];
    AddressView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    [scrollbar addSubview:AddressView];
    
    /* AddressLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 3, 120, 20)];
     AddressLabel.text=@"Address";
     [AddressLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
     AddressLabel.textColor=[dtl valueForKey:@"Scrollcolor"];//[UIColor blackColor];
     AddressLabel.textAlignment=NSTextAlignmentLeft;
     AddressLabel.backgroundColor=[UIColor clearColor];
     [AddressView addSubview:AddressLabel];*/
    
    add=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, scrollbar.frame.size.width-10, 55)];
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[dtl valueForKey:@"Scrollcolor"];
    add.delegate=self;
    add.text=iadl;
    add.placeholder = @"Address";
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [add setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //add.placeholder =@"Description";
    add.backgroundColor=[UIColor clearColor];
    add.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    [AddressView addSubview:add];
    
    UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(20, AddressView.frame.size.height+AddressView.frame.origin.y+15,  scrollbar.frame.size.width-40,100)];
    descriptionView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    
    [scrollbar addSubview:descriptionView];
    
    /* descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 3,  120,20)];
     descriptionLabel.text=@"Description";
     [descriptionLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
     descriptionLabel.textColor=[dtl valueForKey:@"Scrollcolor"];//[UIColor blackColor];
     descriptionLabel.textAlignment=NSTextAlignmentLeft;
     descriptionLabel.backgroundColor=[UIColor clearColor];
     [descriptionView addSubview:descriptionLabel];*/
    
    desc1=[[UITextView alloc]initWithFrame:CGRectMake(0, 0,  scrollbar.frame.size.width-10,100)];
    desc1.placeholder = @"Award Description";
    desc1.backgroundColor=[UIColor clearColor];
    desc1.textColor=[dtl valueForKey:@"Scrollcolor"];
    desc1.tag=4;
    desc1.text=idscl;
    [desc1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    desc1.delegate=self;
    [desc1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    desc1.placeholder =@"Description";
    desc1.backgroundColor=[UIColor clearColor];
    desc1.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    [descriptionView addSubview:desc1];
    
    //////////////////////
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(35,descriptionView.frame.size.height+descriptionView.frame.origin.y+10 , scrollbar.frame.size.width/2 -40, 35)];
    [save setTitle:@"Update" forState: UIControlStateNormal];
    save.backgroundColor=[dtl valueForKey:@"Yellowbtncolor"];
    [save addTarget:self action:@selector(saveAward:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // save.layer.cornerRadius=5;
    save.tag=2;
    
    [scrollbar addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+5,descriptionView.frame.size.height+descriptionView.frame.origin.y+10 , scrollbar.frame.size.width/2 -40, 35)];
    [cancel setTitle:@"Close" forState: UIControlStateNormal];
    cancel.backgroundColor=[dtl valueForKey:@"Yellowbtncolor"];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // cancel.layer.cornerRadius=5;
    [scrollbar addSubview:cancel];
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, cancel.frame.origin.y+cancel.frame.size.height+20);
    
    
}


//-(void)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    textField.userInteractionEnabled=YES;
//    if(textField==email||textField==address ||  textField==ph_num||textField==mob_num||textField==hobbies)
//    {
//        [scrollbar setContentOffset:CGPointMake(0, 250) animated:YES];
//    }
//
//
//}
////
//-(void)textFieldShouldEndEditing:(UITextField *)textField
//{
//    if(textField==email||textField==address||textField==ph_num||textField==mob_num||textField==hobbies)
//    {
//     [scrollbar setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
//
//}

#pragma mark editProfile
-(void)editMainProfile:(UIViewController *)Vc:(NSArray *) profAr1:(NSArray *)indus
{
    
    vc1=Vc;
    [self MainView: Vc:@"Edit Profile"];
    NSArray *profAr= [profAr1 objectAtIndex:0];
    NSMutableDictionary *pp=[SavePrefrences sharedInstance].colorDictionry;
    
    fname=[[UITextField alloc]initWithFrame:CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y-80,scrollbar.frame.size.width-40, 40)];
    fname.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    fname.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    if(![[profAr valueForKey:@"fname"] isEqual:[NSNull null]])
    {
        fname.text=[profAr valueForKey:@"fname"];
    }
    [fname setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    fname.textColor=[pp valueForKey:@"Scrollcolor"];
    fname.clipsToBounds=YES;
    fname.delegate=self;
    
    UIView *padding1    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    fname.leftView = padding1   ;
    fname.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:fname];
    
    mname=[[UITextField alloc]initWithFrame:CGRectMake(20, fname.frame.size.height+fname.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    mname.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    mname.placeholder=@"Middle Name";
    mname.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Middle Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    if(![[profAr valueForKey:@"middle_name"] isEqual:[NSNull null]])
    {
        mname.text=[profAr valueForKey:@"middle_name"];
    }
    [mname setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    mname.delegate=self;
    mname.clipsToBounds=YES;
    mname.textColor=[pp valueForKey:@"Scrollcolor"];
    UIView *padding11    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    mname.leftView = padding11   ;
    mname.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:mname];
    
    lname=[[UITextField alloc]initWithFrame:CGRectMake(20, mname.frame.size.height+mname.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    lname.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    lname.textColor=[pp valueForKey:@"Scrollcolor"];
    lname.placeholder=@"Last Name";
    lname.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    if(![[profAr valueForKey:@"lname"] isEqual:[NSNull null]])
    {
        lname.text=[profAr valueForKey:@"lname"];
    }
    [lname setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    lname.delegate=self;
    UIView *padding12    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    lname.leftView = padding12   ;
    lname.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:lname];
    float div=scrollbar.frame.size.width/3;
    NSLog(@"value of width is %f",div);
    
    
    email=[[UITextField alloc]initWithFrame:CGRectMake(20, lname.frame.size.height+lname.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    email.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    email.textColor=[pp valueForKey:@"Scrollcolor"];
    email.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    if([profAr valueForKey:@"email"])
    {
        if(![[profAr valueForKey:@"email"] isEqual:[NSNull null]])
        {
            email.text=[profAr valueForKey:@"email"];
        }
    }
    [email setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    UIView *padding13    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    email.leftView = padding13   ;
    email.leftViewMode = UITextFieldViewModeAlways;
    email.delegate=self;
    [scrollbar addSubview:email];
    
    //////Gender view///////////
    UIView *AddressView=[[UIView alloc]initWithFrame:CGRectMake(20, email.frame.size.height+email.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    AddressView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    [scrollbar addSubview:AddressView];
    
    gender1=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 80 , 30)];
    gender1.text=@"  Gender:";
    gender1.textColor=[pp valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    gender1.backgroundColor=[UIColor clearColor];
    [gender1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [AddressView addSubview:gender1];
    
    UIButton *imgarrow1 =[[UIButton alloc]initWithFrame:CGRectMake(gender1.frame.size.width+gender1.frame.origin.x, 12, 16, 16)];
    imgarrow1.layer.cornerRadius=7.5;
    imgarrow1.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [imgarrow1 addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
    [imgarrow1 setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    imgarrow1.tag=0;
    [AddressView addSubview:imgarrow1];
    
    UILabel *male=[[UILabel alloc]initWithFrame:CGRectMake(imgarrow1.frame.size.width+imgarrow1.frame.origin.x+2, 5, 80, 30)];
    male.text=@"  Male";
    male.textColor=[pp valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    male.backgroundColor=[UIColor clearColor];
    [male setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [AddressView addSubview:male];
    
    UIButton *imgarrow2 =[[UIButton alloc]initWithFrame:CGRectMake(male.frame.size.width+male.frame.origin.x, 12, 16, 16)];
    imgarrow2.layer.cornerRadius=7.5;
    imgarrow2.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [imgarrow2 addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
    [imgarrow2 setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    imgarrow2.tag=1;
    [AddressView addSubview:imgarrow2];
    if([profAr valueForKey:@"gender"])
    {
        if([profAr valueForKey:@"gender"]==nil||[profAr valueForKey:@"gender"]==NULL||[[profAr valueForKey:@"gender"] isEqual:[NSNull null]]||[profAr valueForKey:@"gender"] == (id)[NSNull null])
        {
            sender1=imgarrow1;
            [imgarrow1 setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        
        else  if([[profAr valueForKey:@"gender"]intValue]==0)
        {
            sender1=imgarrow1;
            [imgarrow1 setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        else
        {
            sender1=imgarrow2;
            [imgarrow2 setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
    }
    UILabel *female=[[UILabel alloc]initWithFrame:CGRectMake(imgarrow2.frame.size.width+imgarrow2.frame.origin.x+10,5, 80, 30)];
    female.text=@"Female";
    female.textColor=[pp valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    female.backgroundColor=[UIColor clearColor];
    [female setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [AddressView addSubview:female];
    
    
    sworking=[[UITextField alloc]initWithFrame:CGRectMake(20, AddressView.frame.size.height+AddressView.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    sworking.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    sworking.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Date Of Birth" attributes:@{NSForegroundColorAttributeName: color}];
    
    if([profAr valueForKey:@"dob"])
    {
        if(![[profAr valueForKey:@"dob"] isEqual:[NSNull null]])
        {
            
            NSString *newString1 =[profAr valueForKey:@"dob"];
            newString1 = [newString1 stringByReplacingOccurrencesOfString:@"undefined-undefined-" withString:@""];
            
            sworking.text=newString1;
        }
    }
    UIView *padding14    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    sworking.leftView = padding14   ;
    sworking.leftViewMode = UITextFieldViewModeAlways;
    
    [sworking setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    sworking.textColor=[pp valueForKey:@"Scrollcolor"];
    [scrollbar addSubview:sworking];
    
    UITapGestureRecognizer * sworkingreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [sworkingreg setNumberOfTouchesRequired:1];
    [sworkingreg setDelegate:self];
    sworking.userInteractionEnabled = YES;
    [ sworking addGestureRecognizer: sworkingreg];
    
    //////relation view///////////
    UIView *relationView=[[UIView alloc]initWithFrame:CGRectMake(20, sworking.frame.size.height+sworking.frame.origin.y+15, scrollbar.frame.size.width-40, 70)];
    relationView.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//
    [scrollbar addSubview:relationView];
    
    UILabel *relation=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 80, 30) ];
    relation.text=@"  Relation:";
    relation.textColor=[pp valueForKey:@"Scrollcolor"];
    relation.backgroundColor=[UIColor clearColor];
    [relation setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [relationView addSubview:relation];
    
    UIButton *imgarrow4 =[[UIButton alloc]initWithFrame:CGRectMake(relation.frame.size.width+relation.frame.origin.x, 12, 16, 16)];
    imgarrow4.layer.cornerRadius=7.5;
    imgarrow4.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [imgarrow4 addTarget:self action:@selector(toggleButton1:) forControlEvents: UIControlEventTouchUpInside];
    [imgarrow4 setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    imgarrow4.tag=0;
    [relationView addSubview:imgarrow4];
    
    UILabel *male2=[[UILabel alloc]initWithFrame:CGRectMake(imgarrow4.frame.size.width+imgarrow4.frame.origin.x+5, 5,80, 30)];
    male2.text=@"  Single";
    male2.textColor=[pp valueForKey:@"Scrollcolor"];
    male2.backgroundColor=[UIColor clearColor];
    [male2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [relationView addSubview:male2];
    
    UIButton *imgarrow5 =[[UIButton alloc]initWithFrame:CGRectMake(male2.frame.size.width+male2.frame.origin.x, 12, 16, 16)];
    imgarrow5.layer.cornerRadius=7.5;
    imgarrow5.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [imgarrow5 addTarget:self action:@selector(toggleButton1:) forControlEvents: UIControlEventTouchUpInside];
    [imgarrow5 setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    imgarrow5.tag=1;
    [relationView addSubview:imgarrow5];
    
    UILabel *female2=[[UILabel alloc]initWithFrame:CGRectMake(imgarrow5.frame.size.width+imgarrow5.frame.origin.x+10,5, 80, 30)];
    female2.text=@"Married";
    female2.textColor=[pp valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    female2.backgroundColor=[UIColor clearColor];
    [female2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [relationView addSubview:female2];
    
    
    //pach by kalpesh
    
    UIButton *imgarrow6 =[[UIButton alloc]initWithFrame:CGRectMake(relation.frame.size.width+relation.frame.origin.x, 40, 16, 16)];
    imgarrow6.layer.cornerRadius=7.5;
    imgarrow6.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [imgarrow6 addTarget:self action:@selector(toggleButton1:) forControlEvents: UIControlEventTouchUpInside];
    [imgarrow6 setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    imgarrow6.tag=2;
    [relationView addSubview:imgarrow6];
    
    UILabel *Divorcedl=[[UILabel alloc]initWithFrame:CGRectMake(imgarrow6.frame.size.width+imgarrow6.frame.origin.x+10,32, 80, 30)];
    Divorcedl.text=@"Divorced";
    Divorcedl.textColor=[pp valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    Divorcedl.backgroundColor=[UIColor clearColor];
    [Divorcedl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [relationView addSubview:Divorcedl];
    
    UIButton *imgarrow7 =[[UIButton alloc]initWithFrame:CGRectMake((Divorcedl.frame.size.width+Divorcedl.frame.origin.x) - 6, 40, 16, 16)];
    imgarrow7.layer.cornerRadius=7.5;
    imgarrow7.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [imgarrow7 addTarget:self action:@selector(toggleButton1:) forControlEvents: UIControlEventTouchUpInside];
    [imgarrow7 setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    imgarrow7.tag=3;
    [relationView addSubview:imgarrow7];
    
    UILabel *Widowl=[[UILabel alloc]initWithFrame:CGRectMake(imgarrow7.frame.size.width+imgarrow7.frame.origin.x+10,32, 80, 30)];
    Widowl.text=@"Widow";
    Widowl.textColor=[pp valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    Widowl.backgroundColor=[UIColor clearColor];
    [Widowl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [relationView addSubview:Widowl];

    
    //End pach by kalpesh
    
    
    if([profAr valueForKey:@"relationship"])
    {
        
        if([profAr valueForKey:@"relationship"]==nil||[profAr valueForKey:@"relationship"]==NULL||[[profAr valueForKey:@"relationship"] isEqual:[NSNull null]]||[profAr valueForKey:@"relationship"] == (id)[NSNull null])
        {
            sender2=imgarrow4 ;
            [imgarrow4 setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        
        else if([[profAr valueForKey:@"relationship"]intValue]==0)
        {
            sender2=imgarrow4 ;
            [imgarrow4 setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        else if([[profAr valueForKey:@"relationship"]intValue]==1)
        {
            sender2=imgarrow5 ;
            [imgarrow5 setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        } else if([[profAr valueForKey:@"relationship"]intValue]==2)
        {
            sender2=imgarrow6 ;
            [imgarrow6 setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        else
        {
            sender2=imgarrow7;
            [imgarrow7 setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
    }
    
    
    country=[[UILabel alloc]initWithFrame:CGRectMake(20, relationView.frame.size.height+relationView.frame.origin.y+15, scrollbar.frame.size.width-40, 40)];
    country.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    if(![[profAr valueForKey:@"country"] isEqual:[NSNull null]])
    {
        country.text=[NSString stringWithFormat:@"  %@",[profAr valueForKey:@"country"]];
    }
    else{
        country.text=@"  Select Country";
    }
    country.textColor=[pp valueForKey:@"Scrollcolor"];
    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //  country.layer.cornerRadius=6;
    country.clipsToBounds=YES;
    [scrollbar addSubview:country];
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    sate=[[UILabel alloc]initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15 ,scrollbar.frame.size.width-40, 40)];
    sate.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    sate.textColor=[pp valueForKey:@"Scrollcolor"];
    if(![[profAr valueForKey:@"state"] isEqual:[NSNull null]])
    {
        sate.text=[NSString stringWithFormat:@"  %@",[profAr valueForKey:@"state"]];
    }
    else
    {
        sate.text=@"  Select state";
    }
    //   sate.layer.cornerRadius=6;
    sate.clipsToBounds=YES;
    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:sate];
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    city=[[UILabel alloc]initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    city.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    city.textColor=[pp valueForKey:@"Scrollcolor"];
    if(![[profAr valueForKey:@"city"] isEqual:[NSNull null]])
    {
        city.text=[NSString stringWithFormat:@"  %@",[profAr valueForKey:@"city"]];
    }
    else
    {
        city.text=@"  Select city";
    }
    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //   city.layer.cornerRadius=6;
    city.clipsToBounds=YES;
    [scrollbar addSubview:city];
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    address=[[UITextField alloc]initWithFrame:CGRectMake(20, city.frame.size.height+city.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    address.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    address.textColor=[pp valueForKey:@"Scrollcolor"];
    address.placeholder=@"Address";
    address.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Address" attributes:@{NSForegroundColorAttributeName: color}];
    if(![[profAr valueForKey:@"address"] isEqual:[NSNull null]])
    {
        address.text=[profAr valueForKey:@"address"];
    }
    
    address.delegate=self;
    [address setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    UIView *padding15    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    address.leftView = padding15   ;
    address.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:address];
    
    ph_num=[[UITextField alloc]initWithFrame:CGRectMake(20, address.frame.size.height+address.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    ph_num.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    ph_num.textColor=[pp valueForKey:@"Scrollcolor"];
    ph_num.placeholder=@"Phone Number";
    ph_num.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Phone Number" attributes:@{NSForegroundColorAttributeName: color}];
    
    UIView *padding16    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    ph_num.leftView = padding16   ;
    ph_num.leftViewMode = UITextFieldViewModeAlways;
    
    ph_num.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    if(![[profAr valueForKey:@"phone_no"] isEqual:[NSNull null]])
    {
        ph_num.text=[NSString stringWithFormat:@"%@",[profAr valueForKey:@"phone_no"]];
    }
    [ph_num setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    //   ph_num.layer.cornerRadius=6;
    ph_num.delegate=self;
    [scrollbar addSubview:ph_num];
    
    mob_num=[[UITextField alloc]initWithFrame:CGRectMake(20, ph_num.frame.size.height+ph_num.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    mob_num.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    mob_num.textColor=[pp valueForKey:@"Scrollcolor"];
    mob_num.placeholder=@"Mobile Number";
    mob_num.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{NSForegroundColorAttributeName: color}];
    
    mob_num.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    if(![[profAr valueForKey:@"mobile_no"] isEqual:[NSNull null]])
    {
        mob_num.text=[NSString stringWithFormat:@"%@",[profAr valueForKey:@"mobile_no"]];
    }
    [mob_num setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    mob_num.delegate=self;
    UIView *padding17    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    mob_num.leftView = padding17   ;
    mob_num.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:mob_num];
    
    
    hobbies=[[UITextField alloc]initWithFrame:CGRectMake(20, mob_num.frame.size.height+mob_num.frame.origin.y+15, scrollbar.frame.size.width-40, 40) ];
    hobbies.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    hobbies.textColor=[pp valueForKey:@"Scrollcolor"];
    hobbies.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Hobbies" attributes:@{NSForegroundColorAttributeName: color}];
    
    if(![[profAr valueForKey:@"hobbies"] isEqual:[NSNull null]])
    {
        hobbies.text=[profAr valueForKey:@"hobbies"];
    }
    [hobbies setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    UIView *padding18    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    hobbies.leftView = padding18   ;
    hobbies.leftViewMode = UITextFieldViewModeAlways;
    hobbies.delegate=self;
    [scrollbar addSubview:hobbies];
    
    
    
    info=[[UILabel alloc]initWithFrame:CGRectMake(20, hobbies.frame.size.height+hobbies.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    info.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    info.textColor=[pp valueForKey:@"Scrollcolor"];
    
    
    //profilear compare indus
    
    int isbreak=0;
    if([profAr containsObject:@"i_id"])
    {
        for(int x=0;x<[indus count];x++)
        {
            
            
            int induId=[[[indus objectAtIndex:x] valueForKey:@"i_id"] intValue];
            int profid=[[profAr valueForKey:@"i_id"] intValue];
            if(induId ==profid)
            {
                info.text=[NSString stringWithFormat:@"  %@",[[indus objectAtIndex:x]valueForKey:@"industry_name"]];
                indid=[NSString stringWithFormat:@"%d",induId];
                isbreak=1;
                break;
            }
            
            else{
                info.text=@"  Select Industry";
            }
            if(isbreak==1)
            {
                break;
            }
            
        }
    }
    else{
        info.text=@"  Select Industry";
    }
    [info setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    // info.layer.cornerRadius=6;
    info.clipsToBounds=YES;
    [scrollbar addSubview:info];
    
    
    UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInduct)];
    [ind setNumberOfTouchesRequired:1];
    [ind setDelegate:self];
    info.userInteractionEnabled = YES;
    [info addGestureRecognizer:ind];
    
    
    
    fb_id=[[UITextField alloc]initWithFrame:CGRectMake(20, info.frame.size.height+info.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    fb_id.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    fb_id.textColor=[pp valueForKey:@"Scrollcolor"];
    fb_id.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Facebook ID" attributes:@{NSForegroundColorAttributeName: color}];
    
    if([profAr valueForKey:@"fcbkid"])
    {
    if(![[profAr valueForKey:@"fcbkid"] isEqual:[NSNull null]])
    {
        fb_id.text=[NSString stringWithFormat:@"%@",[profAr valueForKey:@"fcbkid"]];
    }
    }
    
    [fb_id setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    UIView *padding19   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    fb_id.leftView = padding19 ;
    fb_id.leftViewMode = UITextFieldViewModeAlways;
    fb_id.delegate=self;
    // fb_id.layer.cornerRadius=6;
    
    [scrollbar addSubview:fb_id];
    
    twt_id=[[UITextField alloc]initWithFrame:CGRectMake(20, fb_id.frame.size.height+fb_id.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    twt_id.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    twt_id.textColor=[pp valueForKey:@"Scrollcolor"];
    twt_id.placeholder=@"Twitter ID";
    twt_id.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Twitter ID" attributes:@{NSForegroundColorAttributeName: color}];
    if(![[profAr valueForKey:@"twitter_id"] isEqual:[NSNull null]])
    {
        twt_id.text=[NSString stringWithFormat:@"%@",[profAr valueForKey:@"twitter_id"]];
    }
    [twt_id setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    twt_id.delegate=self;
    UIView *padding20   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    twt_id.leftView = padding20 ;
    twt_id.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:twt_id];
    
    ln_id=[[UITextField alloc]initWithFrame:CGRectMake(20, twt_id.frame.size.height+twt_id.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    ln_id.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    ln_id.textColor=[pp valueForKey:@"Scrollcolor"];
    ln_id.placeholder=@"LinkedIn ID";
    ln_id.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"LinkedIn ID" attributes:@{NSForegroundColorAttributeName: color}];
    if(![[profAr valueForKey:@"linkedin_id"] isEqual:[NSNull null]])
    {
        ln_id.text=[NSString stringWithFormat:@"%@",[profAr valueForKey:@"linkedin_id"]];
    }
    [ln_id setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    ln_id.delegate=self;
    UIView *padding21   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    ln_id.leftView = padding21 ;
    ln_id.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:ln_id];
    
    go_id=[[UITextField alloc]initWithFrame:CGRectMake(20, ln_id.frame.size.height+ln_id.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    go_id.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    go_id.textColor=[pp valueForKey:@"Scrollcolor"];
    go_id.placeholder=@"Google ID";
    go_id.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Google ID" attributes:@{NSForegroundColorAttributeName: color}];
    
    UIView *padding22   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    go_id.leftView = padding22 ;
    go_id.leftViewMode = UITextFieldViewModeAlways;
    
    if(![[profAr valueForKey:@"google_id"] isEqual:[NSNull null]])
    {
        go_id.text=[NSString stringWithFormat:@"%@",[profAr valueForKey:@"google_id"]];
    }
    [go_id setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    go_id.delegate=self;
    [scrollbar addSubview:go_id];
    
    vim_id=[[UITextField alloc]initWithFrame:CGRectMake(20, go_id.frame.size.height+go_id.frame.origin.y+15,scrollbar.frame.size.width-40, 40)];
    vim_id.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    vim_id.textColor=[pp valueForKey:@"Scrollcolor"];
    vim_id.placeholder=@"Vimeo Id";
    vim_id.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Vimeo ID" attributes:@{NSForegroundColorAttributeName: color}];
    
    if(![[profAr valueForKey:@"vimeo_id"] isEqual:[NSNull null]])
    {
        vim_id.text=[NSString stringWithFormat:@"%@",[profAr valueForKey:@"vimeo_id"]];
    }
    [vim_id setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    vim_id.delegate=self;
    UIView *padding23   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    vim_id.leftView = padding23 ;
    vim_id.leftViewMode = UITextFieldViewModeAlways;
    
    [scrollbar addSubview:vim_id];
    //remain
    /* UILabel *desclbl=[[UILabel alloc] initWithFrame:CGRectMake(10, vim_id.frame.size.height+vim_id.frame.origin.y+5, 200, 30)];
     desclbl.text=@"Description:";
     desclbl.textColor=[pp valueForKey:@"Scrollcolor"];//[UIColor blackColor];
     [desclbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
     [scrollbar addSubview:desclbl];*/
    
    descrpt1=[[UITextView alloc]initWithFrame:CGRectMake(20, vim_id.frame.size.height+vim_id.frame.origin.y+15, scrollbar.frame.size.width-40, 60)];
    descrpt1.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    descrpt1.placeholder = @"description";
    if ([SAFESTRING([profAr valueForKey:@"about"])isEqualToString:@""]) {
        descrpt1.text = @"description";
    }
    else{
        descrpt1.text=[NSString stringWithFormat:@"%@",[profAr valueForKey:@"about"]];
    }
    //    if(![[profAr valueForKey:@"about"] isEqual:[NSNull null]] )
    //    {
    //
    //    }
    //    else{
    //
    //    }
    descrpt1.textColor=[pp valueForKey:@"Scrollcolor"];
    [descrpt1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    descrpt1.delegate=self;
    descrpt1.tag=0;
    [descrpt1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    descrpt1.placeholder =@"Description";
    descrpt1.backgroundColor=[UIColor whiteColor];
    descrpt1.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    
    
    [scrollbar addSubview:descrpt1];
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2-120,descrpt1.frame.size.height+descrpt1.frame.origin.y+10 , 120, 40)];
    [done setTitle:@"Done" forState: UIControlStateNormal];
    done.backgroundColor=[pp valueForKey:@"Yellowbtncolor"];
    [done addTarget:self action:@selector(saveProfile:) forControlEvents:UIControlEventTouchUpInside];
    [done setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    done.tag=2;
    [scrollbar addSubview:done];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2+5,descrpt1.frame.size.height+descrpt1.frame.origin.y+10 , 120, 40)];
    [cancel setTitle:@"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[pp valueForKey:@"Yellowbtncolor"];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //   cancel.layer.cornerRadius=5;
    [scrollbar addSubview:cancel];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, cancel.frame.size.height+cancel.frame.origin.y+20);
    
}

-(IBAction)saveProfile:(id)sender
{
    av=[[AllValidationsViewController alloc]init];
    isCallBack=@"8";
    if([av checkNull:fname])
    {
        if([av checkNull:lname])
        {
            if([av checkNull:sworking])
            {
                if([av checkNull:email]&&[av NSStringIsValidEmail:email.text])
                {
                    if([av checkCombo:country]&&[av checkCombo:sate]&&[av checkCombo:city])
                    {
                        if([av checkNull:address])
                        {
                            if([av checkNull:ph_num] &&[av ValidateContactNumber:ph_num.text:15])
                            {
                                if([av checkNull:mob_num]&&[av ValidateContactNumber:mob_num.text:13])
                                {
                                    if([av checkNull:hobbies])
                                    {
                                        if([av checkNull:fb_id]&&[av NSStringIsValidEmail:fb_id.text])
                                        {
                                            if([av checkNull:twt_id]&&[av NSStringIsValidEmail:twt_id.text])
                                            {
                                                if([av checkNull:ln_id]&&[av NSStringIsValidEmail:ln_id.text])
                                                {
                                                    if([av checkNull:go_id]&&[av NSStringIsValidEmail:go_id.text])
                                                    {
                                        if([av checkCombo:info])
                                        {
                                            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
                                            [dic1 setValue:@"1" forKey:@"k"];
                                            [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
                                            [dic1 setValue:fname.text forKey:@"fn"];
                                            [dic1 setValue:mname.text forKey:@"mn"];
                                            [dic1 setValue:email.text forKey:@"em"];
                                            [dic1 setValue:lname.text forKey:@"ln"];
                                            [dic1 setValue:sworking.text forKey:@"dob"];
                                            [dic1 setValue:country.text forKey:@"cont"];
                                            [dic1 setValue:sate.text forKey:@"state"];
                                            [dic1 setValue:city.text forKey:@"city"];
                                            [dic1 setValue:hobbies.text forKey:@"hb"];
                                            [dic1 setValue:address.text forKey:@"ad"];
                                            [dic1 setValue:ph_num.text forKey:@"ph"];
                                            [dic1 setValue:mob_num.text forKey:@"mb"];
                                            [dic1 setValue:[NSString stringWithFormat:@"%@",indid]  forKey:@"ind"];
                                            [dic1 setValue:fb_id.text forKey:@"fb"];
                                            [dic1 setValue:twt_id.text forKey:@"tw"];
                                            [dic1 setValue:ln_id.text forKey:@"li"];
                                            [dic1 setValue:go_id.text forKey:@"gm"];
                                            [dic1 setValue:descrpt1.text forKey:@"ab"];
                                            [dic1 setValue:vim_id.text forKey:@"vm"];
                                            [dic1 setValue:[NSString stringWithFormat:@"%d",iscalpub] forKey:@"gn"];
                                            [dic1 setValue:[NSString stringWithFormat:@"%d",isRelation] forKey:@"rltn"];
                                            [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"SaveProfile" :@"":@"":dic1 :self];
                                            // [prMainView removeFromSuperview];
                                        }                                        }
                                }
                            }
                            
                        }
                        
                    }
                    
                }
            }
        }
    }
}
}
        }
    }
}


//============================

-(void)showpicker:(int)tid
{
    //220:229:235
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance].screenHeight/3, [SavePrefrences sharedInstance].screenWidth-40, 300)];
    datepicker.maximumDate = [NSDate date];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.hidden = NO;
    [datepicker setValue:[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f] forKey:@"textColor"];
    datepicker.backgroundColor=[UIColor colorWithRed:220/255.0f green:229/255.0f blue:235/255.0f alpha:1.0f];
    datepicker.layer.cornerRadius=60;
    datepicker.layer.masksToBounds=YES;
    datepicker.date = [NSDate date];
    datepicker.datePickerMode=UIDatePickerModeDate;
    [datePickerView addSubview:datepicker];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"];
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(datepicker.frame.size.width/2-55, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [save setTitle: @"OK" forState: UIControlStateNormal];
    save.tag=tid;
    save.backgroundColor=[UIColor grayColor];
    [save addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed:255/255 green:255/255 blue:255255 alpha:1.0f] forState:UIControlStateNormal];
    //  save.layer.cornerRadius=5;
    [datePickerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor grayColor];
    [cancel addTarget:self action:@selector(nook:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0f] forState:UIControlStateNormal];
    //   cancel.layer.cornerRadius=5;
    [datePickerView addSubview:cancel];
}



-(void) date:(id) sender
{
    UITapGestureRecognizer * tg=(UITapGestureRecognizer *)sender;
    int tid=(int)tg.view.tag;
    
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [vc1.view addSubview:datePickerView ];
    datePickerView .backgroundColor=[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:.5f];
    
    if(tid==0)
    {
        [self showpicker:tid];
    }
    else
    {
        selView   =[[UIView alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance].screenHeight/3, [SavePrefrences sharedInstance].screenWidth-40, 200)];
        selView.layer.cornerRadius=25;
        selView.backgroundColor=[UIColor colorWithRed:220/255.0f green:229/255.0f blue:235/255.0f alpha:1.0f];
        [datePickerView addSubview:selView];
        
        
        UILabel *selectdate = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, selView.frame.size.width-40, 40)];
        selectdate.text=@"  Select End Date";
        selectdate.backgroundColor=[UIColor clearColor];
        selectdate.layer.cornerRadius=25;
        selectdate.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        selectdate.textAlignment=NSTextAlignmentCenter;
        [selView addSubview:selectdate];
        
        UIButton *Present = [[UIButton alloc]initWithFrame:CGRectMake(selView.frame.size.width/2-90, selectdate.frame.size.height+selectdate.frame.origin.y+20, 180, 30)];
        [Present setTitle: @"Present" forState: UIControlStateNormal];
        Present.tag=0;
        Present.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
        [Present addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
        [Present setTitleColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        Present.layer.cornerRadius=5;
        [selView addSubview:Present];
        
        
        UIButton *newdate = [[UIButton alloc]initWithFrame:CGRectMake(selView.frame.size.width/2-90, Present.frame.size.height+Present.frame.origin.y+20, 180, 30)];
        [newdate setTitle: @" Select New Date" forState: UIControlStateNormal];
        newdate.tag=1;
        newdate.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
        [newdate addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
        [newdate setTitleColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        //   newdate.layer.cornerRadius=5;
        [selView addSubview:newdate];
        
        
        UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(selView.frame.size.width/2 -40, newdate.frame.size.height+newdate.frame.origin.y+10, 80, 35)];
        [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [close setBackgroundColor:[UIColor clearColor]];
        [close setTitle:@"Close" forState:UIControlStateNormal];
        [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [close addTarget:self action:@selector(closeit:) forControlEvents:UIControlEventTouchUpInside];
        [selView addSubview:close];
        
    }
    
}

-(IBAction)closeit:(id)sender
{
    
    [datePickerView removeFromSuperview];
    
}




-(IBAction)present:(id)sender
{
    
    UIButton *btn=sender;
    int x= (int)btn.tag;
    
    if(x==0)
    {
        [selView removeFromSuperview];
        [datePickerView removeFromSuperview];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM/dd/yyyy"];
        
        eworking.text=[df stringFromDate:[NSDate date]];
    }
    else
    {  [selView removeFromSuperview];
        [self showpicker:x];
    }
    
}

-(IBAction)ok:(id)sender
{
    UIButton *ub=(UIButton *)sender;
    int tid =ub.tag;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/yyyy"];
    
    if(tid==0)
    {
        
        sworking.text = [df stringFromDate:datepicker.date];
    }
    
    else{
        eworking.text = [NSString stringWithFormat:@"%@",
                         [df stringFromDate:datepicker.date]];
        
    }
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
    
}


-(IBAction)nook:(id)sender
{
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
}

-(void)LabelChange:(id)sender
{
}
-(IBAction)cancel:(id)sender
{
    NSLog(@"cancelllll");
    
    [prMainView removeFromSuperview];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"predddd");
    [textField resignFirstResponder];
    return YES;
}


//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//        [textView resignFirstResponder];
//    return YES;
//}


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
        [sc getCountryList:self];
    }
}

-(void)stateSel:(id)sender
{
    
    
    
    isCallBack=@"5";
    SelectCountry * sc=[[SelectCountry alloc]init];
    [sc getState:self:cid];
    
}

-(void)citySel:(id)sender
{
    
    
    isCallBack=@"6";
    SelectCountry * sc=[[SelectCountry alloc]init];
    [sc getCity:self:stid];
    
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
                                            country.text=[NSString stringWithFormat:@"  %@",stname];
                                            sate.text=@"  Select State";
                                            city.text=@"  Select City";
                                            cid=cid1;
                                            
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
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
                                            sate.text=[NSString stringWithFormat:@"  %@",stname];
                                            stid=sid1;
                                            city.text=@"  Select City";
                                            
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
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
                                            city.text=[NSString stringWithFormat:@"  %@",cityName];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
    
}
-(IBAction)saveCertificate:(id)sender
{
    
    UITextView *descTxtView = desc1 ? desc1 : desc;
    
    UIButton *btn=sender;
    av=[[AllValidationsViewController alloc]init];
    
    if([av checkNull:nameOfCertificateText])
    {
        if([av checkNull:nameOfOrganisationText])
        {
            if([av checkNull:sworking])
            {
                if([av checkCombo:country]&&[av checkCombo:sate]&&[av checkCombo:city])
                {
                    if([av checkNulltextview:descTxtView])
                    {

                    // printf("%s", desc.text);
                     if([av checkNulltextview:add])
                        
                    {
                        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
                        
                        if(imgBuffer.length > 100)
                        {
                            [dic1 setValue:randomImgName forKey:@"certpic"];
                            [dic1 setValue:imgBuffer forKey:@"buffer1"];
                            
                            
                        }
                        else
                        {
                            [dic1 setValue:@"" forKey:@"certpic"];
                            [dic1 setValue:@"" forKey:@"buffer1"];
                        }
                        
                        [dic1 setValue:nameOfCertificateText.text forKey:@"certname"];
                        [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
                        [dic1 setValue:nameOfOrganisationText.text forKey:@"norg"];
                        [dic1 setValue:descTxtView.text forKey:@"descrip"];
                        [dic1 setValue:subjectText.text forKey:@"sbjct"];
                        [dic1 setValue:country.text forKey:@"cont"];
                        [dic1 setValue:sate.text forKey:@"state"];
                        [dic1 setValue:city.text forKey:@"city"];
                        [dic1 setValue:add.text forKey:@"add"];
                        [dic1 setValue:sworking.text forKey:@"tm"];
                        
                        
                        if(btn.tag==1)
                        {
                            [[SavePrefrences sharedInstance].skthand emitData:@"Certification" :@"SaveCert" :@"":@"":dic1 : vc1];
                        }
                        else if(btn.tag==2)
                        {
                            [dic1 setValue:[NSString stringWithFormat:@"%d",empID] forKey:@"cid"];
                            [dic1 setValue:@"1" forKey:@"k"];
                            [[SavePrefrences sharedInstance].skthand emitData:@"Certification" :@"updateCert" :@"":@"":dic1 :vc1];
                        }
                        imgBuffer=@"";
                        randomImgName=@"";
                        [prMainView removeFromSuperview];
                    }
                }
            }
        }
    }
}
}


-(IBAction)saveAward:(id)sender{
    UIButton *btn=sender;
    av=[[AllValidationsViewController alloc]init];
    if([av checkNull:company_name])
    {
        if([ av checkNull:sworking])
        {
            if([av checkNull:presented_by])
            {
                if([av checkCombo:country]&&[av checkCombo:sate]&&[av checkCombo:city])
                {
                    if([av checkNulltextview:add])
                    {
                        
                        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
                        if (imgBuffer.length >100) {
                            [dic1 setValue:randomImgName forKey:@"pic"];
                            [dic1 setValue:imgBuffer forKey:@"buffer1"];
                        }
                        else{
                            [dic1 setValue:@"" forKey:@"pic"];
                            [dic1 setValue:@"" forKey:@"buffer1"];
                        }
                        [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
                        [dic1 setValue:company_name.text forKey:@"nofcomp"];
                        [dic1 setValue:sworking.text forKey:@"when"];
                        [dic1 setValue:presented_by.text forKey:@"prsntBy"];
                        [dic1 setValue:subjectText.text forKey:@"add"];
                        [dic1 setValue:desc1.text forKey:@"des1"];
                        [dic1 setValue:country.text forKey:@"cont"];
                        [dic1 setValue:sate.text forKey:@"state"];
                        [dic1 setValue:city.text forKey:@"city"];
                        [dic1 setValue:add.text forKey:@"add"];
                        if(btn.tag==1)
                        {
                            NSLog(@"inside ifffff edit");
                            [[SavePrefrences sharedInstance].skthand emitData:@"Awards" :@"SaveAward" :@"":@"":dic1 :vc1];
                            
                        }
                        else{
                            NSLog(@"inside else edit");
                            [dic1 setValue:@"1" forKey:@"k"];
                            [dic1 setValue:[NSString stringWithFormat:@"%d",empID] forKey:@"aid"];
                            [dic1 setValue:desc1.text forKey:@"desc1"];
                            [[SavePrefrences sharedInstance].skthand emitData:@"Awards" :@"updateAward" :@"":@"":dic1 :vc1];
                        }
                        
                        
                        
                        randomImgName=@"";
                        imgBuffer=@"";
                        [prMainView removeFromSuperview];
                    }
                }
            }
        }
    }
}




-(IBAction)saveEmployementProfile:(id)sender
{
    
    UIButton *bt=(UIButton*)sender;
    
    if([av checkNull:name])
    {
        if([av checkNull:sworking] &&[av checkNull:eworking] )
        {
            if( [av checkDate:sworking.text :eworking.text])
            {
                if([av checkNull:degi])
                {
                    if([av checkCombo:country]&&[av checkCombo:sate]&&[av checkCombo:city])
                    {
                        if([av checkNulltextview:add])
                        {
                            
                            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
                            [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
                            [dic1 setValue:name.text forKey:@"ncomp"];
                            [dic1 setValue:sworking.text forKey:@"frm"];
                            [dic1 setValue:eworking.text forKey:@"too"];
                            [dic1 setValue :degi.text  forKey:@"des"];
                            [dic1 setValue:add.text forKey:@"loc"];
                            [dic1 setValue:desc.text forKey:@"desc"];
                            [dic1 setValue:country.text forKey:@"cont"];
                            [dic1 setValue:sate.text forKey:@"state"];
                            [dic1 setValue:city.text forKey:@"city"];
                            [dic1 setValue:add.text forKey:@"add"];
                            
                            if(bt.tag==0)
                            {
                                [[SavePrefrences sharedInstance].skthand emitData:@"Employment" :@"SaveEmp" :@"":@"":dic1 :vc1];
                                
                            }
                            else if (bt.tag==1)
                            {
                                [dic1 setValue:[NSString stringWithFormat:@"%d",empID] forKey:@"emid"];
                                [dic1 setValue:@"1" forKey:@"k"];
                                
                                [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"updateEmp" :@"":@"":dic1 :vc1];
                                
                            }
                            [prMainView removeFromSuperview];
                        }
                    }
                }
            }
        }
    }
    
}


- (void)toggleButton: (id) sender
{
    iscalpub=1;
    UIButton *tappedButton = (UIButton*)sender;
    [sender1  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    sender1=sender;
    
    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"radiounselect.png"]])
    {
        [sender  setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        UIButton *btn=sender;
        iscalpub=btn.tag;
    }
    else
    {
        [sender  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    }
    NSLog(@"%d",(int)iscalpub);
}

- (void)toggleButton1: (id) sender
{
    isRelation=1;
    UIButton *tappedButton = (UIButton*)sender;
    [sender2  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    sender2=sender;
    
    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"radiounselect.png"]])
    {
        [sender  setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        UIButton *btn=sender;
        isRelation=btn.tag;
    }
    else
    {
        [sender  setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
    }
    NSLog(@"%d",(int)iscalpub);
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
    UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage]:[info objectForKey:UIImagePickerControllerOriginalImage];
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
    isCallBack=@"7";
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getInd" :@"":@"":dic1 :self];
    
}

-(void) showInd
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Industry:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[[SavePrefrences sharedInstance].indAr count];x++)
    {
        
        NSString *stname=[[[SavePrefrences sharedInstance].indAr valueForKey:@"industry_name"] objectAtIndex:x];
        NSString *idd=[[[SavePrefrences sharedInstance].indAr valueForKey:@"i_id"] objectAtIndex:x];
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:stname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            indid=idd;
                                            info.text= [NSString stringWithFormat:@"  %@",stname];
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
}

-(void) callBack:(NSArray *)META  :(NSArray *)DATA
{
    int   isCallBack1=[isCallBack intValue];
    
    if (isCallBack1==4)//select Counrt
    {
        
        NSLog(@"call back in allpop");
        
        NSArray * md=[META valueForKey:@"data"];
        countryAr=[md valueForKey:@"country"];
        [self showCountry];
        
    }
    else if(isCallBack1==5)
    {
        NSArray * md=[META valueForKey:@"data"];
        stateAr=[md valueForKey:@"statesData"];
        [self showState];
    }
    
    else if(isCallBack1==6)
    {
        NSArray * md=[META valueForKey:@"data"];
        cityAr=[md valueForKey:@"statesData"];
        [self showCity];
    }
    else if(isCallBack1==7)
    {
        NSLog(@"ind ar Meta %@",META);
        NSLog(@"ind ar Data %@",DATA);
        
        [SavePrefrences sharedInstance].indAr=DATA;
        
        [self showInd];
    }
    
    else if(isCallBack1==8)
    {
        
        NSLog(@"inside 8");
        
        
        int isup =[[DATA valueForKey:@"affectedRows"]intValue ];
        if(isup>=1)
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Profile Updated" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
            
            [prMainView removeFromSuperview];
            
            id<CallTo_Parent> cb= vc1;
            [cb callMethod:nil];
            
        }
        else{
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Profile Not Saved" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
        }
        
    }
    
}



#pragma mark showFullDetail
-(void)showFullDetail:(NSString *)title1:(NSString *)add:(NSString *)award_desc:(NSString *)award_when:(NSString *)name_of_comp:(NSString *)presented_by:(NSString *)Img:(UIViewController * )vc
{
    
    NSLog(@"image pathh===%@",Img);
    NSMutableDictionary *edtprf=[SavePrefrences sharedInstance].colorDictionry;
    
    mainouterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[SavePrefrences sharedInstance].screenWidth,[SavePrefrences sharedInstance].screenHeight)];
    mainouterView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    mainouterView.layer.cornerRadius=10;
    [vc.view addSubview:mainouterView];
    
    UIView *outerView = [[UIView alloc] initWithFrame:CGRectMake(10,100,mainouterView.frame.size.width-20,mainouterView.frame.size.height-150)];
    outerView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"popupcolor"];
    outerView.layer.cornerRadius=10;
    [mainouterView addSubview:outerView];
    
    UILabel *titlab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, outerView.frame.size.width, 40)];
    titlab.text=[NSString stringWithFormat:@"  %@",title1];
    titlab.backgroundColor=[UIColor clearColor];//colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:0.0f/255.0f alpha:2.0f];
    titlab.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    titlab.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    //   titlab.layer.cornerRadius=10;
    titlab.clipsToBounds=YES;
    titlab.textAlignment=NSTextAlignmentCenter;
    [outerView addSubview:titlab];
    
    
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(10, titlab.frame.size.height+titlab.frame.origin.y+10, outerView.frame.size.width/2, 20)];
    title.text=[NSString stringWithFormat:@"  %@",name_of_comp];
    title.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    title.textColor=[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    title.backgroundColor=[UIColor clearColor];
    title.textAlignment=NSTextAlignmentLeft;
    [outerView addSubview:title];
    
    
    UILabel *aw=[[UILabel alloc] initWithFrame:CGRectMake(10, title.frame.size.height+title.frame.origin.y+10, outerView.frame.size.width/2, 20)];
    aw.text=[NSString stringWithFormat:@"  %@",award_when];
    aw.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    aw.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];//[UIColor orangeColor];
    aw.backgroundColor=[UIColor clearColor];
    aw.textAlignment=NSTextAlignmentLeft;
    [outerView addSubview:aw];
    
    
    UILabel *presentedby=[[UILabel alloc] initWithFrame:CGRectMake(10, aw.frame.size.height+aw.frame.origin.y+10, outerView.frame.size.width/2, 20)];
    presentedby.text=[NSString stringWithFormat:@"  %@",presented_by];
    presentedby.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    presentedby.textColor=[edtprf valueForKey:@"Scrollcolor"];//[UIColor blackColor];
    presentedby.backgroundColor=[UIColor clearColor];
    presentedby.textAlignment=NSTextAlignmentLeft;
    [outerView addSubview:presentedby];
    
    
    
    
    UIImageView *certimg =[[UIImageView alloc]initWithFrame:CGRectMake(outerView.frame.size.width/2+40, titlab.frame.size.height+titlab.frame.origin.y+10,65 , 65)];
    certimg.image = [UIImage imageNamed:@"username.png"];
    certimg.backgroundColor=[UIColor clearColor];
    [outerView addSubview:certimg];
    
    if(mang==nil)
        mang=[[ManageArray alloc]init];
    
    Img= [mang concatUrl:Img];
    
    
    NSLog(@"img is -=====jyy=== for Award  %@",Img);
    [imggeter sd_setImageWithURL:[NSURL URLWithString:Img]];
    //     NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
    //     if(Img.length<12)
    //     {
    //         certimg.image = [UIImage imageNamed:Img];
    //     }
    //     else
    //     {
    //         NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Img]];
    //           if (imageData.length<=0)
    //             certimg.image = [UIImage imageNamed:@"username.png"];
    //           else
    //             certimg.image = [UIImage imageWithData:imageData];
    //
    //     }
    
    UITextView *jd=[[UITextView alloc] initWithFrame:CGRectMake(10, presentedby.frame.size.height+presentedby.frame.origin.y+10, outerView.frame.size.width-20, outerView.frame.size.height/2+10)];
    jd.placeholder = @"Award Description";
    jd.text=[NSString stringWithFormat:@"%@ ",award_desc];
    jd.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
    jd.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"Tabstextcolor"];
    jd.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];//[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"backcolor"];
    jd.userInteractionEnabled=YES;
    jd.scrollEnabled=YES;
    jd.textAlignment=NSTextAlignmentLeft;
    [jd setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    jd.placeholder =@"Description";
    jd.backgroundColor=[UIColor clearColor];
    jd.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    [outerView addSubview:jd];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(100, jd.frame.size.height+jd.frame.origin.y+10, outerView.frame.size.width/2-40, 35)];
    [cancel setTitle: @"Close" forState: UIControlStateNormal];
    cancel.backgroundColor=[edtprf valueForKey:@"Yellowbtncolor"];
    [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [cancel addTarget:self action:@selector(discard1:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    // cancel.layer.cornerRadius=5;
    [outerView addSubview:cancel];
    
    
    
    
}

-(IBAction)discard1:(id)sender
{
    [mainouterView removeFromSuperview];
}

@end
