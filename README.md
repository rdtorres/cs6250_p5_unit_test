
# CS6250 project 5 Unit Test
The idea of this repository is to create a bash script that will unit test all requirements from gatech CS6250 project 5. 

A public github repository was created so every student can fork it, add his own tests and create a pull request. We have a class with more than 200 students, if half of us create one single extra test, in end we will have 100+ tests! All students will benefit from this by having a better grade in the end! 



##How to setup:

 1. Edit **test-client.py** to set socket timeout to 2 seconds. Otherwise this script can take forever to execute.
At line 21 add: 
`sock.settimeout(2.0)`

 2. Download **test_all.sh** to your ~/OMS6250-2015-Fall/assignment-5 directory

 3. Add execution permission to it: `chmod +x ./test_all.sh`




##How to run:
 1. Make sure your firewall rules are running on its own terminal. `./run-firewall.sh my_config.cfg`

 2. In the mininet terminal. ping all hosts to avoid false positive tests:
`mininet> pingall`

 3. In the mininet terminal. Execute the test script using sh:
`mininet> sh ./test_all.sh`

 4. In a third terminal. Check the file named **result** with test results 
 `cat result` or `tail -f result`


##FAQ:

Q. I got this error message `./test_all.sh: 5: ./test_all.sh: Syntax error: newline unexpected`
A. Download the file again. It was probrably downloaded using Windows that converted all end of lines from \n to \r\n


