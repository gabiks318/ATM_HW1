#!/bin/bash

zip sub.zip *.asm

YOUR_ZIP=sub.zip
FEEDBACK_FILE=Feedback.txt

chmod +x run_test.sh
echo "Test Results:" > ${FEEDBACK_FILE}

NAME=$(basename -- "${YOUR_ZIP}")
NAME="${NAME%.*}"
mkdir ${NAME}
unzip -qq ${NAME} -d ${NAME}

if [ -d "${NAME}" ]; then
	cd $NAME
else
	echo "ERROR in ${YOUR_ZIP}"
	exit 1
fi

for i in $(seq 1 5); do
	curr_file="ex${i}.asm"
	if [ -f "${curr_file}" ]; then
		  echo "hi" > F
      echo "==== ${curr_file} tests ====" >> "../${FEEDBACK_FILE}"
		for j in $(seq 1 50); do
			curr_test=../Tests/test${i}_${j}
			if [ -f "${curr_test}" ]; then
				../run_test.sh "${curr_file}" "${curr_test}" >> "../${FEEDBACK_FILE}"
			#else
			#	echo "${curr_test} not found"
			#	curr_test_name=$(basename -- "${curr_test}")
			#	echo "${curr_file} could not be tested with ${curr_test_name}: FAIL" >> ../tomFeedback.txt
			fi;
		done
	else
		echo "${curr_file} not found"
		echo "${curr_file} could not be tested, therefore: FAIL" >> "../${FEEDBACK_FILE}"
	fi;
done

cd ..
sudo rm $NAME -rf
echo "END OF CHECK!"
echo "check your feedback file for report :)"
