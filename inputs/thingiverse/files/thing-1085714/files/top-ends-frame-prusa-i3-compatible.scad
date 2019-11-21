//////////////////////////////////////////////////////////////////////////////////////
///
///  Z-axis - top end - for FRAME Prusa i3 compatible
///
//////////////////////////////////////////////////////////////////////////////////////
///
///  2016-04-21 bfj@bflm.eu, Czech Republic
///
///  released under Creative Commons - Attribution - Share Alike licence (CC BY-SA)
//////////////////////////////////////////////////////////////////////////////////////

/*[dimensions]*/
bearing_tolerance = 0.18;
hole_tolerance = 0.2;
nut_tolerance = 0.15;
pos = 0;//[0:Right,1:Left]


/*[hidden]*/
width = 54.2;
height = 8;
depth = 40;
front_width = 34.6;
tolerance = 0.02;
//for next frame generation 
screw=3;//[3,4,5]
m=5;//[5,6,8]

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
METRIC_NUT_THICKNESS =
[
	-1, //0 index is not used but reduces computation
	-1,
	-1,
	2.40,//m3
	3.20,//m4
	4.00,//m5
	5.00,//m6
	-1,
	6.50,//m8
	-1,
	8.00,//m10
	-1,
	10.00,//m12
	-1,
	-1,
	-1,
	13.00,//m16
	-1,
	-1,
	-1,
	16.00//m20
	-1,
	-1,
	-1,
	19.00,//m24
	-1,
	-1,
	-1,
	-1,
	-1,
	24.00,//m30
	-1,
	-1,
	-1,
	-1,
	-1,
	29.00//m36
];



bearing_623 = [10, 4, 3 ];
bearing_624 = [13, 5, 4];
bearing_625 = [16, 5, 5];
bearing_626 = [19, 6, 6];
bearing_608 = [22, 7, 8];

bearing= bearing_625;
if(m==6){
    bearing= bearing_626;
} else if (m==8){
    bearing= bearing_608;
}

function reduction_hole(r, fn) = r/cos(360/fn);


//main box
module chamfered_main_box(h,d=[1,1,1]){
//z-box points    
a0 = [[width-front_width+d[0],+d[1]],[width-d[0],+d[1]],[width-d[0],depth-d[1]],[+d[0],depth-d[1]]];
//x-box points
a1 = [[width-front_width,+d[1]+4],[width,+d[1]+4],[width,depth-d[1]],[0,depth-d[1]]];
//y-box points
a2 = [[width-front_width+d[0]+4,0],[width-d[0]-4,0],[width-d[0],depth],[+d[0],depth]];
//path
pa0=[[0,1,2,3]];
hull(){
        //z-box
        linear_extrude(h) polygon(a0,pa0);
        //x-box
        linear_extrude(h-d[2]) polygon(a1,pa0);
        //y-box
        linear_extrude(h-d[2]) polygon(a2,pa0);
        //front corner
        translate([width-front_width+3,4,0])cylinder(r=4,h=h-d[2],$fn=32);
        //front corner ortogonal
        translate([width-4,4,0])cylinder(r=4,h=h-d[2],$fn=32);
        }

}



//final module
module top_end(){

difference(){
//main box    
chamfered_main_box(height,[1.5,1.5,1]);
//screw holes
translate([width-4.5,4.5,-tolerance])cylinder(r=reduction_hole(screw/2+hole_tolerance,32),h=height+2*tolerance,$fn=32); 
translate([width-4.5,4.5,height-tolerance-nut_tolerance-METRIC_NUT_THICKNESS[screw]])cylinder(r=METRIC_NUT_AC_WIDTHS[screw]/2+nut_tolerance,h=METRIC_NUT_THICKNESS[screw]+2*nut_tolerance,$fn=6);      
translate([width-8.3,18.7,-tolerance])cylinder(r=reduction_hole(screw/2+hole_tolerance,32),h=height+2*tolerance,$fn=32);
 translate([width-8.3,18.7,height-tolerance-nut_tolerance-METRIC_NUT_THICKNESS[screw]])cylinder(r=METRIC_NUT_AC_WIDTHS[screw]/2+nut_tolerance,h=METRIC_NUT_THICKNESS[screw]+2*nut_tolerance,$fn=6);
translate([width-27.5,35,-tolerance])cylinder(r=reduction_hole(screw/2+hole_tolerance,32),h=height+2*tolerance,$fn=32); 
translate([width-27.5,35,height-tolerance-nut_tolerance-METRIC_NUT_THICKNESS[screw]])cylinder(r=METRIC_NUT_AC_WIDTHS[screw]/2+nut_tolerance,h=METRIC_NUT_THICKNESS[screw]+2*nut_tolerance,$fn=6);
translate([width-46,35,-tolerance])cylinder(r=reduction_hole(screw/2+hole_tolerance,32),h=height+2*tolerance,$fn=32); 
translate([width-46,35,height-tolerance-nut_tolerance-METRIC_NUT_THICKNESS[screw]])cylinder(r=METRIC_NUT_AC_WIDTHS[screw]/2+nut_tolerance,h=METRIC_NUT_THICKNESS[screw]+2*nut_tolerance,$fn=6);    
translate([width-37,15,-tolerance])cylinder(r=reduction_hole(screw/2+hole_tolerance,32),h=height+2*tolerance,$fn=32); 
translate([width-37,15,height-tolerance-nut_tolerance-METRIC_NUT_THICKNESS[screw]])cylinder(r=METRIC_NUT_AC_WIDTHS[screw]/2+nut_tolerance,h=METRIC_NUT_THICKNESS[screw]+2*nut_tolerance,$fn=6);    
//----    
//M5 threaded rod hole    
translate([width-27.5,10.5,-tolerance])cylinder(r=reduction_hole(m/2+hole_tolerance,32),h=height+2*tolerance,$fn=32);
//625zz bearing hole
translate([width-27.5,10.5,-tolerance])cylinder(r=reduction_hole(bearing[0]/2+bearing_tolerance, 32),h=bearing[1]+2*tolerance+0.1,$fn=32);
//M8 smooth rod hole   
translate([width-10.5,10.5,-tolerance])cylinder(r=reduction_hole(8/2+hole_tolerance,32),h=5+2*tolerance,$fn=32);
     }      
    
}

if(pos == 1){
    mirror([1,0,0]) top_end();
     /*translate([122.5-width,+40+26+34.15,0])rotate([180,0,270]){
        import("stop_warp_Virsus_Tvirtinimas_1.stl");
    }*/
} else {
    top_end();
   /*translate([width,+40+26+34.15,0])rotate([180,0,270]){
      import("stop_warp_Virsus_Tvirtinimas_2.stl");
   }*/
}


