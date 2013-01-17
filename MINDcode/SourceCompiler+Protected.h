//
//  SourceCompiler+Protected.h
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-16.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "SourceCompiler.h"

@interface SourceCompiler ()

@property (nonatomic, unsafe_unretained) SourceDocument *sourceDocument;

- (void) setDestinationURL:(NSURL *)destinationURL;

@end