//////////////////////////////////////////////////////////////////////////////////////
///
///  Z-axis backlash - support for Split X-Ends - Prusa i3, with Endstop and Belt Tensioner
///
//////////////////////////////////////////////////////////////////////////////////////
///
///  2016-04-19 bfj@bflm.eu, Czech Republic
///
///  released under Creative Commons - Attribution - Share Alike licence (CC BY-SA)
//////////////////////////////////////////////////////////////////////////////////////

/*[globales]*/
//metric nut size
m = 5; //[5,6,8]
//hole for threaded rod
hole_tolerance = 0.45;
//nut tolerance
nut_tolerance = 0.1;
//if motor part then idler=No else idler=Yes
idler = 0;//[0:No,1:Yes]

/*[dimensions]*/
//top part height in mm (exterior dimension)
height_top = 17;
//botom part height in mm (exterior dimension)
height_bottom = 18;


/*[hidden]*/
width_bottom = 2*m+2;
depth_bottom = 2*m;
tolerance = 0.02;

//Based on: http://www.roymech.co.uk/Useful_Tables/Screws/Hex_Screws.htm
METRIC_NUT_AC_WIDTHS =
[
	-1, //0 index is not used but reduces computation
	-1,
	-1,
	6.40,//m3
	8.10,//m4
	9.20,//m5
	11.50,//m6
	-1,
	15.00,//m8
	-1,
	19.60,//m10
	-1,
	22.10,//m12
	-1,
	-1,
	-1,
	27.70,//m16
	-1,
	-1,
	-1,
	34.60,//m20
	-1,
	-1,
	-1,
	41.60,//m24
	-1,
	-1,
	-1,
	-1,
	-1,
	53.1,//m30
	-1,
	-1,
	-1,
	-1,
	-1,
	63.5//m36
];

metric_radius = METRIC_NUT_AC_WIDTHS[m]/2;
bottom_nut_radius = metric_radius +nut_tolerance;
top_nut_radius = metric_radius -nut_tolerance/2;
top_hole_radius = reduction_hole(r=m/2+hole_tolerance,fn=32);
inner_r2 = top_hole_radius/cos(30);
echo(top_hole_radius);
module nutHoleHeight(r, height )
{

		cylinder(r= r, h=height, $fn = 6, center=[0,0]);
	
}



module chamfered_nutHole(r1, r2, height){
          
    d = r1-r2;
    hull(){
  	  translate([0,0,d])cylinder(r= r1,h=height-2*d,$fn = 6, center=[0,0]);
      cylinder(r= r2,h=height,$fn = 6, center=[0,0]);
   }
}

module z_backlash(){

d = bottom_nut_radius-inner_r2;  
difference(){
union(){
difference(){
translate([0,0,height_bottom/2])
cube([width_bottom,depth_bottom,height_bottom], center = true);
   
translate([0,0,-tolerance-d])
chamfered_nutHole(r1=bottom_nut_radius,  height=height_bottom+tolerance-1+d, r2=inner_r2);
    
}    

translate([0,0,height_bottom])
nutHoleHeight(r=top_nut_radius,  height=height_top);
    
}

cylinder(r=top_hole_radius,h=height_top+height_bottom+tolerance, $fn = 32,center=[0,0]);

}

}

function reduction_hole(r, fn) = r/cos(360/fn);


if(idler == 1){
    difference(){
        z_backlash();
        diff = m/cos(30)-m;
        r_cutter = m+diff;
        x0_cutter = (top_hole_radius+r_cutter)*sin(30);
        y0_cutter = (top_hole_radius+r_cutter)*cos(30);
        translate([-x0_cutter,y0_cutter,height_bottom+1+height_top/2+tolerance]){
            cylinder(r=r_cutter,h=height_top,center=true,$fn=32);
        }
    } 

} else {
    
    z_backlash();
    
}



