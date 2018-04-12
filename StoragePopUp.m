

#import "StoragePopUp.h"
#import "AllValidationsViewController.h"
#import "SavePrefrences.h"
#import "ManageArray.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "CreateNewFolderpop.h"
#import "DeleteFolderPop.h"
#import "UIImageView+WebCache.h"
#import "UITreeView.h"
@interface StoragePopUp ()
{
    UITreeView *tree;
    NSMutableDictionary *dictFilter;
    UIView *prMainView,*NameLabel,*prmainsideview;
    AllValidationsViewController *av;
    UILabel *Files_bar1,*Files_bar2,*Myfolder_bar1,*Myfolder_bar2,*uname_lbl;
    UIView *bodyview,*option,*middle_label,*base,*cell_View;
    NSMutableArray *popUpAr,*inviteAr,*backData;
    UITextField *search_lbl;
    UIViewController *vc1;
    UIButton *Search,*invite;
    UIImageView *userpic;
    UIImageView *filterlbl,*three_dots;
    UILabel *NameLabel1,*Files,*Community,*commbar,* yellowcomm,*yellowcbnt,*yellownet;
    UILabel *myfolder;
    UIScrollView *scrollbar;
    NSMutableArray *changetpeAr;
    ManageArray *mar;
    UIAlertView * alrt;
    int fileindex,iscallback,cellheight,sortIt,newsort,sortnew,sortpryk,selectedfolId,fidfrfile,fileIdis,to_id,strid;
    NSArray * fileAr,*commuAr,*shareAr,*netAr,*folderArdata,*storageFileAr;
    UIView *viewfortable, *sideview,*prhier2View;
    NSString * foldernames;
    float foldernewline;
    UITapGestureRecognizer * senderchangcol;
    NSString * buttonHieratext,*filenameis;
    NSMutableArray *getFoldernamedic,*popArforHierchy;
    int ftbrowse;
    id sender1;
    NSString *imgBuffer;
    NSString *randomImgName;
    UITextField *upld;
    
}

@end

@implementation StoragePopUp
@synthesize Filetable,communitytable,sharedtable,networktable,fileid,filename,uid_from;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    dictFilter = [NSMutableDictionary dictionary];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return cellheight;;
}
-(UIView *)MainViewWithoutTitle:(UIViewController *)Vc
{
 
    if(changetpeAr==nil)
       changetpeAr=[[NSMutableArray alloc]init];
    if(av==nil)
       av=[[AllValidationsViewController alloc]init];
    if(mar==nil)
        mar=[[ManageArray alloc]init];
    
    
    
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    NameLabel=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 50)];
    NameLabel.backgroundColor=[[SavePrefrences sharedInstance].colorDictionry valueForKey:@"actionBar"];
    
    [prMainView addSubview:NameLabel];
    
    bodyview=[[UIView alloc]initWithFrame:CGRectMake( 0, NameLabel.frame.size.height+NameLabel.frame.origin.y, [SavePrefrences sharedInstance ].screenWidth, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance].naviHght+[SavePrefrences sharedInstance ].stbarHght))];
    
    bodyview.backgroundColor=[UIColor colorWithRed:244.0/255 green:244.0/255 blue:255.0/255 alpha:1];
    [prMainView addSubview:bodyview];
    return prMainView;
    
}

-(UIView *) MainSideView:(UIViewController *)Vc
{
    prmainsideview = [[UIView alloc]initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prmainsideview];
    vc1=Vc;
    prmainsideview.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:.2f];
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisssidepop)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    prmainsideview.userInteractionEnabled = YES;
    [prmainsideview addGestureRecognizer:communityeg];
    
    return nil;
}



-(void)dissmisssidepop
{
    [sideview removeFromSuperview];
    [prmainsideview removeFromSuperview];
    
}

-(void)moveto:(UIViewController*)Vc
{
    vc1=Vc;
    iscallback=7;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyFolders" :@"getFolders" :@"" :@"" :dic1 :self ];
    
}

-(void)reteriveFolderforFile
{
    iscallback=13;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyFolders" :@"getFolders" :@"" :@"" :dic1 :self ];
}



-(UIView *) MainView:(UIViewController *)Vc:(NSString *) title:(int)isclosedreq
{
    if ([title isEqualToString:@"Sort By"]||[title isEqualToString:@"Filters"])
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
        else{
            
            popUpAr =[[NSMutableArray alloc]init];
            [popUpAr addObject:prMainView];
        }
        
        
        NameLabel1=[[UILabel alloc] initWithFrame:CGRectMake(4, prMainView.frame.size.height/4, prMainView.frame.size.width-8, 50+20)];
        NameLabel1.text=title;
        NameLabel1.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        NameLabel1.font=[UIFont systemFontOfSize:14];
        NameLabel1.textColor=[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        NameLabel1.layer.cornerRadius=12;
        NameLabel1.clipsToBounds=YES;
        NameLabel1.textAlignment=NSTextAlignmentCenter;
        [NameLabel1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [prMainView addSubview:NameLabel1];
        
        
        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake(4, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-8, 120)];
        [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
        scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        scrollbar.layer.cornerRadius=12;
        scrollbar.clipsToBounds=YES;
        [prMainView addSubview:scrollbar];
        return prMainView;

    }
    else
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
        else{
            
            popUpAr =[[NSMutableArray alloc]init];
            [popUpAr addObject:prMainView];
        }
        
        
        NameLabel1=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-40, 50+20)];
        NameLabel1.text=title;
        NameLabel1.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        NameLabel1.font=[UIFont systemFontOfSize:14];
        NameLabel1.textColor=[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        NameLabel1.layer.cornerRadius=5;
        NameLabel1.textAlignment=NSTextAlignmentCenter;
        [NameLabel1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        NameLabel1.layer.cornerRadius=12;
        NameLabel1.clipsToBounds=YES;
        [prMainView addSubview:NameLabel1];
        
        
       /* UIView *closeView=[[UIView alloc] initWithFrame:CGRectMake(NameLabel1.frame.size.width+NameLabel1.frame.origin.x-20, [SavePrefrences sharedInstance ].naviHght+15, 30+20, 50+20)];
        closeView.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [prMainView addSubview:closeView];
        
        if(isclosedreq==1)
        {
            
            UIImageView *cross=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 25, 25)];
            [cross setImage:[UIImage imageNamed:@"cross-icon.png"]];
            cross.userInteractionEnabled=YES;
            [closeView addSubview:cross];
            
            UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
            [communityeg setNumberOfTouchesRequired:1];
            [communityeg setDelegate:self];
            closeView.userInteractionEnabled = YES;
            [closeView addGestureRecognizer:communityeg];
        }*/
        
        
        scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+70))];
        [scrollbar setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight)];
        scrollbar.backgroundColor=[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
        [prMainView addSubview:scrollbar];
        scrollbar.layer.cornerRadius=12;
        scrollbar.clipsToBounds=YES;

        return prMainView;
    }
}


-(void)dissmissmainPop
{
    for(int x=0;x<[popUpAr count];x++)
    {
        UIView *ppv=[popUpAr objectAtIndex:x] ;
        [ppv removeFromSuperview];
    }
    
    [popUpAr removeAllObjects];
    
    
    // NSLog(@"all array cout===%@",[popUpAr count]);
    
    
    
    
}





//=======================================hierarchy open====================================

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
    if(hasmore==1)
    {
        [self MainView : Vc:@" Select A Folder To Move ":0 ];
        
        if(folderid>0)
        {
            prMainView.backgroundColor=[UIColor clearColor];
            
            UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(20, NameLabel1.frame.origin.y+10, 30, 28)];
            [bckarrow setImage:[UIImage imageNamed:@"back11.png"]];
            bckarrow.userInteractionEnabled=YES;
            bckarrow.backgroundColor=[UIColor clearColor];
            [prMainView addSubview:bckarrow];
            
            UITapGestureRecognizer *astreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
            [astreg setNumberOfTouchesRequired:1];
            [astreg setDelegate:self];
            bckarrow.userInteractionEnabled = YES;
            [bckarrow addGestureRecognizer:astreg];
            
        }
        
        
        scrollbar.frame=CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+300));
        
        
        UIView  *btnView = [[UIView alloc] initWithFrame:CGRectMake(scrollbar.frame.origin.x,scrollbar.frame.size.height+scrollbar.frame.origin.y-20,scrollbar.frame.size.width,40+20)];
        btnView.backgroundColor=[UIColor colorWithRed:220.0/255 green:229.0/255 blue:235.0/255 alpha:1];
        btnView.layer.cornerRadius=12;
        btnView.clipsToBounds=YES;
        
        [prMainView addSubview:btnView];
        
        NSMutableDictionary * colr=[SavePrefrences sharedInstance].colorDictionry;
        UIColor * uic=[colr valueForKey:@"Yellowbtncolor"];
        
        UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, btnView.frame.size.width/2-10, 30)];
        // [done setTitle: buttonHieratext forState: UIControlStateNormal];
        [done setTitle: @"Move" forState: UIControlStateNormal];
        
        [done addTarget:self action:@selector(selectedfolder:) forControlEvents:UIControlEventTouchUpInside];
        [done setTitleColor:[UIColor colorWithRed:0.0/255 green:49.0/255 blue:99.0/255 alpha:1] forState:UIControlStateNormal];
        done.layer.cornerRadius=6;
        [btnView addSubview:done];
        done.backgroundColor=uic;
        
        
        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(btnView.frame.size.width/2+5, 20, btnView.frame.size.width/2-10, 30)];
        [cancel setTitle: @"Cancel" forState: UIControlStateNormal];
        [cancel addTarget:self action:@selector(dontMove:) forControlEvents:UIControlEventTouchUpInside];
        [cancel setTitleColor:[UIColor colorWithRed:0.0/255 green:49.0/255 blue:99.0/255 alpha:1] forState:UIControlStateNormal];
        cancel.layer.cornerRadius=6;
        cancel.backgroundColor=uic;
        [btnView addSubview:cancel];
        
        [self showHirarchy:folderid];
    }
}



-(void)Showmoveto1:(UIViewController*)Vc:(int)folderid
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
    if(hasmore==1)
    {
        [self MainView : Vc:@" Upload File ":0 ];
        
        if(folderid>0)
        {
            prMainView.backgroundColor=[UIColor clearColor];
            
            UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(20, NameLabel1.frame.origin.y+10, 30, 28)];
            [bckarrow setImage:[UIImage imageNamed:@"back11.png"]];
            bckarrow.userInteractionEnabled=YES;
            bckarrow.backgroundColor=[UIColor clearColor];
            [prMainView addSubview:bckarrow];
            
            UITapGestureRecognizer *astreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
            [astreg setNumberOfTouchesRequired:1];
            [astreg setDelegate:self];
            bckarrow.userInteractionEnabled = YES;
            [bckarrow addGestureRecognizer:astreg];
            
        }
        
        
        
//        scrollbar.frame=CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+300));
        
        
        
        
        
        
        
//        NSMutableDictionary  *dict=[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"category" ofType:@"plist"]];
//            NSMutableDictionary  *cat =[[NSMutableDictionary alloc] init];
//            cat =[dict valueForKey:@"categoriesList"];
        NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
        prmainsideview.backgroundColor=[ff valueForKey:@"Videocolor"];
        upld=[[UITextField alloc]initWithFrame:CGRectMake(30, NameLabel.frame.size.height+NameLabel.frame.origin.y+120,prMainView.frame.size.width/2+10,30)];
        upld.placeholder=@"Upload File";
        upld.backgroundColor=[UIColor whiteColor];
        upld.layer.cornerRadius=5;
        ///////////////
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        upld.leftView = paddingView;
        upld.leftViewMode = UITextFieldViewModeAlways;
        ////////////
        
        
        [prMainView addSubview:upld];
        
        
        int xspec=40;
        int wid=(prmainsideview.frame.size.width-100)/3;
        NSMutableArray * type=[[NSMutableArray alloc]init];
        [type addObject:@" Video"];
        [type addObject:@" Image"];
        // [type addObject:@" Doc"];
        
        for(int x=0;x<[type count];x++)
        {
            
            
            UIButton *imgarrow1 =[[UIButton alloc]initWithFrame:CGRectMake(xspec, NameLabel.frame.size.height+NameLabel.frame.origin.y+65, 25, 25)];
            imgarrow1.layer.cornerRadius=7.5;
            imgarrow1.layer.borderWidth=1.5;
            imgarrow1.backgroundColor=[UIColor whiteColor];
            imgarrow1.tag=x;
            [imgarrow1 addTarget:self action:@selector(changeFileBrowse:) forControlEvents: UIControlEventTouchUpInside];
            [changetpeAr addObject:imgarrow1];
            
            if(x==0)
            {
                //[imgarrow1 setImage:[UIImage imageNamed: @"gray-radio.png"] forState:UIControlStateNormal];
                imgarrow1.backgroundColor=[UIColor grayColor];
                //sender1=imgarrow1;
            }
            //        else
            //        {
            //            [imgarrow1 setImage:[UIImage imageNamed: @"white-radio.png"] forState:UIControlStateNormal];
            //        }
            [prMainView addSubview:imgarrow1];
            
            
            
            UILabel *filetype=[[UILabel alloc]initWithFrame:CGRectMake(xspec+15, NameLabel.frame.size.height+NameLabel.frame.origin.y+65,wid+5, 25)];
            filetype.text= [NSString stringWithFormat:@"  %@  ",[type objectAtIndex:x]];  //NSStr[type objectAtIndex:x];
            filetype.textAlignment=NSTextAlignmentLeft;
            filetype.backgroundColor=[UIColor clearColor];
            [prMainView addSubview:filetype];
            
            xspec=xspec+wid+20;
            
        }
        
        
        
        
        
        
        UIButton *upl_btn=[[UIButton
                            alloc]initWithFrame:CGRectMake(upld.frame.size.width+upld.frame.origin.x+10,
                                                           NameLabel.frame.size.height+NameLabel.frame.origin.y+120 ,
                                                           prMainView.frame.size.width/2-80, 30)];
        [upl_btn setTitle:@"Browse" forState:UIControlStateNormal];
        [upl_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [upl_btn addTarget:self action:@selector(uploading:)
          forControlEvents:UIControlEventTouchUpInside];
        upl_btn.layer.cornerRadius=5;
        upl_btn.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
        [prMainView addSubview:upl_btn];
        
        
        
//        prmainsideview.frame=CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-40, cancel.frame.origin.y+10);
//        [scrollbar setContentSize:CGSizeMake(scrollbar.frame.size.width, cancel.frame.origin.y+10)];

        
        
        
        
        
        
        NSMutableArray *cat = [self parseTree:folderArdata root:@"0"];
        
        tree = [[UITreeView alloc] initWithFrame:CGRectMake(20, upld.frame.size.height+upld.frame.origin.y+20, prMainView.frame.size.width-40, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+300)) andData:cat];
        tree.backgroundColor =     [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];;
        
        [prMainView addSubview:tree];
        UIFont *font =[UIFont fontWithName:@"Helvetica" size:12];
        [tree setTreeViewFont:font];
        
        
        
        
        
        
        UIView  *btnView = [[UIView alloc] initWithFrame:CGRectMake(tree.frame.origin.x,tree.frame.size.height+tree.frame.origin.y-20,tree.frame.size.width,40+20)];
        btnView.backgroundColor=[UIColor colorWithRed:220.0/255 green:229.0/255 blue:235.0/255 alpha:1];
        btnView.layer.cornerRadius=12;
        btnView.clipsToBounds=YES;

        [prMainView addSubview:btnView];
        
        NSMutableDictionary * colr=[SavePrefrences sharedInstance].colorDictionry;
        UIColor * uic=[colr valueForKey:@"Yellowbtncolor"];
        
