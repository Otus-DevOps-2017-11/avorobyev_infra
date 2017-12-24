# avorobyev_infra

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
