//
//  ChatViewController.m
//  Proyolk
//
//  Created by Shiv ram on 31/01/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "ChatViewController.h"
#import "SavePrefrences.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "ManageArray.h"
#import "ChatStorageEngine.h"
#import "ChatCell.h"

@interface ChatViewController ()<UITextViewDelegate>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_participants.count) {
//        [_userNameLbl setText:@"Conference Chat"];
//        [_onlineStatusLbl setText:@""];
        [_userNameLbl setHidden:YES];
        [_onlineStatusLbl setHidden:YES];
        [_userImageView setHidden:YES];
        [_userDescView setHidden:YES];
        [self fetchGroupMessages];
        [_tableToDescViewConstraint setActive:NO];
        [_tableToHeaderConstraint setConstant:0];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageActivity:) name:@"GC_MESSAGE_SAVED" object:nil];
    }else{
        NSDictionary* contact = [self contactFromId:_userId];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.currentChatUser = _userId;
        _userName = [NSString stringWithFormat:@"%@ %@", contact[@"fname"], contact[@"lname"]];
        [_userNameLbl setText:_userName];
        NSString *img = contact[@"img"];
        ManageArray* mang=[[ManageArray alloc]init];
        _userImage = [mang concatUrl:img];
        _userImageView.layer.cornerRadius=25;
        _userImageView.clipsToBounds=YES;
        [_userImageView sd_setImageWithURL:[NSURL URLWithString:_userImage]];
        if ([contact[@"isonline"] boolValue]) {
            [_onlineStatusLbl setText:@"Online"];
        }else [_onlineStatusLbl setText:@"Offline"];
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageActivity:) name:@"IM_MESSAGE_SAVED" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageTypingIndicator:) name:@"CHAT_TYPING_STATUS" object:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardDidHideNotification object:nil];
    
    _messageTextView.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _chatTableView.hidden = YES;
    [self loadLocalMessages];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messagesArr.count-1 inSection:0];
        [_chatTableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
        _chatTableView.hidden = NO;
    });
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.currentChatUser = nil;
}

- (void)keyboardShown:(NSNotification *)notification{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int height = MIN(keyboardSize.height,keyboardSize.width);
    [_bottomConstraint setConstant:height];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_messagesArr.count > 0)
            
            //pach by kalpesh
            
            [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messagesArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
       // [self lastIndexPath];
    });

}

- (void)keyboardHidden:(NSNotification *)notification{
    [_bottomConstraint setConstant:0];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].y > 0) {
        [self.view endEditing:YES];
    }
}

//MRUG
- (void)loadLocalMessages{
    _messagesArr = [[ChatStorageEngine sharedManager] loadMessages:_userId];
    [_chatTableView reloadData];
    
    if (_messagesArr.count > 0){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [_chatTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
        });
    }
//    [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messagesArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    NSMutableArray* messages = [[NSMutableArray alloc] init];
    NSMutableArray* notifIds = [[NSMutableArray alloc] init];
    for (Messages *msg in _messagesArr) {
        if (msg.incoming && (!msg.seen || !msg.delivered)) {
            NSDictionary* msgDict = @{
                                  @"mess" : msg.messageText,
                                  @"messId" : msg.messageId
                                  };
            [messages addObject:msgDict];
            [notifIds addObject:msg.notificationId];
            [[ChatStorageEngine sharedManager] saveMessageStatus:msg.messageId isSeen:YES isIncoming:YES];
        }
    }
    if (messages.count && notifIds.count) {
        [self sendDeliveryReport:messages.copy notifs:notifIds.copy];
    }
}

- (void)fetchGroupMessages{
    _messagesArr = [[ChatStorageEngine sharedManager] loadGroupMessages];
    [_chatTableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_messagesArr.count > 0)
            
            //pach by kalpesh
        
             [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messagesArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
          //  [self lastIndexPath];
    });
}