//        UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, btnView.frame.size.width/2-10, 30)];
//       // [done setTitle: buttonHieratext forState: UIControlStateNormal];
//        [done setTitle: @"Move" forState: UIControlStateNormal];
//
//        [done addTarget:self action:@selector(selectedfolder:) forControlEvents:UIControlEventTouchUpInside];
//        [done setTitleColor:[UIColor colorWithRed:0.0/255 green:49.0/255 blue:99.0/255 alpha:1] forState:UIControlStateNormal];
//        done.layer.cornerRadius=6;
//        [btnView addSubview:done];
//        done.backgroundColor=uic;
//        
//        
//        UIButton *cancelbtn = [[UIButton alloc]initWithFrame:CGRectMake(btnView.frame.size.width/2+5, 20, btnView.frame.size.width/2-10, 30)];
//        [cancelbtn setTitle: @"Cancel" forState: UIControlStateNormal];
//        [cancelbtn addTarget:self action:@selector(dontMove:) forControlEvents:UIControlEventTouchUpInside];
//        [cancelbtn setTitleColor:[UIColor colorWithRed:0.0/255 green:49.0/255 blue:99.0/255 alpha:1] forState:UIControlStateNormal];
//        cancelbtn.layer.cornerRadius=6;
//        cancelbtn.backgroundColor=uic;
//        [btnView addSubview:cancelbtn];
        
        UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, btnView.frame.size.width/2-10, 30)];
        [save setTitle: @"Save" forState: UIControlStateNormal];
        save.backgroundColor=[ff valueForKey:@"clearClor"];
        [save addTarget:self action:@selector(Saveupload:)
       forControlEvents:UIControlEventTouchUpInside];
        [save setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        save.layer.cornerRadius=6;
        save.tag=0;
        [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [btnView addSubview:save];
        
        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(btnView.frame.size.width/2+5, 20, btnView.frame.size.width/2-10, 30)];
        [cancel setTitle: @"Close" forState: UIControlStateNormal];
        [cancel setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [cancel addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
       // [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancel.layer.cornerRadius=6;
        [btnView addSubview:cancel];

        
       // [self showHirarchy:folderid];
    }
}

-(NSMutableArray *)parseTree:(NSMutableArray *)arr root:(NSString *)Root{
    NSMutableArray *tree = [NSMutableArray arrayWithArray:arr];
    
    NSMutableArray *arrTree = [NSMutableArray array];
    
    
    for (NSMutableDictionary *dictChild in tree) {
        
        if ([[dictChild objectForKey:@"parent_fid"]integerValue] == [Root integerValue]) {
            NSMutableDictionary *dictData = [NSMutableDictionary dictionaryWithDictionary:dictChild];
            
            
            //
            //
            //  [tree removeObject:dictData];
            //            NSMutableDictionary *dictData = [NSMutableDictionary dictionaryWithDictionary:dictChild];
            
            
            NSMutableArray *subArray = [NSMutableArray arrayWithArray:[self parseTree:tree root:[dictChild objectForKey:@"folder_id"]]];
            if (subArray.count<=0) {
                [dictData setObject:@"" forKey:@"categories"];;
            }
            else{
                [dictData setObject:subArray forKey:@"categories"];;
            }
            
            [arrTree addObject:dictData];
            //
        }
        
    }
    
    return arrTree;
}




-(void) showHirarchy:(int)folderid
{
    int yincr=10;
    int xincr=10;
    selectedfolId=0;
    
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
            [folderimg setImage:[UIImage imageNamed:@"folderimg1.png"]];
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
    [scrollbar1 setContentSize:CGSizeMake(scrollbar1.frame.size.width, yincr+80)];
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




-(IBAction)selectedfolder:(id)sender
{
    NSLog(@"pop ar count=rrr=%lu",[popUpAr count]);
    
    
    if(selectedfolId>0)
    {
        
        
        if([buttonHieratext isEqual:@"MoveTo"])
        {
            
            for(int x=0;x<[popUpAr count];x++)
            {
                UIView *ppv=[popUpAr objectAtIndex:x] ;
                [ppv removeFromSuperview];
            }
            [popUpAr removeAllObjects];
            
            
            
            NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
            iscallback=12;
            [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
            [dic setValue:fileid forKey:@"fId"];
            [dic setValue:[NSString stringWithFormat:@"%d",selectedfolId] forKey:@"folId"];
            [dic setValue:uid_from forKey:@"sender"];
            [dic setValue:filename forKey:@"filename"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"moveFiles" :@"" :@"" :dic :self ];
        }
        else if([buttonHieratext isEqual:@"Upload File"])
        {
            
            [self uploadFile:vc1];
            
            
            NSLog(@"herererer upload file");
            
            //                     NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
            //                     iscallback=12;
            //                     [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
            //                     [dic setValue:fileid forKey:@"fId"];
            //                     [dic setValue:[NSString stringWithFormat:@"%d",selectedfolId] forKey:@"folId"];
            //                     [dic setValue:uid_from forKey:@"sender"];
            //                     [dic setValue:filename forKey:@"filename"];
            //                     [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"moveFiles" :@"" :@"" :dic :self ];
            
        }
        
        
        
    }
    else
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Please Select Folder First" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        
        
    }
}



-(IBAction)dontMove:(id)sender
{
    [prMainView removeFromSuperview];
//    for(int x=1;x<[popUpAr count];x++)
//    {
//        UIView *ppv=[popUpAr objectAtIndex:x] ;
//        [ppv removeFromSuperview];
//        [popUpAr removeObjectAtIndex:x];
//    }
    
}









//=======================================hierarchy closed==========================================================






-(UIView *) MainViewfortable:(UIViewController *)Vc:(NSString *) title
{
    av=[[AllValidationsViewController alloc]init];
    
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:.8f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    NameLabel1=[[UILabel alloc] initWithFrame:CGRectMake(20, [SavePrefrences sharedInstance ].naviHght+15, prMainView.frame.size.width-70, 50+30)];
    NameLabel1.text=title;
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
    
    
    return prMainView;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if(theTableView==Filetable)
    {
        cellheight=60;
        return  [fileAr count];
    }
    if(theTableView==communitytable)
    {
        cellheight=80;
        return [commuAr count];
    }
    if(theTableView==sharedtable)
    {
        cellheight=80;
        return [shareAr count];
    }
    if(theTableView==networktable)
    {cellheight=80;
        return [netAr count];
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MyCellIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [self.Filetable dequeueReusableCellWithIdentifier:MyCellIdentifier];
    @try {
        NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor=[ff valueForKey:@"clearcolor"];
        
        if(theTableView==Filetable)
        {
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(10, 2.5, cell.frame.size.width, 60)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
            
            
            //        "file_ext" = jpeg;
            //        "file_id" = 215;
            //        "file_name" = "cartoon2.jpeg";
            //        "file_name1" = "cartoon2.jpeg";
            //        "folder_id" = 30;
            //        imge = "images/picture-icon.png";
            //        logtime = "2016-04-08T07:08:49.000Z";
            //        size = "4 KB";
            //        "u_id" = 6;
            
            
            NSString *file_name=[[fileAr objectAtIndex:indexPath.row] valueForKey:@"file_name"];
            NSString *file_ext=[[fileAr objectAtIndex:indexPath.row] valueForKey:@"file_ext"];
            NSString *file_id=[[fileAr objectAtIndex:indexPath.row] valueForKey:@"file_id"];
            NSString *file_name1=[[fileAr objectAtIndex:indexPath.row] valueForKey:@"file_name1"];
            
            NSString *folder_id=[[fileAr objectAtIndex:indexPath.row] valueForKey:@"folder_id"];
            NSString *imge=[[fileAr objectAtIndex:indexPath.row] valueForKey:@"imge"];
            NSString *logtime=[[fileAr objectAtIndex:indexPath.row] valueForKey:@"logtime"];
            NSString *size=[[fileAr objectAtIndex:indexPath.row] valueForKey:@"size"];
            NSString *u_id=[[fileAr objectAtIndex:indexPath.row] valueForKey:@"u_id"];
            
           /* UIButton *checkpoint=[[UIButton alloc] initWithFrame:CGRectMake(5, (cell_View.frame.size.height/2)-12.5, 25, 25)];
            [checkpoint setImage:[UIImage imageNamed:@"unslectedcheck.png"] forState:UIControlStateNormal];
            [checkpoint addTarget:self action:@selector(checkpoint:) forControlEvents:UIControlEventTouchUpInside];
            checkpoint.tag=indexPath.row;
            [cell_View addSubview:checkpoint];*/

            
            UIImageView *pic=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
            
            if ([file_ext containsString:@"mp4"] || [file_ext containsString:@"fav"]) {
                pic.image = [UIImage imageNamed:@"videoicon.png"];
            }
            else if ([file_ext containsString:@"jpg"] || [file_ext containsString:@"jpeg"]|| [file_ext containsString:@"png"]|| [file_ext containsString:@"gif"]) {
                pic.image = [UIImage imageNamed:@"pictureicn.png"];
            }
            else  {
                pic.image = [UIImage imageNamed:@"docicon.png"];
            }
            
//            pic.image=[UIImage imageNamed:@"pictureicn1.png"];
//            NSString *strUrl = @"https://proyolk.com/";
//            
//            strUrl = [strUrl stringByAppendingString:[[fileAr objectAtIndex:indexPath.row]valueForKey:@"imge"]];
//            [pic sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"user.png"]];
            [cell_View addSubview: pic];
            
            UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(pic.frame.size.width+pic.frame.origin.x+6, (cell_View.frame.size.height/2)-9, 130, 18)];
            title.text=file_name;
            title.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            [title setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
            [title setFont:[UIFont boldSystemFontOfSize:12]];
            [cell_View addSubview:title];
            
            UILabel *bytes=[[UILabel alloc] initWithFrame:CGRectMake(cell_View.frame.size.width-85, (cell_View.frame.size.height/2)-8, 80, 16)];
            bytes.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            bytes.text=[size stringByAppendingString:@""];
            [bytes setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell_View addSubview:bytes];
            //radiounselect.png
            //radioselect.png
            UIButton *checkpoint=[[UIButton alloc] initWithFrame:CGRectMake(cell_View.frame.size.width-25, (cell_View.frame.size.height/2)-10, 20, 20)];
            [checkpoint setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
            [checkpoint addTarget:self action:@selector(checkpoint:) forControlEvents:UIControlEventTouchUpInside];
            checkpoint.tag=indexPath.row;
            [cell_View addSubview:checkpoint];

            
            base=[[UIView alloc]initWithFrame:CGRectMake(0, [SavePrefrences sharedInstance].screenHeight-60, prMainView.frame.size.width, 50)];
            base.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            base.hidden=true;
            [prMainView addSubview: base];
            
            NSMutableArray *picAr=[[NSMutableArray alloc]init];
           /* [picAr addObject:@"sharefile.png"];
            [picAr addObject:@"download.png"];
            [picAr addObject:@"trash.png"];*/
            
            [picAr addObject:@"share.png"];
            [picAr addObject:@"resume_download.png"];
            [picAr addObject:@"deleteblack.png"];

            int xinc=40;
            int wid=(base.frame.size.width)/3;
            for(int x=0;x<3;x++)
            {
                UIImageView *pic=[[UIImageView alloc] initWithFrame:CGRectMake(xinc, 0, 30, 30)];
                pic.image=[UIImage imageNamed:[picAr objectAtIndex:x]];
                pic.tag=x;
                [base addSubview: pic];
                
                xinc=xinc+wid;
                
                UITapGestureRecognizer *myFldr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectOption:)];
                [myFldr setNumberOfTouchesRequired:1];
                [myFldr setDelegate:self];
                pic.userInteractionEnabled = YES;
                [pic addGestureRecognizer:myFldr];
            }
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(20,cell_View.bounds.size.height-2,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:183.0/255.0 blue:183.0/255.0 alpha:0.75];
            [cell addSubview:separator];

            
            return cell;
            
            
        }
        else if(theTableView==communitytable)
        {
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 70)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
            
            NSString *uname=[[commuAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            NSString *u_id=[[commuAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,cell_View.bounds.size.height-1,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            [cell_View addSubview:separator];

            userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
            userpic.backgroundColor=[UIColor clearColor];
           // [userpic setImage:[UIImage imageNamed:@"user.png"]];
            userpic.layer.cornerRadius=22;
            userpic.clipsToBounds=YES;
            [cell_View addSubview:userpic];
            NSString *strUrl = @"https://proyolk.com";
            strUrl = [strUrl stringByAppendingString:[[commuAr objectAtIndex:indexPath.row]valueForKey:@"img"]];
            [userpic sd_setImageWithURL:[NSURL URLWithString:strUrl]];
            uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            if([av checkNullStr:uname])
            {
                uname_lbl.text=uname;
            }
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell_View addSubview: uname_lbl];
            
            invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
            [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [invite setTitle:@"Share" forState:UIControlStateNormal];
            [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            invite.tag=[u_id intValue];
            [invite addTarget:self action:@selector(inviteto:) forControlEvents:UIControlEventTouchUpInside];
            //invite.layer.cornerRadius=4;
            //[invite setClipsToBounds:YES];
            [cell_View addSubview:invite];
            
            UIImageView *isonimg =[[UIImageView alloc]initWithFrame:CGRectMake(cell_View.frame.size.width+cell_View.frame.origin.x-30, 18 ,15, 15)];
            isonimg.image = [UIImage imageNamed:@"onlineicon.png"];
            isonimg.backgroundColor=[UIColor clearColor];
            [cell_View addSubview:isonimg];

            return cell;
            
        }
        else if(theTableView==sharedtable)
        {
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 70)];
            cell_View.backgroundColor=[UIColor clearColor];
            [cell addSubview: cell_View];
            
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0,cell_View.bounds.size.height-1,cell_View.bounds.size.width,1)];
            separator.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
            [cell_View addSubview:separator];

            NSString *uname=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"uname"];
            NSString *u_id=[[shareAr objectAtIndex:indexPath.row]valueForKey:@"u_id"];
            NSString *strUrl = @"https://proyolk.com";
            strUrl = [strUrl stringByAppendingString:[[shareAr objectAtIndex:indexPath.row]valueForKey:@"img"]];
            
            userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
            userpic.backgroundColor=[UIColor redColor];
            [userpic sd_setImageWithURL:[NSURL URLWithString:strUrl] ];
            userpic.layer.cornerRadius=22;
            userpic.clipsToBounds=YES;
            [cell_View addSubview:userpic];
            
            uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            if([av checkNullStr:uname])
            {
                uname_lbl.text=uname;
            }
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell_View addSubview: uname_lbl];
            
            invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
            [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [invite setTitle:@"Share" forState:UIControlStateNormal];
            [invite setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            invite.tag=[u_id intValue];
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
            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width-5, 70)];
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
            [userpic sd_setImageWithURL:[NSURL URLWithString:strUrl] ];
            userpic.layer.cornerRadius=22;
            userpic.clipsToBounds=YES;
            [cell_View addSubview:userpic];
            
            UILabel  *uname_lbl=[[UILabel alloc] initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+5, 15,cell_View.frame.size.width, 20)];
            uname_lbl.textAlignment=NSTextAlignmentLeft;
            uname_lbl.textColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
            if([av checkNullStr:uname])
            {
                uname_lbl.text=uname;
            }
            [uname_lbl setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell_View addSubview: uname_lbl];
            
            
            
            
            
            invite=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, cell_View.frame.size.width-40,20)];
            [invite setTitleColor:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forState:UIControlStateNormal];
            invite.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [invite setTitle:@"Share" forState:UIControlStateNormal];
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

