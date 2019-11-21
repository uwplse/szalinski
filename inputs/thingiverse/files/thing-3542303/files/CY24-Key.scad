// preview[view:north, tilt:top]

/* [Bitting 1-4] */
Depth_1		=	1; //[1,2,3,4]
Depth_2		=	2; //[1,2,3,4]
Depth_3		=	3; //[1,2,3,4]
Depth_4		=	4; //[1,2,3,4]
/* [Bitting 5-8] */
Depth_5		=	1; //[1,2,3,4]
Depth_6		=	2; //[1,2,3,4]
Depth_7		=	3; //[1,2,3,4]
Depth_8		=	4; //[1,2,3,4]
/* [Hidden] */
Key_Code    =   [Depth_1,Depth_2,Depth_3,Depth_4,Depth_5,Depth_6,Depth_7,Depth_8];// Key code Tip to Bow

//Module produces a cube with rounded corners
module rounded(size, r) {
    union() {
        translate([r, 0, 0]) cube([size[0]-2*r, size[1], size[2]]);
        translate([0, r, 0]) cube([size[0], size[1]-2*r, size[2]]);
        translate([r, r, 0]) cylinder(h=size[2], r=r);
        translate([size[0]-r, r, 0]) cylinder(h=size[2], r=r);
        translate([r, size[1]-r, 0]) cylinder(h=size[2], r=r);
        translate([size[0]-r, size[1]-r, 0]) cylinder(h=size[2], r=r);
    }
}


Blade_Len   = 55.0;
Blade_Width =  8.636; //Based on chart showing a #1 cut = 0.340"
Blade_Thk   =  2.0;

Ward1_Len   = 36.0;
Ward1_Width =  2.0;
Ward1_Thk   =  1.0;

Ward2_Len   = 36.0;
Ward2_Width =  1.0;
Ward2_Thk   =  0.5;

//Took Bit depth and spacing from a chart in inches.
//Define vectors and convert to mm
Depth_in    =   [0.340, 0.315, 0.290, 0.265];
Depth       =   Depth_in * 25.4;
echo("Depth:", Depth);
Bit_in      =   [0.296, 0.389, 0.481, 0.573, 0.665, 0.757, 0.849, 0.941];
Bit         =   Bit_in * 25.4;
echo(Bit);


//position of cut for ward 1A (Top side)
W1A_X = 0.0;
W1A_Y = 0.0;
W1A_Z = Blade_Thk - Ward1_Thk;

//position of cut for ward 1B (Bottom side)
W1B_X = 0.0;
W1B_Y = Blade_Width-Ward1_Width;
W1B_Z = 0.0;

//Ward 2 is a pair of central cuts down the center of the blade
//I'm defining the center of each cutout this time
W2_X =  Ward2_Len   / 2.0;
W2_Y =  Blade_Width / 2.0; //center of blade
W2A_Z=  Blade_Thk - (Ward2_Thk / 2.0);
W2B_Z=  0.0;


difference(){
                                            cube([Blade_Len,Blade_Width,Blade_Thk]); //Blade
    translate([W1A_X,W1A_Y,W1A_Z])          cube([Ward1_Len,Ward1_Width,Ward1_Thk]); //Warding 1A
    translate([W1B_X,W1B_Y,W1B_Z])          cube([Ward1_Len,Ward1_Width,Ward1_Thk]); //Warding 1B
    translate ([W2_X, W2_Y,W2A_Z])          cube([Ward2_Len,Ward2_Width,Ward2_Thk],true);//Warding 2A
    translate ([W2_X, W2_Y,W2B_Z])          cube([Ward2_Len,Ward2_Width,Ward2_Thk],true);//Warding 2B
    
	//cut out rectangular bits to correct depth pos 0-7, tip towards bow
	for(bit = [0:1:7]){
		translate([Bit[bit], Depth[Key_Code[bit]-1], W1A_Z]) #cube([1,Blade_Width-Depth[Key_Code[bit]-1],1]);
		translate([Bit[bit],                      0, W1B_Z]) #cube([1,Blade_Width-Depth[Key_Code[bit]-1],1]);
		}
   
    // No reason to get too fancy. Just cut off tip at a 45.
    translate ([ 0.0, Blade_Width / 2.0, 0.0])
    {rotate    ([0,0,45]) cube ([Blade_Width*0.71,Blade_Width*0.5, Blade_Thk]);}
    translate ([ 0.0, Blade_Width / 2.0, 0.0])
    {rotate    ([0,0,-135]) cube ([Blade_Width*0.5,Blade_Width*0.71, Blade_Thk]);}
    }
    

//Now let's add a simple handle 
Bow_Space   =   10.0;
H_Len   =   20.0;
H_Width =   30.0;
H_Thk   =   Blade_Thk + 2.0;

translate ([Ward1_Len+Bow_Space, 0.0, 0.0])
difference(){
                                                               rounded([H_Len,H_Width,H_Thk],4);
    translate ([H_Len/2, H_Width/2, H_Thk/2])  cylinder(h=H_Thk+10, r=4, center=true);
}

