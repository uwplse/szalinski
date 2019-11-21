// Star Outer Diameter
Star_Dia=40;
// Star Inner Diameter
Star_iDia=18;
// Star Thickness
Star_Thickness=3;
// Number of Points (minimum 3)
Pointed=5;
// Star Point Circle Diameter
Star_Points=8;
// Text Line 1
TextLine1="Sheriff";
// Text Line 2
TextLine2="Grimes";
// Text Height
TextThick=1;
// Font Height
TextHeight=9;
// Mounting Pin Length
mpl=20;
// Mounting Pin Width
mpw=5;
// Mounting Pin Depth
mpd=1;
//Multi Material Settings
Print="All"; //[[All,Star Only,Text Only]]
$fn=30*1;

// Star.scad created by Jim ( https://gist.github.com/anoved/9622826 )
// points = number of points (minimum 3)
// outer  = radius to outer points
// inner  = radius to inner points
module Star(points, outer, inner) {
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	// angular width of each pie slice of the star
	increment = 360/points;
	union() {
		for (p = [0 : points-1]) {
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p
			x_outer = x(outer, increment * p);
            y_outer = y(outer, increment * p);
            x_inner = x(inner, (increment * p) + (increment/2));
            y_inner = y(inner, (increment * p) + (increment/2));
            x_next  = x(outer, increment * (p+1));
            y_next  = y(outer, increment * (p+1));
            polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
            translate([x_outer,y_outer,0])circle(d=Star_Points);
		}
	}
}
module StarBall(points, outer, inner) {
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	increment = 360/points;
	union() {
		for (p = [0 : points-1]) {
			x_outer = x(outer, increment * p);
            y_outer = y(outer, increment * p);
            x_next  = x(outer, increment * (p+1));
            y_next  = y(outer, increment * (p+1));
            difference(){
                translate([x_outer,y_outer,0])scale([1,1,.5])sphere(d=Star_Points);
                translate([x_outer,y_outer,-Star_Points])cylinder(d=Star_Points,h=Star_Points);
            }
		}
	}
}
difference(){
    union(){
        //If Print doesnot equal text only print star
        if(Print!="Text Only"){
            linear_extrude(height=Star_Thickness)Star(Pointed,Star_Dia,Star_iDia);
            translate([0,0,Star_Thickness])StarBall(Pointed,Star_Dia,Star_iDia);
        }
        //If Print doesnot equal Star Only Print Text
        if(Print!="Star Only"){
            difference(){
                linear_extrude(height=Star_Thickness+TextThick){
                    union(){
                        translate([TextHeight*.75,0,0])rotate([0,0,-90])text(text=TextLine1, font="Arial Black", halign="center", valign="center", size=TextHeight);
                        translate([-TextHeight*.75,0,0])rotate([0,0,-90])text(text=TextLine2, font="Arial Black", halign="center", valign="center", size=TextHeight*.75);
                    }
                }
                linear_extrude(height=Star_Thickness)Star(Pointed,Star_Dia,Star_iDia);
            }
        }
    }
    translate([mpw,-mpl/2,-mpd])cube([mpw,mpl,mpd*2]);
}