//
//  SourceDocument.m
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "SourceDocument.h"
#import "SourceCompiler.h"
#import "MainWindowController.h"

@interface SourceDocument()

@end


@implementation SourceDocument

- (void)makeWindowControllers {
    [self addWindowController:[[MainWindowController alloc] initWithWindowNibName:@"MainWindowController" andSourceDocument:self]];
}

- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError {
    NSError *error = nil;
    [self.content writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (nil == error) {
        return YES;
    } else {
        if (NULL != outError) {
            *outError = error;
        }
        return NO;
    }
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError {
    NSError *error = nil;
    self.content = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (nil == error) {
        return YES;
    } else {
        if (NULL != outError) {
            *outError = error;
        }
        return NO;
    }
}

- (SourceCompiler *) createSourceCompiler {
    return [[SourceCompiler alloc] initWithSourceDocument:self];
}

@end