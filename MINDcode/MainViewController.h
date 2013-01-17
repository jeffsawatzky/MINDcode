//
//  MainViewController.h
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SourceDocument.h"
#import "SourceCompiler.h"
#import "CompileProgressWindowController.h"
#import "UploadProgressWindowController.h"

@interface MainViewController : NSViewController <CompileProgressWindowControllerDelegate, UploadProgressWindowControllerDelegate>

@property (nonatomic, unsafe_unretained) SourceDocument *sourceDocument;

@end