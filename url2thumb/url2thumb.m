//
//  url2thumb.m
//  url2thumb
//
//  Created by Erik Wrenholt on 09/09/06.
//  Copyright (c) 2012 Timestretch Software. All rights reserved.
//

#import "url2thumb.h"

@implementation Url2Thumb
@synthesize webView = _webView;

//-------------------------------------------------------------------------
// Accepts an initial view width and height. The web page uses this width and height for
// initial rendering. The view will be resized to fit the full size of the web page.
//
// The output of this method is always a full-height image.
-(NSImage*)imageForURL:(NSString*)inURL viewWidth:(long)pageWidth viewHeight:(long)pageHeight
{
	self.viewLoaded = NO;
	
	NSRect bounds = NSMakeRect(0.0, 0.0, pageWidth, pageHeight);
	self.webView = [[WebView alloc] initWithFrame:bounds frameName:nil groupName:nil];
	
	// Register for notification when page is done loading
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webPageFinishedLoading:) name:WebViewProgressFinishedNotification object:nil];
	
	// Hide scrollbars if possible.	 Sometimes they show up on sites that use frames
	[[[self.webView mainFrame] frameView] setAllowsScrolling:NO];
	[[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:inURL]]];
	
	// After loading the request, wait for the web page to finish loading.
	// Once it's done, the viewLoaded flag will be set to YES.
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	while (!self.viewLoaded) {
		[runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.03]];
	}

	// Get the full size of the web page scroll view, resize height to fit.
	WebFrameView *frameView = [[self.webView mainFrame] frameView];
	NSRect bitmapRect = [[frameView documentView] frame];
	[self.webView setFrame:bitmapRect];
	
	// Create an image of the webpage.
	NSBitmapImageRep *bitmap = (NSBitmapImageRep*)[self.webView bitmapImageRepForCachingDisplayInRect:bitmapRect];
	
	[self.webView cacheDisplayInRect:[self.webView bounds] toBitmapImageRep:bitmap];
	NSImage *image = [[[NSImage alloc] initWithSize:bitmapRect.size] autorelease];
	
	[image addRepresentation:bitmap];
	return image;
}
//-------------------------------------------------------------------------
- (void)webPageFinishedLoading:(NSNotification *)inNotification
{
	self.viewLoaded = YES;
	[[NSNotificationCenter defaultCenter] removeObserver:self name:WebViewProgressFinishedNotification object:nil];
}
//-------------------------------------------------------------------------
-(void)dealloc
{
	self.webView = nil;
	[super dealloc];
}
//-------------------------------------------------------------------------
@end
