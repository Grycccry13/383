# Скрипт для вывода содержимого всех файлов в папке
function show_files() {
  echo "Содержимое файлов в папке:"
  find . -type f -exec cat {} \;
}

# Скрипт для создания папок и файлов
function create_structure() {
  mkdir -p lab-03/teachers
  mkdir -p lab-03/students/current
  mkdir -p lab-03/students/dismissed
  mkdir -p lab-03/subjects
  mkdir -p lab-03/schedule

  for letter in a b c; do
    touch lab-03/teachers/letter-${letter}.json
    touch lab-03/students/current/letter-${letter}.json
    touch lab-03/students/dismissed/letter-${letter}.json
    touch lab-03/subjects/letter-${letter}.json
  done

  touch lab-03/schedule/date-18.01.2024.json
  touch lab-03/schedule/date-19.01.2024.json
  touch lab-03/schedule/date-20.01.2024.json
}

# Скрипт для копирования файлов или папок
function copy_files() {
  if [ $# -ne 2 ]; then
    echo "Неверный синтаксис. Используйте: copy_files <источник> <назначение>"
    return 1
  fi
  source="$1"
  destination="$2"
  cp -r "$source" "$destination"
  echo "Копирование из '$source' в '$destination' завершено."
}

# Скрипт для перемещения файлов или папок
function move_files() {
  if [ $# -ne 2 ]; then
    echo "Неверный синтаксис. Используйте: move_files <источник> <назначение>"
    return 1
  fi
  source="$1"
  destination="$2"
  mv "$source" "$destination"
  echo "Перемещение из '$source' в '$destination' завершено."
}

# Скрипт для копирования файлов или папок с параметрами
function copy_files_with_options() {
  if [ $# -lt 3 ]; then
    echo "Неверный синтаксис. Используйте: copy_files_with_options <источник> <назначение> <опции>"
    return 1
  fi
  source="$1"
  destination="$2"
  options="$3"
  cp $options "$source" "$destination"
  echo "Копирование из '$source' в '$destination' с опциями '$options' завершено."
}

# Скрипт для перемещения файлов или папок с параметрами
function move_files_with_options() {
  if [ $# -lt 3 ]; then
    echo "Неверный синтаксис. Используйте: move_files_with_options <источник> <назначение> <опции>"
    return 1
  fi
  source="$1"
  destination="$2"
  options="$3"
  mv $options "$source" "$destination"
  echo "Перемещение из '$source' в '$destination' с опциями '$options' завершено."
}

# Вызов функций
show_files 
create_structure
copy_files lab-03/teachers lab-03/backup 
move_files lab-03/schedule/date-18.01.2024.json lab-03/schedule/backup 
copy_files_with_options lab-03/subjects lab-03/backup -v 
move_files_with_options lab-03/students/current lab-03/students/archived -i 
