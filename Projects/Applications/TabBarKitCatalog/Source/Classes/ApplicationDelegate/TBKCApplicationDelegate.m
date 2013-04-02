
#import "TBKCApplicationDelegate.h"

#import "TBKCMasterViewController.h"
#import "TBKCDetailViewController.h"
#import "TBKCImagesViewController.h"
#import "TBKCSettingsViewController.h"
#import "TBKCContentViewController.h"
#import "TBKCMoviesViewController.h"

#import "TBKCUserDefaults.h"

@implementation TBKCApplicationDelegate

@synthesize window;
@synthesize tabBarController;

#pragma mark Shared Delegate

+(TBKCApplicationDelegate *) sharedApplicationDelegate {
	return (TBKCApplicationDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark <UIApplicationDelegate>

-(BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	window.userInteractionEnabled = TRUE;
	window.backgroundColor = [UIColor blackColor];
	window.contentMode = UIViewContentModeScaleToFill;
	window.autoresizesSubviews = TRUE;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		tabBarController = [[TBKTabBarController alloc] initWithStyle:TBKTabBarStyleDefault];
		tabBarController.delegate = self;
		tabBarController.viewControllers = [NSArray arrayWithObjects:
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCMasterViewController alloc] init]],
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCDetailViewController alloc] init]],
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCImagesViewController alloc] init]],
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCSettingsViewController alloc] init]],
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCMoviesViewController alloc] init]],
												 nil];
		window.rootViewController = self.tabBarController;
	}
	else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		tabBarController = [[TBKTabBarController alloc] initWithStyle:TBKTabBarStyleArrowIndicator];
		tabBarController.delegate = self;
		tabBarController.viewControllers = [NSArray arrayWithObjects:
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCMasterViewController alloc] init]],
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCDetailViewController alloc] init]],
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCImagesViewController alloc] init]],
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCSettingsViewController alloc] init]],
												 [[UINavigationController alloc] initWithRootViewController:[[TBKCMoviesViewController alloc] init]],
												 nil];
		window.rootViewController = self.tabBarController;
	}
	[window makeKeyAndVisible];
	return TRUE;
}

#pragma mark <TBKTabBarControllerDelegate>

-(void) tabBarController:(TBKTabBarController *)tbc didSelectViewController:(UIViewController *)controller {
	
}

#pragma mark Memory

-(void) dealloc {
	tabBarController = nil;
	window = nil;
}

@end
