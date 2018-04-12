

#import "Jobpopup.h"
#import "AllValidationsViewController.h"
#import "SavePrefrences.h"
#import "SelectCountry.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ManageArray.h"
#import "AppDelegate.h"
#import "JobListVIewController.h"
#import "AMPPreviewController.h"
#import "CommonProfile.h"
#import "OtherProfileController.h"

@interface Jobpopup ()
{
    
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UILabel *NameLabel,*title_label,*comment_lbl,*open,*duration_lbl,*mnth,*day,*hours;
    UIView *prMainView,*headerView,*datePickerView;
    UIView *durview;
    NSMutableArray *popUpAr;
    UITextField *qualReq,*title_lbl;
    UITextView *jobdesc,*Message;
    UIViewController *vc1;
    NSString * stid ,*cid;
    AllValidationsViewController *av;
    UIScrollView *scrollbar;
    int issort,sortidis,iscallback,whichtocall,selstatus;
    UILabel * Select_Industry,*Select_Sub_Industry,*country,*sate,*city;
    UITextField *Title,*Posted_On,*Board_Posted_By,*location;
    NSMutableArray *backData;
    NSString *indid,*subid;
    NSArray *dataind ,*subdataind,*jobAr,*jobdetail,*countryAr,*stateAr,*cityAr,*jobDetailAr;
    int jobId,isdate,whichto,selmnth,selday,selhr,chkdesc;
    id sender1;
    UIButton *apply;
    NSString *juid;
    UIDatePicker *datepicker;
    NSString *isEdit,*isselect;
    int ftbrowse,isempty;
    NSString *randomImgName,*imgBuffer;
    UILabel *filename;
    ManageArray *manag;
    NSArray* jobApplicants;
    int stas;
}
@end

@implementation Jobpopup
@synthesize tableViewPoPosted;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    self.view.backgroundColor= [ff valueForKey:@"backcolor"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title
{
    if ([title isEqualToString:@"Sort By"] || [title isEqualToString:@"Change Status"])
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
        NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, prMainView.frame.size.height/2-prMainView.frame.size.height/4, prMainView.frame.size.width-40, 40+20)];
        NameLabel.text=title;
        NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];;
        NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        NameLabel.textColor=[UIColor colorWithRed:0.0/255 green:46.0/255 blue:99.0/255 alpha:1.0];
        NameLabel.textAlignment=NSTextAlignmentCenter;
        NameLabel.layer.cornerRadius=10;
        NameLabel.clipsToBounds=YES;
        [prMainView addSubview:NameLabel];
        
        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, 150)];
        [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
        scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];;
        
        scrollbar.layer.cornerRadius=10;
        [prMainView addSubview:scrollbar];
    }
    else if ([title isEqualToString:@"Advance Search"])
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
        NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, prMainView.frame.size.height/2-prMainView.frame.size.height/3, prMainView.frame.size.width-40, 40+20)];
        NameLabel.text=title;
        NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];;
        NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        NameLabel.textColor=[UIColor colorWithRed:0.0/255 green:46.0/255 blue:99.0/255 alpha:1.0];
        NameLabel.textAlignment=NSTextAlignmentCenter;
        NameLabel.layer.cornerRadius=10;
        NameLabel.clipsToBounds=YES;
        [prMainView addSubview:NameLabel];
        
        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, 300)];
        [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
        scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];;
        
        scrollbar.layer.cornerRadius=10;
        scrollbar.scrollEnabled=NO;
        [prMainView addSubview:scrollbar];
    }
    
    else{
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
        NameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15+10, prMainView.frame.size.width-40, 50+20)];
        NameLabel.text=title;
        NameLabel.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];;
        NameLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
        NameLabel.textColor=[UIColor colorWithRed:0.0/255 green:46.0/255 blue:99.0/255 alpha:1.0];
        NameLabel.textAlignment=NSTextAlignmentCenter;
        NameLabel.layer.cornerRadius=10;
        NameLabel.clipsToBounds=YES;
        [prMainView addSubview:NameLabel];
        
        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+130))];
        [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
        scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        scrollbar.layer.cornerRadius=10;
        scrollbar.clipsToBounds=YES;
        [prMainView addSubview:scrollbar];
        
    }
    
    
    
    return prMainView;
}
-(UIView *) MainViewwithouttitle:(UIViewController *)Vc
{
    av=[[AllValidationsViewController alloc]init];
    
    NSLog(@"pop ar count in mainview2   %lu",[popUpAr count]);
    
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    NSMutableDictionary *stack=[SavePrefrences sharedInstance].colorDictionry;

    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 56)];
    headerView.backgroundColor=[stack valueForKey:@"backcolor"];
    [prMainView addSubview:headerView];
    
    return prMainView;
}
-(void)AddnewProject:(UIViewController*)Vc
{
    chkdesc=0;
    
    [self MainView:Vc :@"Add new Project"];
    NSMutableDictionary *bt=[SavePrefrences sharedInstance].colorDictionry;
    
    scrollbar.frame =CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+100));
    
    title_lbl =[[UITextField alloc]initWithFrame:CGRectMake(20, 5, scrollbar.frame.size.width-40,35)];
   // title_lbl.placeholder=@"Title";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    title_lbl.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName: color}];

    title_lbl.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    title_lbl.textColor=[bt valueForKey:@"Scrollcolor"];
    title_lbl.delegate=self;
    [title_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    title_lbl.leftView = paddingView1;
    title_lbl.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [scrollbar addSubview:title_lbl];
    
    qualReq=[[UITextField alloc]initWithFrame:CGRectMake(20, title_lbl.frame.size.height+title_lbl.frame.origin.y+15, scrollbar.frame.size.width-40,35)];
   // qualReq.placeholder=@"Qualification Required";
    qualReq.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Qualification Required" attributes:@{NSForegroundColorAttributeName: color}];

    qualReq.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    qualReq.textColor=[bt valueForKey:@"Scrollcolor"];
    qualReq.delegate=self;
    [qualReq setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    qualReq.leftView = paddingView2;
    qualReq.leftViewMode = UITextFieldViewModeAlways;
    ///////////
    [scrollbar addSubview:qualReq];
    
    location=[[UITextField alloc]initWithFrame:CGRectMake(20, qualReq.frame.size.height+qualReq.frame.origin.y+15, scrollbar.frame.size.width-40,35)];
   // location.placeholder=@"Location";
    location.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Location" attributes:@{NSForegroundColorAttributeName: color}];

    location.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    location.textColor=[bt valueForKey:@"Scrollcolor"];
    location.delegate=self;
    [location setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    location.leftView = paddingView3;
    location.leftViewMode = UITextFieldViewModeAlways;
    ///////////
    [scrollbar addSubview:location];

    
    duration_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, location.frame.size.height+location.frame.origin.y+15, scrollbar.frame.size.width-40,35)];
    duration_lbl.textColor=[bt valueForKey:@"Scrollcolor"];
    duration_lbl.text=@"  Select Duration";
    [duration_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    duration_lbl.clipsToBounds=YES;
    duration_lbl.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [scrollbar addSubview:duration_lbl];
    
    
    
    UITapGestureRecognizer *ind1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDuration:)];
    [ind1 setNumberOfTouchesRequired:1];
    [ind1 setDelegate:self];
    duration_lbl.userInteractionEnabled = YES;
    [duration_lbl addGestureRecognizer:ind1];
    

    
    country=[[UILabel alloc] initWithFrame:CGRectMake(20, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+15, scrollbar.frame.size.width-40, 35)];
    country.text=@"  Select Country";
    country.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    country.textColor=[bt valueForKey:@"Scrollcolor"];
    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    country.clipsToBounds=YES;
    [scrollbar addSubview:country];
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    sate=[[UILabel alloc] initWithFrame:CGRectMake(20, country.frame.size.height+country.frame.origin.y+15, scrollbar.frame.size.width-40, 35)];
    sate.text=@"  Select State";
    sate.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    sate.textColor=[bt valueForKey:@"Scrollcolor"];
    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    sate.clipsToBounds=YES;
    [scrollbar addSubview:sate];
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    
    city=[[UILabel alloc] initWithFrame:CGRectMake(20, sate.frame.size.height+sate.frame.origin.y+15, scrollbar.frame.size.width-40, 35)];
    city.text=@"  Select City";
    city.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    city.textColor=[bt valueForKey:@"Scrollcolor"];
    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    city.clipsToBounds=YES;
    [scrollbar addSubview:city];
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    
    
    Select_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20,city.frame.size.height+city.frame.origin.y+15, scrollbar.frame.size.width-40, 35)];
    Select_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Select_Industry.textColor=[bt valueForKey:@"Scrollcolor"];
    Select_Industry.text=@"  Select Industry";
    [Select_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Industry.clipsToBounds=YES;
    [scrollbar addSubview:Select_Industry];
    
    UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInduct)];
    [ind setNumberOfTouchesRequired:1];
    [ind setDelegate:self];
    Select_Industry.userInteractionEnabled = YES;
    [Select_Industry addGestureRecognizer:ind];
    
    
    Select_Sub_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20,Select_Industry.frame.size.height+Select_Industry.frame.origin.y+15, scrollbar.frame.size.width-40,35)];
    Select_Sub_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Select_Sub_Industry.textColor=[bt valueForKey:@"Scrollcolor"];
    
    Select_Sub_Industry.text=@"  Select Sub Industry";
    [ Select_Sub_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Sub_Industry.clipsToBounds=YES;
    [scrollbar addSubview: Select_Sub_Industry];
    
    
    UITapGestureRecognizer *ind2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecSubInd)];
    [ind2 setNumberOfTouchesRequired:1];
    [ind2 setDelegate:self];
    Select_Sub_Industry.userInteractionEnabled = YES;
    [Select_Sub_Industry addGestureRecognizer:ind2];
    
    jdesc=[[UILabel alloc]initWithFrame:CGRectMake(20, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+15, scrollbar.frame.size.width-40, 20)];
    
    jdesc.text=@"Job Description";
    [jdesc setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    jdesc.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    jdesc.backgroundColor=[UIColor clearColor];
    [scrollbar addSubview:jdesc];

    UIView *ViewJobdesc=[[UIView alloc]initWithFrame:CGRectMake(20, jdesc.frame.size.height+jdesc.frame.origin.y+5, scrollbar.frame.size.width-40, 60)];
    ViewJobdesc.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [scrollbar addSubview:ViewJobdesc];
    
    
    jobdesc=[[UITextView alloc]initWithFrame:CGRectMake(5, 5, scrollbar.frame.size.width-20, 50)];
    jobdesc.backgroundColor=[UIColor clearColor];
    jobdesc.clipsToBounds=YES;
    jobdesc.delegate=self;
    [jobdesc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    jobdesc.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [ViewJobdesc addSubview:jobdesc];
    
    UIButton *attach=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    attach.frame=CGRectMake(10,ViewJobdesc.frame.size.height+ViewJobdesc.frame.origin.y+10, 100, 40);
    [attach setTitle:@"Attach File" forState:UIControlStateNormal];
    [attach setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [attach setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f]forState:UIControlStateNormal];
    [attach addTarget:self action:@selector(attachFile:) forControlEvents:UIControlEventTouchUpInside];
    attach.backgroundColor=[UIColor clearColor];
    [scrollbar addSubview:attach];
    
    filename=[[UILabel alloc]initWithFrame:CGRectMake(attach.frame.size.width+30, ViewJobdesc.frame.size.height+ViewJobdesc.frame.origin.y+10, 160, 25)];
    filename.textColor=[UIColor blackColor];
    [scrollbar addSubview:filename];
    
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame=CGRectMake( 35,attach.frame.size.height+attach.frame.origin.y+15, scrollbar.frame.size.width/2 -40, 35);
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [submit setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(Addnewjob:)forControlEvents:UIControlEventTouchUpInside];
    
    submit.backgroundColor=[UIColor clearColor];
    [scrollbar addSubview:submit];
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake( submit.frame.size.width+submit.frame.origin.x+5,attach.frame.size.height+attach.frame.origin.y+15, scrollbar.frame.size.width/2 -40, 35);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f]forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel1:) forControlEvents:UIControlEventTouchUpInside];
    close.backgroundColor=[UIColor clearColor];
    
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, close.frame.size.height+close.frame.origin.y+20);
    
    NSArray *fields = @[title_lbl, qualReq, location];
    
    _keyboardControls = [[BSKeyboardControls alloc] initWithFields:fields];
    [_keyboardControls setDelegate:self];
}