-(void) invitelabl :(UITapGestureRecognizer *)ges
{
    
    UILabel * label=  (UILabel *)ges.view;
    label.text=@"Invited";
    label.backgroundColor=[UIColor grayColor];
    
    int d= (int)label.tag;
    
    NSLog(@"tag======%d",d);
    
    
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1)
    {
        NSLog(@"ok");
        iscallback=5;
        
        NSString * fileid1= [[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"id"];
        [[SavePrefrences sharedInstance].skthand emitData:@"MyFiles" :@"delfile" :@"" :@"" :dic1 :self ];
    }
    else if(buttonIndex==0)
    {
        NSLog(@"cancel");
        [alrt dismissWithClickedButtonIndex:0 animated:YES];
        
    }
}

-(IBAction)inviteto:(id)sender
{
    
    UIButton *btn=(UIButton *)sender;
    
    if([btn.titleLabel.text isEqual:@"Share"])
    {
        [inviteAr addObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
        [btn setTitle:@"Shared" forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor clearColor];
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%d",fileIdis] forKey:@"fId"];
        [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"u_from"];
        [dic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"u_to"];
        iscallback=16;
        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"StInviteMem" :@"" :@"" :dic :self ];
    }
    
    
}

-(void)SelectOption:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    
    int t=(int)tg.view.tag;
    
    
    
    
    if((int)tg.view.tag==0)
    {
        NSLog(@"opening share");
        
        
        [self shareIt:vc1];
    }
    else if((int)tg.view.tag==1)
    {
        
        
       [self downloadImg:[[fileAr objectAtIndex:t] objectForKey:@"file_name"] user: [NSString stringWithFormat:@"%@",[[fileAr objectAtIndex:t] objectForKey:@"u_id"]]];
        
        
        //        mar=[[ManageArray alloc]init];
        //        path=[mar concatUrl:path];
        //
        //        NSLog(@"%@",path);
        //
        //
        //
        //
        //        NSURL  *url = [NSURL URLWithString:path];
        //        NSData *urlData = [NSData dataWithContentsOfURL:url];
        //        if (urlData)
        //        {
        //            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //            NSString  *documentsDirectory = [paths objectAtIndex:0];
        //
        //            NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"filename.png"];
        //            [urlData writeToFile:filePath atomically:YES];
        //
        //            NSLog(@"file path======%@",filePath);
        //
        //        }
        
    }
    else if((int)tg.view.tag==2)
    {
        NSLog(@"delte file");
        
        alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alrt show];
        [self alertView:alrt clickedButtonAtIndex:2];
        
    }
    
}

