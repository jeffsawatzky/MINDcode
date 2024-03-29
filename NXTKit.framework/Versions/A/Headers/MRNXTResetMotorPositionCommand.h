//
//  MRNXTResetMotorPositionCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"
#import "MRNXTConstants.h"

@interface MRNXTResetMotorPositionCommand : MRNXTCommand {
@private
    NXTOutputPort port;
    BOOL relative;
}

@property (assign) NXTOutputPort port;
@property (assign) BOOL relative;

@end
