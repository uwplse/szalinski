// preview[view:west, tilt:top]

//Which part would you like to render? (Parts must be printed separately).
part="All"; //[All, Outer Ring, Inner Ring, Pointer, Handle]
//Design of the faces.
style="Spiral"; //[Fill, Spiral, Straight]
//Density of the design.
density=5; //[1:10]
month_notation=2; //[2:3-letter, 3:1-letter]
time_notation=1; //[1:Roman numerals, 2:Arabic numerals]
//Customizer currently supports all google fonts (google.com/fonts).
font_choice="Russo One";

/*[Hidden]*/
//Radius of the outer ring (ie. the whole star dial).
radius=35;
//Diameter of small stars, radius of pointer stars.
star_size=0.5;
//Removes touching faces
delta = 0.001;

month_data=[
[0, "", "", "", 0, 0],
[1, "January", "Jan", "J", 31, 31],
[2, "February", "Feb", "F", 28, 59],
[3, "March", "Mar", "M", 31, 90],
[4, "April", "Apr", "A", 30, 120],
[5, "May", "May", "M", 31, 151],
[6, "June", "Jun", "J", 30, 181],
[7, "July", "Jul", "J", 31, 212],
[8, "August", "Aug", "A", 31, 243],
[9, "September", "Sep", "S", 30, 273],
[10, "October", "Oct", "O", 31, 304],
[11, "November", "Nov", "N", 30, 334],
[12, "December", "Dec", "D", 31, 365],
];

time=[
[0, "XII", "12"],
[1, "I", "1"],
[2, "II", "2"],
[3, "III", "3"],
[4, "IV", "4"],
[5, "V", "5"],
[6, "VI", "6"],
[7, "VII", "7"],
[8, "VIII", "8"],
[9, "IX", "9"],
[10, "X", "10"],
[11, "XI", "11"],
[12, "XII", "12"],
[13, "I", "1"],
[14, "II", "2"],
[15, "III", "3"],
[16, "IV", "4"],
[17, "V", "5"],
[18, "VI", "6"],
[19, "VII", "7"],
[20, "VIII", "8"],
[21, "IX", "9"],
[22, "X", "10"],
[23, "XI", "11"]
];

