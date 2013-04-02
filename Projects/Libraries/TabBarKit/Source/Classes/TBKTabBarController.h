
/*!
@project    TabBarKit
@header     TBKTabBarController.h
@copyright  (c) 2010 - 2011, David Morford
*/

#import <UIKit/UIKit.h>
#import <TabBarKit/TBKTabBar.h>
#import <TabBarKit/TBKTabBarItem.h>

@class TBKTabBarView;
@protocol  TBKTabBarControllerDelegate;

/*!
@class TBKTabBarController
@superclass UIViewController <TBKTabBarDelegate>
@abstract
*/
@interface TBKTabBarController : UIViewController <TBKTabBarDelegate>

@property (nonatomic, weak) id <TBKTabBarControllerDelegate> delegate;

@property (nonatomic, strong) TBKTabBar *tabBar;
@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIViewController *selectedViewController;

@property (nonatomic, strong, readonly) UINavigationController *moreNavigationController;
@property (nonatomic, copy) NSArray *customizableViewControllers;

#pragma mark Designated Initializer

-(id) initWithStyle:(TBKTabBarStyle)aStyle;

-(void) setViewControllers:(NSArray *)controllers animated:(BOOL)animated;

@end

#pragma mark -

/*!
@protocol TBKTabBarControllerDelegate <NSObject>
@abstract 
*/
@protocol TBKTabBarControllerDelegate <NSObject>

@optional
-(BOOL) tabBarController:(TBKTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
-(void) tabBarController:(TBKTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

-(void) tabBarController:(TBKTabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers;
-(void) tabBarController:(TBKTabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed;
-(void) tabBarController:(TBKTabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed;

@end

#pragma mark -

/*!
@category UIViewController (TBKTabBarControllerItem)
@abstract 
*/
@interface UIViewController (TBKTabBarControllerItem) <TBKTabBarItemDataSource>

@property (nonatomic, retain) TBKTabBarItem *tabItem;
@property (nonatomic, retain) TBKTabBarController *tabController;

@end

#pragma mark -

/*!
@category UINavigationController (TBKTabBarControllerItem)
@abstract 
*/
@interface UINavigationController (TBKTabBarControllerItem) <TBKTabBarItemDataSource>
@end
