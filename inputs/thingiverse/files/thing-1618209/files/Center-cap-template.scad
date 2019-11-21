//Edit these parameters
diameter_inner = 55;    //Inner diameter of plugging hole from 10 - 98
wall_thickness = 4;     //Keep this to a sane value for good flex
tap_hight = 8;          //How far inn is the groove?
emblem_hight= 3.5;      //How thick do you want it?
faces = 30;             //how smooth do you want it?
clipthickness = 2;      //How deep is your groove?
tapsmooth = 50;         //How sharp angle do you want on your tap
clipnumbers = 6;        //Keep to even numbers
autoclipspace = ((diameter_inner * 3.14)/clipnumbers)/2;//math
clipspace = autoclipspace;//Can be replaced with guesswork.
emblem_inner = diameter_inner + 7; //Brimsize close to the hole.   
emblem_outer = diameter_inner + 2; //Brimsize close to the bottom.


//math to make scaling work.
insight_cut= diameter_inner - wall_thickness;
tap_hight_from_0 = tap_hight + emblem_hight;
total_hight = tap_hight_from_0 + 5;
clipwide = diameter_inner + clipthickness;
cylindertop = tap_hight_from_0;
cylinderbottom =  cylindertop - tapsmooth;
cutouthight = tapsmooth;
topcut = 50 + tap_hight_from_0 + 3;
block_nr = clipnumbers;
blockangle = 360 / block_nr;
audidiameter = (emblem_outer/4)/2;
ringthickness = 1* diameter_inner/60;

//Module for audi logo.
module audiring (diameter= 60, offset= 0)  {
    translate([offset,0,0]){
        rotate_extrude(convexity=10,$fn=faces)
        translate([diameter,0,0])
        circle(r=ringthickness,$fn=faces);
    }
}


difference() {
    //Basic shape
    union() {
    // Cone, face
    cylinder(d2=emblem_inner, d1=emblem_outer, h=emblem_hight, $fn=faces );
    // Cylinder, interior clip
    cylinder(d=diameter_inner, h=tap_hight_from_0);
        
    // upper wedge on clip
    translate(v=[0,0,cylindertop])
    cylinder(d2=0, d1=clipwide, h=tapsmooth);
    // lower wedge on clip
    translate(v=[0,0,cylinderbottom])
    cylinder(d1=0, d2=clipwide, h=tapsmooth);  
        



    };
    //***** Comment out if you have audi ;)*****
    //******************************************
    //audiring (audidiameter, emblem_outer/12);
    //audiring (audidiameter, emblem_outer/4);
    //audiring (audidiameter, -emblem_outer/12);
    //audiring (audidiameter, -emblem_outer/4);
    //******************************************
    
    //************ Text example ****************
    //******************************************
    //translate([20, -emblem_outer/3, 0])
    //mirror([1,0,0]){
    //linear_extrude(0.4)
    //    text("TEXT-Example", size = 4);
    //}
    //******************************************
    
    
    // Cut out the interior of interior clip
    translate(v=[0,0,emblem_hight])
        cylinder( d=insight_cut, h=cutouthight);
    // Slice off top and bottom of the cap
    translate([0,0,-50])
        cube(center=true,[clipwide,clipwide,100]);
    translate([0,0,topcut])
        cube(center=true,[clipwide,clipwide,100]);
    
    
    //Function for getting scalable clip's
        for( i = [0:block_nr]) {
        rotate(a=[0,0,blockangle*i])
            translate([0, 0, 30])
                cube(center=true,[100, clipspace, 50]);
            
    };
       
}