module outer_ring(radius, month_notation){
    translate([0, 0, -3])
    intersection(){
        difference(){
            cylinder(r=(2*(radius/3)), h=((PI*(radius-5))/365)+3, $fn=365);
            
            translate([0,0,-delta])
            cylinder(r=6.5, h=((PI*(radius-5))/365)+3+2*delta, $fn=36);
        }
        if(style=="Fill"){
        }
        if(style=="Spiral"){
            for(i=[0:180/density:360]){
                rotate(a=i, v=[0, 0, 1])
                translate([radius/2, 0, -delta])
                difference(){
                    cylinder(r=radius/2, h=((PI*(radius-5))/365)+3+2*delta, $fn=365);
                    
                    cylinder(r=(radius/2)-2, h=((PI*(radius-5))/365)+3+2*delta, $fn=365);
                    translate([-radius, 0, 0])
                    cube([2*radius, radius, ((PI*(radius-5))/365)+3+2*delta]);
                }
            }
        }
        if(style=="Straight"){
            for(i=[0:180/density:360]){
                rotate(a=i, v=[0, 0, 1])
                translate([6, -1, 0])
                cube([2*(radius/3)-6, 2, ((PI*(radius-5))/365)+3]);
            }
        }
    }
    for (i=[0:365], l=[0:4]){
        rotate(a=(i*5*360/365)+(l*360/365), v=[0, 0, 1]){
            rotate(a=90, v=[0, 1, 0])
            translate([0, 0, radius-5])
            cylinder(d=((2*PI*(radius-5))/365), h=l+1, $fn=4);

            translate([radius-5, -((PI*(radius-5))/365), -1])
            cube([l+1, ((2*PI*(radius-5))/365), 1]);
        }
    }
    difference(){
        union(){
            translate([0, 0, -3])
            cylinder(r=radius, h=2, $fn=365);
            
            translate([0, 0, -1])
            cylinder(r=radius-5, h=((PI*(radius-5))/365)+1, $fn=365);
        }
        rotate(a=-90, v=[0, 1, 0])
        linear_extrude(h=radius)
        polygon(points=[[-2, -2], [-2, 2], [-4, 0]]);

        translate([0, 0, -3-delta])
        cylinder(r=2*radius/3, h=((PI*(radius-5))/365)+3+2*delta, $fn=365);

        for(month=[1:12]){
            for (i=[month_data[month][5]]){
                rotate(a=(i*360/365)-(180/365), v=[0, 0, 1])
                rotate(a=90, v=[0, 1, 0])
                translate([-((PI*(radius-5))/365), 0, radius/2])
                cylinder(d=((2*PI*(radius-5))/365), h=(radius/2)-5, $fn=4);
            }
            for (i=[month_data[month][5]]){
                rotate(a=(i*360/365)-(180/365)-((month_data[month][4])/2), v=[0, 0, 1])
                translate([3*(radius/4), 0, -1])
                rotate(a=-90, v=[0, 0, 1])
                linear_extrude(h=1)
                text(month_data[month][month_notation], font=str(font_choice), size=radius/10, valign="center", halign="center");
            }
        }
    }
    translate([0, 0, -3])
    difference(){
        cylinder(r=6.5, h=((PI*(radius-5))/365)+3, $fn=36);
        
        translate([0,0,-delta])
        cylinder(r=5.5, h=1+delta, $fn=36);
        
        cylinder(r=4.5, h=((PI*(radius-5))/365)+3+delta, $fn=36);
    }
}
module inner_ring(radius){
    intersection(){
        difference(){
            cylinder(r=(2*(radius/3))-(radius/6), h=2, $fn=36);
            
            translate([0,0,-delta])
            cylinder(r=6.5, h=2+2*delta, $fn=36);
        }
        if(style=="Fill"){
        }
        if(style=="Spiral"){
            for(i=[0:180/density:360]){
                rotate(a=i, v=[0, 0, 1])
                translate([radius/2, 0, 0])
                difference(){
                    cylinder(r=radius/2, h=2, $fn=36);
                    
                    translate([0,0,-delta])
                    cylinder(r=(radius/2)-2, h=2+2*delta, $fn=36);
                    
                    translate([-radius, 0, -delta])
                    cube([2*radius, radius, 2+2*delta]);
                }
            }
        }
        if(style=="Straight"){
            for(i=[0:180/density:360]){
                rotate(a=i, v=[0, 0, 1])
                translate([6, -1, 0])
                cube([radius/3, 2, 2]);
            }
        }
    }
    difference(){
        for(i=[0:23]){
            rotate(a=15*(time[i][0]), v=[0, 0, 1])
            translate([(2*(radius/3))-(radius/10), 0, 0])
            cylinder(r=radius/10, h=2, $fn=36);
        }
        for(i=[0, 1, 2, 3, 4, 5, 6, 7, 8, 16, 17, 18, 19 ,20, 21, 22, 23]){
            rotate(a=15*(time[i][0]), v=[0, 0, 1])
            translate([(2*(radius/3))-(radius/10), 0, 1])
            rotate(a=-90, v=[0, 0, 1])
            linear_extrude(h=1)
            text(time[i][time_notation], font=str(font_choice), size=radius/20, valign="center", halign="center");
        }
    }  
    difference(){
        union(){
            for (i=[65, 121.5, -90.5]){
                rotate(a=i, v=[0, 0, 1]){
                    translate([radius-5, 0, 0])
                    cylinder(r=5, h=2, $fn=36);
                    
                    translate([2*(radius/3)-2, 0, 0])
                    cube([(radius/3)-3, 5, 2]);
                }
            }
            cylinder(r=6.5, h=2, $fn=36);
        }
        union(){
            for (i=[65, 121.5, -90.5]){
                rotate(a=i, v=[0, 0, 1])
                translate([radius-10, -5, -delta])
                cube([10, 5, 2+2*delta]);
            }
            rotate(a=65, v=[0, 0, 1])
            translate([radius-9, 1.5, 2])
            ursa_major(star_size);
            
            rotate(a=121.5, v=[0, 0, 1])
            translate([radius-9, 1.5, 2])
            ursa_minor(star_size);
            
            rotate(a=-90.5, v=[0, 0, 1])
            translate([radius-9, 1, 2])
            cassiopeia(star_size);
            
            translate([0,0,-delta])
            cylinder(r=4.5, h=2+2*delta, $fn=36);
        }
    }
}
module pointer(radius){
    difference(){
        union(){
            rotate_extrude($fn=36){
                translate([-5, 0.5, 0])
                circle(d=1, $fn=36);
                
                translate([-5, 0, 0])
                square(1);
            }
            cylinder(r=4.5, h=((PI*(radius-5))/365)+6, $fn=36);
            
            translate([0, 0, ((PI*(radius-5))/365)+4])
            cube([4.5, radius, 2]);
            
            translate([0, radius, ((PI*(radius-5))/365)+4])
            cylinder(r=4.5, h=2, $fn=36);
        }
        union(){
            translate([0,0,-delta])
            cylinder(r=2.5, h=((PI*(radius-5))/365)+6+2*delta, $fn=36);
            
            for(i=[0:1]){
                rotate(a=i*90, v=[0, 0, 1]){
                    translate([-5.5, 0, 3])
                    rotate(a=90, v=[0, 1, 0])
                    cylinder(r=2, h=11, $fn=36);
                    
                    translate([-5.5, -1.5, -delta])
                    cube([11, 3, 3+delta]);
                }
            }
            translate([-4.5, radius-4.5, ((PI*(radius-5))/365)+4-delta])
            cube([4.5, 9, 2+2*delta]);
        }
    }
}
module handle(radius){
    linear_extrude(height=radius/3)
    polygon(points=[[-2, -2], [-2, 2], [-3, 1], [-3, -1]]);
    
