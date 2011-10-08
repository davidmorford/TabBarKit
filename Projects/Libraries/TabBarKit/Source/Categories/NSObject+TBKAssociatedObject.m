
#import <TabBarKit/NSObject+TBKAssociatedObject.h>

@implementation NSObject (TBKAssociatedObject)

-(void) associateValue:(id)aValue withKey:(void *)aKey {
	objc_setAssociatedObject(self, aKey, aValue, TBKAssociationPolicyRetainNonatomic);
}

-(void) associateValue:(id)aValue withKey:(void *)aKey policy:(TBKAssociationPolicy)aPolicy {
	objc_setAssociatedObject(self, aKey, aValue, aPolicy);
}

-(id) associatedValueForKey:(void *)aKey {
	return objc_getAssociatedObject(self, aKey);
}

-(void) removeAssociatedValueForKey:(void *)aKey {
	[self associateValue:nil withKey:aKey policy:TBKAssociationPolicyAssign];
}

@end