-(void)shareIt:(UIViewController*)Vc
{
    
    [self MainViewfortable:vc1 :@"Share"];
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    
    
    float div= (viewfortable.frame.size.width)/3;
    
    NSMutableArray *shareAr=[[NSMutableArray alloc]init];
    [shareAr addObject:@"Community"];
    [shareAr addObject:@"Cabinet"];
    [shareAr addObject:@"Network"];
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
    
    
    
    proyolkBtn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 4,div+0.4, 50)];
    [proyolkBtn1 setTitle: @"Community" forState: UIControlStateNormal];
    [proyolkBtn1 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    //proyolkBtn1.textAlignment=NSTextAlignmentCenter;
    [proyolkBtn1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn1 setBackgroundColor:[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];//[ff valueForKey:@"backcolor"];
    proyolkBtn1.tag=111;
    [proyolkBtn1 addTarget:self action:@selector(tapBar1:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn1];
    
    proyolkBtn2=[[UIButton alloc]initWithFrame:CGRectMake(proyolkBtn1.frame.size.width+proyolkBtn1.frame.origin.x, 4,div+0.4, 50)];
    [proyolkBtn2 setTitle: @"Cabinet" forState: UIControlStateNormal];
    //proyolkBtn2.textAlignment=NSTextAlignmentCenter;
    [proyolkBtn2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn2 setBackgroundColor:[UIColor  colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];
    [proyolkBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    proyolkBtn2.tag=222;
    [proyolkBtn2 addTarget:self action:@selector(tapBar2:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn2];
    
    proyolkBtn3=[[UIButton alloc]initWithFrame:CGRectMake(proyolkBtn2.frame.size.width+proyolkBtn2.frame.origin.x, 4,div+0.4, 50)];
    [proyolkBtn3 setTitle: @"Network" forState: UIControlStateNormal];
    //proyolkBtn1.textAlignment=NSTextAlignmentCenter;
    [proyolkBtn3 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [proyolkBtn3 setBackgroundColor:[UIColor colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f]];//[ff valueForKey:@"backcolor"];
    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    proyolkBtn3.tag=333;
    [proyolkBtn3 addTarget:self action:@selector(tapBar3:) forControlEvents:UIControlEventTouchUpInside];
    [viewfortable addSubview:proyolkBtn3];
    

    
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
    
    yellowcomm=[[UILabel alloc]initWithFrame:CGRectMake(0, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
    yellowcomm.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellowcomm.hidden=false;
    [viewfortable addSubview:yellowcomm];
    
    yellowcbnt=[[UILabel alloc]initWithFrame:CGRectMake(yellowcomm.frame.size.width+yellowcomm.frame.origin.x, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
    yellowcbnt.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellowcbnt.hidden=true;
    [viewfortable addSubview:yellowcbnt];
    
    yellownet=[[UILabel alloc]initWithFrame:CGRectMake(yellowcbnt.frame.size.width+yellowcbnt.frame.origin.x, proyolkBtn1.frame.size.height+proyolkBtn1.frame.origin.y, div, 5)];
    yellownet.backgroundColor=[UIColor colorWithRed:130.0f/255 green:197.0f/255 blue:246.0f/255 alpha:1.0f];//[ff valueForKey:@"clearColor"];
    yellownet.hidden=true;
    [viewfortable addSubview:yellownet];

    
    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(10, yellownet.frame.size.height+yellownet.frame.origin.y+2, viewfortable.frame.size.width-55, 30)];
    search_lbl.placeholder=@"Search";
    search_lbl.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0f];
    search_lbl.clipsToBounds=YES;
    search_lbl.delegate=vc1;
    search_lbl.backgroundColor=[UIColor colorWithRed:248.0f/255 green:250.0f/255 blue:251.0f/255 alpha:1.0f];
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = paddingView;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
     [search_lbl addTarget:self action:@selector(searchShare:) forControlEvents:UIControlEventEditingChanged];
    ////////////
    

    [viewfortable addSubview:search_lbl];
    
    
    Search=[[UIButton alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+7, yellownet.frame.size.height+yellownet.frame.origin.y+5, 30, 30)];
    [Search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Search.backgroundColor=[ff valueForKey:@"clearColor"];
    [Search setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [Search addTarget:self action:@selector(searchShare:) forControlEvents:UIControlEventTouchUpInside];
    Search.layer.cornerRadius=6;
    [Search setClipsToBounds:YES];
    [viewfortable addSubview:Search];
    
    
}
/*-(void)tapShareBar:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    if((int)tg.view.tag==0)
    {
        Search.tag=0;
        yellowcomm.hidden=false;
        yellowcbnt.hidden=true;
        yellownet.hidden=true;
        [sharedtable removeFromSuperview];
        [networktable removeFromSuperview];
    }
    else if ((int)tg.view.tag==1)
    {
        Search.tag=1;
        yellowcbnt.hidden=false;
        yellowcomm.hidden=true;
        yellownet.hidden=true;
        [communitytable removeFromSuperview];
        [networktable removeFromSuperview];
        iscallback=0;
        NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"StorageFrndz" :@"" :@"" :dic1 :self];
    }
    else if ((int)tg.view.tag==2)
    {
        Search.tag=2;
        yellowcbnt.hidden=true;
        yellowcomm.hidden=true;
        yellownet.hidden=false;
        iscallback=1;
        [communitytable removeFromSuperview];
        [sharedtable removeFromSuperview];
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        
        NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        [dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"StorageFrndzz" :@"" :@"" :dic1 :self];
    }
}*/

-(IBAction)tapBar1:(id)sender
//-(void)tapBar:(id)sender
{
    Search.tag=0;
    search_lbl.tag=0;
    yellowcomm.hidden=false;
    yellowcbnt.hidden=true;
    yellownet.hidden=true;
    [sharedtable removeFromSuperview];
    [networktable removeFromSuperview];

    [proyolkBtn1 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    [proyolkBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

-(IBAction)tapBar2:(id)sender
//-(void)tapBar:(id)sender
{
    Search.tag=1;
    search_lbl.tag=1;
    yellowcbnt.hidden=false;
    yellowcomm.hidden=true;
    yellownet.hidden=true;
    [communitytable removeFromSuperview];
    [networktable removeFromSuperview];
    iscallback=0;
    NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"StorageFrndz" :@"" :@"" :dic1 :self];

    [proyolkBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn2 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
    [proyolkBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(IBAction)tapBar3:(id)sender
//-(void)tapBar:(id)sender
{
    Search.tag=2;
    search_lbl.tag=2;
    yellowcbnt.hidden=true;
    yellowcomm.hidden=true;
    yellownet.hidden=false;
    iscallback=1;
    [communitytable removeFromSuperview];
    [sharedtable removeFromSuperview];
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    
    NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
    [dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
    [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"StorageFrndzz" :@"" :@"" :dic1 :self];

    [proyolkBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proyolkBtn3 setTitleColor:[UIColor colorWithRed:130.0f/255 green: 197.0f/255 blue:246.0f/255 alpha:1.0] forState:UIControlStateNormal];
}



-(IBAction)searchShare:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if((int)btn.tag==0)
    {
        iscallback=2;
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        [ dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
        [ dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:search_lbl.text forKey:@"mem"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"getSgMem" :@"" :@"" :dic1 :self];
        
    }
    else if ((int)btn.tag==1)
    {
        // cabinet simple seasrch
        iscallback=3;
        NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [ dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
        [ dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:search_lbl.text forKey:@"frnd"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"getSgFrnd" :@"" :@"" :dic1 :self];
        
        
    }
    else if((int)btn.tag==2)
    {
        // network simple search
        iscallback=4;
        NSString * fileid1=[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"];
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [ dic1 setObject:[NSString stringWithFormat:@"%@",fileid1] forKey:@"fId"];
        [ dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [dic1 setObject:search_lbl.text forKey:@"frnd"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"getSgFrndNet" :@"" :@"" :dic1 :self];
        
        
    }
}

-(IBAction)checkpoint:(id)sender
{
    UIButton *resultButton = (UIButton *)sender;
    fileindex=(int)resultButton.tag;
    [[fileAr objectAtIndex: fileindex] valueForKey:@"file_id"];
    
    fileIdis= [[[fileAr objectAtIndex:fileindex] valueForKey:@"file_id"] intValue];
    
    NSLog(@"My File Check===========%@",@"File Check===========%@");

    
    
    if([[resultButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"radiounselect.png"]])
    {
        [sender1 setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"radioselect.png"] forState:UIControlStateNormal];
        base.hidden=false;
        Filetable.frame =CGRectMake(0, middle_label.frame.size.height+middle_label.frame.origin.y,prMainView.frame.size.width,prMainView.frame.size.height-(option.frame.size.height+middle_label.frame.size.height+110));
        sender1=sender;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
        [self hidebaseMenu];
    }
    
}


-(void)hidebaseMenu
{
    base.hidden=true;
    Filetable.frame =CGRectMake(0, middle_label.frame.size.height+middle_label.frame.origin.y,prMainView.frame.size.width,prMainView.frame.size.height-(option.frame.size.height+middle_label.frame.size.height+70));
    
}
-(void) showMyfileView:(UIViewController *)vc:(NSArray *)data
{
    
    NSLog(@"heteere==================");
    
    storageFileAr =nil;
    
    scrollbar.frame=CGRectMake(0, 20, prhier2View.frame.size.width, prhier2View.frame.size.height);
    base.hidden=true;
    
    NSMutableDictionary *dd=[SavePrefrences sharedInstance].colorDictionry;
    fileAr=data;
    [self MainViewWithoutTitle:vc];
    
    filterlbl=[[UIImageView alloc] initWithFrame:CGRectMake(prMainView.frame.size.width-50, 10, 30, 30)];
    filterlbl.image=[UIImage imageNamed:@"filtericon1.png"];
    filterlbl.hidden=false;
    [NameLabel addSubview:filterlbl];
    
    three_dots=[[UIImageView alloc]initWithFrame:CGRectMake(prMainView.frame.size.width-50, 15, 20, 20)];
    three_dots.image=[UIImage imageNamed:@"more.png"];
    three_dots.hidden=true;
    [NameLabel addSubview:three_dots];
    
    UITapGestureRecognizer *sworkingreg2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openSettings)];
    [sworkingreg2 setNumberOfTouchesRequired:1];
    [sworkingreg2 setDelegate:self];
    three_dots.userInteractionEnabled = YES;
    three_dots.tag=0;
    [three_dots addGestureRecognizer:sworkingreg2];
    
    
    UIImageView *back=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 50, 25)];//10, 15, 25, 25)];
    back.image=[UIImage imageNamed:@"back1.png"];
    [NameLabel addSubview:back];
    
    UITapGestureRecognizer *filtericongesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissmainPop)];
    [filtericongesture1 setNumberOfTouchesRequired:1];
    [filtericongesture1 setDelegate:self];
    back.userInteractionEnabled = YES;
    [back addGestureRecognizer:filtericongesture1];
    
    UIImageView*logo=[[UIImageView alloc] initWithFrame:CGRectMake(NameLabel.frame.size.width/2-75,5,150, 50)];//back.frame.size.width+back.frame.origin.x+20,5, 120, 45)];
    logo.image=[UIImage imageNamed:@"logo_new.png"];
    [NameLabel addSubview:logo];
    arrData = [NSMutableArray array];
    UITapGestureRecognizer *filtericongesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filter_proyolk)];
    [filtericongesture setNumberOfTouchesRequired:1];
    [filtericongesture setDelegate:self];
    filterlbl.userInteractionEnabled = YES;
    [filterlbl addGestureRecognizer:filtericongesture];
    
    /*
     File Text and Indicator Color :- 52:127:103
     Folder Text and Indicator Color :- 108:114:41
     */
    option=[[UIView alloc]initWithFrame:CGRectMake(0,0, prMainView.frame.size.width, 40)];
    option.backgroundColor=[UIColor colorWithRed:244.0f/255 green:244.0f/255 blue:255.0f/255 alpha:1.0];
    [bodyview addSubview:option];
    
    Files=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width/2, 40)];
    Files.text=@"Files";
    Files.textAlignment=NSTextAlignmentCenter;
    [Files setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    Files.backgroundColor=[dd valueForKey:@"backcolor"];
    Files.textColor=[UIColor colorWithRed:52.0f/255 green: 127.0f/255 blue:103.0f/255 alpha:1.0];//[dd valueForKey:@"Yellowbtncolor"];
    [option addSubview:Files];
    
    Files_bar1=[[UILabel alloc]initWithFrame:CGRectMake(0, Files.frame.size.height+Files.frame.origin.y, prMainView.frame.size.width/2, 4)];
    Files_bar1.backgroundColor=[dd valueForKey:@"backcolor"];
    [option addSubview:Files_bar1];
    
    

    Files_bar2=[[UILabel alloc]initWithFrame:CGRectMake(0, Files.frame.size.height+Files.frame.origin.y, prMainView.frame.size.width/2, 4)];
    Files_bar2.backgroundColor=[UIColor colorWithRed:52.0f/255 green: 127.0f/255 blue:103.0f/255 alpha:1.0];
    Files_bar2.hidden=false;
    [option addSubview:Files_bar2];
    
    UITapGestureRecognizer *myFilr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMyFiles)];
    [myFilr setNumberOfTouchesRequired:1];
    [myFilr setDelegate:self];
    Files.userInteractionEnabled = YES;
    Files.tag=0;
    [Files addGestureRecognizer:myFilr];
    
    myfolder=[[UILabel alloc]initWithFrame:CGRectMake(Files.frame.size.width+Files.frame.origin.x, 0, prMainView.frame.size.width/2, 40)];
    myfolder.text=@"Folder";
    myfolder.textAlignment=NSTextAlignmentCenter;
    [myfolder setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    myfolder.backgroundColor=[dd valueForKey:@"backcolor"];
    myfolder.textColor=[UIColor colorWithRed:108.0f/255 green: 114.0f/255 blue:41.0f/255 alpha:1.0];//[dd valueForKey:@"Videocolor"];
    [option addSubview:myfolder];
    
    Myfolder_bar1=[[UILabel alloc]initWithFrame:CGRectMake(Files.frame.size.width+Files.frame.origin.x, myfolder.frame.size.height+myfolder.frame.origin.y, prMainView.frame.size.width/2, 4)];
    Myfolder_bar1.backgroundColor=[dd valueForKey:@"backcolor"];
    [option addSubview:Myfolder_bar1];
    
    Myfolder_bar2=[[UILabel alloc]initWithFrame:CGRectMake(Files.frame.size.width+Files.frame.origin.x, myfolder.frame.size.height+myfolder.frame.origin.y, prMainView.frame.size.width/2, 4)];
    Myfolder_bar2.backgroundColor=[UIColor colorWithRed:108.0f/255 green: 114.0f/255 blue:41.0f/255 alpha:1.0];
    Myfolder_bar2.hidden=true;
    [option addSubview:Myfolder_bar2];
    //
    UITapGestureRecognizer *myFldr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OpenFolder)];
    [myFldr setNumberOfTouchesRequired:1];
    [myFldr setDelegate:self];
    myfolder.userInteractionEnabled = YES;
    [myfolder addGestureRecognizer:myFldr];
    
    middle_label=[[UIView alloc]initWithFrame:CGRectMake(0, Files_bar2.frame.size.height+Files_bar2.frame.origin.y, prMainView.frame.size.width, 40)];
    middle_label.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [bodyview addSubview:middle_label];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, bodyview.frame.size.width, 1)];
    line1.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [middle_label addSubview:line1];

    search_lbl=[[UITextField alloc]initWithFrame:CGRectMake(5, 3.5, prMainView.frame.size.width-40, middle_label.frame.size.height-7)];
    search_lbl.backgroundColor=[UIColor colorWithRed:225.0f/255.0f green:232.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
    search_lbl.placeholder=@"File name or size";
    search_lbl.delegate=vc1;
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    search_lbl.leftView = paddingView;
    search_lbl.leftViewMode = UITextFieldViewModeAlways;
     [search_lbl addTarget:self action:@selector(SearchFiles) forControlEvents:UIControlEventEditingChanged];
    ////////////
    
    [middle_label addSubview:search_lbl];
    
    
    UIImageView *searchbutton=[[UIImageView alloc]initWithFrame:CGRectMake(search_lbl.frame.size.width+search_lbl.frame.origin.x+1, 3.5, 25,25)];
    searchbutton.backgroundColor=[UIColor clearColor];
    searchbutton.image=[UIImage imageNamed:@"search.png"];
    searchbutton.tag=3;
    [middle_label addSubview:searchbutton];
    
    UITapGestureRecognizer *searchreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SearchFiles)];
    [searchreg setNumberOfTouchesRequired:1];
    [searchreg setDelegate:self];
    searchbutton.userInteractionEnabled = YES;
    [searchbutton addGestureRecognizer:searchreg];
    
    Filetable = [[UITableView alloc] initWithFrame:CGRectMake(0, middle_label.frame.size.height+middle_label.frame.origin.y,prMainView.frame.size.width,prMainView.frame.size.height-(option.frame.size.height+middle_label.frame.size.height+70))];
    Filetable.delegate = self;
    Filetable.dataSource = self;
    Filetable.scrollEnabled = YES;
    Filetable.backgroundColor=[dd valueForKey:@"backcolor"];
    Filetable.separatorColor=[dd valueForKey:@"backcolor"];
    [bodyview addSubview:Filetable];
    
    
    
    
    
}

-(void)openSettings
{
    NSLog(@"im m i n setting  %f",prMainView.frame.size.height );
    [self MainSideView :vc1];
    sideview=[[UIView alloc]initWithFrame:CGRectMake(prMainView.frame.size.width-170, 0,170, 150)];
    sideview.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [prmainsideview addSubview:sideview];
    
    
    
    NSMutableArray *menuAr=[[NSMutableArray alloc]init];
    [menuAr addObject:@"  Upload File"];
    [menuAr addObject:@"  Create Folder"];
    [menuAr addObject:@"  Delete Folder"];
    
    float div=0;
    float hy=sideview.frame.size.height/3;
    
    for(int x=0; x<[menuAr count];x++)
    {
        UILabel *menu=[[UILabel alloc]initWithFrame:CGRectMake(2, div, sideview.frame.size.width,hy )];
        menu.text=[menuAr objectAtIndex:x];
        [menu setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        menu.textAlignment=NSTextAlignmentLeft;
        menu.tag=x;
        [sideview addSubview:menu];
        
        div=div+hy;
        
        UITapGestureRecognizer *searchreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openmenuItems:)];
        [searchreg setNumberOfTouchesRequired:1];
        [searchreg setDelegate:self];
        menu.userInteractionEnabled = YES;
        [menu addGestureRecognizer:searchreg];
        
    }
}





-(void)openmenuItems:(id)sender
{
    UITapGestureRecognizer *tg=(UITapGestureRecognizer*)sender;
    
    [sideview removeFromSuperview];
    [prmainsideview removeFromSuperview];
    
    if((int)tg.view.tag==0)
    {
        NSLog(@"uploading");
        [self reteriveFolderforFile];
        
        // [self uploadFile:vc1];
    }
    else if((int)tg.view.tag==1)
    {
        
        CreateNewFolderpop *cfpop=[[CreateNewFolderpop alloc]init];
        [cfpop createNewFolder:vc1:self];
        
        
        
        
        
        
        NSLog(@"creating folder");
    }
    else if((int)tg.view.tag==2)
    {
        
        //-(void) reterivefolderhierchy:(UIViewController *)vc
        
        DeleteFolderPop *dfpop=[[DeleteFolderPop alloc]init];
        [dfpop reterivefolderhierchy:vc1:self];
        
        
        NSLog(@"deleting folder");
    }
    
}

-(void)uploadFile:(UIViewController*)Vc
{
    ftbrowse=0;
    imgBuffer=@"";
    [self MainView:vc1 :@" Select File" :1];
    NSLog(@"height od namelabel  %f",NameLabel.frame.size.height);
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    scrollbar.backgroundColor=[ff valueForKey:@"Videocolor"];
    upld=[[UITextField alloc]initWithFrame:CGRectMake(30, NameLabel.frame.size.height+NameLabel.frame.origin.y+120,prMainView.frame.size.width/2+10,30)];
    upld.placeholder=@"Upload File";
    upld.backgroundColor=[UIColor whiteColor];
    upld.layer.cornerRadius=5;
    ///////////////
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    upld.leftView = paddingView;
    upld.leftViewMode = UITextFieldViewModeAlways;
    ////////////
    

    [prMainView addSubview:upld];
    
    
    int xspec=40;
    int wid=(scrollbar.frame.size.width-100)/3;
    NSMutableArray * type=[[NSMutableArray alloc]init];
    [type addObject:@" Video"];
    [type addObject:@" Image"];
    // [type addObject:@" Doc"];
    changetpeAr = [NSMutableArray array];
    
    for(int x=0;x<[type count];x++)
    {
        
        
        UIButton *imgarrow1 =[[UIButton alloc]initWithFrame:CGRectMake(xspec, NameLabel.frame.size.height+NameLabel.frame.origin.y+65, 25, 25)];
        imgarrow1.layer.cornerRadius=7.5;
        imgarrow1.layer.borderWidth=1.5;
        imgarrow1.backgroundColor=[UIColor whiteColor];
        imgarrow1.tag=x;
        [imgarrow1 setImage:[UIImage imageNamed: @"gray-radio.png"] forState:UIControlStateNormal];
        [imgarrow1 setImage:[UIImage imageNamed: @"white-radio.png"] forState:UIControlStateSelected];

        [imgarrow1 addTarget:self action:@selector(changeFileBrowse:) forControlEvents: UIControlEventTouchUpInside];
        [changetpeAr addObject:imgarrow1];
        
//        if(x==0)
//        {
//            //[imgarrow1 setImage:[UIImage imageNamed: @"gray-radio.png"] forState:UIControlStateNormal];
//            imgarrow1.backgroundColor=[UIColor grayColor];
//             //sender1=imgarrow1;
//        }
////        else
////        {
////            [imgarrow1 setImage:[UIImage imageNamed: @"white-radio.png"] forState:UIControlStateNormal];
////        }
        [prMainView addSubview:imgarrow1];
        
        
        
        UILabel *filetype=[[UILabel alloc]initWithFrame:CGRectMake(xspec+15, NameLabel.frame.size.height+NameLabel.frame.origin.y+65,wid+5, 25)];
        filetype.text= [NSString stringWithFormat:@"  %@  ",[type objectAtIndex:x]];  //NSStr[type objectAtIndex:x];
        filetype.textAlignment=NSTextAlignmentLeft;
        filetype.backgroundColor=[UIColor clearColor];
        [prMainView addSubview:filetype];
        
        xspec=xspec+wid+20;
        
    }
    
    
    
    
    
    
    UIButton *upl_btn=[[UIButton
                        alloc]initWithFrame:CGRectMake(upld.frame.size.width+upld.frame.origin.x+10,
                                                       NameLabel.frame.size.height+NameLabel.frame.origin.y+120 ,
                                                       prMainView.frame.size.width/2-80, 30)];
    [upl_btn setTitle:@"Browse" forState:UIControlStateNormal];
    [upl_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [upl_btn addTarget:self action:@selector(uploading:)
      forControlEvents:UIControlEventTouchUpInside];
    upl_btn.layer.cornerRadius=5;
    upl_btn.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
    [prMainView addSubview:upl_btn];
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(40,
                                                               upld.frame.size.height+upld.frame.origin.y+30, prMainView.frame.size.width/2-40,
                                                               40)];
    [save setTitle: @"Save" forState: UIControlStateNormal];
    save.backgroundColor=[ff valueForKey:@"clearClor"];
    [save addTarget:self action:@selector(Saveupload:)
   forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    save.layer.cornerRadius=6;
    save.tag=0;
    [save setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [prMainView addSubview:save];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(save.frame.size.width+save.frame.origin.x+10, upld.frame.size.height+upld.frame.origin.y+30, prMainView.frame.size.width/2-40, 40)];
    [cancel setTitle: @"Close" forState: UIControlStateNormal];
    [cancel setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [cancel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [cancel addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancel.layer.cornerRadius=6;
    [prMainView addSubview:cancel];
    
    
    scrollbar.frame=CGRectMake(20, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-40, cancel.frame.origin.y+10);
    [scrollbar setContentSize:CGSizeMake(scrollbar.frame.size.width, cancel.frame.origin.y+10)];
    
}


-(IBAction)buttonClick:(id)sender{
//    NSLog(@"uploading saved  ==%d",selectedfolId);
//    
//    iscallback=18;
//    
//    NSMutableArray *arrData  = [tree getSelectedValue];
//    
//    if (arrData.count<=0) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk"  message:@"Select Folder First."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    else{
//        if(imgBuffer.length>10)
//        {
//            selectedfolId  = [[arrData lastObject]integerValue];;
//            NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
//            [dic setValue:[SavePrefrences sharedInstance].uid forKey :@"id"];
//            [dic setValue:[NSString stringWithFormat:@"%d",selectedfolId] forKey:@"pfid"];
//            [dic setValue:randomImgName forKey:@"upfile"];
//            if(ftbrowse==0)
//                [dic setValue:@".mp4" forKey:@"upfileExt" ];
//            
//            if(ftbrowse==1)
//                [dic setValue:@".png" forKey: @"upfileExt"];
//            
//            [dic setValue:[NSString stringWithFormat:@"%d",(int)imgBuffer.length] forKey:@"size"];
//            [dic setValue:imgBuffer forKey:@"buffer1"];
//            
//            [[SavePrefrences sharedInstance].skthand emitData:@"MyFolders" :@"uploadFile" :@"" :@"" :dic :self];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk"  message:@"Select File First."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }
//    
    [prMainView removeFromSuperview];
}


- (void)changeFileBrowse: (id) sender
{
    
    
    
    for (UIButton *btn in changetpeAr) {
        [btn setBackgroundColor:[UIColor whiteColor]];
    }
    UIButton *tappedButton = (UIButton*)sender;
    [tappedButton setBackgroundColor:[UIColor grayColor]];
//    UIButton *btnVideo = (UIButton *)[prMainView viewWithTag:500];
//    UIButton *btnImage = (UIButton *)[prMainView viewWithTag:501];
//    if (btnImage.tag == tappedButton.tag) {
//        [btnImage setSelected:YES];
//        [btnVideo setSelected:NO];
//    }
//    else{
//        [btnImage setSelected:NO];
//        [btnVideo setSelected:YES];
//    }
//    
    
   // ftbrowse=(int)tappedButton.tag;
    
    
//    NSLog(@"ft browse====%d",ftbrowse);
//    
//    for(int x=0;x<[changetpeAr count];x++)
//    {
//       UIButton * chkBtn=[changetpeAr objectAtIndex:x];
//        chkBtn.backgroundColor=[UIColor whiteColor];
//        
//    }
//    
//    UIButton * btn= [changetpeAr objectAtIndex:ftbrowse];
//    btn .backgroundColor=[UIColor grayColor];
//  
   
    
    
    
    
//    NSLog(@"sender current Image====%@",tappedButton.currentImage);
//    
//    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"white-radio.png"]])
//    {
//        [sender  setImage:[UIImage imageNamed: @"gray-radio.png"] forState:UIControlStateNormal];
//        
//    }
//    else
//    {
//        [sender  setImage:[UIImage imageNamed: @"white-radio.png"] forState:UIControlStateNormal];
//    }
//        sender1=sender;
//
//       NSLog(@" file browse type %d",ftbrowse);
}




-(IBAction)uploading:(id)sender
{
    
    
    if(ftbrowse==0)//video
    {
        
       UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.view.tag = 101;
        randomImgName = [self randomImagName];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,      nil];
        [vc1 presentModalViewController:imagePicker animated:YES];
        
      //  [mar showMessageToUser];
        
        
        
    }
    else if (ftbrowse==1)//images
    {
        
        
        //[self openDocument];
        [self chooseOption];
        
        
    }
    else if(ftbrowse==2)//doc
    {
        
    }
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    if(ftbrowse==0)
    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Loading...." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        [alert show];
       
              //[alert dismissWithClickedButtonIndex:0 animated:NO];
            [self dismissModalViewControllerAnimated:YES];
            [picker dismissViewControllerAnimated:true completion:^{
                NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
                NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
                NSString *moviePath = [videoUrl path];
                if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
                    
                    
                    
                    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
                        UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
                    }
                    NSData *videoData = [NSData dataWithContentsOfFile:moviePath];
                    
                    imgBuffer = [videoData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                    
                    
                }
               

              //  [self uploadVideo:moviePath];
                    // }
            }];
            
            
            
    
               
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
        
        [alert dismissWithClickedButtonIndex:0 animated:NO];
        
        
    }
    
    
}



-(IBAction)Saveupload:(id)sender
{
    NSLog(@"uploading saved  ==%d",selectedfolId);
    
    iscallback=18;
    
    NSMutableArray *arrData  = [tree getSelectedValue];
    
    if (arrData.count<=0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk"  message:@"Select Folder First."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        if(imgBuffer.length>10)
        {
            selectedfolId  = [[arrData lastObject]integerValue];;
            NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
            [dic setValue:[SavePrefrences sharedInstance].uid forKey :@"id"];
            [dic setValue:[NSString stringWithFormat:@"%d",selectedfolId] forKey:@"pfid"];
            [dic setValue:randomImgName forKey:@"upfile"];
            if(ftbrowse==0)
                [dic setValue:@".mp4" forKey:@"upfileExt" ];
            
            if(ftbrowse==1)
                [dic setValue:@".png" forKey: @"upfileExt"];
            
            [dic setValue:[NSString stringWithFormat:@"%d",(int)imgBuffer.length] forKey:@"size"];
            [dic setValue:imgBuffer forKey:@"buffer1"];
            
            [[SavePrefrences sharedInstance].skthand emitData:@"MyFolders" :@"uploadFile" :@"" :@"" :dic :self];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Proyolk"  message:@"Select File First."delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    [prMainView removeFromSuperview];

    
    
    
    //
    //
    //
    
    
    //    f(SplashScreen.imagedata.size()>0) {
    //        try {
    //            JSONObject obj = new JSONObject();
    //            obj.put(“id”, prefdBk.get(0));
    //            obj.put(“pfid”, pfid);//33
    //            obj.put(“upfile”, SplashScreen.imagedata.get(0));
    //            obj.put(“upfileExt”, SplashScreen.imagedata.get(3));
    //            obj.put(“size”, SplashScreen.imagedata.get(1));
    //            obj.put(“buffer1”, SplashScreen.imagedata.get(2));
    //            count = 0;
    //            SplashScreen.hnd.emitData(“MyFolders”, “uploadFile”, "", "", obj, new PJSCallBack() {
    //                @Override
    //                public Object callback(JSONObject meta, final JSONArray data) {
    //                    runOnUiThread(new Runnable() {
    //                        @Override
    //                        public void run() {
    //                            Toast.makeText(getApplicationContext(), “Uploaded !”, Toast.LENGTH_LONG).show();
    //
    //                        }
    //                    });
    //                    return null;
    //                }
    //            });
    //        } catch (Exception e) {
    //            e.printStackTrace();
    //        }
    //
    //    }
    
    
    
    
    
    
    
    
    
    
    
    
}

-(void)SearchFiles
{
    
    iscallback=11;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setObject:search_lbl.text forKey:@"in"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyFiles" :@"SearchFiles" :@"":@"":dic :self];
    
}


-(void)openMyFiles
{
    /*
     File Text and Indicator Color :- 52:127:103
     Folder Text and Indicator Color :- 108:114:41
     */


    filterlbl.hidden=false;
    three_dots.hidden=true;
    NSLog(@"file opened");
    Files.textColor=[UIColor colorWithRed:52.0/255.0 green:127.0/255.0 blue:103.0/255.0 alpha:1];
    myfolder.textColor=[UIColor colorWithRed:108.0/255.0 green:114.0/255.0 blue:41.0/255.0 alpha:1];
    iscallback=6;
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setValue:@"0" forKey:@"cs"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyFiles" :@"getAllFiles" :@"":@"":dic :self];
    
}
-(void)CommunitytableView
{
    inviteAr=[[NSMutableArray alloc]init];
    communitytable = [[UITableView alloc] initWithFrame:CGRectMake(0, search_lbl.frame.size.height+search_lbl.frame.origin.y+5,viewfortable.frame.size.width,viewfortable.frame.size.height-search_lbl.frame.size.height-search_lbl.frame.origin.y)];
    communitytable.delegate = self;
    communitytable.dataSource = self;
    communitytable.scrollEnabled = YES;
    communitytable.backgroundColor=[UIColor  colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    communitytable.separatorColor=[UIColor  colorWithRed:220.0f/255.0f green:229.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    [viewfortable addSubview:communitytable];
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

-(void)OpenFolder
{
    
  /*  UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(0, option.frame.size.height-2, option.frame.size.width, 2)];
    lblline.backgroundColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
    [option addSubview:lblline];*/

    NSLog(@"Folder opened");
    filterlbl.hidden=true;
    three_dots.hidden=false;
    middle_label.hidden=true;
    Files_bar2.hidden=true;
    storageFileAr=nil;
    
    
    Myfolder_bar2.hidden=false;
    [Filetable removeFromSuperview];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
   /* myfolder.textColor=[ff valueForKey:@"Yellowbtncolor"];
    Files.textColor=[ff valueForKey:@"Yellowbtncolor"];*/
    
    Files.textColor=[UIColor colorWithRed:52.0/255.0 green:127.0/255.0 blue:103.0/255.0 alpha:1];
    myfolder.textColor=[UIColor colorWithRed:108.0/255.0 green:114.0/255.0 blue:41.0/255.0 alpha:1];

    option.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    prMainView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    
    
    iscallback=14;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"MyFolders" :@"getFolders" :@"" :@"" :dic :self];
    
}



-(void)filterpopup:(UIViewController *)vc dictFilter:(NSMutableDictionary *)dictFil
{
    NSLog(@"filter value in storage........");
    [self MainView:vc:@"Filters":1];
    
    scrollbar.frame=CGRectMake( 4, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-8, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+120));
    
    [scrollbar setContentSize:CGSizeMake(scrollbar.frame.size.width, 200)];
    
    
    NSMutableArray *sortAr=[[NSMutableArray alloc]init];
    [sortAr addObject:@"Document"];
    [sortAr addObject:@"Sheets"];
    [sortAr addObject:@"Media"];
    
   int hy=NameLabel.frame.size.height+NameLabel.frame.origin.y+20;
    for(int x=0;x<[sortAr count];x++ )
    {
        UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(hy+10,8, 15,  15)];
        img.layer.cornerRadius=7.5;
        [img addTarget:self action:@selector(clickIT:) forControlEvents: UIControlEventTouchUpInside];
        [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        [img setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateSelected];
        img.tag=100+x;
        [scrollbar addSubview:img];
        
        UILabel *doc=[[UILabel alloc]initWithFrame:CGRectMake(hy+30, 1, 150, 25)];
        [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        doc.textColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
        if (x==0) {
            NSString *obj = [dictFil objectForKey:@"filter-1"];
            if (obj.length>0) {
                [img setSelected:YES];
            }
            
        }
        else if (x==1) {
            NSString *obj = [dictFil objectForKey:@"filter-2"];
            if (obj.length>0) {
                [img setSelected:YES];
            }
        }
        else if (x==2) {
            NSString *obj = [dictFil objectForKey:@"filter-3"];
            if (obj.length>0) {
                [img setSelected:YES];
            }
        }
        
        doc.text=[sortAr objectAtIndex: x];
        [scrollbar addSubview:doc];
        hy=hy+100;
    }
    
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake((scrollbar.frame.size.width/2)-105, 60, 100, 25)];
    [submit setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    submit.backgroundColor=[UIColor clearColor];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitFilter:) forControlEvents:UIControlEventTouchUpInside];
    submit.layer.cornerRadius=6;
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];

    [submit setClipsToBounds:YES];
    [scrollbar addSubview:submit];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake((scrollbar.frame.size.width/2)+5, 60, 100, 25)];
    [close setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    close.backgroundColor=[UIColor clearColor];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    close.layer.cornerRadius=6;
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];

    [close setClipsToBounds:YES];
    [scrollbar addSubview:close];
    
    
    scrollbar.frame=CGRectMake(4, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-8, 120);
    
    
}

-(IBAction)clickIT:(id)sender
{
    UIButton *tg=(UIButton*)sender;
    sortIt=(int)tg.tag;
    
    if(sortIt==100 || sortIt==101 || sortIt==102)
    {
        if (tg.selected) {
            [tg setSelected:NO];
           
        }
        else{
            
            
            [tg setSelected:YES];
        }
//        sender1=sender;
//        [sender1 setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
//        
//        [sender setImage:[UIImage imageNamed:@"radioselect.png"] forState:UIControlStateNormal];
    }
    
    
}
-(IBAction)submitFilter:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    UIButton *btnDocuments = (UIButton *)[scrollbar viewWithTag:100];
    UIButton *btnSheets = (UIButton *)[scrollbar viewWithTag:101];
    UIButton *btnMedia = (UIButton *)[scrollbar viewWithTag:102];
    iscallback=8;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    dictFilter  = [NSMutableDictionary dictionary];
    dictFilter  = [NSMutableDictionary dictionary];
    if(btnDocuments.selected)
    {
        [dictFilter setObject:@"flt1" forKey:@"filter-1"];
        [dic1 setObject:@"flt1" forKey:@"k"];
    }
    if (btnSheets.selected)
    {
        [dictFilter setObject:@"flt2" forKey:@"filter-2"];
        [dic1 setObject:@"flt2" forKey:@"l"];
    }
    if (btnMedia.selected)
    {
        [dictFilter setObject:@"flt3" forKey:@"filter-3"];
        [dic1 setObject:@"flt3" forKey:@"m"];
    }
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [ dic setObject:dic1 forKey:@"tp"];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"filter" :@"":@"":dic :self];
    
}
-(void)filter_proyolk
{
    NSLog(@"filter value of storage.......");
    [self MainView:vc1:@"Filters":1];
    
    scrollbar.frame=CGRectMake( 4, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-30, [SavePrefrences sharedInstance ].screenWidth-8, 180);
    
    [scrollbar setContentSize:CGSizeMake(scrollbar.frame.size.width, 180)];
    
    
    NSMutableArray *sortAr=[[NSMutableArray alloc]init];
    [sortAr addObject:@"All"];
    [sortAr addObject:@"Documents"];
    [sortAr addObject:@"Picture"];
    [sortAr addObject:@"Video"];
    [sortAr addObject:@"Podcast"];
    
    
   /* int hy=NameLabel.frame.size.height+NameLabel.frame.origin.y;
    for(int x=0;x<[sortAr count];x++ )
    {
        UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(15,hy+5, 15,  15)];
        img.layer.cornerRadius=7.5;
        [img addTarget:self action:@selector(filterselecttap:) forControlEvents: UIControlEventTouchUpInside];
        [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        img.tag=x;
        [scrollbar addSubview:img];
        
        
        
        UILabel    *doc=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+5, hy, 150, 25)];
        [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
        doc.textColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
        doc.text=[sortAr objectAtIndex: x];
        [scrollbar addSubview:doc];
        
        hy=hy+50;
        
    }*/
    
    int hy=scrollbar.frame.size.width+scrollbar.frame.origin.x-350;
    for(int x=0;x<[sortAr count];x++ )
    {
        
        if (x==0||x==1||x==2)
        {
            UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(hy+5, 18, NameLabel.frame.size.width/3, 30)];
            descriptionView.backgroundColor=[UIColor clearColor];
            // descriptionView.clipsToBounds=YES;
            [scrollbar addSubview:descriptionView];
            
            UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(0,5, 15,  15)];
            img.layer.cornerRadius=7.5;
            [img addTarget:self action:@selector(filterselecttap:) forControlEvents: UIControlEventTouchUpInside];
            if ([arrData containsObject:[NSString stringWithFormat:@"%d",x]]) {
                [img setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
            }
            else{
                [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
            }
                img.tag=x;
            [descriptionView addSubview:img];
            
            UILabel *doc=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 25)];
            [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
            doc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0];
            doc.text=[sortAr objectAtIndex: x];
            [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [descriptionView addSubview:doc];
            
            hy=hy+110;

        }
        
        if (x==3)
        {
            UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2-scrollbar.frame.size.width/4, 50, 100, 30)];
            descriptionView.backgroundColor=[UIColor clearColor];
            // descriptionView.clipsToBounds=YES;
            [scrollbar addSubview:descriptionView];
            
            UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(0,5, 15,  15)];
            img.layer.cornerRadius=7.5;
            [img addTarget:self action:@selector(filterselecttap:) forControlEvents: UIControlEventTouchUpInside];
            [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
            if ([arrData containsObject:[NSString stringWithFormat:@"%d",x]]) {
                [img setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
            }
            else{
                [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
            }
            img.tag=x;
            [descriptionView addSubview:img];
            
            UILabel *doc=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 25)];
            [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
            doc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0];
            doc.text=[sortAr objectAtIndex: x];
            [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [descriptionView addSubview:doc];
            
        }
        if (x==4)
        {
            UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2-scrollbar.frame.size.width/4+100, 50, 100, 30)];
            descriptionView.backgroundColor=[UIColor clearColor];
            // descriptionView.clipsToBounds=YES;
            [scrollbar addSubview:descriptionView];
            
            UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(0,5, 15,  15)];
            img.layer.cornerRadius=7.5;
            if ([arrData containsObject:[NSString stringWithFormat:@"%d",x]]) {
                [img setImage:[UIImage imageNamed: @"radioselect.png"] forState:UIControlStateNormal];
            }
            else{
                [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
            }
            [img addTarget:self action:@selector(filterselecttap:) forControlEvents: UIControlEventTouchUpInside];
            [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
            img.tag=x;
            [descriptionView addSubview:img];
            
            UILabel *doc=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 25)];
            [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
            doc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0];
            doc.text=[sortAr objectAtIndex: x];
            [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            [descriptionView addSubview:doc];
            
        }

    }

    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake(scrollbar.frame.size.width/2-scrollbar.frame.size.width/4, 100, 80, 25)];
    [submit setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    submit.backgroundColor=[UIColor clearColor];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitprykFilter:) forControlEvents:UIControlEventTouchUpInside];
    submit.layer.cornerRadius=6;
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [submit setClipsToBounds:YES];
    [scrollbar addSubview:submit];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(submit.frame.origin.x+submit.frame.size.width+20, 100, 80, 25)];
    [close setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    close.backgroundColor=[UIColor clearColor];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
    close.layer.cornerRadius=6;
    [close setClipsToBounds:YES];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];

    [scrollbar addSubview:close];
    
    
}

