# Запрос ФИО
read -p "Введите ваше ФИО (на русском): " fullname

# Запрос фамилии на английском
read -p "Введите вашу фамилию (на английском): " lastname

# Запрос возраста
read -p "Введите ваш возраст: " age

# Запрос хобби
read -p "Введите ваши хобби: " hobbies

# Создание папки пользователя
mkdir -p "$lastname"

# Создание папок documents, videos, photos в папке пользователя
mkdir -p "$lastname/documents"
mkdir -p "$lastname/videos"
mkdir -p "$lastname/photos"

# Создание файлов в папках documents, videos, photos
for i in 1 2 3; do
  touch "$lastname/documents/file-$i.txt"
  touch "$lastname/videos/video-$i.mp4"
  touch "$lastname/photos/photo-$i.jpg"
done

# Создание папки archive
mkdir -p "$lastname/archive"

# Создание папок, соответствующих возрасту пользователя
for i in $(seq 1 $age); do
  mkdir -p "$lastname/archive/year-$i"
  mkdir -p "$lastname/archive/year-$i/documents"
  mkdir -p "$lastname/archive/year-$i/videos"
  mkdir -p "$lastname/archive/year-$i/photos"

  # Создание файлов в папках documents, videos, photos
  for j in 1 2 3; do
    touch "$lastname/archive/year-$i/documents/file-$j.txt"
    touch "$lastname/archive/year-$i/videos/video-$j.mp4"
    touch "$lastname/archive/year-$i/photos/photo-$j.jpg"
  done
done

echo "Папка '$lastname' успешно создана с необходимыми файлами и папками."

