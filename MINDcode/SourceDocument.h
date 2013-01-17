//
//  SourceDocument.h
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SourceCompiler;


@interface SourceDocument : NSDocument

@property (nonatomic, strong) NSString *content;

- (SourceCompiler *) createSourceCompiler;

@end