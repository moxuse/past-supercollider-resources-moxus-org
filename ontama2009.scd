ProxySpace.push(s);

o=AudioMeter.new;
o.autoreset = 0.05;


~a.fadeTime_(4);
~a.play;
~a.source={AllpassC.ar(Convolution.ar(HenonC.ar(SampleRate.ir/3, LFNoise2.ar(0.4,1.2),  LFNoise2.ar(0.3,0.9),mul:0.5),Mix.fill(8,{FSinOsc.ar({[0,5,7,9,12,24].choose+74}.midicps*{[1,0.5,2,0.666,0.75].choose},0.06.rand ,HenonC.ar(SampleRate.ir/12, LFNoise2.ar(0.3,1.2),  LFNoise1.ar(0.3,0.9)) * 0.025 )})),0.2,{[0.04.rand,0.03.rand]},{[0.09.rand,1.2.rand]})};



~a.source={AllpassC.ar(Convolution.ar(HenonC.ar(SampleRate.ir/7, LFNoise0.ar(8,1.2),  LFNoise0.ar(8,0.9),mul:0.3),Mix.fill(12,{Pulse.ar({[0,5,7,9,12,24].choose+74+12}.midicps*{[1,0.5,2,0.666,0.75].choose},0.5.rand ,HenonC.ar(SampleRate.ir, LFNoise2.ar(0.3,1.2),  LFNoise1.ar(0.3,0.9)) * 0.07 )})),0.3,{[0.04.rand,0.05.rand]},{[0.1.rand,0.2.rand]})};




~a.source={AllpassC.ar(Mix.fill(8,{Resonz.ar(WhiteNoise.ar(4),{[0,5,7,9,12,24].choose+74}.midicps*{[1,0.5,2,0.666,0.75].choose},0.007) * HenonC.ar(SampleRate.ir, LFNoise2.ar(0.6,1.2),  LFNoise2.ar(0.2,0.9) ) }),0.01,{[0.04.rand,0.05.rand]},{[0.1.rand,0.2.rand]})};

~b.play;
~b.fadeTime_(4);

~b.source={CombL.ar(Convolution.ar(HenonN.ar(LFNoise2.kr(0.5,20,74).midicps, LFNoise0.ar(0.8,1.2),  LFNoise1.ar(0.7,0.9),mul:0.2),Mix.fill(5,{SinOsc.ar({[0,4,7,9,12,24].choose+74}.midicps*{[1,0.5,1.5,0.75].choose},FSinOsc.ar({[0,5,7,9,12,24].choose+74}.midicps*2,0,120),HenonC.ar(LFNoise0.kr(0.3,12,74).midicps, LFNoise0.ar(1,1.2),  LFNoise0.ar(2,0.9)) * 0.033 )})),0.5,{[0.04.rand,0.03.rand]},{[0.12,0.1]})};

/////////
~b.fadeTime_(0);
~b.source={AllpassN.ar((Convolution.ar(HenonC.ar(SampleRate.ir, LFNoise0.ar(8,1.2),  LFNoise0.ar(2,0.9),mul:0.3),Mix.fill(8,{FSinOsc.ar({[0,4,6,10,12,24].choose+74+12}.midicps*{[1,0.5,2,0.666,0.75].choose},0.5.rand ,HenonN.ar(SampleRate.ir, LFNoise2.ar(8,1.2),  LFNoise1.ar(3,0.9)) * 0.2 )}))*12 ).softclip*0.2 ,0.05,{[0.04.rand,0.05.rand]},{[0.1.rand,0.8.rand]})};

/////////
////////

~a.end;
~b.end;

~b.play;
s.sendMsg(\b_allocRead, 10, "sounds/soz30.wav");
//
s.sendMsg(\b_allocRead, 10, "sounds/soz16.wav");
~b.source={AllpassC.ar(PlayBuf.ar(2,10,1,1,44100*14.rand,1)*HenonN.ar(SampleRate.ir/1000, LFNoise2.ar(0.8,1.2),  LFNoise2.ar(0.3,0.9),mul:0.8),0.1,{[0.04.rand,0.05.rand]},{[0.13,0.1]})};

~b.play;

(
o=AudioMeter.new;
o.autoreset_(0.5)
)
Pdef(\comp).play;

Pdef(\comp).fadeTime = 3;

Pdef(\comp).stop;

(
Pdef(\comp,
	Ppar([

Pbind(\instrument,"duct",\midinote,Prand([4,\reset,0,\reset,9]+33, inf),
	\dur,Prand([2,1],inf),\amp,0.15),


Pbind(\instrument,"kicks",
	\dur,Pseq([8],inf),\amp,0.2),

Pbind(\instrument,Pshuf(["clicks","clicks2","clicks3"],inf),
	\dur,Prand([0.25],inf),\amp,Pseq([2,1,1,1,3,1,1,1,0,0,0,0,0,0]/5,inf)),

Pbind(\instrument,Prand(["snr1","snr2"],inf),
	\dur,Pseq([2],inf),\amp,0.8),
	])
);
)

Tempo.bpm=60
__________________________

