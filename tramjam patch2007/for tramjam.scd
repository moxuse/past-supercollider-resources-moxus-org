////////////////////////cahossiner!!//////////

Route_15_Totsuka_Line

OSCresponder.remove
~a.end;



p=OSCresponder(nil,"/dooropen", {|t r m|
if(m[1]==1, {
~a.play;
},{
if(m[1]==0,{
~a.end;
});
});
m.postln;
}).add;

NetAddr("localhost", 57120).sendMsg("/dooropen","hoge");
//s=Server.internal;
ProxySpace.push(s.boot);

~a.play;
~a.fadeTime=1.5;
(
~a.source={arg lpf=127;
AllpassC.ar(Mix.fill(23,{SinOsc.ar({[0,5,7,10,12,-12].choose+67}.midicps*{[1,0.5,2,0.666,0.75].choose},SinOsc.ar({[0,5,7,10,12,-12].choose+56}.midicps*122) ,HenonC.ar(SampleRate.ir/3.33, LFNoise2.ar(0.6,8.2), TExpRand.ar(0.13, 1.14, Impulse.ar(8))) * 0.25 )})
,0.25,{[0.04.rand,0.05.rand]},{[2.4.rand,1.3.rand]})
};
)



//~a.play;
//(
//~a.source={arg lpf=127;
//(RLPF.ar(AllpassC.ar(Mix.fill(18,{SinOsc.ar({[0,5,7,9,12,-12].choose+56}.midicps*{[1,0.5,2,0.666,0.75].choose},SinOsc.ar({[0,5,7,10,12,-12].choose+80}.midicps*122) ,HenonC.ar(SampleRate.ir, LFNoise2.ar(0.6,8.2), TExpRand.ar(0.13, 1.14, Impulse.ar(16))) * 0.2 )})
//,0.05,{[0.04.rand,0.05.rand]},{[2.4.rand,1.3.rand]}),lpf.midicps,0.25)*223).softclip*0.2
//};
//)
//
//(
//~a.source={
//AllpassC.ar(Mix.fill(8,{Pulse.ar({[0,5,7,9,12,-12].choose+56}.midicps*{[1,0.5,2,0.666,0.75].choose},0.9.rand , LinCongL.ar(
//	SampleRate.ir.rand,
//	LFNoise0.kr(0.3, 0.1, 0.1),
//	LFNoise0.kr(0.4, 0.5, 0.1),
//	LFNoise0.kr(0.2, 0.5)
//) * 0.2 )})
//,0.25,{[0.04.rand,0.05.rand]},{[1.4.rand,0.3.rand]})
//};
//)

/////////////////24,17
o=AudioMeter.new
o.autoreset_(0.25);
(
~a.source={
Pan2.ar(Mix.fill(16,{SinOsc.ar({[0,5,7,10,12,-12,17].choose+80}.midicps*{[1,0.5,2,0.666,0.75].choose},0.9.rand , LinCongL.ar(
	SampleRate.ir.rand,
	LFNoise0.kr(0.3, 0.1, 0.1),
	LFNoise0.kr(2.4, 0.5, 0.1),
	LFNoise0.kr(0.2, 0.5)
) * 0.23 )}),LFNoise2.kr(0.5,0.25));
}
)

~a.fadeTime=15;
~a.end;

//FreqScope.new(420, 180,Color.new255(125, 60, 0,120),Color.white);

~b.play;
~b.fadeTime=15;
(
~a.source={arg lpf=127;
RLPF.ar(AllpassC.ar(Mix.fill(8,{Pulse.ar({[0,5,7,9,12,-24].choose+80}.midicps*{[1,0.5,2,0.666,0.75].choose},0.1, HenonC.ar(SampleRate.ir/12, LFNoise2.ar(0.75,1.2),LFNoise1.ar(6.13,0.75)) * 0.1 )})
,0.1,{[0.04.rand,0.05.rand]},{[0.7.rand,0.8.rand]}),Lag.kr(lpf.midicps))
};
)

(
~a.source={arg lpf=127;
LPF.ar(AllpassC.ar(Mix.fill(8,{SinOsc.ar({[0,5,7,9,12].choose+80}.midicps*{[1,0.5,2,0.666,0.75].choose},0.1 ,FBSineC.ar(SampleRate.ir/6.rand) * LFNoise2.ar(0.2,0.05) )})
,0.1,{[0.04.rand,0.05.rand]},{[0.7.rand,0.8.rand]}),Lag.kr(lpf.midicps*1.5,0.05))
};
)
~b.fadeTime=15;
~b.end;

AudioMeter.new([0,1],s).autoreset_(0.25)




s.sendMsg(\b_allocRead, 20, "sounds/soz18.aif");
s.sendMsg(\b_allocRead, 20, "sounds/soz17.aif");


~y.play;
(
~a.source={ arg out=20,bufnum=20;
	var trig,kernel,in,dem,src;
	Out.ar(0,Mix.fill(12,{PlayBuf.ar(2,20,[1,0.5,0.04,0.75,0.25].choose,1,MouseX.kr(0,BufFrames.kr(bufnum)),0.6)*HenonL.ar(SampleRate.ir/3.33, LFNoise0.ar(0.75,1.2,0.1), TExpRand.ar(0.01,[0.8,0.9],Impulse.ar(12)) )}*0.3*Decay2.ar(Dust.ar(12),0.01,0.4)));

};)

~y.fadeTime=8;
~y.end;



~v.play;
~v.fadeTime=2;
(
~a.source={
 Klank.ar(`[[2658, 13071, 953], nil, [1, 1, 1]], PinkNoise.ar(0.03)) *Decay2.ar(Dust.ar([14,14]),0.0,0.08)
  };
)



(
~a.source={
 Klank.ar(`[[15800, 3071, 95], nil, [1, 1, 1]], PinkNoise.ar(0.03)) *Decay2.ar(Dust.ar([14,14]),0.0,0.08)
  };
)



~a.source = {HenonC.ar(SampleRate.ir/3.3333,TExpRand.ar(0.1,[2.8,4.23],Impulse.ar([10,5])),mul:0.7).clip(-0.6,0.6)};

~v.end;




--------------------excute----------
~a.source = { LatoocarfianL.ar(SampleRate.ir * StandardL.ar(SampleRate.ir), TExpRand.ar(0.1,1.8,Impulse.ar(10)), mul:0.08) ! 2 };


~a.source=  {ClipNoise.ar(0.2)*Decay2.ar(Dust.ar(43),0.01,0.05).dup};

~v.source=  {FBSineL.ar(SampleRate.ir* StandardL.ar(SampleRate.ir/12),TExpRand.ar(0.1,1.8,Impulse.ar(8)), 1, 1, mul:0.1) ! 2 clip2: SinOsc.ar([16,8])}



