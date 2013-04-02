
#import "TBKCSettingsViewController.h"

@implementation TBKCSettingsViewController

#pragma mark Initializer

-(id) init {
	self = [super initWithStyle:UITableViewStyleGrouped];
	if (!self) {
		return nil;
	}
	return self;
}


#pragma mark UIViewController

-(void) loadView {
	[super loadView];
	self.title = @"Settings";
}

-(void) viewDidLoad {
	[super viewDidLoad];
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return TRUE;
}

-(NSString *) tabImageName {
	return @"Settings";
}


#pragma mark <UITableViewDataSource>

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tv {
	return 1;
}

-(NSInteger) tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)aSection {
	return 2;
}

-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)anIndexPath {
	static NSString *CellIdentifier = @"CellIdentifier";
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	cell.textLabel.text = [NSString stringWithFormat:@"Settings %d", anIndexPath.row];
	return cell;
}

#pragma mark Gozer

-(void) didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

-(void) viewDidUnload {
	[super viewDidUnload];
}


@end
