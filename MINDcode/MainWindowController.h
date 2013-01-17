//
//  MainWindowController.h
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SourceDocument.h"

@interface MainWindowController : NSWindowController

- (id)initWithWindowNibName:(NSString *)windowNibName andSourceDocument:(SourceDocument *)sourceDocument;

@end