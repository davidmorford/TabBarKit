
/*!
@project    TabBarKit
@header     NSObject+TBKAssociatedObject.h
@copyright  (c) 2010 - 2011, David Morford
@shoutout	Andy Matuschak for the orginial idea.
*/

#import <Foundation/Foundation.h>
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>

typedef objc_AssociationPolicy TBKAssociationPolicy;
enum {
	TBKAssociationPolicyAssign = OBJC_ASSOCIATION_ASSIGN,
	TBKAssociationPolicyRetainNonatomic = OBJC_ASSOCIATION_RETAIN_NONATOMIC,
    TBKAssociationPolicyCopyNonatomic = OBJC_ASSOCIATION_COPY_NONATOMIC,
	TBKAssociationPolicyRetain = OBJC_ASSOCIATION_RETAIN,
    TBKAssociationPolicyCopy = OBJC_ASSOCIATION_COPY
};

/*!
@category NSObject (TBKAssociatedObject)
@abstract 
*/
@interface NSObject (TBKAssociatedObject)

-(id) associatedValueForKey:(void *)aKey;

/*!
@abstract Retains value
*/
-(void) associateValue:(id)aValue withKey:(void *)aKey;

-(void) removeAssociatedValueForKey:(void *)aKey;

/*!
@method associateValue:withKey:policy:
@abstract Associated a value and a policy with an object instance.
@discussion Used to associate a TBKTabBarItems and TBKTabBarController instance with 
contained view controllers without requiring a silly protocol or subclass. Yum.
@param aValue 
@param aKey 
@param aPolicy 
*/
-(void) associateValue:(id)aValue withKey:(void *)aKey policy:(TBKAssociationPolicy)aPolicy;

@end
