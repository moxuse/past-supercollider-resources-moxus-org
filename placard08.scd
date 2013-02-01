s.sendMsg(\b_allocRead, 30, "sounds/sona.wav");
(
Tempo.bpm=40;
SynthDef("0Hat",{arg amp=1,rate=2,del=0,rrate=1,id=30;
	var gate,src,cenv;
	var b, trate, dur,out,pos;

	b=id;

	trate = LFNoise0.kr(0.5,13,2).abs;
	dur = SinOsc.ar(0.6,16,2) +1 / trate;
	gate = 1;

	pos = rate*TRand.kr(1,4,gate);

	cenv=EnvGen.ar(Env.perc(0.0,0.5*rrate,amp,1),gate); // cluster envelope

	src=TGrains.ar(2, Impulse.ar(trate), b, rate/pos, MouseX.kr(BufDur.kr(b)/pos,0), dur, LFNoise0.kr(0.4), 4, 2)
	*cenv
	*EnvGen.ar(Env.perc(0.0,1.5*rate,1,1).delay(del),doneAction:2); // synth envelope
	Out.ar(0,(src*10).softclip*0.1);
}).store;


SynthDef("bass3",{arg amp,gate=1,note=50;
var src;
src=Mix.fill(5,{SinOsc.ar({[0,5,7,-12].choose+note}.midicps*{[1,0.5,2,1.75].choose}*SinOsc.ar({[0,-5,-7,-12].choose+note}.midicps*2,0,0.5),SinOsc.ar({[0,5,7,12,-12].choose+note}.midicps*102,0,0.5) , 0.07*LFNoise2.kr(1,0.4,0.8) )});
src=CombC.ar(src, 0.1,{[0.03.rand,0.02.rand]+0.05}, 2)*EnvGen.ar(Env.perc(0,0.8,1.0,-5),gate,doneAction:2);
Out.ar(0,src);
}).store;

SynthDef("bass5",{arg amp,gate=1,note=114;
var src;
src=Mix.fill(7,{SinOsc.ar({[0,5,7,-12].choose+note}.midicps*{[1,1.5,2,4,7,0.666].choose},Pulse.ar({[12,29,24,48].choose+note}.midicps,0.1,1.5.rand+0.1) , 0.035 )})*EnvGen.ar(Env.perc(0,0.2,1.0,12),gate,doneAction:2);
src=CombC.ar(src, 0.25,{[0.01.rand,0.01.rand]+0.04}, 0.1);
Out.ar(0,src);
}).store;

SynthDef("bass4",{arg amp,note=35,gate=1,def=1;
var src;
src=SinOsc.ar(note.midicps,SinOsc.ar(note.midicps*82,0,0.5), 0.23)*EnvGen.ar(Env.perc(0.0,0.3*def,1.0,12),gate,doneAction:2);
src=CombC.ar(src, 0.1,{[0.1.rand,0.1.rand]+0.01}, 0.8);
Out.ar(0,src);
}).store;


SynthDef("gsynth",{arg amp,gate=1,note=50,rate=1;
var src,cenv;
	cenv=EnvGen.ar(Env.perc(0.0,0.1,1,-2),gate,doneAction:2); // cluster envelope
	src=PlayBuf.ar(2, 10, BufRateScale.kr(10), -0.5*rate, MouseX.kr(0,BufFrames.kr(10)), 0)*0.4
	*cenv;
src=CombC.ar(src, 0.05,{[0.04.rand,0.04.rand]+0.01}, 2);
Out.ar(0,src.softclip);
}).store;

SynthDef("clap",{arg amp,gate=1,def=1;
var src;
src=Nes2.ar(Impulse.kr(16), d0:2r00000101, d2:8, smask:2r00101000)*0.3*EnvGen.ar(Env.perc(0.0,0.25*def,1.0,-5),gate,doneAction:2);
//src=CombC.ar(src, 0.1,{[0.04.rand,0.04.rand]+0.01}, 0.2);
Out.ar(0,Pan2.ar(src,-0.7));
}).store;




SynthDef("bass4",{arg amp,note=35,gate=1,def=1;
var src;
src=SinOsc.ar(note.midicps,SinOsc.ar(note.midicps*42,0,1), 0.25)*EnvGen.ar(Env.perc(0.0,0.3*def,1.0,12),gate,doneAction:2);
src=CombC.ar(src, 0.1,{[0.1.rand,0.1.rand]+0.01}, 0.8);
Out.ar(0,src);
}).store;


SynthDef("clap2",{arg amp,gate=1,def=1;
var src;
src=Nes2.ar(Impulse.kr(12), d0:2r10110101, d2:12, smask:2r00101001)*0.4*EnvGen.ar(Env.perc(0.0,0.25*def,1.0,-5),gate,doneAction:2);
src=CombC.ar(src, 0.1,{[0.04.rand,0.04.rand]+0.01}, 0.03);
Out.ar(0,src);
}).store;

SynthDef("clap3",{arg amp,gate=1,def=1;
var src;
src=HenonC.ar(SampleRate.ir/2,	LFNoise2.kr(6, 0.2, 1.2),LFNoise2.kr(1, 0.15, 0.15))*0.2*EnvGen.ar(Env.perc(0.0,0.1*def,1.0,12),gate,doneAction:2);
src=CombC.ar(src, 0.1,{[0.04.rand,0.04.rand]+0.01}, 0.2);
Out.ar(0,src);
}).store;
)

