#Readme for lesion_analysis.ijm


##Description

This script will convert images to lab stack, extract circular lesions on green backgrounds and add them to the region of interest (ROI) in FIJI/ImageJ. It also saves the ROI selection in a subfolder called "/roi/" under the photo name and measures all lesions it successfully detects.

##Installation

*	To install (temporarily) save the "lesion_analysis.ijm" file somewhere memorable
*	Open ImageJ or FIJI
*	Click on "Plugins" in the top toolbar
*	Hover the mouse over "Macros", then click "Install..."
*	Select the "lesion_analysis.ijm" file you saved earlier

The macro is installed! By default, it is bound to the "q" key, however this can be changed by editing the .ijm file at the top line, where it says "Lesion detection [q]".  Simply change the letter "q" in this line to something else.

If the script doesn't seem to work, you can open the .ijm file and run it directly from there. This is useful for checking errors.

*	Click File > Open
*	Select the "lesion_analysis.ijm" file
*	Open the window containing the code
*	Hit "run" after selecting the photo you wish to analyse.

##Using the Macro

####The macro will by default:

	1. Duplicate the image
	2. Convert the duplicated image to CIE lab stack (a type of colour space different to standard RGB)
	3. Select the second layer of the lab stack
	4. Auto detect circular regions that lack green colour within green areas
	5. Add them to the region of interest (ROI)
	6. Save the ROIs
	7. Measure all detected lesions

####To use:

	1. Rename all images to appropriate, identifiable names ("exp26_tray5_72hpi.jpg"). Do not use spaces.
	2. Open the first image you would like to analyse
	2. Using the straight line tool, draw a line along the 5cm ruler
	3. Set the scale by clicking Analyse > Set Scale and selecting 5cm as the known distance
	4. Click OK and select the photo 
	5. Press "q" on the keyboard (or hit run if the script is open)
	6. Leave for a while - it may take some time
	7. The original image will appear with ROIs illustrating detected lesions along with numerical values
	8. False positive lesions can be removed by clicking the ROI region where they are and hitting delete
	9. False negative lesions have to be manually added, using an available ImageJ/FIJI tool (free hand, versatile wand etc).
	10. Clicking "measure" will add the calculated area of each selected ROI to the measure box
	11. The ROI can be saved by clicking More > Save in the ROI window


The ROI detected by the macro is saved in a subfolder of the image called "roi". This can be reopened later if necessary.

	1. Open the image of interest in ImageJ/FIJI
	2. Open the ROI of interest in ImageJ/FIJI (which should have the same filename but with "_roi.zip" added