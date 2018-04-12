//
//  popups.h
//  ;
//
//  Created by Purple Intellect on 25/03/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "PjsCallBack.h"

@interface popups : UIViewController<CallTo_Parent,PjsCallBack>
{
    UILabel *desc;
}

-(void)AddnewPodcast:(UIViewController*)Vc;
-(void)sortbypop:(UIViewController*)Vc:(int)SortID;
-(void)AddNewLibrary:(UIViewController*)Vc;
-(void)sortbylibrary:(UIViewController*)Vc;
-(void)postpone:(UIViewController*)Vc:(int)ispost;
@end