s.sendMsg(\b_allocRead, 10, "sounds/soz27.aif");

s.sendMsg("/s_new","bass3",1001,0,0,1,\gate,1,\note,70);
s.sendMsg("/n_set",1001,\note,56);
s.sendMsg("/n_set",1001,\gate,0);


s.sendMsg("/s_new","clap",2001,0,0,1,\gate,1,\def,3);
s.sendMsg("/s_new","gsynth",6001,0,0,1,\gate,1,\rate,2);
s.sendMsg("/n_set",3001,\rate,2);


e=Pbind(
\instrument,\bass3,\legato,1,
\degree,Prand([[0,3],[0,5],8,7,6]+62,inf),
 \dur,Pseq([0.125],inf)
).play;

e.free;


t = TaskProxy.new;
t.play;


t.play;
t.stop;



AudioMeter.new
/////////////////////////////////////////////
/////////////////////////////////////////////
/////////////////////////////////////////////
/////////////////////////////////////////////
/////////////////////////////////////////////
/////////////////////////////////////////////

//logger setting RANGE:10/cm MEASE:X100mV
//logger sereal protocol "+ [00/ff/PWM] [ff/forwoad On] [ff~00/AD out]"

q=SerialPort.new("/dev//tty.usbserial-A30007a3",9600,8,true,nil,true,true);
q.putAll("+000000");




