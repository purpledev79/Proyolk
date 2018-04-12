//
//  ChatConversationsController.m
//  Proyolk
//
//  Created by Shiv ram on 06/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "ChatConversationsController.h"
#import "Messages+CoreDataProperties.h"
#import "ChatStorageEngine.h"
#import "ChatViewController.h"
#import "ConversationsCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "ManageArray.h"

@interface ChatConversationsController ()

@end

@implementation ChatConversationsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    drawer = [[LeftRightDrawer alloc] init];
    [drawer initArs:self];
    
    [_conversationsTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageActivity:) name:@"IM_MESSAGE_SAVED" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    allConversations = [[ChatStorageEngine sharedManager] loadConversations];
    datedConversations = [self createDatedDictionary];
    [_conversationsTable reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self makePendingCall];
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:@"IM_MESSAGE_SAVED"];
}

- (void)messageActivity:(NSNotification *)notification{
    allConversations = [[ChatStorageEngine sharedManager] loadConversations];
    datedConversations = [self createDatedDictionary];
    [_conversationsTable reloadData];
}

#pragma mark UTILITIES
- (NSDictionary*)createDatedDictionary{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    for (Messages* msg in allConversations.allValues) {
        NSDictionary* contact = [self contactFromId:msg.userId];
        if(!contact) continue;
        long long timestamp = msg.time.longLongValue/1000;
        NSString* dateStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];
        if (dict[dateStr]) {
            NSMutableArray* arr = [dict[dateStr] mutableCopy];
            [arr addObject:msg];
            [dict setValue:arr forKey:dateStr];
        }else{
            [dict setValue:@[msg] forKey:dateStr];
        }
    }
    
    for (NSString* dateStr in dict.allKeys) {
        NSMutableArray* values = [dict[dateStr] mutableCopy];
        NSSortDescriptor *desc = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO];
        [values sortUsingDescriptors:[NSArray arrayWithObject:desc]];
        [dict setValue:values forKey:dateStr];
    }
    
    return dict.copy;
}

