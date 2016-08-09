//find filename & directory set as variable

PhotoFile = getInfo("image.filename"); //filename of photo
PhotoName = File.nameWithoutExtension;
PhotoDuplicate = PhotoName+"-1.JPG";
Directory = File.directory; //Find the working directory
TrayFolder = Directory+PhotoName+File.separator; //Call folder for individual tray
File.makeDirectory(TrayFolder); //create tray folder
ResultsFolder = TrayFolder+"LeafImages"+File.separator; //Call the folder name for the results folder
File.makeDirectory(ResultsFolder); //create the leaf folder

//develop macro 

run("Rotate 90 Degrees Right"); //rotate so that image 'reads' leaves left to right
run("Duplicate...", "title="+PhotoDuplicate); //duplicate images for analysis

//Convert to lab stack then select leaves from slice 3
selectWindow(PhotoDuplicate); //select duplicated image
run("Lab Stack");
selectWindow(PhotoDuplicate); //select duplicated image
setSlice(3);
setAutoThreshold("Default dark");
//run("Threshold...");

//identify leaves in tray
roiManager("Reset");
run("Analyze Particles...", "size=50000-Infinity show=[Overlay Outlines] display exclude clear include add"); //isolate the leaves ADDED CLEAR 24/07/2015
roiManager("Show All with labels");

//how many leaves are in the ROI manager
NumberOfLeaves = roiManager("count"); //NOTE IMAGEJ COUNTS FROM 0, THEREFORE ALL NAMING IS l+1

showMessageWithCancel("There are "+NumberOfLeaves+" leaves, is this correct?"); //this is to check the number of leaves are correct
//wait(5000); //macro was getting in a mess by going to quickly, if it keeps doing this use this line.

for (l = 0; l<NumberOfLeaves; l++){
	selectWindow(PhotoFile); //select original window
	roiManager("Show None");
	roiManager("Select", l); //select leaf
	LeafName = PhotoName+"_Leaf"+l+1+"";
	run("Duplicate...", "title="+LeafName); //duplicate leaf image
	selectWindow(LeafName); //select new leaf image
	setBackgroundColor(0, 0, 0);
	run("Clear Outside"); //remove non-leaf area

	//save images in folder
	run("Rotate 90 Degrees Left"); //rotate so that image back to normal.
	saveAs("Tiff", ""+ResultsFolder+LeafName+".TIF");
	run("Close");
}

selectWindow(PhotoDuplicate);
run("Close");
selectWindow("ROI Manager");
run("Close");
selectWindow("Results");
IJ.renameResults(""+PhotoName+"_LeafData");
saveAs("txt", ""+TrayFolder+PhotoName+"_LeafData.xls");
run("Close");
selectWindow(PhotoFile);
run("Rotate 90 Degrees Left");

//replace with lesion analysis loop
exit("Macro complete!\nLeaf images & data has been saved in "+ResultsFolder+".")