-(IBAction)filterselecttap:(id)sender
{
    UIButton *tg=(UIButton*)sender;
    sortpryk=(int)tg.tag;
    if (![arrData containsObject:[NSString stringWithFormat:@"%d",sortpryk]]) {
        [arrData addObject:[NSString stringWithFormat:@"%d",sortpryk]];
    }
    else{
        [arrData removeObject: [NSString stringWithFormat:@"%d",sortpryk]];
    }
    
    if(sortpryk==0 || sortpryk==1 || sortpryk==2 || sortpryk==3 ||sortpryk==4)
    {
        [sender1 setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
        sender1=sender;
        [sender setImage:[UIImage imageNamed:@"radioselect.png"] forState:UIControlStateNormal];
    }
    
    
}
-(IBAction)cancelButton:(id)sender{
    arrData = [NSMutableArray array];
    int cnt=(int)[popUpAr count]-1;
    NSLog(@"pop ar count===%d",cnt);
    
    if([popUpAr count]>0)
    {
        UIView *ppv=[popUpAr objectAtIndex:cnt] ;
        [ppv removeFromSuperview];
        [popUpAr removeObjectAtIndex:cnt];
        
    }


}

-(IBAction)submitprykFilter:(id)sender
{
    
    iscallback=10;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [dic setObject:@"0" forKey:@"cs"];
     [dic setObject:@"0" forKey:@"limit"];
    
    
    NSString * mod=@"getAllFiles";
    
   
    
    
    if(sortpryk==0)
    {
        mod=@"getAllFiles";
    }
    else if (sortpryk==1)
    {
        mod=@"getDocFiles";
    }
    else if (sortpryk==2)
    {
        mod=@"getPicFiles";
        
    }
    else if (sortpryk==3)
    {
        mod=@"getVideoFiles";
    }
    else if (sortpryk==4)
    {
        mod=@"getPodFiles";
    }
    
    [[SavePrefrences sharedInstance].skthand emitData:@"MyFiles" :mod :@"":@"":dic :self];
   // [self dissmissmainPop];
    
}
-(void)sortedfilter:(UIViewController *)vc dictFilter:(NSMutableDictionary *)dictFil
{
    [self MainView:vc:@"Sort By":1];
    dictFilter  = dictFil;
    scrollbar.frame=CGRectMake(4, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, [SavePrefrences sharedInstance ].screenWidth-8, [SavePrefrences sharedInstance ].screenHeight-([SavePrefrences sharedInstance ].naviHght+[SavePrefrences sharedInstance ].stbarHght+120));
    
    NSMutableArray *sortAr=[[NSMutableArray alloc]init];
    [sortAr addObject:@"Size"];
    [sortAr addObject:@"Recent"];
    [sortAr addObject:@"Owner"];
    [sortAr addObject:@"Name"];
    
    int hy=NameLabel.frame.size.height+NameLabel.frame.origin.y;
    
    for(int x=0;x<[sortAr count];x++ )
    {
        UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(hy+20,8, 15,  15)];
        img.layer.cornerRadius=7.5;
        [img addTarget:self action:@selector(sortbytap:) forControlEvents: UIControlEventTouchUpInside];
        [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
        img.tag=x;
        [scrollbar addSubview:img];
        
        
        
        UILabel *doc=[[UILabel alloc]initWithFrame:CGRectMake(hy+40, 1, 100, 25)];
        [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        doc.textColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
        doc.text=[sortAr objectAtIndex: x];
        [scrollbar addSubview:doc];
        
        hy=hy+100;
        
    }
    
//    int hy=scrollbar.frame.size.width+scrollbar.frame.origin.x-350;
//    
//    for(int x=0;x<[sortAr count];x++ )
//    {
//        UIView *descriptionView=[[UIView alloc]initWithFrame:CGRectMake(hy+2, 8, NameLabel.frame.size.width/3, 30)];
//        descriptionView.backgroundColor=[UIColor clearColor];
//        [scrollbar addSubview:descriptionView];
//
//        UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(0,5, 15,  15)];
//        img.layer.cornerRadius=7.5;
//        [img addTarget:self action:@selector(sortbytap:) forControlEvents: UIControlEventTouchUpInside];
//        [img setImage:[UIImage imageNamed: @"radiounselect.png"] forState:UIControlStateNormal];
//        img.tag=x;
//        [descriptionView addSubview:img];
//        
//        UILabel *doc=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 25)];
//        [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
//        doc.backgroundColor=[UIColor clearColor];
//        doc.textColor=[UIColor colorWithRed:153.0f/255 green:153.0f/255 blue:153.0f/255 alpha:1.0];
//        doc.text=[sortAr objectAtIndex: x];
//        [descriptionView addSubview:doc];
//        
//      /*  UITapGestureRecognizer *ind = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sortbytap:)];
//        [ind setNumberOfTouchesRequired:1];
//        [ind setDelegate:self];
//        doc.userInteractionEnabled = YES;
//        [doc addGestureRecognizer:ind];*/
//
//        hy=hy+80;
//        
//    }
    
    
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake((scrollbar.frame.size.width/2)-105, 60, 100, 25)];
    [submit setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    submit.backgroundColor=[UIColor clearColor];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitSort:) forControlEvents:UIControlEventTouchUpInside];
    submit.layer.cornerRadius=6;
    [submit setClipsToBounds:YES];
    [submit setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [scrollbar addSubview:submit];
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake((scrollbar.frame.size.width/2)+5, 60, 100, 25)];
    [close setTitleColor:[UIColor colorWithRed: 0.0f/255.0f green:49.0f/255.0f blue:99.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    close.backgroundColor=[UIColor clearColor];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    [close addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    close.layer.cornerRadius=6;
    
    
    [close setClipsToBounds:YES];
    [scrollbar addSubview:close];
    
    scrollbar.frame=CGRectMake(4, NameLabel1.frame.size.height+NameLabel1.frame.origin.y-20, prMainView.frame.size.width-8, 120);

    [scrollbar setContentSize:CGSizeMake(scrollbar.frame.size.width, close.frame.size.height+close.frame.origin.y)];

}

-(IBAction)sortbytap:(id)sender
{
    
    UIButton *tg=(UIButton *)sender;
    sortnew=(int)tg.tag;
    
    if(sortnew==0||sortnew==1||sortnew==2||sortnew==3)
    {
        [sender1 setImage:[UIImage imageNamed:@"radiounselect.png"]forState:UIControlStateNormal];
        sender1=sender;
        [sender1 setImage:[UIImage imageNamed:@"radioselect.png"] forState:UIControlStateNormal];
        
    }
    
    
}
-(IBAction)submitSort:(id)sender
{
    
    if(sortnew==0)
    {
        sortnew=3;
    }
    else if(sortnew==1)
    {
        sortnew=2;
    }
    else  if(sortnew==2)
    {
        sortnew=1;
    }
    else  if(sortnew==3)
    {
        sortnew=4;
    }
    iscallback=19;
    if (dictFilter.count>0) {
        NSError * err;
//        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictFilter options:0 error:&err];
//        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:dictFilter forKey:@"tp"];
        [dic1 setObject:@"0" forKey:@"limit"];
        [dic1 setObject:[NSString stringWithFormat:@"%d",sortnew] forKey:@"val"];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"filter" :@"":@"":dic1 :self];
    }
    else{
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setObject:[NSString stringWithFormat:@"%d",sortnew] forKey:@"val"];
        [dic1 setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
        [dic1 setObject:@"0" forKey:@"limit"];

        
        [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"getInbox" :@"":@"":dic1 :self];
    }
    
    
}

-(IBAction)cancel:(id)sender
{
    NSLog(@"hello world ");

    
    UIButton *btn=(UIButton*)sender;
    UIButton *btnDocuments = (UIButton *)[scrollbar viewWithTag:100];
    UIButton *btnSheets = (UIButton *)[scrollbar viewWithTag:101];
    UIButton *btnMedia = (UIButton *)[scrollbar viewWithTag:102];
    iscallback=8;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    dictFilter  = [NSMutableDictionary dictionary];
    dictFilter  = [NSMutableDictionary dictionary];
    
    
//    if(btnDocuments.selected)
//    {
//        [dictFilter setObject:@"filter-1" forKey:@"flt1"];
//        [dic1 setObject:@"flt1" forKey:@"k"];
//    }
//    if (btnSheets.selected)
//    {
//        [dictFilter setObject:@"filter-2" forKey:@"flt2"];
//        [dic1 setObject:@"flt2" forKey:@"l"];
//    }
//    if (btnMedia.selected)
//    {
//        [dictFilter setObject:@"filter-3" forKey:@"flt3"];
//        [dic1 setObject:@"flt3" forKey:@"m"];
//    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [ dic setObject:dic1 forKey:@"tp"];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"filter" :@"":@"":dic :self];
    
    [self dissmisspop];
}
-(void)dissmisspop1
{
    int cnt=(int)[popUpAr count]-1;
    NSLog(@"pop ar count===%d",cnt);
    
    if([popUpAr count]>0)
    {
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
-(void)dissmisspop
{
    int cnt=(int)[popUpAr count]-1;
    NSLog(@"pop ar count===%d",cnt);
    
    if([popUpAr count]>0)
    {
        UIView *ppv=[popUpAr objectAtIndex:cnt] ;
        [ppv removeFromSuperview];
        [popUpAr removeObjectAtIndex:cnt];
        
    }
//    if([popUpAr count]==0)
//    {
        id<CallTo_Parent>  cb= vc1;
        [cb callMethod:backData];
//    }
}


-(void)dissmisspopHierchy2
{
    int cnt=(int)[popArforHierchy count]-1;
    NSLog(@"pop ar popArforHierchy count===%d",cnt);
    
    if([popArforHierchy count]>1)
    {
        UIView *ppv=[popArforHierchy objectAtIndex:cnt] ;
        [ppv removeFromSuperview];
        [popArforHierchy removeObjectAtIndex:cnt];
        
    }
    
}







//=====================satart hierarchy 2=============

-(void)Showmoveto2:(int)folderid
{
    prhier2View = [[UIView alloc] initWithFrame:CGRectMake(0,Files_bar1.frame.origin.y+Files_bar1.frame.size.height,bodyview.frame.size.width-100,bodyview.frame.size.height)];
    prhier2View.backgroundColor=[UIColor colorWithRed:244.0/255 green:244.0/255 blue:255.0/255 alpha:1];
    [bodyview addSubview:prhier2View];
    bodyview.backgroundColor = [UIColor clearColor];
 

    
    if([popArforHierchy count]>0)
    {
        [popArforHierchy addObject:prhier2View];
    }
    else{
        
        popArforHierchy =[[NSMutableArray alloc]init];
        [popArforHierchy addObject:prhier2View];
    }
    
    
    if(folderid>0)
    {
        UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 25, 25)];
        [bckarrow setImage:[UIImage imageNamed:@"back11.png"]];
        bckarrow.userInteractionEnabled=YES;
        bckarrow.backgroundColor=[UIColor clearColor];
        [prhier2View addSubview:bckarrow];
        

        UILabel *doc=[[UILabel alloc]initWithFrame:CGRectMake(bckarrow.frame.size.width+bckarrow.frame.origin.x+50, 2, bodyview.frame.size.width-80, 20)];
        [doc setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
        doc.textColor=[UIColor colorWithRed:78.0f/255 green:119.0f/255 blue:145.0f/255 alpha:1.0];
        
        
        for(int x=0;x<[getFoldernamedic count];x++)
        {
            NSString * name= [getFoldernamedic objectAtIndex:x];
            
            NSArray * Ar=[name componentsSeparatedByString:@"-"];
            
            
            if([[Ar objectAtIndex:1] intValue]==fidfrfile)
            {
                doc.text=Ar[0];
                break;
            }
            
        }
        
        
        [prhier2View addSubview:doc];
        
        UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, doc.frame.size.height+doc.frame.origin.y+4, bodyview.frame.size.width, 1)];
        [line setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
        line.backgroundColor=[UIColor whiteColor];
        [prhier2View addSubview:line];
        
        
        UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspopHierchy2)];
        [communityeg setNumberOfTouchesRequired:1];
        [communityeg setDelegate:self];
        bckarrow.userInteractionEnabled = YES;
        [bckarrow addGestureRecognizer:communityeg];
        
    }
    
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, 90, bodyview.frame.size.height)];
    [scrollbar setContentSize:CGSizeMake(90, [SavePrefrences sharedInstance].screenHeight-40)];
    //scrollbar.backgroundColor=[UIColor redColor];
    [prhier2View addSubview:scrollbar];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, scrollbar.frame.size.width, 1)];
    line1.backgroundColor=[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [scrollbar addSubview:line1];
    
    
    [scrollbar1 removeFromSuperview];
    scrollbar1=[[UIScrollView alloc]initWithFrame:CGRectMake(90,30, bodyview.frame.size.width-90, bodyview.frame.size.height)];
    [scrollbar1 setContentSize:CGSizeMake([SavePrefrences sharedInstance].screenWidth, [SavePrefrences sharedInstance].screenHeight-40)];
   // scrollbar1.backgroundColor=[UIColor redColor];
    [prhier2View addSubview:scrollbar1];
    

    [self showfiles:folderid];
}
//here color problm
-(void)showfiles:(int) folderid
{
    int yincr=10;
    int xincr=10;
    selectedfolId=0;
    
    for(int x=0;  x<[folderArdata count];x++)
    {
        
        int parent_fid=[[[folderArdata objectAtIndex:x] valueForKey:@"parent_fid"] intValue];
        if(parent_fid==folderid)
        {
            
            NSString *folder_name=[[folderArdata objectAtIndex:x] valueForKey:@"folder_name"];
            NSString *folder_id=[[folderArdata objectAtIndex:x] valueForKey:@"folder_id"];
            
            [getFoldernamedic addObject:[folder_name stringByAppendingString:[NSString stringWithFormat:@"-%@",folder_id]]];
            UIImageView  *folderimg=[[UIImageView alloc]initWithFrame:CGRectMake(xincr, yincr, 40,40)];
            folderimg.backgroundColor=[UIColor clearColor];
            [folderimg setImage:[UIImage imageNamed:@"folderimg1.png"]];
            folderimg.tag=[folder_id intValue];
            [scrollbar addSubview:folderimg];
            
            UITextView  *folderName  =[[UITextView alloc]initWithFrame:CGRectMake(xincr, folderimg.frame.origin.y+folderimg.frame.size.height, 80,40)];
            folderName.textColor=[UIColor blackColor];
            folderName.font=[UIFont boldSystemFontOfSize:10];
            folderName.backgroundColor=[UIColor clearColor];
            folderName.text=folder_name;
            folderName.tag=[folder_id intValue];
            folderName.userInteractionEnabled=NO;
            folderName.textAlignment=NSTextAlignmentLeft;
            [scrollbar addSubview:folderName];
            
            UITapGestureRecognizer *openges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFolder2:)];
            [openges setNumberOfTouchesRequired:1];
            [openges setDelegate:self];
            folderimg.userInteractionEnabled = YES;
            [folderimg addGestureRecognizer:openges];
            
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:   self action:@selector(openNewFolder2:)];
            doubleTap.numberOfTapsRequired = 2;
            [folderimg addGestureRecognizer:doubleTap];
            
            [openges requireGestureRecognizerToFail:doubleTap];
            
            xincr=xincr+90;
            
            if(xincr>scrollbar.frame.size.width)
            {
                xincr=10;
                yincr=yincr+85;
            }
        }
    }
     [scrollbar setContentSize:CGSizeMake(90, yincr+90)];
    
    
    xincr = 10;
    yincr = 10;

    NSMutableArray *arrSubViews = [scrollbar1 subviews];
    for (UIView *subView in arrSubViews) {
        [subView removeFromSuperview];
    }
   
    
    for(int x=0;x<[storageFileAr count];x++)
    {
        NSString *file_name1  =[[storageFileAr  objectAtIndex:x]valueForKey:@"file_name1"];
        
        NSString *file_size  =[[storageFileAr  objectAtIndex:x]valueForKey:@"size"];
        NSString *file_ext  =[[storageFileAr  objectAtIndex:x]valueForKey:@"file_ext"];
        NSString *file_id  =[[storageFileAr  objectAtIndex:x]valueForKey:@"file_id"];
        UIImageView *folderimg=[[UIImageView alloc]initWithFrame:CGRectMake(35, yincr, 40,40)];
        folderimg.backgroundColor=[UIColor clearColor];
        if ([file_ext containsString:@"mp4"] || [file_ext containsString:@"fav"]) {
            folderimg.image = [UIImage imageNamed:@"videoicon.png"];
        }
        else if ([file_ext containsString:@"jpg"] || [file_ext containsString:@"jpeg"]|| [file_ext containsString:@"png"]|| [file_ext containsString:@"gif"]) {
            folderimg.image = [UIImage imageNamed:@"pictureicn.png"];
        }
        else  {
            folderimg.image = [UIImage imageNamed:@"docicon.png"];
        }
        
        UIButton *checkpoint=[[UIButton alloc] initWithFrame:CGRectMake(0,folderimg.frame.origin.y+15, 20, 20)];
        
        [checkpoint setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
        checkpoint.enabled = true;
        checkpoint.userInteractionEnabled = YES;
       // [checkpoint addTarget:self action:@selector(Tick:) forControlEvents:UIControlEventTouchUpInside];
        [checkpoint addTarget:self action:@selector(TickOne:) forControlEvents:UIControlEventTouchUpInside];
        checkpoint.tag=x;
        
        [scrollbar1 addSubview:checkpoint];
        [scrollbar1 bringSubviewToFront:checkpoint];
        
//        UITapGestureRecognizer *openges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tick:)];
//        [openges1 setNumberOfTouchesRequired:1];
//        [openges1 setDelegate:self];
//        checkpoint.userInteractionEnabled = YES;
//        
//        [checkpoint addGestureRecognizer:openges1];
        
        
//        NSString *strFileURl = @"https://proyolk.com";
//        strFileURl = [strFileURl stringByAppendingString:[[storageFileAr  objectAtIndex:x]valueForKey:@"imge"]];
        
        //[folderimg sd_setImageWithURL:[NSURL URLWithString:strFileURl] placeholderImage:[UIImage imageNamed:@"docicon.png"]];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strFileURl]];
//        if(strFileURl.length<12)
//        {
//            folderimg.image = [UIImage imageNamed:@""];
//        }
//        else
//        {
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strFileURl]];
//            if (imageData.length<=0)
//                folderimg.image = [UIImage imageNamed:@"username.png"];
//            else
//                folderimg.image = [UIImage imageWithData:imageData];
//            
//        }
        
        //[folderimg setImage:[UIImage imageNamed:@"docicon.png"]];
        folderimg.tag=x;
        [scrollbar1 addSubview:folderimg];
        
        UITextView *folderName  =[[UITextView alloc]initWithFrame:CGRectMake(80, folderimg.frame.origin.y+10, scrollbar1.frame.size.width-40,40)];
        folderName.textColor=[UIColor blackColor];
        folderName.font=[UIFont boldSystemFontOfSize:10];
        folderName.backgroundColor=[UIColor clearColor];
        folderName.text=[NSString stringWithFormat:@"%@ - %@",file_name1,file_size];
        folderName.tag=[file_id intValue];
        folderName.userInteractionEnabled=NO;
        folderName.textAlignment=NSTextAlignmentLeft;
        [scrollbar1 addSubview:folderName];
        
        
        
        
        UITapGestureRecognizer *openges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBaseMenu:)];
        [openges setNumberOfTouchesRequired:1];
        [openges setDelegate:self];
        folderimg.userInteractionEnabled = YES;
        
        [folderimg addGestureRecognizer:openges];
        
        
        yincr=yincr+50;
        
        
    }
    [scrollbar1 setContentSize:CGSizeMake(scrollbar1.frame.size.width, yincr+50)];
    
}
-(IBAction)TickOne:(id)sender
{
        UIButton *resultButton = (UIButton *)sender;
        fileindex=(int)resultButton.tag;
    for (id obj in  scrollbar1.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
        }
    }
    
    if([[resultButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"radiounselect.png"]])
            {
               // [resultButton setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
                [resultButton setImage:[UIImage imageNamed:@"radioselect.png"] forState:UIControlStateNormal];
                base.hidden=false;
              // InboxtableView.frame =CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height-200);
        
                sender1=sender;
        
            }
            else
            {
                [resultButton setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
            }
    
//    UIImageView *btn = (UIImageView*)sender.view;
//    btn.backgroundColor=[UIColor lightGrayColor];
    
    
    //       "file_ext" = png;
    //       "file_id" = 255;
    //       "file_name" = "back.png";
    //       "file_name1" = "back.png";
    //       "folder_id" = 30;
    //       logtime = "2016-04-18T05:18:16.000Z";
    //       size = "1 KB";
    //       "u_id" = 6;
    
    
    
    selectedfolId=[[[storageFileAr objectAtIndex:(int)resultButton.tag] valueForKey:@"file_id"] intValue];
    strid =[[[storageFileAr objectAtIndex:(int)resultButton.tag] valueForKey:@"u_id_from"]integerValue]; ;
    filenameis=[[storageFileAr objectAtIndex:(int)resultButton.tag] valueForKey:@"file_name"];
    
    fileIdis=selectedfolId;
    senderchangcol=sender;
    [self showBaseMenuitem];
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
//      // InboxtableView.frame =CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height-200);
//        
//        sender1=sender;
//        
//    }
//    else
//    {
//        [sender setImage:[UIImage imageNamed:@"radiounselect.png"] forState:UIControlStateNormal];
//        base.hidden=true;
//      //  InboxtableView.frame =CGRectMake(0,middle_label.frame.size.height+middle_label.frame.origin.y,[SavePrefrences sharedInstance].screenWidth,main.frame.size.height);
//        
//        
//    }
}