    difference(){
        union(){
            translate([-3, 0, 5])
            cylinder(r=5, h=(radius/3)-3, $fn=36);
            
            translate([-3, 0, 5])
            sphere(r=5, $fn=36);
            
            difference(){
                translate([-3, 0, 1.5*radius])
                sphere(r=5, $fn=36);
                
                translate([-8, -5, (1.5*radius)-5])
                cube([10, 10, 5]);
            }
            if(style=="Fill"){
                translate([-3, 0, (radius/3)+2])
                cylinder(r=5, h=(1.5*radius)-(radius/3)-2, $fn=36);
            }
            if(style=="Spiral"){
                translate([-3, 0, (radius/3)+2])
                for(i=[0:360/density:360]){
                    rotate(a=i, v=[0, 0, 1])
                    linear_extrude(height=(1.5*radius)-(radius/3)-2, twist = 360)
                    translate([4, 0, 0])
                    circle(r=1, $fn=36);
                }
            }
            if(style=="Straight"){
                translate([-3, 0, (radius/3)+2])
                for(i=[0:360/density:360]){
                    rotate(a=i, v=[0, 0, 1])
                    translate([4, 0, 0])
                    cylinder(r=1, h=(1.5*radius)-(radius/3)-2, $fn=36);
                }
            }
        }
        translate([-3, -5, -delta])
        cube([5, 10, radius/3+delta]);
    }
}
module cassiopeia(star_size){
    translate([0, 3.8*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([3*star_size, 1.2*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([5.6*star_size, 2.2*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([7.9*star_size, 0, 0])
    sphere(d=1.5*star_size, $fn=36);
    
    translate([10*star_size, 2.8*star_size, 0])
    sphere(d=star_size, $fn=36);
}
module ursa_major(star_size){
    translate([0, 2*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([2.5*star_size, 2.6*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([6.2*star_size, 1.5*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([6.9*star_size, 0, 0])
    sphere(d=star_size, $fn=36);
    
    translate([9.6*star_size, 0.3*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([9.7*star_size, 2.3*star_size, 0])
    sphere(d=1.5*star_size, $fn=36);
}
module ursa_minor(star_size){
    translate([0, 1.2*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([2.4*star_size, 0.3*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([5.2*star_size, 0, 0])
    sphere(d=star_size, $fn=36);
    
    translate([7.6*star_size, 0.9*star_size, 0])
    sphere(d=star_size, $fn=36);
    
    translate([9.5*star_size, 0, 0])
    sphere(d=star_size, $fn=36);
    
    translate([9.6*star_size, 3.3*star_size, 0])
    sphere(d=1.5*star_size, $fn=36);
    
    translate([10.8*star_size, 1.6*star_size, 0])
    sphere(d=star_size, $fn=36);
}

module render_part(part){
    if(part=="All"){
        translate([-(2*(radius/3)), 0, -((PI*(radius-5))/365)])
        rotate(a=-90, v=[0, 1, 0])
        handle(radius);
        
        translate([0, 0, -((PI*(radius-5))/365)])
        outer_ring(radius, month_notation, font_choice);
        
        inner_ring(radius);
        translate([0, 0, -3])
        pointer(radius);
    }
    else if(part=="Outer Ring"){
        translate([0, 0, -((PI*(radius-5))/365)])
        outer_ring(radius, month_notation, font_choice);
    }
    else if(part=="Inner Ring"){
        inner_ring(radius);
    }
    else if(part=="Pointer"){
        translate([0, 0, -3])
        pointer(radius);
    }
    else if(part=="Handle"){
        translate([-(2*(radius/3)), 0, -((PI*(radius-5))/365)])
        rotate(a=-90, v=[0, 1, 0])
        handle(radius);
    }
}
render_part(part);
        