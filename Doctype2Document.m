/*
   Project: TestDocument

   Copyright (C) 2024 Free Software Foundation

   Author: Sebastian Reitenbach

   Created: 2024-09-03 19:53:44 +0200 by sebastia

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

#import "Doctype2Document.h"

@implementation Doctype2Document

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialize your document here
        NSLog(@"Initializing Doctype2Document");
    }
    return self;
}

- (NSString *)windowNibName {
    // Return the name of the .gorm file that defines the document's UI
    return @"Doctype2Document";
}


- (void)makeWindowControllers {
//    TestWindowController *controller = [[TestWindowController alloc] initWithWindowNibName:@"Doctype1Document"];
    //    TestWindowController *controller = [[TestWindowController alloc] init];

  //  [self addWindowController:controller];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Serialize your document data into NSData for saving
    return [NSData data];  // Replace with actual serialization code
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    // Deserialize your document data from NSData
    return YES;  // Replace with actual deserialization code
}

@end
