//
//  WareProtocol.h
//  Factory
//

#import <Foundation/Foundation.h>

/**
 *  The particular protocol defines behaviour of an abstract ware.
 */
@protocol WareProtocol <NSObject>

/**
 *  Returns the unique identifier of a particular ware.
 */
- (NSString *)uniqueIdentifier;

@end
