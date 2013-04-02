
#import <TabBarKit/TBKTabBarController.h>
#import <TabBarKit/TBKTabBar.h>
#import <TabBarKit/TBKTabBarItem.h>
#import <TabBarKit/NSObject+TBKAssociatedObject.h>
#import <QuartzCore/QuartzCore.h>

static CGFloat const TBKTabBarDefaultStyleHeight = 49.0;
static CGFloat const TBKTabBarArrowIndicatorHeight = 44.0;

@interface TBKMoreListController : UITableViewController
@property (nonatomic, strong) NSArray *moreViewControllers;
@property (nonatomic, weak) UIBarButtonItem *moreEditButtonItem;
@property (nonatomic, assign) BOOL allowsCustomizing;
@end

#pragma mark -

@interface TBKTabBarController () <UINavigationControllerDelegate>
@property (nonatomic, strong, readwrite) UINavigationController *moreNavigationController;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) TBKTabBarStyle tabBarStyle;
@property (nonatomic, assign) CGFloat tabBarHeight;
@property (nonatomic, assign) BOOL displaysTabBarItemTitles;
-(void) loadViewControllers;
@end

#pragma mark -

@implementation TBKTabBarController

@synthesize delegate;
@synthesize tabBar;
@synthesize tabBarStyle;
@synthesize tabBarHeight;
@synthesize containerView;
@synthesize viewControllers;
@synthesize selectedViewController;
@synthesize moreNavigationController;
@synthesize customizableViewControllers;
@synthesize selectedIndex;
@synthesize displaysTabBarItemTitles;

#pragma mark - Initializer

-(id) initWithStyle:(TBKTabBarStyle)aStyle {
	self = [super initWithNibName:nil bundle:nil];
	if (!self) {
		return nil;
	}
	self.tabBarStyle = aStyle;
	if (self.tabBarStyle == TBKTabBarStyleArrowIndicator) {
		self.tabBarHeight = TBKTabBarArrowIndicatorHeight;
	}
	else if (self.tabBarStyle == TBKTabBarStyleDefault) {
		self.tabBarHeight = TBKTabBarDefaultStyleHeight;
	}
	return self;
}


#pragma mark - UIViewController

-(void) loadView {
	[super loadView];
}

-(void) viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor clearColor];
		
	self.containerView = [[UIView alloc] initWithFrame:self.view.frame];
	self.view = self.containerView;
	
	self.tabBar = [[TBKTabBar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - self.tabBarHeight, CGRectGetWidth(self.view.bounds), self.tabBarHeight) 
											  style:self.tabBarStyle];
	self.tabBar.delegate = self;
	
	[self.containerView addSubview:self.tabBar];
	[self loadViewControllers];
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self addObserver:self forKeyPath:@"viewControllers" options:(NSKeyValueObservingOptionNew) context:nil];
}


#pragma mark - KVO

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	#ifdef __KVODEBUG__
	NSLog(@"Key Value Observing <%p %@> keyPath: %@ object: <%p %@>", self, NSStringFromClass([self class]), keyPath, object, NSStringFromClass([object class]));
	#endif
	if (object == self) {
		if ([keyPath isEqualToString:@"viewControllers"]) {
			id newValue = [change objectForKey:NSKeyValueChangeNewKey];
			if (![newValue isEqual:[NSNull null]] && (newValue != nil)) {
				[self loadViewControllers];
			}
		}
	}
}


#pragma mark - View Controler Loading

-(void) setViewControllers:(NSArray *)controllers animated:(BOOL)animated {
	self.viewControllers = controllers;
}

-(void) loadViewControllers {
	NSMutableArray *controllerTabs = [NSMutableArray arrayWithCapacity:[self.viewControllers count]];
	NSUInteger tagIndex = 0;
	for (UIViewController *controller in self.viewControllers) {
		if ([controller isKindOfClass:[UINavigationController class]]) {
			((UINavigationController *)controller).delegate = self;
		}
		TBKTabBarItem *tabItem = [[TBKTabBarItem alloc] initWithImageName:controller.tabImageName style:self.tabBarStyle tag:tagIndex title:controller.title];
		[controllerTabs addObject:tabItem];
		[controller setTabItem:tabItem];
		[controller setTabController:self];
		tagIndex++;
	}
	self.tabBar.items = controllerTabs;
}

-(void) unloadViewControllers {

}


#pragma mark - <TBKTabBarDelegate>

-(void) tabBar:(TBKTabBar *)aTabBar didSelectTabAtIndex:(NSUInteger)anIndex {
	UIViewController *vc = [self.viewControllers objectAtIndex:anIndex];
	if (self.selectedViewController == vc) {
		if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
			[(UINavigationController *)self.selectedViewController popToRootViewControllerAnimated:YES];
		}
	}
	else {
		self.selectedViewController = vc;
		[self.selectedViewController viewWillAppear:NO];
		
		[self.containerView removeFromSuperview];
		self.containerView = self.selectedViewController.view;
		self.selectedViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | 
															 UIViewAutoresizingFlexibleHeight | 
															 UIViewAutoresizingFlexibleBottomMargin);
		CGFloat containerViewHeight = CGRectGetHeight(self.view.bounds);
		containerViewHeight -= CGRectGetHeight(self.tabBar.bounds);
		self.selectedViewController.view.frame = CGRectMake(CGRectGetMinX(self.view.bounds), 
												 CGRectGetMinY(self.view.bounds), 
												 CGRectGetWidth(self.view.bounds), 
												 containerViewHeight);
		[self.view addSubview:self.containerView];
		[self.view sendSubviewToBack:self.containerView];
		[self.containerView setNeedsLayout];
		[self.selectedViewController viewDidAppear:NO];
		self.selectedIndex = anIndex;
	}
	
	if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
		[self.delegate tabBarController:self 
				didSelectViewController:self.selectedViewController];
	}
}


