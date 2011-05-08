
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
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.userInteractionEnabled = TRUE;
	self.window.backgroundColor = [UIColor blackColor];
	self.window.contentMode = UIViewContentModeScaleToFill;
	self.window.autoresizesSubviews = TRUE;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		self.tabBarController = [[TBKTabBarController alloc] initWithStyle:TBKTabBarStyleDefault];
		self.tabBarController.delegate = self;
		self.tabBarController.viewControllers = [NSArray arrayWithObjects:
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCMasterViewController alloc] init] autorelease]] autorelease],
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCDetailViewController alloc] init] autorelease]] autorelease],
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCImagesViewController alloc] init] autorelease]] autorelease],
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCSettingsViewController alloc] init] autorelease]] autorelease],
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCMoviesViewController alloc] init] autorelease]] autorelease],
												 nil];
		self.window.rootViewController = self.tabBarController;
	}
	else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		self.tabBarController = [[TBKTabBarController alloc] initWithStyle:TBKTabBarStyleArrowIndicator];
		self.tabBarController.delegate = self;
		self.tabBarController.viewControllers = [NSArray arrayWithObjects:
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCMasterViewController alloc] init] autorelease]] autorelease],
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCDetailViewController alloc] init] autorelease]] autorelease],
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCImagesViewController alloc] init] autorelease]] autorelease],
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCSettingsViewController alloc] init] autorelease]] autorelease],
												 [[[UINavigationController alloc] initWithRootViewController:[[[TBKCMoviesViewController alloc] init] autorelease]] autorelease],
												 nil];
		self.window.rootViewController = self.tabBarController;
	}
	[self.window makeKeyAndVisible];
	return TRUE;
}

#pragma mark <TBKTabBarControllerDelegate>

-(void) tabBarController:(TBKTabBarController *)tbc didSelectViewController:(UIViewController *)controller {
	
}

#pragma mark Memory

-(void) dealloc {
	self.tabBarController = nil;
	self.window = nil;
	[super dealloc];
}

@end