#pragma mark BSKEYBOARD CONTROLS

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if(chkdesc==0){
        [scrollbar setContentOffset:CGPointMake(0,300) animated:YES];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [scrollbar setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls{
    [keyboardControls.activeField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [_keyboardControls setActiveField:textField];
}


#pragma mark --

-(void)DurationView
{
    
    NSMutableDictionary *advnce=[SavePrefrences sharedInstance].colorDictionry;
    //248:250:251
    durview=[[UIView alloc]initWithFrame:CGRectMake(5, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+5, scrollbar.frame.size.width-10,45)];
    durview.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    durview.hidden=false;
    [scrollbar addSubview:durview];
    
    mnth=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, durview.frame.size.width/3 -10, 20)];
    mnth.text=@" Month";
    mnth.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    mnth.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [mnth setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    mnth.clipsToBounds=YES;
    [durview addSubview:mnth];
    
    day=[[UILabel alloc]initWithFrame:CGRectMake(mnth.frame.size.width+mnth.frame.origin.x+5, 0, durview.frame.size.width/3 -10, 20)];
    day.text=@" Days";
    day.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    day.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [day setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    day.clipsToBounds=YES;
    [durview addSubview:day];
    
    hours=[[UILabel alloc]initWithFrame:CGRectMake(day.frame.size.width+day.frame.origin.x+5,0, durview.frame.size.width/3 -10, 20)];
    hours.text=@" Hour";
    hours.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    hours.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];;
    [hours setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    hours.clipsToBounds=YES;
    [durview addSubview:hours];
    
    UIButton *set = [[UIButton alloc]initWithFrame:CGRectMake(durview.frame.size.width/2-60, mnth.frame.size.height+mnth.frame.origin.y+2, durview.frame.size.width/4-20, 20)];
    [set setTitle: @"set" forState: UIControlStateNormal];
    set.backgroundColor=[UIColor clearColor];
    [set setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [set addTarget:self action:@selector(setduration:) forControlEvents:UIControlEventTouchUpInside];
    [set setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    set.tag=0;
    [durview addSubview:set];
    
    UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(set.frame.size.width+set.frame.origin.x+5, mnth.frame.size.height+mnth.frame.origin.y+2, durview.frame.size.width/4-20, 20)];
    [close setTitle: @"close" forState: UIControlStateNormal];
    close.backgroundColor=[UIColor clearColor];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close addTarget:self action:@selector(closeduration:) forControlEvents:UIControlEventTouchUpInside];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
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
      country.frame=CGRectMake(20, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+15, scrollbar.frame.size.width-40, 35);
    
}

-(IBAction)Addnewjob:(id)sender
{
    iscallback=19;
    
    if([av checkNull:title_lbl])
    {
        if([av checkNull:qualReq])
        {
            if([av checkCombo:duration_lbl])
            {
                if([av checkCombo:country]&&[av checkCombo:sate]&&[av checkCombo:city])
                {
                    if([av checkCombo:Select_Industry]&&[av checkCombo:Select_Sub_Industry])
                    {
                    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                    [dic setObject:title_lbl.text forKey:@"title"];
                    [dic setObject:qualReq.text forKey:@"qua"];
                    [dic setObject:duration_lbl.text forKey:@"dur"];
                    [dic setObject:location.text forKey:@"loc"];
                    [dic setObject:jobdesc.text forKey:@"desc"];
                    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
                    [dic setObject:country.text forKey:@"cont"];
                    [dic setObject:sate.text forKey:@"state"];
                    [dic setObject:city.text forKey:@"city"];
                   // [dic setObject:Select_Industry.text forKey:@"i_id"];
                    //[dic setObject:Select_Sub_Industry.text forKey:@"t_id"];
                    
                        [dic setObject:indid forKey:@"i_id"];
                        [dic setObject:subid forKey:@"t_id"];
                     
                        
                        
                        
                    if(imgBuffer==nil||imgBuffer==NULL||[imgBuffer isEqual:[NSNull null]]||imgBuffer == (id)[NSNull null])
                    {
                    }
                    else
                    {
                    if(imgBuffer.length>100)
                    {
                        [dic setObject:randomImgName forKey:@"att"];
                        [dic setObject:imgBuffer forKey:@"buffer1"];
                    }
                    else
                    {
                                 [dic setObject:@"" forKey:@"att"];
                    }
                    }
                    [[SavePrefrences sharedInstance].skthand emitData:@"AllProjects" :@"saveJob" :@"" :@"" :dic :self ];
                    
                      
                    //        SONObject obj = new JSONObject();
                    //        obj.put(“title”, ed_postjobtitle.getText().toString());
                    //        obj.put(“qua”, ed_postjobqualif.getText().toString());
                    //        obj.put(“dur”, ed__postjobDuration.getText().toString());
                    //        obj.put(“loc”, ed__postjobsLocation.getText().toString());
                    //        obj.put(“desc”, ed__postjobjobdesc.getText().toString());
                    //        obj.put(“cont”, postajob_spinnercontry.getSelectedItem());
                    //        obj.put(“state”, postajob_spinnerstate.getSelectedItem());
                    //        obj.put(“city”, postajob_spinnercity.getSelectedItem());
                    //        //                        obj.put("u_id", splash_data.get(0));
                    //        obj.put(“id”, splash_data.get(0));
                    //        obj.put(“i_id”, postajob_spinnerIndust.getSelectedItemPosition());//Industry
                    //        obj.put(“t_id”, addSpin.get(postajob_spinnersubInd.getSelectedItemPosition()));//sub
                    //        if(SplashScreen.imagedata.size()>0) {
                    //            obj.put(“att”, SplashScreen.imagedata.get(0));
                    //            obj.put(“buffer1”, SplashScreen.imagedata.get(2));
                    //        }else {obj.put(“att”,"");}
                    //        if(postP==0)
                    //        {
                    //            obj.put(“k”, “ok”);
                    //            getopenJobs(“AllProjects”, “saveJob”, obj);
                    //            
                    //        }else{
                    //            obj.put(“k”, “all”);
                    //            showAppliedJobs(“AllProjects”, “saveJob”, obj);
                    //
                    imgBuffer=@"";
                    }
                }
            }
        }
    }
    
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
-(void)searchAdvance:(UIViewController*)Vc:(int)whichto
  {
    
    NSMutableDictionary *advnce=[SavePrefrences sharedInstance].colorDictionry;
    [self MainView:Vc :@"Advance Search"];
    
    
    Title=[[UITextField alloc]initWithFrame:CGRectMake(20,5, scrollbar.frame.size.width-40,35)];
    Title.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Title.textColor=[advnce valueForKey:@"Scrollcolor"];
   // Title.placeholder=@"Title";
    UIColor *color = [UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    Title.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName: color}];

    [Title setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Title.delegate=self;
      ///////////
      UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
      Title.leftView = paddingView1;
      Title.leftViewMode = UITextFieldViewModeAlways;
      ///////////

    [scrollbar addSubview:Title];
    
    Posted_On=[[UITextField alloc]initWithFrame:CGRectMake(20,Title.frame.size.height+Title.frame.origin.y+15, scrollbar.frame.size.width-40, 35)];
    Posted_On.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Posted_On.textColor=[advnce valueForKey:@"Scrollcolor"];
   // Posted_On.placeholder=@"Posted On";
    Posted_On.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Posted On" attributes:@{NSForegroundColorAttributeName: color}];
    Posted_On.tag=0;
    [ Posted_On setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Posted_On.userInteractionEnabled=NO;
      ///////////
      UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
      Posted_On.leftView = paddingView2;
      Posted_On.leftViewMode = UITextFieldViewModeAlways;
      ///////////

    [scrollbar addSubview: Posted_On];
    
    UITapGestureRecognizer *indreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(date:)];
    [indreg setNumberOfTouchesRequired:1];
    [indreg setDelegate:self];
    Posted_On.userInteractionEnabled = YES;
    [Posted_On addGestureRecognizer:indreg];
    
    
    Board_Posted_By=[[UITextField alloc]initWithFrame:CGRectMake(20,Posted_On.frame.size.height+Posted_On.frame.origin.y+15 , scrollbar.frame.size.width-40, 35)];
    Board_Posted_By.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Board_Posted_By.textColor=[advnce valueForKey:@"Scrollcolor"];
   // Board_Posted_By.placeholder=@"Posted By";
    Board_Posted_By.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Posted By" attributes:@{NSForegroundColorAttributeName: color}];

    Board_Posted_By.delegate=self;
    [Board_Posted_By setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
      ///////////
      UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
      Board_Posted_By.leftView = paddingView4;
      Board_Posted_By.leftViewMode = UITextFieldViewModeAlways;
      ///////////

    [scrollbar addSubview:Board_Posted_By];
    
    duration_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,Board_Posted_By.frame.size.height+Board_Posted_By.frame.origin.y+15, scrollbar.frame.size.width-40,35)];
    duration_lbl.textColor=[advnce valueForKey:@"Scrollcolor"];
    duration_lbl.text=@"  Select Duration";
    [duration_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    duration_lbl.clipsToBounds=YES;
    duration_lbl.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [scrollbar addSubview:duration_lbl];
    
    UITapGestureRecognizer *ind1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDuration:)];
    [ind1 setNumberOfTouchesRequired:1];
    [ind1 setDelegate:self];
    duration_lbl.tag=0;
    duration_lbl.userInteractionEnabled = YES;
    [duration_lbl addGestureRecognizer:ind1];
    
    location=[[UITextField alloc]initWithFrame:CGRectMake(20,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+15, scrollbar.frame.size.width-40,35)];
    location.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    location.textColor=[advnce valueForKey:@"Scrollcolor"];
    //location.placeholder=@"Location";
    location.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Location" attributes:@{NSForegroundColorAttributeName: color}];

    [location setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    location.delegate=self;
      ///////////
      UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
      location.leftView = paddingView5;
      location.leftViewMode = UITextFieldViewModeAlways;
      ///////////

    [scrollbar addSubview:location];
    
    Select_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20,location.frame.size.height+location.frame.origin.y+15, scrollbar.frame.size.width-40, 35)];
    Select_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Select_Industry.textColor=[advnce valueForKey:@"Scrollcolor"];
    Select_Industry.text=@"  Select Industry";
    [Select_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Industry.clipsToBounds=YES;
    [scrollbar addSubview:Select_Industry];
    
    UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInduct)];
    [ind setNumberOfTouchesRequired:1];
    [ind setDelegate:self];
    Select_Industry.userInteractionEnabled = YES;
    [Select_Industry addGestureRecognizer:ind];
    
    
    Select_Sub_Industry=[[UILabel alloc]initWithFrame:CGRectMake(20,Select_Industry.frame.size.height+Select_Industry.frame.origin.y+15, scrollbar.frame.size.width-40,35)];
    Select_Sub_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Select_Sub_Industry.textColor=[advnce valueForKey:@"Scrollcolor"];
    Select_Sub_Industry.text=@"  Select Sub Industry";
    [ Select_Sub_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Sub_Industry.clipsToBounds=YES;
    [scrollbar addSubview: Select_Sub_Industry];
    
    
    UITapGestureRecognizer *ind2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecSubInd)];
    [ind2 setNumberOfTouchesRequired:1];
    [ind2 setDelegate:self];
    Select_Sub_Industry.userInteractionEnabled = YES;
    [Select_Sub_Industry addGestureRecognizer:ind2];
  
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame=CGRectMake( scrollbar.frame.size.width/2 -130,Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+15, scrollbar.frame.size.width/2 -40, 35);
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [submit setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f]forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(advanceSearchDetails:)forControlEvents:UIControlEventTouchUpInside];
    submit.tag=whichto;
    submit.backgroundColor=[UIColor clearColor];
    [scrollbar addSubview:submit];
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake( submit.frame.size.width+submit.frame.origin.x+5,Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+15, scrollbar.frame.size.width/2 -40, 35);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel1:) forControlEvents:UIControlEventTouchUpInside];
    
    close.backgroundColor=[UIColor clearColor];
    
    [scrollbar addSubview:close];
    
      scrollbar.frame=CGRectMake( 20, NameLabel.frame.size.height+NameLabel.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-40, close.frame.size.height+close.frame.origin.y+20);
      scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, close.frame.size.height+close.frame.origin.y+10);
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
            duration_lbl.text=[NSString stringWithFormat:@"  %@",[day.text stringByAppendingString:hours.text]];
            durview.hidden=true;
            country.frame=CGRectMake(20,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+15, scrollbar.frame.size.width-40,35);
        }
        else{
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Hours" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alrt show];
            
        }
    }
    else if (![mnth.text isEqual:@" Month"] &&[day.text isEqual:@" Days"]&& ![hours.text isEqual:@" Hour"])
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Days" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alrt show];
    }
    else if ([mnth.text isEqual:@" Month"] &&[day.text isEqual:@" Days"]&& ![hours.text isEqual:@" Hour"])
    {
        duration_lbl.text=[NSString stringWithFormat:@"  %@",hours.text];
        durview.hidden=true;
        country.frame=CGRectMake(20,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+15, scrollbar.frame.size.width-40,35);
    }
    else{
        duration_lbl.text=[NSString stringWithFormat:@"  %@",[[mnth.text stringByAppendingString:day.text]stringByAppendingString:hours.text]];
        durview.hidden=true;
        country.frame=CGRectMake(20,duration_lbl.frame.size.height+duration_lbl.frame.origin.y+15, scrollbar.frame.size.width-40,35);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"predddd");
    [textField resignFirstResponder];
    return YES;
}

