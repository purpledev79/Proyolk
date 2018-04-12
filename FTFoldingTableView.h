//
//  FTFoldingTableView.h
//  FTFoldingTableView
//
//  Created by liufengting https://github.com/liufengting on 16/6/20.
//  Copyright © 2016年 liufengting. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - ENUM FTFoldingSectionState
/**
 *  FTFoldingSectionState
 */
typedef NS_ENUM(NSUInteger, FTFoldingSectionState) {
    /**
     *  section state flod
     */
    FTFoldingSectionStateFlod,
    /**
     *  section state show
     */
    FTFoldingSectionStateShow,
};

#pragma mark - ENUM FTFoldingSectionHeaderArrowPosition
/**
 *  FTFoldingSectionHeaderArrowPosition
 */
typedef NS_ENUM(NSUInteger, FTFoldingSectionHeaderArrowPosition) {
    /**
     *  arrow position left
     */
    FTFoldingSectionHeaderArrowPositionLeft,
    /**
     *  arrow position right
     */
    FTFoldingSectionHeaderArrowPositionRight,
};


#pragma mark - FTFoldingTableViewDelegate

@class FTFoldingTableView;
/**
 *  FTFoldingTableViewDelegate
 */
@protocol FTFoldingTableViewDelegate <NSObject>

@required
/**
 *  perferedArrowPositionForFTFoldingTableView
 *
 *  @param ftTableView FTFoldingTableView
 *
 *  @return FTFoldingSectionHeaderArrowPosition
 */
- (FTFoldingSectionHeaderArrowPosition)perferedArrowPositionForFTFoldingTableView:(FTFoldingTableView *)ftTableView;
/**
 *  numberOfSectionForFTFoldingTableView
 *
 *  @param ftTableView FTFoldingTableView
 *
 *  @return NSInteger
 */
- (NSInteger )numberOfSectionForFTFoldingTableView:(FTFoldingTableView *)ftTableView;
/**
 *  numberOfRowsInSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return NSInteger
 */
- (NSInteger )ftFoldingTableView:(FTFoldingTableView *)ftTableView numberOfRowsInSection:(NSInteger )section;
/**
 *  heightForHeaderInSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return CGFloat
 */
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForHeaderInSection:(NSInteger )section;
/**
 *  heightForRowAtIndexPath
 *
 *  @param ftTableView FTFoldingTableView
 *  @param indexPath   NSIndexPath
 *
 *  @return CGFloat
 */
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  titleForHeaderInSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return NSString
 */
- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView titleForHeaderInSection:(NSInteger )section;
/**
 *  cellForRowAtIndexPath
 *
 *  @param ftTableView FTFoldingTableView
 *  @param indexPath   NSIndexPath
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *)ftFoldingTableView:(FTFoldingTableView *)ftTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  didSelectRowAtIndexPath
 *
 *  @param ftTableView FTFoldingTableView
 *  @param indexPath   NSIndexPath
 */
- (void )ftFoldingTableView:(FTFoldingTableView *)ftTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  arrowImageForSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIImage
 */
- (UIImage *)ftFoldingTableView:(FTFoldingTableView *)ftTableView arrowImageForSection:(NSInteger )section;
/**
 *  descriptionForHeaderInSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return NSString
 */
- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView descriptionForHeaderInSection:(NSInteger )section;
/**
 *  backgroundColorForHeaderInSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIColor
 */
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView backgroundColorForHeaderInSection:(NSInteger )section;
/**
 *  fontForTitleInSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIFont
 */
- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForTitleInSection:(NSInteger )section;
/**
 *  fontForDescriptionInSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIFont
 */
- (UIFont *)ftFoldingTableView:(FTFoldingTableView *)ftTableView fontForDescriptionInSection:(NSInteger )section;
/**
 *  textColorForTitleInSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIColor
 */
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForTitleInSection:(NSInteger )section;
/**
 *  textColorForDescriptionInSection
 *
 *  @param ftTableView FTFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIColor
 */
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView textColorForDescriptionInSection:(NSInteger )section;

@end

#pragma mark - FTFoldingSectionHeaderDelegate
/**
 *  FTFoldingSectionHeaderDelegate
 */
@protocol FTFoldingSectionHeaderDelegate <NSObject>
/**
 *  ftFoldingSectionHeaderTappedAtIndex
 *
 *  @param index NSInteger
 */
- (void)ftFoldingSectionHeaderTappedAtIndex:(NSInteger)index;

@end

#pragma mark - FTFoldingTableView
/**
 *  FTFoldingTableView
 */
@interface FTFoldingTableView : UITableView <UITableViewDelegate,UITableViewDataSource,FTFoldingSectionHeaderDelegate>
/**
 *  FTFoldingTableViewDelegate foldingDelegate
 */
@property(nonatomic,strong)NSString *strFlag;
@property (nonatomic, strong)id<FTFoldingTableViewDelegate> foldingDelegate;

@end

#pragma mark - FTFoldingSectionHeader
/**
 *  FTFoldingSectionHeader
 */
@interface FTFoldingSectionHeader : UIView
@property(nonatomic,strong)NSString *strFl;
@property (nonatomic, strong)id<FTFoldingSectionHeaderDelegate> tapDelegate;
/**
 *  initWithFrame
 *
 *  @param frame frame
 *  @param tag   tag
 *
 *  @return instancetype
 */
-(instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag;
/**
 *  setup
 *
 *  @param backgroundColor   UIColor
 *  @param titleString       NSString
 *  @param titleColor        UIColor
 *  @param titleFont         UIFont
 *  @param descriptionString NSString
 *  @param descriptionColor  UIColor
 *  @param descriptionFont   UIFont
 *  @param arrowImage        UIImage
 *  @param arrowPosition     FTFoldingSectionHeaderArrowPosition
 *  @param sectionState      FTFoldingSectionState
 */
-(void)setupWithBackgroundColor:(UIColor *)backgroundColor
                    titleString:(NSString *)titleString
                     titleColor:(UIColor *)titleColor
                      titleFont:(UIFont *)titleFont
              descriptionString:(NSString *)descriptionString
               descriptionColor:(UIColor *)descriptionColor
                descriptionFont:(UIFont *)descriptionFont
                     arrowImage:(UIImage *)arrowImage
                  arrowPosition:(FTFoldingSectionHeaderArrowPosition)arrowPosition
                   sectionState:(FTFoldingSectionState)sectionState;





@end
