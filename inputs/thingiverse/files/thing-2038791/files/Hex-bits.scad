// Hex bits

bit_type = "Hex"; // [Hex, Double Hex, Hex Socket, Square, Square Socket, Double Square, Star]
magnet_slot = "false"; // [true, false]
magnet_diameter = 6;
magnet_height = 3;
sizes = [1.5,2,2.5,3,4,5];
number = len(sizes);
bit_size = 7;
tip_length = 6;
bit_length = 14;
bit_spacing = 2;
xc = number;
yc = round(sqrt(number));
count = number;

if(bit_type == "Hex"){
    build_hex();
}

else if(bit_type == "Hex Socket"){
    build_hex_socket();
}

else if(bit_type == "Double Hex"){
    build_dbl_hex();
}


else if(bit_type == "Square"){
    build_square();
}


else if(bit_type == "Square Socket"){
    build_square_socket();
}


else if(bit_type == "Double Square"){
    build_dbl_square();
}

if(bit_type == "Star"){
    build_star();
}

module build_hex(){
     
    for (x = [0:xc-1]){
    for(y = [0:yc-1]){
    county = count-y;
    if(county > 0){
    difference(){
        union(){
    
    base(x,y);
    sizes = sizes*1.16;
    translate([x*(bit_size+bit_spacing), y*(bit_size+bit_spacing), tip_length+bit_length]) scale([1,1,.5]) sphere($fn=6,d=sizes[y+(yc*x)]);
    
    translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) linear_extrude (height = tip_length, center = false, convexity = 10) polygon(ngon(6, sizes[y+(yc*x)]/2));
    
    }
    notch_cut(x, y);
    }
}
}
count = count-x*yc;
}
}

module build_hex_socket(){
    for (x = [0:xc-1]){
    for(y = [0:yc-1]){
    county = count-y;
    if(county > 0){
        sizes = sizes*1.16;
    difference(){
    union(){
    base(x,y);
    translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length+1]) linear_extrude (height = tip_length, center = false, convexity = 10) polygon(ngon(30, sizes[y+(yc*x)]/2+1));
    
        translate([x*(bit_size+bit_spacing), y*(bit_size+bit_spacing), bit_length+2]) scale([1,1,.5]) sphere($fn=6,d=sizes[y+(yc*x)]);
    }
    
    translate([x*(bit_size+bit_spacing), y*(bit_size+bit_spacing), bit_length+2]) scale([1,1,.5]) sphere($fn=6,d=sizes[y+(yc*x)]);
    
    translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length+2]) linear_extrude (height = tip_length, center = false, convexity = 10) polygon(ngon(6, sizes[y+(yc*x)]/2));
    notch_cut(x, y);
    }
    echo(county, "add");
}
echo(count);
}
count = count-x*yc;
}
}

module build_dbl_hex(){
    
    for (x = [0:xc-1]){
    for(y = [0:yc-1]){
    county = count-y;
    if(county > 0){
    difference(){
        union(){
    base(x,y);
   sizes = sizes*1.16;
    translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) linear_extrude (height = tip_length, center = false, convexity = 10) polygon(ngon(6, sizes[y+(yc*x)]/2));
        translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) rotate(90) linear_extrude (height = tip_length, center = false, convexity = 10) polygon(ngon(6, sizes[y+(yc*x)]/2));
    }
    notch_cut(x,y);
}
    echo(county, "add");
}
echo(count);
}
count = count-x*yc;
}
}

module build_square(){
for (x = [0:xc-1]){
    for(y = [0:yc-1]){
    county = count-y;
    if(county > 0){
    difference(){
        union(){
        base(x,y);
       sizes = sizes*1.1;
        translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) linear_extrude (height = tip_length, center = false, convexity = 10) rotate(45) polygon(ngon(4, sizes[y+(yc*x)]/2));  
    }
    notch_cut(x,y);
    }
    echo(county, "add");
}
echo(count);
}
count = count-x*yc;
}

}

