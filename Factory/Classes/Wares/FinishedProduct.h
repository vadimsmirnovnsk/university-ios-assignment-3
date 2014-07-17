//
//  FinishedProduct.h
//  Factory
//

#import "MemoryPayload.h"
#import "WareProtocol.h"

/**
 *  The class represents a finished product.
 */
@interface FinishedProduct : MemoryPayload
    <WareProtocol>

/**
 * Does no initialization; user -initWithRawMaterials: instead.
 */
- (id)init;

/**
 *  Initializes the newly created instances of the class
 *  with the specified raw materials.
 */
- (id)initWithRawMaterials:(NSSet *)rawMaterials;

@end
