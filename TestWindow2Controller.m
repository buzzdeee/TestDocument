/*
   Project: TestDocument

   Copyright (C) 2024 Free Software Foundation

   Author: Sebastian Reitenbach

   Created: 2024-09-03 20:24:49 +0200 by sebastia

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

#import "TestWindow2Controller.h"
#import "Doctype2.h"

@implementation TestWindow2Controller

// don't do anything here
// we don't want the window loaded on application start
- (TestWindow2Controller *)init
{
  return self;
}

- (TestWindow2Controller *)initWithWindowNibName:(NSString *)nibNameOrNil
{
  self = [super initWithWindowNibName:nibNameOrNil];
  if (self)
    {
      NSLog(@"TestWindow2Controller initWithWindowNibName: %@", nibNameOrNil);
      _documentModel = [[Doctype2 alloc] init];
    }
  else
    {
      NSLog(@"TestWindow2Controller had trouble initializing");
    }
  return self;
}

- (void)windowDidLoad
{
  [super windowDidLoad];
  // Perform additional setup after loading the window
  NSLog(@"TestWindow2Controller: windowDidLoad: successfully from .gorm file: %@", self.window);
}


@end
