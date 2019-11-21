//new winkel

// ************* Declaration part *************

// material strength
thickness=3;

//width of the angle
width=60;

//each side can be tuned to its own length
y_lenght1=30;
y_lenght2=30;

//amount of screws vertical
screws_y_vertical=1;

//amount of screws horizontal
screws_x_horizontal=3;

// campher of side 1
screw_campher_side1="inside";  //[outside:Outside, inside:Inside , none:None ]

//campher of side 2
screw_campher_side2="inside";  //[outside:Outside, inside:Inside , none:None ]

screw_campher_radius=3;
screw_campher_height=2;
screw_campher_radius_lower=3; //set this value equal to "screw_campher_radius" or "screw_radius". Setting it to screw_radius wil lcreate a campher, setting it to "screw_campher_radius" will create a cylindric hole 

screw_distance_border_left_right=8; // important: if only 1 screw vertical is set, then this valus defines where this single screw is set. if you want it in the middle, then set it to "width/2"
screw_distance_top=10;
screw_distance_bottom1=6; // important: if only 1 screw horizontal is set, then this valus defines where this single screw is set. if you want it in the middle, then set it to "y_lenght1/2"
screw_distance_bottom2=10; // important: if only 1 screw horizontal is set, then this valus defines where this single screw is set. if you want it in the middle, then set it to "y_lenght1/2"
screw_radius=2;
amount_extra_strong=4;  // set higher value as zero to make extra strong
extra_strong_thickness=3;



module extra_stark () {
    step = (amount_extra_strong>1) ? (width-amount_extra_strong*extra_strong_thickness)/(amount_extra_strong-1):1;

    
    d=[[0,0],[y_lenght2-thickness,0],[0,y_lenght1-thickness]];
    for (x=[0:amount_extra_strong-1])
            translate ([x*(step+extra_strong_thickness)+extra_strong_thickness,y_lenght1-thickness,0]) 
                rotate ([0,90,180]) 
                linear_extrude (height=extra_strong_thickness) polygon (d);
}



module side (lenght,campher,screw_distance_bottom) {
    difference () {
    screw_step_y = (screws_y_vertical>1) ? (lenght-screw_distance_top-screw_distance_bottom)/(screws_y_vertical-1):0;
    screw_step_x = (screws_x_horizontal>1) ? (width-2*screw_distance_border_left_right)/(screws_x_horizontal-1):0;
    echo ("length",lenght,"width",width,"screw_step_y",screw_step_y,"screw_step_x",screw_step_x);
    cube ([width,lenght,thickness]);
    
    for (y=[0:screws_y_vertical-1])
         for (x=[0:screws_x_horizontal-1]) {
             echo (lenght,y,x);
            translate ([screw_distance_border_left_right+x*screw_step_x,screw_distance_bottom+y*screw_step_y,0]) 
                {
                    //screw
                    cylinder (r=screw_radius,h=thickness,$fn=20);
                    //campher
                    if (campher=="outside") translate ([0,0,thickness-screw_campher_height]) cylinder (r1=screw_campher_radius_lower,r2=screw_campher_radius,h=screw_campher_height,$fn=20);
                    if (campher=="inside") cylinder (r2=screw_campher_radius_lower,r1=screw_campher_radius,h=screw_campher_height,$fn=20);
                    } //end translate               
          } //end x-loop
    } //end diff
} //end

module winkel () {
    side (y_lenght1,screw_campher_side1,screw_distance_bottom1);
    translate ([0,y_lenght1-thickness,-y_lenght2+thickness]) mirror ([0,1,0]) rotate ([90,0,0]) side (y_lenght2,screw_campher_side2,screw_distance_bottom2);
}


//main
winkel ();
if (amount_extra_strong>0) extra_stark ();


