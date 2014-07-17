//
//  LocationProtocol.h
//  Factory
//

#import <Foundation/Foundation.h>

/**
 *  The particular protocol defines behaviour of an abstract location.
 */
@protocol LocationProtocol <NSObject>

/**
 *  Returns the geographic coordinate that specifies
 *  the north-south position of the location.
 */
- (float)latitude;

/**
 *  Returns the geographic coordinate that specifies
 *  the east-west position of the location.
 */
- (float)longitude;

@end
