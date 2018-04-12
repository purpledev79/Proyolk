//
//  ViewController.m
//  faq_Page
//
//  Created by iFlame on 12/11/16.
//  Copyright © 2016 iFlame. All rights reserved.
//

#import "FAQViewController.h"
#import "FaqCell.h"
#import "SavePrefrences.h"
@interface FAQViewController ()
{
    int isCallback;
    NSMutableArray *ArrQuestion;
}
@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ft_tableView.strFlag = @"101";
    self.ft_tableView.foldingDelegate = self;
    //self.ft_tableView. = self;
    self.segmentControl.delegate = self;
    isCallback=1;
    [self customizeActionBar];
    self.arrowPosition = FTFoldingSectionHeaderArrowPositionRight;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Faqs":@"GetFaqFront" :@"":@"":dic1 :self];
    
    NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
    self.view.backgroundColor=[brd valueForKey:@"backcolor"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnselectTab:(id)sender
{
    NSMutableArray *arrView = self.container.subviews;
    for (UIButton *btn in arrView) {
        [btn setSelected:NO];
    }
    
    UIButton *btnSelected = (UIButton *)sender;
    [btnSelected setSelected:YES];
    [self getFAQData:(int)btnSelected.tag];

}

-(void)callBack:(NSArray *)meta :(NSArray *)data
{
    
    //   [self removeFromSuperview];
    
    if (isCallback==1)
    {
        NSMutableDictionary *dictData = (NSMutableDictionary *)meta;
        arrData = [[dictData objectForKey:@"data"]objectForKey:@"fq"];
        NSMutableArray *arrButtons  = [NSMutableArray array];
        for (int i = 0; i<arrData.count; i++)
        {
            NSMutableDictionary *dictData = [arrData objectAtIndex:i];
            [arrButtons addObject:[dictData objectForKey:@"tab_name"]];
            
        }
        self.segmentControl.buttons = arrButtons;
        
        [self getFAQData:[[[arrData objectAtIndex:0]objectForKey:@"tab_id"]integerValue]];
    }
    else{
        NSMutableArray *arrData = (NSMutableArray *)data;
        ArrQuestion = [NSMutableArray arrayWithArray:arrData];
        [self.ft_tableView reloadData];
        NSLog(@"Data %@",data);
    
    }
}

- (void)didSelectItemAtIndex:(NSInteger)index{
    
    _txtSearch.text=@"";
    
    self.strSelectedTab = [[[arrData objectAtIndex:index]objectForKey:@"tab_id"]integerValue];
    [self getFAQData:[[[arrData objectAtIndex:index]objectForKey:@"tab_id"]integerValue]];
}

-(void)getFAQData:(int)ID{
    isCallback=2;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",ID] forKey:@"faqid"];
//    [dic1 setObject:@"true" forKey:@""];
    [[SavePrefrences sharedInstance].skthand emitData:@"Faqs":@"GetFaqFront" :@"":@"":dic1 :self];
//    [self.tblview reloadData];
}

- (FTFoldingSectionHeaderArrowPosition)perferedArrowPositionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return self.arrowPosition;
}
- (NSInteger )numberOfSectionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
     return ArrQuestion.count;
}
- (NSInteger )ftFoldingTableView:(FTFoldingTableView *)ftTableView numberOfRowsInSection:(NSInteger )section
{
    return 1;
}
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForHeaderInSection:(NSInteger )section
{
    return 40;
}
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dict = [ArrQuestion objectAtIndex:indexPath.row];
    NSString *strHtml =  [self stringByStrippingHTML:[dict objectForKey:@"answer"]];
    CGSize sizeOfText = [strHtml boundingRectWithSize: CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)
                                              options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                           attributes: [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:16]
                                                                                   forKey:NSFontAttributeName]
                                              context: nil].size;
    
    return ceilf(sizeOfText.height+200);
  //  return 200;
    
}
- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForTitleInSection:(NSInteger )section{
    return [UIFont fontWithName:@"Helvetica" size:16 ];
}

-(NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView titleForHeaderInSection:(NSInteger)section
{
    NSMutableDictionary *dict = [ArrQuestion objectAtIndex:section];
    return  [dict objectForKey:@"question"];
    
}


- (UITableViewCell *)ftFoldingTableView:(FTFoldingTableView *)ftTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict = [ArrQuestion objectAtIndex:indexPath.section];
    FaqCell *faqcell = [ftTableView dequeueReusableCellWithIdentifier:@"FaqCell" forIndexPath:indexPath];
    faqcell.lblTitle.text = [dict objectForKey:@"question"];
    faqcell.lblDescription.text = [self stringByStrippingHTML:[dict objectForKey:@"answer"]];
    faqcell.lblDescription.scrollEnabled = NO;
    faqcell.lblDescription.backgroundColor = [UIColor clearColor];
    faqcell.selectionStyle = UITableViewCellSelectionStyleNone;
    faqcell.backgroundColor = [UIColor clearColor];
    return faqcell;
    
}
-(NSString *) stringByStrippingHTML:(NSString *)strHtml {
    NSRange r;
    NSString *s = [strHtml copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}
- (void )ftFoldingTableView:(FTFoldingTableView *)ftTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ftTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - FTFoldingTableViewDelegate / optional delegates, change almost everything using delegate

- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"";
}

- (IBAction)btnSearchAction:(id)sender {
    
    isCallback=2;
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setObject:[NSString stringWithFormat:@"%d",self.strSelectedTab] forKey:@"faqid"];
    [dic1 setObject:self.txtSearch.text forKey:@"key"];
    //    [dic1 setObject:@"true" forKey:@""];
    [[SavePrefrences sharedInstance].skthand emitData:@"Faqs":@"GetFaqFront" :@"":@"":dic1 :self];
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

@end