-(void)selectDuration:(UIViewController*)Vc
{
    duration_lbl.userInteractionEnabled=NO;
    [self DurationView];
    country.frame=CGRectMake(20,durview.frame.size.height+durview.frame.origin.y+15, scrollbar.frame.size.width-40,35);
    
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
    [datepicker setValue:[UIColor whiteColor] forKey:@"textColor"];
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
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [datePickerView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, datepicker.frame.size.height+datepicker.frame.origin.y, 70, 30)];
    [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
    cancel.backgroundColor=[UIColor grayColor];
    [cancel addTarget:self action:@selector(nook:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [datePickerView addSubview:cancel];
    
}
-(IBAction)ok:(id)sender
{
    UIButton *ub=(UIButton *)sender;
    int tid =ub.tag;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M-d-yyyy"];
    
    if(tid==0)
    {
        
        Posted_On.text=[NSString stringWithFormat:@"%@",[df stringFromDate:datepicker.date]];
    }
    
    else{
        
        
    }
    [datepicker removeFromSuperview];
    
    [datePickerView removeFromSuperview];
    
}


-(IBAction)nook:(id)sender
{
    [datepicker removeFromSuperview];
    [datePickerView removeFromSuperview];
}


#pragma mark onRowClick
-(void)readMoreDetails
{
    NSMutableDictionary *detailsclr=[SavePrefrences sharedInstance].colorDictionry;
    [self MainViewwithouttitle:vc1];
    
   // headerView.backgroundColor=[UIColor colorWithRed:51.0f/255 green:102.0f/255 blue:153.0f/255 alpha:1.0f];
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
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(headerView.frame.size.width/2-75,5,headerView.frame.size.width/2-20, 50)];
    [logo setCenter:CGPointMake(headerView.center.x, logo.center.y)];
    [logo setContentMode:UIViewContentModeScaleAspectFit];

   // UIImageView *logo=[[UIImageView alloc]initWithFrame:CGRectMake(bckarrow.frame.size.width+bckarrow.frame.origin.x+15,5,150,50)];
    [logo setImage:[UIImage imageNamed:@"logo_new.png"]];
    [headerView addSubview:logo];
    
    
    UILabel *gap=[[UILabel alloc] initWithFrame:CGRectMake(0,headerView.frame.size.height-1, headerView.frame.size.width, 2)];
    gap.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [headerView addSubview:gap];

    
   /* UIScrollView *scroll1=[[UIScrollView alloc] initWithFrame:CGRectMake(0,headerView.frame.size.height+headerView.frame.origin.y,prMainView.frame.size.width, prMainView.frame.size.height)];
    [scroll1 setContentSize:CGSizeMake(prMainView.frame.size.width, prMainView.frame.size.height)];
    scroll1.backgroundColor=[detailsclr valueForKey:@"backcolor"];
    [prMainView addSubview:scroll1];*/
    
    UIScrollView *commentMain=[[UIScrollView alloc] initWithFrame:CGRectMake(0,headerView.frame.size.height+headerView.frame.origin.y,prMainView.frame.size.width, prMainView.frame.size.height)];
    [commentMain setContentSize:CGSizeMake(prMainView.frame.size.width, prMainView.frame.size.height+150)];
    commentMain.backgroundColor=[detailsclr valueForKey:@"backcolor"];
    [commentMain setScrollEnabled:YES];
    [prMainView addSubview:commentMain];
    
    UIImageView *imge=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
  //  [imge setImage:[UIImage imageNamed:@"user.png"]];
    imge.layer.cornerRadius=30;
    imge.clipsToBounds=YES;
    [commentMain addSubview:imge];
    
    NSString *uname=[[jobdetail objectAtIndex:0]valueForKey:@"uname"];
    NSString *email=[[jobdetail objectAtIndex:0]valueForKey:@"email"];
    NSString *title=[[jobdetail objectAtIndex:0]valueForKey:@"title"];
    NSString *duration=[[jobdetail objectAtIndex:0]valueForKey:@"duration"];
    NSString *location=[[jobdetail objectAtIndex:0]valueForKey:@"location"];
    NSString *qualification=[[jobdetail objectAtIndex:0]valueForKey:@"qualification"];
    NSString *industry_name=[[jobdetail objectAtIndex:0]valueForKey:@"industry_name"];
    NSString *topic_name=[[jobdetail objectAtIndex:0]valueForKey:@"topic_name"];
    NSString *job_desc=[[jobdetail objectAtIndex:0]valueForKey:@"job_desc"];
    NSString *job_id=[[jobdetail objectAtIndex:0]valueForKey:@"job_id"];
    NSString *status=[[jobdetail objectAtIndex:0]valueForKey:@"status"];
    NSString *img=[[jobdetail objectAtIndex:0]valueForKey:@"img"];
    NSString *about=[[jobdetail objectAtIndex:0]valueForKey:@"about"];
    NSString *attachName=[[jobdetail objectAtIndex:0]valueForKey:@"attachName"];
    attachName =  [attachName.lowercaseString isEqualToString:@"undefined"] ? @"No Attachments" : attachName;
    
    if(manag==nil)
        manag=[[ManageArray alloc]init];
    
    NSString * url=[manag concatUrl:img];
    if(url.length<12)
    {
        imge.image = [UIImage imageNamed:@"username.png"];
    }
    else
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        if (imageData.length<=0)
            imge.image = [UIImage imageNamed:@"username.png"];
        else
            imge.image = [UIImage imageWithData:imageData];
    }
    if(img==nil||img==NULL||[img isEqual:[NSNull null]]||[img isEqual:@""]||img == (id)[NSNull null])
    {
    }
    else
    {
        NSArray* foo = [img componentsSeparatedByString: @"/"];
        img = [foo objectAtIndex: (int)[foo count]-1];
    }
    
    UILabel *UserName=[[UILabel alloc]initWithFrame:CGRectMake(imge.frame.size.width+imge.frame.origin.x+5, 15, commentMain.frame.size.width-130, 20)];
    UserName.text=uname;//78:119:145
    UserName.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    UserName.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    [commentMain addSubview:UserName];
    
    UILabel *emailUser=[[UILabel alloc]initWithFrame:CGRectMake(imge.frame.size.width+imge.frame.origin.x+5,UserName.frame.size.height+UserName.frame.origin.y+10,commentMain.frame.size.width-130, 20)];
    emailUser.text=email;
    emailUser.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    emailUser.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [commentMain addSubview:emailUser];
    
   // UILabel *gap=[[UILabel alloc] initWithFrame:CGRectMake(0,imge.frame.size.height+imge.frame.origin.y+10, prMainView.frame.size.width, 1)];
 //   gap.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
  //  [commentMain addSubview:gap];
    
    UILabel *title_lbl=[[UILabel alloc] initWithFrame:CGRectMake(-2,imge.frame.size.height+imge.frame.origin.y+10, commentMain.frame.size.width+4,40)];//85:172:238
    title_lbl.backgroundColor=[UIColor clearColor];
    title_lbl.textColor=[UIColor colorWithRed:78.0f/255.0f green:119.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    title_lbl.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    title_lbl.text=[NSString stringWithFormat:@"   %@", title];
    title_lbl.layer.borderWidth=1;
    title_lbl.layer.borderColor=[[UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1] CGColor];
    [commentMain addSubview:title_lbl];
    //1111
    
    UITextView *job_desc1=[[UITextView alloc] initWithFrame:CGRectMake(10,title_lbl.frame.size.height+title_lbl.frame.origin.y+5, commentMain.frame.size.width-20, 40)];
    job_desc1.text=[NSString stringWithFormat:@"%@",job_desc];
    job_desc1.textAlignment=NSTextAlignmentLeft;
    job_desc1.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    job_desc1.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    job_desc1.backgroundColor=[UIColor clearColor];
    job_desc1.editable=NO;
    [job_desc1 sizeToFit];
    [commentMain addSubview:job_desc1];

    
    UILabel *Duration=[[UILabel alloc]initWithFrame:CGRectMake(10,job_desc1.frame.size.height+job_desc1.frame.origin.y+15, 100, 20)];
    Duration.text=@"Duration :";
    Duration.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    Duration.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [commentMain addSubview:Duration];
    
    UILabel *duration_time=[[UILabel alloc]initWithFrame:CGRectMake(Duration.frame.size.width+Duration.frame.origin.x, job_desc1.frame.size.height+job_desc1.frame.origin.y+5,  commentMain.frame.size.width, 20)];
    duration_time.text=duration;
    duration_time.textAlignment=NSTextAlignmentLeft;
    duration_time.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    duration_time.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    
    [commentMain addSubview:duration_time];
    //2222
    UILabel *Location=[[UILabel alloc]initWithFrame:CGRectMake(10, Duration.frame.size.height+Duration.frame.origin.y+5, 100, 20)];
    Location.text=@"Location :";
    Location.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    Location.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [commentMain addSubview:Location];
    
    UILabel *Location_details=[[UILabel alloc]initWithFrame:CGRectMake(Location.frame.size.width+Location.frame.origin.x,  duration_time.frame.size.height+duration_time.frame.origin.y+5,  commentMain.frame.size.width, 20)];
    Location_details.text=location;
    Location_details.textAlignment=NSTextAlignmentLeft;
    Location_details.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    Location_details.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [commentMain addSubview:Location_details];
    
    /*UILabel *Attachment=[[UILabel alloc]initWithFrame:CGRectMake(5,Location.frame.size.height+Location.frame.origin.y+5, 100, 20)];
    Attachment.text=@"Attachment:";
    Attachment.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    Attachment.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    [commentMain addSubview:Attachment];
    
    UILabel *Attachment_txt=[[UILabel alloc]initWithFrame:CGRectMake(Attachment.frame.size.width+Attachment.frame.origin.x, Location.frame.size.height+Location.frame.origin.y+5,  commentMain.frame.size.width, 20)];
    Attachment_txt.text=[NSString stringWithFormat:@"%@",img];
    Attachment_txt.textAlignment=NSTextAlignmentLeft;
    Attachment_txt.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    Attachment_txt.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [commentMain addSubview:Attachment_txt];*/
    
    //333
    UILabel *Qualification=[[UILabel alloc]initWithFrame:CGRectMake(10, Location.frame.size.height+Location.frame.origin.y+5, 100, 20)];
    Qualification.text=@"Qualification :";
    Qualification.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    Qualification.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [commentMain addSubview:Qualification];
    
    UILabel *Qualification_txt=[[UILabel alloc]initWithFrame:CGRectMake(Qualification.frame.size.width+Qualification.frame.origin.x,Location.frame.size.height+Location.frame.origin.y+5,  commentMain.frame.size.width, 20)];
    Qualification_txt.text=qualification;
    Qualification_txt.textAlignment=NSTextAlignmentLeft;
    Qualification_txt.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    Qualification_txt.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [commentMain addSubview:Qualification_txt];
    
    //444
    UILabel *industry=[[UILabel alloc]initWithFrame:CGRectMake(10,Qualification.frame.size.height+Qualification.frame.origin.y+5, 100, 20)];
    industry.text=@"Industry :";
    industry.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    industry.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [commentMain addSubview:industry];
    
    UILabel *industry_txt=[[UILabel alloc]initWithFrame:CGRectMake(industry.frame.size.width+industry.frame.origin.x,Qualification_txt.frame.size.height+Qualification_txt.frame.origin.y+5,commentMain.frame.size.width, 20)];
    industry_txt.text=industry_name;
    industry_txt.textAlignment=NSTextAlignmentLeft;
    industry_txt.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    industry_txt.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [commentMain addSubview:industry_txt];
    //555
    UILabel *Subindustry=[[UILabel alloc]initWithFrame:CGRectMake(10, industry.frame.size.height+industry.frame.origin.y+5, 100, 20)];
    Subindustry.text=@"Sub Industry :";
    Subindustry.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    Subindustry.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [commentMain addSubview:Subindustry];
    
    UILabel *Subindustry_txt=[[UILabel alloc]initWithFrame:CGRectMake(Subindustry.frame.size.width+Subindustry.frame.origin.x,industry_txt.frame.size.height+industry_txt.frame.origin.y+5,commentMain.frame.size.width, 20)];
    Subindustry_txt.text=[NSString stringWithFormat:@"%@",topic_name];
    Subindustry_txt.textAlignment=NSTextAlignmentLeft;
    Subindustry_txt.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    Subindustry_txt.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [commentMain addSubview:Subindustry_txt];
    //666
    UILabel *Attachment=[[UILabel alloc]initWithFrame:CGRectMake(10,Subindustry.frame.size.height+Subindustry.frame.origin.y+5, 100, 20)];
     Attachment.text=@"Attachment :";
     Attachment.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
     Attachment.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
     [commentMain addSubview:Attachment];
     
     UILabel *Attachment_txt=[[UILabel alloc]initWithFrame:CGRectMake(Attachment.frame.size.width+Attachment.frame.origin.x, Subindustry.frame.size.height+Subindustry.frame.origin.y+5,  commentMain.frame.size.width, 20)];
     Attachment_txt.text=attachName;
     Attachment_txt.textAlignment=NSTextAlignmentLeft;
     Attachment_txt.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
     Attachment_txt.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
     [commentMain addSubview:Attachment_txt];

    UIImageView *imgAttachment=[[UIImageView alloc] initWithFrame:CGRectMake(commentMain.frame.size.width-35, Subindustry.frame.size.height+Subindustry.frame.origin.y+5, 30, 30)];
    [imgAttachment setImage:[UIImage imageNamed:@"attachment.png"]];
    if (![attachName isEqualToString:@"No Attachments"]) {
        [commentMain addSubview:imgAttachment];
        UIButton *attachBtn=[[UIButton alloc] initWithFrame:CGRectMake(commentMain.frame.size.width-35, Subindustry.frame.size.height+Subindustry.frame.origin.y+5, 30, 30)];
        attachBtn.imageView.image = nil;
        attachBtn.titleLabel.text = nil;
        [attachBtn addTarget:self action:@selector(jobAttachmentViewer:) forControlEvents:UIControlEventTouchUpInside];
        [commentMain addSubview:attachBtn];
    }

    
    UILabel *gap1=[[UILabel alloc]initWithFrame:CGRectMake(0,imgAttachment.frame.size.height+imgAttachment.frame.origin.y+10,prMainView.frame.size.width, 1)];
    gap1.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [commentMain addSubview:gap1];
    
    UILabel *descript1=[[UILabel alloc]initWithFrame:CGRectMake(10,gap1.frame.size.height+gap1.frame.origin.y+5, commentMain.frame.size.width-10, 30)];
    descript1.text=@"About Company :";
    descript1.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    descript1.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [commentMain addSubview:descript1];

    
    UITextView *descript=[[UITextView alloc] initWithFrame:CGRectMake(5,descript1.frame.size.height+descript1.frame.origin.y+5, commentMain.frame.size.width-10, 120)];
    descript.text=[NSString stringWithFormat:@"%@",about];
    descript.textAlignment=NSTextAlignmentLeft;
    descript.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
    descript.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    descript.backgroundColor=[UIColor clearColor];
    descript.editable=NO;
    descript.scrollEnabled=YES;
    [descript sizeToFit];
    [commentMain addSubview:descript];
    
    apply=[[UIButton alloc]initWithFrame:CGRectMake(30, descript.frame.size.height+descript.frame.origin.y+10, commentMain.frame.size.width-60, 35)];
    [apply setTitle: @"Apply" forState: UIControlStateNormal];
    apply.userInteractionEnabled=YES;
    [apply setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    apply.backgroundColor=[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    apply.layer.cornerRadius=5;
    apply.clipsToBounds=YES;
    [apply setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if(whichto==0||whichto==1)
    {
         apply.hidden=true;
    }
    if(whichto==4)
    {
        if([[SavePrefrences sharedInstance].uid intValue]==[juid intValue])
        {
            apply.hidden=true;
        }
        else
        {
            apply.tag=[job_id intValue];
            [apply setClipsToBounds:YES];
            if(status==nil||status==NULL||[status isEqual:[NSNull null]]||status == (id)[NSNull null])
            {
                apply.hidden=false;
                [apply addTarget:self action:@selector(applyProject:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if([status intValue]==0)
            {
                apply.hidden=false;
                [apply addTarget:self action:@selector(applyProject:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if([status intValue]==1)
            {
                apply.hidden=true;
                apply.backgroundColor=[UIColor clearColor];
                apply.userInteractionEnabled=NO;
                
            }
            
            else if([status intValue]==2)
            {
                apply.hidden=false;
                apply.backgroundColor=[UIColor clearColor];
                apply.userInteractionEnabled=NO;
            }
            
        }

    }
    [commentMain addSubview:apply];
    commentMain.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, descript.frame.size.height+descript.frame.origin.y+150);

    
    tableViewPoPosted = [[UITableView alloc] initWithFrame:CGRectMake(5, descript.frame.size.height+descript.frame.origin.y+20,commentMain.frame.size.width-10, 200)];
    tableViewPoPosted.delegate = self;
    tableViewPoPosted.dataSource = self;
    tableViewPoPosted.scrollEnabled = YES;
    tableViewPoPosted.backgroundColor=[UIColor clearColor];
    tableViewPoPosted.separatorColor=[UIColor clearColor];
    [commentMain addSubview:tableViewPoPosted];
    
    tableViewPoPosted.hidden=true;
    if(whichto==3)
    {
        tableViewPoPosted.hidden=false;
        apply.hidden=true;

        commentMain.contentSize=CGSizeMake([SavePrefrences sharedInstance].screenWidth-20, tableViewPoPosted.frame.size.height+tableViewPoPosted.frame.origin.y+150);

    }

    [tableViewPoPosted performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
   // scroll1.contentSize=CGSizeMake(commentMain.frame.size.width,tableViewPoPosted.frame.size.height+tableViewPoPosted.frame.origin.y+20);


}

#pragma mark tableView

-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section{
    return jobApplicants.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 100;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *pdp=[SavePrefrences sharedInstance].colorDictionry;
    
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.tableViewPoPosted dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.clipsToBounds=YES;
    
    //130:197:246
    UIView *cell_View=[[UIView alloc] initWithFrame:CGRectMake(5, 5, tableViewPoPosted.frame.size.width-10, 90)];
    cell_View.backgroundColor=[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:0.3f];
    cell_View.layer.borderWidth=1;
    cell_View.layer.borderColor=[[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f] CGColor];
    [cell addSubview: cell_View];

    if(theTableView==tableViewPoPosted)
    {
        NSDictionary* applicant = jobApplicants[indexPath.row];
       UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, cell_View.frame.size.height/2-25, 50, 50)];
        userpic.backgroundColor=[UIColor grayColor];
        userpic.layer.cornerRadius=25;
        userpic.clipsToBounds=YES;
        [cell_View addSubview:userpic];
        
        
        NSString * url=[manag concatUrl:applicant[@"img"]];
        if(url.length<12)
        {
            userpic.image = [UIImage imageNamed:@"username.png"];
        }
        else
        {
            [userpic sd_setImageWithURL:[NSURL URLWithString:url]];
        }
        
        UIButton* profileBtn = [[UIButton alloc] initWithFrame:userpic.frame];
        profileBtn.imageView.image = nil;
        profileBtn.titleLabel.text = nil;
        profileBtn.tag = indexPath.row;
        [profileBtn addTarget:self action:@selector(profileBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell_View addSubview:profileBtn];
        
        UILabel *uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10, 5,cell_View.frame.size.width, 30)];
        uname_lbl.textColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];
        uname_lbl.backgroundColor=[UIColor clearColor];
        [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        uname_lbl.text=applicant[@"uname"];
        [cell_View addSubview: uname_lbl];
        
        
        UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-50, 5 ,30 ,30)];
        NSString* accptImgName;
        if ([applicant[@"status"] boolValue]) {
            accptImgName = @"accpetedJob.png";
        }else accptImgName = @"accept1.png";
        
        isonimg.image = [UIImage imageNamed:accptImgName];
        isonimg.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:isonimg];
        
        UIButton* acceptApplicant = [[UIButton alloc] initWithFrame:isonimg.frame];
        acceptApplicant.imageView.image = nil;
        acceptApplicant.titleLabel.text = nil;
        acceptApplicant.tag = indexPath.row;
        [acceptApplicant addTarget:self action:@selector(acceptApplicantBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell_View addSubview:acceptApplicant];
        
        
        UIImageView *imgCal =[[UIImageView alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+15, uname_lbl.frame.size.height+uname_lbl.frame.origin.y+8 ,30 ,30)];
        imgCal.image = [UIImage imageNamed:@"calendaricn.png"];
        imgCal.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:imgCal];
        
        UIButton* calBtn = [[UIButton alloc] initWithFrame:imgCal.frame];
        calBtn.imageView.image = nil;
        calBtn.titleLabel.text = nil;
        calBtn.tag = indexPath.row;
        [calBtn addTarget:self action:@selector(calendarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell_View addSubview:calBtn];
        
        UIImageView *imgUser =[[UIImageView alloc]initWithFrame:CGRectMake(imgCal.frame.size.width+imgCal.frame.origin.x+10, uname_lbl.frame.size.height+uname_lbl.frame.origin.y+5 ,30 ,30)];
        imgUser.image = [UIImage imageNamed:@"advance-search.png"];
        imgUser.backgroundColor=[UIColor clearColor];
        [cell_View addSubview:imgUser];
        
        UIButton* proCallBtn = [[UIButton alloc] initWithFrame:imgUser.frame];
        proCallBtn.imageView.image = nil;
        proCallBtn.titleLabel.text = nil;
        proCallBtn.tag = indexPath.row;
        [proCallBtn addTarget:self action:@selector(profileBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell_View addSubview:proCallBtn];
        

//        UIImageView *imgCam =[[UIImageView alloc]initWithFrame:CGRectMake(imgUser.frame.size.width+imgUser.frame.origin.x+10, uname_lbl.frame.size.height+uname_lbl.frame.origin.y+8 ,30 ,27)];
//        imgCam.image = [UIImage imageNamed:@"chatvideoNew.png"];
//        imgCam.backgroundColor=[UIColor clearColor];
//        [cell_View addSubview:imgCam];
        
//        UIButton* vidCallBtn = [[UIButton alloc] initWithFrame:imgCam.frame];
//        vidCallBtn.imageView.image = nil;
//        vidCallBtn.titleLabel.text = nil;
//        vidCallBtn.tag = indexPath.row;
//        [vidCallBtn addTarget:self action:@selector(videoCallBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell_View addSubview:vidCallBtn];
 
        NSString* attachment = applicant[@"attach"];
        if ([attachment length]) {
            UIImageView *imgDown =[[UIImageView alloc]initWithFrame:CGRectMake(imgUser.frame.size.width+imgUser.frame.origin.x+10, uname_lbl.frame.size.height+uname_lbl.frame.origin.y+8 ,30 ,27)];
            imgDown.image = [UIImage imageNamed:@"resume_download.png"];
            imgDown.backgroundColor=[UIColor clearColor];
            [cell_View addSubview:imgDown];
            
            UIButton* downloadBtn = [[UIButton alloc] initWithFrame:imgDown.frame];
            downloadBtn.imageView.image = nil;
            downloadBtn.titleLabel.text = nil;
            downloadBtn.tag = indexPath.row;
            [downloadBtn addTarget:self action:@selector(downloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell_View addSubview:downloadBtn];
        }

        return cell;
    }
    return cell;
    
}

-(IBAction)calendarBtnAction:(id)sender{
    NSLog(@"GO TO CALENDAR");
}

-(IBAction)profileBtnAction:(id)sender{
    NSLog(@"GO TO Profile");
    UIButton* btn = (UIButton*)sender;
    NSDictionary* person = jobApplicants[btn.tag];
    
    iscallback=109;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:person[@"u_id"] forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Profile":@"showProfile" :@"":@"":dic1 :self];
//    LeftRightDrawer* drawer = [[LeftRightDrawer alloc] init];
//    [drawer openfriendprofile:person[@"u_id"]];
}

-(IBAction)videoCallBtnAction:(id)sender{
    NSLog(@"GO TO Video Call");
}

-(IBAction)jobAttachmentViewer:(id)sender{
    NSString *attachUrl=[[jobdetail objectAtIndex:0]valueForKey:@"attach"];
    NSURL *remoteURL = [NSURL URLWithString:[manag concatUrl:attachUrl]];
    AMPPreviewController *pc = [[AMPPreviewController alloc]
                                initWithRemoteFile:remoteURL];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController presentViewController:pc animated:YES completion:nil];
}

-(IBAction)downloadBtnAction:(id)sender{
    NSLog(@"GO TO DOWNLOAD");
    UIButton* btn = (UIButton*)sender;
    NSDictionary* applicant = jobApplicants[btn.tag];
    NSString * url=[manag concatUrl:applicant[@"attach"]];
    NSURL *remoteURL = [NSURL URLWithString:url];
    AMPPreviewController *pc = [[AMPPreviewController alloc]
                                initWithRemoteFile:remoteURL];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController presentViewController:pc animated:YES completion:nil];
}

-(IBAction)acceptApplicantBtnAction:(id)sender{
    NSLog(@"GO TO ACCEPT APPLICATION");
    UIButton* btn = (UIButton*)sender;
    iscallback=108;
    NSDictionary* applicant = jobApplicants[btn.tag];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSDictionary* theJob = jobdetail[0];
    [dic setValue:theJob[@"job_id"] forKey:@"jid"];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setValue:applicant[@"u_id"] forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"accept" :@"" :@"" :dic :self ];
    
    
    /*
    NSURL *remoteURL = [NSURL URLWithString:@"http://www.planwallpaper.com/static/images/desktop-year-of-the-tiger-images-wallpaper.jpg"];
    AMPPreviewController *pc = [[AMPPreviewController alloc]
                                initWithRemoteFile:remoteURL];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController presentViewController:pc animated:YES completion:nil];
     */
}

-(IBAction)applyProject:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    [self applyJob:vc1 :(int)btn.tag];
    
}
-(void)applyJob:(UIViewController*)Vc:(int)checkjob
{
    
    chkdesc=1;
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    [self MainView:Vc :@"Apply Job"];
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y-20,scrollbar.frame.size.width, 300 );
    UILabel *type_msg=[[UILabel alloc]initWithFrame:CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y-90, scrollbar.frame.size.width-40, 35)];
    type_msg.text=@"Type Your Message Here";
    [type_msg setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    type_msg.textColor=[UIColor blackColor];
    [scrollbar addSubview:type_msg];
    
    
    Message=[[UITextView alloc]initWithFrame:CGRectMake(20, type_msg.frame.size.height+type_msg.frame.origin.y+10, scrollbar.frame.size.width-40, 80)];
    Message.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
   // Message.layer.borderWidth=2;
    [Message setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
   // Message.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1] CGColor];
    Message.delegate=self;
    [scrollbar addSubview:Message];
    
    
    UIButton *attach=[[UIButton alloc]initWithFrame:CGRectMake(20, Message.frame.size.height+Message.frame.origin.y+10, 80, 40)];
    attach.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [attach setTitle:@"Attach" forState:UIControlStateNormal];
    [attach setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [attach setTitleColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [attach addTarget:self action:@selector(attachFile:) forControlEvents:UIControlEventTouchUpInside];
    [attach setClipsToBounds:YES];
    [scrollbar addSubview:attach];
    
    
    filename=[[UILabel alloc]initWithFrame:CGRectMake(attach.frame.size.width+30, Message.frame.size.height+Message.frame.origin.y+10, 160, 25)];
    filename.textColor=[UIColor blackColor];
    [scrollbar addSubview:filename];
    
    
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake(15, attach.frame.size.height+attach.frame.origin.y+10, 150, 30)];
    submit.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [submit setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitJobMessage:) forControlEvents:UIControlEventTouchUpInside];
    submit.tag=checkjob;
    [submit setClipsToBounds:YES];
    [scrollbar addSubview:submit];
    
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake(submit.frame.size.width+submit.frame.origin.x+5,attach.frame.size.height+attach.frame.origin.y+10, 150, 30);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f]forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel1:) forControlEvents:UIControlEventTouchUpInside];
    close.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [scrollbar addSubview:close];
    
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width,scrollbar.frame.size.height-500);
}


