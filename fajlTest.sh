#!/bin/bash
cpu_type(){
	cat <<- __EOF__
	$(lscpu | grep "Model name" | awk '{print "Произвођач:"$3 "\nМодел:"$4}') 
__EOF__
	return
}
cpu_frequency(){
	cat <<- __EOF__
	$(lscpu | grep "CPU MHz" | awk '{print "Тренутни Clock: "$3}')
	__EOF__
	return
}
cpu_max_frequency(){
	cat  <<- __EOF__
	$(lscpu | grep "CPU max MHz" | awk '{print "Максимални Clock: "$4}')
	__EOF__
	return
}
cpu_min_frequency(){
	cat <<- __EOF__
	$(lscpu | grep "CPU min MHz" | awk '{print "Минимални Clock: "$4}')
	__EOF__
	return
}
if [[ $1 == "" ]]; then
	DELAY=2
	while true; do
	clear
	cat  <<- EOF
		Одабери једну од 3 опције:
		
			1. Информације о кориснику
			2. Информације о слободном простору на home партицији
			3. Информације о процесору
			0. Излаз из програма
		EOF	
	read  op1
	if [[  $op1 =~ ^[0-3] ]]; then
		if [ $op1 == 3 ];then
			clear 
			cat <<- EOF
			Опције за информације о CPU
		
			0. Тренутна CPU фреквенција
			1. Максимална CPU фреквенција
			2. Minimalna CPU фреквенција
			3. Модел CPU  
			EOF
			read op2 
			case $op2 in
				0)	cpu_frequency	;;
				1)	cpu_max_frequency	;;
				2)	cpu_min_frequency	;;
				3) 	cpu_type	;;
				*)	echo "Недозвољен унос" >&2
					exit 1	;;
			esac
			sleep $DELAY
			continue
		fi
		if [[ $op1 == 1 ]]; then 
			echo "Корисник је : $HOSTNAME"
			sleep $DELAY
			continue
		fi
		if [[ $op1 == 2 ]]; then
			df -h | grep home | awk '{print "Слободан простор на home:" $3}'
			sleep $DELAY
			continue
		fi
		if [[ $op1 == 0 ]]; then
			break
		fi
	else
		echo "Недозвољен унос" >&2
		sleep $DELAY
	fi
done
elif [[ $1 == "cpu" ]]; then
			clear 
			cat <<- EOF
			Опције за информације о CPU
		
			0. Тренутна CPU фреквенција
			1. Максимална CPU фреквенција
			2. Minimalna CPU фреквенција
			3. Модел CPU  
			EOF
			read op 
			case $op in
				0)	cpu_frequency	;;
				1)	cpu_max_frequency	;;
				2)	cpu_min_frequency	;;
				3) 	cpu_type	;;
				*)	echo "Недозвољен унос" >&2
					exit 1	;;
			esac
fi

