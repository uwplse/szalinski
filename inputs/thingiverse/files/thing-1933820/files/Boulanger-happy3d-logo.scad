ville = "Paris";

 

module object1(scale) {polyhedron(






rotate([0,0,0])
{
    // Entrer le nom de la ville ici
        

        linear_extrude(height=20)
    {
        translate([-235,-38,7]) scale([2,2,0]) rotate([0,0,0]) text(ville);
    }
        object1(1);
}