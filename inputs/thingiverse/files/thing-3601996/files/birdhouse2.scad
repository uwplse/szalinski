
print_base = false;
print_top = true;
print_holder = false;

//big
fillet = 10;

radius_bottom_inner = 120;
r = 150;
r_roof = 165;

radius_pole = 50;

base_bottom_height = 50;

h = 300;

//global strength
s = 5;


width_feeder_holes = 40;

width_roof_holes = 20;

//for unperfectness in print, change to a small number
margin = 2;

roof_height = 100;

width_roof_hang = 30;
hang_holes_r = 8;

resolution = 20;
$fn=resolution;



////small
//fillet = 10;
//
//radius_bottom_inner = 70;
//r = 102;
//r_roof = 108;
//
//radius_pole = 38;
//
//base_bottom_height = 30;
//
//h = 200;
//
////global strength
//s = 2;
//
//
//width_feeder_holes = 40;
//
//width_roof_holes = 17;
//roof_holes_support_width = 2;
////for unperfectness in print, change to a small number
//margin = 2;
//
//roof_height = 80;
//
//width_roof_hang = 30;
//hang_holes_r = 8;
//
//resolution = 20;
//$fn=resolution;








module line(p1,p2,w) {
    hull() {
        translate(p1) circle(r=w);
        translate(p2) circle(r=w);
    }
}
module polyline(points, index, w) {
    if(index < len(points)) {
        line(points[index - 1], points[index],w);
        polyline(points, index + 1, w);
    }
}

function choose(n, k)=
     k == 0? 1
    : (n * choose(n - 1, k - 1)) / k;

function _point_on_bezier_rec(points,t,i,c)=
    len(points) == i ? c
    : _point_on_bezier_rec(points,t,i+1,c+choose(len(points)-1,i) * pow(t,i) * pow(1-t,len(points)-i-1) * points[i]);

function _point_on_bezier(points,t)=
    _point_on_bezier_rec(points,t,0,[0,0]);

//a bezier curve with any number of control points
//parameters: 
//points - the control points of the bezier curve (number of points is variable)
//resolution - the sampling resolution of the bezier curve (number of returned points)
//returns:
//resolution number of samples on the bezier curve
function bezier(points,fn)=[
    for (t =[0:1.0/fn:1+(1/fn/2)]) _point_on_bezier(points, t)
    ];

//create a 3D rotational model with a bezier curve of given points, resolution and thickness
module bezier_model(points,resolution,thickness) {
    translate([0,0,thickness/2]) rotate_extrude() polyline(bezier(points,resolution),1,thickness/2);
}
    









function _get_paths(paths,i,fill_point)=
    i == len(paths)-2? [[paths[i],paths[i+1],fill_point]] :
    concat([[paths[i],paths[i+1],fill_point]],_get_paths(paths,i+1,fill_point));
    
function _range(maxi,i)=
    i == maxi? maxi
    : concat(i,_range(maxi,i+1));
    
module bezier_model_filled(points,fill_point,resolution,thickness) {
    bez_paths = _range(resolution,0);
    bezier_points = bezier(points,resolution);
    paths = _get_paths(bez_paths,0,len(bezier_points));
    translate([0,0,0]) 
        rotate_extrude()
            polygon(concat(bezier_points,[fill_point]),paths=paths);
}

if(print_base) {

    difference() {
        //base with pole
        union() {
        rotate_extrude() polygon( points=[[0,0],[radius_bottom_inner,0],[radius_bottom_inner,s],[radius_pole,s],[radius_pole,h],[radius_pole-s,h],[radius_pole-s,s],[0,s]] );
        bezier_model([[radius_bottom_inner,0],[r-fillet,0],[r,base_bottom_height],[r+2,base_bottom_height]],resolution,s);
        
            bezier_model_filled([[radius_bottom_inner-fillet,s],[radius_pole,s],[radius_pole-s/2,radius_pole]],[radius_pole-s/2,s],resolution,s);
            }
        //cut out feeder holes
        translate([0,radius_bottom_inner-fillet,s])rotate([90,0,0]) linear_extrude((radius_bottom_inner-fillet)*2) polygon(points=bezier([[-width_feeder_holes/2,0],[-width_feeder_holes/2,width_feeder_holes],[-2,width_feeder_holes],[2,width_feeder_holes],[width_feeder_holes/2,width_feeder_holes],[width_feeder_holes/2,0]],resolution));
        rotate([0,0,90])translate([0,radius_bottom_inner-fillet,s])rotate([90,0,0]) linear_extrude((radius_bottom_inner-fillet)*2) polygon(points=bezier([[-width_feeder_holes/2,0],[-width_feeder_holes/2,width_feeder_holes],[-2,width_feeder_holes],[2,width_feeder_holes],[width_feeder_holes/2,width_feeder_holes],[width_feeder_holes/2,0]],resolution));

        //cut out roof mountings
        for(variable = [0 : 90 : 360])
            rotate([0,0,variable])
        translate([-width_roof_holes/2,0,h-width_roof_holes*2])rotate([90,0,0])linear_extrude(500)
        polygon(points=[[0,0],[width_roof_holes*2+margin,0],[width_roof_holes*2+margin,width_roof_holes*2],[width_roof_holes,width_roof_holes*2],[width_roof_holes,0],[width_roof_holes-roof_holes_support_width,0],[width_roof_holes-roof_holes_support_width,width_roof_holes],[width_roof_holes/2,width_roof_holes*1.5],[0,width_roof_holes]]);

    }
}

if(print_top) {
    translate([0,0,h-width_roof_holes*2]) {
        //roof mount rods
        for(variable = [0 : 90 : 360])
            rotate([0,0,variable])
        translate([-width_roof_holes/2,0,0])rotate([90,0,0])linear_extrude(r_roof-s/2)
        polygon(points=[[0,0],[width_roof_holes,0],[width_roof_holes,width_roof_holes/2-margin],[width_roof_holes/2,width_roof_holes-margin],[0,width_roof_holes/2-margin]]);

        //main roof
        difference() {
        union() {
            bezier_model([[r_roof,0],[r_roof,roof_height/2],[width_roof_hang,roof_height-width_roof_hang],[width_roof_hang+s,roof_height]],resolution,s);
            rotate_extrude()polygon(points=concat(bezier([[width_roof_hang+s*1.5,roof_height],[width_roof_hang+s,roof_height+width_roof_hang*2],[0,roof_height+width_roof_hang*2]],resolution),[[0,roof_height]]));
        }


        //hang mount
        translate([0,0,roof_height+width_roof_hang])
        for(variable = [0 : 90 : 360])
            rotate([0,0,variable])
        rotate([90,0,0])cylinder(500,hang_holes_r,hang_holes_r);
        }
        
        //stabilyser cylinder for rods and roof
        cylinder(roof_height,width_roof_hang+s,width_roof_hang+s);

    }
}

holder_r = 30;
holder_screw_r = 2;
holder_ring_r = 10;

translate([200,0,0]) if(print_holder) {
    difference(){
        cylinder(s,holder_r,holder_r);
        translate([holder_r/1.5,0,0])cylinder(s,holder_screw_r,holder_screw_r);
        translate([-holder_r/1.5,0,0])cylinder(s,holder_screw_r,holder_screw_r);
    }
            rotate([90,0,90])rotate_extrude(angle=180) translate([holder_r-holder_ring_r,0,0])circle(holder_ring_r);

}
