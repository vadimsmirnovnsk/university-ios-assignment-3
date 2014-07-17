//
//  WarehouseProtocol.h
//  Factory
//

#import <Foundation/Foundation.h>

@protocol WareProtocol;

/**
 *  The particular protocol defines behaviour of an abstract warehouse.
 */
@protocol WarehouseProtocol <NSObject>

/**
 *  Says whether the warehouse is empty.
 */
- (BOOL)isEmpty;

/**
 *  Says whether the warehouse is full of wares.
 */
- (BOOL)isFull;

/**
 *  Returns the total number of wares the receiver is able to keep.
 */
- (NSUInteger)capacity;

/**
 *  Puts the specified ware into the warehouse.
 */
- (void)putWare:(id<WareProtocol>)ware;

/**
 *  Ships the specified count of wares if possible.
 *
 *  @remarks    If there is not enough wares in the warehouse,
 *              upon return contains an @b NSError object that
 *              describes the problem.
 */
- (NSSet *)shipWaresOfCount:(NSUInteger)count
                      error:(NSError **)error;

@end
