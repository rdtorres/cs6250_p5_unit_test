#!/bin/bash
# script to unit test CS6250 project 5
# use at your own risk
# Author: Rafael Torres - rdtorres (at) gatech (doot) edu

E_HOSTS=(e1 e2 e3)
W_HOSTS=(w1 w2 w3)
HOSTS=(${E_HOSTS[@]} ${W_HOSTS[@]})

E_IPS=(10.0.0.1 10.0.0.2 10.0.0.3)
W_IPS=(10.0.0.4 10.0.0.5 10.0.0.6)
IPS=(${E_IPS[@]} ${W_IPS[@]})

PORTS_4=(2000 2001 2002 2003 2004)
PORTS_5=(3000 3001 3002)
PORTS=(1080 1081 ${PORTS_4[@]} ${PORTS_5[@]} )

M_PIDS=()


# erasing previous result
> result

echo "starting all servers" >> result
for ((i = 0 ; i < 6 ; i++)); do
	M_PID=$(ps ax | grep "mininet:${HOSTS[$i]}" | grep bash | grep -v mnexec | awk '{print $1};')
	M_PIDS+=($M_PID)
	for P in ${PORTS[@]}; do
		sudo mnexec -a $M_PID /bin/bash -c "python test-server.py ${IPS[$i]} $P" &
	done
done

#TEST_PIDS=()
for ((i = 0 ; i < 3 ; i++)); do
	for ((j = 3 ; j < 6 ; j++)); do
		MSG="Testing connectivity from ${HOSTS[$i]} to ${HOSTS[$j]}:1080" 
		sudo mnexec -a ${M_PIDS[$i]} /bin/bash -c "python test-client.py ${IPS[$j]} 1080 && echo $MSG: fail >> result || echo $MSG: passed >> result" 
		#TEST_PIDS+=($!)
	done
done
#wait ${TEST_PIDS[@]}

#TEST_PIDS=()
for ((i = 3 ; i < 6 ; i++)); do
	for ((j = 0 ; j < 3 ; j++)); do
		MSG="Testing connectivity from ${HOSTS[$i]} to ${HOSTS[$j]}:1080" 
		sudo mnexec -a ${M_PIDS[$i]} /bin/bash -c "python test-client.py ${IPS[$j]} 1080 && echo $MSG: fail >> result || echo $MSG: passed >> result" 
		#TEST_PIDS+=($!)
	done
done
#wait ${TEST_PIDS[@]}


#TEST_PIDS=()
for ((i = 0 ; i < 3 ; i++)); do
	for ((j = 0 ; j < 3 ; j++)); do
		MSG="Testing connectivity from ${HOSTS[$i]} to ${HOSTS[$j]}:1080" 
		sudo mnexec -a ${M_PIDS[$i]} /bin/bash -c "python test-client.py ${IPS[$j]} 1080 && echo $MSG: passed >> result || echo $MSG: fail >> result" 
		#TEST_PIDS+=($!)
	done
done
#wait ${TEST_PIDS[@]}

#TEST_PIDS=()
for ((i = 3 ; i < 6 ; i++)); do
	for ((j = 3 ; j < 6 ; j++)); do
		MSG="Testing connectivity from ${HOSTS[$i]} to ${HOSTS[$j]}:1080" 
		sudo mnexec -a ${M_PIDS[$i]} /bin/bash -c "python test-client.py ${IPS[$j]} 1080 && echo $MSG: passed >> result || echo $MSG: fail >> result"
		#TEST_PIDS+=($!)
	done
done
#wait ${TEST_PIDS[@]}

MSG="Testing connectivity from ${HOSTS[0]} to ${HOSTS[3]}:1081" 
sudo mnexec -a ${M_PIDS[0]} /bin/bash -c "python test-client.py ${IPS[3]} 1081 && echo $MSG: fail >> result || echo $MSG: passed >> result"

MSG="Testing connectivity from ${HOSTS[3]} to ${HOSTS[0]}:1081" 
sudo mnexec -a ${M_PIDS[3]} /bin/bash -c "python test-client.py ${IPS[0]} 1081 && echo $MSG: fail >> result || echo $MSG: passed >> result"

for P in ${PORTS_4[@]}; do 

	MSG="Testing connectivity from ${HOSTS[1]} to ${HOSTS[4]}:$P" 
	sudo mnexec -a ${M_PIDS[1]} /bin/bash -c "python test-client.py ${IPS[4]} $P && echo $MSG: fail >> result || echo $MSG: passed >> result"

	MSG="Testing connectivity from ${HOSTS[4]} to ${HOSTS[1]}:$P" 
	sudo mnexec -a ${M_PIDS[4]} /bin/bash -c "python test-client.py ${IPS[1]} $P && echo $MSG: fail >> result || echo $MSG: passed >> result"
done

for P in ${PORTS_5[@]}; do 

	MSG="Testing connectivity from ${HOSTS[2]} to ${HOSTS[5]}:$P" 
	sudo mnexec -a ${M_PIDS[2]} /bin/bash -c "python test-client.py ${IPS[5]} $P && echo $MSG: fail >> result || echo $MSG: passed >> result"

	MSG="Testing connectivity from ${HOSTS[5]} to ${HOSTS[2]}:$P" 
	sudo mnexec -a ${M_PIDS[5]} /bin/bash -c "python test-client.py ${IPS[2]} $P && echo $MSG: passed >> result || echo $MSG: fail >> result"
done

echo "terminating all servers. Check result file" >> result
for M in ${M_PIDS[@]}; do
	sudo mnexec -a $M /bin/bash -c 'ps -ef | grep test-server| cut -c10-15 | xargs kill -9' 
done

