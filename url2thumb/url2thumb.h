//
//  url2thumb.h
//  url2thumb
//
//  Created by Erik Wrenholt on 09/09/06.
//  Copyright (c) 2012 Timestretch Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface Url2Thumb : NSObject
{
	WebView *_webView;
}

@property (readwrite, retain) WebView *webView;
@property (readwrite, assign) BOOL viewLoaded;

// Returns a full size image, based on an initial view size.
// The image returned may be thousands of pixels tall.
// Often you can get the iPhone version of a web site, with a viewWidth of 320 or 480.

-(NSImage*)imageForURL:(NSString*)inURL
			 viewWidth:(long)inPageWidth
			viewHeight:(long)inPageHeight;

@end