-(IBAction)attachVideo:(id)sender
{
    
    NSLog(@"Video upload");
}

-(IBAction)submitJobMessage:(id)sender
{
    if(Message.text.length>0)
    {
    UIButton *btn=(UIButton*)sender;
    iscallback=18;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"jobid"];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:Message.text forKey:@"comment"];
    
    if(imgBuffer.length>100)
    {
        [dic setValue:randomImgName forKey:@"attach"];
        [dic setValue:imgBuffer forKey:@"buffer1"];
    }
        [[SavePrefrences sharedInstance].skthand emitData:@"AllProjects" :@"applyJobs" :@"" :@"" :dic :self ];
    
    imgBuffer=@"";
    }
    else{
     UIAlertView   *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Comment First" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(void)OpenJobDetails:(UIViewController*)Vc:(int)whichjob:(NSString*)uid:(int)checktab
{
    whichto=checktab;
    iscallback=5;
    vc1=Vc;
    juid=uid;
    NSLog(@"value of job id is %d",checktab);
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:uid forKey:@"id"];
    [dic1 setObject:[NSString stringWithFormat:@"%d",whichjob] forKey:@"jid"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"getApplicants" :@"":@"":dic1 :self];
    
    
}

-(void)ChangeStatus:(UIViewController*)Vc:(int)JobId:(NSString *)status
{
    NSMutableDictionary *bt=[SavePrefrences sharedInstance].colorDictionry;
    
    if([status isEqual:@"Open"])
    {
        stas=0;
    }
    else if([status isEqual:@"Completed"])
    {
        stas=2;
    }
    else
    {
        stas=1;
    }
    
    jobId=JobId;
    [self MainView:Vc :@"Change Status"];
    
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y-20, scrollbar.frame.size.width, 150 );

    open=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, scrollbar.frame.size.width-20, 35)];
    open.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    open.textColor=[bt valueForKey:@"Scrollcolor"];
    open.text=[NSString stringWithFormat:@"  %@", status];
    [ open setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    open.clipsToBounds=YES;
    [scrollbar addSubview: open];
    
    
    UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showstatus)];
    [ind setNumberOfTouchesRequired:1];
    [ind setDelegate:self];
    open.userInteractionEnabled = YES;
    [open addGestureRecognizer:ind];
    
    
    
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame=CGRectMake(35,open.frame.size.height+open.frame.origin.y+20, scrollbar.frame.size.width/2 -40, 35);
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [submit setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(SubmitStatus:)forControlEvents:UIControlEventTouchUpInside];
    
    submit.backgroundColor=[bt valueForKey:@"Yellowbtncolor"];
    [scrollbar addSubview:submit];
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake(submit.frame.size.width+submit.frame.origin.x+10,open.frame.size.height+open.frame.origin.y+20, scrollbar.frame.size.width/2 -40, 35);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel1:) forControlEvents:UIControlEventTouchUpInside];
    close.backgroundColor=[bt valueForKey:@"Yellowbtncolor"];
    
    [scrollbar addSubview:close];
    scrollbar.scrollEnabled=NO;
   // scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, 100);
}

