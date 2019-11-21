$fn=400;

hoehe = 30;
radius = 24/2;
halter_breite=24+3;
halter_hoehe=23;

module zylplushalter()
{
    linear_extrude(height = hoehe)
    {
        circle(radius + 3);
    }

    translate([-halter_breite/2, 0, 0])
    cube([halter_breite,halter_hoehe,3]);
}

difference()
{
    zylplushalter();
    
    linear_extrude(height = hoehe)
    {
        circle(radius);
    }
}

translate([-halter_breite/2,20,-20])
cube([halter_breite,3,20]);

//translate([-20,20,-20])
//cube([40,15,5]);
