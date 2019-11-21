//Specify the distance between the centers of the inserts
wrench_length = 50;

//The size of the insert on the right side
insert_size_a = 5.5;

//The size of the insert on the left side
insert_size_b = 7.66;

// preview[view:south, tilt:top]

/* [hidden] */
wrench_thickness = (insert_size_a + insert_size_b) / 4;
offset = wrench_thickness;

module insert(insert)
{
    /*
    linear_extrude(height=10,convexity=10)
    polygon(points=[[-insert/2,0],[0,insert/2],[insert+wrench_thickness,insert/2],[insert+wrench_thickness,-insert/2],[0,-insert/2]]);
    */
    
    union()
    {
        translate([-insert/2,-insert/2,0])
        cube([insert + wrench_thickness,insert,wrench_thickness+1]);
        
        translate([-insert/2,0,0])
        scale([1.25 + insert/20,insert/2,1])
        cylinder(r=1,h=wrench_thickness+1,$fn=44);
    }
}

difference()
{
    hull()
    {
        translate([wrench_length/2,0,0])
        scale([1,1 + insert_size_a/20,1])
        cylinder(r=insert_size_a/2 + wrench_thickness,h=wrench_thickness,$fn=insert_size_a*10);

        translate([wrench_length/2 - insert_size_a,-(insert_size_a + insert_size_b)/4,0])
        cube([1,(insert_size_a*1.05 + insert_size_b*1.05)/2,wrench_thickness]);
    }

    translate([wrench_length/2 + offset,offset/2,-0.5])
    rotate([0,0,30])
    {
        insert(insert_size_a);
    }
}

difference()
{
    hull()
    {
        translate([-wrench_length/2,0,0])
        scale([1,1 + insert_size_b/20,1])
        cylinder(r=insert_size_b/2 + wrench_thickness,h=wrench_thickness,$fn=insert_size_b*10);

        translate([-(wrench_length/2 - insert_size_b),-(insert_size_a + insert_size_b)/4,0])
        cube([1,(insert_size_a*1.1 + insert_size_b*1.1)/2,wrench_thickness]);
    }
    
    translate([-wrench_length/2 - offset, -offset/2,-0.5])
    rotate([0,0,30 + 180])
    {
        insert(insert_size_b);
    }
}

hull()
{
    translate([wrench_length/2 - insert_size_a,-(insert_size_a + insert_size_b)/4,0])
    cube([1,(insert_size_a*1.1 + insert_size_b*1.1)/2,wrench_thickness]);

    translate([-(wrench_length/2 - insert_size_b),-(insert_size_a + insert_size_b)/4,0])
    cube([1,(insert_size_a*1.1 + insert_size_b*1.1)/2,wrench_thickness]);
}