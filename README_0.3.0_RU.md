# WhiteList Transport Test 0.3.0 — iPhone Optimized

## Что исправлено

- компактный экран без гигантской круглой кнопки;
- нижняя панель больше не перекрывает основные действия;
- уменьшены шрифты и карточки;
- маршрут сворачивается;
- импорт конфигурации открывается в удобном sheet;
- отдельная кнопка «Вставить» из буфера;
- крупная доступная кнопка «Импортировать»;
- кнопки Check/Ping остаются нажимаемыми и показывают конкретную причину;
- проверка доступности Jitsi URL;
- таймаут ожидания peer увеличен;
- ошибки `wait for peer`, `start timed out`, `deadline exceeded` переводятся в понятное сообщение;
- YAML parser читает provider, transport, room, key, DNS и SOCKS5 port.

## Почему сейчас был timeout

Сообщение:

```text
wait for peer
olcRTC start timed out
context deadline exceeded
```

означает, что клиентская сторона запустилась, но серверный olcRTC peer
не появился в той же Jitsi комнате за отведённое время.

Проверь VPS:

```bash
systemctl status whitelistvpn-olcrtc --no-pager
journalctl -u whitelistvpn-olcrtc -n 100 --no-pager
cat /opt/whitelistvpn/server.yaml
```

У сервера и клиента должны полностью совпадать:

```text
auth.provider
net.transport
room.id
crypto.key
```

## Обновление GitHub

Замени в репозитории файлы:

```text
App/AppModel.swift
App/ContentView.swift
App/Profile.swift
Shared/OLCBridge.m
project.yml
.github/workflows/build-transport-test-ipa.yml
```

После commit:

```text
Actions
→ Build olcRTC Transport Test IPA
→ Run workflow
```

Артефакт:

```text
WhiteListTransportTest-0.3.0-unsigned-ipa
```
