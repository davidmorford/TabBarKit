
#import "TBKCMoviesViewController.h"
#import "TBKCContentViewController.h"

@implementation TBKCMoviesViewController

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
	self.title = @"Films";
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return TRUE;
}

-(NSString *) tabImageName {
	return @"Super8";
}


#pragma mark <UITableViewDataSource>

-(NSInteger) numberOfSectionsInTableView:(UITableView *)aTableView {
	return 1;
}

-(NSInteger) tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"CellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [NSString stringWithFormat:@"Item %d", indexPath.row];
	return cell;
}


#pragma mark <UITableViewDelegate>

-(void) tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
	TBKCContentViewController *contentViewController = [[TBKCContentViewController alloc] init];
	contentViewController.hidesBottomBarWhenPushed = YES;
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
