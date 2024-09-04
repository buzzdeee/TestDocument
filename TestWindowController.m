/*
   Project: TestDocument

   Copyright (C) 2024 Free Software Foundation

   Author: Sebastian Reitenbach

   Created: 2024-09-02 21:42:59 +0200 by sebastia

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

#import "TestWindowController.h"
#import "Doctype1.h"

@implementation TestWindowController

// don't do anything here
// we don't want the window loaded on application start
- (TestWindowController *)init {

    return self;
}

- (TestWindowController *)initWithWindowNibName:(NSString *)nibNameOrNil {
    self = [super initWithWindowNibName:nibNameOrNil];
    if (self) {
        NSLog(@"TestWindowController initialized with nib: %@", nibNameOrNil);
        _documentModel = [[Doctype1 alloc] init];
    } else {
        NSLog(@"TestWindowController had trouble initializing");
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    // Perform additional setup after loading the window
    NSLog(@"TestWindowController: Window loaded successfully from .gorm file: %@", self.window);
}


// action methods to update the model
- (IBAction)updateTextFieldAge:(id)sender {
    NSString *newAge = [sender stringValue]; // Assuming sender is a NSTextField
    [self.documentModel updateAge:newAge];
    NSLog(@"Updated age to: %@", self.documentModel.age);
    [self.document updateChangeCount:NSChangeDone];    
}

- (IBAction)updateTextFieldName:(id)sender {
    NSString *newName = [sender stringValue]; // Assuming sender is a NSTextField
    [self.documentModel updateName:newName];
    NSLog(@"Updated name to: %@", self.documentModel.name);
    [self.document updateChangeCount:NSChangeDone];    
}

@end
