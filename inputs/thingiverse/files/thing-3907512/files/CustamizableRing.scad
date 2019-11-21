/*
Erica Umlor's Customizable Ring for MSE4777

Created: 10/05/19
Description: This is a simple band for a nice sporty or casual look. Change the diameter, thickness and width of the ring and print! Ring size reference:

USA size    Ring diameter (mm)
    3           14.00
    3.5         14.40
    4           14.80
    4.5         15.20
    5           15.60
    5.5         16.00
    6           16.50
    6.5         16.90
    7           17.30
    7.5         17.70
    8           18.20
    8.5         18.60
    9           19.00
    9.5         19.40
    10          19.80
    10.5        20.20
    11          20.60
    11.5        21.00
    12          21.40
    12.5        21.80
    13          22.20
    13.5        22.60
    
*/

diameter = 17.3;         // Ring diameter from chart
band_thickness = 2.5;    // 2.5 is average
band_width = 4;          // Women avg = 4 mm 
                         // Men avg = 8 mm

ring();

module ring () {
    difference() {   
        outside();
        inside();
    }
}

module inside () {
    cylinder(band_width*4,diameter/2,diameter/2,center=true, $fn=100);
}

module outside () {
    minkowski() {
        cylinder(band_width,diameter/2+band_thickness,diameter/2+band_thickness,center=true, $fn=100);
        sphere(band_thickness*0.5, $fn=100);
    }
}















