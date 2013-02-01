s.sendMsg(\b_allocRead, 20, "sounds/soz60.wav");

s.sendMsg(\b_allocRead, 20, "sounds/soz8.wav");

s.sendMsg(\b_allocRead, 10, "sounds/soz16.wav");


Tempo.bpm=120;
o=AudioMeter.new;
o.autoreset_(0.25);
__________

(
SynthDef("kicks",{arg amp=0,rate=0;
var out,mod;
mod = EnvGen.ar(Env.perc(0.001,0.1,1,-2)) * 8200;
out=SinOsc.ar(50+mod,pi/4,amp).dup*EnvGen.ar(Env.perc(0.0, 0.05, 0.5, 12),doneAction: 2);
Out.ar(0,out);
}).store;

SynthDef("kicks2",{arg amp=0,rate=0;
var out,mod;
mod = EnvGen.ar(Env.perc(0.001,0.01,0.6,-4)) * 1200;
out=SinOsc.ar(50+mod,pi/4,amp).dup*EnvGen.ar(Env.perc(0.0, 0.5, 0.7, 6),doneAction: 2);
out=out+SinOsc.ar(11343,0,0.2)*EnvGen.ar(Env.perc(0.0, 0.5, 1, 12));
Out.ar(0,out*0.6);
}).store;

SynthDef("moes",{arg rate=1,amp=0;
	var b = 10, trate, dur,out;
	trate = MouseY.kr(2,500,1);
	dur = SinOsc.ar(0.4,0,3) +4 / trate;
	out=TGrains.ar(2, Impulse.ar(trate), b,rate, MouseX.kr(0,BufDur.kr(b)), dur, LFNoise1.kr(2), 4, 2)*amp*
EnvGen.kr(Env.perc(0.01,0.7,1,4), 1, doneAction:2);
Out.ar(0,(out*113).softclip*0.07);
}).store;


SynthDef("moes2",{arg rate=1,amp=0;
	var b = 20, trate, dur,out;
	trate = MouseY.kr(2,500,1);
	dur = SinOsc.ar(0.4,0,3) +4 / trate;
	out=TGrains.ar(2, Impulse.ar(trate), b,rate, MouseX.kr(0,BufDur.kr(b)), dur, LFNoise1.kr(4), 4, 2)*amp*
EnvGen.kr(Env.perc(0.01,0.3,1,4), 1, doneAction:2);
Out.ar(0,(out*32).softclip*0.2);
}).store;


SynthDef("moe2",{arg rate=1,amp=0,trate = 80;
	var b = 30, dur,out;
	dur = SinOsc.ar(0.4,0,3) +4 / trate;
	out=TGrains.ar(2, Impulse.ar(trate), b,rate, MouseX.kr(0,BufDur.kr(b)), dur,LFNoise2.kr(3), 4, 2)*amp*
EnvGen.kr(Env.perc(0.21,0.397,1,-4), 1, doneAction:2);
Out.ar(0,(out*2).softclip*0.2);
}).store;



SynthDef("moe3",{arg amp=0,rate=1,dur;
     var out;
	out= Pan2.ar(Klank.ar(`[[12600, 800, 60]*rate, nil, [1, 1, 1, 1]], WhiteNoise.ar(0.1)) *amp*
EnvGen.kr(Env.perc(0.00,0.2*dur,1,16), 1, doneAction:2),-0.6);
Out.ar(0,(out*23).softclip*0.15);
}).store;



SynthDef("moe4",{arg amp=0,rate;
     var out;
	out= Pan2.ar(Klank.ar(`[[15120, 6500, 3624]*rate, nil, [1, 1, 1, 1]], ClipNoise.ar(0.06)) *amp*
EnvGen.kr(Env.perc(0.00,0.17,1,-6), 1, doneAction:2),0.8);
Out.ar(0,(out*123).softclip*0.07);
}).store;

SynthDef("bass2",{arg amp=0.95,dur,note;
     var out;
	out= Pan2.ar(Klank.ar(`[[12725, 9415, 3492], nil, [0.5, 0.8, 0.6]], SinOsc.ar(note.midicps,0,LFNoise2.ar(0.04)
) )*amp*
EnvGen.kr(Env.perc(0.01,0.75*dur,1,-5), 1, doneAction:2),LFNoise1.ar(0.06));
Out.ar(0,out);
}).store;


SynthDef("bass",{arg freq,amp,gate=1;
	var src;
	src=SinOsc.ar([freq,freq*1.01],LFPar.ar(freq/2.1624)*EnvGen.ar(Env.adsr(0.2,0.1,0.03,0.2,1,13)),SinOsc.ar(freq*2,LFCub.ar(freq*102)*SinOsc.ar(freq/2),LFNoise2.kr(2,0.1,0.15)))*EnvGen.ar(Env.adsr(0.0,0.03,0.03,0.0,1,12,amp),gate,doneAction:2);
	Out.ar(0,src);
 }).store;

SynthDef("bass3",{arg freq,amp,gate=1;
	var src;
	src=Pan2.ar(Shaper.ar(0,LFPar.ar(freq*12, 0, Line.kr(7,0,0.2)),0.6*SinOsc.ar(freq*12,LFCub.ar(freq*13)))
*EnvGen.ar(Env.adsr(0.1,0.4,0.4,0.1,amp,3),gate,doneAction:2),LFNoise1.ar(0.1));
	Out.ar(0,src.softclip);
 }).store;
)



____________________

(
Pdef(\moe0,
	Ppar([


Pbind(\instrument,"moe2",
	\dur,Prand([3,5,1,0.5]*2,inf),\amp,0.3,\trate,Prand([100,80,40],inf)),


Pbind(\instrument,"kicks2",
	\dur,Pshuf([4],inf),\amp,0.89),

Pbind(\instrument,Prand(["kicks","moes"],inf),\dur,Prand([0.75,2.75,2.5,0.25]*2,inf),\amp,Prand([0.4,0.5,\],inf),\rate,Pshuf([1,1.25,1.75,1.3],inf)),


Pbind(\instrument,Prand(["moe3","moe4","moe3"],inf),
	\dur,0.125,\amp,Pseq([\,1,3,4,1,0,3,1,4,4,\,\,0,0,0]/4,inf),\rate,Prand([1,0.75,1,1,1,2,\,\,1,1.5],inf)),


Pbind(\instrument,Prand(["moe4","moe3"],inf),
	\dur,Pseq([1,2,4],inf)*Pseq([1,1,1,1,Pshuf([1/2,2/3,1/3],7)*Prand([2/3,3],7)*Prand([1,1,1,3/2,0.5],3),2],inf),\amp,Prand([\,2,2,4,\,1,\,2,1,0,0,0]/4,inf),\rate,Prand([0.3,0.75,0.5,1,\,\],inf)),


Pbind(\instrument,Prand(["moes","moes2"],inf),
	\dur,0.25,\amp,Prand([1,1,\,\,0.5,\,\],inf),\rate,Prand([4/5,1/2,3/4,2,-2,0.05,12],inf)),

	Pbind(\instrument,"bass2",\dur,Prand([7],inf),
\note,Pxrand([0,7,5]+62-12,inf)+Pxrand([0,0,-3,7,0,5,0,10],inf)),

	Pbind(\instrument,"bass2",\dur,Prand([7,0.454,5,3.53,2.555,0.34,0.467]*2,inf),\note,Pxrand([0,7,4,-12,-20,19,-24]+98,inf)),

			Pbind(\instrument,\bass,\dur,Prand([0.75,0.5,2.5,0.75,4]*2,inf),\amp,Pseq([1.7,2,2]/2,inf),\midinote,Pxrand([[5,12],[7,0],[-5,0],[-5,12]]+71-36,inf),\legato,Pwhite(0.12,0.3)),

		Pbind(\instrument,\bass3,\dur,Pshuf([3,0.25,0.75,1,2]*2,inf),\amp,1,\midinote,Prand([2,3,7,8,12]+59+12,inf),\legato,Pwhite(0.5,0.2)),

	]))
)
Tempo.bpm=85;
p = Pdef(\moe0).play;

t=TempoClock(0.70833333333333).play;
p.stop;


Pdef(\moe0,
	Ppar([
Pbind(\instrument,\moes20,\rate,
Pseq([1],inf),\pos,0,\dur,Pseq([4],inf),\lega,12);
]));

c.free
c=ExternalClock(t).play;
(
a=BBCut2(CutGroup([CutStream1.new(0),CutFunc({arg i;NetAddr("127.0.0.1", 5500).sendMsg("/tr0",i)}),CutBPF1(6000,drqfunc:0.5),CutMixer(0,0.8,RollAmplitude.new(0.59),CutPan1.new({(0.7.rand2)}))]),SQPusher2(quant:{[0.75,0.25,0.125/2].wchoose([0.9,0.1,0.1])},scramble:0.99,bpsd:0.49));
)


(
c=ExternalClock(t).play;
a=BBCut2(CutGroup([CutStream1.new(0),CutMixer(0,0.75,RollAmplitude.new(0.75),CutPan1.new({(0.79.rand2)}))]),WarpCutProc1.new({[1,2,4].choose}));
)
a.play(c);

a.pause;

a.resume;

c.free;
a.free;








____________________________
____________________________

o=AudioMeter.new
o.autoreset_(0.05)



ProxySpace.push(s);

~a.fadeTime_(19);
~a.play;
(
~a.source={arg lpf=127;
RLPF.ar(AllpassC.ar(Mix.fill(12,{SinOsc.ar({[0,3,7,9,12,-12].choose+86}.midicps*{[1,0.5,2,0.666,0.75].choose},0.4.rand ,HenonC.ar(SampleRate.ir/12.rand, LFNoise2.ar(0.3,1.2),  LFNoise1.ar(0.2,0.9)) * 0.1 )})
,0.25,{[0.04.rand,0.05.rand]},{[1.4.rand,0.3.rand]}),Lag.kr(lpf.midicps,0.1))
};
)
(
~a.source={
AllpassC.ar(Mix.fill(6,{SinOsc.ar({[0,5,7,9,12,-12].choose+56}.midicps*{[1,0.5,2,0.666,0.75].choose},0.9.rand ,LinCongC.ar(
	SampleRate.ir.rand,
	LFNoise0.kr(0.3, 0.1, 0.1),
	LFNoise0.kr(0.4, 0.5, 0.1),
	LFNoise0.kr(0.2, 0.5)
) * 0.2 )})
,0.25,{[0.04.rand,0.05.rand]},{[1.4.rand,0.3.rand]})
};
)

__________
(
~a.source={arg lpf=127;
RLPF.ar(AllpassC.ar(Mix.fill(12,{SinOsc.ar({[0,3,7,9,12,-12].choose+56+12}.midicps*{[1,0.5,2,0.666,0.75].choose},0.4.rand ,HenonC.ar(SampleRate.ir/12.rand, LFNoise2.ar(0.3,1.2),  LFNoise2.ar(3.2,0.9)) * 0.1 )})
,0.25,{[0.04.rand,0.05.rand]},{[1.4.rand,0.3.rand]}),Lag.kr(lpf.midicps,0.1))
};
)
_________
//~a.endしちゃだめ。
~b.play;
~b.fadeTime_(12);
~b.source=(~a*120).softclip*0.19;
~a.end;
~b.end;


s.sendMsg(\b_allocRead, 77, "sounds/moe55.wav");
{PlayBuf.ar(2,77,1,1,9424,0)}.play;