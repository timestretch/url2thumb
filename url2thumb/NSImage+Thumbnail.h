//
//  NSImage+Thumbnail.h
//  url2thumb
//
//  Created by Erik Wrenholt on 12/19/12.
//  Copyright (c) 2012 Timestretch Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface NSImage (Thumbnail)

-(NSImage*)resizeToWidth:(NSInteger)width;
-(NSImage*)resizeToWidth:(NSInteger)width
		thenCropToHeight:(NSInteger)height;

-(NSData*)pngData;
-(NSData*)jpegData:(float)quality;

@end
