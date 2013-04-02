
#import "TBKCContentViewController.h"
#import <TabBarKit/TBKTabBarController.h>

@implementation TBKCContentViewController

#pragma mark UIViewController

-(id) init {
	self = [super initWithNibName:nil bundle:nil];
	if (!self) {
		return nil;
	}
	return self;
}


#pragma mark UIViewController

-(void) loadView {
	[super loadView];
	self.title = @"Content";
	self.view.backgroundColor = [UIColor grayColor];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


#pragma mark Memory

-(void) viewDidUnload {
	[super viewDidUnload];
}

-(void) didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end
