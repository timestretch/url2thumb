url2thumb
=========

Take screenshots of web sites from the command line on your mac.

Examples
--------

This example will take a full size, full quality png screenshot.

	./url2thumb -url "http://www.cnn.com/" -o cnn.png

This example shows all available flags, and will make a smaller 150x100 pixel JPEG thumbnail of the website.

	./url2thumb -url "http://www.timestretch.com/ \
				-o "timestretch.jpg" \
				-viewWidth 1024 \
				-viewHeight 768 \
				-outputWidth 150 \
				-outputHeight 100 \
				-quality 0.75

Flags
=====


Only the "-url" and "-o" output file flags are required. The others are optional, but very useful to getting the desired output. If you omit any optional flags, the default values indicated below will be used.

--------------------------

Specify the URL to visit and take a screenshot. Only URLs that start with "http" and "https" are allowed. You may put urls in quotes that contain special characters such as ampersands.

	-url "http://www.example.com/"

--------------------------

Specify the output file name and path. The extension used for the output file may be ".png" or ".jpg". Quality for JPEGs may be specified with the -quality flag.

	-o "/tmp/example.jpg"

--------------------------

Specify the initial viewport size in pixels, to contain the WebView. You may get the mobile version of the site by passing in a width of 320 or 480 pixels.

	-viewWidth (default = 1024)
	-viewHeight (default = 768)

--------------------------

If left blank, the resulting screenshot will be sized to contain the entire web view. This may result in a very large image thousands of pixels tall. You may crop to either either an outputWidth or outputHeight, or both.

	-outputWidth (default = automatic)
	-outputHeight (default = automatic)

--------------------------

If you specify and output file type of ".jpg", you can also pass in the -quality flag (between 0.01 and 1.0). If you don't specify a quality, 0.75 will be used.

	-quality [0.0 - 1.0] (default = 0.75)

Warning: Shared-Session Issues
------------------------------

If you are logged in to a website in Safari or other browser that uses WebKit, your screenshots taken with url2thumb will reflect this. WebKit shares session data among all WebViews shared by a user. If you have any suggestions on how to fix this, please let me know.

To-Do
-----

- Pass in a time to wait before taking screenshot for pages with loading animations.
- Deal with shared sessions issue mentioned above.

-------------------------------

©2006-2012 Erik Wrenholt

- Web site: [Timestretch.com](http://www.timestretch.com/)
- GitHub: [github.com/timestretch](https://github.com/timestretch)
