//
//  Interview.m
//  Proyolk
//
//  Created by iFlame on 10/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "Interview.h"
#import "Tvc.h"
@interface Interview ()

@end

@implementation Interview

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Tvc *cell = [tableView dequeueReusableCellWithIdentifier:@"Tvc" forIndexPath:indexPath];
    cell.lblTime.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.lblTime.layer.borderWidth = 1.0;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220.0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSearch:(id)sender {
    
    
}

-(void) didPressCancel:(id)obj{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Proyolk" message:@"ARE YOU SURE TO CANCEL THIS INTERVIEW ?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    //alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"Please fill the Reason Here";
    [alert show];

}
-(void) didPressProfile:(id)obj{
//    CommonProfile   *cmpop=[[CommonProfile alloc]init];
//    
//    [ cmpop addProfileimage:data :[friendid intValue] :vc1] ;
}
-(void) didPressDetail:(id)obj{

}
@end
