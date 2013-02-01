p = ProxySpace.push(s);

AudioMeter.new
s.sendMsg(\b_allocRead, 20, "sounds/soz28.aiff");

s.sendMsg(\b_allocRead, 66, "sounds/onder.wav");
s.sendMsg(\b_allocRead, 66, "sounds/soz2.wav");

s.sendMsg(\b_allocRead, 66, "sounds/soz29_m.wav");//rate *0.5
g = Buffer.alloc(s,a,1);

~y.play;
(
~y.source={ arg out=20,bufnum=20;
	var trig,kernel,in,dem,src;

	trig =	CoinGate.kr(0.25,TDuty.kr(
				Drand([0.5,0.75,0.5,0.75], inf), // demand ugen as durations
				0,
				Dseq([0.1, 0, 1.0, 1, 1.0,0,0.5,1], inf) // demand ugen as amplitude
			));
	src=AllpassC.ar(PlayBuf.ar(1,20,2,Lag.kr(trig,0.05),MouseX.kr(0,BufFrames.kr(bufnum)),1),0.05,{[0.032.rand,0.03.rand]},0.04);
Out.ar(0,src*0.8)
};
)

~y.fadeTime=4;
~y.end;




"/Users/moxuse/Documents/past_documents/2006winter/CageCutGui.sc".loadPaths


 Buffer.alloc(s,2048,2,bufnum:60);
~z.play;
~z.fadeTime=0.4;
(
~z.source={
var src,note,rate;
			rate = 2;
			note = 60;
	note =Duty.kr(
				Dseq([0.5]*8, inf), // demand ugen as durations
				0,
				Dseq([7,7,0,7]+note, inf) // demand ugen as amplitude
			);

	src=Mix.fill(8,{LFCub.ar(note.midicps*{[1,1.5,0.75,0.5123,3,1.333,2.6666].choose},LFPar.ar(note.midicps*2,LFCub.ar(note.midicps*5/7,0,LFNoise0.kr(10.4,6)),LFPar.ar(note.midicps,0,2)),0.08)})*HenonC.ar(SampleRate.ir/rate,TExpRand.ar(0.1,2.8,Impulse.ar(10)),mul:0.8);
	x=src;
	src=CombC.ar(src,0.008,[0.043,0.04],0.8);
};)

~z.end;

~c.end;
~c.source={Impulse.ar(1.95*4);0;}

