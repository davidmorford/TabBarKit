
/*!
@project    TabBarKit
@header     TBKTabBar.h
@copyright  (c) 2010 - 2011, David Morford
*/

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NSUInteger TBKTabBarStyle;
enum {
	TBKTabBarStyleDefault = 1,
	TBKTabBarStyleArrowIndicator = 2,
};

@class TBKTabBarItem;
@protocol TBKTabBarDelegate;

/*!
@class TBKTabBar
@superclass UIView
@abstract
@discussion
*/
@interface TBKTabBar : UIView

@property (nonatomic, assign) id <TBKTabBarDelegate> delegate;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) TBKTabBarItem *selectedTabBarItem;

@property (nonatomic, assign) TBKTabBarStyle tabBarStyle;

#pragma mark Designated Initialzer

-(id) initWithFrame:(CGRect)aFrame style:(TBKTabBarStyle)aStyle;

/*!
@abstract Will fade in or out or reorder and adjust spacing.
*/
-(void) setItems:(NSArray *)tabItems animated:(BOOL)animated;

#pragma mark Reorder

/*!
@abstract List all items that can be reordered. Always animates a sheet up. 
visible items not listed are fixed in place.
*/
-(void) beginCustomizingItems:(NSArray *)tabItems;

/*!
@abstract Hide customization sheet. normally you should let the user do it.
Check list of items to see new layout. returns YES if layout changed
*/
-(BOOL) endCustomizingAnimated:(BOOL)animated;
-(BOOL) isCustomizing;

@end

#pragma mark -

/*!
@protocol TBKTabBarDelegate <NSObject>
@abstract 
*/
@protocol TBKTabBarDelegate <NSObject>

@optional
-(void) tabBar:(TBKTabBar *)aTabBar didSelectTabAtIndex:(NSUInteger)anIndex;

@optional

-(void) tabBar:(TBKTabBar *)tabBar willBeginCustomizingItems:(NSArray *)items;
-(void) tabBar:(TBKTabBar *)tabBar willEndCustomizingItems:(NSArray *)items changed:(BOOL)changed;
-(void) tabBar:(TBKTabBar *)tabBar didBeginCustomizingItems:(NSArray *)items;
-(void) tabBar:(TBKTabBar *)tabBar didEndCustomizingItems:(NSArray *)items changed:(BOOL)changed;

@end
