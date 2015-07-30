run("Lab Stack"); 
setSlice(2); 
run("Gaussian Blur...", "sigma=2 slice"); 
setAutoThreshold("Moments dark"); 
run("Analyze Particles...", "size=200-Infinity exclude clear add slice"); 