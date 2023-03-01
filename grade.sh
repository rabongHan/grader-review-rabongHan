CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

if [[! -e ListExamples.java]]; then
    echo "Error: the file submitted is incorrect"
    exit 1
fi

cp student-submission/*.java .

javac -cp $CPATH *.java
if [ $? -ne 0 ]; then
    echo "Error: Compilation failed"
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt
if grep -q "FAILURES!!!" test-output.txt; then
    echo "Test Failed"
else
    echo "Test Succeed"
fi
