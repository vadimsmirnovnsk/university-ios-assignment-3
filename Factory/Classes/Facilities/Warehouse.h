//
//  Warehouse.h
//  Factory
//

#import <Foundation/Foundation.h>

#import "LocationProtocol.h"
#import "WarehouseProtocol.h"

static NSString *const WarehouseErrorDomain;
static NSString *const kWarehouseErrorDescription;

static const NSInteger WarehouseErrorCodeNotEnoughWares;

/**
 *  The class represents a simple warehouse.
 */
@interface Warehouse : NSObject
    <LocationProtocol, WarehouseProtocol>

@property (nonatomic, getter = capacity) NSUInteger capacity;

/**
 *  Returns the geographic coordinate that specifies
 *  the north-south position of the location.
 */
@property (nonatomic, getter = latitude) float latitude;

/**
 *  Returns the geographic coordinate that specifies
 *  the east-west position of the location.
 */
@property (nonatomic, getter = longitude) float longitude;

@end