#pragma mark - <UINavigationControllerDelegate>

-(void) navigationController:(UINavigationController *)nvc willShowViewController:(UIViewController *)vc animated:(BOOL)animated {
	[vc setTabItem:nvc.tabItem];
	[vc setTabController:nvc.tabController];
	if (vc.hidesBottomBarWhenPushed == YES && self.tabBar.hidden == NO) {
		self.containerView.frame = self.view.bounds;
		// One *might* be inclined to think UINavigationControllerHideShowBarDuration would work best here. Sadly not so.
		[UIView animateWithDuration:0.275 
							  delay:0 
							options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseIn)
						 animations:^{
							 CGRect tabBarBounds = self.tabBar.frame;
							 tabBarBounds.origin.x -= CGRectGetMaxX(self.containerView.frame);
							 self.tabBar.frame = tabBarBounds;
						 } 
						 completion:^(BOOL finished){
							self.tabBar.hidden = YES;
						 }];
		return;
	}
	else if (vc.hidesBottomBarWhenPushed == NO && self.tabBar.hidden == YES) {
		self.tabBar.hidden = NO;
		[UIView animateWithDuration:0.275 
							  delay:0 
							options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseIn)
						 animations:^{
						     CGRect tabBarBounds = self.tabBar.frame;
							 tabBarBounds.origin.x = CGRectGetMinX(self.view.bounds);
							 self.tabBar.frame = tabBarBounds;
						 } 
						 completion:^(BOOL finished){
							 [UIView animateWithDuration:0.1 delay:0 
												 options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionBeginFromCurrentState)
											  animations:^{
												  self.containerView.frame = CGRectMake(CGRectGetMinX(self.view.bounds), 
																						CGRectGetMinY(self.view.bounds), 
																						CGRectGetWidth(self.view.bounds), 
																						(CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.tabBar.bounds)));
											  }
											  completion:^(BOOL finished){
											  }];
						 }];
		return;
	}
}

-(void) navigationController:(UINavigationController *)nvc didShowViewController:(UIViewController *)vc animated:(BOOL)animated {

}


#pragma mark - UIInterfaceOrientation

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)anOrientation {
    BOOL shouldRotate = YES;
    if (selectedViewController && [selectedViewController respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)])
    {
        shouldRotate = [self.selectedViewController shouldAutorotateToInterfaceOrientation:anOrientation];
    }
    return shouldRotate;
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)anOrientation duration:(NSTimeInterval)aDuration {
	if (UIInterfaceOrientationIsPortrait(anOrientation)) {
		for (TBKTabBarItem *tabBarItem in self.tabBar.items) {
			if (self.displaysTabBarItemTitles) {
				tabBarItem.imageEdgeInsets = UIEdgeInsetsMake(0, 22, 11, 0);
				tabBarItem.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 2, 0);
			}
			else {
				tabBarItem.imageEdgeInsets = UIEdgeInsetsZero;
			}
			[tabBarItem setNeedsDisplay];
		}
	}
	else if (UIInterfaceOrientationIsLandscape(anOrientation)) {
		for (TBKTabBarItem *tabBarItem in self.tabBar.items) {
			if (self.displaysTabBarItemTitles) {
				tabBarItem.imageEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
				tabBarItem.titleEdgeInsets = UIEdgeInsetsMake(0, -1, 0, 0);
			}
			else {
				tabBarItem.imageEdgeInsets = UIEdgeInsetsMake(6, 0, 0, 0);
			}
			[tabBarItem setNeedsDisplay];
		}		
	}
	[self.selectedViewController willRotateToInterfaceOrientation:anOrientation duration:aDuration];
}

-(void) willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)anOrientation duration:(NSTimeInterval)aDuration {
	[self.selectedViewController willAnimateFirstHalfOfRotationToInterfaceOrientation:anOrientation duration:aDuration];
}

-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)anOrientation duration:(NSTimeInterval)aDuration {
	[self.selectedViewController willAnimateRotationToInterfaceOrientation:anOrientation duration:aDuration];
}

-(void) willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)anOrientation duration:(NSTimeInterval)aDuration {
	[self.selectedViewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:anOrientation duration:aDuration];
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)anOrientation {
	[self.tabBar.selectedTabBarItem setSelected:YES];
	[self.selectedViewController didRotateFromInterfaceOrientation:anOrientation];
}


#pragma mark - Memory

-(void) didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

