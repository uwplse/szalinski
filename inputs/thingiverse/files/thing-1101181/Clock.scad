
/* [Clock] */
// Outter Radius
radius=80;

// Frame and surface's thickness
thickness=5;

// How should the hour be read?
type_of_mark = "Romans"; // [Numbers, Romans, Ticks, Dots]

/* [Time] */
//
hour=3; // From 0 to 24 h
//
minutes=27; // From 0 to 60 min

// preview[view:south, tilt:top]


clock();

module clock(){
    $fa=1;
    $fs=0.1;
    
    // Surface of the clock
	linear_extrude(height=thickness){
        circle(radius);
		}
        
    // Frame
    color("green")
    translate([0,0,thickness])
    linear_extrude(height=thickness){
        difference(){
        circle(radius);
        circle(radius-thickness);
        }
    }
    
    // Numbers, ticks...
    miR=radius-2.5*thickness;
    romans=["I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII"];
    color("red")
    for(i=[1:12])
    {
        if (type_of_mark=="Numbers"){
            linear_extrude(height=2*thickness){
                translate([miR*sin(30*i),miR*cos(30*i)])
                text(str(i),size=2*thickness,halign="center",valign="center");
            }
        }
        else if (type_of_mark=="Ticks"){
            rotate(30*i)
            translate([0,0,thickness])
            linear_extrude(height=thickness)
            polygon(points=[ [0.80*radius,-0.2*thickness],
                             [0.90*radius,-0.2*thickness],
                             [0.90*radius, 0.2*thickness],
                             [0.80*radius, 0.2*thickness]]);
        }
        else if (type_of_mark=="Dots"){
            rotate(30*i)
            translate([0.85*radius,0,thickness])
            sphere(0.5*thickness);
        }
        else if (type_of_mark=="Romans"){
            linear_extrude(height=2*thickness){
                translate([miR*sin(30*i),miR*cos(30*i)])
                text(romans[i-1],size=1.7*thickness,halign="center",valign="center");
            }
        }
    }

    
    // Define the time
    angH=hour*30+minutes*0.5;
    angM=minutes*6;
    color("DarkSlateGray")
    rotate(90-angM)
    translate([0,0,thickness])
    linear_extrude(height=0.8*thickness)
    polygon(points=[ [0,0],
                     [0.1*radius,-0.05*radius],
                     [0.75*radius,0],
                     [0.1*radius,0.05*radius]]);
    color("SlateGray")
    rotate(90-angH)
    translate([0,0,thickness])
    linear_extrude(height=0.8*thickness)
    polygon(points=[ [0,0],
                     [0.08*radius,-0.045*radius],
                     [0.50*radius,0],
                     [0.08*radius,0.045*radius]]);
    
}