~v.play;
~v.fadeTime=0.0;
~v.source = {Klank.ar(`[[8001, 531, 5053, 1223], nil, [1, 1, 1, 1]], PinkNoise.ar(0.05))*HenonC.ar(SampleRate.ir/70,TExpRand.ar(0.01,[2.8,4.23],Impulse.ar(1.95*4)),mul:0.23).softclip(-0.5,0.5)};

~v.source = { LatoocarfianC.ar(SampleRate.ir , TExpRand.ar(0.1,1.8,Impulse.ar([0.5,8])), mul:0.15) };
~v.end;



(
 Buffer.alloc(s,2048,1,bufnum:77);
s.sendMsg(\b_allocRead, 66, "sounds/soz18.wav");
s.sendMsg(\b_allocRead, 66, "sounds/soz25_m.wav");
)


~x.play;

(
~x.source =  {
	var in, chain,src,trig;
		trig =	CoinGate.kr(0.05,TDuty.kr(
				Drand([0.5,0.75,0.5,0.75], inf), // demand ugen as durations
				0,
				Dseq([0.1, 2, 5.0, 1, 2.0,1,0.5,3], inf) // demand ugen as amplitude
			));
	in = PlayBuf.ar(1, 66, BufRateScale.kr(66)*trig, loop: 1);

	chain = FFT(77, in);
	//chain = PV_MagFreeze(chain, MouseY.kr > 0.75 );
	chain = PV_BinScramble(chain, 3, 0.1, 0.35 );
	chain=PV_ConformalMap(chain, MouseX.kr(-1.0,1.0), MouseY.kr(1.0,-1.0));
	chain = PV_BinShift(chain, LFNoise0.kr(0.5,2.48,0.02),MouseY.kr(0.15, 1.125) );


	src=CombC.ar(IFFT(chain),0.15,[0.015,0.014],0.1);
	Out.ar(0, src );
	}
)
~x.end;
s.sendMsg(\b_allocRead, 66, "sounds/soz29_m.wav.wav");
//s.sendMsg(\b_allocRead, 66, "sounds/soz8.wav");

s.sendMsg(\b_allocRead, 66, "sounds/soz3.wav");



(
~x.source =  {
	var in, chain,src;
	in = PlayBuf.ar(1, 66, BufRateScale.kr(66), loop: 1);

	chain = FFT(77, in);
	chain = PV_MagFreeze(chain, MouseY.kr > 0.75 );
	chain = PV_BinShift(chain, 1,MouseY.kr(0.05, 0.5, \exponential) );
	chain=PV_ConformalMap(chain, MouseX.kr(-1.0,1.0), MouseY.kr(1.0,-1.0));
	src=CombC.ar(IFFT(chain),0.1,[0.053,0.014],0.1);
	Out.ar(0,  src);
	}
)


//////////////////////////////////////////////////////
//////////////////////////////////////////////////////









(

SynthDef("Hat",{arg amp=1,rate=1,del=0,rrate=1;
	var gate,src,cenv;
	gate=1;
	cenv=EnvGen.ar(Env.perc(0.0,0.017,amp,12),gate); // cluster envelope
	src=RHPF.ar(Impulse.ar(7000*rrate,SinOsc.ar(7454*rate,SinOsc.ar(3450*rrate,0,830),6),12)*LFNoise2.ar(150,0.4),420,0.2)
		*cenv
		*EnvGen.ar(Env.linen(0.5,0.5,0.25,1,1).delay(del),doneAction:2); // synth envelope
	Out.ar(12,(src*320).softclip*0.18);
}).store;

//sine click
SynthDef("Click",{arg amp=1,rate=1,del=0,rrate=1;
	var gate,src;
	gate=1;
	src=SinOsc.ar(12660,SinOsc.ar(EnvGen.ar(Env.perc(0.0,0.15,2000,-12),gate)+60,SinOsc.ar(10,0,20),2*rate))*LFNoise2.ar(EnvGen.ar(Env.perc(0.0,0.2,600,-12))+30,0.8)
		*EnvGen.ar(Env.perc(0.0,0.05,amp,12),gate) // cluster envelope
		*EnvGen.ar(Env.linen(0.25,0.75,0.25,1,1).delay(del),doneAction:2); // synth envelope
	Out.ar(12,(src*120).softclip*0.25);
}).store;



SynthDef("bass",{arg amp=1,note=60;
	var gate,src;
	gate=1;
	src=Mix.fill(5,{SinOsc.ar(note.midicps*{[1,1.5,0.75,0.5123,2,3].choose},SinOsc.ar(note.midicps/2,SinOsc.ar(note.midicps*102,0,LFNoise0.kr(4,12)),0.2),0.05)})
		*EnvGen.ar(Env.linen(0.0,0.3,0.0,1,12),doneAction:2);
//		*Decay2.ar(Impulse.ar(12),0.0,0.2); // synth envelope
	Out.ar(12,src);
}).store;


SynthDef("rev1",{arg amp=1,delay=0.15,decay=0.35;
var src,env,z;
	z=In.ar(12);
	z=AllpassL.ar(z,0.1,0.02,0.04);
	4.do({ z = AllpassL.ar(z, 0.005, {[rrand(0.01, 0.03)+delay,rrand(0.01, 0.04)+delay]}, decay) });
	Out.ar(0, z*amp);
	}).store;
)

Tempo.bpm=12

(
Pdef(\lamer,
Ppar([
	Pbind(\instrument,\Hat,\dur,Pseq([0.2,0.025,0.025,0.125,0.235,0.225,0.225,0.125,0.225,0.025,0.25,0.45,0.25,0.005,0.5,0.025,0.162,1.0],inf),
	\rate,Pseq([1,0.5,0.4,0.6,0.1,1,1],inf),\amp,1),

	Pbind(\instrument,\Click,\dur,Pseq([0.606,1.405,0.616,0.55,0.9],inf),
	\rate,1,\amp,Pseq([1,0.5,1,0],inf)),


//	//Pbind(\instrument,\bass,\dur,Pseq([4.077]/16,inf),\note,Pseq([Pseq([[3,8,12]],16),Pseq([[8,10,0]],16)]+35,inf)),
//	Pbind(\instrument,\bass,\dur,Pseq([4.077]/16,inf),\note,Pseq([Pseq([3,8,12],4),Pseq([8,10,0],4)]+35,inf))

	])
).play;
)

s.sendMsg(9,"rev1",5000,1,1);

Pdef(\lamer).play;





///end
Pdef(\lamer).stop;
s.sendMsg(11,5000);


~y.end;
~z.end;
~v.end;
~x.end;

4.077
















//////////////////////////////////////////////////////
//////////////////////////////////////////////////////


(
Instr(\spher,{arg lpf=50, rq=0.1,atk=0.2,rel=1.0,modSpeed=6.0,modMix=0.0,fx=0.3, gain=1,amp = 0;
	var ratio, n, d, p, q, mode, z, w, pul, mod,out;
	n = 32;
	ratio = 1.5;
	pul = Impulse.ar(modSpeed);
	//base = 100;
	p = FloatArray.new(3*n);
	q = FloatArray.new(3*n);
	d = 3.0;
	//mode = [-24, -12, 0, 5, 7, 10, 12, 17, 24, 36, 48];
	mode = [0, 5, 7];
	//mode = [0, 2, 4, 5, 7, 9, 11];
	n.do({ var freq;
		freq = (mode.choose + 36).midicps
		* [0.125,0.25,0.5,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,12.0,16.0,18.0,24.0,32.0,48.0,64.0,128.0].choose
		//*[1.0, ratio].choose*[1.0, ratio].choose
		//*[1.0, ratio].choose*[1.0, ratio].choose
		//*[1.0, ratio].choose*[1.0, ratio].choose
		;
		p.add(freq);
		p.add(freq + d.rand2);
		p.add(freq + d.rand2);
		});
	n.do({ arg i;
		var freq;
		freq = p.at(3*i);
		q.add(freq + d.rand2);
		q.add(freq + d.rand2);
		q.add(freq + d.rand2);
		});
	z = [`[p, nil, FloatArray.rand(3*n, 0, 2pi)],
		`[q, nil, FloatArray.rand(3*n, 0, 2pi)]];
	out = Klang.ar(z, 1, 0)*(0.25/n);
	out = RLPF.ar(out, lpf, rq);
	out = (out*gain).softclip*amp;
	w = out;
	4.do({
		w = AllpassL.ar(out, 0.2,LFNoise2.kr([rrand(0.1, 0.2),rrand(0.1, 0.2)],0.05,0.15), 2)
		});
	out = (out * (fx - 1.0)) + (w * fx);
	mod = out * Decay2.ar(pul, atk, rel);
	out = (mod * modMix) + (out * (1-modMix));
	out;
	},#[
	\freq, \rq,
	[0.001,0.5,\linear,0],[0.002,2.0,\linear,0],
	[0,20.0,\linear,0],[0,1.0,\linear,0],\nil,[1,4096,\exponential,0],\amp
	]).test
)




















