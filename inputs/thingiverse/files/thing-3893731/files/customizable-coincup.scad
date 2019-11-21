//this is the radius of your cup holder, in mm. it is best to under-estimate so the coin cup fits nicely
r = 35;

//this is the height of your cup holder, which I recommend being less than the actual height of your cup holder
h = 48;

$fn = 100;

difference () {
    
    cylinder (h, r, r, center = true); //holder body
    
    translate ([0, -(r - 8), 3]) cylinder (h - 2, 10, 10, center = true); //penny slot
    translate ([-(r - 9), 0, 3]) cylinder (h - 2, 11, 11, center = true); //nickel slot
    translate ([0, (r - 7), 3]) cylinder (h - 2, 9, 9, center = true); //dime slot
    translate ([(r - 12), 0, 3]) cylinder (h - 2, 13, 13, center = true); //quarter slot
    
    translate ([-70,-9,-24.5]) cube (size = [140,18,10]); // fingerslot
	rotate ([0,0,90]) translate ([-70,-7,-24.5]) cube (size = [140,14,10]); // fingerslot
    
    translate ([25.5,-13,-20]) cube (size = [15,26,2.8]); 
	translate ([-40.5,-13,-20]) cube (size = [15,26,2.8]); 
	translate ([-14.75,23,-20]) cube (size = [29.5,15,3]); 
	translate ([-10.75,-34.5,-20]) cube (size = [21.5,10,4.35]); 
    }
    