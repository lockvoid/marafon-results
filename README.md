## Установка

Установите Ruby (версия 2.6.4), SQLite3 и Ruby on Rails, Node, Yarn, и [Windows Server 2003 Resource Kit Tools](https://www.microsoft.com/en-us/download/confirmation.aspx?id=17657)

OS X:

https://gorails.com/setup/osx/10.14-mojave

Ubuntu:

https://gorails.com/setup/ubuntu/19.04

## Запуск

1. Создайте файл `.env` и впишите следующие настройки:

CHRONOTRACK_CLIENT_ID=уникальный идентификатор API-ключа в системе ChronoTrack
CHRONOTRACK_USERNAME=имя пользователя в системе ChronoTrack
CHRONOTRACK_PASSWORD=пароль в системе ChronoTrack
CHRONOTRACK_EVENT_ID=идентификатор забега ChronoTrack
READER_CSV_PATH=абсолютный путь до CSV файла, в который записываются считывания меток

2. Создате базу данных `rake db:drop` `rake db:migrate`

3. Импортируйте данные по меткам атлетов коммандой `rake members:import`

4. Запустите сервер коммандой `rails s`

5. Откройту Chrome и введите адрес localhost:3000

6. Теперь его надо вывести на экран и сделать полноэкранный режим с помощью кнопки fn + F11. Вернуться в нормальный режим так же можно с помощью этой комбинации.

P.S. localhost:3000/admin - админка
