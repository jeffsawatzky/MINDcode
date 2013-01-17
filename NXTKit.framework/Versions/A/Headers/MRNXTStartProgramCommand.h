//
//  MRNXTStartProgramCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTStartProgramCommand : MRNXTCommand {
@private
    NSString *filename;
}

@property (copy) NSString *filename;

@end