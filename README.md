# avorobyev_infra

# Задание 5

## решения задачи со слайда 36
1. на сервере запускаем терминал, в нем ssh сессию до сервера назначения. используем agent forwarding, чтобы вторая сессия авторизовалась по ключу  
`ssh -t -A appuser@35.195.53.45 ssh 10.132.0.3`

2. Туннель. Трафик через локальный порт 3022 передается на ssh сервер узла в интрасети  
```
ssh -L 3022:10.132.0.3:22 appuser@35.195.53.45 #открываем туннель
ssh -p 3022 appuser@localhost #во втором терминале пользуемся им
```
3. JumpHost в ssh, начиная с версии 7.3. Для 7.2 ProxyCommand  
```
ssh -o ProxyCommand="ssh -l appuser -W %h:%p 35.195.53.45" appuser@10.132.0.3 #one liner

#или для подключения в одну строку: ssh gcp-internal-one

cat <<EOF >> ~/.ssh/config
Host gcp-internal-one
  Hostname 10.132.0.3
	User appuser
  ProxyCommand ssh -l appuser 35.195.53.45 -W %h:%p
EOF
```

## Конфигурация сети
Хост bastion, IP: 35.195.53.45, внутр. IP: 10.132.0.2  
Хост: internal-one, внутр. IP: 10.132.0.3


# Задание 6

PS. для возможности переиспользования кода в доп. задании разбил его по функциям и разместил в файле libfunc.sh.

## Решение дополнительных заданий

```
#удаляем правило файервола
gcloud compute firewall-rules delete default-puma-server

#удаляем инстанс
gcloud compute instances delete reddit-app

#создаем стартовый скрипт для установки reddit-app вместе с зависимостями, пользуясь функциями из "библиотеки"
cat <<! > startup_script.sh
#!/bin/bash

$(cat libfunc.sh)

ruby_tasks && mongo_tasks && app_tasks
!

#создаем инстанс. На отработку скрипта уходит около 4х минут, можно проверять /var/log/syslog
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=f1-micro \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup_script.sh

#создаем правило доступа к серверу
gcloud compute firewall-rules create default-puma-server \
  --allow tcp:9292 \
  --source-tags=puma-server \
  --source-ranges=0.0.0.0/0 \
  --description="access to puma server"

```

# Задание 7

Продолжил развивать идею библиотеки функций. IMHO удобней так, чем с кучей sh файлов. Это позволило поэкспериментировать с inline скриптами, через которые эти функции вызываются.

## Работа с секцией переменных шаблона

Добавлены переменные:

* gcp_project_id
* gcp_src_image_family
* machine_type
* workdir

## Расширение параметров GCP builder

Добавлены парамеры:

* image_description
* disk_size
* disk_type
* network
* tags

## Дополнительные задачи

### Полный образ

В секцию provisioners базового шаблона добалена сборка приложения (не под root!) и регистация в системе управления сервисами ОС. Реализация последнего подсмотрена у коллег ;)

Добавил шаблон immutable_oneprov.json, в котором все вызовы размещены в одном provisioner.

### Развертывание vm
packer/scripts/creare_reddit-vm.sh:
```bash
#!/bin/bash

gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family reddit-full \
  --image-project=mindful-atlas-188816 \
  --machine-type=f1-micro \
  --tags puma-server \
  --restart-on-failure
```

# Задание 8

Ключи добавил через переменную типа map

## Дополнительные задачи

### 1. Ключи проекта

Управляются через ресурс google_compute_project_metadata_item. Имя элемента ssh-keys.

Ключ, добавленный вручную, удалился, так как Terraform не следит за ресурсами, не определенными в конфиге. Что логично )  

Также заметил, что gcp реагирует на перенос строки, создавая пустое поле на вэб странице. Частично выкосил c помощью trimspace.

### 2. Балансировщик
в другой раз (
