/*
Other designs can be found here.....
If you find any of them helpfull please leave me a like :)
https://www.thingiverse.com/Ken_Applications/designs

Ken applications .... OpenSCAD version used 2019.05 

This is another openSCAD file which lets you customize your own knurled nut.
It does not use any library files only a few modules which you can use in your own projects.
I have only tested it on an M10 X 1.5mm thread and included a 0.4mm tolerance in the thread module which made a perfect fit on my Ender 3 pro.
the Knurl module that i have used comes from https://www.thingiverse.com/thing:3673637   (Big thank you for this)

Render time took about 1.5 minutes.
Print time about 12 minutes for M10 x 1.5 thread with knurled outside diameter of 20mm
*/

/* [Thread parameters are here] */

//The outside diameter of the thread.
dia=10.0;//[0:0.1:20]

// The pitch of the thread.. for example a standard M10 = 1.5mm pitch. M8 has a pitch of 1.25mm etc
pitch=1.5;//[0.5:0.1:5]

// Thread length which is the same as the overall height of the nut
thread_length=10;//[5:1:50]

//Chamfer the thread thread... both top and bottom
internal_chamfer=2.5;//[0:0.1:5]



/* [Knurl parameters are here] */

// The outside diameter of the nut...Must be bigger than the thread dia + the wall thickness
knurl_outter_dia=25;//[10:0.1:100]

//The lower the number the more coarse the knurl is. higher values will take longer to render
knurl_number=30;//[15:1:50]

//Chamfer the outside diameter i.e the knurl
external_chamfer=2.5;//[0:0.1:5]


///all the modules are below
complete_thing();//combines all the modules


module thread(){
//echo(pitch*0.614/2);
$fn=34;    
tolerance=0.4;    
dia_plus=dia+tolerance;    
depth_ratio=(pitch*0.614/2);
linear_extrude(twist=-360*(thread_length/pitch),height=thread_length)
translate([depth_ratio,0,0])
circle(d=dia_plus-pitch/2);
cylinder(  thread_length, d1=dia_plus-pitch,  d2=dia_plus-pitch ,$fn=100 );
}



module knurl(radius,ht,nf,dc,dr){
$fn=4;
deg=360/nf;
tr=PI*radius/nf;
cf=cos(180/$fn);
//echo("practical cutting depth",tr);   
if(dc>tr) echo("WARNING - cut depth exceeds practical depth",tr);
difference(){
    cylinder(r=radius,h=ht,$fn=180);
    for(j=[-1:2:1]){
        for(i=[0:nf-1]){
            translate([0,0,-0.1])
            rotate([0,0,i*deg])
            linear_extrude(height=ht+0.2,twist=dr*j)
            translate([0,radius+tr-dc*cf])
               circle(r=tr,$fn=4);
        }
    }
}
}





module chamfer_boss(chamfer,boss_dia,cylinder_hgt,both_bot_top){
if ((both_bot_top==2)||(both_bot_top==0))  mirror([0,0,1])
translate([0,0,-cylinder_hgt])
difference(){
cylinder(chamfer*0.7071,d1=boss_dia+0.3,d2=boss_dia+0.3);
translate([0,0,-0.5]) cylinder(chamfer*0.7071+1,d1=boss_dia-1-chamfer*0.7071*2,d2=boss_dia+1);
}
if ((both_bot_top==1)||(both_bot_top==0))
difference(){
cylinder(chamfer*0.7071,d1=boss_dia+0.3,d2=boss_dia+0.3);
translate([0,0,-0.5]) cylinder(chamfer*0.7071+1,d1=boss_dia-1-chamfer*0.7071*2,d2=boss_dia+1);
}
}



module chamfer_hole(chamfer,hole_dia,cylinder_hgt,center,rotx,rotz){
if (center==1) rotate (a = [rotx, 0, rotz]) translate([0,0,-cylinder_hgt/2])     {  
$fn=120;
translate([0,0,-(chamfer*0.7071)-0.5+cylinder_hgt]) cylinder((chamfer*0.7071)+1,d1=hole_dia-1,d2=hole_dia+((0.7071*chamfer)*2+1));
mirror([0,0,1]) translate([0,0,-(chamfer*0.7071+0.5)]) cylinder((chamfer*0.7071)+1,d1=hole_dia-1,d2=hole_dia+((0.7071*chamfer)*2+1));
    
cylinder(h=cylinder_hgt, r1=hole_dia/2, r2=hole_dia/2, center=false);  
 }

if (center==0) rotate (a = [rotx, 0, rotz]) translate([0,0,0])     {  
$fn=120;
translate([0,0,-(chamfer*0.7071)-0.5+cylinder_hgt]) cylinder((chamfer*0.7071)+1,d1=hole_dia-1,d2=hole_dia+((0.7071*chamfer)*2+1));
mirror([0,0,1]) translate([0,0,-(chamfer*0.7071+0.5)]) cylinder((chamfer*0.7071)+1,d1=hole_dia-1,d2=hole_dia+((0.7071*chamfer)*2+1));
    
cylinder(h=cylinder_hgt, r1=hole_dia/2, r2=hole_dia/2, center=false);  
}
 
}



module complete_thing(){
difference(){
knurl_depth= 3.14*(knurl_outter_dia/2)/knurl_number;   
knurl_angle= thread_length/ (knurl_outter_dia/2)*45;
//echo (knurl_angle);  
knurl(knurl_outter_dia/2,thread_length,knurl_number,knurl_depth/1.3,knurl_angle);
thread();
chamfer_boss(external_chamfer,knurl_outter_dia,thread_length,0);
chamfer_hole(internal_chamfer,dia-pitch,thread_length,0,0,0);
}
}

