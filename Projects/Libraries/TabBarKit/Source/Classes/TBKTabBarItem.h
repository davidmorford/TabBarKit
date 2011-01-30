
/*!
@project    TabBarKit
@header     TBKTabBarItem.h
@copyright  (c) 2010 - 2011, David Morford
*/

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NSUInteger TBKTabBarItemSelectionStyle;
enum {
	TBKTabBarItemDefaultSelectionStyle = 1,
	TBKTabBarItemIndicatorSelectionStyle = 2
};

/*!
@class TBKTabBarItem
@superclass UIButton
@abstract
*/
@interface TBKTabBarItem : UIButton

@property (nonatomic, copy) NSNumber *badgeValue;

#pragma mark Initializers

-(id) initWithImageName:(NSString *)anImageName style:(TBKTabBarItemSelectionStyle)aStyle;
-(id) initWithImageName:(NSString *)anImageName style:(TBKTabBarItemSelectionStyle)aStyle tag:(NSInteger)aTag;
-(id) initWithImageName:(NSString *)anImageName style:(TBKTabBarItemSelectionStyle)aStyle tag:(NSInteger)aTag title:(NSString *)aTitle;

@end

#pragma mark -

/*!
@protocol TBKTabBarItemDataSource <NSObject>
@abstract 
*/
@protocol TBKTabBarItemDataSource <NSObject>

@property (nonatomic, readonly) NSString *tabImageName;
@property (nonatomic, readonly) NSString *tabTitle;

@end
