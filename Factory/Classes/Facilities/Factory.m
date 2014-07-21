//
//  Factory.m
//  Factory
//

#import "AssemblyLine.h"
#import "Factory.h"
#import "Transporter.h"
#import "RawMaterial.h"
#import "Warehouse.h"

static const NSUInteger DefaultCapacityOfFinishedProductStorage = 10;
static const NSUInteger DefaultCapacityOfRawMaterialStorage = 50;

static const NSUInteger DefaultNumberOfFreeTransporters = 8;
static const NSUInteger DefaultLimitOnShipmentVolume = 5;

@interface Factory ()

@property (nonatomic, retain) NSMutableSet *freeTransporters;
@property (nonatomic, retain) NSMutableSet *occupiedTransporters;
@property (nonatomic, retain) NSMutableSet *restingTransporters;

@property (nonatomic, retain) AssemblyLine *assemblyLine;
@property (nonatomic, retain) Warehouse *finishedProductStorage;
@property (nonatomic, retain) Warehouse *rawMaterialStorage;

- (void)simulateWorkingWeek;

- (void)simulateWorkingDay;

@end

@implementation Factory

@synthesize freeTransporters = freeTransporters_;
@synthesize occupiedTransporters = occupiedTransporters_;
@synthesize restingTransporters = restingTransporters_;

@synthesize assemblyLine = assemblyLine_;
@synthesize finishedProductStorage = finishedProductStorage_;
@synthesize rawMaterialStorage = rawMaterialStorage_;

#pragma mark - Getters

- (NSMutableSet *)occupiedTransporters
{
    if (!occupiedTransporters_) {
        occupiedTransporters_ = [NSMutableSet set];
    }

    return occupiedTransporters_;
}

- (NSMutableSet *)restingTransporters
{
    if (!restingTransporters_) {
        restingTransporters_ = [NSMutableSet set];
    }

    return restingTransporters_;
}

- (AssemblyLine *)assemblyLine
{
    if (!assemblyLine_) {
        assemblyLine_ = [[AssemblyLine alloc] init];
        assemblyLine_.latitude = .0f;
        assemblyLine_.longitude = -1.f;
    }

    return assemblyLine_;
}

#pragma mark - Setters

- (void)setFreeTransporters:(NSMutableSet *)freeTransporters
{
    freeTransporters_ = freeTransporters;
}

- (void)setFinishedProductStorage:(Warehouse *)finishedProductStorage
{
    finishedProductStorage_ = finishedProductStorage;
}

- (void)setRawMaterialStorage:(Warehouse *)rawMaterialStorage
{
    rawMaterialStorage_ = rawMaterialStorage;
}

#pragma mark - Initialization

- (id)init
{
    if ((self = [super init])) {
        freeTransporters_ = [NSMutableSet set];

        NSInteger counter = DefaultNumberOfFreeTransporters;
        while (--counter >= 0) {
            Transporter *const transporter = [[Transporter alloc] init];
            transporter.name = [NSString stringWithFormat:@"Name %li", (long)counter];
            transporter.surname = [NSString stringWithFormat:@"Surname %li", (long)counter];
            [transporter moveToLocation:self];
            [freeTransporters_ addObject:transporter];
        } // while

        finishedProductStorage_ = [[Warehouse alloc] init];
        finishedProductStorage_.latitude = -1.f;
        finishedProductStorage_.longitude = -1.f;
        finishedProductStorage_.capacity = DefaultCapacityOfFinishedProductStorage;

        rawMaterialStorage_ = [[Warehouse alloc] init];
        rawMaterialStorage_.latitude = -1.f;
        rawMaterialStorage_.longitude = 1.f;
        rawMaterialStorage_.capacity = DefaultCapacityOfRawMaterialStorage;

        while (![rawMaterialStorage_ isFull]) {
            [rawMaterialStorage_ putWare:[[RawMaterial alloc] init]];
        } // while
    } // if

    return self;
}

#pragma mark - Deallocation

