# Ian Dimayuga (icd3)

all:

ep2: ep2.tr ep2_test

ep2_test: ep2_exp_on_off ep2_packet_size ep2_delack ep2_endtime

ep2.tr:
	ns ep2/ep2.tcl | tee ep2/ep2.out

ep2_exp_on_off:
	grep '^r' ep2/ep2.tr | grep ' exp ' | python ep2/exp_on_off.py

ep2_packet_size:
	grep '^r' ep2/ep2.tr | grep -v ' ack ' | python ep2/packet_size.py

ep2_delack:
	egrep '(^r|^\+)' ep2/ep2.tr | python ep2/delack.py | sort | uniq -c

ep2_endtime:
	grep '^r' ep2/ep2.tr | grep ' tcp ' | python ep2/endtime.py