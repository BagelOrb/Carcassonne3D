use <Carcassonne_core.scad>;






// ============================

//   M I N I   E X P A N S I O N

// ============================



 
module crcf(seed=12,shield=1) {
    color([0.3,0.7,0.3]) bottom(2,1,0,1);

    difference() {
        union() {
            rotate([0,0,  0]) roundCityWall();
            rotate([0,0,180]) roundCityWall();
        }
       translate([11.5,0,6]) cube([3,10,10],center=true);
    }
    translate([11.5,0,0]) gate();
  
    
 
    if (seed == 10) wallTower(10);
    //if (seed == 10) 
        rotate(180) wallTower(30);
    //if (seed == 11) 
        wallTower(25, 1);
    //if (seed == 11) 
        wallTower(-25, 1);

    render() difference() {
            if (shield) color([0.7,0.7,0.7]) translate([0,0,1]) bottom(0,1,0,1, 2);
            else color([0.7,0.7,0.7]) translate([0,0,1]) bottom(0,1,0,1, 0);
            rotate([0,0,  0]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
            rotate([0,0,180]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
    }

    offX = rands(-1.5,1.5,7*7,seed);
    offY = rands(-1.5,1.5,7*7,seed+1);
    rots = rands(0,360,7*7,seed+2);
    for(x=[-3:3])
        for(y=[-3:3])
            if (x>-3&&x<3 && ((x>-2&&x<2) || y>2 || y<-2) && (!shield || x<1||y<2))
                translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                    rotate([0,0,rots[x+3+(y+3)*7]]) house();

    intersection() {
        rotate([0,0,90]) road(3);
        translate([20,0,0]) cube([40,40,40],center=true);
    }
}

module crcr_plain(seed=0) {
	color([0.3,0.7,0.3]) bottom(1,2,1,2);

	singleCityWall();
	rotate([0,0,180]) singleCityWall();

	if (seed == 1) wallTower(15);
	if (seed == 2) wallTower(20, 1);
	if (seed == 2) rotate(180) wallTower(25);

	offX = rands(-1.5,1.5,7*7,seed+20);
	offY = rands(-1.5,1.5,7*7,seed+21);
	rots = rands(0,360,7*7,seed+22);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3 || x == -3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
                        
         road(seed+623);
}

module crrr_alt(seed=217) {
    color([0.3,0.7,0.3]) bottom(1,2,2,2);
    roadCorner(seed+604);
    rotate([0,0,180]) roadCorner(seed+300);
        
    difference() {
        singleCityWall();
        translate([11.5,0,6]) cube([3,10,10],center=true);
    }
    
    translate([11.5,0,0]) gate();
    

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
module plate1_mini_expansion() {
	translate([  0,  0]) crcf();
	translate([ 50,  0]) crcr_plain();
	translate([100,  0]) crrr_alt();
//	translate([150,  0]) ????;
//
//	translate([  0, 50]) ();
//	translate([ 50, 50]) ????;
//	translate([100, 50]) ????;
//	translate([150, 50]) ????;
//
//	translate([  0,100]) ????;
//	translate([ 50,100]) ????;
//	translate([100,100]) ????;
//	translate([150,100]) ????;
//
//	translate([  0,150]) ????;
//	translate([ 50,150]) ????;
//	translate([100,150]) ????;
//	translate([150,150]) ????;
}


plate1_mini_expansion();

//fwfw();
//crrr_alt();




//bottom(0,0,0,0);

//length =20;
//max = 3;
//width = 10;
//height = 10;
//list = [ for (i = [-length:1]) (i==1)? [0,0] : [i/length*width, exp(pow(i/length*max,3)) *height ] ];
//
//
//
//
//rs = rands(-.5,.5,11);
//
//scale([1,1,4])
//rotate([0,90,0])
//rotate_extrude(convexity = 10, $fn = 20)
//union() {
//    intersection() {
//        for (i= [0:9])
//            translate([rs[i],rs[i+1]])
//            scale([1,.1])
//            circle(r=1);
//        translate([0,-5]) 
//        square([10,10]);
//    }
//}










