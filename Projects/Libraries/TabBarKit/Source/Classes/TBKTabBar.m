
#import <TabBarKit/TBKTabBar.h>
#import <TabBarKit/TBKTabBarItem.h>

@interface TBKArrowLayer : CAShapeLayer
@end

@implementation TBKArrowLayer

-(id) init {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	self.bounds = CGRectMake(0, 0, 10, 7);
	self.position = CGPointMake(0,0);
	self.anchorPoint = CGPointMake(0,0);
	
	UIBezierPath *trianglePath = [UIBezierPath bezierPath];
	[trianglePath moveToPoint:CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame) - 1.5)];
	[trianglePath addLineToPoint:CGPointMake(CGRectGetMidX(self.frame) - 0.25, CGRectGetMinY(self.frame))];
	[trianglePath addLineToPoint:CGPointMake(CGRectGetMidX(self.frame) + 0.25, CGRectGetMinY(self.frame))];
	[trianglePath addLineToPoint:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame) - 1.5)];
	self.path = trianglePath.CGPath;
	self.fillColor = [UIColor colorWithWhite:(25.0/100.0) alpha:1.0].CGColor;
	
	return self;
}


@end

#pragma mark -

@interface TBKTabBar ()
@property (nonatomic, strong) TBKArrowLayer *arrowLayer;
@property (nonatomic, assign) CGFloat tabMargin;
-(void) setArrowPositionAnimated:(BOOL)animated;
@end

#pragma mark -

@implementation TBKTabBar

@synthesize delegate;
@synthesize items;
@synthesize selectedTabBarItem;
@synthesize tabBarStyle;
@synthesize arrowLayer;
@synthesize tabMargin;

#pragma mark CALayer

+(Class) layerClass {
	return [CAGradientLayer class];
}


#pragma mark Initializer

-(id) initWithFrame:(CGRect)aFrame style:(TBKTabBarStyle)aStyle {
	self = [super initWithFrame:aFrame];
	if (!self) {
		return nil;
	}
	self.tabBarStyle = aStyle;
	self.tabMargin = 2.0;
	self.backgroundColor = [UIColor blackColor];
	self.userInteractionEnabled = YES;
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
	
	if (self.tabBarStyle == TBKTabBarStyleArrowIndicator) {
		arrowLayer = [[TBKArrowLayer alloc] init];
		CGRect arrowFrame = self.arrowLayer.frame;
		arrowFrame.origin.y = -(arrowFrame.size.height - 2.5f);
		arrowLayer.frame = arrowFrame;
	}

	CAGradientLayer *backingLayer = (CAGradientLayer *)self.layer;
	static NSMutableArray *colors = nil;
	if (colors == nil) {
		colors = [[NSMutableArray alloc] initWithCapacity:3];
		UIColor *color = nil;
		color = [UIColor colorWithWhite:(25.0/100.0) alpha:1.0];
		[colors addObject:(id)[color CGColor]];
		color = [UIColor colorWithWhite:(21.0/100.0) alpha:1.0];
		[colors addObject:(id)[color CGColor]];
		color = [UIColor colorWithWhite:(16.0/100.0) alpha:1.0];
		[colors addObject:(id)[color CGColor]];
		color = [UIColor colorWithWhite:(0.0/100.0) alpha:1.0];
		[colors addObject:(id)[color CGColor]];
	}
	[backingLayer setColors:colors];
	[backingLayer setLocations:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], 
														 [NSNumber numberWithFloat:0.25], 
														 [NSNumber numberWithFloat:0.49], 
														 [NSNumber numberWithFloat:0.5], nil]];
	
	if (self.tabBarStyle == TBKTabBarStyleArrowIndicator) {
		[self.layer addSublayer:self.arrowLayer];
	}
	return self;
}


#pragma mark -

-(void) setItems:(NSArray *)aTabBarItemArray {
	for (TBKTabBarItem *tabBarItem in items) {
		[tabBarItem removeFromSuperview];
	}

	items = aTabBarItemArray;

	if ([items count]) {
		[(TBKTabBarItem *)[items objectAtIndex:0] setSelected:YES];
		self.selectedTabBarItem = [items objectAtIndex:0];
		[self.delegate tabBar:self didSelectTabAtIndex:0];
	}
	for (TBKTabBarItem *tabBarItem in items) {
		tabBarItem.userInteractionEnabled = YES;
		[tabBarItem addTarget:self 
					   action:@selector(didSelectTabBarItem:) 
			 forControlEvents:UIControlEventTouchDown];
	}
	[self setNeedsLayout];
}

-(void) didSelectTabBarItem:(TBKTabBarItem *)sender {
	for (TBKTabBarItem *tab in items) {
		if (tab == sender) {
			continue;
		}
		tab.selected = NO;
	}
	sender.selected = YES;
	self.selectedTabBarItem = sender;
	[self.delegate tabBar:self didSelectTabAtIndex:[self.items indexOfObject:sender]];
	if (self.tabBarStyle == TBKTabBarStyleArrowIndicator) {
		[self setArrowPositionAnimated:YES];
	}
}

-(void) setArrowPositionAnimated:(BOOL)animated {
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
	}
	CGRect arrowLayerFrame		= self.arrowLayer.frame;
	arrowLayerFrame.origin.x	= self.selectedTabBarItem.frame.origin.x + ((self.selectedTabBarItem.frame.size.width / 2) - (arrowLayerFrame.size.width / 2));
	self.arrowLayer.frame		= arrowLayerFrame;
	if (animated) {
		[UIView commitAnimations];
	}
}


#pragma mark UIView

-(void) layoutSubviews {
	[super layoutSubviews];
	CGRect currentBounds = self.bounds;
	currentBounds.size.width /= self.items.count;
	currentBounds.size.width -= (self.tabMargin * (self.items.count + 1)) / self.items.count;
	for (TBKTabBarItem *tab in self.items) {
		currentBounds.origin.x += self.tabMargin;
		tab.frame = currentBounds;
		currentBounds.origin.x += currentBounds.size.width;
		[self addSubview:tab];
	}
	if (self.tabBarStyle == TBKTabBarStyleArrowIndicator) {
		[self setArrowPositionAnimated:NO];
	}
	[self.selectedTabBarItem setSelected:YES];
}

-(void) setFrame:(CGRect)aFrame {
	[super setFrame:aFrame];
	[self setNeedsDisplay];
}


#pragma mark -

-(void) setItems:(NSArray *)tabItems animated:(BOOL)animated {

}

-(void) beginCustomizingItems:(NSArray *)anItemArray {

}

-(BOOL) endCustomizingAnimated:(BOOL)animated {
	return NO;
}

-(BOOL) isCustomizing {
	return NO;
}


#pragma mark Memory

-(void) dealloc {
	self.delegate = nil;
}

@end
