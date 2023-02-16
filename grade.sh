CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

# 1. Clone the repository of the student submission to a well-known directory
# name (provided in starter code)
rm -rf student-submission
echo "Cloning $1....."
# git clone $1 student-submission 2> /dev/null
GIT_ERROR=`git clone --quiet $1 student-submission 2>&1`
if [[ $? -eq 0 ]]
then
    echo "Finished cloning"
else
    echo "Cloning failed --------ERROR!---------"
    echo $GIT_ERROR
    echo "--------------------------------------"
    rm -rf student-submission
    exit 1
fi

# 2. Check that the student code has the correct file submitted. If they didn't,
# detect and give helpful feedback about it.
cd student-submission
if [[ -f "ListExamples.java" ]]
then
    echo "ListExamples found"
else
    echo "File ListExamples.java not found"
    rm -rf student-submission
    exit 1
fi

# 3. Somehow get the student code and your test .java file into the same
# directory
cp ../TestListExamples.java .

# 4. Compile your tests and the student's code from the appropriate directory
# with the appropriate classpath commands. If the compilation fails, detect
# and give helpful feedback about it.
echo "---------------------Compiling Tests---------------------"
javac -cp $CPATH *.java

if [[ $? -eq 0 ]]
then
    echo "Compile success"
else
    echo "Compile failed"
    exit 1
fi

# 5. Run the tests and report the grade based on the JUnit output.

echo ""
echo "----------------------Running Tests----------------------"
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

cd ..
rm -rf ./student-submission
