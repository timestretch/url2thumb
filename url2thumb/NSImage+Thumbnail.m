//
//  NSImage+Thumbnail.m
//  url2thumb
//
//  Created by Erik Wrenholt on 12/19/12.
//  Copyright (c) 2012 Timestretch Software. All rights reserved.
//

#import "NSImage+Thumbnail.h"

@implementation NSImage (Thumbnail)

//-------------------------------------------------------------------------
-(NSBitmapImageRep*)bitmap
{
	[self lockFocus];
	NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0, 0, self.size.width, self.size.height)];
	[self unlockFocus];
	return bitmap;
}
//-------------------------------------------------------------------------
-(NSImage*)resizeToWidth:(NSInteger)outputWidth
{
	NSInteger outputHeight = round((self.size.height/(float)self.size.width) * outputWidth);
	NSImage *resultImage = [[NSImage alloc] initWithSize:NSMakeSize(outputWidth, outputHeight)];
	[resultImage lockFocus];
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
	[[self bitmap] drawInRect:NSMakeRect(0.0, 0.0, outputWidth, outputHeight)];
	[resultImage unlockFocus];
	return [resultImage autorelease];
}
//-------------------------------------------------------------------------
-(NSImage*)resizeToWidth:(NSInteger)outputWidth
		thenCropToHeight:(NSInteger)outputHeight
{
	NSImage *sourceImage = [self resizeToWidth:outputWidth];
	NSImage *resultImage = [[NSImage alloc] initWithSize:NSMakeSize(outputWidth, outputHeight)];
	
	[resultImage lockFocus];
	[[sourceImage bitmap] drawAtPoint:NSMakePoint(0.0, outputHeight - sourceImage.size.height)];
	[resultImage unlockFocus];
	return [resultImage autorelease];
}

//-------------------------------------------------------------------------
-(NSData*)pngData
{
	return [[self bitmap] representationUsingType:NSPNGFileType properties:nil];
}
//-------------------------------------------------------------------------
// 
-(NSData*)jpegData:(float)quality
{	
	return [[self bitmap] representationUsingType:NSJPEGFileType  properties:@{NSImageCompressionFactor: [NSNumber numberWithFloat:quality]}];
}

@end