-(void)editJobdeatils:(UIViewController*)Vc:(int)jId
{
    
    vc1=Vc;
    jobId=jId;
    iscallback=9;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",jobId] forKey:@"jid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"upJob" :@"":@"":dic1 :self];
    
    
}



-(void)ShowJobDetail
{
    
    chkdesc=0;
    
    NSMutableDictionary *bt=[SavePrefrences sharedInstance].colorDictionry;
    
    scrollbar.frame =CGRectMake(20, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+100));
    
    isEdit=@"cc";
    NSString *title=[[jobDetailAr objectAtIndex:0]valueForKey:@"title"];
    NSString *duration=[[jobDetailAr objectAtIndex:0]valueForKey:@"duration"];
    NSString *ilocation=[[jobDetailAr objectAtIndex:0]valueForKey:@"location"];
    NSString *qualification=[[jobDetailAr objectAtIndex:0]valueForKey:@"qualification"];
    NSString *industry_name=[[jobDetailAr objectAtIndex:0]valueForKey:@"i_id"];
    NSString *topic_name=[[jobDetailAr objectAtIndex:0]valueForKey:@"t_id"];
    NSString *job_desc=[[jobDetailAr objectAtIndex:0]valueForKey:@"job_desc"];
    NSString *job_id=[[jobDetailAr objectAtIndex:0]valueForKey:@"job_id"];
    NSString *icountry=[[jobDetailAr objectAtIndex:0]valueForKey:@"country"];
    NSString *icity=[[jobDetailAr objectAtIndex:0]valueForKey:@"city"];
    NSString *istate=[[jobDetailAr objectAtIndex:0]valueForKey:@"state"];
    
    for(int x=0; x<[dataind count];x++)
    {
        if([[[dataind valueForKey:@"i_id"]objectAtIndex:x] isEqual:industry_name])
        {
            indid=[[dataind valueForKey:@"i_id"]objectAtIndex:x];
            industry_name=[[dataind valueForKey:@"industry_name"]objectAtIndex:x];
            break;
            
        }
    }
    
    for(int x=0; x<[subdataind count];x++)
    {
        if([[[subdataind valueForKey:@"t_id"]objectAtIndex:x] isEqual:topic_name])
        {
            subid=[[subdataind valueForKey:@"t_id"]objectAtIndex:x];
            topic_name=[[subdataind valueForKey:@"topic_name"]objectAtIndex:x];
            break;
            
        }
    }
    
    [self MainView:vc1 :@"Edit Job Details"];
    
    title_lbl =[[UITextField alloc]initWithFrame:CGRectMake(10, 5, scrollbar.frame.size.width-20,35)];
    title_lbl.text=Title;
    title_lbl.placeholder = @"Title";
    title_lbl.backgroundColor=[UIColor whiteColor];
    title_lbl.textColor=[bt valueForKey:@"Scrollcolor"];
    title_lbl.delegate=self;
    [title_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    title_lbl.leftView = paddingView1;
    title_lbl.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [scrollbar addSubview:title_lbl];
    
    qualReq=[[UITextField alloc]initWithFrame:CGRectMake(10, title_lbl.frame.size.height+title_lbl.frame.origin.y+10, scrollbar.frame.size.width-20,35)];
    qualReq.text=qualification;
    qualReq.placeholder=@"Qualification Required";
    qualReq.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    qualReq.textColor=[bt valueForKey:@"Scrollcolor"];
    qualReq.delegate=self;
    [qualReq setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    qualReq.leftView = paddingView2;
    qualReq.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [scrollbar addSubview:qualReq];
    
    duration_lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, qualReq.frame.size.height+qualReq.frame.origin.y+10, scrollbar.frame.size.width-20,35)];
    duration_lbl.text=@"  Select Duration";
    duration_lbl.textColor=[bt valueForKey:@"Scrollcolor"];
    duration_lbl.text=[NSString stringWithFormat:@"  %@", duration];
    [duration_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    duration_lbl.clipsToBounds=YES;
    duration_lbl.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [scrollbar addSubview:duration_lbl];
    
    
    
    UITapGestureRecognizer *ind1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDuration:)];
    [ind1 setNumberOfTouchesRequired:1];
    [ind1 setDelegate:self];
    duration_lbl.userInteractionEnabled = YES;
    [duration_lbl addGestureRecognizer:ind1];
    
    
    country=[[UILabel alloc] initWithFrame:CGRectMake(10, duration_lbl.frame.size.height+duration_lbl.frame.origin.y+10, scrollbar.frame.size.width-20, 35)];
    //country.text=@"  Select Country";
    country.text=[NSString stringWithFormat:@"  %@",icountry];
    country.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    country.textColor=[bt valueForKey:@"Scrollcolor"];
    [country setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    country.clipsToBounds=YES;
    [scrollbar addSubview:country];
    
    UITapGestureRecognizer *countryreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countrySel:)];
    [countryreg setNumberOfTouchesRequired:1];
    [countryreg setDelegate:self];
    country.userInteractionEnabled = YES;
    [country addGestureRecognizer:countryreg];
    
    sate=[[UILabel alloc] initWithFrame:CGRectMake(10, country.frame.size.height+country.frame.origin.y+10, scrollbar.frame.size.width-20, 35)];
   
    sate.text=[NSString stringWithFormat:@"  %@",istate];
    sate.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    sate.textColor=[bt valueForKey:@"Scrollcolor"];
    [sate setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    sate.clipsToBounds=YES;
    [scrollbar addSubview:sate];
    
    UITapGestureRecognizer *satereg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateSel:)];
    [satereg setNumberOfTouchesRequired:1];
    [satereg setDelegate:self];
    sate.userInteractionEnabled = YES;
    [sate addGestureRecognizer:satereg];
    
    
    city=[[UILabel alloc] initWithFrame:CGRectMake(10, sate.frame.size.height+sate.frame.origin.y+10, scrollbar.frame.size.width-20, 35)];
    city.text=[NSString stringWithFormat:@"  %@",icity];
    city.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    city.textColor=[bt valueForKey:@"Scrollcolor"];
    [city setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    city.clipsToBounds=YES;
    [scrollbar addSubview:city];
    
    UITapGestureRecognizer *cityreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySel:)];
    [cityreg setNumberOfTouchesRequired:1];
    [cityreg setDelegate:self];
    city.userInteractionEnabled = YES;
    [city addGestureRecognizer:cityreg];
    
    location=[[UITextField alloc]initWithFrame:CGRectMake(10, city.frame.size.height+city.frame.origin.y+10, scrollbar.frame.size.width-20,35)];
    location.placeholder=@"Location";
    location.text=ilocation;
    location.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    location.textColor=[bt valueForKey:@"Scrollcolor"];
    location.delegate=self;
    [location setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    ///////////
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    location.leftView = paddingView3;
    location.leftViewMode = UITextFieldViewModeAlways;
    ///////////

    [scrollbar addSubview:location];

    Select_Industry=[[UILabel alloc]initWithFrame:CGRectMake(10,location.frame.size.height+location.frame.origin.y+10, scrollbar.frame.size.width-20, 35)];
    
    Select_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Select_Industry.textColor=[bt valueForKey:@"Scrollcolor"];
    
    if([indid isEqual: NULL] || [indid intValue]==0)
    {
     Select_Industry.text=@"  Select Industry";
    }
    else{
        Select_Industry.text=[NSString stringWithFormat:@"  %@", industry_name];
    }
    
   
    [Select_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Industry.clipsToBounds=YES;
    [scrollbar addSubview:Select_Industry];
    
    UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectInduct)];
    [ind setNumberOfTouchesRequired:1];
    [ind setDelegate:self];
    Select_Industry.userInteractionEnabled = YES;
    [Select_Industry addGestureRecognizer:ind];
    
    
    Select_Sub_Industry=[[UILabel alloc]initWithFrame:CGRectMake(10,Select_Industry.frame.size.height+Select_Industry.frame.origin.y+10, scrollbar.frame.size.width-20,35)];
    Select_Sub_Industry.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    Select_Sub_Industry.textColor=[bt valueForKey:@"Scrollcolor"];
    if([indid isEqual: NULL] || [indid intValue]==0)
    {
        Select_Sub_Industry.text=@"  Select Sub Industry";

    }
    else
    {
    Select_Sub_Industry.text=[NSString stringWithFormat:@"  %@",topic_name];
    }
        [ Select_Sub_Industry setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    Select_Sub_Industry.clipsToBounds=YES;
    [scrollbar addSubview: Select_Sub_Industry];
    
    
    UITapGestureRecognizer *ind2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selecSubInd)];
    [ind2 setNumberOfTouchesRequired:1];
    [ind2 setDelegate:self];
    Select_Sub_Industry.userInteractionEnabled = YES;
    [Select_Sub_Industry addGestureRecognizer:ind2];
    
    jdesc=[[UILabel alloc]initWithFrame:CGRectMake(10, Select_Sub_Industry.frame.size.height+Select_Sub_Industry.frame.origin.y+10, scrollbar.frame.size.width-20, 20)];
    jdesc.text=@"Job Description";
    [jdesc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    jdesc.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    jdesc.backgroundColor=[UIColor clearColor];
    [scrollbar addSubview:jdesc];
    
    UIView *ViewJobdesc=[[UIView alloc]initWithFrame:CGRectMake(10, jdesc.frame.size.height+jdesc.frame.origin.y+5, scrollbar.frame.size.width-20, 60)];
    ViewJobdesc.backgroundColor=[UIColor colorWithRed:248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    [scrollbar addSubview:ViewJobdesc];
    
    jobdesc=[[UITextView alloc]initWithFrame:CGRectMake(5, 5, scrollbar.frame.size.width-20, 50)];
    jobdesc.text=job_desc;
    [jobdesc setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    jobdesc.backgroundColor=[UIColor clearColor];
    jobdesc.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    jobdesc.delegate=self;
    [ViewJobdesc addSubview:jobdesc];
    
    UIButton *attach=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    attach.frame=CGRectMake( 10,ViewJobdesc.frame.size.height+ViewJobdesc.frame.origin.y+10, 80, 40);
    [attach setTitle:@" Attach File " forState:UIControlStateNormal];
    [attach setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [attach setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [attach addTarget:self action:@selector(attachFile:) forControlEvents:UIControlEventTouchUpInside];
    attach.backgroundColor=[bt valueForKey:@"Yellowbtncolor"];
    [scrollbar addSubview:attach];
    
    filename=[[UILabel alloc]initWithFrame:CGRectMake(attach.frame.size.width+30, ViewJobdesc.frame.size.height+ViewJobdesc.frame.origin.y+10, 160, 25)];
    filename.textColor=[UIColor blackColor];
    [scrollbar addSubview:filename];
    
    
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame=CGRectMake(35,attach.frame.size.height+attach.frame.origin.y+15, scrollbar.frame.size.width/2 -40, 35);
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [submit setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(SubmitJobDetail:)forControlEvents:UIControlEventTouchUpInside];
    
    submit.backgroundColor=[bt valueForKey:@"Yellowbtncolor"];
    [scrollbar addSubview:submit];
    
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake(submit.frame.size.width+submit.frame.origin.x+5,attach.frame.size.height+attach.frame.origin.y+15,  scrollbar.frame.size.width/2 -40, 35);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel1:) forControlEvents:UIControlEventTouchUpInside];
    close.backgroundColor=[bt valueForKey:@"Yellowbtncolor"];
    
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, close.frame.size.height+close.frame.origin.y+20);
    
    
}

-(IBAction)SubmitJobDetail:(id)sender
{
    NSLog(@"am clicked ");
    iscallback=20;
    if([av checkNull:title_lbl]&&[av checkNull:qualReq]&&[av checkNull:location])
    {
        if([av checkCombo:country]&&[av checkCombo:duration_lbl]&&[av checkCombo:sate]&&[av checkCombo:city]&&[av checkCombo:Select_Industry]&&[av checkCombo:Select_Sub_Industry])
        {
            NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
            [dic1 setObject:[NSString stringWithFormat:@"%d",jobId] forKey:@"jid"];
            [dic1 setObject:title_lbl.text forKey:@"title"];
            [dic1 setObject:qualReq.text forKey:@"qua"];
            [dic1 setObject:duration_lbl.text forKey:@"dur"];
            [dic1 setObject:location.text forKey:@"loc"];
            [dic1 setObject:jobdesc.text forKey:@"desc"];
            [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
            //
            [dic1 setObject:[NSString stringWithFormat:@"%@",indid] forKey:@"i_id"];
            [dic1 setObject:[NSString stringWithFormat:@"%@",subid] forKey:@"t_id"];
            if([isEdit isEqual:@"cc"])
            {
                [dic1 setObject:@"cc" forKey:@"k"];
            }
            else
            {
                [dic1 setObject:country.text forKey:@"cont"];
                [dic1 setObject:sate.text forKey:@"state"];
                [dic1 setObject:city.text forKey:@"city"];
                [dic1 setObject:@"pp" forKey:@"k"];
                
            }
            
            if(imgBuffer.length>100)
            {
                [dic1 setObject:randomImgName forKey:@"att"];
                [dic1 setObject:imgBuffer forKey:@"buffer1"];

            }
            
            
            [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"updateJob" :@"":@"":dic1 :self];
            [prMainView removeFromSuperview];
            imgBuffer=@"";
        }
        
     }
}

-(void)showstatus
  {
    NSMutableArray *statusAr=[[NSMutableArray alloc]init];
  if(stas==0)
  {
    [statusAr addObject:@"Open"];
    [statusAr addObject:@"Work In Progress"];
    [statusAr addObject:@"Completed"];
  }
  else if(stas==1)
  {
      [statusAr addObject:@"Work In Progress"];
      [statusAr addObject:@"Completed"];
  }
  else if(stas==2)
  {
      [statusAr addObject:@"Completed"];
  }
      
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"PROYOLK"message:@"Select Status:"preferredStyle:UIAlertControllerStyleActionSheet];
    for(int x=0;x<[statusAr count];x++)
    {
        NSString *statusname=[statusAr objectAtIndex:x];
        
        
        
        UIAlertAction *drivingAction = [UIAlertAction actionWithTitle:statusname style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            NSString * tile= [action title];
                                            selstatus=x;
                                            open.text=statusname;
                                        }];
        [alert addAction:drivingAction];
    }
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:defaultAction];
    [vc1 presentViewController:alert animated:YES completion:nil];
    
 }

