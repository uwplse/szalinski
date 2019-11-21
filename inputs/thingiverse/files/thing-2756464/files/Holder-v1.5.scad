/* If you want to use the new customization features, then you need the newest development version of OpenSCAD which you can get on the website along with the standard version. 
    Enable Edit--Preferences--Features--customizer and then uncheck View--Hide customizer.*/

/* I tried to limit the size and fit options for the customizer to reasonable ranges but if you have come this far (i.e. opening the .scad file in a text editor ;)) you can change these values easily if you need to. The values in square brackets (for example [0:0.1:1]) create a step slider in the customizer and values are [lowest step value:step size:highest step value]. Experiment with the values until you are satisfied with the look and fit. You should be able to print it with the default values though. 
    The code is amply commented so it should be easy to understand and possibly reuse. Commenting the code helps you understand it and me to learn and memorize the OpenSCAD scene language.*/

// little info tab for thingiverse users
/* [More detailed info on parameters in .scad-file!] */
// (file can be opened with any text editor)
ok = false; // 

// here you can choose which parts to print. If you just want to test the fit of a single part (i.e. the bearing holder or the outer holder part) you can switch off the other parts of the brace
/* [Parts to print (chose single parts for fit testing)] */
// Print the brim (blue)? yes/no
brim_yn = true;
// Outer holder part (yellow)?
holder_outer_wall_yn = true;
// Bearing holder (orange)?
bearing_holder_yn = true;
// Struts (green)?
struts_yn = true;


/* The fit options are there for adjusting the fit of the brace on future prints. Your first print will tell you where you need adjustments, if any.*/
/* [Fit options] */
// Adjusting the press fit value will add tenths of a millimeter to the outside of the main brace wall so that it fits more tightly into the spool. Initially I printed it with 0.5 mm added (58.5mm diameter, current default setting) which was a pretty tight fit, almost too tight, so I added the option to reduce this if the brace does hardly fit into the spool when printed on your printer. I would recommend values between 0.2-0.5. Less and the brace would probably slide out too easily. The actual spool inside diameter is 58mm (to 59mm near the surface of the spool). The brace is designed to be a bit oversized so that it does not come off easily.
// Press fit (default: 0.5mm, added to outside of 'main wall', diameter inside spool is 58 mm, 59mm near the surface)
press_fit = 0.5; // [0:0.1:0.5]

// The next value adds material on the inside of the bearing holder to make the bearing fit more tightly. If you choose a value of 0.1mm you are taking away about 1/10 of the diameter of a bearing so values from 0.025 to 0.1 might be a good idea if the bearings fit too loosely (as did mine). I still have to test printing only the holder to see which settings are best. I'll update here with recommendations.
// Bearing fit snugness (default: 0mm, be careful with this or you might have to file a lot to fit the bearings in)
bearing_fit = 0; // [0:0.025:0.2]

/* [Size and Looks options] */
// Brim height (actual brim, not printing brim, default: 3 mm)
brim_h = 3; // [1:1:5]
// Brim width (default: 7 mm)
brim_w = 7; // [2:1:15]

// A thicker wall width adds material on the inside of the wall, not the outside. The outside size is fixed (plus press fit value from above). 4mm is probably enough, it might work with 3mm, 2 or 1 is probably to fragile.
// Brace wall width (default: 4mm)
wall_width = 4; // [1:1:10]

// recommended number of struts 3-5, 6 is probably overkill, four is working nicely for me, three is not tested yet but will probably work, so 3-4 for minimal material use and 5-6 for good looks
// Number of stabilization struts (default: 4)
struts = 4; // [3:1:6]
/* [Hidden] */
$fn=72; // number of facets the parts are composed of
wall=2;

// Adjusting Bearing chamfer will add a bevel to the inside of the bearing hole so that bearings slide in more easily 
// Bearing chamfer width (default: 0.2mm)
bchamfer_w = 0.2; // [0:0.1:0.5]

// Bearing chamfer height (default: 0.4mm)
bchamfer_h = 0.4; // [0:0.1:1]

// Adjusting outer wall chamfer will add a bevel to the outside of the brace wall to make it easier to fit
// Outer wall chamfer width in mm (default: 0.2)
ochamfer_w = 0.2; // [0:0.1:1]

// Outer wall chamfer height in mm (default: 0.5)
ochamfer_h = 0.5; // [0:0.1:5]

// the following two values are for quicker rendering. If you cut out a cylinder from another for example and they are exactly the same height, OpenSCAD has difficulties deciding if the end caps of the cylinders were actually cut or not (but ONLY in the fast preview). If you render it, it shows correctly. It takes more time to preview and render and the preview looks ugly. If you oversize the cutting cylinder (or object) a tiny bit on both sides, it results in a clean hole so to speak, in the quick preview as well as in the final render. In this case, I move the cutting object a tiny bit down (tdiff) and oversize it (by th, twice tdiff) so that the cutting object protrudes by 0.05 on the top and bottom side and results in a clean cut. Any value greater than or equal to 0.001 will do. The ones I chose are arbitrary, I just liked the numbers ;).
tdiff = [0,0,-0.05];
th=0.1;

// Colors
col_holder_outer_wall = "Yellow";
col_bearing_holder =([255/255, 185/255, 0/255]);
col_struts = "GreenYellow";
col_brim = "CornflowerBlue";

// protruding brim, keeps the brace from falling into the spool
module brim(){ 
    color(col_brim)
    difference(){
        cylinder(h=brim_h, d=58+brim_w);
        translate(tdiff) cylinder(h=brim_h+th, d=58+press_fit);
    }
};

// 'main' wall that fits into spool
module holder_outer_wall(){ 
    color(col_holder_outer_wall)
    difference(){
        cylinder(h=12, d=58+press_fit);
        translate(tdiff) cylinder(h=12.1+th, d=58-wall_width);
    }
};

// holder for ball bearing
module bearing_holder(){ 
    // outer wall of holder
    color(col_bearing_holder)
    difference(){ 
        cylinder(h=7+wall+1, d=22+2*wall);
        translate(tdiff) cylinder(h=7.1+wall+1+th, d=22-bearing_fit);
    }
    // bottom of holder w/ hole for easier removal of bearing
    color(col_bearing_holder)
    difference(){ 
        cylinder(h=wall+1, d=22+2*wall); 
        translate(tdiff) cylinder(h=wall+1+th, d=12);
    }
};

// stabilization struts, base model
module strut(){ 
    translate([0,19,wall/2]) cube([10,19,wall],true);
};
    
module struts(){ // adds number of struts as set in parameters
    rot_angle = 360 / struts;
    for (a=[0:1:struts-1]){ 
        color(col_struts)
        rotate([0,0,a*-rot_angle]) strut(); // using the previously defined base model here
    };
};
    
// the parts of the brace are defined first (and can be reused as needed) and only after they are defined I actually put them in the scene, see below. This is not necessary but I think it provides a more readable, logical and literally more modular scene code plus it puts the code for switching individual modules on and off in one place.

union(){
    // outer brim (blue) 
    if(brim_yn){ brim(); };
    // wall plus brim (yellow)
    if(holder_outer_wall_yn){ holder_outer_wall(); };
    // ball bearing holder (orange)
    if(bearing_holder_yn){ bearing_holder(); };
    // stabilization struts (green)
    if(struts_yn){ struts(); };
};