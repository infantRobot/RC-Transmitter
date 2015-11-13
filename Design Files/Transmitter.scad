//gimbal();

//switchFlick();
//POT();
//LCD();
tranX = 150;
tranY = 150;

thick = 2;

renderFN = 64;
$fn = 24;

difference() 
{
	union() 
	{
		translate([10,0,thick/2])
			cube([tranX, tranY, thick], center = true);
		
		radius = 10;
		translate([10,tranY/2,-(radius-thick)])
			side(150,0);
		translate([-tranX/2+10,0,-(radius-thick)])
			side(150,90);
		translate([10,-tranY/2,-(radius-thick)])
			side(150,180);
		translate([(tranX/2+10),0,-(radius-thick)])
			side(150,270);
		
		for (i = [-1,1]) {
			for (j = [-1,1]) {
				translate([tranX/2*i+10, tranY/2*j,-10+thick])
					difference()
					{
						sphere(r=10, $fn = renderFN);
						translate([0,0,-15])
							cube([30,30,30], center=true);
						translate([-15*i,-15*j,-.1])
							cube([30,30,30], center=true);
					}
			}
		}
		
		
		hull() 
		{
			translate([gimX, gimY, -4])
				cylinder(r=gimCirR, h=4);
			translate([gimX, -gimY, -4])
				cylinder(r=gimCirR, h=4);
		}
		
		
		translate([lcdX,0,-2.5])
			cube([38,82,5], center = true);
		
		translate([switchX,-switchS*1, -1.5])
			cylinder(r=9, h=1.5);
		translate([switchX,switchS*1, -1.5])
			cylinder(r=9, h=1.5);
	}
	gimX = 5;
	gimY = 40;
	gimCirR = 82/2;
	translate([gimX, gimY, -3.9])
		gimbal();
	translate([gimX, -gimY, -3.9])
		gimbal();
	
	lcdX = 65;
	translate([lcdX,0,-4.9])
		LCD();
	
	switchX = -50;
	switchS = 20;
	translate([switchX,-switchS*1, -1.5])
		POT();
	translate([switchX,-switchS*2, -1.5])
		switchFlick();
	translate([switchX,-switchS*3, -1.5])
		switchFlick();
	translate([switchX,switchS*1, -1.5])
		POT();
	translate([switchX,switchS*2, -1.5])
		switchFlick();
	translate([switchX,switchS*3, -1.5])
		switchFlick();
	
	buttonS = 4.6+6;
	buttonX = 53;
	buttonY = 50;
	buttonZ = 1;
	for(i = [0,1,2])
	{
		translate([buttonS*i+buttonX, buttonY, buttonZ])
			#button();
	}
	for(i = [0,1,2])
	{
		translate([buttonS*i+buttonX, -buttonY, buttonZ])
			#button();
	}
	
	ledR = 1.7;
	ledH = 8;
	ledX = -5;
	ledY = 5;
	ledZ = -5;
	translate([ledX,ledY, ledZ])
		cylinder(r1=ledR+.3, r2=ledR, h=ledH);
	translate([ledX,-ledY, ledZ])
		cylinder(r1=ledR+.3, r2=ledR, h=ledH);
	
	onOffX = 9;
	onOffY = 4.2;
	onOffPlace = 12;
	
	translate([onOffPlace,ledY, 0])
		cube([onOffX,onOffY,12], center = true);
	translate([onOffPlace,-ledY, 0])
		cube([onOffX,onOffY,12], center = true);
	
	for(a = [0:5])
	{
		for (i = [-1,1]) {
			translate([a*30-64, i*(tranY/2+4),-12])
				#cylinder(r=1.4, h=8, $fn=12);
			translate([i*(tranX/2+4)+10, a*30-tranY/2,-12])
				#cylinder(r=1.4, h=8, $fn=12);
		}
	}
}


//*/
module side(length, rot = 0)
{
	rad = 10;
	rotate([0,-90,rot])
	translate([0,0,-length/2])
	difference()
	{
		cylinder(r=rad, h=length, $fn = renderFN);
		
		aaa = 200;
		translate([-aaa, -aaa/2,-.1])
			cube([aaa,aaa,length*1.2]);
		translate([-aaa/2, -aaa,-.1])
			cube([aaa,aaa,length*1.2]);
	}
}
module button() 
{
	translate([0,0,-2])
		cube([6.2,6.2,4],center=true);
	cylinder(r=3.6/2, h= 1.6);
}

module LCD() 
{
	
	pcbX = 36;
	pcbY = 80;
	pcbZ = 2;
	
	holeR = 2.8/2;
	holeOff = 1;
	
	lcdX = 25;
	lcdY = 72;
	lcdZ = 7;
	
	lcdL = 18;
	lcdLH = 3.6;
	
	translate([0,0,-pcbZ/2])
		cube([pcbX,pcbY,pcbZ], center= true);
	translate([0,0,lcdZ/2])
		cube([lcdX,lcdY,lcdZ], center= true);
	translate([0,lcdY/2,lcdLH/2])
		cube([lcdL,pcbY-lcdY,lcdLH], center= true);
		
	for (i = [-1,1]) {
		for (j = [-1,1]) {
			translate([i*(pcbX/2-holeOff-holeR), j*(pcbY/2-holeOff-holeR),0])
				cylinder(r=holeR, h=5, $fn = 12);
		}
	}
		
	
}

module POT()
{
	underR = 16.5/2;
	length = 25;
	depth = 10;
	
	shaftR = 7/2;
	placeOff = 7.7;
	
	hull() 
	{
		translate([0,0,-depth])
		cylinder(r=underR, h= depth);
		translate([length-1, -underR,-2])
			cube([1,underR*2,2]);
	}
	cylinder(r=shaftR, h=8);
	translate([-2.5/2,-(underR), 0])
		cube([2.5, 2, 3]);
}

module switchFlick() 
{
	switchW = 13;
	switchL = 12;
	switchH = 13;
	switchR = 6/2;
	switchRH = 8.5;
	
	translate([0,0, -switchH/2])
		cube([switchW, switchL, switchH], center= true);
	
	cylinder(r=switchR, h=switchRH);
	
}

module gimbal()
{
	innerHoleDist = 45;
	outerHoleDist = 54;
	
	halfInner = innerHoleDist/2;
	halfOuter = outerHoleDist/2;
	
	innerHoleR = 3/2;
	outerHoleR = 6/2;
	outerHoleH = 3.5;
	
	centerR = 48/2;
	
	for (i = [-1,1]) {
		for (j = [-1,1]) {
			translate([i*halfInner, j*halfInner,0])
				cylinder(r=innerHoleR, h=15);
			translate([i*halfOuter, j*halfOuter,0])
				cylinder(r=outerHoleR, h=outerHoleH);
		}
	}
	cylinder(r=centerR, h= 8, $fn = renderFN);
	
	translate([-30,-30,-30])
		cube([60,60,30]);
}