-(IBAction)SubmitStatus:(id)sender
{
    iscallback=4;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",jobId] forKey:@"jid"];
    [dic1 setObject:[NSString stringWithFormat:@"%d",selstatus] forKey:@"val"];
    [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"chngstatus" :@"":@"":dic1 :self];
    
}

-(IBAction)advanceSearchDetails:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    int whichtab=(int)btn.tag;
    

    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    
    
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    if ([duration_lbl.text isEqual:@"  Select Duration"])
    {
        [dic1 setObject:@"" forKey:@"dur"];
    }
    else
    {
     [dic1 setObject:duration_lbl.text forKey:@"dur"];
    }
    
    [dic1 setObject:location.text forKey:@"loc"];
    [dic1 setObject: Posted_On.text forKey:@"postedon"];
    [dic1 setObject:Board_Posted_By.text forKey:@"postedby"];
    [dic1 setObject:Title.text forKey:@"key"];
    if([isselect isEqual:@"selected"])
    {
        [dic1 setObject:indid forKey:@"ind"];
        [dic1 setObject: subid forKey:@"top"];
    }
    else{
        [dic1 setObject:@"" forKey:@"ind"];
        [dic1 setObject: @"" forKey:@"top"];
    }
    
      
    if(location.text==NULL || Posted_On.text==NULL || [duration_lbl.text isEqual:@""] || Board_Posted_By.text == NULL || Title.text==NULL)
    {
    
        isempty=1;
    }
    else
    {
        isempty=0;
    }
    
    [dic1 setObject:[self getSortKey] forKey:@"val"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JOB_ADVANCE_SEARCH" object:nil userInfo:dic1];
    [self dissmisspop];
    
    
    
   
    
}

