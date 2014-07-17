//
//  AssemblyLine.h
//  Factory
//

#import "LocationProtocol.h"

@class FinishedProduct;

/**
 *  The class represent a simple assembly line in action.
 */
@interface AssemblyLine : NSObject
    <LocationProtocol>

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

/**
 *  Processes the given raw materials in order to produce a finished product.
 */
- (FinishedProduct *)processRawMaterials:(NSSet *)rawMaterials;

@end
