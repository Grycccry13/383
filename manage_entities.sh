#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Недостаточно аргументов. Использование: $0 <действие> <имя_сущности> [новое_имя]"
  exit 1
fi

ACTION="$1"
ENTITY_NAME="$2"
NEW_ENTITY_NAME="${3:-}" 


USERS_DIR="users"
STUDENTS_DIR="students"
TEACHERS_DIR="teachers"


find_entity_path() {
  local entity_name="$1"
  if [[ -f "$USERS_DIR/$entity_name" ]]; then
    echo "$USERS_DIR/$entity_name"
  elif [[ -f "$STUDENTS_DIR/$entity_name" ]]; then
    echo "$STUDENTS_DIR/$entity_name"
  elif [[ -f "$TEACHERS_DIR/$entity_name" ]]; then
    echo "$TEACHERS_DIR/$entity_name"
  else
    echo "Сущность '$entity_name' не найдена."
    return 1
  fi
}


case "$ACTION" in
  create)
    if [ -z "$NEW_ENTITY_NAME" ]; then
      echo "Укажите имя для создания"
      exit 1
    fi

    touch "$STUDENTS_DIR/$NEW_ENTITY_NAME" 
    send_telegram_notification "Создана сущность: $NEW_ENTITY_NAME"
    ;;
  rename)
    if [ -z "$NEW_ENTITY_NAME" ]; then
      echo "Укажите новое имя."
      exit 1
    fi
    ENTITY_PATH=$(find_entity_path "$ENTITY_NAME")
    if [[ $? -eq 0 ]]; then
      mv "$ENTITY_PATH" "$ENTITY_PATH/.bak"
      mv "$ENTITY_PATH/.bak" "${ENTITY_PATH/$ENTITY_NAME/$NEW_ENTITY_NAME}"
      send_telegram_notification "Сущность '$ENTITY_NAME' переименована в '$NEW_ENTITY_NAME'"
    fi
    ;;
  delete)
    ENTITY_PATH=$(find_entity_path "$ENTITY_NAME")
    if [[ $? -eq 0 ]]; then
      rm "$ENTITY_PATH"
      send_telegram_notification "Сущность '$ENTITY_NAME' удалена."
    fi
    ;;
  *)
    echo "Неизвестное действие: $ACTION"
    exit 1
    ;;
esac

exit 0