- (NSString*)getSortKey{
    NSString* sortKey = [[NSUserDefaults standardUserDefaults] valueForKey:@"JOB_SORT_KEY"];
    if (!sortKey.length) sortKey = @"1";
    return sortKey;
}

-(void)sortby:(UIViewController*)Vc:(int)sortID
{
    [self MainView:Vc :@"Sort By"];
    sortidis=sortID;
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    scrollbar.frame = CGRectMake(scrollbar.frame.origin.x, scrollbar.frame.origin.y,scrollbar.frame.size.width, 120 );
    NSMutableArray *sortAr=[[NSMutableArray alloc]init];
    [sortAr addObject:@"Title"];
    [sortAr addObject:@"UserName"];
    [sortAr addObject:@"Status"];
    
   /* int hy=NameLabel.frame.size.height+NameLabel.frame.origin.y-90;
    for(int x=0;x<[sortAr count];x++ )
    {
        UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(10,hy+5, 15,  15)];
        img.layer.cornerRadius=7.5;
        [img addTarget:self action:@selector(SelectSort:) forControlEvents: UIControlEventTouchUpInside];
        [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        if(x==(issort-1))
        {
            sender1=img;
            [img setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        img.tag=x;
        [scrollbar addSubview:img];
        comment_lbl=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+5, hy, 150, 25)];
        [comment_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
        comment_lbl.textColor=[UIColor blackColor];
        comment_lbl.text=[sortAr objectAtIndex: x];
        [scrollbar addSubview:comment_lbl];
        hy=hy+50;
        
    }*/
    int hy=scrollbar.frame.size.width+scrollbar.frame.origin.x-350;
    for(int x=0;x<[sortAr count];x++ )
    {
        
        UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(hy+10, 8, NameLabel.frame.size.width/3, 30)];
        descriptionView.backgroundColor=[UIColor clearColor];
        [scrollbar addSubview:descriptionView];
        
        UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(0,5, 15,  15)];
        img.layer.cornerRadius=7.5;
        [img addTarget:self action:@selector(SelectSort:) forControlEvents: UIControlEventTouchUpInside];
        [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        if(x==(issort-1))
        {
            sender1=img;
            [img setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
        }
        img.tag=x;
        [descriptionView addSubview:img];
        
        
        comment_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 25)];
        [comment_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        comment_lbl.textColor=[UIColor colorWithRed:183.0f/255.0f green:182.0f/255.0f blue:182.0f/255.0f alpha:1.0f];
        comment_lbl.text=[sortAr objectAtIndex: x];
        [descriptionView addSubview:comment_lbl];
        
        hy=hy+100;
        
    }

    
    int w=scrollbar.frame.size.width;
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake(w/2-w/4, comment_lbl.frame.size.height+comment_lbl.frame.origin.y+20, 80, 35)];
    [submit setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    submit.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitSortby:) forControlEvents:UIControlEventTouchUpInside];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    submit.tag=sortID;
    [submit setClipsToBounds:YES];
    [scrollbar addSubview:submit];
    
    
   // UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
   // close.frame=CGRectMake(submit.frame.size.width+submit.frame.origin.x+5,comment_lbl.frame.size.height+comment_lbl.frame.origin.y+15, scrollbar.frame.size.width/2 -40, 35);
    UIButton *close=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    close.frame=CGRectMake(submit.frame.size.width+submit.frame.origin.x+15,comment_lbl.frame.size.height+comment_lbl.frame.origin.y+20, 80, 35);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:46.0f/255.0f blue:99.0f/255.0f alpha:1.0f]forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel1:) forControlEvents:UIControlEventTouchUpInside];
    close.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [scrollbar addSubview:close];
    
    scrollbar.contentSize=CGSizeMake(scrollbar.frame.size.width, 300);
}

-(IBAction)SelectSort:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    issort=(int)btn.tag;
    
    if(issort==0||issort==1||issort==2)
    {
        [sender1 setImage:[UIImage imageNamed:@"radiounselect.png"]forState:UIControlStateNormal];
        sender1=sender;
        [sender setImage:[UIImage imageNamed:@"radioselect.png"]forState:UIControlStateNormal];
    }
}

-(IBAction)submitSortby:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    
    if(issort==0)
    {
        issort=1;
    }
    else if(issort==1)
    {
        issort=2;
    }
    else if(issort==2)
    {
        issort=3;
    }
    
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", issort] forKey:@"JOB_SORT_KEY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JOB_SORT_CHANGE" object:nil];
    [self dissmisspop];
    return;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic1 setObject:[NSString stringWithFormat:@"%d",issort] forKey:@"val"];
    
    if(sortidis==0)//awarded job
    {
        iscallback=0;
        [[SavePrefrences sharedInstance].skthand emitData:@"AppliedJobs" :@"getopenJobs" :@"":@"":dic1 :self];
    }
    else if(sortidis==1)//applied job
    {
        iscallback=1;
        [[SavePrefrences sharedInstance].skthand emitData:@"AwardJobs" :@"showAppliedJobs" :@"":@"":dic1 :self];
        
    }
    
    else if(sortidis==3)//posted projects job
    {
        iscallback=12;
        [[SavePrefrences sharedInstance].skthand emitData:@"PostedProject" :@"getJobsPosted" :@"":@"":dic1 :self];
        
    }
    
    else if(sortidis==4)//allprojects job
    {
        iscallback=13;
        [[SavePrefrences sharedInstance].skthand emitData:@"AllProjects" :@"getAllJobs" :@"":@"":dic1 :self];
        
    }
    
    issort=-1;
    
}
-(void)countrySel:(id)sender
{
    if(countryAr !=nil&&[countryAr count]>0)
    {
        [self showCountry];
    }
    else
    {
        iscallback=6;
        SelectCountry * sc=[[SelectCountry alloc]init];
        [sc getCountryList:self];
    }
}

