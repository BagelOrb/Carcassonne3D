use <Carcassonne_core.scad>;

use <Carcassonne_common_shapes.scad>;

// ======================================================

//  L I T T L E   B U I L D I N G S   E X P A N S I O N

// ======================================================








module nice_house()

{

    difference() 

    {

        union() {

            translate([3,6,2.5]) cube([4,4,5],center=true);

            translate([0,0,4]) cube([10,10,8],center=true);

            intersection() {

                hull() {

                    translate([0,0,10]) rotate([0,0,45]) 

                        cylinder(h=4,r1=sqrt(2)*5, r2=0, $fn=4, center=true);

                    translate([-10,0,10]) rotate([0,0,45]) 

                        cylinder(h=4,r1=sqrt(2)*5, r2=0, $fn=4, center=true);

                }

                cube([10,10,30],center=true);

            }

            translate([-5,-2,5]) 

            scale([.5,1,1])

            rotate([0,0,45]) 

                cylinder(h=1,r1=sqrt(2)*2, r2=0, $fn=4, center=true);

            

            

            translate([-6,-1]) cube([2,1,4.5]);

            translate([-6,-4]) cube([2,1,4.5]);

            

            translate([4,0]) cube([1,10,3]);

            translate([-10,9]) cube([15,1,3]);

            translate([-10,0]) cube([1,9,3]);

            translate([-10,-5]) cube([15,1,3]);

            translate([-10,-4,2]) cube([1.5,1.5,4],center=true);

            translate([-10,0,2]) cube([1.5,1.5,4],center=true);

        }

        

        //front

        translate([-8,-3]) cube([4,2,4]);

        translate([-8,1,1.5]) cube([4,2,2]);

        translate([-8,1,5]) cube([4,2,2]);

        translate([-6,0,9]) rotate([0,90]) cylinder(h=4,r=1, center=true); //cube([4,2,2]);

        

        //back

        translate([4,1]) cube([4,2,4]);

        translate([4,-3,1.5]) cube([4,2,2]);

        translate([4,-3,5]) cube([4,2,2]);

        

        //sides

        translate([-1,-8,5]) cube([2,4,2]);

        translate([-2,-8,1.5]) cube([4,4,2]);

        translate([-2,4,1.5]) cube([2,4,2]);

        translate([-2,4,5]) cube([2,4,2]);

        

    }

}








module little_buildings() // small expansion

{

    sf1=1.5;

    for (x = [0:5])

        translate([x*20 - 20,0,0]) scale([sf1,sf1,sf1]) wallTower();

    sf2=3;

    for (x = [0:5])

        translate([x*20,10,0]) scale([sf2,sf2,sf2]) farmhouse();

    sf3=1;

    for (x = [0:5])

        translate([x*20,30,0]) scale([sf3,sf3,sf3]) nice_house();

    

    

}

little_buildings();






