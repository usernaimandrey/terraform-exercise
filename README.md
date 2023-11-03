## Инфраструктура в Yandex cloud на основе Terraform

 - 2 инстанса
 - балансировщик
 - сеть и три подсети в трех зонах доступности
 - зона dns и записи

[настройка cli утилиты yandex](https://cloud.yandex.ru/docs/cli/quickstart)

Сконфигурируйте Trraform:

```bash
make configure-terraform
```

Создайте токен для работы с Yandex:

```bash
make create-token
```

Разверните инфраструктуру:

```bash
make setup-cloud
```
