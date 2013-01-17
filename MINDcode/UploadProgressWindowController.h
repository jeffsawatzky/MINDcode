//
//  UploadProgressWindowController.h
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "ProgressWindowController.h"

@protocol UploadProgressWindowControllerDelegate;


@interface UploadProgressWindowController : ProgressWindowController

@property (nonatomic, unsafe_unretained) id<UploadProgressWindowControllerDelegate> delegate;

- (id)initWithSourceURL:(NSURL *)url device:(MRNXTDevice *)device;

@end


@protocol UploadProgressWindowControllerDelegate

- (void) uploadProgressWindowController:(UploadProgressWindowController *)controller didFinishUploadingFile:(NSString *)fileName withSuccess:(BOOL)success;

@end