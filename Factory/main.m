//
//  main.m
//  Factory
//

#import "Factory.h"

int main(int argc, char * argv[])
{
    NSAutoreleasePool *const pool = [[NSAutoreleasePool alloc] init];
    {
        Factory *const factory = [[Factory alloc] init];
        [factory simulateWorkingMonth];
        [factory release];
    }
    [pool release];

    return 0;
}
