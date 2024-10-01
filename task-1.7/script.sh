# Папка для базы данных
DB_DIR="database"

# Проверка наличия папки базы данных
if [ ! -d "$DB_DIR" ]; then
  mkdir -p "$DB_DIR"
  mkdir -p "$DB_DIR/Преподаватели" "$DB_DIR/Студенты" "$DB_DIR/Оценки"
  echo "База данных создана"
else
  echo "База данных уже существует"
fi

# Функция для добавления данных
add_data() {
  local category="$1"
  local name="$2"
  local data="$3"

  mkdir -p "$DB_DIR/$category/$name"
  echo "$data" > "$DB_DIR/$category/$name/info.txt"
  echo "Данные добавлены в категорию '$category'"
}

# Функция для удаления данных
remove_data() {
  local category="$1"
  local name="$2"

  rm -rf "$DB_DIR/$category/$name"
  echo "Данные удалены из категории '$category'"
}

# Функция для перемещения данных
move_data() {
  local source_category="$1"
  local source_name="$2"
  local target_category="$3"

  mv "$DB_DIR/$source_category/$source_name" "$DB_DIR/$target_category"
  echo "Данные перемещены из категории '$source_category' в категорию '$target_category'"
}

# Меню
while true; do
  echo ""
  echo "Меню:"
  echo "1. Добавить данные"
  echo "2. Удалить данные"
  echo "3. Переместить данные"
  echo "4. Выход"

  read -p "Выберите действие: " choice

  case $choice in
    1)
      read -p "Введите категорию (Преподаватели, Студенты, Оценки): " category
      read -p "Введите имя: " name
      read -p "Введите данные: " data
      add_data "$category" "$name" "$data"
      ;;
    2)
      read -p "Введите категорию (Преподаватели, Студенты, Оценки): " category
      read -p "Введите имя: " name
      remove_data "$category" "$name"
      ;;
    3)
      read -p "Введите исходную категорию: " source_category
      read -p "Введите исходное имя: " source_name
      read -p "Введите целевую категорию: " target_category
      move_data "$source_category" "$source_name" "$target_category"
      ;;
    4)
      echo "Выход"
      exit 0
      ;;
    *)
      echo "Некорректный выбор"
      ;;
  esac
done
