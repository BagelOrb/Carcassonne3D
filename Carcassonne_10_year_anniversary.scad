use <Carcassonne_core.scad>;

use <Carcassonne_common_shapes.scad>;

use <Carcassonne_inns_and_cathedrals.scad>;

// =======================================

//  1 0  Y E A R   A N N I V E R S A R Y

// =======================================






module roundCityWall2() {

    rr = 21;

    render(convexity=2) intersection() {

        union() {

            difference() {

                translate([ 24,0,0]) 

                //rotate([0,0,360/22*16])

                cylinder(r=rr,h=8,$fn=16);

                translate([ 24,0,0]) 

                //rotate([0,0,360/22*16])

                cylinder(r=rr-2,h=12,$fn=16);

                

                for(i=[0:10])

                    translate([ 24,0,8]) rotate([0,0,360/16*(0.5+i)]) cube([60,3,2],center=true);

            }

            translate([ 20, 20]) cylinder(r=3,h=9);

            translate([ 20,-20]) cylinder(r=3,h=9);

        }

        cube([40,40,40],center=true);

    }

}















module rrrr_alt(seed=129)

{

    color([0.3,0.7,0.3]) bottom(2,2,2,2);

    roadCorner(seed+300);

    rotate([0,0,180])

    roadCorner(seed+900);

}



module rrff_cloister(seed = 188)

{

   ffrr(seed);

    translate([0,0])

    rotate([0,0,-30])

   cloister(); 

}



module cffr(seed=3) {
    color([0.3,0.7,0.3]) bottom(1,0,2,0);
    difference() {
        singleCityWall();
        translate([11.5,0,6]) cube([3,10,10],center=true);
    }
    
    translate([11.5,0,0]) gate();
    
    rotate([0,0,180]) 
    roadCorner(seed+15);

    if (seed == 1) wallTower(15);
    if (seed == 2) wallTower(-10, 1);

    offX = rands(-1.5,1.5,7*7,seed+40);
    offY = rands(-1.5,1.5,7*7,seed+41);
    rots = rands(0,360,7*7,seed+42);
    for(x=[-3:3])
            for(y=[-3:3])
                    if ((y > -2 && y < 2) && (x == 3))
                            translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                                    rotate([0,0,rots[x+3+(y+3)*7]]) house();
}




module crff(seed = 70 )
{
    color([0.3,0.7,0.3]) bottom(1,0,2,0);
    difference() {
        singleCityWall();
        translate([11.5,0,6]) cube([3,10,10],center=true);
    }
    
    translate([11.5,0,0]) gate();
    
    rotate([0,0,90]) 
    roadCorner(seed+15);

    if (seed == 1) wallTower(15);
    if (seed == 2) wallTower(-10, 1);

    offX = rands(-1.5,1.5,7*7,seed+40);
    offY = rands(-1.5,1.5,7*7,seed+41);
    rots = rands(0,360,7*7,seed+42);
    for(x=[-3:3])
            for(y=[-3:3])
                    if ((y > -2 && y < 2) && (x == 3))
                            translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                                    rotate([0,0,rots[x+3+(y+3)*7]]) house();
}





module cccf_sadface(seed=123, shield=0) {

    color([0.3,0.7,0.3]) bottom(1,1,0,1);



    rotate([0,0,  0]) roundCityWall();

    rotate([0,0,  0]) roundCityWall2();

    rotate([0,0,180]) roundCityWall();



    if (seed == 10) wallTower(10);

    if (seed == 10) rotate(180) wallTower(15);

    if (seed == 11) wallTower(25, 1);

    if (seed == 11) wallTower(-25, 1);



    render() difference() {

            if (shield) color([0.7,0.7,0.7]) translate([0,0,1]) bottom(1,1,0,1, 2);

            else color([0.7,0.7,0.7]) translate([0,0,1]) bottom(1,1,0,1, 0);

            rotate([0,0,  0]) translate([24,0,0]) cylinder(r=21,h=10,$fn=22);

            rotate([0,0,180]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);

    }

    intersection() {

        color([0.7,0.7,0.7]) translate([0,0,1]) bottom(1,1,0,1, 0);

        translate([40,0,0]) cylinder(r=29,h=10,$fn=22);

    }



    offX = rands(-1.5,1.5,7*7,seed);

    offY = rands(-1.5,1.5,7*7,seed+1);

    rots = rands(0,360,7*7,seed+2);

    for(x=[-3:3])

        for(y=[-3:3])

            if (x>-3&&x<3 && ((x>-2&&x<2) || y>2 || y<-2) && (!shield || x<1||y<2) && rands(0,1,1,seed+y*7+x*13)[0]<.4)

                translate([((x+3)/6*5-3)*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])

                    rotate([0,0,rots[x+3+(y+3)*7]]) house();

            

    for (x=[-12:9:10])

        translate([16,x]+rands(-1,1,2,seed+x+4312)) 

        rotate([0,0,rands(0,360,1)[0]])

        house();

}





module cccc_mouth(seed=213, shield=0)

{

    color([0.3,0.7,0.3]) bottom(1,1,0,0);

    cornerWall(shield);



    if (seed == 1) 

        wallTower(20);

    if (seed == 2) rotate(90) wallTower(-15, 1);

    

    if (seed == 10) rotate(90) wallTower(-20);

    if (seed == 10) wallTower(5);

    //if (seed == 11) 

        rotate(90) wallTower(0, 1);



    offX = rands(-1.5,1.5,7*7,seed);

    offY = rands(-1.5,1.5,7*7,seed+1);

    rots = rands(0,360,7*7,seed+2);

    for(x=[-3:3])

        for(y=[-3:3])

            if ((((x > -2 && (x < 2)) || (y > -2 && y < 2)) && (x == 3 || y == 3))

                    || (!shield && x > 1 && y > 1))

                translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])

                    rotate([0,0,rots[x+3+(y+3)*7]]) house();

            

            

     seed = seed+1234;

     rotate([0,0,180])

    {

            cornerWall(shield);



        //if (seed == 1) 

            wallTower(5);

        //if (seed == 2) 

            rotate(90) wallTower(-15, 1);

        

        if (seed == 10) rotate(90) wallTower(-20);

        if (seed == 10) wallTower(5);

        if (seed == 11) rotate(90) wallTower(0, 1);



        offX = rands(-1.5,1.5,7*7,seed);

        offY = rands(-1.5,1.5,7*7,seed+1);

        rots = rands(0,360,7*7,seed+2);

        for(x=[-3:3])

            for(y=[-3:3])

                if ((((x > -2 && (x < 2)) || (y > -2 && y < 2)) && (x == 3 || y == 3))

                        || (!shield && x > 1 && y > 1))

                    translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])

                        rotate([0,0,rots[x+3+(y+3)*7]]) house();

    }

}








module anniversary() {

     	translate([  0,  0]) rrrr_alt();

	translate([ 50,  0]) rrff_cloister();

	translate([100,  0]) cffr();

	translate([150,  0]) crff();



	translate([  0, 50]) cfrr(); // existing

	translate([ 50, 50]) crcr_alt(816);

	translate([100, 50]) cccf_sadface(); 

	translate([150, 50]) cccc_mouth(); 



	translate([  0,100]) crrf(); // existing

	translate([ 50,100]) cfrf(32); 

}



anniversary();






