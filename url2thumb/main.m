//
//  main.m
//  url2thumb
//
//  Created by Erik Wrenholt on 09/09/06.
//  Copyright (c) 2012 Timestretch Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

#import "url2thumb.h"
#import "NSImage+Thumbnail.h"

void print_help()
{
	printf("By Erik Wrenholt 2006-2015. http://www.timestretch.com/\n");
	printf("Specify either png or jpg suffix for output file.\n");
	printf("Defaults for view size shown below.\n");
	printf("If the output size is omitted, a full sized image will be captured.\n");
	printf("Output height is optional when combined with width.\n");
	printf("Quality is used for JPEG export.\n");
	printf("\n\n");
	printf("./url2thumb -url \"http://www.timestretch.com/\" \\\n");
	printf("            -o \"timestretch.jpg\" \\\n");
	printf("            -viewWidth 1024 \\\n");
	printf("            -viewHeight 768 \\\n");
	printf("            -outputWidth 150 \\\n");
	printf("            -outputHeight 100 \\\n");
	printf("            -transparentWebView 0 \\\n");
	printf("            -quality 0.75\n");
}

int main(int argc, const char * argv[])
{

	@autoreleasepool {
		
		if (argc <= 2)
		{
			print_help();
			exit(0);
		}

		NSUserDefaults *args = [NSUserDefaults standardUserDefaults];

		NSString *url = [args stringForKey:@"url"];
		NSString *outputFilename = [args stringForKey:@"o"];
		
		NSInteger viewWidth = [args integerForKey:@"viewWidth"];
		NSInteger viewHeight = [args integerForKey:@"viewHeight"];

		NSInteger outputWidth = [args integerForKey:@"outputWidth"];
		NSInteger outputHeight = [args integerForKey:@"outputHeight"];
		
		NSInteger transparentWebView = [args integerForKey:@"transparentWebView"];
		
		float quality = [args floatForKey:@"quality"];
		
		
		if (viewWidth <= 0)
			viewWidth = 1024;
		
		if (viewHeight <= 0)
			viewHeight = 768;
		
		if (quality <= 0)
			quality = 0.75;

		if (quality > 1.0)
		{
			printf("Warning: quality should be between 0.0 and 1.0\n\n");
			quality = 1.0;
		}
		
		if (!([url hasPrefix:@"http"] || [url hasPrefix:@"file"]))
		{
			printf("Error: The URL needs to start with 'http' or 'file'.\n\n");
			print_help();
			exit(0);
		}
		
		if (![[outputFilename lowercaseString] hasSuffix:@".jpg"]
			&& ![[outputFilename lowercaseString] hasSuffix:@".png"])
		{
			printf("Error: The output file name must end in .jpg or .png.\n\n");
			print_help();
			exit(0);
		}
		
		BOOL isPng = [[outputFilename lowercaseString] hasSuffix:@".png"];
		
		[NSApplication sharedApplication];
		
		Url2Thumb *url2thumb = [[[Url2Thumb alloc] init] autorelease];
		
		NSImage *fullSizeScreenshot = [url2thumb imageForURL:url
									  viewWidth:viewWidth
									 viewHeight:viewHeight
									transparent:transparentWebView];
		
		NSImage *outputImage = nil;
		NSData *imageData = nil;
		
		// Resize width, then height
		if (outputWidth > 0 && outputHeight > 0)
			outputImage = [fullSizeScreenshot resizeToWidth:outputWidth thenCropToHeight:outputHeight];
		else if (outputWidth > 0)	//resize to a width only
			outputImage = [fullSizeScreenshot resizeToWidth:outputWidth];
		else if (outputHeight > 0)	//resize to a height only
			outputImage = [fullSizeScreenshot resizeToWidth:fullSizeScreenshot.size.width thenCropToHeight:outputHeight];
		else	// use full size image
			outputImage = fullSizeScreenshot;
		
		if (isPng)
			imageData = [outputImage pngData];
		else
			imageData = [outputImage jpegData:quality];
		
		[imageData writeToFile:outputFilename atomically:YES];
		
	}
    return 0;
}