(

SynthDef("bass6",{arg amp,gate=1,note=64,trig=1;
var src;
src=AllpassC.ar(Mix.fill(4,{SinOsc.ar({[0,5,7,9,12,-12].choose+note}.midicps*{[1,0.5,2,0.666,0.75].choose},SinOsc.ar({[0,5,7,10,12,-12].choose+56}.midicps*25) ,HenonC.ar(SampleRate.ir, LFNoise2.ar(1.6,8.2)*trig) * 0.15 )})
,0.1,{[0.02.rand,0.03.rand]},{[0.4.rand,0.3.rand]});
Out.ar(0,src*EnvGen.ar(Env.adsr(0.6,1,0.7,0.02,1.0,-2),gate));
}).store;
)
(
Tempo.bpm=60;
s.sendMsg("/s_new","bass6",5000,0,0,1,\gate,1,\note,72);

t.source={|t r m|
	var rules,aprules,hexlist,width,poslist,stream,output;
	var array,patStream;
	width=32;
	poslist=[];
	output = "";
	aprules = [
		"A" -> "a",
		"B" -> "b",
		"C" -> "c",
		"D" -> "d",
		"E" -> "e",
		"F" -> "f"
		];
	rules = [[//rule "Chell"
		"a>a>a" -> "x",
		"a>a>x" -> "a",
		"a>x>a" -> "x",
		"a>x>x" -> "a",
		"x>a>a" -> "a",
		"x>a>x" -> "a",
		"x>x>a" -> "a",
		"x>x>x" -> "x",
		],[//rule 30
		"a>a>a" -> "x",
		"a>a>x" -> "x",
		"a>x>a" -> "x",
		"a>x>x" -> "a",
		"x>a>a" -> "a",
		"x>a>x" -> "a",
		"x>x>a" -> "a",
		"x>x>x" -> "x",
		],[//rule 90
		"a>a>a" -> "x",
		"a>a>x" -> "a",
		"a>x>a" -> "x",
		"a>x>x" -> "a",
		"x>a>a" -> "a",
		"x>a>x" -> "x",
		"x>x>a" -> "a",
		"x>x>x" -> "x",
		],[//rule 105
		"a>a>a" -> "x",
		"a>a>x" -> "a",
		"a>x>a" -> "a",
		"a>x>x" -> "x",
		"x>a>a" -> "a",
		"x>a>x" -> "x",
		"x>x>a" -> "x",
		"x>x>x" -> "a",
		]].choose;
			//decide pitch of x pixels
	hexlist=(8*(0,1..width-1)).asHexString;

	hexlist.size.do({arg k; poslist=poslist.add(hexlist.at(k).at(6).asString.rewriteString(aprules) ++ hexlist.at(k).at(7).asString.rewriteString(aprules) )});//canvert to hex list

	stream=Pseq(poslist,inf).asStream;
	//poslist.postln;



		array = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxa";

		patStream = Pseq(array,32).asStream;

		300.do({
			32.do({arg i;




				if(array.at(i) == $x,{
				s.sendMsg("/n_set",5000,\gate,0,\note,74,\trig,0);
				c=stream.next.asString;
				output = "+" ++ "ff" ++ "ff" ++ c;
				q.putAll(output);

				0.0.wait;
				});
				if(array.at(i) == $a,{
				s.sendMsg("/n_set",5000,\gate,1,\note,74,\trig,1);
				c=stream.next.asString;
				output = "+" ++ "ff" ++ "ff" ++ c;
				q.putAll(output);

				0.15.wait;
					});

				});

			array=array.rewriteString(rules).keep(32);
			array.postln;
			22.do({
					q.putAll("+00fffff");
							0.0125.wait;
							q.putAll("+ffffff");
							0.0125.wait;
							});
					});

		300.do({
				q.putAll("+00fffff");
				0.0025.wait;
				q.putAll("+ffffff");
				0.0025.wait;
				});
			s.sendMsg(11,5000);
			q.putAll("+000000");
			//"python /Users/moxuse/Desktop/imagingloger/untitled.py".unixCmd;


};
)

s.sendMsg(11,8000);

(
SynthDef("bass6",{arg amp,gate=1,note=64,trig=1;
var src;
src=AllpassC.ar(Mix.fill(8,{SinOsc.ar({[0,5,7,9,12,-12].choose+note}.midicps*{[1,0.5,2,0.666,0.75].choose},SinOsc.ar({[0,5,7,10,12,-12].choose+56}.midicps*25) ,HenonC.ar(SampleRate.ir/2, trig/6) * 0.05 )})
,0.1,{[0.02.rand,0.03.rand]},{[0.4.rand,0.3.rand]});
Out.ar(0,src*EnvGen.ar(Env.adsr(0.6,1,0.7,0.02,1.0,-2),gate));
}).store;

s.sendMsg("/s_new","bass6",8000,0,0,1,\gate,1,\note,84);


t.source= {|t r m|



	     90.do({arg i; var prisn,prisn2,st,st2;
		  prisn = Pwhite(0, 6, inf);
		  prisn2 = Pwhite(0, 9, inf);

		  st=prisn.asStream.next;
		  st2=prisn2.asStream.next;

		  s.sendMsg("/n_set",8000,\gate,0,\note,59,\trig,st2,\gate,1);


	    60.do({
	    q.putAll("+" ++ "ff" ++ "ff"++st.asString++st2.asString);
	    0.0125.wait;
	    q.putAll("+" ++ "00" ++ "ff"++st.asString++st2.asString);
	    0.0125.wait;
	    });

	    });

	    	300.do({
			q.putAll("+00ff3c");
			0.0025.wait;
			q.putAll("+ffff3c");
			0.0025.wait;
			});
	    q.putAll("+000000");
	    s.sendMsg(11,8000);
	    //"python /Users/moxuse/Desktop/imagingloger/untitled.py".unixCmd;

};
)

