#! /bin/bash

test_input_dir="test_inputs/"
test_output_dir="generated_outputs/"
desired_output_dir="desired_outputs/"
isTestcaseError=0
isCompileErrors=0
isCompileWarnings=0

# use echo -e "${RED} text" .. for echoing colored output
RED='\033[0;31m' # produces red color when added in output
GREEN='\033[0;32m' # produces green
NOCOLOR='\033[0m' # removes color from output

# clean .out files and output
echo "remove compiled .out files ... "
rm *.out
echo "remove ${test_output_dir}* ... "
rm ${test_output_dir}*

# compile .c files and do check... 
for cfile in *.c
do

    program="${cfile%.c}.out" #cutoff suffix .c and add .out
    programname="${cfile%.c}" #cutoff suffix .c

    echo "compile $cfile to $program ... "
    # redirect stderr to file
    gcc -Wall "$cfile" -o "${cfile%.c}.out" 2> ${test_output_dir}${programname}_compile_result.txt

    #check if .out file is generated
    if [ ! -f $program ]
    then
      isCompileError=1
      echo -e "${RED}[ERROR]${NOCOLOR}Compiled file not found!"
      cat ${test_output_dir}${programname}_compile_result.txt # output compile stuff 
      continue #start with next .c file
    fi

    #check for compiler warnings
    compilerWarnings=$(grep "warning" ${test_output_dir}${programname}_compile_result.txt) #redirect grep to variable

    if [ ! -z "$compilerWarnings" ]
    then
      isCompileWarnings=1
      echo "compiler warnings ... check ${test_output_dir}${programname}_compile_result.txt"
    fi

    echo ""
    echo "testing $program ... "

    for inputfile in ${test_input_dir}input*.txt 
    do
       #echo "/**************************"
       printf "testing $inputfile " # printf because we do not want a newline

       outfile=${inputfile#$test_input_dir} #cutoff prefix
       outfile=${outfile%.txt} #cutoff suffix .txt

       desiredfile=${inputfile#$test_input_dir} #cutoff prefix test_input_dir
       desiredfile=${desiredfile#input} #cutoff prefix input

       #echo "hexdump -C $inputfile > ${test_output_dir}${programname}_${outfile}_hex.txt"
       hexdump -C $inputfile > ${test_output_dir}${programname}_${outfile}_hex.txt #generating hexdump input

       #echo "./"$program" < "$inputfile" > ${test_output_dir}${programname}_${outfile}_result.txt"
       ./"$program" < "$inputfile" > ${test_output_dir}${programname}_${outfile}_result.txt #start program with test-files

       #echo "hexdump -C ${test_output_dir}${programname}_${outfile}_result.txt > ${test_output_dir}${programname}_${outfile}_result_hex.txt"
       hexdump -C ${test_output_dir}${programname}_${outfile}_result.txt > ${test_output_dir}${programname}_${outfile}_result_hex.txt #generating hexdump generated

       #echo "hexdump -C ${desired_output_dir}desired_output${desiredfile} > ${test_output_dir}${programname}_${outfile}_desired_hex.txt"
       hexdump -C ${desired_output_dir}desired_output${desiredfile} > ${test_output_dir}${programname}_${outfile}_desired_hex.txt # generating hexdump desired

       #echo "diffresult=diff ${test_output_dir}${programname}_${outfile}_result.txt ${desired_output_dir}desired_output${desiredfile}"
       diffresult=$(diff -q ${test_output_dir}${programname}_${outfile}_result.txt ${desired_output_dir}desired_output${desiredfile}) #diff result to diffresult variable

       #only show desired vs output if there is an error ($diffresult should be empty if files are equal)
       if [ -z "$diffresult" ]
       then
         echo -e "[${GREEN}OK!${NOCOLOR}]"
       else
	 isTestcaseError=1
         echo -e "${RED}[ERROR]${NOCOLOR}"
         echo "comparing desired vs output hex"
         echo "............................"
         echo "diff ${test_output_dir}${programname}_${outfile}_result_hex.txt ${test_output_dir}${programname}_${outfile}_desired_hex.txt"
         diff ${test_output_dir}${programname}_${outfile}_result_hex.txt ${test_output_dir}${programname}_${outfile}_desired_hex.txt
         echo "............................"
       fi
    done
done

echo ""

if [ $isCompileErrors = 1 ]
then
  echo -e "${RED}ERROR compiling some programs!${NOCOLOR}"
else
  echo -e "${GREEN}Compiles ok!${NOCOLOR}"
fi

if [ $isCompileWarnings = 1 ]
then
  echo -e "${RED}Some compiler warnings!${NOCOLOR}"
else
  echo -e "${GREEN}No Warnings!${NOCOLOR}"
fi

if [ $isTestcaseError = 1 ]
then
  echo -e "${RED}ERROR in testcase(s)!${NOCOLOR}"
else
  echo -e "${GREEN}All testcases good!${NOCOLOR}"
fi

# check if python and the atoy tools are existing
if command -v python &>/dev/nul
then
    toyEofCharacter=$(printf "\x$(printf %x 03)")
fi


