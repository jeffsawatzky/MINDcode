//
//  Document.m
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "NXCSourceDocument.h"
#import "NXCSourceCompiler.h"

@interface NXCSourceDocument()

@end


@implementation NXCSourceDocument

- (SourceCompiler *) createSourceCompiler {
    return [[NXCSourceCompiler alloc] initWithSourceDocument:self];
}

+ (BOOL)autosavesInPlace {
    return YES;
}

@end