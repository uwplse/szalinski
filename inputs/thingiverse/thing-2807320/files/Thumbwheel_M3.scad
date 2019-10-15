epsilon = 0.01;

$fn = 32;

//rotate ([180, 0, 0])
screwgrip ();

module screwgrip ()
{
    difference ()
    {
        union ()
        {
            cylinder (d1 = 8, d2 = 8, h = 3);

            hull ()
            {
                translate ([0, 0, 3])
                cylinder (d1 = 8, d2 = 8, h = epsilon);
                
                translate ([0, 0, 6])
                cylinder (d = 12, h = 2, $fn = 6);
            }
            
            hull ()
            {
                translate ([0, 0, 6])
                cylinder (d = 12, h = 2, $fn = 6);
                
                translate ([0, 0, 8])
                cylinder (d = 8, h = 2, $fn = 6);
                
                
            }
        }
        
        epzstep (1)
        cylinder (d = 4, h = 10);
        
        translate ([0, 0, 7])
        cylinder (d = 6, h = 10);
        
    }
}

module epzstep (n)
{
    translate ([0, 0, -n * epsilon])
    children ();
}