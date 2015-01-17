
use <Carcassonne_core.scad>;

module cooo(seed=0, shield = 0) {
	singleCityWall();

	if (seed == 1) wallTower(15);
	if (seed == 2) wallTower(-10);
	if (seed == 3) wallTower(20, 1);
	if (seed == 4) wallTower( 15);
	if (seed == 4) wallTower(-15);

	offX = rands(-1.5,1.5,7*7,seed+30);
	offY = rands(-1.5,1.5,7*7,seed+31);
	rots = rands(0,360,7*7,seed+32);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}


module fence(amax=360, steps = 10, r = 10, seed =623) {
    xoff = rands(-1,1,steps+1,seed);
    yoff = rands(-1,1,steps+1,seed+steps*2);
    linear_extrude(height=1.5)
    for (i=[0:steps-1])
        hull() {
            translate([r*sin(i/steps*amax) + xoff[i], r*cos(i/steps*amax) + yoff[i] ])
            circle(r=.3);
            translate([r*sin((i+1)/steps*amax) + xoff[i+1], r*cos((i+1)/steps*amax) + yoff[i+1] ])
            circle(r=.3);
        }
    
}




module farmhouse() {

    translate([-2,-2])

    difference() 

    {

        union(){

            cube([4,4,2]);

            translate([2,4,2])

            rotate([90,0])

            linear_extrude(height=4)

            polygon([[-2,0],[2,0],[0,1]]);

        }

        translate([1,-1,0])

        cube([1,2,1.5]);

        translate([1,3,0])

        cube([1,2,1.5]);

    }

}


module farm(seed= 1243) {
    farmhouse();
    translate([0,-8])
    rotate([0,0,-10])
    fence(amax=340, steps = 8, r=8);
    
}

module gate() {
    difference() {
        union() {
            translate([0,0,4]) cube([2,8,8],center=true);
        }
        translate([0,0,4]) 
        rotate([0,90])
        hull() {
            intersection() { 
                translate([0,1]) cylinder(h=6,r=3,center=true); 
                translate([0,-1]) cylinder(h=6,r=3,center=true); }
            translate([4,0]) cube([4,4,6],center=true);
        }
    }
    

    translate([0,4]) { cylinder(h=12, r=2); translate([0,0,12]) cylinder(h=2, r1=2, r2=1); }
    translate([0,-4]) { cylinder(h=12, r=2); translate([0,0,12]) cylinder(h=2, r1=2, r2=1); }
    
    hull() {
        translate([0,-4,8]) cylinder(h=1,r1=1,r2=0,$fn=4);
        translate([0,4,8]) cylinder(h=1,r1=1,r2=0,$fn=4);
    }

}

module mountain(radius, height, peekedness = .8) {
    rotate_extrude(convexity = 10, $fn = 12)
    polygon(points = [for (i = [-3:.2:1]) [
        (i>0.01)? 0 : i/3*radius,
        (i>0.01)? 0 : height * pow(exp(-i*i),peekedness)     ]     ]); 
    
    
}