-(void) openNewFolder2:(id)sender
{
    NSLog(@" openNewFolder2");
    UITapGestureRecognizer *ges=(UITapGestureRecognizer *)sender;
    fidfrfile =(int)ges.view.tag;
    
    [self reterivenewfile];
    
}

-(void) reterivenewfile
{
    iscallback=15;
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"%d",fidfrfile] forKey:@"f_id"];
      [dic setObject:@"t" forKey:@"f"];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Storage" :@"FolderSort": @"" :@"" :dic :self];
}


-(void) selectFolder2:(UITapGestureRecognizer*)sender
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

-(void) showBaseMenu:(UITapGestureRecognizer *)sender
{
    if(senderchangcol!=nil)
    {
        UIImageView *btn = (UIImageView*)senderchangcol.view;
        btn.backgroundColor=[UIColor clearColor];
    }
    UIImageView *btn = (UIImageView*)sender.view;
    btn.backgroundColor=[UIColor lightGrayColor];
    
    
    //       "file_ext" = png;
    //       "file_id" = 255;
    //       "file_name" = "back.png";
    //       "file_name1" = "back.png";
    //       "folder_id" = 30;
    //       logtime = "2016-04-18T05:18:16.000Z";
    //       size = "1 KB";
    //       "u_id" = 6;
    
    
    
    selectedfolId=[[[storageFileAr objectAtIndex:(int)btn.tag] valueForKey:@"file_id"] intValue];
    strid =[[[storageFileAr objectAtIndex:(int)btn.tag] valueForKey:@"u_id_from"]integerValue]; ;
    filenameis=[[storageFileAr objectAtIndex:(int)btn.tag] valueForKey:@"file_name"];
    
    fileIdis=selectedfolId;
    senderchangcol=sender;
    [self showBaseMenuitem];
    
}


