//
//  Person.h
//  Factory
//

#import "MemoryPayload.h"

@protocol LocationProtocol;

/**
 *  The class represents a simple person.
 */
@interface Person : NSObject

/**
 *  Returns the first name of the person.
 */
@property (nonatomic, copy) NSString *name;

/**
 *  Returns the last name of the person.
 */
@property (nonatomic, copy) NSString *surname;

/**
 *  Returns the current location of the person.
 */
@property (nonatomic, readonly) id<LocationProtocol> location;

/**
 *  Moves the receiver to the specific location.
 */
- (void)moveToLocation:(id<LocationProtocol>)location;

@end
