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

#ifndef _TESTWINDOW2CONTROLLER_H_
#define _TESTWINDOW2CONTROLLER_H_

#import <AppKit/AppKit.h>

@class Doctype2;

@interface TestWindow2Controller : NSWindowController
{

}

@property (nonatomic, strong) Doctype2 *documentModel;

/*
- (IBAction)updateTextFieldWidth:(id)sender;
- (IBAction)updateTextFieldHeight:(id)sender;
*/
@end

#endif // _TESTWINDOW2CONTROLLER_H_

