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
#import "Doctype1Document.h"

@implementation TestWindowController

// Not needed, just properly connect in .gorm file the outlets ;)
//@synthesize textFieldName = _textFieldName;
//@synthesize textFieldAge = _textFieldAge;

// don't do anything here
// we don't want the window loaded on application start
- (TestWindowController *)init {

    return self;
}

- (void)dealloc {
    // Clean up KVO observer
    Doctype1Document *document = (Doctype1Document *)self.document;
    [document.model removeObserver:self forKeyPath:@"name"];
    [document.model removeObserver:self forKeyPath:@"age"];    
}

- (TestWindowController *)initWithWindowNibName:(NSString *)nibNameOrNil {
    self = [super initWithWindowNibName:nibNameOrNil];
    if (self) {
        NSLog(@"TestWindowController initialized with nib: %@", nibNameOrNil);
        // Not needed anymore
        //_documentModel = [[Doctype1 alloc] init];
    } else {
        NSLog(@"TestWindowController had trouble initializing");
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    // Perform additional setup after loading the window
    
    Doctype1Document *document = (Doctype1Document *)self.document;
    [self.textFieldName bind:NSValueBinding toObject:document.model withKeyPath:@"name" options:nil];
    [self.textFieldAge bind:NSValueBinding toObject:document.model withKeyPath:@"age" options:nil];    
    
    // Optionally, register for KVO notifications if you want more control
    [document.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:NULL];
    [document.model addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];    
    
    NSLog(@"TestWindowController: Window loaded successfully from .gorm file: %@", self.window);
}


- (IBAction)updateModel:(id)sender {
    // Update the document's model when the user interacts with the UI
    NSLog(@"TestWindowController updateModel called by: %@", sender);
    Doctype1Document *document = (Doctype1Document *)self.document;
    // is this clever, or better to compare the sender against some values and have some maybe huge case
    // statement in case there are _MANY_ properties in the document?
    document.model.name = self.textFieldName.stringValue;
    document.model.age = self.textFieldAge.stringValue;
    NSLog(@"Name value: %@", self.textFieldName.stringValue);
    NSLog(@"Age value: %@", self.textFieldAge.stringValue);
    NSLog(@"Model Name after updating: %@", document.model.name);
    NSLog(@"Model Age after updating: %@", document.model.age);
    NSLog(@"TestWindowController updateModel: the document model: %@", document);
    // Mark doc as 'dirty'
    [document updateChangeCount:NSChangeDone];
}

// action methods to update the model NOT USED ANYMORE
/*
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
*/

// KVO observer method
// to make this work, it needs: https://github.com/gnustep/libs-base/pull/444
// otherwise replace NSKeyValueChangeKey with NSString*
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString*,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"age"]) {
        NSLog(@"Age changed to: %@", change[NSKeyValueChangeNewKey]);
    } else if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"Name changed to: %@", change[NSKeyValueChangeNewKey]);
    }
}

@end
