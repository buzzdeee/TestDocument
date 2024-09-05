/*
   Project: TestDocument

   Copyright (C) 2024 Free Software Foundation

   Author: Sebastian Reitenbach

   Created: 2024-09-02 21:42:12 +0200 by sebastia

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

#import <objc/runtime.h>

// #import <dispatch/dispatch.h>
#import "TestDocumentController.h"
#import "TestWindowController.h"
#import "TestWindow2Controller.h"
#import "Doctype1Document.h"
#import "Doctype2Document.h"

@implementation TestDocumentController

+ (TestDocumentController *)sharedDocumentController {
    static TestDocumentController *sharedInstance = nil;
    static NSObject *syncObject = nil; // A synchronization object
    
    // Initialize the synchronization object if needed
    if (syncObject == nil) {
        syncObject = [[NSObject alloc] init];
    }
    
    @synchronized(syncObject) {
        if (sharedInstance == nil) {
            // Obtain the current shared instance from the superclass
            sharedInstance = (TestDocumentController *)[super sharedDocumentController];
            
            // If the current instance is not our custom class, swizzle the class
            if (![sharedInstance isKindOfClass:[TestDocumentController class]]) {
                object_setClass(sharedInstance, [TestDocumentController class]);
                
                // Perform your initialization after the swizzling
                [sharedInstance performCustomInitialization];
            }
        }
    }

    NSLog(@"TestDocumentController sharedDocumentController: Current Document Controller: %@", sharedInstance);
    return sharedInstance;
}

// links against -ldispatch, don't want to do that...
/*
+ (TestDocumentController *)sharedDocumentController {
    static TestDocumentController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Without isa swizzling
        //sharedInstance = [[self alloc] init];
        
        // isa-swizzle....
        // Get the current shared instance
        sharedInstance = (TestDocumentController *)[super sharedDocumentController];      
        // If the current instance is not our custom class, swizzle the class
        if (![sharedInstance isKindOfClass:[TestDocumentController class]]) {
            object_setClass(sharedInstance, [TestDocumentController class]);
          
            // Perform your initialization after the swizzling
            [sharedInstance performCustomInitialization];              
        }          
    });

    NSLog(@"TestDocumentController  sharedDocumentController: Current Document Controller: %@", sharedInstance);    
    return sharedInstance;
}
*/


- (void)performCustomInitialization {
        // Initialize the map with document type to window controller class mappings
        NSLog(@"TestDocumentController init, setting up _documentTypeToWindowControllerMap!!!");
        _documentTypeToWindowControllerMap = @{
            @"DocType1": [TestWindowController class],
            @"DocType2": [TestWindow2Controller class]
        };
        _documentTypeToDocumentMap = @{
            @"DocType1": [Doctype1Document class],
            @"DocType2": [Doctype1Document class]
        };        

}

- (Class)windowControllerClassForDocumentType:(NSString *)typeName {
    NSLog(@"TestDocumentController: windowControllerClassForDocumentType %@", typeName);
    return self.documentTypeToWindowControllerMap[typeName];
}

- (Class)documentClassForType:(NSString *)typeName {
    // Return the appropriate document class based on the document type
    NSLog(@"TestDocumentController: documentClassForType %@", typeName);
    return self.documentTypeToDocumentMap[typeName];  
}


- (void)newDocument:(id)sender {
    NSLog(@"TestDocumentController newDocument: was called");
    Class documentControllerClass;
    Class windowControllerClass;
    NSString *windowNibName;
    
    // Obtain the document class    
    if ([sender tag] == 0)
      {
        NSLog(@"TestDocument newDocument: sender tag was 0");
        documentControllerClass = [self documentClassForType:@"DocType1"];
        NSLog(@"TestDocument, newDocument: documentControllerClass: %@", documentControllerClass);
        windowControllerClass = [self windowControllerClassForDocumentType:@"DocType1"];        
        windowNibName = @"Doctype1Document";
      }
    else
      {
        NSLog(@"TestDocument newDocument: sender tag was 1");      
        documentControllerClass = [self documentClassForType:@"DocType2"];
        windowControllerClass = [self windowControllerClassForDocumentType:@"DocType2"];        
        windowNibName = @"Doctype2Document";        
      }
    NSLog(@"TestDocument, newDocument: documentControllerClass: %@", documentControllerClass);      
    if (documentControllerClass) {
        // Create a new document instance, we assign subclasses
        
        NSLog(@"TestDocument newDocument: I have a documentControllerClass %@", documentControllerClass);
        NSLog(@"TestDocument newDocument: I have a windowControllerClass %@", windowControllerClass);        
        
        NSDocument *newDocument = [[documentControllerClass alloc] init];
        
        // Create and configure the window controller, actually subclasses as well
        NSWindowController *windowController = [[windowControllerClass alloc] initWithWindowNibName:windowNibName];
        
        // Add the window controller to the document
        [newDocument addWindowController:windowController];
        
        // Show the window
        [windowController.window makeKeyAndOrderFront:self];
        
        // Add the new document to the document controller
        [self addDocument:newDocument];
    } else {
        NSLog(@"Error: No document class found for type.");
    }
}


@end
