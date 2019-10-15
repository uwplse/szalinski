//Customizable Silverware Drawer Organizer -3 side by side for drawer wider then 6 inches,
//Each Holder Printerd Seperately and placed next to each other in drawer
//Knife, Spoon, Fork
//Simple Cube design
//Thickness of design is not adjustable
//Designed to to sit side by side with edge of drawer or another holder


//Enter Width of Drawer in mm
w=254;

//Depth of drawer (Measure side down) in mm 
d=63;

//Enter Length (mm) of Longest Utensile 
L=216;


module uholder(){
        difference(){
        cube([(w/3),(d-13),(L+25.4)],false);
            translate([(25/3)/2,7,7])cube([((w-25)/3),(d-6),(L+12)],false);
    }
}
uholder();