s.sendMsg(11,8000);
t.play;

(

SynthDef("bass6",{arg amp,gate=1,note=64,trig=1;
var src;
src=AllpassC.ar(Mix.fill(8,{SinOsc.ar({[0,5,7,9,12,-12].choose+note}.midicps*{[1,0.5,2,0.666,0.75].choose},SinOsc.ar({[0,5,7,10,12,-12].choose+56}.midicps*25) ,HenonC.ar(SampleRate.ir/2, trig/6) * 0.05 )})
,0.1,{[0.02.rand,0.03.rand]},{[0.4.rand,0.3.rand]});
Out.ar(0,src*EnvGen.ar(Env.adsr(0.6,1,0.7,0.02,1.0,-2),gate));
}).store;
)
(
s.sendMsg("/s_new","bass6",8000,0,0,1,\gate,1,\note,84);

t.source=  {|t r m|
	     80.do({arg i; var prisn,prisn2,ps;
	    prisn = Pwhite(0, 9, inf);
	    prisn2 = Pwhite(0, 9, inf);



	    20.do({
	    ps=prisn.asStream.next;
	    q.putAll("+" ++ "ff" ++ "ff"++ps.asString++prisn2.asStream.next.asString);

	    s.sendMsg("/n_set",8000,\gate,0,\note,49,\trig,ps,\gate,1);

	    0.025.wait;
	    q.putAll("+" ++ "00" ++ "ff"++prisn.asStream.next.asString++prisn2.asStream.next.asString);
	    0.025.wait;
	    });
	    });

	    	300.do({
			q.putAll("+00ff3c");
			0.0025.wait;
			q.putAll("+ffff3c");
			0.0025.wait;
			});
			s.sendMsg(11,8000);
			//"python /Users/moxuse/Desktop/imagingloger/untitled.py".unixCmd;
	    }
)







