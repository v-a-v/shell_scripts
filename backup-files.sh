#!/bin/bash
#
#
#

log_file=/var/log/backup-data.log

## Куда бэкапим
dir_to_backup=/data/archives/

## Что бэкапим. rsync запихиваем сюда то что нужно бэкапить
backup_dirs=/data/backups/

## Формируем название файла
daily=`date "+%Y-%m-%d"`
daily_file_name=$daily-DOMAIN-data-backups

## За сколько дней оставлять архив бэкапа
outdated=`date --date='1 days ago' "+%Y-%m-%d"`
outdated_file_name=$outdated-DOMAIN-data-backups

unset array_dir
## Добавляем в массив папки, которые нужно забэкапить
array_dir=( $(ls $backup_dirs) )

echo "`date` - Стартуем бэкапирование скриптом $0" >> $log_file

## Обнуляем переменную
unset dir_name

## Обход массива с папками. ЦИКЛ
for dir_name in "${array_dir[@]}"; do

## Создаем бэкап
echo "`date` - Создаем бэкап для $dir_name" >> $log_file
/bin/tar cjpf $dir_to_backup/$daily_file_name-$dir_name.tar.bz2 $backup_dirs/$dir_name
echo "`date` - Бэкап для $dir_name создан" >> $log_file

if [ -s "$dir_to_backup/$daily_file_name-$dir_name.tar.bz2" ]
then
    echo "`date` - Передаем архив $dir_name на FTP" >> $log_file
    curl --upload-file $dir_to_backup/$daily_file_name-$dir_name.tar.bz2 ftp://LOGIN:PASSWORD@USER.your-backup.de/backup_files/ >> $log_file
    echo "`date` - Передача архива $dir_name на FTP завершена." >> $log_file

    if [ -s "$dir_to_backup/$outdated_file_name-$dir_name.tar.bz2" ]
    then
        echo "`date` - Удаляем старый бэкап $outdated_file_name-$dir_name.tar.bz2" >> $log_file
        rm -f $dir_to_backup/$outdated_file_name-$dir_name.tar.bz2
    fi
fi
##

done
## Конец ЦИКЛА
echo "`date` - Бэкапирование скриптом $0 завершилось" >> $log_file