-(void) viewDidUnload {
	tabBar.delegate = nil;
	 tabBar = nil;
     containerView = nil;
	[super viewDidUnload];
}

-(void) dealloc {
	self.delegate = nil;
}

@end

#pragma mark -

@implementation UIViewController (TBKTabBarControllerItem)

static NSString * const TBKTabItemKey = @"TBKTabItemKey";
static NSString * const TBKTabControllerKey = @"TBKTabControllerKey";

@dynamic tabItem;
@dynamic tabController;

-(TBKTabBarItem *) tabItem {
	return [self associatedValueForKey:TBKTabItemKey];
}

-(void) setTabItem:(TBKTabBarItem *)anItem {
	if (anItem) {
		if ([self associatedValueForKey:TBKTabItemKey] != nil) {
			TBKTabBarItem *associatedItem = (TBKTabBarItem *)[self associatedValueForKey:TBKTabItemKey];
			if (associatedItem != anItem) {
				[self associateValue:nil withKey:TBKTabItemKey policy:TBKAssociationPolicyAssign];
				[self associateValue:anItem withKey:TBKTabItemKey policy:TBKAssociationPolicyRetainNonatomic];
			}
			[self associateValue:nil withKey:TBKTabItemKey policy:TBKAssociationPolicyAssign];
		}
		else {
			[self associateValue:anItem withKey:TBKTabItemKey policy:TBKAssociationPolicyRetainNonatomic];
		}
	}
	else {
		[self associateValue:nil withKey:TBKTabItemKey policy:TBKAssociationPolicyAssign];
	}
}

-(TBKTabBarController *) tabController {
	return [self associatedValueForKey:TBKTabControllerKey];
}

-(void) setTabController:(TBKTabBarController *)aTabController {
	if (aTabController) {
		if ([self associatedValueForKey:TBKTabControllerKey] != nil) {
			TBKTabBarController *associatedController = (TBKTabBarController *)[self associatedValueForKey:TBKTabControllerKey];
			if (associatedController != aTabController) {
				[self associateValue:nil withKey:TBKTabControllerKey policy:TBKAssociationPolicyAssign];
				[self associateValue:aTabController withKey:TBKTabControllerKey policy:TBKAssociationPolicyRetainNonatomic];
			}
		}
		else {
			[self associateValue:aTabController withKey:TBKTabControllerKey policy:TBKAssociationPolicyRetainNonatomic];
		}
	}
	else {
		[self associateValue:nil withKey:TBKTabControllerKey policy:TBKAssociationPolicyAssign];
	}
}

-(NSString *) tabImageName {
	return nil;
}

-(NSString *) tabTitle {
	return nil;
}

@end

#pragma mark -

@implementation UINavigationController (TBKTabBarControllerItem)

-(NSString *) tabImageName {
	return [(UIViewController *)[self.viewControllers objectAtIndex:0] tabImageName];
}

-(NSString *) tabTitle {
	return [(UIViewController *)[self.viewControllers objectAtIndex:0] tabTitle];
}

@end

#pragma mark -

@implementation TBKMoreListController

@synthesize moreViewControllers;
@synthesize allowsCustomizing;
@synthesize moreEditButtonItem;

#pragma mark Initializer

-(id) init {
	self = [super initWithStyle:UITableViewStylePlain];
	if (!self) {
		return nil;
	}
	return self;
}


#pragma mark UIViewController

-(void) loadView {
	[super loadView];
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}


#pragma mark <UITableViewDataSource>

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tv {
	return 1;
}

-(NSInteger) tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return [self.moreViewControllers count];
}

-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)anIndexPath {
	static NSString *TBKMoreCellIdentifier = @"TBKMoreCellID";
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:TBKMoreCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TBKMoreCellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	UIViewController *controller = [self.moreViewControllers objectAtIndex:anIndexPath.row];
	NSString *cellTitleText = nil;
	if (controller && [controller respondsToSelector:@selector(tabTitle)]) {
		cellTitleText = [controller tabTitle];
	}
	else {
		cellTitleText = controller.title;
	}
	cell.textLabel.text = cellTitleText;
	
	if (controller && [controller respondsToSelector:@selector(tabImageName)]) {
		cell.imageView.image = [UIImage imageNamed:[controller tabImageName]];
	}
	return cell;
}


#pragma mark <UITableViewDelegate>

-(void) tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


#pragma mark TBKTabBarItemDataSource

-(NSString *) tabImageName {
	return @"TBKTabBarMoreTemplate";
}

-(NSString *) tabTitle {
	return NSLocalizedString(@"More", @"");
}


#pragma mark Memory

-(void) viewDidUnload {
	[super viewDidUnload];
}

-(void) didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end

#pragma mark -

/*
@interface TBKMoreNavigationController : UINavigationController

@property (nonatomic, retain) TBKMoreListController *moreListController;
@property (nonatomic, retain) UINavigationController *originalNavigationController;
@property (nonatomic, retain) UIViewController *originalRootViewController;

@property (nonatomic, assign) UIViewController *displayedViewController;
@property (nonatomic, retain) NSArray *moreViewControllers;
@property (nonatomic, assign) BOOL allowsCustomizing;
@end
*/
