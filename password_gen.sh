#!/bin/bash
#
# Автор: Воронков Александр
#
# Задание:
# "Нужно сгенерировать 50 паролей и показать сколько сгенерировалось паролей с каким количеством цифр. Вывод вида:
# Количество паролей с 2 цифрами = 1
# Количество паролей c 3 цифрами = 10
# Написать скрипт или однострочник на bash"

# Длина пароля
LENGTH_PASS=20

# Символы для пароля
CHAR_PASS="_A-Z-a-z-0-9"

# Количество паролей
COUNT_PASS=50

generatPassword()
{
    echo $(< /dev/urandom tr -dc $CHAR_PASS | head -c$LENGTH_PASS)
}

# Генерируем пароли и считаем в них количество цифр
for (( i=1; i <= $COUNT_PASS; i++ ))
do
    password=$( generatPassword )
    digitalCount=$( echo $password | tr -dc [:digit:] | wc -c )
    arResult[$digitalCount]=$(( arResult[$digitalCount] + 1 ))
done

# Выводим результаты подсчета цифр в паролях
for indx in ${!arResult[*]}
do
  if [[ $indx = 1 ]]
    then
    strDigit="цифрой"
  else
    strDigit="цифрами"
  fi
    printf "Количество паролей с %s %s = %s\n" "$indx" "$strDigit" "${arResult[$indx]}"
done
