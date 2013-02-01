(
Document.current.mouseDownAction_({arg doc;
var char;
char = 700/ doc.selectionSize;
if(char<9){char=9};
char.postln;
doc.font_(Font("Monaco",char),doc.selectionStart,doc.selectionSize);
doc.stringColor_(Color.rand,doc.selectionStart,doc.selectionSize);
})
)

////////////////

(
Public.startListen;
a = NetAddr("127.0.0.1", 57120); // mori
c = NetAddr("169.254.44.147", 57120); // inafuku

//// boot local server
//Server.default = Server.local;
//s = Server.default;
//if(not(s.serverRunning), {s.boot});

// create a public proxyspace
p = ProxySpace.push(s);
r = ProxySpace.push(s);

x = Public(p);
z = Public(r);

p.dispatch = x;
r.dispatch = z;

x.addresses = a;
z.addresses = c;

x.join(\waitingroom, \mori);
z.join(\waitingroom, \mori);

x.sendingKeys = \all;
z.sendingKeys = \all;

x.listeningKeys = \all;
z.listeningKeys = \all;

x.makeLogWindow;
z.makeLogWindow;

p.fadeTime = 6.0;
r.fadeTime = 3.0;
)

// define output proxy
(
p[\publicout].play;
p[\out].play;
r[\publicout].play;
r[\out].play;
)

p[\out] = { Impulse.ar([9100, 10010], 0, 0.1) }; // mori

r[\out] =  { Impulse.ar([900, 10010], 0, 0.1) };  // inafuku


r[\out].end;
p[\out].end;
p[\publicout].end;
r[\publicout] .end;


/////////////////////


p[\publicout] = { LatoocarfianL.ar(SampleRate.ir * StandardL.ar(SampleRate.ir), TExpRand.ar(0.1,1.8,Impulse.ar(10)), mul:0.08) ! 2 };


p[\publicout]=  {ClipNoise.ar(0.2)*Decay2.ar(Dust.ar(43),0.01,0.05).dup};

p[\publicout]=  {FBSineL.ar(SampleRate.ir* StandardL.ar(SampleRate.ir),TExpRand.ar(0.1,3.8,Impulse.ar(10)), 1, 1, mul:0.1) ! 2 clip2: SinOsc.ar([5,3])}

p[\publicout] = {Crackle.ar(TExpRand.ar(0.1,[1.8,1.23],Impulse.ar([10,6])),mul:0.5)};



///////////////


clip2: SinOsc.ar(10,0,0.4)

*200).softclip*0.1


r[\publicout] = {Pulse.ar(Lag.ar(TExpRand.ar(40,15345,Impulse.ar([4,8])),0.02),0.1,0.1) clip2:SinOsc.ar(10,0,0.4)};



 p[\publicout] = {Crackle.ar(TExpRand.ar(0.1,[1.8,1.23],Impulse.ar([10,6])),mul:0.5) wrap2: SinOsc.ar(4,0.2,0.3)};



 p[\publicout] = {Blip.ar(Lag.ar(TExpRand.ar(8900,12023,Impulse.ar([10,23])),0.4),34,mul:0.25) clip2: SinOsc.ar(3)};


 p[\publicout] = {(Klank.ar(`[6.fib(2000,50),nil,0.4.dup(6)],Dust2.ar(3)).dup*200).softclip*0.1};

Click








~a.fadeTime_(4);
~a.play;
~a.source={Convolution.ar(HenonC.ar(22000, LFNoise2.ar(0.3,1.2),  LFNoise1.ar(0.2,0.9)),Mix.fill(5,{SinOsc.ar({[0,5,7,9,12,-12].choose+75}.midicps*{[1,0.5,2,0.666,0.75].choose},0.4.rand ,HenonC.ar(SampleRate.ir/2, LFNoise2.ar(0.3,1.2),  LFNoise1.ar(0.2,0.9)) * 0.1 )}))};


ProxySpace.push(s);

~b.fadeTime_(4);
~b.play;
(
~b.source={arg lpf=127;
RLPF.ar(AllpassC.ar(Mix.fill(12,{SinOsc.ar({[0,5,7,9,12,-12].choose+56}.midicps*{[1,0.5,2,0.666,0.75].choose},0.4.rand ,HenonC.ar(SampleRate.ir/12.rand, LFNoise2.ar(0.3,1.2),  LFNoise1.ar(0.2,0.9)) * 0.1 )})
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
RLPF.ar(AllpassC.ar(Mix.fill(12,{SinOsc.ar({[0,5,7,9,12,-12].choose+56+12}.midicps*{[1,0.5,2,0.666,0.75].choose},0.4.rand ,HenonC.ar(SampleRate.ir/12.rand, LFNoise2.ar(0.3,1.2),  LFNoise2.ar(33.2,0.9)) * 0.1 )})
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