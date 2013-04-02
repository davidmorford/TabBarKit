
#import <TabBarKit/TBKTabBarItem.h>
#import <TabBarKit/UIImage+TBKMasking.h>

@interface TBKTabBarItemSelectionLayer : CAShapeLayer
-(id) initWithItemFrame:(CGRect)itemFrame style:(TBKTabBarItemSelectionStyle)aStyle;
@end

@implementation TBKTabBarItemSelectionLayer

-(id) initWithItemFrame:(CGRect)itemFrame style:(TBKTabBarItemSelectionStyle)aStyle {
	self = [super init];
	if (!self) {
		return nil;
	}
	self.needsDisplayOnBoundsChange = YES;
	
	CGRect insetFrame = CGRectZero;
	if (aStyle == TBKTabBarItemIndicatorSelectionStyle) {
		insetFrame = CGRectMake(0, 3, itemFrame.size.width, itemFrame.size.height - 3);
	}
	else if (aStyle == TBKTabBarItemDefaultSelectionStyle) {
		insetFrame = CGRectMake(0, 2, itemFrame.size.width, itemFrame.size.height - 6);
	}
	
	self.position = CGPointMake(0,0);
	self.anchorPoint = CGPointMake(0.0, 0.0);
	self.frame = insetFrame;
	
	UIBezierPath *roundedRectPath = nil;
	
	if (aStyle == TBKTabBarItemIndicatorSelectionStyle) {
		roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:insetFrame 
												byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) 
													  cornerRadii:CGSizeMake(5.0, 5.0)];
	}
	else if (aStyle == TBKTabBarItemDefaultSelectionStyle) {
		roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:insetFrame 
												byRoundingCorners:(UIRectCornerAllCorners) 
													  cornerRadii:CGSizeMake(5.0, 5.0)];	
	}
	self.path = roundedRectPath.CGPath;
	self.fillColor = [UIColor colorWithWhite:(50.0/100.0) alpha:0.25].CGColor;
	return self;
}

@end

#pragma mark -

@interface TBKBadgeLayer : CAShapeLayer
@property (nonatomic, weak) CATextLayer *countTextLayer;
-(void) setCountString:(NSString *)aString;
@end

@implementation TBKBadgeLayer

@synthesize countTextLayer;

-(id) initWithFrame:(CGRect)rect count:(NSString *)countString {
	self = [super init];
	if (!self) {
		return nil;
	}
	//self.needsDisplayOnBoundsChange = YES;
	self.anchorPoint = CGPointMake(0.0, 0.0);
	self.bounds = CGRectMake(0, 0, 14, 14);
	
	NSLog(@"%@", NSStringFromCGRect(rect));
	
	self.position = CGPointMake(CGRectGetWidth(rect) - 3.0, 3.0);
	NSLog(@"%@", NSStringFromCGPoint(self.position));
	NSLog(@"%@", NSStringFromCGPoint(CGPointMake(20.0 - 3.0, 3.0)));
	
	UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
	self.path = circlePath.CGPath;
	self.fillColor = [UIColor redColor].CGColor;
	//self.borderColor  = [UIColor whiteColor].CGColor;
	//self.borderWidth = 1.0;
	
	self.countTextLayer = [CATextLayer layer];
	self.countTextLayer.position = CGPointMake(0.0, 3.0);
	self.countTextLayer.anchorPoint = CGPointMake(0.0, 0.0);
	self.countTextLayer.bounds = self.bounds;
	
	self.countTextLayer.string = countString;
	self.countTextLayer.fontSize = 12.0;
	self.countTextLayer.alignmentMode = @"center";
	
	[self addSublayer:self.countTextLayer];
	
	return self;
}

-(void) setCountString:(NSString *)aString {
	self.countTextLayer.string = aString;
	[self setNeedsDisplay];
}



@end

#pragma mark -

@interface TBKTabBarItem ()
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImage *tabImage;
@property (nonatomic, strong) UIImage *selectedTabImage;
@property (nonatomic, assign) TBKTabBarItemSelectionStyle selectionStyle;