- (NSArray*)sortedArrayByDate:(NSArray*)source{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSArray *sorted = [source sortedArrayUsingComparator:^NSComparisonResult(NSString *strDate1, NSString *strDate2) {
        NSDate *d1 =[formatter dateFromString:strDate1];
        NSDate *d2 =[formatter dateFromString:strDate2];
        //NSDate *d2 = obj2[@"date"];
        
        // return [d1 compare:d2]; // ascending order
        return [d2 compare:d1]; // descending order
    }];
    return sorted;
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

#pragma mark

#pragma mark UITABLEVIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return datedConversations.allKeys.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lblHeader = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd,yyyy"];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSString* dateStr = [self sortedArrayByDate:datedConversations.allKeys][section];
    NSDate *d1 =[formatter dateFromString:dateStr];
    if ([calendar isDateInToday:d1]) {
        lblHeader.text = @"Today";
    }
    else if ([calendar isDateInYesterday:d1]){
        lblHeader.text = @"Yesterday";
    }
    else{
        
        lblHeader.text = dateStr;
    }
    [lblHeader setBackgroundColor:[UIColor clearColor]];
    lblHeader.textAlignment = NSTextAlignmentCenter;
    lblHeader.font = [UIFont fontWithName:@"helvetica" size:14.0];
    return lblHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* sorted = [self sortedArrayByDate:datedConversations.allKeys];
    return [datedConversations[sorted[section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* sorted = [self sortedArrayByDate:datedConversations.allKeys];
    NSString* dateStr = sorted[indexPath.section];
    Messages* msg = [datedConversations[dateStr] objectAtIndex:indexPath.row];
    NSString* cellIdentifier = @"CONVERSATIONS_CELL";
    
    ConversationsCell* cell = (ConversationsCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary* contact = [self contactFromId:msg.userId];
    
    //pach by kalpesh
    
    if (!contact) {
        [cell.userNameLbl setText:msg.fname];
    }else [cell.userNameLbl setText:[NSString stringWithFormat:@"%@ %@", contact[@"fname"], contact[@"lname"]]];
    
    NSString *userchatlabel = [NSString stringWithFormat:@"%@ %@", contact[@"fname"], contact[@"lname"]];
    
    
    NSString *img = contact[@"img"];
    ManageArray* mang=[[ManageArray alloc]init];
    NSString* imgUrl = [mang concatUrl:img];
    
    if (cell.chatBadge) {
        [cell.chatBadge removeFromSuperview];
        cell.chatBadge = nil;
    }
    
    long unreadMsg = [[ChatStorageEngine sharedManager] getUnreadMessageCount:msg.userId];
    cell.chatBadge = [GIBadgeView new];
    cell.chatBadge.badgeValue = unreadMsg;
    [cell.chatIcon addSubview:cell.chatBadge];
    cell.chatBadge.topOffset = 14;   // Moves the badge down 10 points.
    cell.chatBadge.rightOffset = 14;
    cell.userImageView.layer.cornerRadius=22;
    cell.userImageView.clipsToBounds=YES;
    [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    if ([contact[@"isonline"] boolValue]) {
        [cell.onlineStatus setBackgroundColor:[UIColor colorWithRed:0.05 green:0.59 blue:0.23 alpha:1.0]];
        [cell.onlineStatusLbl setText:@"Online"];
    }else{
        [cell.onlineStatus setBackgroundColor:[UIColor darkGrayColor]];
        [cell.onlineStatusLbl setText:@"Offline"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray* sorted = [self sortedArrayByDate:datedConversations.allKeys];
    NSString* dateStr = sorted[indexPath.section];
    Messages* msg = [datedConversations[dateStr] objectAtIndex:indexPath.row];
    UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChatViewController *vc2=[mainStoryboard instantiateViewControllerWithIdentifier:@"CHAT_SCREEN"];
    vc2.userId = msg.userId;
    [self showViewController:vc2 sender:nil];
}
#pragma mark --

#pragma mark FETCH PENDING MESSAGES

- (void)makePendingCall{
    
    @try {
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        [dic1 setValue:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"DashMain" :@"genData":@"":@"":dic1 :self];
    } @catch (NSException *exception) {
        
    }
}

-(void) callBack:(NSArray *)META  :(NSArray *)DATA{
    NSDictionary* mainMeta = (NSDictionary*)META;
    NSArray* allMessages;
    NSMutableDictionary* mappedDict = [[NSMutableDictionary alloc] init];
    NSString* lastSavedDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"LAST_SAVE_DATE"];
    long long lastTimestamp;
    if (lastSavedDate.length) {
        lastTimestamp = lastSavedDate.longLongValue;
    }else lastTimestamp = 0;
    if (mainMeta[@"notis"]) {
        allMessages = mainMeta[@"notis"];
        for (NSDictionary* notif in allMessages) {
            NSString* fruid = [NSString stringWithFormat:@"%@", notif[@"fruid"]];
            if ([fruid isEqualToString:@"598"]) {
                
            }
            NSMutableDictionary* chNotif = notif.mutableCopy;
            if ([notif[@"message"] isKindOfClass:[NSString class]]) {
                NSDictionary *msgObject = [NSJSONSerialization JSONObjectWithData:[notif[@"message"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
                [chNotif setValue:msgObject forKey:@"message"];
            }
            if (![fruid isEqualToString:@"000"]) {
                NSString* userID = [NSString stringWithFormat:@"%@", chNotif[@"uid"]];
                if (mappedDict[userID]) {
                    NSMutableArray *arr = [mappedDict[userID] mutableCopy];
                    NSString* msgTime = [NSString stringWithFormat:@"%@", chNotif[@"time"]];
                    long long msgTimestamp = msgTime.longLongValue;
                    if (msgTimestamp > lastTimestamp) {
                        [arr addObject:chNotif];
                    }
                    [mappedDict setValue:arr forKey:userID];
                }else{
                    NSString* msgTime = [NSString stringWithFormat:@"%@", chNotif[@"time"]];
                    long long msgTimestamp = msgTime.longLongValue;
                    if (msgTimestamp > lastTimestamp) {
                        [mappedDict setValue:@[chNotif] forKey:userID];
                    }
                }
            }
            
        }
    }
    
    for (NSString* user in mappedDict.allKeys) {
        NSArray* arr = mappedDict[user];
        for (NSDictionary* dict in arr) {
            NSString* msgTime = [NSString stringWithFormat:@"%@", dict[@"time"]];
            long long msgTimestamp = msgTime.longLongValue;
            if (msgTimestamp > lastTimestamp) lastTimestamp = msgTimestamp;
            NSLog(@"TAKING MESSAGE FROM *** %@ *** TO *** %@ ****", dict[@"uid"], dict[@"fruid"]);
            if ([dict[@"fruid"] intValue]==598) {
                
            }
            if ([user isEqualToString:[NSString stringWithFormat:@"%@", [SavePrefrences sharedInstance].uid]]) {
                [[ChatStorageEngine sharedManager] saveMessage:dict isIncoming:NO];
            }else [[ChatStorageEngine sharedManager] saveMessage:dict isIncoming:YES];
        }
    }
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%lld", lastTimestamp] forKey:@"LAST_SAVE_DATE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark
@end