-(void)stateSel:(id)sender
{
    
    iscallback=7;
    SelectCountry * sc=[[SelectCountry alloc]init];
    [sc getState:self:cid];
    
}


-(void)citySel:(id)sender
{
    
    isEdit=@"pp";
    iscallback=8;
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
                                            Select_Industry.text=[NSString stringWithFormat:@"  %@",stname];
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
       NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    if([av checkCombo:Select_Industry])
    {
        isselect=@"selected";
     
        [dic1 setObject:indid forKey:@"inid"];
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
                                            Select_Sub_Industry.text=[NSString stringWithFormat:@"  %@",subname];
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




-(void)dissmisspop{
    int cnt=(int)[popUpAr count]-1;
    NSLog(@"pop ar count===%d",cnt);
    
    if([popUpAr count]>0){
        UIView *ppv=[popUpAr objectAtIndex:cnt] ;
        [ppv removeFromSuperview];
        [popUpAr removeObjectAtIndex:cnt];
    }
    if([popUpAr count]==0){
        id<CallTo_Parent>  cb= vc1;
        [cb callMethod:backData];
    }
}

-(void)dissmisspop1{
 
    int cnt=(int)[popUpAr count]-1;
    NSLog(@"pop ar count===%d",cnt);
    
    if([popUpAr count]>0){
        UIView *ppv=[popUpAr objectAtIndex:cnt] ;
        [ppv removeFromSuperview];
        [popUpAr removeObjectAtIndex:cnt];
    }
    if([popUpAr count]==0)
    {
        id<CallTo_Parent>  cb= vc1;
        [cb callMethod:nil];
    }
    
}
-(IBAction)cancel1:(id)sender
{
    NSLog(@"hello world ");
    apply.userInteractionEnabled=YES;
    [apply setTitle:@"Apply" forState:UIControlStateNormal];
    [self dissmisspop1];
    
}

-(void) callMethod:(NSArray *)meta
{
    
}
-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    NSLog(@"call back in popup====%d",iscallback);
    
    if(iscallback==0)//award job sort
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"awardjobsort"];
        [backData addObject:data];
        [self dissmisspop];
        
    }
    if(iscallback==1)//apply job sort
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"applyjobsort"];
        [backData addObject:data];
        [self dissmisspop];
    }
    
    if(iscallback==2)//select indu
    {
        dataind =data;
        [self showInd];
    }
    
    if(iscallback==3)//select sub
    {
        subdataind=data;
        [self showSubInd];
    }
    if(iscallback==4)//select status
    {
        NSString *affected=[data valueForKey:@"affectedRows"];
        if([affected intValue]>0)
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Successfully Updated" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
            
            backData=[[NSMutableArray alloc]init];
            [backData addObject:@"changestatus"];
            //
            NSMutableArray * n=[[NSMutableArray alloc]init];
            [n addObject:data];
            [backData addObject:data];
            
            [self dissmisspop];
        }
        else
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Not Updated" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    if(iscallback==5)//read more comments
    {
        
        NSLog(@"data of callback====%@",data);
        NSLog(@"meta of callback====%@",meta);
        
        NSArray *jobPart=[meta valueForKey:@"data"];
        jobdetail=[jobPart valueForKey:@"part"];
        jobApplicants=[jobPart valueForKey:@"tut1"];
       if([jobdetail count]>0)
         {
        [self readMoreDetails];
         }
       else{
           UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"No Details Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
           [alrt show];
       }
    }
    if (iscallback==6)//select Counrt
    {
        
        NSLog(@"call back in allpop");
        
        NSArray * md=[meta valueForKey:@"data"];
        countryAr=[md valueForKey:@"country"];
        [self showCountry];
        
    }
    else if(iscallback==7)
    {
        NSArray * md=[meta valueForKey:@"data"];
        stateAr=[md valueForKey:@"statesData"];
        [self showState];
    }
    
    else if(iscallback==8)
    {
        NSArray * md=[meta valueForKey:@"data"];
        cityAr=[md valueForKey:@"statesData"];
        [self showCity];
    }
    else if(iscallback==9)
    {
        jobDetailAr=data;
        iscallback=10;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getInd" :@"":@"":dic1 :self];
    }
    else if(iscallback==10)
    {
        dataind=data;
        iscallback=11;
        
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[jobDetailAr valueForKey:@"i_id"] forKey:@"inid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getDep" :@"":@"":dic1 :self];
    }
    else if(iscallback==11)
    {
        subdataind=data;
        [self ShowJobDetail];
    }
    if(iscallback==12)//posted project  sort
    {
        
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"PostedProjectsort"];
        [backData addObject:data];
        [self dissmisspop];
    }
    if(iscallback==13)//ALl project  sort
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"AllProjectsort"];
        [backData addObject:data];
        [self dissmisspop];
    }
    if(iscallback==14)//award job advnce
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"awardJobAdvnce"];
        [backData addObject:data];
        [backData addObject:[NSString stringWithFormat:@"%d",isempty]];
        [self dissmisspop];
    }
    if(iscallback==15)//applied job advnce
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"AppliedJobAdvnce"];
        [backData addObject:data];
         [backData addObject:[NSString stringWithFormat:@"%d",isempty]];
        [self dissmisspop];
    }
    if(iscallback==16)//PostedProject advnce
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"PostedProjectAdvnce"];
        [backData addObject:data];
         [backData addObject:[NSString stringWithFormat:@"%d",isempty]];
        [self dissmisspop];
    }
    if(iscallback==17)//AllProject advnce
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"AllProjectAdvnce"];
        [backData addObject:data];
         [backData addObject:[NSString stringWithFormat:@"%d",isempty]];
        [self dissmisspop];
    }
    if(iscallback==18)
    {
        
        NSArray *dd=[data valueForKey:@"jobins"];
        NSString *val=[dd valueForKey:@"affectedRows"];
        
        if([val intValue]>0)
        {
            
            NSLog(@"hello inside if");
            
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Successfully Applied" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
            [prMainView removeFromSuperview];
            apply.userInteractionEnabled=NO;
            apply.backgroundColor=[UIColor clearColor];
            [apply setTitle:@"Applied" forState:UIControlStateNormal];
        }
        else
        {
            NSLog(@"hello inside else");
            
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Not Applied" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alrt show];
            apply.userInteractionEnabled=YES;
            [apply setTitle:@"Apply" forState:UIControlStateNormal];
        }
        
    }
    if(iscallback==19)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"addnewjob"];
        [backData addObject:[meta valueForKey:@"data"]];
        [self dissmisspop];
      
        
    }
    if(iscallback==20)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"updatejobdetails"];
        [backData addObject:[meta valueForKey:@"data"]];
        [self dissmisspop];
        
    }
    if(iscallback==108)
    {
        NSDictionary* metas = (NSDictionary*)meta;
        NSArray* participants = metas[@"data"][@"tut2"];
        NSString* userId = [NSString stringWithFormat:@"%@", metas[@"data"][@"id"]];
        for (NSDictionary* dict in participants) {
            NSString* innerUser = [NSString stringWithFormat:@"%@", dict[@"u_id"]];
            if ([userId isEqualToString:innerUser]) {
                NSMutableArray* allParts = jobApplicants.mutableCopy;
                for (NSMutableDictionary* user in allParts) {
                    NSString* jobUser = [NSString stringWithFormat:@"%@", user[@"u_id"]];
                    if ([userId isEqualToString:jobUser]) {
                        user[@"status"] = [NSNumber numberWithBool:YES];
                        jobApplicants = allParts;
                        [tableViewPoPosted performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
                        break;
                    }
                }
            }
        }
        
    }
    if (iscallback==109){
//        CommonProfile *cmpop=[[CommonProfile alloc]init];
//        cmpop.flag = 101;
        NSDictionary* metaDict = (NSDictionary*)meta;
//        //[self.navigationController pushViewController:cmpop animated:YES];
//        [ cmpop addProfileimage:data :[metaDict[@"uid"] intValue] :vc1] ;
        
        OtherProfileController *opc = [[OtherProfileController alloc] init];
        opc.friendId = [NSString stringWithFormat:@"%@", metaDict[@"uid"]];
        opc.profileAr = data;
//        [self showViewController:opc sender:nil];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navigationController pushViewController:opc animated:YES];
    }
}

-(IBAction)attachFile:(id)sender
 {
 
   
         
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Proyolk"message:@"Select Filte :"preferredStyle:UIAlertControllerStyleActionSheet];
     
     
     UIAlertAction* drivingAction1 = [UIAlertAction actionWithTitle:@"Image" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               ftbrowse=1;
                                                              [self chooseOption];
                                                               
                                                           }];
     
     
     
         UIAlertAction* drivingAction2 = [UIAlertAction actionWithTitle:@"Video File" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action){
                                                               
                                                                   
                                                                    ftbrowse=0;
                                                                   UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                                                                   imagePicker.delegate = self;
                                                                   imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                                   imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,      nil];
                                                                   [vc1 presentModalViewController:imagePicker animated:YES];
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   
                                                               }];
         
         UIAlertAction *walkingAction3 = [UIAlertAction actionWithTitle:@"Doc File" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action){
                                                                   //[self openCamera];
                                                                   
                                                               }];
         
         
         UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
         [alert addAction:drivingAction1];
         [alert addAction:drivingAction2];
         [alert addAction:walkingAction3];
         [alert addAction:defaultAction];
         [vc1 presentViewController:alert animated:YES completion:nil];
         
     }

     
-(void)chooseOption
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
        imagePicker.delegate = vc1;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [vc1 presentModalViewController:imagePicker animated:YES];
        randomImgName = [self randomImagName];
        filename.text=randomImgName;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Camera Unavailable"  message:@"Unable to find a camera on your device."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
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



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
 {
     NSLog(@"imagepickerrr insiee===%d",ftbrowse);
    
    if(ftbrowse==0)
    {
        
        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
        
        if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
            NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
            NSString *moviePath = [videoUrl path];
            
            if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath))
            {
                UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
                NSLog(@"dsdad  %@",moviePath);
                
                NSData* data = [moviePath dataUsingEncoding:NSUTF8StringEncoding];
                //NSData* data = UIImageJPEGRepresentation(moviePath, 1.0f);
                NSString *imgBuffer= [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                
                NSLog(@"imge bufferr======%@",imgBuffer);
            }
        }
        
        [self dismissModalViewControllerAnimated:YES];
    }
    else if(ftbrowse==1)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Loading...." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage]:[info objectForKey:UIImagePickerControllerOriginalImage];
        NSData* data = UIImageJPEGRepresentation(outputImage, 1.0f);
        imgBuffer= [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [picker dismissViewControllerAnimated:YES completion:nil];
        randomImgName = [self randomImagName];
        filename.text=randomImgName;
        [alert dismissWithClickedButtonIndex:0 animated:NO];
        
        
    }
    
    
}





@end