- (void)dealloc
{

}

#pragma mark - Production

- (void)simulateWorkingMonth
{
    NSLog(@"A brand new month starts.\n\n");

    for (NSUInteger index = 0; index < 5; ++index) {
        [self simulateWorkingWeek];
    }

    NSLog(@"The month is over.\n\n");
}

- (void)simulateWorkingWeek
{
    NSLog(@"A brand new week starts.\n\n");

    for (NSUInteger index = 0; index < 5; ++index) {
        [self simulateWorkingDay];
    }

    NSInteger counter = DefaultNumberOfFreeTransporters - [self.freeTransporters count];
    while (--counter >= 0) {
        /**
         *  @remarks    The factory has decided to hire some transporters.
         */
        Transporter *const transporter = [[Transporter alloc] init];
        transporter.name = [NSString stringWithFormat:@"Name %li", (long)(counter + (arc4random() % 1000) + 1)];
        transporter.surname = [NSString stringWithFormat:@"Surname %li", (long)(counter  + (arc4random() % 1000) + 1)];
        [transporter moveToLocation:self];
        [self.freeTransporters addObject:transporter];
    }

    NSLog(@"The week is over.\n\n");
}

- (void)simulateWorkingDay
{
    NSLog(@"A brand new day starts.\n\n");

    NSError *error = nil;
    for (NSUInteger index = 0; index < 8; ++index) {
        @autoreleasepool
        {
        
            if ([self.freeTransporters count]) {
                if (arc4random() % 7 == 0) {
                    
                     // @remarks    One of the transporters has decided to retire.
                    [self.freeTransporters removeObject:[self.freeTransporters anyObject]];
                }
            }

            if ([self.restingTransporters count]) {
                if (arc4random() % 3 == 0) {
                  
                     // @remarks    One of the resting transporters is ready to get back to work.
                    
                    Transporter *const transporter = [self.restingTransporters anyObject];
                    [transporter moveToLocation:self];

                    [self.freeTransporters addObject:transporter];
                    [self.restingTransporters removeObject:transporter];
                }
            }

            Transporter *const transporter = [self.freeTransporters anyObject];
            if (transporter) {
                const NSUInteger shipmentVolume = 1 + (arc4random() % DefaultLimitOnShipmentVolume);
                transporter.cargo = [self.rawMaterialStorage shipWaresOfCount:shipmentVolume
                                                                        error:&error];
                if (!error) {
                    [self.occupiedTransporters addObject:transporter];
                    [self.freeTransporters removeObject:transporter];

                    [transporter moveToLocation:self.assemblyLine];

                    transporter.cargo = [self.assemblyLine processRawMaterials:transporter.cargo];
                    [transporter moveToLocation:self.finishedProductStorage];

                    if ([self.finishedProductStorage isFull]) {
                         // @remarks    The warehouse is full, it's high time to sell its wares.
                        [self.finishedProductStorage shipWaresOfCount:[self.finishedProductStorage capacity]
                                                                error:nil];
                    }
                    [self.finishedProductStorage putWare:transporter.cargo];
                    transporter.cargo = nil;

                    [self.restingTransporters addObject:transporter];
                    [self.occupiedTransporters removeObject:transporter];
                }
                else {
                    // @remarks    There is not enough raw meterials,
                    //             let's buy some.
                    while (![rawMaterialStorage_ isFull]) {
                        [rawMaterialStorage_ putWare:[[RawMaterial alloc] init]];
                    }
                    // [error release]; We shouldn't release autorelizing object
                    // error = nil;
                }
            }
        }

        NSLog(@"%li working hour.", (long)(index + 1));
    }

    [self.freeTransporters addObjectsFromArray:[self.restingTransporters allObjects]];
    [self.restingTransporters removeAllObjects];

    NSLog(@"\n\n");
    NSLog(@"The day is over.\n\n");
}

#pragma mark - LocationProtocol implementation

- (float)latitude
{
    return .0f;
}

- (float)longitude
{
    return .0f;
}

@end
