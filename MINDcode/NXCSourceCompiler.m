//
//  NXCSourceCompiler.m
//  MINDcode
//
//  Created by Jeff Sawatzky on 2013-01-14.
//  Copyright (c) 2013 Jeff Sawatzky. All rights reserved.
//

#import "NXCSourceCompiler.h"
#import "SourceCompiler+Protected.h"

@interface NXCSourceCompiler()

@end


@implementation NXCSourceCompiler

- (BOOL) compile {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if ([super compile]) {
        //do actual compile
        NSURL *nbcExecutableURL = [[[[NSBundle mainBundle] executableURL] URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"nbc"];
        NSURL *frameworksURL = [[NSBundle mainBundle] privateFrameworksURL];
        
        NSURL *inputFileURL = [self.sourceDocument fileURL];
        self.destinationURL = [[inputFileURL URLByDeletingPathExtension] URLByAppendingPathExtension:@"rxe"];
        NSArray *args = [NSArray arrayWithObjects:@"-Z2",[NSString stringWithFormat: @"-O=%@",[self.destinationURL path]],[NSString stringWithFormat: @"%@",[inputFileURL path]],nil];
        
        NSPipe *pipe = [[NSPipe alloc] init];
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:[nbcExecutableURL path]];
        [task setArguments:args];
        [task setEnvironment:[NSDictionary dictionaryWithObject:[frameworksURL path] forKey:@"DYLD_FALLBACK_FRAMEWORK_PATH"]];
        [task setStandardOutput:pipe];
        [task setStandardError:pipe];
        
        NSLog(@"running %@ with %@", nbcExecutableURL, args);
        NSLog(@"with env %@", task.environment);
        [task launch];
        
        NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
        NSString *standardOutput = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (self.delegate) {
            [self.delegate sourceCompiler:self didReceiveOutput:standardOutput];
        }
        
        [task waitUntilExit];
        
        if (NSTaskTerminationReasonExit == [task terminationReason] && 0 == [task terminationStatus]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

@end