(
SynthDef("sin-f",{arg amp=0,freq=550;
var out;
out=Pan2.ar(SinOsc.ar(freq)*EnvGen.ar(Env.perc(0.01, 1.26, 1, -4),doneAction: 2),SinOsc.ar(2.25));
Out.ar(0,out.clip(-0.9,0.9));
}).store;

SynthDef("duct",{arg amp=0,freq=550;
var out;
out=Pulse.ar(freq*120,0.15,0.4)*Decay2.ar(Impulse.ar(30), 0.01, 0.14, 1)*EnvGen.ar(Env.new([0,1,0], [0.15,0],'step'),doneAction: 2);
Out.ar(0,Pan2.ar(out.clip(-0.9,0.9),LFNoise2.kr(4)));
}).store;



SynthDef("kicks",{arg amp=0;
var out;
out=SinOsc.ar(XLine.kr(1020,48,0.03),[0.07,0.03],amp).dup*EnvGen.ar(Env.linen(0.00, 0.3, 0.05, 1,12),doneAction: 2);
Out.ar(0,out);
}).store;

SynthDef("snr1",{
var dom;
dom=12800;
Out.ar(0,Pan2.ar(Pulse.ar(XLine.kr(dom,60,0.05),0.15,0.4)*Decay2.ar(Impulse.ar(8), 0.01, 0.14, 5)*
EnvGen.kr(Env.linen(0.02,0.1,0.02,1,1), 1, doneAction:2),LFNoise1.kr(4,1)).softclip*0.7)
}).store;


SynthDef("snr2",{arg amp=1,gate=1,gain=800,lpf=1024;
var out;
y=Pan2.ar(RHPF.ar(ClipNoise.ar(0.5),6000,0.3)*Decay2.ar(Impulse.ar(XLine.kr(16,9,0.1)), 0.01, 0.02, 5)*
EnvGen.kr(Env.linen(0.02,0.11,0.02,1,1), 1, doneAction: 2),LFNoise1.kr(4,1));
    out = (y*gain)*gate/8;
	w = y;
	w = AllpassN.ar(w, 0.1,{[0.1.rand, 0.1.rand]}.dup(2), 1.0);
	y = (y * -0.5) + (w * 0.5);

Out.ar(0,(y*60).softclip*0.2);
}).store;



SynthDef("clicks",{arg amp=0;
var v,y,a,b,env;
env=LFNoise2.kr(0.5,0.1,0.02);
a=Pulse.ar(360,0.5,0.8);
b=Impulse.ar(700,0,0.5);
v=(a wrap2:b)*
EnvGen.ar(Env.linen(0.0,env*3,0.01,1,12), doneAction:2)*amp;
Out.ar(0,Pan2.ar((v*30).softclip*0.24,LFNoise1.kr(2)));
}).store;

SynthDef("clicks2",{arg amp=0;
var v,y,a,b,env;
env=LFNoise2.kr(0.5,0.1,0.06);
a=Pulse.ar(6,0.5,0.5);
b=RHPF.ar(Dust.ar([12700,12004],0.8),900,0.1);
v=(a clip2:b)*
EnvGen.ar(Env.linen(0.00,env*2,0.001,1,-4), doneAction:2)*amp;
Out.ar(0,Pan2.ar((v*2).softclip*0.2,LFNoise1.kr(6)));
}).store;

SynthDef("clicks3",{arg freq=120,amp=0;
var v,y,a,b,env;
env=LFNoise2.kr(0.5,0.1,0.02);
a=Pulse.ar(XLine.kr(1260-freq,2256,0.1),0.25,0.5);
b=SinOsc.ar(9700,0,0.94);
v=(a clip2:b)*
EnvGen.ar(Env.linen(0.0,env*3,0.03,1,12), doneAction:2)*amp;
Out.ar(0,Pan2.ar((v*30).softclip*0.2,LFNoise1.kr(6)));
}).store;
)
________________________________________
(
SynthDef("clicks",{arg amp=0;
var a,b,env;
env=LFNoise2.kr(0.5,0.1,0.02);
a=LFPulse.ar([57,66].midicps,0.5,0.1,0.3);

EnvGen.ar(Env.perc(0.004,env,0.5,2), doneAction:2)*amp;
Out.ar(0,Pan2.ar(a,LFNoise1.kr(2)));
}).store;

SynthDef("clicks2",{arg amp=0;
var v,y,a,b,env;
env=LFNoise2.kr(0.5,0.1,0.02);
a=LFPulse.ar([61,69],0.5,0.5);

EnvGen.ar(Env.perc(0.004,env,0.5,4), doneAction:2)*amp;
Out.ar(0,Pan2.ar(a,LFNoise1.kr(6)));
}).store;

SynthDef("clicks3",{arg amp=0;
var v,y,a,b,env;
env=LFNoise2.kr(0.5,0.1,0.02);
a=Pulse.ar(60,0.5,0.8);
b=Pulse.ar([700,720]);
v=(a clip2:b)*
EnvGen.ar(Env.perc(0.004,env,1,4), doneAction:2)*amp;
Out.ar(0,Pan2.ar(v,LFNoise1.kr(6)));
}).store;


)
