/*
   Project: TestDocument

   Copyright (C) 2024 Free Software Foundation

   Author: Sebastian Reitenbach

   Created: 2024-09-02 20:52:56 +0200 by sebastia

   This application is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This application is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#import "Doctype1Document.h"
#import "TestWindowController.h"
#import "Doctype1.h"

@implementation Doctype1Document

@synthesize model = _model;

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialize your document here
        NSLog(@"Initializing Doctype1Document self: %@", self);    
        // IS this sane to call here????
        _model = [[Doctype1 alloc] init];
    }
    
    return self;
}

- (NSString *)windowNibName {
    // Return the name of the .gorm file that defines the document's UI
    return @"Doctype1Document";
}


- (void)makeWindowControllers {
//    TestWindowController *controller = [[TestWindowController alloc] initWithWindowNibName:@"Doctype1Document"];
    //    TestWindowController *controller = [[TestWindowController alloc] init];

  //  [self addWindowController:controller];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Ensure the model exists
    NSLog(@"Doctype1Document dataOfType called! %@", self.model);
    NSLog(@"Doctype1Document dataOfType called! %@", self.model.age);
    NSLog(@"Doctype1Document dataOfType called! %@", self.model.name);        
    @try {
        if (!self.model) {
            if (outError) {
                *outError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                code:NSFileWriteUnknownError
                                            userInfo:@{NSLocalizedDescriptionKey: @"No data to save"}];
            }
            return nil;
        }
        
        // Archive model object to NSData
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model requiringSecureCoding:NO error:outError];
        
        if (!data && outError) {
            NSLog(@"Archiving failed with error: %@", *outError);
            return nil;
        }
        
        NSLog(@"Successfully encoded the data: %@", data);
        return data;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception caught during archiving: %@", exception);
        if (outError) {
            *outError = [NSError errorWithDomain:NSCocoaErrorDomain
                                            code:NSFileWriteUnknownError
                                        userInfo:@{NSLocalizedDescriptionKey: [exception reason]}];
        }
        return nil;
    } 
    //return [NSData data];
}

// shouldn't be necessary, was just for debugging help...
- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError {
    NSLog(@"Saving to URL: %@", url);
    return [super writeToURL:url ofType:typeName error:outError];
}




- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Unarchive the model from the data
    NSLog(@"Doctype1Document readFromData called!");
    self.model = [NSKeyedUnarchiver unarchivedObjectOfClass:[Doctype1 class] fromData:data error:outError];
    
    // If unarchiving fails, return NO and pass the error
    if (!self.model && outError) {
        return NO;
    }
 
    return YES;
}


- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError {
    NSLog(@"Doctype1Document readFromURL:ofType:error: called");
    
    // Load data from file
    //NSData *data = [NSData dataWithContentsOfURL:url options:0 error:outError];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (!data) {
        NSLog(@"Failed to read data from URL: %@", url);
        return NO;
    }
    
    // Unarchive model object from NSData
    self.model = [NSKeyedUnarchiver unarchivedObjectOfClass:[Doctype1 class] fromData:data error:outError];
    if (!self.model) {
        NSLog(@"Failed to unarchive model");
        return NO;
    }
    
    // Notify that the document has been successfully loaded
    [self updateChangeCount:NSChangeCleared];
    
    // Force initialization of the UI if lazy loading is used
    TestWindowController *windowController = [[TestWindowController alloc] initWithWindowNibName:@"Doctype1Document"];
    [self addWindowController:windowController];
    [windowController showWindow:self];
    
    return YES;
}
@end
