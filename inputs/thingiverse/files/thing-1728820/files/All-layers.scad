//Variables

// Which one would you like to see?
part = "Base"; // [Base:Base Layer,Upper:Upper Layer]


number="11";
    

n=str(number);

print_part();

module print_part() {
	if (part == "Base") {
		base();
	} else if (part == "Upper") {
		upper();
	} 
}    

module base() {
    difference() {
        color( "white", 1 ) {
            linear_extrude(height = 6, center = true, convexity = 10, twist = 0)
            scale([1.5,1])circle(d=150,$fn=360);  
        }
    translate([0,0,3])
    linear_extrude(height = 8, center = true, convexity = 10, twist = 0)
    scale([1.5,1])circle(d=141,$fn=360);  

    translate ([95,0,0])
    cylinder(h=15, d=3, center=true);

    translate ([-95,0,0])
    cylinder(h=15, d=3, center=true);

    }
    color( "white", 1 ) {
    translate ([0,0,-2])
    linear_extrude(height = 14,center=false, convexity = 10, twist = 0,$fn = 360)
    if (len(n)<2) {
        text(text=n,  font="Helvetica:style=Bold",size = 100,halign="center",valign="center");}
    else if (len(n)<3) {
        text(text=n,  font="Helvetica:style=Bold",size = 85,halign="center",valign="center");}
    else if (len(n)<4) {
        text(text=n,  font="Helvetica:style=Bold",size = 65,halign="center",valign="center");}
   else if (len(n)<5) {
        text(text=n,  font="Helvetica:style=Bold",size = 50,halign="center",valign="center");}
   else if (len(n)<6) {
        text(text=n,  font="Helvetica:style=Bold",size = 40,halign="center",valign="center");}
   else {
       text(text="MAX LEN!!",  font="Helvetica:style=Bold",size = 20,halign="center",valign="center");}
    
    }
}

module upper() {
    difference() {
        color( "blue", 1 ) {
            linear_extrude(height = 4, center = true, convexity = 10, twist = 0)
            scale([1.5,1])circle(d=140,$fn=360); 
        }
        translate ([95,0,0])
        cylinder(h=15, d=5, center=true);

        translate ([-95,0,0])
        cylinder(h=15, d=5, center=true);

        translate ([0,0,-7])
        linear_extrude(height = 14,center=false, convexity = 10, twist = 0,$fn = 360)
        if (len(n)<2) {
            text(text=n,  font="Helvetica:style=Bold",size = 100,halign="center",valign="center");}
        else if (len(n)<3) {
            text(text=n,  font="Helvetica:style=Bold",size = 85,halign="center",valign="center");}
        else if (len(n)<4) {
            text(text=n,  font="Helvetica:style=Bold",size = 65,halign="center",valign="center");}
        else if (len(n)<5) {
            text(text=n,  font="Helvetica:style=Bold",size = 50,halign="center",valign="center");}
        else if (len(n)<6) {
            text(text=n,  font="Helvetica:style=Bold",size = 40,halign="center",valign="center");}
        else {
            text(text="MAX LEN!!",  font="Helvetica:style=Bold",size = 20,halign="center",valign="center");}

    }
}


