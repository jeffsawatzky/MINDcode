//
//  SourceCompiler.h
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SourceDocument.h"

@protocol SourceCompilerDelegate;


@interface SourceCompiler : NSObject

@property (nonatomic, unsafe_unretained) id<SourceCompilerDelegate> delegate;
@property (nonatomic, readonly) NSURL *destinationURL;

- (id) initWithSourceDocument:(SourceDocument *)sourceDocument;
- (BOOL) compile;

@end


@protocol SourceCompilerDelegate

- (void) sourceCompiler:(SourceCompiler *)sourceCompiler didReceiveOutput:(NSString *)output;

@end