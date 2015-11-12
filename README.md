
# CS6250 project 5 Unit Test
The idea of this repository is to create a bash script that will unit test all requirements from gatech CS6250 project 5. 

A public github repository was created so every student can fork it, add his own tests and create a pull request. We have a class with more than 200 students, if half of us create one single extra test in end we will have +100 test and all students will benefit from this having a better grade in the end! 

-------------

##How to setup:

 1. Edit **test-client.py** to set socket timeout to 2 seconds. Otherwise this script can take forever to execute.
At line 21 add: 
`sock.settimeout(2.0)`

 2. Download **test_all.sh** to your ~/OMS6250-2015-Fall/assignment-5 directory

-------------

##How to run:

 1. In the mininet terminal. ping all hosts to avoid false positive tests:
`mininet> pingall`

 2. In the mininet terminal. Execute the test script using sh:
`mininet> sh ./test_all.sh`

 3. in another terminal. Check the file named **result** with test results 
 `tail -f result`

-------------
