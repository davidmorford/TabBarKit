
/*!
@file		main.m
@project	TabBarKitCatalog
@copyright  (c) 2010 - 2011, David Morford
@created	9/24/2010
*/

#import <UIKit/UIKit.h>

int
main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"TBKCApplicationDelegate");
	[pool release];
	return retVal;
}
