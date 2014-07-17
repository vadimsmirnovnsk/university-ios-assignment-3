//
//  MemoryPayload.m
//  Factory
//

#import "MemoryPayload.h"

@interface MemoryPayload ()
{
    UInt8 *memoryLoad_;
}

@end

@implementation MemoryPayload

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        const NSUInteger memoryLoadSize = 10000000;
        memoryLoad_ = (UInt8 *)malloc(sizeof(UInt8) * memoryLoadSize);
        if (memoryLoad_ != NULL) {
            for (NSUInteger i = 0; i < memoryLoadSize; i++) {
                memoryLoad_[i] = UINT8_MAX;
            }
        }
    }

    return self;
}

#pragma mark - Deallocation

- (void)dealloc
{
    free(memoryLoad_);
    memoryLoad_ = NULL;

    [super dealloc];
}

@end