-(void)showBaseMenuitem
{
    scrollbar.frame=CGRectMake(0, 20, prhier2View.frame.size.width, prhier2View.frame.size.height-110);
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry ;
    base=[[UIView alloc]initWithFrame:CGRectMake(0, scrollbar.frame.size.height+scrollbar.frame.origin.y, bodyview.frame.size.width, 45)];
    base.backgroundColor=[ff valueForKey:@"Scrollcolor"];
    base.hidden=false;
    [prhier2View addSubview: base];
    
    NSMutableArray *picAr=[[NSMutableArray alloc]init];
  //  [picAr addObject:@"moveto.png"];
  //  [picAr addObject:@"download.png"];
  //  [picAr addObject:@"trash.png"];
   
    [picAr addObject:@"move11.png"];
    [picAr addObject:@"resume_download.png"];
    [picAr addObject:@"deleteblack.png"];
    
    int xinc=30;
    int wid=(base.frame.size.width)/3;
    for(int x=0;x<3;x++)
    {
        UIImageView *pic=[[UIImageView alloc] initWithFrame:CGRectMake(xinc, 0, 40, 40)];
        pic.image=[UIImage imageNamed:[picAr objectAtIndex:x]];
        pic.tag=x;
        [base addSubview: pic];
        
        xinc=xinc+wid;
        
        UITapGestureRecognizer *myFldr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(basemenuAction:)];
        [myFldr setNumberOfTouchesRequired:1];
        [myFldr setDelegate:self];
        pic.userInteractionEnabled = YES;
        [pic addGestureRecognizer:myFldr];
    }
}


