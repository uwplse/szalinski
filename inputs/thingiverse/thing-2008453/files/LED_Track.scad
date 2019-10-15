// for nonWP strip no shrink wrap
StripWidth = 10.7;  
StripHeight = 1.75; 
StripGap = 5.5; // leave clearance for the LED's to shine through
offset = 0.25;


// For nonWP strip With Shrin
//StripWidth = 10.9;  
//StripHeight = 3; 
//StripGap = 6; // leave clearance for the LED's to shine through
//offset = 0.25;

// For WP strip with shrink wrap
//StripWidth = 10.7;  
//StripHeight = 4; 
//StripGap = 6.5; // leave clearance for the LED's to shine through
// offset = 0;


// For WP strip no shrink wrap
//StripWidth = 10.5;  
//StripHeight = 2.5; 
//StripGap = 6.5; // leave clearance for the LED's to shine through
// offset = 0;



SideWall = 2;
TopWall = 2;
Length = 230;



module remove() {
    union(){
        cube([Length+1,StripWidth,StripHeight], center=true);
        translate([0,0+offset,(StripHeight-.01)]) 
        cube([Length+1, StripGap, StripHeight], center=true);
        
    }
}

translate([0,0,0]) {
    difference() {
        cube([Length, (StripWidth+SideWall), (StripHeight+TopWall)], center=true);
        remove();
    }
}