module build_square_socket(){
    for (x = [0:xc-1]){
    for(y = [0:yc-1]){
    county = count-y;
    if(county > 0){
    difference(){
    union(){
    base(x,y);
        sizes = sizes*1.1;
    translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length+1]) linear_extrude (height = tip_length, center = false, convexity = 10) polygon(ngon(30, sizes[y+(yc*x)]/2+1));
    
        translate([x*(bit_size+bit_spacing), y*(bit_size+bit_spacing), bit_length+2]) scale([1,1,.5]) sphere($fn=6,d=sizes[y+(yc*x)]);
    }
    
    translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length+2]) linear_extrude (height = tip_length, center = false, convexity = 10) rotate(45) polygon(ngon(4, sizes[y+(yc*x)]/2));
    
    notch_cut(x, y);
    }
    echo(county, "add");
}
echo(count);
}
count = count-x*yc;
}
}

module build_dbl_square(){
for (x = [0:xc-1]){
    for(y = [0:yc-1]){
    county = count-y;
    if(county > 0){
    difference(){
        union(){
        base(x,y);
        sizes = sizes*1.1;
        translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) linear_extrude (height = tip_length, center = false, convexity = 10) rotate(45) polygon(ngon(4, sizes[y+(yc*x)]/2)); 
        translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) linear_extrude (height = tip_length, center = false, convexity = 10) polygon(ngon(4, sizes[y+(yc*x)]/2)); 
    
    }
    notch_cut(x,y);
    }
    echo(county, "add");
}
echo(count);
}
count = count-x*yc;
}

}

module base(x,y){
   
       difference(){
        union(){
    if(bit_type == "Hex Socket" || bit_type == "Square Socket"){
        translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) cylinder($fn=6, height = 1, r1 = bit_size*1.16/2, r2 = sizes[y+(yc*x)]/2+1);
    }
    else{
     translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) cylinder($fn=6, height = 1, r1 = bit_size*1.16/2, r2 = sizes[y+(yc*x)]/2);
    }
    linear_extrude(height = bit_length,     center = false) translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),0]) polygon(ngon(6, bit_size*1.16/2));
}
 if(magnet_slot == "true"){
            translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),1]) cylinder($fn=30, height = magnet_height+.4, r1 = magnet_diameter/2+.2, r2 = magnet_diameter/2+.2);
        }

}
}
module build_star(){
    
    for (x = [0:xc-1]){
    for(y = [0:yc-1]){
    county = count-y;
    if(county > 0){
    difference(){
        union(){
    base(x,y);
   sizes = sizes*1.16;
    translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) linear_extrude (height = tip_length, center = false, convexity = 10) polygon(ngon(3, sizes[y+(yc*x)]/2));
        translate([x*(bit_size+bit_spacing),y*(bit_size+bit_spacing),bit_length]) rotate(180) linear_extrude (height = tip_length, center = false, convexity = 10) polygon(ngon(3, sizes[y+(yc*x)]/2));
    }
    notch_cut(x,y);
}
    echo(county, "add");
}
echo(count);
}
count = count-x*yc;
}
}

module notch_cut(x, y){
    // Notch Cut
        translate([x*(bit_size+bit_spacing)-bit_size/2,y*(bit_size+bit_spacing),bit_length/2]) rotate([45, 45, 45])cube(size = .2, center = true);
    translate([x*(bit_size+bit_spacing)+bit_size/2,y*(bit_size+bit_spacing),bit_length/2]) rotate([45, 45, 45])cube(size = .2, center = true);
        translate([x*(bit_size+bit_spacing)-bit_size/4,y*(bit_size+bit_spacing)-bit_size/2.3,bit_length/2]) rotate([45, 45, 45])cube(size = .2, center = true);
    translate([x*(bit_size+bit_spacing)+bit_size/4,y*(bit_size+bit_spacing)+bit_size/2.3,bit_length/2]) rotate([45, 45, 45])cube(size = .2, center = true);
    translate([x*(bit_size+bit_spacing)+bit_size/4,y*(bit_size+bit_spacing)-bit_size/2.3,bit_length/2]) rotate([45, 45, 45])cube(size = .2, center = true);
    translate([x*(bit_size+bit_spacing)-bit_size/4,y*(bit_size+bit_spacing)+bit_size/2.3,bit_length/2]) rotate([45, 45, 45])cube(size = .2, center = true);
}
function ngon(num, r) = 
    [for (i=[0:num-1], a=i*360/num) [ r*cos(a), r*sin(a)]];