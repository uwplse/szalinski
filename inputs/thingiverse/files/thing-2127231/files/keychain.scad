//Base thickness
depth_base = 4; //[1:1:10]
//Text thickness
depth_text = 3; //[1:1:10]
//Keychain width
width = 70; //[20:10:150]
//Keychain height
height = 20; //[5:5:100]
//Corner radius
r = 8; //[1:50]
//Custom Name
name = "Name";

translate([0,0,depth_base/2])
difference(){
union(){
    if(2*r<height)
        hull()
            for(i=[-1,1])
                for(j=[-1,1])
                    translate([i*(width/2 - r), j*(height/2 - r) ,0])
                        cylinder(h = depth_base, r = r, center = true, $fn=48);
    else
        hull()
            for(i=[-1,1])
                translate([i*(width/2 - r), 0 ,0])
                    cylinder(h = depth_base, r = r, center = true, $fn=48);
    translate([4,0,0])    
        linear_extrude(depth_base/2+depth_text)
            text(name, size = height-6, valign="center",halign="center");
}
translate([-width/2+7,0,0])
    cylinder(h = depth_text+depth_base+10, d = 6, center = true, $fn=48);
}