-(NSIndexPath *)lastIndexPath
{
    NSInteger lastSectionIndex = MAX(0, [_chatTableView numberOfSections] - 1);
    NSInteger lastRowIndex = MAX(0, [_chatTableView numberOfRowsInSection:lastSectionIndex] - 1);
    return [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
    
   // [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
}

- (void)sendDeliveryReport:(NSArray*)messages notifs:(NSArray*)notifs{
    NSDictionary* msgDict = @{
                              @"message" : messages,
                              @"notiIds" : notifs,
                              @"uid" : [SavePrefrences sharedInstance].uid,
                              @"messS" : @"2",
                              @"fruid":_userId
                              };
    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rn" :@"" :@"d" :msgDict :self];
}

-(void)sendTypingStatus:(BOOL)isTyping {
    NSDictionary* msgDict = @{
                              @"ty" : isTyping ? @true : @false,
                              @"uid" : [SavePrefrences sharedInstance].uid,
                              @"fruid":_userId,
                              @"ntc":@6
                              };
    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"isT" :@"" :@"d" :msgDict :self];

}

- (void)messageActivity:(NSNotification *)notification{
    NSString* user = [NSString stringWithFormat:@"%@", notification.userInfo[@"uid"]];
    if ([user isEqualToString:_userId]) {
        [self loadLocalMessages];
    }else if([user isEqualToString:@"000"]){
        [self fetchGroupMessages];
    }
}

- (void)messageTypingIndicator:(NSNotification *)notification{
    NSString* user = [NSString stringWithFormat:@"%@", notification.userInfo[@"uid"]];
    NSString* status = [NSString stringWithFormat:@"%@", notification.userInfo[@"ty"]];
    if ([user isEqualToString:_userId]) {
        if (status.boolValue) {
            _onlineStatusLbl.text = @"typing...";
            [self startBlinkingLabel:_onlineStatusLbl];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _onlineStatusLbl.text = @"Online";
                [self stopBlinkingLabel:_onlineStatusLbl];
            });
        }else{
            _onlineStatusLbl.text = @"Online";
            [self stopBlinkingLabel:_onlineStatusLbl];
        }
    }
}

-(void) startBlinkingLabel:(UILabel *)label{
    label.alpha =1.0f;
    [UIView animateWithDuration:1.5
                          delay:0.5
                        options: UIViewAnimationOptionAutoreverse |UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         label.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             
                         }
                     }];
}

