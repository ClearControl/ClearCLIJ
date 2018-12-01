// Get test data
//run("Blobs (25K)");
open("C:/structure/data/blobs.gif");
getDimensions(width, height, channels, slices, frames);
input = getTitle();
threshold = 128;

// create memory for mask and temp image
newImage("Untitled", "8-bit black", width, height, slices);
rename("Mask");
mask = getTitle();

newImage("Untitled", "8-bit black", width, height, slices);
rename("Temp");
temp = getTitle();


// Init GPU
run("CLIJ Macro Extensions", "cl_device=[Intel(R) UHD Graphics 620]");
Ext.CLIJ_clear();

// push data to GPU
//Ext.CLIJ_push(input);
//Ext.CLIJ_push(mask);
//Ext.CLIJ_push(temp);

// cleanup ImageJ
run("Close All");

// create a mask using a fixed threshold
Ext.CLIJ_threshold(input, mask, threshold);

// binary opening: erosion + dilation, twice each
Ext.CLIJ_erode(mask, temp);
Ext.CLIJ_erode(temp, mask);

Ext.CLIJ_dilate(mask, temp);
Ext.CLIJ_dilate(temp, mask);


// show result
Ext.CLIJ_pull(mask);

