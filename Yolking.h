//
//  Yolking.h
//  Proyolk
//
//  Created by PURPLE on 4/27/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//
//
#define SAFESTRING(str) ISVALIDSTRING(str) ? str : @""
#define ISVALIDSTRING(str) (str != nil && [str isKindOfClass:[NSNull class]] == NO)
#define VALIDSTRING_PREDICATE [NSPredicate predicateWithBlock:^(id evaluatedObject, NSDictionary *bindings){return (BOOL)ISVALIDSTRING(evaluatedObject);}]
#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "CommonProfile.h"
@interface Yolking : UIViewController<PjsCallBack,UIScrollViewDelegate>{
    NSString *friendid;
    UIViewController *vc1;
    NSMutableDictionary *dictionaryByDate;
    
}
@property(nonatomic,strong)IBOutlet UITableView  *notiTableView;
-(void)yolkingscreen:(UIViewController *)Vc;
-(void)customizeActionBar;

@end
