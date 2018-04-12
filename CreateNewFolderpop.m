

#import "CreateNewFolderpop.h"
#import "SavePrefrences.h"
#import "StoragePopUp.h"
#import "AppDelegate.h"
#import "JobListVIewController.h"

@interface CreateNewFolderpop ()
{
    int iscallback;
    NSArray *folderArdata;
    UIView *prMainView;
    UIViewController *vc1;
    NSMutableArray * popUpAr;
    UILabel * NameLabel1;
    UIScrollView *scrollbar;
    NSString *foldernames;
    int selectedfolId;
    UITapGestureRecognizer *senderchangcol;
    UITextField *crftxt;
    StoragePopUp *stpop;
}
@end

@implementation CreateNewFolderpop

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createNewFolder:(UIViewController *)vc:(StoragePopUp *)stpop1;
{
    
    vc1=vc;
    stpop=stpop1;
    iscallback=0;
    
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyFolders" :@"getFolders" :@"" :@"" :dic1 :self ];
    
}



-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title:(int)isclosedreq
{
    
    
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
    //220:229:235
    
    NameLabel1=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-40, 50+20)];
    NameLabel1.text=title;
    NameLabel1.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    NameLabel1.font=[UIFont systemFontOfSize:14];
    NameLabel1.textColor=[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
    NameLabel1.layer.cornerRadius=15;
    NameLabel1.clipsToBounds=YES;
    NameLabel1.textAlignment=NSTextAlignmentCenter;
    [prMainView addSubview:NameLabel1];
    
    
    /*
     UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel1.frame.size.width+NameLabel1.frame.origin.x, [SavePrefrences sharedInstance ].naviHght+15, 30, 50)];
     closeView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
     [prMainView addSubview:closeView];
     
     if(isclosedreq==1)
     {
     UILabel *cross=[[UILabel alloc] initWithFrame:CGRectMake(2, 2, 25, 25)];
     cross.userInteractionEnabled=YES;
     [closeView addSubview:cross];
     
     UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
     [communityeg setNumberOfTouchesRequired:1];
     [communityeg setDelegate:self];
     closeView.userInteractionEnabled = YES;
     [closeView addGestureRecognizer:communityeg];
     }

     */
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
    [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
    scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    scrollbar.layer.cornerRadius=15;
    scrollbar.clipsToBounds=YES;
    [prMainView addSubview:scrollbar];
    return prMainView;
}






-(void)Showmoveto:(UIViewController*)Vc:(int)folderid
{
    int hasmore=0;
    for(int x=0;  x<[folderArdata count];x++)
    {
        int parent_fid=[[[folderArdata objectAtIndex:x] valueForKey:@"parent_fid"] intValue];
        if(parent_fid==folderid)
        {
            hasmore=1;
            break;
            
        }
    }
//    if(hasmore==1)
//    {
        [self MainView : Vc:@" Create Folder ":0 ];
        
        if(folderid>0)
        {
            prMainView.backgroundColor=[UIColor clearColor];
            UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(20, NameLabel1.frame.origin.y+10, 22, 22)];
            [bckarrow setImage:[UIImage imageNamed:@"back1.png"]];
            bckarrow.userInteractionEnabled=YES;
            bckarrow.backgroundColor=[UIColor clearColor];
            [prMainView addSubview:bckarrow];
            
            UITapGestureRecognizer *astreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
            [astreg setNumberOfTouchesRequired:1];
            [astreg setDelegate:self];
            bckarrow.userInteractionEnabled = YES;
            [bckarrow addGestureRecognizer:astreg];
            
        }
        
       /* else
        {
            UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(NameLabel1.frame.size.width+NameLabel1.frame.origin.x, NameLabel1.frame.origin.y+10, 22, 22)];
            [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
            cross.userInteractionEnabled=YES;
            [prMainView addSubview:cross];
            
            UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
            [communityeg setNumberOfTouchesRequired:1];
            [communityeg setDelegate:self];
            cross.userInteractionEnabled = YES;
            [cross addGestureRecognizer:communityeg];
        }*/
        
        scrollbar.frame=CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+300));
        //220:129:135
        UIView  *btnView = [[UIView alloc] initWithFrame:CGRectMake(scrollbar.frame.origin.x,scrollbar.frame.size.height+scrollbar.frame.origin.y-20-20,scrollbar.frame.size.width,70+20)];
        btnView.backgroundColor=[UIColor colorWithRed:220.0/255 green:229.0/255 blue:235.0/255 alpha:1];
        btnView.layer.cornerRadius=15;
        btnView.clipsToBounds=YES;
        [prMainView addSubview:btnView];
        
        [crftxt setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        crftxt = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, btnView.frame.size.width-40, 35)];
        crftxt.backgroundColor=[UIColor colorWithRed: 248.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
        crftxt.textColor=[UIColor colorWithRed: 153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        crftxt.delegate=vc1;
        [btnView addSubview:crftxt];
       
        
        UIButton *crbtn = [[UIButton alloc]initWithFrame:CGRectMake(btnView.frame.size.width/2-btnView.frame.size.width/4, 40, btnView.frame.size.width/4, 30)];
        [crbtn setTitle: @"Submit" forState: UIControlStateNormal];
        [crbtn setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [crbtn addTarget:self action:@selector(createfolder:) forControlEvents:UIControlEventTouchUpInside];
        [crbtn setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btnView addSubview:crbtn];
        
        UIButton *btnClose = [[UIButton alloc]initWithFrame:CGRectMake(crbtn.frame.size.width+crbtn.frame.origin.x+10, 40, btnView.frame.size.width/4, 30)];
        [btnClose setTitle: @"Close" forState: UIControlStateNormal];
        [btnClose setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [btnClose setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [btnView addSubview:btnClose];
        
        UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
        [communityeg setNumberOfTouchesRequired:1];
        [communityeg setDelegate:self];
        btnClose.userInteractionEnabled = YES;
        [btnClose addGestureRecognizer:communityeg];
        

        [self showHirarchy:folderid];
    //}
}


-(void) showHirarchy:(int)folderid
{
    int yincr=10;
    int xincr=10;
    //selectedfolId=0;
    
    for(int x=0;  x<[folderArdata count];x++)
    {
        int parent_fid=[[[folderArdata objectAtIndex:x] valueForKey:@"parent_fid"] intValue];
        if(parent_fid==folderid)
        {
            
            NSString *folder_name=[[folderArdata objectAtIndex:x] valueForKey:@"folder_name"];
            NSString *folder_id=[[folderArdata objectAtIndex:x] valueForKey:@"folder_id"];
            
            foldernames=[folder_name stringByAppendingString:[NSString stringWithFormat:@"%@",folder_name]];
            
            
            UIImageView  *folderimg=[[UIImageView alloc]initWithFrame:CGRectMake(xincr, yincr, 40,40)];
            folderimg.backgroundColor=[UIColor clearColor];
            [folderimg setImage:[UIImage imageNamed:@"folderimg.png"]];
            folderimg.tag=[folder_id intValue];
            [scrollbar addSubview:folderimg];
            
            
            UITextView  *folderName  =[[UITextView alloc]initWithFrame:CGRectMake(xincr, folderimg.frame.origin.y+folderimg.frame.size.height, 40,40)];
            folderName.textColor=[UIColor blackColor];
            folderName.font=[UIFont boldSystemFontOfSize:8];
            folderName.backgroundColor=[UIColor clearColor];
            folderName.text=folder_name;
            folderName.tag=[folder_id intValue];
            folderName.userInteractionEnabled=NO;
            folderName.textAlignment=NSTextAlignmentCenter;
            [scrollbar addSubview:folderName];
            
            
            UITapGestureRecognizer *openges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFolder:)];
            [openges setNumberOfTouchesRequired:1];
            [openges setDelegate:self];
            folderimg.userInteractionEnabled = YES;
            [folderimg addGestureRecognizer:openges];
            
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:   self action:@selector(openNewFolder1:)];
            doubleTap.numberOfTapsRequired = 2;
            [folderimg addGestureRecognizer:doubleTap];
            
            [openges requireGestureRecognizerToFail:doubleTap];
            
            xincr=xincr+70;
            
            if(xincr>scrollbar.frame.size.width)
            {
                xincr=10;
                yincr=yincr+80;
            }
        }
    }
    [scrollbar setContentSize:CGSizeMake(scrollbar.frame.size.width, yincr+80)];
}

-(void) openNewFolder1:(id)sender
{
    NSLog(@" double two clickkkkk");
    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
    int folderid =(int)ges.view.tag;
    [self Showmoveto : vc1:folderid];
    
}

-(void) selectFolder:(UITapGestureRecognizer*)sender
{
    if(senderchangcol!=nil)
    {
        UIImageView *btn = (UIImageView*)senderchangcol.view;
        btn.backgroundColor=[UIColor clearColor];
    }
    UIImageView *btn = (UIImageView*)sender.view;
    btn.backgroundColor=[UIColor lightGrayColor];
    selectedfolId=(int)btn.tag;
    senderchangcol=sender;
}

-(IBAction)createfolder:(id)sender
{
    if(crftxt.text.length>0){
        
        NSString * foldername=crftxt.text;
        NSLog(@"folder create dtaa   %@",foldername);
        
        
        //        if (id)
        //            pjs.send({m: 'MyFolders', fn: 'createFolder'}, {id: l['uid'], fldrname: e('folder-name').value, pfid: pfid, k: 'fol'}, genCreateFolder);
        //        else
        //            pjs.send({m: 'MyFolders', fn: 'createFolder'}, {id: l['uid'], fldrname: e('folder-name').value, pfid: pfid, k: ''}, genCreateFolder);
        //    }
        
        
        
        iscallback=1;
        
        if(selectedfolId>=0)
        {
            NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
            [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
            [dic setValue:foldername forKey:@"fldrname"];
            [dic setValue:[NSString stringWithFormat:@"%d",selectedfolId] forKey:@"pfid"];
            [dic setValue:@"fol" forKey:@"k"];
            [[SavePrefrences sharedInstance].skthand emitData:@"MyFolders" :@"createFolder" :@"" :@"" :dic :self ];
        }
        else{
            NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
            [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
            [dic setValue:foldername forKey:@"fldrname"];
            [dic setValue:[NSString stringWithFormat:@"%d",selectedfolId] forKey:@"pfid"];
            [dic setValue:@"" forKey:@"k"];
            [[SavePrefrences sharedInstance].skthand emitData:@"MyFolders" :@"createFolder" :@"" :@"" :dic :self ];
        }
        
    }
    
    
    
    
}


-(IBAction)selectedfolder:(id)sender
{
    NSLog(@"pop ar count=rrr=%lu",[popUpAr count]);
    
    
}

-(void)dissmisspop{
    int cnt=(int)[popUpAr count]-1;
    NSLog(@"pop ar count===%d",cnt);
    id<CallTo_Parent> cb= stpop;
    [cb callMethod:popUpAr];
    if([popUpAr count]>0){
        UIView *ppv=[popUpAr objectAtIndex:cnt] ;
        [ppv removeFromSuperview];
        [popUpAr removeObjectAtIndex:cnt];
        
    }
}

-(void) callBack:(NSArray *)meta :(NSArray *)data{
    
    if(iscallback==0){
        NSLog(@"meta ============0====%@",meta);
        NSLog(@"meta ============0====%@",data);
        
        folderArdata=data;
        [self Showmoveto:vc1 :0];
        
        
    }
    else if(iscallback==1)
    {
        
        NSLog(@"meta ============1====%@",meta);
        NSLog(@"meta ============1====%@",data);
        if([data count]>0)
        {
            id<CallTo_Parent>  cb= stpop;
            [cb callMethod:data];
        }
        [self removePop];
        
       // [self createNewFolder:vc1:stpop];
        
        
    }
    
    
}

-(void)removePop
{
    for(int x=0;x<[popUpAr count];x++)
    {
        UIView *ppv=[popUpAr objectAtIndex:x] ;
        [ppv removeFromSuperview];
    }
    
    [popUpAr removeAllObjects];
    
}







@end
