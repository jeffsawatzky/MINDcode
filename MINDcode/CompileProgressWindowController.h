//
//  CompilingProgressWindowController.h
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-17.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "ProgressWindowController.h"
#import "SourceDocument.h"
#import "SourceCompiler.h"

@protocol CompileProgressWindowControllerDelegate;


@interface CompileProgressWindowController : ProgressWindowController <SourceCompilerDelegate>

@property (nonatomic, unsafe_unretained) id<CompileProgressWindowControllerDelegate> delegate;

- (id)initWithDocument:(SourceDocument *)document;

@end


@protocol CompileProgressWindowControllerDelegate

- (void) compileProgressWindowController:(CompileProgressWindowController *)controller didReceiveOutput:(NSString *)output;
- (void) compileProgressWindowController:(CompileProgressWindowController *)controller didFinishCompilingFile:(NSURL *)destinationURL withSuccess:(BOOL)success;

@end