/* A script to detect lesions in photo. 
Instead, try and capture all lesions within a single photo and allow user to say which lesion is which
Could possibly develop all for a photo later, after including set scale measurement at beginning?*/

macro "Lesion detection [q]" {

setBatchMode(true); //batch mode on

PhotoFile = getInfo("image.filename"); //filename of photo
PhotoName = File.nameWithoutExtension; //name of photo (no file extension)
PhotoDuplicate = PhotoName+"-1.JPG"; //filename of photo duplicate

Directory = File.directory; //Find the working directory
ROIFolder = Directory+"ROI"+File.separator; //Call folder for ROIs
//print(ROIFolder)
File.makeDirectory(ROIFolder); //create ROI folder

run("Duplicate...", "title="+PhotoDuplicate); //duplicate images for analysis

selectWindow(PhotoDuplicate); //select the duplicate photo for manipulation
run("Lab Stack"); //split the photo into CIE lab stack, which shows clear differential between infected and healthy tissue.
selectWindow(PhotoDuplicate); //select the duplicate photo again (it needs this or it gets confused)
setSlice(2); //select slice 2 which has dark lesions and brightly coloured leaves
run("Gaussian Blur...", "sigma=3 slice"); //run small gaussian blur to obscure any small error details
setAutoThreshold("Minimum");  //Automatically filters for lesions based on Shebang method with the background presumed as light, should isolate most lesions
run("Convert to Mask", "method=Minimum background=Light calculate");
run("Analyze Particles...", "size=10-Infinity circularity=0.1-1.00 exclude clear add slice"); //analyse particles based on being >5mm and at least mostly circular.
close(PhotoDuplicate); //close the edited duplicate photo
setBatchMode(false); //exit batch mode

selectWindow(PhotoFile); //select original
roiManager("Show All"); //show detected lesions
roiManager("Save", ROIFolder+PhotoName+"_roi.zip"); // saves selected ROI as image name + "_ROI.zip"
//run("Flatten");
//saveAs("Jpeg", ROIFolder+PhotoName+"_roi.jpg");
//roiManager("Measure");

}