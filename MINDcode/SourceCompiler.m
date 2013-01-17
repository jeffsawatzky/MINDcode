//
//  SourceCompiler.m
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "SourceCompiler+Protected.h"

@interface SourceCompiler()

@end


@implementation SourceCompiler

- (id) initWithSourceDocument:(SourceDocument *)sourceDocument {
    self = [self init];
    
    if (self) {
        self.sourceDocument = sourceDocument;
    }
    
    return self;
}

- (void) setDestinationURL:(NSURL *)destinationURL {
    _destinationURL = destinationURL;
}

- (BOOL) compile {
    return YES;
}

@end