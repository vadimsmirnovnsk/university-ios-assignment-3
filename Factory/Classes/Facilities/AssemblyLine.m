//
//  AssemblyLine.m
//  Factory
//

#import "AssemblyLine.h"
#import "FinishedProduct.h"

@implementation AssemblyLine

@synthesize latitude = latitude_;
@synthesize longitude = longitude_;

#pragma mark - LocationProtocol implementation

- (float)latitude
{
    return latitude_;
}

- (float)longitude
{
    return longitude_;
}

#pragma mark - Processing

- (FinishedProduct *)processRawMaterials:(NSSet *)rawMaterials
{
    //sleep(1);
    return [[[FinishedProduct alloc] initWithRawMaterials:rawMaterials]autorelease];
}

@end
