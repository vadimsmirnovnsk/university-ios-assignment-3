//
//  Person.m
//  Factory
//

#import "Person.h"

@implementation Person

@synthesize name = name_;
@synthesize surname = surname_;
@synthesize location = location_;

#pragma mark - Movement

- (void)moveToLocation:(id<LocationProtocol>)location
{
    location_ = location;
}

- (void) dealloc {

}

@end
