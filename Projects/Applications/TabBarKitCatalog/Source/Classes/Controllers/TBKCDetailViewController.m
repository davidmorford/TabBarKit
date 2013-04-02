
#import "TBKCDetailViewController.h"
#import "TBKCContentViewController.h"

@implementation TBKCDetailViewController

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
	self.title = @"Books";
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return TRUE;
}

-(NSString *) tabImageName {
	return @"Book";
}

#pragma mark <UITableViewDataSource>

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tv {
	return 1;
}

-(NSInteger) tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)aSection {
	return 16;
}

-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)anIndexPath {
	static NSString *CellIdentifier = @"CellIdentifier";
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [NSString stringWithFormat:@"Settings %d", anIndexPath.row];
	return cell;
}


#pragma mark <UITableViewDelegate>

-(void) tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
	TBKCContentViewController *contentViewController = [[TBKCContentViewController alloc] init];
	[self.navigationController pushViewController:contentViewController animated:TRUE];
}


#pragma mark Gozer

-(void) viewDidUnload {
	[super viewDidUnload];
}

-(void) didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end