//
////time seqence section
//(
//
//SynthDef("bass6",{arg amp,gate=1,note=74,trig=1;
//var src;
//src=AllpassC.ar(Mix.fill(4,{SinOsc.ar({[0,5,7,9,12,-12].choose+note}.midicps*{[1,0.5,2,0.666,0.75].choose},SinOsc.ar({[0,5,7,10,12,-12].choose+56}.midicps*25) ,HenonC.ar(SampleRate.ir, LFNoise2.ar(1.6,8.2)*trig) * 0.15 )})
//,0.1,{[0.02.rand,0.03.rand]},{[0.4.rand,0.3.rand]});
//Out.ar(0,src*EnvGen.ar(Env.adsr(0.6,1,0.7,0.02,1.0,-2),gate));
//}).store;
//
//s.sendMsg("/s_new","bass6",5000,0,0,1,\gate,1,\note,74);
//
//t.source={|t r m|
//	var list,hexlist,poslist,time,stream,timestream,output,width,rules;
//	list=[];
//	output = "";
//	poslist = [];
//	time = 0.25;
//
//	width = m[1];
//
//	rules = [
//		"A" -> "a",
//		"B" -> "b",
//		"C" -> "c",
//		"D" -> "d",
//		"E" -> "e",
//		"F" -> "f"
//		];
//
//	a=Pseq(["ff","00"],inf).asStream;
//
//
//	//make time list from recived message
//	(m.size-2).do({arg i;
//		//list=list.add((m[i+2] + 1).reciprocal*0.1.clip(0,0.15));//mode image format "1"
//		list=list.add((( m[i+2] + 1).reciprocal*5 ).clip(0,0.15));//mode image format "L"
//		});
//	list.size.postln;
//
//	list= list.reverse;
//
//	timestream = Pseq(list,list.size).asStream;
//
//	//decide pitch of x pixels
//	hexlist=(8*(0,1..width-1)).asHexString;
//
//	hexlist.size.do({arg k; poslist=poslist.add(hexlist.at(k).at(6).asString.rewriteString(rules) ++ hexlist.at(k).at(7).asString.rewriteString(rules) )});//canvert to hex list
//
//	stream=Pseq(poslist,inf).asStream;
//	//poslist.postln;
//
//
//		list.size.do({arg j;
//			//end of x line and return
//			if (j % (width+1) == 0, {
//				"\n beep".postln;
//
//					22.do({
//						q.putAll("+00fffff");
//						0.0125.wait;
//						q.putAll("+ffffff");
//						0.0125.wait;
//						});
//				},{
//
//				c=stream.next.asString;
//				time = timestream.next;
//
//				if(time >= 15,{
//				s.sendMsg("/n_set",5000,\gate,0,\note,74,\trig,0);
//				},{
//				s.sendMsg("/n_set",5000,\gate,1,\note,74,\trig,1);
//				});
//
//				output = "+" ++ "ff" ++ "ff" ++ c;
//				q.putAll( output );
//
//				//time makes alpher depth of pixels
//				time.wait;
//
//				}
//				);
//
//			time.postln;
//			//output.postln;
//
//		});
//		300.do({
//			q.putAll("+00fffff");
//			0.0025.wait;
//			q.putAll("+ffffff");
//			0.0025.wait;
//			});
//		q.putAll("+000000");
//		//"python /Users/moxuse/Desktop/imagingloger/untitled.py".unixCmd;
//
//
//		}
//)

p.remove;u.remove;l.remove;f.remove;

"python /Users/moxuse/Desktop/imagingloger/untitled.py".unixCmd;
SerialPort.closeAll;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//position at x acxis (AD out)
(
var hexlist,poslist,time,streem;

poslist=[];
time =0.25;

n=32;
hexlist=(8*(0,1..n-1)).asHexString;

hexlist.size.do({arg i; poslist=poslist.add(hexlist.at(i).at(6).asString ++ hexlist.at(i).at(7).asString)});//canvert to hex list

streem=Pseq(poslist).asStream;
poslist.postln;

//Task({
//	31.do({
//
//		c=streem.next;
//		time.wait;
//		if(c==nil,{"beep".postln});//return
//		c.postln;
//
//	})
//	}).play;
)


	hexlist=(8*(0,1..width-1)).asHexString;

	hexlist.size.do({arg i; poslist=poslist.add(hexlist.at(i).at(6).asString ++ hexlist.at(i).at(7).asString)});//canvert to hex list

255.reciprocal
0.reciprocal

asHexString(123)
"python /Users/moxuse/Desktop/imagingloger/untitled.py".unixCmd;


//logger setting RANGE:20/cm MEASE:X100mV
//logger sereal protocol "+ [00/ff/PWM] [ff/forwoad On] [ff~00/AD out]"

p=SerialPort.new("/dev//tty.usbserial-A30007a3",9600,8,true,nil,true,true);
p.putAll("+000000");


(
t=Task({
	10.do({
	100.do({
		p.putAll("+ffffff");
		0.025.wait;
		p.putAll("+00ffff");
		0.025.wait;
		});
		100.do({
		p.putAll("+ffff00");
		0.025.wait;
		p.putAll("+00ff00");
		0.025.wait;
		});
	});
}).play;
)

t.stop

SerialPort.closeAll;


/////////////////////////////////////////////
/////////////////////////////////////////////
/////////////////////////////////////////////

0.2.clip(0,0.25)

p.putAll("+43cf04");



