//
//  RawMaterial.m
//  Factory
//

#import "RawMaterial.h"

@implementation RawMaterial

#pragma mark - WareProtocol implementation

- (NSString *)uniqueIdentifier
{
    return [self description];
}

@end
