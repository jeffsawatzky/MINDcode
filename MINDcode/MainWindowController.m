//
//  MainWindowController.m
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "MainWindowController.h"
#import "MainViewController.h"

@interface MainWindowController ()

@property (nonatomic, strong) IBOutlet MainViewController *mainViewController;
@property (nonatomic, strong) SourceDocument *sourceDocument;

@end


@implementation MainWindowController

-(id)initWithWindowNibName:(NSString *)windowNibName andSourceDocument:(SourceDocument *)sourceDocument {
    self = [super initWithWindowNibName:windowNibName];
    if (self) {
        // Initialization code here.
        self.sourceDocument = sourceDocument;
    }
    
    return self;
}

- (void)windowDidLoad {    
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    self.mainViewController.sourceDocument = self.sourceDocument;
    [self.mainViewController.view setAutoresizingMask:(NSViewWidthSizable|NSViewHeightSizable)];
    [self.mainViewController.view setFrame:[self.window.contentView bounds]];
    [self.window.contentView addSubview:self.mainViewController.view];
}

@end