var doc,array;
doc = Document.new("test");
array=[];
array=Array.fill2D(10, 10, {["-","0"].choose});

array.asString.postln;
Task({
	100.do({
		array=Array.fill2D(25, 25, {["-","*","o","\n"].choose});
		doc.string_(array.flat.asString);
		0.05.wait;
	});
	doc.close;
}).play(AppClock);

(
Task({
var array,result;
array = Array.fill(31,0).put(12,1);
result=[];
20.do({
31.do({arg item,i;
	if(and(array.at(i-1)==1,array.at(i)==1,array.at(i+1)==1),{result=result.add(0)},{
	if(and(array.at(i-1)==1,array.at(i)==1,array.at(i+1)==0),{result=result.add(1)},{
	if(and(array.at(i-1)==1,array.at(i)==0,array.at(i+1)==1),{result=result.add(0)},{
	if(and(array.at(i-1)==1,array.at(i)==0,array.at(i+1)==0),{result=result.add(1)},{
	if(and(array.at(i-1)==0,array.at(i)==1,array.at(i+1)==1),{result=result.add(1)},{
	if(and(array.at(i-1)==0,array.at(i)==1,array.at(i+1)==0),{result=result.add(0)},{
	if(and(array.at(i-1)==0,array.at(i)==0,array.at(i+1)==1),{result=result.add(1)},{
	if(and(array.at(i-1)==0,array.at(i)==0,array.at(i+1)==0),{result=result.add(0)})})})})})})})})
	});
	array = result.keep(32);
	array.join.postln;
	result = [];

	});

	}).play
	)

[[0,0],[1,0]].choose
(
Task({
var array,rules;
	array = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxa";
	rules = [[//rule "Chell"
	"a>a>a" -> "x",
	"a>a>x" -> "a",
	"a>x>a" -> "x",
	"a>x>x" -> "a",
	"x>a>a" -> "a",
	"x>a>x" -> "a",
	"x>x>a" -> "a",
	"x>x>x" -> "x",
	],[//rule 30
"a>a>a" -> "x",
"a>a>x" -> "x",
"a>x>a" -> "x",
"a>x>x" -> "a",
"x>a>a" -> "a",
"x>a>x" -> "a",
"x>x>a" -> "a",
"x>x>x" -> "x",
],[//rule 90
"a>a>a" -> "x",
"a>a>x" -> "a",
"a>x>a" -> "x",
"a>x>x" -> "a",
"x>a>a" -> "a",
"x>a>x" -> "x",
"x>x>a" -> "a",
"x>x>x" -> "x",
]].choose;
	62.do({
	array=array.rewriteString(rules).keep(32).postln ;

	});


}).play
)



0.0005.reciprocal

(
t=Routine({

	     80.do({arg i; var prisn,prisn2,st,st2;
		  prisn = Pwhite(0, 6, inf);
		  prisn2 = Pwhite(0, 9, inf);

		  st=prisn.asStream.next;
		  st2=prisn2.asStream.next;


	    10.do({
	    q.putAll("+" ++ "ff" ++ "ff"++st.asString++st2.asString);
	    0.0125.wait;
	    q.putAll("+" ++ "00" ++ "ff"++st.asString++st2.asString);
	    0.0125.wait;
	    });

	    });
	    q.putAll("+000000");

}).play;
)
q.putAll("+000000");
(
t=Routine({
	     80.do({arg i; var prisn,prisn2;
	    prisn = Pwhite(0, 9, inf);
	    prisn2 = Pwhite(0, 9, inf);

	    20.do({
	    q.putAll("+" ++ "ff" ++ "ff"++prisn.asStream.next.asString++prisn2.asStream.next.asString);
	    0.025.wait;
	    q.putAll("+" ++ "00" ++ "ff"++prisn.asStream.next.asString++prisn2.asStream.next.asString);
	    0.025.wait;
	    });
	    });

	    	300.do({
			q.putAll("+00ff3c");
			0.0025.wait;
			q.putAll("+ffff3c");
			0.0025.wait;
			});

}).play;
)
q.putAll("+000000");
