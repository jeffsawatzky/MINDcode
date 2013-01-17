//
//  ProgressWndowController+Protected.h
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-16.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "ProgressWindowController.h"

@interface ProgressWindowController ()

@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *promptTextField;
@property (nonatomic, unsafe_unretained) IBOutlet NSProgressIndicator *progressIndictor;

- (void)dismissSheet;
- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;

@end
