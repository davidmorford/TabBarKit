
#import <TabBarKit/UIImage+TBKMasking.h>

@implementation UIImage (TBKTabBarImage)

-(UIImage *) tabBarImage {
	return ([self imageMaskedWithColors:[NSArray arrayWithObjects:[UIColor colorWithHue:(0.0/360.0) saturation:(0.0/100.0) brightness:(62.0/100.0) alpha:(1.0/1.0)], [UIColor colorWithHue:(0.0/360.0) saturation:(0.0/100.0) brightness:(27.0/100.0) alpha:(1.0/1.0)], nil] 
								opacity:0.0]);
}

-(UIImage *) selectedTabBarImage {
	return ([self imageMaskedWithColors:[NSArray arrayWithObjects:[UIColor colorWithHue:(216.0/360.0) saturation:(19.0/100.0) brightness:(97.0/100.0) alpha:(1.0/1.0)], [UIColor colorWithHue:(206.0/360.0) saturation:(100.0/100.0) brightness:(96.0/100.0) alpha:(1.0/1.0)], nil] 
								opacity:0.0]);
}

@end

#pragma mark -

@implementation UIImage (TBKMasking)

-(UIImage *) imageMaskedWithColors:(NSArray *)aColorList opacity:(CGFloat)anOpacity {
	if (aColorList) {
		UIImage *image;
		UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0);
		{
			CGRect rect = CGRectZero;
			rect.size = [self size];
			CGContextRef context = UIGraphicsGetCurrentContext();
			CGContextSaveGState(context);
			{
				CGContextTranslateCTM(context, 0, rect.size.height);
				CGContextScaleCTM(context, 1.0, -1.0);
				
				CGRect maskRect = CGRectMake(0, 0, self.size.width, self.size.height);
				CGContextClipToMask(context, maskRect, self.CGImage);

				CGContextSaveGState(context);
				{
					CGContextSaveGState(context);
					{
						CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
						CGContextAddRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
						CGContextClosePath(context);
					}
					CGContextRestoreGState(context);
					
					CGContextClip(context);
					NSMutableArray *ar = [NSMutableArray array];
					for (UIColor *c in aColorList) {
						[ar addObject:(id)c.CGColor];
					}
					CGColorSpaceRef space = CGBitmapContextGetColorSpace(context);
					CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)ar, NULL);
					CGContextDrawLinearGradient(context,
												gradient, 
												CGPointMake(rect.origin.x, rect.origin.y + rect.size.height),  //BUGBUG: Flip?
												CGPointMake(rect.origin.x, rect.origin.y), 
												kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
					CGGradientRelease(gradient);
				}
				CGContextRestoreGState(context);
			}
			CGContextRestoreGState(context);
			image = UIGraphicsGetImageFromCurrentImageContext();
		}
		UIGraphicsEndImageContext();
		return image;
	}
	return self;
}

@end