-(void) stopBlinkingLabel:(UILabel *)label{
    // REMOVE ANIMATION
    [label.layer removeAnimationForKey:@"opacity"];
    label.alpha = 1.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


-(void)textViewDidEndEditing:(UITextView *)textView{
    [self sendTypingStatus:NO];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self sendTypingStatus:YES];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UITABLEVIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messagesArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_participants.count) {
        GroupChat* msg = _messagesArr[indexPath.row];
        NSString* cellIdentifier;
        if (msg.incoming) {
            cellIdentifier = @"GC_FRIEND_CHAT_CELL";
        }else{
            cellIdentifier = @"MY_CHAT_CELL";
        }
        
        ChatCell* cell = (ChatCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [cell.messageStatusIcon setHidden:YES];
        [cell.messageLbl setText:msg.messageText];
        if (msg.incoming) {
            NSDictionary* contact = [self contactFromId:msg.userId];
            [cell.nameLbl setText:contact[@"fname"]];
            NSString *img = contact[@"img"];
            ManageArray* mang=[[ManageArray alloc]init];
            NSString* imgUrl = [mang concatUrl:img];
            cell.senderImage.layer.cornerRadius=25;
            cell.senderImage.clipsToBounds=YES;
            [cell.senderImage sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        }else{
            [cell.nameLbl setText:[SavePrefrences sharedInstance].fname];
        }
        long long timeInterval = msg.time.longLongValue/1000;
        NSDate* msgDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSDateFormatter* dtf = [[NSDateFormatter alloc] init];
        [dtf setDateFormat:@"MMM d, h:mm a"];
        [cell.dateLbl setText:[dtf stringFromDate:msgDate]];
        return cell;
    }else{
        Messages* msg = _messagesArr[indexPath.row];
        NSString* cellIdentifier;
        if (msg.incoming) {
            cellIdentifier = @"FRIEND_CHAT_CELL";
        }else{
            cellIdentifier = @"MY_CHAT_CELL";
        }
        
        ChatCell* cell = (ChatCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        [cell.messageLbl setText:msg.messageText];
        
        if (msg.incoming) {
            cell.senderImage.layer.cornerRadius=25;
            cell.senderImage.clipsToBounds=YES;
            [cell.senderImage sd_setImageWithURL:[NSURL URLWithString:_userImage]];
            [cell.messageStatusIcon setHidden:YES];
        }else{
            [cell.messageStatusIcon setHidden:NO];
            if (msg.seen) {
                [cell.messageStatusIcon setImage:[UIImage imageNamed:@"doubleTickIcon"]];
            }else if (msg.delivered) [cell.messageStatusIcon setImage:[UIImage imageNamed:@"singleTickIcon"]];
            else [cell.messageStatusIcon setImage:[UIImage imageNamed:@"unsentMessageIcon"]];
        }
        
        long long timeInterval = msg.time.longLongValue/1000;
        NSDate* msgDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSDateFormatter* dtf = [[NSDateFormatter alloc] init];
        [dtf setDateFormat:@"MMM d, h:mm a"];
        [cell.dateLbl setText:[dtf stringFromDate:msgDate]];
        return cell;
    }
}

#pragma mark

- (IBAction)sendMessage:(id)sender {
    
    //MRUG
    if(_messageTextView.text.length<=0){
        
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Message Can’t be Empty!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return;
    }
    
    if (_participants.count) {
        NSDictionary* msgDict = @{
                                  @"mess":_messageTextView.text,
                                  @"messId":[self generateMessageId],
                                  @"mT" : @"group"
                                  };
        NSDictionary* sendMsg = @{
                                  @"uid" : [SavePrefrences sharedInstance].uid,
                                  @"fruid": @"000",
                                  @"message" : msgDict
                                  };
        for (NSString* user in _participants) {
            NSMutableDictionary* mesgMutDict = [NSMutableDictionary dictionaryWithDictionary:sendMsg];
            [mesgMutDict setValue:user forKey:@"fruid"];
            NSDictionary* msgDict = @{
                                      @"mess":_messageTextView.text,
                                      @"messId":[self generateMessageId],
                                      @"mT" : @"group"
                                      };
            [mesgMutDict setValue:msgDict forKey:@"message"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"sIM" :@"" :@"d" :mesgMutDict :self];
        }
        
        [[ChatStorageEngine sharedManager] saveGroupMessage:sendMsg isIncoming:NO];
        [_messageTextView setText:nil];
        [self.view endEditing:YES];
        
    }else{
        
                NSDictionary* msgDict = @{
                                  @"mess":_messageTextView.text,
                                  @"messId":[self generateMessageId]
                                  };
        NSDictionary* sendMsg = @{
                                  @"uid" : [SavePrefrences sharedInstance].uid,
                                  @"fruid": _userId,
                                  @"message" : msgDict,
                                  @"fname":[SavePrefrences sharedInstance].fname,
                                  @"lname":[SavePrefrences sharedInstance].lname,
                                  };
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"sIM" :@"" :@"d" :sendMsg :self];
        [[ChatStorageEngine sharedManager] saveMessage:sendMsg isIncoming:NO];
        [_messageTextView setText:nil];
        [self.view endEditing:YES];
        
        
    }
}

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//TODO: Duplicate Message ID is generated
-(NSString*)generateMessageId{
    NSString *min =@"100"; //Get the current text from your minimum and maximum textfields.
    NSString *max =@"10000000";
    int randNum = rand() % ([max intValue] - [min intValue]) + [min intValue]; //create the random number.
    NSString *num = [NSString stringWithFormat:@"%d", randNum]; //Make the number into a string.
    num = [self randomStringWithLength:7];
    return num;
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}


-(void) callBack:(NSArray *)META  :(NSArray *)DATA{
    
}
@end
