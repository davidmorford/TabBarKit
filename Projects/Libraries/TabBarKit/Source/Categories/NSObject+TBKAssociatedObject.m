
#import <TabBarKit/NSObject+TBKAssociatedObject.h>

@implementation NSObject (TBKAssociatedObject)

-(void) associateValue:(id)aValue withKey:(NSString *)aKey {
	objc_setAssociatedObject(self, [aKey cStringUsingEncoding:NSUTF8StringEncoding], aValue, TBKAssociationPolicyRetainNonatomic);
}

-(void) associateValue:(id)aValue withKey:(NSString *)aKey policy:(TBKAssociationPolicy)aPolicy;{
	objc_setAssociatedObject(self, [aKey cStringUsingEncoding:NSUTF8StringEncoding], aValue, aPolicy);
}

-(id) associatedValueForKey:(NSString *)aKey {
	return objc_getAssociatedObject(self, [aKey cStringUsingEncoding:NSUTF8StringEncoding]);
}

-(void) removeAssociatedValueForKey:(NSString *)aKey {
	[self associateValue:nil withKey:aKey policy:TBKAssociationPolicyAssign];
}

@end
