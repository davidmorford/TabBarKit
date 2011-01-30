
/*!
@project    TabBarKit
@header     UIImage+TBKMasking.h
@copyright  (c) 2010 - 2011, David Morford
*/

#import <UIKit/UIKit.h>

@interface UIImage (TBKTabBarImage)

-(UIImage *) tabBarImage;
-(UIImage *) selectedTabBarImage;

@end

#pragma mark -

/*!
@class UIImage (TBKMasking)
@abstract
@discussion
*/
@interface UIImage (TBKMasking)

-(UIImage *) imageMaskedWithColors:(NSArray *)aColorList opacity:(CGFloat)anOpacity;

@end

