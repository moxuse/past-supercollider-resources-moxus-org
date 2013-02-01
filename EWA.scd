(
o=AudioMeter.new;o.autoreset_(0.25);

s.sendMsg("/b_allocRead",10,"sounds/hh24.wav");
s.sendMsg("/b_allocRead",100,"sounds/ew02.wav");
s.sendMsg("/b_allocRead",110,"sounds/ew01.wav");
s.sendMsg("/b_allocRead",120,"sounds/ew00.wav");

s.sendMsg("/b_allocRead",40,"sounds/ove.aif");
s.sendMsg("/b_allocRead",30,"sounds/sui2.aif");
s.sendMsg("/b_allocRead",20,"sounds/onder2.wav");

s.sendMsg("/b_allocRead",50,"sounds/soz15.wav");
s.sendMsg("/b_allocRead",60,"sounds/soz20.aif");
s.sendMsg("/b_allocRead",70,"sounds/soz9.wav");
//soz15.wav //for-ice
//soz20.wav //for-ice
//soz9.wav //for-ice


SynthDef("food1-1",{arg amp=1;
	var src;
	src=RHPF.ar(PlayBuf.ar(1,10,Rand(1,4),loop:0),LFNoise2.ar(3,12,89).midicps,0.3)
		*EnvGen.ar(Env.linen(0.0,0.3,0.0,1,-1),doneAction:2); // synth envelope
	Out.ar(0,Pan2.ar((src*20).softclip*0.25,0.8));
}).store;


SynthDef("food1-2",{arg amp=1,rate=1,del=0,rrate=1;
	var gate,src;
	gate=1;
	src=SinOsc.ar(XLine.kr(127876,Rand(4000,400),0.04),0,0.3)
		*EnvGen.ar(Env.linen(0.0,0.01,0.04,1,-3))
		*EnvGen.ar(Env.linen(0.0,0.3,0.0,1,-1),doneAction:2); // synth envelope
	Out.ar(0,Pan2.ar((src*20).softclip*0.25,0));
}).store;


SynthDef("food1-3",{arg amp=1,rate=1,del=0,rrate=1;
	var gate,src;
	gate=1;
	src=SinOsc.ar(4800,0,0.3)
		*EnvGen.ar(Env.linen(0.0,0.5,0.04,1,-3))
		*EnvGen.ar(Env.linen(0.0,0.3,0.0,1,-1),doneAction:2);// synth envelope
	Out.ar(0,Pan2.ar((src*20).softclip*0.25,-0.9));
}).store;

SynthDef("food1-a",{arg amp=1;
	var src;
	src=PlayBuf.ar(1,100,1,loop:0)*1.5
		*EnvGen.ar(Env.linen(0.0,0.5,0.0,1,-1),doneAction:2); // synth envelope
	Out.ar(0,Pan2.ar(src,0));
}).store;

SynthDef("food1-b",{arg amp=1;
	var src;
	src=PlayBuf.ar(1,110,1,loop:0)*1.35
		*EnvGen.ar(Env.linen(0.0,0.5,0.0,1,-1),doneAction:2,doneAction:2); // synth envelope
	Out.ar(0,Pan2.ar(src,0.8));
}).store;


SynthDef("food1-c",{arg amp=1;
	var src;
	src=PlayBuf.ar(1,120,1,loop:0)*1.5
		*EnvGen.ar(Env.linen(0.0,0.5,0.0,1,-1),doneAction:2,doneAction:2); // synth envelope
	Out.ar(0,Pan2.ar(src,-0.8));
}).store;


////////

SynthDef("food2-1",{arg amp=1,gate=0,rrate=1;
	var src;
	src=PlayBuf.ar(1,20,1,1,620,1)
		*EnvGen.ar(Env.adsr(0.02,0.3,0.8,0.75,amp,12),gate,doneAction:0); // synth envelope
	Out.ar(0,Pan2.ar(src,0));
}).store;



SynthDef("food2-2",{arg amp=1,gate=0,rrate=1;
	var src;
	src=RHPF.ar(PlayBuf.ar(1,30,1,1,27840,1),7000,0.3)
		*EnvGen.ar(Env.adsr(0.02,0.3,0.75,0.5,amp,12),gate,doneAction:0); // synth envelope
	Out.ar(0,Pan2.ar(src,0.9));
}).store;



SynthDef("food2-3",{arg amp=1,gate=0,rrate=1;
	var src;
	src=PlayBuf.ar(2,40,1,1,2784,1)
		*EnvGen.ar(Env.adsr(0.02,0.3,0.75,0.5,amp,12),gate,doneAction:0); // synth envelope
	Out.ar(0,Pan2.ar(src,-0.9));
}).store;



/////////


SynthDef("food3-1",{arg amp=1,gate=0,rrate=1;
	var src;
	src=Pulse.ar(100,0.1,0.3).softclip
		*EnvGen.ar(Env.adsr(0.0,0.1,0.6,0.01,1,1),gate,doneAction:0); // synth envelope
	Out.ar(0,Pan2.ar(src,0));
}).store;


SynthDef("food3-2",{arg amp=1,gate=0,rrate=1;
	var src;
	src=PlayBuf.ar(1,60,1,1,Rand(0, BufFrames.kr(60)),1)
		*EnvGen.ar(Env.adsr(0.3,0.1,0.6,0.5,1,1),gate,doneAction:0); // synth envelope
	Out.ar(0,Pan2.ar(src,0.3));
}).store;


SynthDef("food3-3",{arg amp=1,gate=0;
	var src;
	src=ClipNoise.ar(0.2)*Decay2.ar(Dust.ar(43),0.01,0.05)
		*EnvGen.ar(Env.adsr(0.3,0.1,0.5,0.5,1,1),gate,doneAction:0); // synth envelope
	Out.ar(0,src);
}).store;

)