-(void)basemenuAction:(id)sender
 {
    UITapGestureRecognizer * ges=(UITapGestureRecognizer *)sender;
    int idd=(int)ges.view.tag;
    if(idd==0)
    {
        [self shareIt:vc1];
    }
    else if(idd==1)
    {
        [self downloadImg:filenameis user:[NSString stringWithFormat:@"%d",strid]];
    }
    else if(idd==2)
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setValue:[NSString stringWithFormat:@"%d",fileIdis] forKey:@"id"];
        iscallback=17;
        
        [[SavePrefrences sharedInstance].skthand emitData:@"MyFiles" :@"delfile" :@"" :@"" :dic :self];
        
    }
 }


//=======================folderhierach2 ===========end=======



-(void)downloadImg:(NSString *)path1 user:(NSString *)strId
{
    
    NSLog(@"path isssss====%@",path1);
    NSString *path=@"";
    AlertView *alert = [[AlertView alloc]init];
    [alert showAlertView:@"Please Wait"];
//    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [self.view bringSubviewToFront:HUD];
//    // Set the label text.
//    HUD.label.text = @"Loading";
   

    if(![path1 containsString:@"/"])
    {
        NSString *upload= [[[SavePrefrences sharedInstance].skthand btkurl] stringByAppendingString:[NSString stringWithFormat:@"%@/",@"upload"]];
        NSString *upload1= [upload stringByAppendingString:strId];
        NSString *upload2= [upload1 stringByAppendingString:[NSString stringWithFormat:@"/%@/",@"storage"]];
        path= [upload2 stringByAppendingString:path1];
        NSLog(@"final pathdd=======%@",path);
        //SplashScreen.url + “/upload/”+ storage.get(position).u_id_from + “/storage/”+ storage.get(position).file_name
    }
    else
    {
        ManageArray  *marr=[[ManageArray alloc]init];
        path=[marr concatUrl:path1];
    }
    
    
    NSURL  *url=[NSURL URLWithString:path];
    NSData *urldta=[NSData dataWithContentsOfURL:url];
    if(urldta)
        {
        //    [HUD hideAnimated:YES];
        [alert DissmissAlertView];
        NSArray *pathAr=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docdirectory=[pathAr objectAtIndex:0];
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", docdirectory,@"filename.png"];
        [urldta writeToFile:filePath atomically:YES];
        NSLog(@"filepath is === %@",filePath);
        NSData *pdfData = [NSData dataWithContentsOfFile:filePath];
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[pdfData] applicationActivities:nil];
            [vc1 presentViewController:activityViewController animated:true completion:nil];
       
       
        }
    else
        {
          //     [HUD hideAnimated:YES];
            [alert DissmissAlertView];
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Download Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
      
        }
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




-(NSString *) randomImagName
{
    
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
    for (int i=0; i<12; i++)
    {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    NSString *rnd;
    if (ftbrowse==0) {
         rnd  =[randomString stringByAppendingString:@".mp4"];
    }
    else{
        rnd  =[randomString stringByAppendingString:@".png"];

    }

    upld.text=rnd;
    
    return rnd;
}


-(void)openDocument
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"hello.txt"];
    BOOL fileExists = [fileManager fileExistsAtPath:filePath];
    
    
  
    
    
    
    //           NSMutableArray *matches = [[NSMutableArray alloc]init];
    //           NSFileManager *fManager = [NSFileManager defaultManager];
    //           NSString *item;
    //           NSArray *contents = [fManager contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Document"] error:nil];
    //
    //       NSLog(@"content=====%@",contents);
    //
    //           // >>> this section here adds all files with the chosen extension to an array
    //           for (item in contents){
    //               //if ([[item pathExtension] isEqualToString:@"txt"]) {
    //                   [matches addObject:item];
    //                   NSLog(@"contentttt===%@",matches);
    //              // }
    //           }
    //return matches; }
}

-(void)uploadVideo:(NSString *)moviePath{
    
    
//    NSString *imgName = [self randomImagName];
//    iscallback=100;
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//    [dic setObject:videoBuffer forKey:@"buffer1"];
//    [dic setObject:[SavePrefrences sharedInstance].uid forKey:@"id"];
//    [dic setObject:imgName forKey:@"pic"];
//    
//    [[SavePrefrences sharedInstance].skthand emitData:@"Profile" :@"uploadVd" :@"" :@"no" :dic :self ];
    
    
    
}




-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    NSLog(@"Storage_data=========%@",data);
    NSLog(@"Storage_meta=========%@",meta);
    
    NSLog(@"iscallback=e======%d",iscallback);
   
    if(iscallback==0)
    {
        NSArray *newdata=[meta valueForKey:@"data"];
        shareAr= [newdata valueForKey:@"friend"];
        [self SharedtableView];
    }
    else if (iscallback==1)
    {
        
        NSArray *newdata=[meta valueForKey:@"data"];
        netAr= [newdata valueForKey:@"friend"];
        
        NSLog(@"data in array%@",netAr);
        [self NetworktableView];
    }
    else if(iscallback==2)
    {
        commuAr=data;
        [self CommunitytableView];
    }
    else if (iscallback==3)
    {
        shareAr=data;
        [sharedtable reloadData];
    }
    else if (iscallback==4)
    {
        netAr=data;
        [networktable reloadData];
    }
    else if (iscallback==5)
    {
        
        if([data valueForKey:@"affectedRows"]>0)
        {
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Deleted Successfully!!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alrt show];
            [alrt dismissWithClickedButtonIndex:0 animated:YES];
            [self openMyFiles];
        }
    }
    else if (iscallback==6)
    {
        [self showMyfileView :vc1:data];
    }
    else if (iscallback==7)
    {
        folderArdata=data;
        buttonHieratext=@"MoveTo";
        [self Showmoveto :vc1:0];
    }
    else if (iscallback==8)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"FilteredData"];
        [backData addObject:data];
        [backData addObject:dictFilter];
        
        [self dissmisspop];
    }
    else if (iscallback==9)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"Sorteddata"];
        [backData addObject:data];
        [self dissmisspop];
    }
    else if (iscallback==10)
    {
        [self hidebaseMenu];
        [self dissmisspop1];
        fileAr=data;
        if([fileAr count]>0)
          {
            [Filetable reloadData];
          }
        else
         {
            [Filetable reloadData];
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Oops! No New Result Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alrt show];
            
        }
    }
    else if (iscallback==11)
    {
        fileAr=data;
        [self hidebaseMenu];
        if([fileAr count]>0)
        {
            
            [Filetable reloadData];
        }
        else{
            
            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Oops! No New Result Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alrt show];
            
        }
        
    }
    else if(iscallback==12)
    {
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"reteriveInbox"];
        [backData addObject:data];
        
        id<CallTo_Parent>  cb= vc1;
        [cb callMethod:backData];
    }
    
    else if (iscallback==13)
    {
        folderArdata=data;
        buttonHieratext=@"Upload File";
        [self Showmoveto1 :vc1:0];
    }
    else if (iscallback==14)
    {
        NSLog(@"meta==14===%@",meta);
        NSLog(@"data===14==%@",data);
        getFoldernamedic=[[NSMutableArray alloc]init];
        folderArdata=data;
        [self Showmoveto2 :0];
    }
    else if(iscallback==15)
    {
        NSMutableDictionary *dictData = (NSMutableDictionary *)meta;
        storageFileAr=[[dictData objectForKey:@"data"] objectForKey:@"fileList"];
        folderArdata=data;
        [self Showmoveto2 :fidfrfile];
        
        
    }
    else if(iscallback==16)
    {
        NSLog(@"meta =====16==%@",meta);
        NSLog(@"data ======16=%@",data);
    }
    else if(iscallback==17)
    {
        NSLog(@"meta =====17==%@",meta);
        NSLog(@"data ======17=%@",data);
        
        [self dissmisspopHierchy2];
        NSLog(@"folder isss======%d",fidfrfile);
        
        [self reterivenewfile];
    }
    else if(iscallback==18)
    {
        //   NSLog(@"meta =====18==%@",meta);
        // NSLog(@"data ======18=%@",data);
    }
    else if (iscallback = 19){
        backData=[[NSMutableArray alloc]init];
        [backData addObject:@"Sorteddata"];
        [backData addObject:data];
        [self dissmisspop];
    }
    
    
    
    
}

//OpenFolder




-(void) callMethod:(NSArray *)meta
{
    // NSString * chk=[meta objectAtIndex:0];
    
    NSLog(@"Valuuuuuuuuuu===%@",meta);
    
    
    [self OpenFolder];
    
    
    // NSLog(@"Valuuuuuuuuuu===%@",meta);
    // NSLog(@"COUNT IS %lu",[meta count]);
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
    //            UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Oops! No Results" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    //            [alrt show];
    //        }
}









@end