@property (nonatomic, strong) NSString *controllerTitle;
@property (nonatomic, strong) NSString *tabTitle;
@property (nonatomic, assign) BOOL displayTitle;

@property (nonatomic, strong) TBKTabBarItemSelectionLayer *selectionLayer;
@property (nonatomic, strong) TBKBadgeLayer *badgeLayer;
@end

#pragma mark -

@implementation TBKTabBarItem

@synthesize badgeValue;
@synthesize imageName;
@synthesize tabImage;
@synthesize selectedTabImage;
@synthesize selectionStyle;
@synthesize controllerTitle;
@synthesize tabTitle;
@synthesize displayTitle;
@synthesize selectionLayer;
@synthesize badgeLayer;


#pragma mark Initializers

-(id) initWithImageName:(NSString *)anImageName style:(TBKTabBarItemSelectionStyle)aStyle {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	self.selectionStyle = aStyle;
	self.backgroundColor = [UIColor clearColor];
	
	// Image
	self.imageName = anImageName;
	self.tabImage = [[UIImage imageNamed:self.imageName] tabBarImage];
	self.selectedTabImage = [[UIImage imageNamed:self.imageName] selectedTabBarImage];
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self setImage:self.tabImage forState:UIControlStateNormal];
	[self setImage:self.selectedTabImage forState:UIControlStateSelected];
	
	return self;
}

-(id) initWithImageName:(NSString *)anImageName style:(TBKTabBarItemSelectionStyle)aStyle tag:(NSInteger)aTag {
	self = [self initWithImageName:anImageName style:aStyle];
	if (!self) {
		return nil;
	}
	self.tag = aTag;
	return self;
}

-(id) initWithImageName:(NSString *)anImageName style:(TBKTabBarItemSelectionStyle)aStyle tag:(NSInteger)aTag title:(NSString *)aTitle {
	self = [self initWithImageName:anImageName style: aStyle tag:aTag];
	if (!self) {
		return nil;
	}
	self.controllerTitle = aTitle;
	self.tabTitle = aTitle; // Should be from controller...
	
	if (self.controllerTitle && self.selectionStyle == TBKTabBarItemDefaultSelectionStyle) {
		/*
		self.displayTitle = YES;
		self.titleLabel.font = [UIFont boldSystemFontOfSize:10.0];
		self.titleLabel.textAlignment = UITextAlignmentCenter;
		self.titleLabel.contentMode = UIViewContentModeLeft;
		self.imageEdgeInsets = UIEdgeInsetsMake(0, 22, 11, 0);
		self.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 2, 0);
		[self setTitle:self.controllerTitle forState:(UIControlStateNormal | UIControlStateSelected)];
		*/
	}
	return self;
}


#pragma mark UIControl

-(void) setSelected:(BOOL)flag {
	[super setSelected:flag];
	[self.selectionLayer removeFromSuperlayer];
	self.selectionLayer = nil;
	selectionLayer = [[TBKTabBarItemSelectionLayer alloc] initWithItemFrame:self.bounds style:self.selectionStyle];
	if (flag) {
		if (![self.layer.sublayers containsObject:self.selectionLayer]) {
			[self.layer addSublayer:self.selectionLayer];
		}
	}
	else {
		if ([self.layer.sublayers containsObject:self.selectionLayer]) {
			[self.selectionLayer removeFromSuperlayer];
		}
	}
	[self setNeedsDisplay];
}


-(void) setHighlighted:(BOOL)flag {

}

-(void) setBadgeValue:(NSNumber *)aValue {
	if ([badgeValue compare:aValue] != NSOrderedSame) {
		badgeValue = [aValue copy];
	}
	if (!self.badgeLayer) {
		badgeLayer = [[TBKBadgeLayer alloc] initWithFrame:self.bounds count:[aValue stringValue]];
		[self.layer addSublayer:self.badgeLayer];
	}
	if (self.badgeLayer && [aValue unsignedIntegerValue] == 0) {
		[self.badgeLayer removeFromSuperlayer];
		return;
	}
	else {
		[self.badgeLayer setCountString:[aValue stringValue]];
	}
}



#pragma mark -

-(void) dealloc {
	self.badgeValue = nil;
}

@end