////////////////////////////////
////////////////////////////////
////////////////////////////////
p = ArduinoSMS("/dev/tty.usbserial-A6004uD2", 9600); // was 9600 (changed by thor)

(
var f0,f1,f2,f3,f4,f5;


f0=Synth("food2-1");
f1=Synth("food2-2");
f2=Synth("food2-3");
f3=Synth("food3-1");
f4=Synth("food3-2");
f5=Synth("food3-3");

p.action = { |... msg|
	var shift_index,break_flag;
	shift_index=0;

	/////////actually sound tsdk 1
	"one".postln;
		if(msg[1] == 1,{

			if( 0.8.coin,{
				s.sendMsg("/s_new","food1-2",9001,0,1);
				},{s.sendMsg("/s_new","food1-a",9001,0,1);
			})
	});

	if(msg[2] == 1,{
			if( 0.8.coin,{
				s.sendMsg("/s_new","food1-1",9002,0,1);
				},{s.sendMsg("/s_new","food1-b",9002,0,1);
			})
	});

	if(msg[3] == 1,{
			if( 0.8.coin,{
				s.sendMsg("/s_new","food1-3",9003,0,1);
				},{s.sendMsg("/s_new","food1-c",9003,0,1);
			})
	});
	//////////////


	break_flag=1;
	if(msg[4] == 1,{
		shift_index = 1;
		break_flag=0;
		});

		if(shift_index == 1,{

			p.action = { |... msg|

				if(msg[4] == 0,{
					break_flag=1;

				});



				if(break_flag == 1,{

				shift_index = 2;
				if(msg[4] == 1,{
				if(shift_index == 2,{

					p.action = { |... msg|
						"t h r e e".postln;
							/////////actually sound tsdk 3
								if(msg[1] == 1,{

								f3.set(\gate,1);
							},{f3.set(\gate,0)});

							if(msg[2] == 1,{
								//s.sendMsg("/s_new","food2",1002,0,1);

								f4.set(\gate,1);
							},{f4.set(\gate,0)});

							if(msg[3] == 1,{
								//s.sendMsg("/s_new","food3",1002,0,1);

								f5.set(\gate,1);
							},{f5.set(\gate,0)});
							//////////////

					}});
					});
					});

			"tow tow tow".postln;

			/////////actually sound tsdk 2
			if(msg[1] == 1,{

			f0.set(\gate,1);
			},{f0.set(\gate,0)});

			if(msg[2] == 1,{
				//s.sendMsg("/s_new","food2",1002,0,1);

			f1.set(\gate,1);
			},{f1.set(\gate,0)});

			if(msg[3] == 1,{
				//s.sendMsg("/s_new","food3",1002,0,1);

			f2.set(\gate,1);
			},{f2.set(\gate,0)});
			//////////////


			};

		})
}

)



// read digital pins
(
t=Task( {
	inf.do {
		p.send($r, $d);
		0.025.wait;

	}
}).play;
)
t.stop;






p.close;