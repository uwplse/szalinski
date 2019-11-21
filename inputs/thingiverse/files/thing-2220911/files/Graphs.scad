min_value =  -3;
max_value = 3;
resolution = .2;
line_thickness = .1;
fn = 24;    
    
/**
* line3d.scad
*
* Creates a 3D line from two points. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line3d.html
*
**/

module line3d(p1, p2, thickness, p1Style = "CAP_CIRCLE", p2Style = "CAP_CIRCLE") {
    r = thickness / 2;

    frags = $fn > 0 ? 
        ($fn >= 3 ? $fn : 3) : 
        max(min(360 / $fa, r * 2 * 3.14159 / $fs), 5)
    ;
    
    dx = p2[0] - p1[0];
    dy = p2[1] - p1[1];
    dz = p2[2] - p1[2];
    
    
    length = sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2));

    ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2)));
    az = atan2(dy, dx);

    module cap_butt() {
        translate(p1) 
            rotate([0, ay, az]) 
                linear_extrude(length) 
                    circle(r);
    }
                
    module capCube(p) {
        w = r / 1.414;
        translate(p) 
            rotate([0, ay, az]) 
                translate([0, 0, -w]) 
                    linear_extrude(w * 2) 
                        circle(r);       
    }
    
    module capSphere(p) {
        translate(p) 
            rotate([0, ay, az]) 
                sphere(r * 1.0087);          
    }
    
    module cap(p, style) {
        if(style == "CAP_CIRCLE") {
            capCube(p);     
        } else if(style == "CAP_SPHERE") { 
            if(frags > 4) {
                capSphere(p);  
            } else {
                capCube(p);       
            }        
        }       
    }
    
    cap_butt();
    cap(p1, p1Style);
    cap(p2, p2Style);
}

/**
* polyline3d.scad
*
* Creates a 3D polyline from a list of `[x, y, z]` coordinates. 
* It depends on the line3d module so you have to include line3d.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polyline3d.html
*
**/

module polyline3d(points, thickness, startingStyle = "CAP_CIRCLE", endingStyle = "CAP_CIRCLE") {
    module line_segment(index) {
        styles = index == 1 ? [startingStyle, "CAP_BUTT"] : (
            index == len(points) - 1 ? ["CAP_SPHERE", endingStyle] : [
                "CAP_SPHERE", "CAP_BUTT"
            ]
        );
        
        line3d(points[index - 1], points[index], thickness, 
               p1Style = styles[0], p2Style = styles[1]);
    }

    module polyline3d_inner(points, index) {
        if(index < len(points)) {
            line_segment(index);
            polyline3d_inner(points, index + 1);
        }
    }

    polyline3d_inner(points, 1);
}    

/*
* Remixed from [OpenSCAD Graph Generator](http://www.thingiverse.com/thing:2214040) 
*    by [WClampitt1](http://www.thingiverse.com/WClampitt1/).
* 
* @license https://opensource.org/licenses/lgpl-3.0.html
* 
* @see https://www.thingiverse.com/thing:2220911
*/
    
function f(x, y) = (pow(y,2)/pow(2, 2))-(pow(x,2)/pow(2, 2));

graph(
    min_value, 
    max_value, 
    resolution, 
    line_thickness, 
    fn
);

module graph(min_value, max_value, resolution, line_thickness, fn){
    $fn = fn;
    
    _scale = 10;
    
    module x_axis(){
        for(y = [min_value : resolution : max_value]) {
            polyline3d(
                [for(x = [min_value: resolution : max_value]) [x, y, f(x, y)]], 
                line_thickness, 
                startingStyle = "CAP_SPHERE", 
                endingStyle = "CAP_SPHERE"
            );
        }
    }
    
    module y_axis(){                    
        for(x = [min_value : resolution : max_value]) {
            polyline3d(
                [for(y = [min_value: resolution : max_value]) [x, y, f(x, y)]], line_thickness, 
                startingStyle = "CAP_SPHERE", 
                endingStyle = "CAP_SPHERE"
            );
        }
    }
    
    scale(_scale) union() {
        x_axis();
        y_axis();
    }
}

    
