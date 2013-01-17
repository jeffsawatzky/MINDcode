//
//  ProgressWindowController.m
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "ProgressWindowController+Protected.h"

@interface ProgressWindowController ()

@end


@implementation ProgressWindowController

- (id)init {
    self = [super initWithWindowNibName:@"ProgressWindowController"];
    
    if (self) {
    }
    
	return self;
}

- (void)presentAsSheetInWindow:(NSWindow *)parentWindow {
    NSLog(@"%s", __PRETTY_FUNCTION__);
	NSWindow * window = [self window];
    NSLog(@"%@", window);
    
    [NSApp beginSheet: window
       modalForWindow: parentWindow
        modalDelegate: self
       didEndSelector: @selector(didEndSheet:returnCode:contextInfo:)
          contextInfo: nil];
}

- (void)dismissSheet {
    NSLog(@"%s", __PRETTY_FUNCTION__);
	NSWindow * window = [self window];
    NSLog(@"%@", window);
    
	[NSApp endSheet:window];
}

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [sheet orderOut:self];
}

@end