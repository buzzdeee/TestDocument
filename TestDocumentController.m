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

#import "TestDocumentController.h"
#import "TestWindowController.h"
#import "TestWindow2Controller.h"
#import "Doctype1Document.h"
#import "Doctype2Document.h"

@implementation TestDocumentController

+ (TestDocumentController *)sharedDocumentController
{
  static TestDocumentController *sharedInstance = nil;
  static NSObject *syncObject = nil; // A synchronization object
    
  // Initialize the synchronization object if needed
  if (syncObject == nil)
    {
      syncObject = [[NSObject alloc] init];
    }
    
    @synchronized(syncObject)
      {
        if (sharedInstance == nil)
          {
            // Obtain the current shared instance from the superclass
            sharedInstance = (TestDocumentController *)[super sharedDocumentController];
            
            // If the current instance is not our custom class, swizzle the class
            // HOWEVER: since we initialize early via CustomInitializer, it shall never happen
            // that we see the 'had to isa-swizzle' output
            if (![sharedInstance isKindOfClass:[TestDocumentController class]])
              {
                object_setClass(sharedInstance, [TestDocumentController class]);
                
                // Perform your initialization after the swizzling
                [sharedInstance performCustomInitialization];
                NSLog(@"TestDocumentController: sharedDocumentController: had to isa-swizzle...");
              }
            else
              {
                NSLog(@"TestDocumentController: sharedDocumentController: no need to isa-swizzle...");
                [sharedInstance performCustomInitialization];
              }
          }
      }

    NSLog(@"TestDocumentController sharedDocumentController: Current Document Controller: %@", sharedInstance);
    return sharedInstance;
}

- (void)performCustomInitialization
{
  // Initialize the map with document type to window controller class mappings
  NSLog(@"TestDocumentController performCustomInitialization: setting up _documentTypeToWindowControllerMap!!!");
  _documentTypeToWindowControllerMap = @{
      @"DocType1": [TestWindowController class],
      @"DocType2": [TestWindow2Controller class]
  };
  // Initialize the map with document type to model map
  _documentTypeToModelMap = @{
      @"DocType1": [Doctype1Document class],
      @"DocType2": [Doctype2Document class]
  };
}

- (Class)windowControllerClassForDocumentType:(NSString *)typeName
{
  NSLog(@"TestDocumentController: windowControllerClassForDocumentType %@", typeName);
  return self.documentTypeToWindowControllerMap[typeName];
}

- (Class)documentClassForType:(NSString *)typeName
{
  // Return the appropriate document class based on the document type
  NSLog(@"TestDocumentController: documentClassForType %@", typeName);
  return self.documentTypeToModelMap[typeName];  
}


- (void)newDocument:(id)sender
{
  NSLog(@"TestDocumentController newDocument: was called");
  Class documentControllerClass;
  Class windowControllerClass;
  NSString *windowNibName;
    
  // Obtain the document class    
  if ([sender tag] == 0)
    {
      NSLog(@"TestDocumentController newDocument: sender tag was 0");
      documentControllerClass = [self documentClassForType:@"DocType1"];
      NSLog(@"TestDocumentController, newDocument: documentControllerClass: %@", documentControllerClass);
      windowControllerClass = [self windowControllerClassForDocumentType:@"DocType1"];        
      windowNibName = @"Doctype1Document";
    }
  else
    {
      NSLog(@"TestDocumentController newDocument: sender tag was 1");      
      documentControllerClass = [self documentClassForType:@"DocType2"];
      windowControllerClass = [self windowControllerClassForDocumentType:@"DocType2"];        
      windowNibName = @"Doctype2Document";        
    }
  NSLog(@"TestDocumentController, newDocument: documentControllerClass: %@", documentControllerClass);      
  if (documentControllerClass)
    {
      // Create a new document instance, we assign subclasses
        
      NSLog(@"TestDocumentController newDocument: I have a documentControllerClass %@", documentControllerClass);
      NSLog(@"TestDocumentController newDocument: I have a windowControllerClass %@", windowControllerClass);        
        
      NSDocument *newDocument = [[documentControllerClass alloc] init];
        
      // Create and configure the window controller, actually subclasses as well
      NSWindowController *windowController = [[windowControllerClass alloc] initWithWindowNibName:windowNibName];
        
      // Add the window controller to the document
      [newDocument addWindowController:windowController];
        
      // Show the window
      [windowController.window makeKeyAndOrderFront:self];
        
      // Add the new document to the document controller
      [self addDocument:newDocument];
    }
  else
    {
      NSLog(@"Error: No document class found for type.");
    }
}
@end
